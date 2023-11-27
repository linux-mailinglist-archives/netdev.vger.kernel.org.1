Return-Path: <netdev+bounces-51431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D42857FA998
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 20:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3821DB20F1A
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 19:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18594595E;
	Mon, 27 Nov 2023 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GA3PC37b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE9C131
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 11:03:41 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cf904825c2so66842595ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 11:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111821; x=1701716621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xeLlbkCksJisb3y6jjL289ZDTds1CqtWZxwNSr9V8Pk=;
        b=GA3PC37bEFnVv1FMuugicFqye6zG4W7STtE1hPt2UxR/Hi+YXLGEQnNq1fL70t+b9j
         yiigqwtoo7Zrxp3ly6z4GMFibSwW497OEnBNEOSyoF3Zvp9upXqROvciKw0OPbvqIZJx
         ATZKdbR4M70n7CxGeH44Z5mk9s7JG6J9HLbu8B9rhuDXNyagv7MjOzLcQ5tvmjKTJxB7
         vKcvna5gGjhuwCH5ror1UBXtiMYf/gnHimHdTGtbf8y9P6FjmcQXHDD7z0R47NzF+zbg
         vdeXTtWEf1uN1C4pISW2hhg+P+4ubpAem0cojZY878q4qrN1BMj3SlnvMvtg9Xp6vo5M
         Q9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111821; x=1701716621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xeLlbkCksJisb3y6jjL289ZDTds1CqtWZxwNSr9V8Pk=;
        b=TubyXvNSgHxVEOqYnXJdh8wezyL6GgyPOLul8SacV1MzuvHKg0c9h4HFGI2blLVibS
         JpKqDDaF+ZwNzqgfLSjx2Y7RhlGWu3ECu3sD6Hu9mNgTipyd9qiXEkXpt7uf8MFq9hYw
         e6OI3TWiccZkIksNxIl8VObz44gQE4KYs4rVfprwaXv0cCgnTCr3oETrBJyq/cI01kWC
         d8RvtiDcbdj95AMkuh5WzV72dD1onUpImWZ0vsrODsQid57ycMxiNz8ZQAVZ7xTxpRxh
         CY+FwHtVKLFSW9NQPIp+XdlL5X2HgjWYQNdFvw/zHc6ik65pJIlRP4iFtYYidyWi1AmO
         s3Pw==
X-Gm-Message-State: AOJu0Yya94TjiV9d3fNkGJRC//+iyqYYZEHaj8SUBlU3GuCq+06A7Ww0
	/oMEwsjOuzomkvvJgmn0yGTs2iw=
X-Google-Smtp-Source: AGHT+IF6RNDkcP+Fi382qERYGP7LZKJ89O5uRYNHli3mJyFA9QcODvz5FyQmIFY35v4/oNc61SLKBxQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:1302:b0:1ce:1829:2df8 with SMTP id
 iy2-20020a170903130200b001ce18292df8mr2455154plb.12.1701111821379; Mon, 27
 Nov 2023 11:03:41 -0800 (PST)
Date: Mon, 27 Nov 2023 11:03:17 -0800
In-Reply-To: <20231127190319.1190813-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127190319.1190813-1-sdf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127190319.1190813-12-sdf@google.com>
Subject: [PATCH bpf-next v6 11/13] selftests/bpf: Add TX side to xdp_metadata
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

Request TX timestamp and make sure it's not empty.
Request TX checksum offload (SW-only) and make sure it's resolved
to the correct one.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 33 ++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 4439ba9392f8..33cdf88efa6b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -56,7 +56,8 @@ static int open_xsk(int ifindex, struct xsk *xsk)
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
-		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
+		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG | XDP_UMEM_TX_SW_CSUM,
+		.tx_metadata_len = sizeof(struct xsk_tx_metadata),
 	};
 	__u32 idx;
 	u64 addr;
@@ -138,6 +139,7 @@ static void ip_csum(struct iphdr *iph)
 
 static int generate_packet(struct xsk *xsk, __u16 dst_port)
 {
+	struct xsk_tx_metadata *meta;
 	struct xdp_desc *tx_desc;
 	struct udphdr *udph;
 	struct ethhdr *eth;
@@ -151,10 +153,14 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 		return -1;
 
 	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
-	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
+	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + sizeof(struct xsk_tx_metadata);
 	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
 	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
 
+	meta = data - sizeof(struct xsk_tx_metadata);
+	memset(meta, 0, sizeof(*meta));
+	meta->flags = XDP_TXMD_FLAGS_TIMESTAMP;
+
 	eth = data;
 	iph = (void *)(eth + 1);
 	udph = (void *)(iph + 1);
@@ -178,11 +184,17 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	udph->source = htons(AF_XDP_SOURCE_PORT);
 	udph->dest = htons(dst_port);
 	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
-	udph->check = 0;
+	udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
+					 ntohs(udph->len), IPPROTO_UDP, 0);
 
 	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
 
+	meta->flags |= XDP_TXMD_FLAGS_CHECKSUM;
+	meta->request.csum_start = sizeof(*eth) + sizeof(*iph);
+	meta->request.csum_offset = offsetof(struct udphdr, check);
+
 	tx_desc->len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
+	tx_desc->options |= XDP_TX_METADATA;
 	xsk_ring_prod__submit(&xsk->tx, 1);
 
 	ret = sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
@@ -194,13 +206,21 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 
 static void complete_tx(struct xsk *xsk)
 {
-	__u32 idx;
+	struct xsk_tx_metadata *meta;
 	__u64 addr;
+	void *data;
+	__u32 idx;
 
 	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
 		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
 
 		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
+
+		data = xsk_umem__get_data(xsk->umem_area, addr);
+		meta = data - sizeof(struct xsk_tx_metadata);
+
+		ASSERT_NEQ(meta->completion.tx_timestamp, 0, "tx_timestamp");
+
 		xsk_ring_cons__release(&xsk->comp, 1);
 	}
 }
@@ -221,6 +241,7 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	const struct xdp_desc *rx_desc;
 	struct pollfd fds = {};
 	struct xdp_meta *meta;
+	struct udphdr *udph;
 	struct ethhdr *eth;
 	struct iphdr *iph;
 	__u64 comp_addr;
@@ -257,6 +278,7 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	ASSERT_EQ(eth->h_proto, htons(ETH_P_IP), "eth->h_proto");
 	iph = (void *)(eth + 1);
 	ASSERT_EQ((int)iph->version, 4, "iph->version");
+	udph = (void *)(iph + 1);
 
 	/* custom metadata */
 
@@ -270,6 +292,9 @@ static int verify_xsk_metadata(struct xsk *xsk)
 
 	ASSERT_EQ(meta->rx_hash_type, 0, "rx_hash_type");
 
+	/* checksum offload */
+	ASSERT_EQ(udph->check, htons(0x721c), "csum");
+
 	xsk_ring_cons__release(&xsk->rx, 1);
 	refill_rx(xsk, comp_addr);
 
-- 
2.43.0.rc1.413.gea7ed67945-goog


