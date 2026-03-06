Return-Path: <netdev+bounces-264688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANniOVB1qmnRRwEAu9opvQ
	(envelope-from <netdev+bounces-264688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:33:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BDC21C189
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5849A301F4AF
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 06:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D55636F407;
	Fri,  6 Mar 2026 06:33:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4402848A1
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778829; cv=none; b=pFpQFeWCv+iftOY0fedacS4hrlCs+7A217JEukS/q9Zm63i+anqkOPQzJ0CKcb7Nz/gJrCM1j2f069+dQt073aYk8oBWhfnlrd2SzuWEOghe0gcvLg+JY8GoTDliV1H2/0CE6rJ/zsz2wvuJG8eL7eE7gie++MBTkgaHNKvWFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778829; c=relaxed/simple;
	bh=KFZR9V8u6CMrm/XfjAFQ+uIEysANP+mps6jVcXyxpl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Po9DdDDV2dujLleAOu0Q+9ZQW9C0yVCBoCxi9Nnt1UmRs5raD4BPjJFiqgkMwhrqDCRKktgYAvhiDvjYBIdgNrnnHVk157wAk7UfXw+Ffcn7g9e0YvEhr/sMr1nNotwtwDm4fQO/lcFQlbZji+dDy8yzCZXizhgoGQ/7dpwb0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1772778764t5bb8385d
X-QQ-Originating-IP: 6zVk8rJhE1lHF6vQ/lZRBEw7zdyeBXy9/ASDJDt/H1c=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.243.152])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Mar 2026 14:32:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11091958750007124057
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
Subject: [PATCH net-next v4 01/10] net: ngbe: remove netdev->ethtool->wol_enabled setting
Date: Fri,  6 Mar 2026 14:32:02 +0800
Message-Id: <20260306063211.20536-2-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NS9jmIGr9NkKWls5uOOki9FvZZm8OZm79cfTNU+HXU2Znstc7Z8oQ/ZE
	Wt02nnRNsoh+ztew6fdRT+Yb46n85rKYw1BgMSGeEjjkQ0rblcfA+lwZrxo4xNRj2m2Ps3t
	sXqNYhLNM0/I/U5P0p2A2EISE3Sl9EW4rH9a1U2HqK6OaeI8qRfPVBPJdzJNjhIVimv2Sqn
	FH3HasNCIza3h7BB17XE+SOxSJ7/ZWqE/y9naiJFKFKzb7k1IFq4AwjZJHZGWKmF8edrh6d
	f216YHGCPwf0GdPajIvdyH7u02xPXdmbXEz0RQg0zKNSAUkGN9fkTIhz5jfXUltdL/Mp2/R
	63qvqY/95xYZxXW8F97H4bfagqVWPS03+CUuVVdPTlWz0kwS5WiIOqu7xhkvEGg5MbcM456
	XkAyH44NPIqgL+DzUM7fMeYFRrNV7Fehz0+UKP7BvwDRsoHQtMBHnQTrR86j+uDj0Bm+7H5
	1qVmquzOcKNaMy1PxTkysANiecU/jsc6JY7/AhJpr3vm14yM6q0oCLS7cZWS1OBXb3rQb8w
	BXuzsBsV/gM3cg8xN8N8oHGOvEXxBkFmMQuw/Yd5o9c7S9/NEB8eTF0E6fHLnyhm71KCoY9
	SjBtz0lXxgc9pbJOxjsBHEJOfYPnL+unCZQh5P6Dg2tFiufVnr3A7kB8MVe7SOuVZNt5gob
	cZ9MzDe3WxvlTQocrr5ywqjbGRaNRqRNup3PXCMJpYEbTWiK3rAXG+z6R9pXiB85B7KtRmz
	L3iYzm2hg/SeS+yViQ7SRvlQsV1P1JpCEUTNEf0ZX75AtzhhnYomhKYrFzLyQ1qgwokVNXw
	JHEKdB2jxE2hctgZyIIDZ9RusCseF4kTfUGXvrs4i1WXyCAZsnT3sk/3caVe3QupkiRWOJY
	VQ0Us2MCXqRnUPt27e2Zh2zHANODKukeqLl11QnQWgdOrUVhSJwfVG5WmCRIgKPthjAMD/4
	8UkaPtRuS3UjqLhzXQ0TZB4FcUio42KNGdih8uswGYSg8nlpgd5lSGqAgVWSMIVjwgyIx3Z
	4h179PJR6ERxFefIR45Gu7IOPfdIBK8QOKitjYXF06jevGverK6Nf2hI/mIX7loF+GeRWTR
	A==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 55BDC21C189
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264688-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

netdev->ethtool->wol_enabled is set in ethtool core code, so remove the
redundant setting in ngbe_set_wol().

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index fc04040957bf..40779fee0fdf 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -37,9 +37,8 @@ static int ngbe_set_wol(struct net_device *netdev,
 	wx->wol = 0;
 	if (wol->wolopts & WAKE_MAGIC)
 		wx->wol = WX_PSR_WKUP_CTL_MAG;
-	netdev->ethtool->wol_enabled = !!(wx->wol);
 	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
-	device_set_wakeup_enable(&pdev->dev, netdev->ethtool->wol_enabled);
+	device_set_wakeup_enable(&pdev->dev, !!(wx->wol));
 
 	return 0;
 }
-- 
2.48.1


