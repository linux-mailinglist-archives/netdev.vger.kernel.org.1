Return-Path: <netdev+bounces-268469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLoGIaUFuWmEnAEAu9opvQ
	(envelope-from <netdev+bounces-268469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:41:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 900822A4F8C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3342D3026D9A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57266391838;
	Tue, 17 Mar 2026 07:39:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5723A3909B3
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733191; cv=none; b=tS6h9AsVEsXOWCEIhY72WriSFPYOevQKdR7oJePn0/56sqsTDzNOcsM4tIgZqoybqsJTJjBcC2Mn2UFYhYBYf8UEowf6wWXSQ0RK6o5UkWWow/dxCkLJEMzofI+1qdU/jfSZ2ZKjVnVdxJvCi7ZtY8c7HmeRuwTNj8lh87WOmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733191; c=relaxed/simple;
	bh=DS37ZtIrZGfCBkLXCBoFV4Vy2v8jIKZx0O9zqzQ8JUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxX/KaJR5SGQnVeugw5I3doe0+H2sZjEoWYOAhcwCYb2uRbym61ZVlQEwLmTdvSEDvbQQsUq3IXmoPwB8WbnjMje/ywUxTpcnlmzC88F+KvrLqeRYoqakV+utqzb5dYHjQ0JCtyqhH1LbioMlocR+K/3aACYKc66HYe6uC411Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1773733142t441eb26e
X-QQ-Originating-IP: laLXknHWy5GZIGOBJEhLsXaQXr8YM+exWOB7Hxh69Ms=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.239.227])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Mar 2026 15:39:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12146233862348206051
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
	Kees Cook <kees@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v5 08/11] net: wangxun: delete service_timer before cancel service_work
Date: Tue, 17 Mar 2026 15:38:24 +0800
Message-Id: <20260317073827.4300-9-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260317073827.4300-1-jiawenwu@trustnetic.com>
References: <20260317073827.4300-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NzvW2jrTTu4jq3zZz34E3s4wFj8Cu5ssxCZ2Xm3TBOhuQWSxYkCygUS+
	SMPakTD87/+8rpIzbxSpVJNV8wkrTO6Zd8uQBNMVG8ifwYZsdNNTbe8lsOkUsjhzfU7SOjP
	lOHZv6FKjOtanyzV9HJ9t+/3kku3qym81Hv/I83qBUqJbcQ2n+nZYvCtICnJubHMA+/uxVt
	c1r5vs5L0a+mwsYmdinS2oigl3DamsGNbI8QPuKXfQliJ49rnrQhszW8UD1YrFEPT+s7j/8
	Ebe/zzfIjr5dyLVRaYFTiZHvsVXrag1GDBWujNx+f0Y8IXFgCXhVdj5uo6G7Sjc9jWWip34
	YSZQgc3oiHKxQYT7hD8RJK8gwkzarYYWiOjG2/9TppM5+ZzKN9NxQLy/HwabvzZV4fc6rGp
	amdeiOlApyHei5OaL2v3AA5qeSRxercEQXpd6AGdHMWjRd6+t1xFuo5Nx/2g9u+YOOqaGM8
	WEHbya961XUfDAEvdz9nrAxY2Bic37gt63O6L2mG2lju7I6wD9qInr0FJn7r/tZ1dS8fiqf
	RP5Jh3/bYAQF5UUZn648GjiIrgrMCpMBrObXS/kO5cRKng5CiouqptxgAySnNKRxzC3agIp
	Jx9VtEPgI9ys3lhoKA/i/fo7Bj5nr654+22ZI2Dj+4FKkBLEM438CWxAIOddxzeQfpxBFDl
	nrttn+9UVMK5/bju0p3pF44ntBIudQ2wdkZQwlhpw3v89BIkxF+YF1bA6KCYoZy2/cHLypI
	wl/qbEj4ynCY04xTBqQU/XXq0Zs9I2JuCsOVxUs9fklFyIXvn8/fRsC9kvEtqmAR9+6c/wL
	pcYFl+CZP+GXGZH1M+Ezn1DNyif7cRX6+s2JEOAg6vKjAQMi5f6Sm5CmsvxJoTAeZkSMtlP
	vucyFOmRLfNAcCN8imgfFfGZuNCrkq/amWWp8nSVCSwh6h54Gi33tC0cbvlU1YyYd5PHf4H
	cfXIctHzJ4ZI+1tjCD4suib8Av7DUvxo65ViBuq94L0NpNguyuemouDRHcNlo+bESnEm6cS
	SQyTVJWxrRg7F29ztRzar/0UGY2wYy7EQL5xqm5ZrHcaLSGN/mBY8IH8ozPb6b8qZmkLi33
	6/KtK1XqmN6yhtaSG7Y9UXwHxwTjTaWA8TwfqFR9X6f
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268469-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.819];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,trustnetic.com:email,trustnetic.com:mid]
X-Rspamd-Queue-Id: 900822A4F8C
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


