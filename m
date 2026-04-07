Return-Path: <netdev+bounces-275854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPUlBrFy1GmSuAcAu9opvQ
	(envelope-from <netdev+bounces-275854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:57:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E553A9462
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC3433019809
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229B3372B26;
	Tue,  7 Apr 2026 02:57:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0D372EDB
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775530656; cv=none; b=t9p9wjvg5vUd1rao9gQLJeJJFPuhxQXcRVc9xIbmN7+shgooptaWLZlMxJSq3Fn3qStUsp25t8XRPDg1UeSEi0lMAcuxr9Zn0Pe/6kQ/vbeTHX4LwyygWxkaM75XizOQXwAg2RhPj5rMC8Xx69LlemwI6xG/qQwq5rBrTxzSZ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775530656; c=relaxed/simple;
	bh=/bul4IAq3YCdfoNvSpOxlUun1WBFrt2nrvHzPkI51X0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3YJ2V7/7iY2kr3HOUFQPiWriEv7rcvEKDSJgn9kJsX3L36EF4Aauj2U1+KAZL24bCJKL/O0HqkFyBhgOG7a9KJkmTqi3FAeh6k4RZ80+MaYYlnM2zzLcIcYLVssUZMDfejBPYoNYXvUGH6ejsM9M4unGhSPyZIXvQmR0SHmBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1775530611te3fef9ec
X-QQ-Originating-IP: R7zqD0q2kboqaClt+rLho0YuMMTBofSnj1mvc76YiwU=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Apr 2026 10:56:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15061125918897745960
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v7 6/9] net: wangxun: reorder timer and work sync cancellations
Date: Tue,  7 Apr 2026 10:56:13 +0800
Message-Id: <20260407025616.33652-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260407025616.33652-1-jiawenwu@trustnetic.com>
References: <20260407025616.33652-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M0rKEBkdLtKD8kosx2NPln47XUE8w/hmPoR5TCh1YkJzuJvR57I1gBlg
	0HNwv9Ro7dZFvFZjb9ibK49EQwRjSsLh9fMrSpBR+BD+cW5fhL15uSzZy95KlDu/23RYTXM
	886B+H4L7Q7jcH6Rxq6L9yaTTJx1WxfjoSSyt76aRQ6TlIUlmNJ4GHZfI5MLW59wHFWTuXK
	aUm7jdLohntetRlMg0AzBhB+HpNpscBFN43hm9NW/Hl4Giq/mEr86AnNpDcdUQfq5Xug2gZ
	0j0+heFQV/6AYByuvthD9fvN80roIGoGzSMDxhLSD41oiPXWRHAPlLMJ8BIiOLyXnT+d8Ry
	zC+JCMAEqaG5lz7RJSOKZGz7cRv3UGz9/lDlBbeVpQddDamb0U8MQggWsUFvZe23L5vP/y6
	aaf0gMsuF+9/iuzHWzPG2+UZ1qH/NiEqzHRMK+r+Nb8Tqnq9rpWXJTY3gEpj2vRqPbGPEgq
	01627Zq5rSURJr/CaOR8YkS31MnLTBEY6l+IuU4g4ACAYqqPwNnqFUfeJdWfkLyP7eVO5Ry
	cb34bLQp6emf8foNEErPkDTWrQjOt8Rb4l+BBI0A7RaO0Lxew0zBNKFedj9GrI3at5R28ca
	ABEuD2ydxWh5tevGLCAEgHqOMN6ZdxbUcFSjImcksedEwPf24Pu8uo8AKvpPwJMzSxxi4iK
	akqSJmFyuftlY544QRRFh8i0PYB7E0OMyJ7D1mGOYrWJ3lbf+jvCZQ3mhQ5XN5lT6jnqcRK
	2KNgrDhdRf4tMMU3MByqAy+kMSsnAHJicmuxI86R9BOfQtsEfA540svlbPdU3xtnLFSN526
	8CEq0n3klYt/ONzKE265QjDK7I7HWHRbsPh7hfmwdjY3xW1ApQiiv7f9J1/SlshAOqPS/K0
	x8vCCUU0mhGBgwPRtxS03Y3TIQMaGSp5wXsQwmTA7+3W0X4ukRSqohO8CMjld+gCyQF8bi4
	KDejexCJfzRQ4ulXSfThzCRFGx9K6B4rlHtjCnWSipu8r4M+D/I4ZMOr/uznKcwVEGlhRvt
	Q5ppwO8FZ6Lg8i8LZsAyO478BQ0KN70Jt8aq1gBhrJmCUINTMzTxhTDUJCZdeJ25r6BCYES
	wxYaKeMZbg3MttbxePR6bAQofpDnUa4WeMrRdYkE/oC
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275854-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,gmail.com,debian.org,trustnetic.com];
	NEURAL_SPAM(0.00)[0.424];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,trustnetic.com:email,trustnetic.com:mid]
X-Rspamd-Queue-Id: 88E553A9462
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When removing the device, timer_delete_sync(&wx->service_timer) is
called in .ndo_stop() after cancel_work_sync(&wx->service_task). This
may cause new work to be queued after device down.

Move unregister_netdev() before cancel_work_sync(), and use
timer_shutdown_sync() to prevent the timer from being re-armed.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c | 3 ++-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c   | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 75a6f0898afe..29cdbed2e5ec 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -48,9 +48,10 @@ void wxvf_remove(struct pci_dev *pdev)
 	struct wx *wx = pci_get_drvdata(pdev);
 	struct net_device *netdev;
 
-	cancel_work_sync(&wx->service_task);
 	netdev = wx->netdev;
 	unregister_netdev(netdev);
+	timer_shutdown_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
 	kfree(wx->vfinfo);
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 00726605628b..0dd128aa18da 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -946,12 +946,13 @@ static void txgbe_remove(struct pci_dev *pdev)
 	struct txgbe *txgbe = wx->priv;
 	struct net_device *netdev;
 
-	cancel_work_sync(&wx->service_task);
-
 	netdev = wx->netdev;
 	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
 
+	timer_shutdown_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
+
 	txgbe_remove_phy(txgbe);
 	wx_free_isb_resources(wx);
 
-- 
2.48.1


