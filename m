Return-Path: <netdev+bounces-264696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNKUMqF1qmnRRwEAu9opvQ
	(envelope-from <netdev+bounces-264696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:35:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D962B21C1D5
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 611A4301D573
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 06:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CA537187F;
	Fri,  6 Mar 2026 06:34:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69227188735
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778859; cv=none; b=sGw0vbt8Me/pmMYwIRJqEUch6H4geT0iepXbaJUVV781/FW48XNnk3UnnESrM4cjcU6le0HGg27cj9BnRSlTHCpxzuNJdp8+R8hjovxgqIDhaCW5UTn4NFdNJLUfQHKJHI7AL9pJMMxxKSM6452pN5bPtvaBfiEgnSsxnNMVeew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778859; c=relaxed/simple;
	bh=DS37ZtIrZGfCBkLXCBoFV4Vy2v8jIKZx0O9zqzQ8JUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFgFixpFXa4KhFVOfNYesW9Di57zOvQEWQtc+oN3m54/3c6Abft/hiz43SEHo7EU3rZgurC4bzv4KPMn+AWwA3iAfZiBtExG0YyGOI5uJTZNaiEGKMh6y/IxEMz06ynOM/dFU8JYiU3ADBZBTlI29MIzUPRBnIxCEwZaNOWUx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1772778788taf979a68
X-QQ-Originating-IP: 15BRuAwEsWcJl9k4/aAzBcZs8EXoQ/hq7+Je3dLT+GU=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.243.152])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Mar 2026 14:33:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12591326020015615702
EX-QQ-RecipientCnt: 18
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 08/10] net: wangxun: delete service_timer before cancel service_work
Date: Fri,  6 Mar 2026 14:32:09 +0800
Message-Id: <20260306063211.20536-9-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260306063211.20536-1-jiawenwu@trustnetic.com>
References: <20260306063211.20536-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N9zhM9rQuf4dpzR3FK8MhSGdL5XMB81hR0d68Fu+0bouyEf0VqnPCF4L
	c2oUvjRmbdP6vQgb/RDZHbdmGyaUptp1Zi9+UGAIeUMDEbbAJrKXfTD1vlE6VrjyAvbW/EC
	HLWbgVfv4iOKAbt2/c6WKw+nZVwkpdl6qaGSZ/ykYPnupgYC9oziVUuFFHbDBa/HTN4S2lQ
	IOK0mvlTAh4vjzdHM6AIARG0GWWANPKVSUjyJ+ifa809hWkuC7KPAYmr2ufhRLFturHJYyV
	W4Y87zZGBXBtsYrFhIU4Phu6Bzj4UmyFVJQ8h7QE4y8TzMElsN/YZTjZBBl8NMy9Wi6TZ+/
	GhGZ1ZTrn+jjjNV0231Q3HwdtKUo5nfNMPcf0f5JpBNi0ZDrLq8yvbGx8AM+i567x2bSxZ0
	Nu7eBCpVgP2SspUFSGnT8YT9Zyw57l+yfZZi4XIeR3n/Gcf6dAbtmybZm8+gbXV7hrxrkCw
	BT8OagfzF6VGV0rcPZFPmBHY/aQtJe6nP3dG++KJWZhkazNZn1OlW/eCy0wXiuvUddz9bfu
	XqmKI+wJKEyhC15jiJiZ88XcJJQK92vw3ieeTAhWfw6PEFsydzbq72I8dUEUymS4ZBMgSFo
	yoG467nS97fJb/HXRN4rSJGbMBoVNbLMZSgLpU/Yw5U5qGbvhUDn8XVC/yC5D5H69ZpC5to
	ilbGRVrjHN+4O+f7UgurctyIqffl3wwlXUV7MpYuxflHR9b5miR47Ufl/s4KlB7AusK4Kcx
	6Ib4BHxFodPDtplKGqaryzSNScbj9AK/45fAIxyWYPGCkADEMyZ9GU0v9CvkwRe5eRLd7up
	KF8nQs1rutNoymO8711BGvRuEJvD3eatfG5eRCUUDOcvnokiWndAdaFvFpdOHJ72lugE04J
	5SAcLnG9qaViu7Z7kMUJU+OqQJ9zlAtZX/ZxI4BUlNaKgViDpdqaGl47Z7aXsTUF3WYO4Yf
	PslwkxIB3LNHVj6rAqaqBdDW9KZBJZNUBIU6P9fzC7wKnuJ396vW1JmtgQmlJDAdZnj2L1N
	dFzIXsyKKlOYf8YfO+FErrY95udQEG4vepq/I1Ai1fS/oeQz5GaumQ89kwoJoOurcYmsegW
	CfwPuTAtHFrDV5pb35NBAig41OOMGCtw2y3P6wFqmp1
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: D962B21C1D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264696-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,trustnetic.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

When removing the device, timer_delete_sync(&wx->service_timer) is
called in .ndo_stop() after cancel_work_sync(&wx->service_task). This
may cause new work to be queued after device down. So we should delete
service_timer first.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c | 1 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index ade2bfe563aa..5565062c7471 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -48,6 +48,7 @@ void wxvf_remove(struct pci_dev *pdev)
 	struct wx *wx = pci_get_drvdata(pdev);
 	struct net_device *netdev;
 
+	timer_delete_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
 	netdev = wx->netdev;
 	unregister_netdev(netdev);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index ddc7cea9d7c2..01ceaf270b70 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -936,6 +936,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	struct txgbe *txgbe = wx->priv;
 	struct net_device *netdev;
 
+	timer_delete_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
 
 	netdev = wx->netdev;
-- 
2.48.1


