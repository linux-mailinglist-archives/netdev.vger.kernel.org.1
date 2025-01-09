Return-Path: <netdev+bounces-156681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F3FA075D6
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D83166BC1
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012A0215762;
	Thu,  9 Jan 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KP159cl4"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D61E531
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426239; cv=none; b=dizXZNm2obMO/5PEJY9CCLxtKGNTWVq8APCTA8gvpSYDzvaTWn4R7NGTPiGWKjgFkwl+5DJuYZMdux2gz9/QWnjYtkCGL1HrRLv61/9NCjZT8njrpL1voOfDOYOTqc0MRpH1YzPqIadgG7rUQc8/RhRf6vl2aS3AMQxv3GVjApA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426239; c=relaxed/simple;
	bh=9Tk3e8/puPJrVpajTSBRMSkpQWBKaY4JLIbXwFx+Vak=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=Os+tyZww/HBj36VEnAhqQFvezlT6/jGFqaMc04tUANEm7qYZ1SpCUbbMtv9IZ+zP5i5nCSvIWJ7bEZEt4rm3kXFCukAtVi2+c0HpUi6XJcVbXdHe90d3lTDT2nIRcW5lLvW39xkAm+53kP/KLEiEbWwtmEJ1Vc35fC4ci5ZDADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KP159cl4; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736426234; bh=cP8/g5iyadNEW/dEbqVWvq7Pu/1yi5zRy+4ZOJ3uBM8=;
	h=From:To:Cc:Subject:Date;
	b=KP159cl4o8xYd1b2nqoxcOiuSBOrrs1Vtg//BIHIePBxRArryrJFHlW6xNTKFPKZS
	 3fioVnGDmMmvl+mHFL//w4/Kb7299NV4hCGntEOT5vL72P2+qcLeLG4ziba0L7qVpn
	 w8X1m2E6MNz/GQXBqLQ11yVBDOZ8mjApvfzgxX2E=
Received: from mail.red54.com ([192.42.116.209])
	by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
	id 7140C228; Thu, 09 Jan 2025 20:28:20 +0800
X-QQ-mid: xmsmtpt1736425700tsu47gznh
Message-ID: <tencent_50197BA0ACE5FECA9F15DB877ED002416809@qq.com>
X-QQ-XMAILINFO: MDYp5rM0WWUsNSlZvLnIbgCdNjVvDLiU6qG3hjyEE6f0ALjNTfNNWt4+6PA+DD
	 bupKUDGzTBkGpHyxQ7yniANaw39OY9+b3vCB4TF1AQdyXxGzPXbn37/OuVTQYIp/9KP7b97E38m6
	 iiiedgvQKV/GNgASauzGLy9srgl0+SvoIFDJJFr9uX9qmuQ++zyYSvZg0QFjNvbEtcYanGZ5M818
	 17frwNr7o9JjiBs/3BzgJJIrk3FIVeVIoi2T0OKxHktkHY2zNjjCYadE4O2xI0J2n4GxnFGMrOT4
	 HfAs2514UJElIq3UDJ/BTxY4p0jnFAOmXN6aRrKJO9REiQdubHgZj1UK02CGnu9C0+bur0NBi457
	 rYY8ADZaT1pcedVUbye2Z+rpDBDP18+JX4GjtkOVQmYMWRzS347GRgglLX7zkXfjp9f7R0XSoZQB
	 hjY220yB7Y9yeb5H2tejJ2THTq99eYFS3H3oYiwJWIMJQPKptNGy/IF/qlUv1KzHsVdBbE87LVqG
	 kuC8Y8WWC12WBUjGI2NlTh3axs1PLNBrk0e9HZ340Ltl10WmDyJROJDvJLQHRvUgWL7Yjvi7E4YF
	 cNKzzE02uRRlUAqyRsMwJDdI6FrKj2ysolkj/9B4hn+3Y+8eefdPNJOCFT+3YDBIOIzRas8bI1Mi
	 BbMDS7HfwG2yENCtULIwPh2G5FltL7G3njGR6LD3QLC82YYTo/OtXbBXzmvMzD2e64Om+Yi+XALP
	 FxRUvPpjnyzzjn4u0KTLT3DRaFgZbWFhcQqT3SJnW5jyRIMu/DegiMA34ALPUbTYqi89P0eKyQi8
	 Hklt/j0HxG9MWbYRFmuXok2Gqqhzdc+aUyKz62Gy7FSLUpNqMcm53Rcv5G0MTFe0ijJ0xa8Xfg61
	 PGZ0b1S8flARR6/hWc406z8K6Sr1/jeV+nGnl0X+Y5+WzCo8leRcx4rWcDc1NSDLsNKiCycSSS/9
	 6xhdksejhSI68ow/nnFYY4DM/0lPCT
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Prarit Bhargava <prarit@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [net PATCH] net: appletalk: Drop aarp_send_probe_phase1()
Date: Thu,  9 Jan 2025 12:27:51 +0000
X-OQ-MSGID: <20250109122751.58730-1-Yeking@Red54.com>
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

Due to the ltpc, cops, and ipddp drivers have been deleted,
aarp_send_probe_phase1() no longer works. (found by code inspection)

Fixes: 1dab47139e61 ("appletalk: remove ipddp driver")
Fixes: 00f3696f7555 ("net: appletalk: remove cops support")
Fixes: 03dcb90dbf62 ("net: appletalk: remove Apple/Farallon LocalTalk PC support")
Fixes: dbecb011eb78 ("appletalk: use ndo_siocdevprivate")
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 net/appletalk/aarp.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index 9fa0b246902b..af6a737e4dd3 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -432,38 +432,10 @@ static struct atalk_addr *__aarp_proxy_find(struct net_device *dev,
 	return a ? sa : NULL;
 }
 
-/*
- * Probe a Phase 1 device or a device that requires its Net:Node to
- * be set via an ioctl.
- */
-static void aarp_send_probe_phase1(struct atalk_iface *iface)
-{
-	struct ifreq atreq;
-	struct sockaddr_at *sa = (struct sockaddr_at *)&atreq.ifr_addr;
-	const struct net_device_ops *ops = iface->dev->netdev_ops;
-
-	sa->sat_addr.s_node = iface->address.s_node;
-	sa->sat_addr.s_net = ntohs(iface->address.s_net);
-
-	/* We pass the Net:Node to the drivers/cards by a Device ioctl. */
-	if (!(ops->ndo_do_ioctl(iface->dev, &atreq, SIOCSIFADDR))) {
-		ops->ndo_do_ioctl(iface->dev, &atreq, SIOCGIFADDR);
-		if (iface->address.s_net != htons(sa->sat_addr.s_net) ||
-		    iface->address.s_node != sa->sat_addr.s_node)
-			iface->status |= ATIF_PROBE_FAIL;
-
-		iface->address.s_net  = htons(sa->sat_addr.s_net);
-		iface->address.s_node = sa->sat_addr.s_node;
-	}
-}
-
-
 void aarp_probe_network(struct atalk_iface *atif)
 {
-	if (atif->dev->type == ARPHRD_LOCALTLK ||
-	    atif->dev->type == ARPHRD_PPP)
-		aarp_send_probe_phase1(atif);
-	else {
+	if (atif->dev->type != ARPHRD_LOCALTLK &&
+	    atif->dev->type != ARPHRD_PPP) {
 		unsigned int count;
 
 		for (count = 0; count < AARP_RETRANSMIT_LIMIT; count++) {
-- 
2.43.0


