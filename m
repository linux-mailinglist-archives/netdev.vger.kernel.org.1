Return-Path: <netdev+bounces-240674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B95EC778E8
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 07:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D49252B882
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 06:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D303043BF;
	Fri, 21 Nov 2025 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y5xY0y4l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200B8303CA0
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705850; cv=none; b=jF66XQCgs1OeuRStUBE1zivK/8R3X8JXr584qjDeBR/cYmAgxatmmSX+oC32tzE0aWnTWcAaSbpw7Xf/7N6lpLWGPXH5/i7n4R8FSRWJx1Q2K9pqFEAA2sAvdyOGpFuoTo026RyhU1CO6ohwc6D2EMViWOV8HMeG57Y8bn8zEIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705850; c=relaxed/simple;
	bh=QFBWY+j3FnQ7s1aKD8Q02ivrUPtWrVe8ho1SxmgRjjU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hDWnApvwQ25QQmdY5MaubZto3f61XmFGS/Jr2q4VHBnUyoVL4KF8wAlEPc1J+XkCCwEJbI9a+q3tQv3X0W/0+rSMDO6jIAGrrxFNYl5jNCF2qQsO2njmakILx2Tnk+QfsohGBXWHxP7YlRWs6T+PtwrpLhZ2KMdTZf5ig8Lsxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y5xY0y4l; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8804b991a54so68342926d6.2
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 22:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763705848; x=1764310648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=885XTxuu91C10pvV7Mn0xEWqiM8zGXhbAVs3WOBOcYo=;
        b=y5xY0y4lyOL2DuLhcPnchjR7SLLaaGU4vijYE9L3PtJ+KsF/wrcnhwfrz2St2nmFLO
         zDLsrwIcelUW5N9aULsh/s0WVMoh1s86zjl5LpZojpo2GFGoFY7+SkOSf5UFcqTeoH+S
         +Izyx2ZLTHzgGFtmCqI4CYZRf6ycfeAsz/yiv1BWFz4v6UFcH0oVnh4a+tSjWw9GkdlM
         IiC7Z6Z3mt4yW0mnx8pTPeSs4cEr4kO+/UrTU8PWcV65bjfPDqkoW4G5S7AuSipE8tLB
         yLxvkCMqcTY/4r9k1pABDFL265TwTQIHmveThtb/lQ+XU6zcc51tz/F4DSxRhtMYBWGw
         8m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763705848; x=1764310648;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=885XTxuu91C10pvV7Mn0xEWqiM8zGXhbAVs3WOBOcYo=;
        b=BObSnv6W2iOzas22v3BZWB3qkPf645Yvlfmw/vaNmnpkzo/ZUe4d5FN8mIAZJmYBoh
         s05ysiRkKIKfbnDm3ArXBLxXqYSCP/uIPcpgOnDUj4jbhyHfYm/OwTuQPauiFeCsEXz0
         ZEm/zzUbNYsdnkKf/lVj6NJflavzgGVtxT8wPrP+4gg3DGv6FhNf82lN6p2NZR38Taud
         +h1isH7Yf1X3x9vv1v3H6k5OxgdsK8YPUT3mzm3QvE/4tCHiB9f3/4cNtIywXXSH02NY
         BNkCA9JhjMYex+JZT42Avxpu3Gc6vdZXSEiBD2/gzShWrqBgVsbmE7ysWBZIo/TT5XmS
         VCdw==
X-Forwarded-Encrypted: i=1; AJvYcCUR4a/8gNHbdBnac3/8//Z0UAM/moI7OqmuwXhzCivwmsPVk49ZMS2DnoaBXMtSKcmDvN7oI6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEfwIaGl25et/ZpMqgAU/yeEcOAJ1kwR4H8WYgnX6Fy6/84JjZ
	Kz3KTnl/ujcemovYOH7wO3YtLRHtNFIeATG4G35IjPDVCeZtVCpwM+7OLZGGWGodT9Ud4z62iOc
	smoQ8NFdmIvItWg==
X-Google-Smtp-Source: AGHT+IEUiPPUnwZLxiqrJVqlszCqn9FW38fyWNRbyWnkQ6f4whUVn6QK2FymXvAlF30XRrTMvveSMEIS3d7mJw==
X-Received: from qvbpc17.prod.google.com ([2002:a05:6214:4891:b0:882:6a87:f45f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1d23:b0:882:49f4:da1e with SMTP id 6a1803df08f44-8847c52b3f9mr17419436d6.54.1763705847690;
 Thu, 20 Nov 2025 22:17:27 -0800 (PST)
Date: Fri, 21 Nov 2025 06:17:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121061725.206675-1-edumazet@google.com>
Subject: [PATCH net-next] net: optimize eth_type_trans() vs CONFIG_STACKPROTECTOR_STRONG=y
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some platforms exhibit very high costs with CONFIG_STACKPROTECTOR_STRONG=y
when a function needs to pass the address of a local variable to external
functions.

eth_type_trans() (and its callers) is showing this anomaly on AMD EPYC 7B12
platforms (and maybe others).

We could :

1) inline eth_type_trans()

   This would help if its callers also has the same issue, and the canary cost
   would be paid by the callers already.

   This is a bit cumbersome because netdev_uses_dsa() is pulling
   whole <net/dsa.h> definitions.

2) Compile net/ethernet/eth.c with -fno-stack-protector

   This would weaken security.

3) Hack eth_type_trans() to temporarily use skb->dev as a place holder
   if skb_header_pointer() needs to pull 2 bytes not present in skb->head.

This patch implements 3), and brings a 5% improvement on TX/RX intensive
workload (tcp_rr 10,000 flows) on AMD EPYC 7B12.

Removing CONFIG_STACKPROTECTOR_STRONG on this platform can improve
performance by 25 %.
This means eth_type_trans() issue is not an isolated artifact.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ethernet/eth.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 43e211e611b1698cbec5f6256ffd59975584bf04..13a63b48b7eeb896dfe98eb0070a261eed2c384b 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -154,9 +154,9 @@ EXPORT_SYMBOL(eth_get_headlen);
  */
 __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 {
-	unsigned short _service_access_point;
 	const unsigned short *sap;
 	const struct ethhdr *eth;
+	__be16 res;
 
 	skb->dev = dev;
 	skb_reset_mac_header(skb);
@@ -181,15 +181,15 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 	 *      the protocol design and runs IPX over 802.3 without an 802.2 LLC
 	 *      layer. We look for FFFF which isn't a used 802.2 SSAP/DSAP. This
 	 *      won't work for fault tolerant netware but does for the rest.
+	 *	We use skb->dev as temporary storage to not hit
+	 *	CONFIG_STACKPROTECTOR_STRONG=y costs on some platforms.
 	 */
-	sap = skb_header_pointer(skb, 0, sizeof(*sap), &_service_access_point);
-	if (sap && *sap == 0xFFFF)
-		return htons(ETH_P_802_3);
+	sap = skb_header_pointer(skb, 0, sizeof(*sap), &skb->dev);
+	res = (sap && *sap == 0xFFFF) ? htons(ETH_P_802_3) : htons(ETH_P_802_2);
 
-	/*
-	 *      Real 802.2 LLC
-	 */
-	return htons(ETH_P_802_2);
+	/* restore skb->dev in case it was mangled by skb_header_pointer(). */
+	skb->dev = dev;
+	return res;
 }
 EXPORT_SYMBOL(eth_type_trans);
 
-- 
2.52.0.460.gd25c4c69ec-goog


