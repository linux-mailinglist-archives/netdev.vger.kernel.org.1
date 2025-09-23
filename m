Return-Path: <netdev+bounces-225609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FDEB9612F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE7819C429D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1861A5BA2;
	Tue, 23 Sep 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz81mPd6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46B20766E
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635286; cv=none; b=GZqA9w+YpoQQOF8EAhtYjasGmfD2hvMf+N6bExg60fglF+TmDzNjRtLTmsNp8dMPqPbu4DGZfyVnTLtIQBdiVyvgBfldZG7CbT4jcQ+QC2MeYLPnjSiPIg2NSo2YqQT1j67N7Qbw76GiY374SgqpnwiSbKBxpPzoG1KT/Si/THE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635286; c=relaxed/simple;
	bh=DwqYpKTXau6vhBXM+pzvs28rbUhSSDoTbAVZk1c8v+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZkEdYXJNoieBFxEWlu9fAjf0uBgIM6YhqOHT5rbiKQyeq3DDMnCYOEDF1vSre1MQ3/NicD8fMULD6xMlrCBEQZzDGQpYC9hQRxsgyJmYRAoTubBGJ7Ehvygd+awrbXmjXiFj4M8Pk2Uv1vFEloL2M+fxDz8G1Nb0hiQ6JnG5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xz81mPd6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46d25f99d5aso15669335e9.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635283; x=1759240083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st+ur//QDkwfuMGditKwVjge5bMAayZ6QeaI82Ojcu4=;
        b=Xz81mPd6WCfBKCpYn98b+UURHlPYxVSXpthIRBgsK4jKSSzuuJDqiR4yIuHNURuSir
         l4qqZ7XAl6kjjbBLXwzzfsxkIti/R/b9aWlfvPkEwrunfOBz1FoPbGEgt4o0udeM4tvZ
         6U4jaHx/k6gHzKIDjoS2QallNiKSeTdiHTSMg0T1yOFox3ZRb8Z9EDw5Lt+WGqhL8X12
         7E1gdZfRUKrDJjt9seBzRhGVPFHXZj0LrHRjZgxkVx8kGWiQDY6Ps+M286c0XminjPL7
         gwMqaLENbZyflSVdHpKO5421jioltMKvwLK85FkOqs4Lkcoa85IcRf5+9lL34+wreC7N
         DAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635283; x=1759240083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st+ur//QDkwfuMGditKwVjge5bMAayZ6QeaI82Ojcu4=;
        b=gCy3kKEuEypLpj95jejPrpx/+SfRUabAqRU5l46pXwtZzomDLyYLXq5W/I11pX5iIc
         pd3Q6GM5brN52wtnlKKCOJi8krrSgHUqYWxfWL4LAq5RQC8NJen8+E+VTtjsJd2PRE5y
         wh43nkw408qfo343wm5Yb6ABKgWuqh1VBcyCuWdIJwbulfN6psvNh63cDj2zuxghNu9j
         pYcLNHM07CnSo9/ELsizcNY3x/bBbVosTIolJnuHeQdoyKpCiC9pOe0DUAGOzhYjuazs
         MA17SEfnv1fY+o+9r88b2uPEaEbi2Nbf8fOriF8dBCTEqc+qIZ6mOZNf20yGYtiiF8vs
         v9ww==
X-Gm-Message-State: AOJu0Yy9LIxHaoxJCCCC6GFN4GoVJSFcAu9OQ21vvy6aOwpQXG1g10aS
	q1QAa99vDd1Sl6xT8TyJ32T6fOEwqleCgmxEJgmLlJKt16r5U/EgD3jc
X-Gm-Gg: ASbGncv3D9bPD9jE1mty+3rJomkUfSv8MJbQngEIGkUfiZ6+gFJIqcG4Y2A8ZSonj9+
	aQ6vZfD00DFii6iv0XjW96H72vGdD3jOeB+wnvV21VSU22xg9Km0IhbRgA2kTx8gd2Mo4yQtgkd
	k+YhVR9rrA8qV8mkNBDTraqK0EMlTbg4C75wxKXZwcjb8YHPguAT2QZwyB0HeGspWREqZZchADq
	JOAEnP+1QlL/bqEZdWjGiSrnStnoZFhj7LN4mN/crkqIiwxwA8h2MK1SIScLFu3rq2oXVGNVzKa
	iq+RMZKdt28mI8dqN+R12yMaIveFAWwqWA9629EwKDLWFnULFh5Tx+V9tkBYb7QEkDJjTXbgDpy
	8lEG1nEJgA+Eng3qSa1XBNi4xaa29vyBYN0eSR0ixxVdz0+jmFHxNRNFrKCU=
X-Google-Smtp-Source: AGHT+IEGOePtXL0eudR5Pwqxhf5w613K1ZKRlie2QD1JZdsWORnIyr1q6XRLgOGqsyCfLDksblwfcA==
X-Received: by 2002:a05:6000:40c7:b0:3ea:63d:44a8 with SMTP id ffacd0b85a97d-405d090c6f8mr2553939f8f.15.1758635282691;
        Tue, 23 Sep 2025 06:48:02 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3f9c62d083esm12082311f8f.32.2025.09.23.06.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:48:02 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 06/17] net/mlx4: Remove jumbo_remove step from TX path
Date: Tue, 23 Sep 2025 16:47:31 +0300
Message-ID: <20250923134742.1399800-7-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

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
2.50.1


