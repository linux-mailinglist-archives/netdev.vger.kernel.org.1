Return-Path: <netdev+bounces-271804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JCGEy2XxGnn1AQAu9opvQ
	(envelope-from <netdev+bounces-271804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:17:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE26C32E4A4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCE0E3013A76
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4AE2DAFA9;
	Thu, 26 Mar 2026 02:16:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83903081D6
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491391; cv=none; b=q1d9f+IG3VXHY5/lTfiZdZqCj2Na6HV2Gu2JPybbEA5MTUwSZ47SsDfTgw63w38K/p2+EDwVJg15fZKbq5c0A31t2e/8tACNEXdmdqBaGOnNLOTlc2v5RCUarHNJVEHM7QOn/Wo1IkUORC+rXqXNqdH6wvlO5FO/M1ym/xI51eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491391; c=relaxed/simple;
	bh=DS37ZtIrZGfCBkLXCBoFV4Vy2v8jIKZx0O9zqzQ8JUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzkwJ2EjFTpxI8GvBRfvGru750KhTx+m3N38++/ZqCYQQ6pM5WFn0MlDr8Dtb9v7uow00Jrh/xJjbDBO3LQav5W1iV8H6v6oZ3GXgm2+orJM9RmlG+ZdZcX2/8fKpcMsBR2OILfmT3piIaIZerxnEH61yCB4SCOUORIYAuXW0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz11t1774491336t7abed8cf
X-QQ-Originating-IP: n50lOM/Ka3MnRifJ+Y4ph1hjFJysqDZ+XHgRdt6kwzc=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.44])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Mar 2026 10:15:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8423968161112651738
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 08/11] net: wangxun: delete service_timer before cancel service_work
Date: Thu, 26 Mar 2026 10:14:03 +0800
Message-Id: <20260326021406.30444-9-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260326021406.30444-1-jiawenwu@trustnetic.com>
References: <20260326021406.30444-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MmGZZGFxOFhUbktYe7S1faFaS0atwhwhf6Wt4+sfnAMyyMj5t1mIDmBb
	WuL3M1fHpOTyurPnvcAU6/C90UKauIwM10Cd0QzeOoHqTXOXHhcWKuXXGDGkBwVCg05ACSN
	YPZkBRcwN9B3hJHsSmgzkYJR2p1irCik/R3LkePmhnMs3/qgRam1ool3osdNHnKSonCJF2a
	tritjaw+V3bC6ZJ0uD/PWsinKewCmvzUpVT4tjHJ+MlwZe5KipRVOlLohsGxMR504sY54o1
	aBrGQJN9RsMmW6B4BIyEdaCqH73TbL3Pfhj81T9q1+Eke3zDx/ZDeSZcdeGdkfGigjoDsKJ
	k1HjyAF0+NNQQHCNZgPFNgHrau0/co35YsKFwHq+wRI1kUkKIn6gfAZkl7EMNBEnS+0hDY2
	3JQkOIn6X4NghyP4muuhIy6YkBcNaNx387Nan0iVStpXFvV1m1iTiLVmzzo9qTVMrw6oLzx
	GIhXd0KHstAcUuad+OS/ceVUA1y+K1ntETmNoxIw+NFW0btHeLgHynJ2/iKuKnpiN/9ndHZ
	r/ueY+0t5T1T81EoCW7LUnkjrhGJpeBJTPBTtBwpr833FDVGwPW5aNnTTJUHRNKIN7tbe/n
	CemVfwK4riT76VmNpqTcBYhO1OO7zc0IIOkceenh/i0dr0WPIad/xyYLTFiGADLxh/6E6ve
	QSHmkkWDV2uh1Xux/lxety6jsoYRobbttrRKGaky2LQl07f+sUnnA3oFrFoQiTIL8LJbdEh
	h9eQ3/JSc7S/uq6HqeWcdAZXm5QdYCGJaWNoHn2jg60M+7VzuLjjGgcpuwEHnECG837qqZl
	YJNsGKByK9zSXTrUVCAEnQ6Je4hItKX6BmbTt+ERkhEtGuc9+dTk/DHI2EUsY8XPlF6J4s0
	JQcmd1cn4rQZEawAKSylkgIYvpS/MV2BOwkNIgAjDy/J2xOrUBQFZPe5v6fKhH+Zaxq3iJN
	0WuWShiUEXNKFB0wP6yToV+pW2RaQ5WICgTsHgOy7txyVbjOT0Nz2q5glHGP83Zp0wmGMVY
	Uf8XHKQWb4TCcqJYx9Onmy6l6oWr7EJlHMOdfoKp875m9uQeajbSsZDvlvzS9WLksUrXNrv
	eK09LHJqvFatLN+WITtvhjSS9AJ9+x69MLvFCEMg6xR
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271804-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:email,trustnetic.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE26C32E4A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


