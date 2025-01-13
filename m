Return-Path: <netdev+bounces-157697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1E1A0B38F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B083AA3B4
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480A0235BF4;
	Mon, 13 Jan 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hURS3vGR"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30C4235BF6;
	Mon, 13 Jan 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736761536; cv=none; b=dR7/pnFIH5QjwKTyqRJlOWfxo3vsJlcW4gNxTr+uUuWJIjKuTdI+5kWYfMfisIAacShUAf6ZGwdkJjqDWmgCfaxjrFDi7tS5CBQYtKyVor2CcrSH/2Th5GToSCZwqfzTDH8m7bZjA1EQJ5XAkIbhO+ncQ4RF/U4wSc9Vufeehyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736761536; c=relaxed/simple;
	bh=DGaiv9b5UWVkhDkHFYc1ja0FdSe9pmdaQy72D5NVJjE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YC8WoMTeeuKyi7LFRgRGNS60dleGPXiFto0q3NiFQR/kO25J9JV/Xzro2iZebbN/vmHAqFdoUzM9KjoTEQ29BcaaV5sgBOA+n9RQlv+g3iIiu/WE9v/Wet1RVLTVJeT3HwQqjBvAN/JNoPwNkup8MJ7qFVoj6zHaEGFLt1DHruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hURS3vGR; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736761520; bh=8BUcaaeDR8g0TBCHYYEj7TUQmhe8ESqqCwpv/+P8Z6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hURS3vGRmYwfKmxo3g9NIuxKGw+L0SJ5hPWU6EmmysH7VgmM6lz+1slPVddPksWuW
	 ZnON0XNzaicxPL2Yn1MWt0SkJyPafPTOBvHnHBipujD69Pjp+SkllFGbM5e4RiXz/Y
	 TwYXMixaKrIuD3qi+dQXz/u1EHRYZeb0phFFwlCQ=
Received: from mail.red54.com ([45.138.16.231])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id B4132020; Mon, 13 Jan 2025 17:45:01 +0800
X-QQ-mid: xmsmtpt1736761501tgiqcpvb6
Message-ID: <tencent_EE9140075A979E58EBB03FA7E7DEF6831F07@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Jukl1Czjf3/A8q9aptpoeYH0jFNYe+4LOXC+JDf/tj8hrQIFqWoH
	 Bcrlb5s3D3rBdhKRbzcXlI06CdDqFLnmvCMfshRTGmp6uh35Hamjram09npTGyIGPFNANvC8OYHC
	 gE8vO/W06TE0I1gNF/j2kBJJ7wfE6DpKYBZRap0IpbY+sPX9rxAwCMYBljRcAbkRS9S89A2IOWzJ
	 KuiUq6+S74lLKJKX8NipkEhxvtU0yfOyVLlwGnIXNVcsS52s3FVU7a4HymY3lPxe8a9HpEnzn0R7
	 ap/T86bDytrDmiy1401txtBENQk6vAtIdY4bJZkCXHpt0ChWmt08/xBTPHy530GSrmm4sVHm/ANW
	 BaOX0LXBHzHDdrb2S8jO5Lx6H4damg+P0YDstrsfYHyOOd9SVqUTqXyePzN3LkQYaYsOJos3yTtt
	 luKhSuOBjTQC6YebuVzI49W/w/744fvywooG2c5cu5De4zbl4Q0lYMLvqFYEivX4ObzLwTj5E4BD
	 rM36FjxxZn2muR6M66+b9c5N11zeGFGCTxmNIOQaagJYtzJwkl8xEI6w7KNSCuhgxwPWa3FXBN4m
	 8czx3wYScoGcXgElYdJfnGd18ApNOzRN5w976kt8JNcHJSpzzF+kgzMabj3n44yKOieymtLY7Bos
	 T6OrGrp+KvOq/8geZhe9QcUl6oUTlcOqbyfaxPwNmMiEb3d8jgBaEYs1xtyYH3dyDShzEvqFvUPW
	 l7qVs7A/FiA+LtSwyfTJhtdq54iQsjyK4CtjYk7h3BGpiIRBaV1gHTGuiEYhcj90aL4gBZx9jCFL
	 fEF6B5BiG8skZzXBd3T0KSAww8kGJOSlD2+yYDjW6SsaET3IMh9vaO2P21+ZAhzUqtU4WqQQ1A7v
	 QusCadF5b/tA5hkGRR9BhmxUIf10kOlZBfzOIbC2/Yi/hUhTEPPSg6opr3tZhRW+M+D4feKDC5TT
	 U9aYEduKSEzQQKGZIFuny4w/i/qVa8oXXv4w3NYQlY9zVpjt5yPvFL/gnbqwYJWBSFNyx/leotNL
	 O/iARV1neApHSipQmMncHrRIsxrEwkp3nHY3CCDQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: kuba@kernel.org
Cc: Yeking@Red54.com,
	arnd@arndb.de,
	davem@davemloft.net,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	prarit@redhat.com,
	vkuznets@redhat.com
Subject: [PATCH net v2] net: appletalk: Drop aarp_send_probe_phase1()
Date: Mon, 13 Jan 2025 09:44:51 +0000
X-OQ-MSGID: <20250113094451.141836-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250110182435.6b811abe@kernel.org>
References: <20250110182435.6b811abe@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

aarp_send_probe_phase1() used to work by calling ndo_do_ioctl of
appletalk drivers such as ltpc, cops, or ipddp, but these drivers have
been removed since the following commits:
commit dbecb011eb78 ("appletalk: use ndo_siocdevprivate")
commit 03dcb90dbf62 ("net: appletalk: remove Apple/Farallon LocalTalk PC
support")
commit 00f3696f7555 ("net: appletalk: remove cops support")
commit 1dab47139e61 ("appletalk: remove ipddp driver")

Thus aarp_send_probe_phase1() no longer works, so drop it. (found by
code inspection)

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
V1 -> V2: Update commit message

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


