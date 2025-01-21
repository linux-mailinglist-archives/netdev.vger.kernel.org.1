Return-Path: <netdev+bounces-160088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6020A18143
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F9B16B64E
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C61F4270;
	Tue, 21 Jan 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QvMKbg4v"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08F71F473F;
	Tue, 21 Jan 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473966; cv=none; b=aVTRKq2GLooTXAJAluMN6iLpQ7P3CZNjby81awT7Mb87mzwSqHNISnjwkobfU4bfuzVQ93Re51DQYoG8v7PEsSgO3/Ox68g0ULr8x2Yh5nVgLZKoK6TjwlnVf0kwZe2wJqM0BLt0CYdyy5R/SMZzDbB/KCFlEkxtGjfuqX9rwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473966; c=relaxed/simple;
	bh=s08Xi7eWilOToJoqOUp06VHD5CTe5bX8JeRbxnDip0Y=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=uqkFk2l6KfWBuDspy8RXFJT61L0zDfz2kd3Df9fPByQ0bMq/oyBTc0XUybSWVKmTVNDBDTNtBK1P6SQ/5adzpgqL3U32HYb/g9Ip5QJNi++D9GZG/rIKoeYyKfZfbJapfiePOiaoiHN6l/ml0ppP1ziIYsV+/V4svjWqTLL0BeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QvMKbg4v; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1737473953; bh=dDHMd9dQM0LmBIFol6kp8ZqAfRV3AwLNy4F0aQQQg10=;
	h=From:To:Cc:Subject:Date;
	b=QvMKbg4vfliT1YnxY89qjSE9dy0cLfTeDxI8VKxG7E4Hi3/Qh1tum9zeqY6IGxxLP
	 KhmTmsFV28DnEZq7zT15E9vkAowHWqs7ZWyMY7NjAPByfEBQ20TUh8W3YA9p7xd2VO
	 tvjuUvBxdwNTKEU/XPK+Z9ZmYwih4OdJ9wLCdI8c=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 9BA3DAAB; Tue, 21 Jan 2025 23:38:58 +0800
X-QQ-mid: xmsmtpt1737473938tlk9u0aix
Message-ID: <tencent_D0DC3D8CD6217FA0CFAFEDE53F27810DB408@qq.com>
X-QQ-XMAILINFO: NKSU0tyXQiJ3n6BHFmWKi+Z1Sr1fGtkrL0UdLYH/sEN3QaQ7CnyOkEg36uu+FP
	 +xzyEKsRQBff12epLApWXjINyZW2QSSJn8JUOPNUR7Icn6j6GGjArNFKfSeYunWMl/XMxiaLJsC5
	 DGoAyYN14fb1OsQQxCN3TXiC3khIzqop4RVQt3w44YhWHY4QBDWS9RHBCG4A1XYSPHqIUsXjsVWg
	 vTNb9Q6Me47kVurzWaldRF1+/QGaFQRBaAjaV5aDmPailsZ5/qM7CycqNR3xSEsHRMB0pWh2veq8
	 jrXKjnnTGfSV4wywaEycEtTJBUgeFidmnxbia2jV1xXMTQNuQxwGa8OZs5mYrgWuEhRrRdcX2gfa
	 ndh0gI1iy6T25n7acfxL68KuAkMvqng/5vgv++z1XG8aUNPfZl6ekUShSvcx3poNjl7l/NvWd9nz
	 egzYZw3YAN9c4tPL6+UgAcHuTUUfpGSMSLPqc0t2cPy5IM1wM/TRpwqrEBqLqczCBijtuQn81Eeb
	 3LDkDcz5t1/3zWluyHZWB0DUOJxz35oab9SEfjJWzyIrruwwaKgiqOV3w/Ft1hnmqzge2eZXjf7H
	 KWSvj3Lx5mbXkn2IFvFYIUChnIqfBe1IlLtTRSpS4RUeTL+XK4Rgu8cuwXlCoRzws3wttwu56KjP
	 I8UR7YypEKcNpT20idOjrghIH7we31io3H9grHyoLYctHXXmoItHblJ9Bh/25xX2dfQywN21xDzR
	 XDDc9SDWkkxZpbpzj/9+qTCy+DChYiUP6SaD50VEcsngt4v4586/0GUgjVjnT9Gnqo/YWZEacrvf
	 ljK+IKFUsLHARUnoegcPMtgaJyDKHFbWHL7Fs64rJrHVGkqsZ7XPtS2QKllgn37NLGnhUjAhjHV4
	 B+10BtdY/sfrBfgkevu/sIuchA56s+Wm+d+4/WuiIflucA1usiAil/yb8RmcalGS8uyEw+fJERKF
	 qzcNMMECW0Ct/z5wH6DcB4g4OI38x3qkcXAaiqUM2cMYKHSUwDacSKitWs0HtSh/KEcu+oMrAkOw
	 9htCkKZ7gOOVjxRqX5FzO43Ums9EDhFyQV+NMVsA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: the appletalk subsystem no longer uses ndo_do_ioctl
Date: Tue, 21 Jan 2025 15:38:47 +0000
X-OQ-MSGID: <20250121153847.356747-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

ndo_do_ioctl is no longer used by the appletalk subsystem after commit
45bd1c5ba758 ("net: appletalk: Drop aarp_send_probe_phase1()").

Fixes: 45bd1c5ba758 ("net: appletalk: Drop aarp_send_probe_phase1()")
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
V1 -> V2: Add Fixes tag

 include/linux/netdevice.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8da4c61f97b9..2a59034a5fa2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1085,8 +1085,8 @@ struct netdev_net_notifier {
  *
  * int (*ndo_do_ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);
  *	Old-style ioctl entry point. This is used internally by the
- *	appletalk and ieee802154 subsystems but is no longer called by
- *	the device ioctl handler.
+ *	ieee802154 subsystem but is no longer called by the device
+ *	ioctl handler.
  *
  * int (*ndo_siocbond)(struct net_device *dev, struct ifreq *ifr, int cmd);
  *	Used by the bonding driver for its device specific ioctls:
-- 
2.43.0


