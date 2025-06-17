Return-Path: <netdev+bounces-198674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2908ADD070
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E18B3A41BB
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F972EAD11;
	Tue, 17 Jun 2025 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp78h38a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA92E3B1C
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171365; cv=none; b=fFkAV8TowKIdpCrduc46AXDTX0sktE8ASZZqQJX188wk9UEhJDkTC3zN2Jop804L7XH7GElxx6m41avuiGPyb39wNSwTjvEFps8WBl+1FedLkTRBBXEzdX+qLcvL5KG+fwHjKqyTdFBwRs8C36ocdFwJfe2/bd1SO7I0UoVhtgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171365; c=relaxed/simple;
	bh=cbkfSbj1v3wvGrHH39kL/bZMsinT6UtpFGhPzE3KE+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELF4pgyG1LJ0VVVvAKQzjV/hU+62d4W6V4RqyMvp35ijAm7vMedG+gY7q9xL7a0ohiDx4hI2bu8v/YI3PwDTFVbh07wheYKSlvFcFuQeqj3tIQFPAH8bavBGEI0/dimxTrs7hmdSQjwogZ7+T42Eu1C93ZIBRQp+JnggkO645fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp78h38a; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adb2e9fd208so1175407666b.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171361; x=1750776161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNFfL4AGXHP0tK1zEY2pHIqKensgZlso6Fm3Rjpow0c=;
        b=jp78h38aTAL+cnKnqtwHKmdYH5LB3rd5gxDlJMD8bLEeHhmCw0U0d2vhnX3j6x7fkF
         5yyFP3qrbAwZ9Z4/6YqmvfNEE3HRAY94i1pnDDuEr+MDwLM5itdUiESruumD7moZgodZ
         NaC+sod4OLMLc81HF3BuTppnIE8AgLu6W3YkuHuzUnyx+Et9QX7k0Rhlvd1CzlKgNa+Z
         gvgbRKvW6Myfrw3asEmUcWarMfpVYgA0OltqUTIy8pi2zv6AAO9DFRLnbbVP/CltXN7X
         oHjlv3gXv2SEFVJitAPzllPuJVQw/7QLLY1WZAzV8qJYm58O6IVdTDsbusXRcgYhHkX1
         fJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171361; x=1750776161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNFfL4AGXHP0tK1zEY2pHIqKensgZlso6Fm3Rjpow0c=;
        b=gRSJQuCIFb0UPl7vfO9xWrCXZPFFMgkzGhqh0DiGIoRWK3A4qbUife2uG9hAieOmcS
         w5njXBIt1MXO0zKi7W4agWQB9Pii86MEqetjQAekviAWkEyyELEjxE6F/m/oNmP2wN1x
         d/33T4xT+1Lz+dFWWwMPJFdkqdNkfYW/aUlj6jQj0UjzdcCnysHQmvAt+bnIJH2qZmxy
         rUgcu8Fvf5Ef92XLhNrWUQyMWR3Hd5BYlmhju3+2jaavRGCBD/B9NzgA6IN0mWW2OszI
         oHZqErWfuSoy96sD8OBv6vhHlIKcfVTmQp1qohkkLmUwrr4NpKMLPALrtmoWUEz/otQL
         OARQ==
X-Gm-Message-State: AOJu0YwxLeGuDmMsk7UboiPCln0KGmJaEVq/cK3Kkwn+TCP1GJuSZHvl
	C4MRdCAwpXwlpuljhztLiA7mZV+VwjW+29i5OusIGuaXiSE9gl05Hm8b
X-Gm-Gg: ASbGnct9B6gJe/OUxztm1Mdg65ByBTFesvCFbSFx/qKjpBlX53zzWj/18aOo9+F3C3U
	1BzKpxrGVjxsmZP3BW7HTnKsbEAngoweG/l02EfJHeUzPKt4iQK16G+3pvIZW835HJ3Z/CmzOgy
	05EW3yA3JKjpezZsZynIUBwjJFlCrPLfsu6zO18TOF5bGI+ljolgBNxdyRSPx/pAQsYNDEeFG6t
	dLk2i2AY6KaxRjMvTYCWJARCM4d8DrAzPFC40nTYMlmirxPLRjkT8EyHLAxy+6tRNvjGegLOq9F
	gdyWSyBnE94Xs1/lb4Zjrv+d86MAa2rYPsc79GWJF0SC9nxclAcrncc9d/BDZh8spfD5oWx/F6z
	oO49OBC4Uehhu
X-Google-Smtp-Source: AGHT+IFryJ9gWYyNiLgyob7YjyXoD+ZtbPpPEOUpIBDfJVAxmFInljEjGXPHbUz6v4bgC54SCn719g==
X-Received: by 2002:a17:907:3f0c:b0:ad5:3055:784d with SMTP id a640c23a62f3a-adfad54b20bmr1170167466b.34.1750171360949;
        Tue, 17 Jun 2025 07:42:40 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adf37467a91sm781716666b.166.2025.06.17.07.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:40 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 06/17] net/mlx4: Remove jumbo_remove step from TX path
Date: Tue, 17 Jun 2025 16:40:05 +0200
Message-ID: <20250617144017.82931-7-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mlx4 TX path, that used to check and remove
HBH.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c | 42 +++++-----------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 87f35bcbeff8..c5d564e5a581 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -636,28 +636,20 @@ static int get_real_size(const struct sk_buff *skb,
 			 struct net_device *dev,
 			 int *lso_header_size,
 			 bool *inline_ok,
-			 void **pfrag,
-			 int *hopbyhop)
+			 void **pfrag)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	int real_size;
 
 	if (shinfo->gso_size) {
 		*inline_ok = false;
-		*hopbyhop = 0;
 		if (skb->encapsulation) {
 			*lso_header_size = skb_inner_tcp_all_headers(skb);
 		} else {
-			/* Detects large IPV6 TCP packets and prepares for removal of
-			 * HBH header that has been pushed by ip6_xmit(),
-			 * mainly so that tcpdump can dissect them.
-			 */
-			if (ipv6_has_hopopt_jumbo(skb))
-				*hopbyhop = sizeof(struct hop_jumbo_hdr);
 			*lso_header_size = skb_tcp_all_headers(skb);
 		}
 		real_size = CTRL_SIZE + shinfo->nr_frags * DS_SIZE +
-			ALIGN(*lso_header_size - *hopbyhop + 4, DS_SIZE);
+			ALIGN(*lso_header_size + 4, DS_SIZE);
 		if (unlikely(*lso_header_size != skb_headlen(skb))) {
 			/* We add a segment for the skb linear buffer only if
 			 * it contains data */
@@ -884,7 +876,6 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 	int desc_size;
 	int real_size;
 	u32 index, bf_index;
-	struct ipv6hdr *h6;
 	__be32 op_own;
 	int lso_header_size;
 	void *fragptr = NULL;
@@ -893,7 +884,6 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool stop_queue;
 	bool inline_ok;
 	u8 data_offset;
-	int hopbyhop;
 	bool bf_ok;
 
 	tx_ind = skb_get_queue_mapping(skb);
@@ -903,7 +893,7 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto tx_drop;
 
 	real_size = get_real_size(skb, shinfo, dev, &lso_header_size,
-				  &inline_ok, &fragptr, &hopbyhop);
+				  &inline_ok, &fragptr);
 	if (unlikely(!real_size))
 		goto tx_drop_count;
 
@@ -956,7 +946,7 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 		data = &tx_desc->data;
 		data_offset = offsetof(struct mlx4_en_tx_desc, data);
 	} else {
-		int lso_align = ALIGN(lso_header_size - hopbyhop + 4, DS_SIZE);
+		int lso_align = ALIGN(lso_header_size + 4, DS_SIZE);
 
 		data = (void *)&tx_desc->lso + lso_align;
 		data_offset = offsetof(struct mlx4_en_tx_desc, lso) + lso_align;
@@ -1021,31 +1011,15 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 			((ring->prod & ring->size) ?
 				cpu_to_be32(MLX4_EN_BIT_DESC_OWN) : 0);
 
-		lso_header_size -= hopbyhop;
 		/* Fill in the LSO prefix */
 		tx_desc->lso.mss_hdr_size = cpu_to_be32(
 			shinfo->gso_size << 16 | lso_header_size);
 
+		/* Copy headers;
+		 * note that we already verified that it is linear
+		 */
+		memcpy(tx_desc->lso.header, skb->data, lso_header_size);
 
-		if (unlikely(hopbyhop)) {
-			/* remove the HBH header.
-			 * Layout: [Ethernet header][IPv6 header][HBH][TCP header]
-			 */
-			memcpy(tx_desc->lso.header, skb->data, ETH_HLEN + sizeof(*h6));
-			h6 = (struct ipv6hdr *)((char *)tx_desc->lso.header + ETH_HLEN);
-			h6->nexthdr = IPPROTO_TCP;
-			/* Copy the TCP header after the IPv6 one */
-			memcpy(h6 + 1,
-			       skb->data + ETH_HLEN + sizeof(*h6) +
-					sizeof(struct hop_jumbo_hdr),
-			       tcp_hdrlen(skb));
-			/* Leave ipv6 payload_len set to 0, as LSO v2 specs request. */
-		} else {
-			/* Copy headers;
-			 * note that we already verified that it is linear
-			 */
-			memcpy(tx_desc->lso.header, skb->data, lso_header_size);
-		}
 		ring->tso_packets++;
 
 		i = shinfo->gso_segs;
-- 
2.49.0


