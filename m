Return-Path: <netdev+bounces-211567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5435B1A25A
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB391886D10
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F01626E17F;
	Mon,  4 Aug 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ezPn1rfu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAE25D208
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311982; cv=none; b=ZcXcpGWZ60ZDltxSH5R1nZUyCIpPF8+tzTquSoCl1B5g5rKATA0e1kQMMx0txZofZddogO0cc8W9hwd9XJZgXa5zSuExZKKsh0IMpv8/JYVVi/hLwuMqPW6/ZLj+Q/dkuCpFG6mu97Wb31ddBD+FqAlQtyC5vL5iDUWqyoOXkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311982; c=relaxed/simple;
	bh=6Q0K1QIZOOFau5ZctzVpe7zO1m+/DOuCPLw8+uCeHKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GdAm86pljc3Zgls4Nf6VVtZqoSttkC/ZlK1uvk2lIsfTQQmsLf28JWM5JxIhmV2MpCW0QW9puN3y17cWaOSpILQEWI37MIWpLFnBqf2tWoHyapRiIFi4jFZG0tB6Pim84n/SfGKHyFtc/bPBy2WgFVmTmI941jb27UIZCLwAFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ezPn1rfu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so954814666b.3
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754311978; x=1754916778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZ04Y6i2iJ0+tBid0GHRu2U+46Amz8TcC4hTojaCtjc=;
        b=ezPn1rfusE15kRXCPQgdZR4sZPwxFgEb/mLrWDa+7kRJrIVDIpYYsc/fuVT4omflEl
         T5GBhgM7sPMgweu6HdhPnH07E3DNXrxsWYD/xXLvR5i6wgAucpda7ltHsK6KspIYuayj
         SDPjgqO4g/IHtooiNQGA+c7ZdGWegDYcysSMKnIahwwqwDxYWCGXUVfpujoSKmvuJ9xu
         yN6L5ngXI27jsCmuvrvEbw4O6m9qoWEFptexqkBZzV4TBEOUJPmKhZn4i6IKjz9CgIbK
         uon4HjQOGM0aAUd4Mv0xE65vaPmRVqAzRCGf15Xf5Advb++kEfs6v9KqT7aaLOAtVfCY
         XL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311978; x=1754916778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZ04Y6i2iJ0+tBid0GHRu2U+46Amz8TcC4hTojaCtjc=;
        b=EbpP4xeH1RlIp7irpUo2p/9IIcebMJt5GluJiAan1hMR4H3bL3CvWeYiNDB8fZmIcd
         hralQLFlswNOApFyJi2g0N8qt0YsA89MTlWnIm8rb7Qfm4tSiPAsQ942rpvBx6/ylqNU
         t9XAvGzGW8lM0gx30YjdjHlDzCTo0vJgiR/9HQWcJifS8rP7r3x8RD3G4rDicj2reD7W
         H1qQX98zntlhNhdiswDncShaVWnCoD53BGu+woUqwHLtk8PfJ9KPTfIlY+SN5u1BQrwS
         28D58nJS+gGf9EEBALoZvkFV91FOxrdMksRL3CWKM7/ZG97D+fT25e/5ZMLvLP1Dlp5u
         +sug==
X-Forwarded-Encrypted: i=1; AJvYcCVhffzZ3LRIJxssvVIt1UVlb/RoJE0KEXK4IGyQOwar746huUwyY1AgW8eRXXnRH9YuF2ckG1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYdWtOHs8aw5jsV3Sf1Tjxa9XACAco6uCi01RgE0RIdwT2viqG
	L/RCof8o/C4XLCMtdQ5iu/iSfEvmYqdx+lBWSND8klpg31jc03TOblKdLR+mSggP020=
X-Gm-Gg: ASbGncvX68fCdPdbkMpawRjaKp3HiOZGz80F6ldkfUVppDYrWUagzGe5qVjChXWlyXl
	8iiOKB1WFejgaNF+7AaL8AYOX4V2pNoo6CU7T+GXj/sJw7zkeLa29BBfUpU1z13NzexPcahh2Ea
	/hPKnW4oCSExjkZYPCRrngdDp5r/uDPrDlcz+tq0epsAgHqZasYlbf2/NQwV+rpv3QS6rkBldZx
	uaX3lbBKR3SPRZ/LYBXU2uOdzn0y5/WKp1crD5xqKxw8AoNGMBvYfRPtdVud5VJTQzDCU5hAPM4
	wJOYtmsaU86S0iE1Mc+3KjB7l+yDNjMUR+T3CHttC8DUYW/TqP60Q8peXzhQsWrPEIK/vrOmeJD
	kl7Bg+TvlPB279oU=
X-Google-Smtp-Source: AGHT+IEHsLLAZkDTwkF+goTdcHqCzB7XwO0pmxoZsLyOz1k+7kUGeiTFtGokuj/FuISHTm+WqMAM5A==
X-Received: by 2002:a17:907:9691:b0:ae3:b2b7:7f2f with SMTP id a640c23a62f3a-af9401af464mr974935166b.40.1754311976284;
        Mon, 04 Aug 2025 05:52:56 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3375sm729934166b.41.2025.08.04.05.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:52:55 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 04 Aug 2025 14:52:31 +0200
Subject: [PATCH bpf-next v6 8/9] selftests/bpf: Cover read/write to skb
 metadata at an offset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-skb-metadata-thru-dynptr-v6-8-05da400bfa4b@cloudflare.com>
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
In-Reply-To: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Exercise r/w access to skb metadata through an offset-adjusted dynptr,
read/write helper with an offset argument, and a slice starting at an
offset.

Also check for the expected errors when the offset is out of bounds.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          |  10 ++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 119 +++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 79c4c58276e6..24a7b4b7fdb6 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -375,6 +375,16 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.ing_cls_dynptr_slice_rdwr,
 			    skel->progs.ing_cls_dynptr_slice,
 			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_offset"))
+		test_tuntap(skel->progs.ing_xdp_zalloc_meta,
+			    skel->progs.ing_cls_dynptr_offset_wr,
+			    skel->progs.ing_cls_dynptr_offset_rd,
+			    skel->maps.test_result);
+	if (test__start_subtest("dynptr_offset_oob"))
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.ing_cls_dynptr_offset_oob,
+			    skel->progs.ing_cls,
+			    skel->maps.test_result);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index e7879860f403..ee3d8adf5e9c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1,5 +1,6 @@
 #include <stdbool.h>
 #include <linux/bpf.h>
+#include <linux/errno.h>
 #include <linux/if_ether.h>
 #include <linux/pkt_cls.h>
 
@@ -122,6 +123,124 @@ int ing_cls_dynptr_slice_rdwr(struct __sk_buff *ctx)
 	return TC_ACT_UNSPEC; /* pass */
 }
 
+/* Read skb metadata in chunks from various offsets in different ways. */
+SEC("tc")
+int ing_cls_dynptr_offset_rd(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	const __u32 chunk_len = META_SIZE / 4;
+	const __u32 zero = 0;
+	__u8 *dst, *src;
+
+	dst = bpf_map_lookup_elem(&test_result, &zero);
+	if (!dst)
+		return TC_ACT_SHOT;
+
+	/* 1. Regular read */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	bpf_dynptr_read(dst, chunk_len, &meta, 0, 0);
+	dst += chunk_len;
+
+	/* 2. Read from an offset-adjusted dynptr */
+	bpf_dynptr_adjust(&meta, chunk_len, bpf_dynptr_size(&meta));
+	bpf_dynptr_read(dst, chunk_len, &meta, 0, 0);
+	dst += chunk_len;
+
+	/* 3. Read at an offset */
+	bpf_dynptr_read(dst, chunk_len, &meta, chunk_len, 0);
+	dst += chunk_len;
+
+	/* 4. Read from a slice starting at an offset */
+	src = bpf_dynptr_slice(&meta, 2 * chunk_len, NULL, chunk_len);
+	if (!src)
+		return TC_ACT_SHOT;
+	__builtin_memcpy(dst, src, chunk_len);
+
+	return TC_ACT_SHOT;
+}
+
+/* Write skb metadata in chunks at various offsets in different ways. */
+SEC("tc")
+int ing_cls_dynptr_offset_wr(struct __sk_buff *ctx)
+{
+	const __u32 chunk_len = META_SIZE / 4;
+	__u8 payload[META_SIZE];
+	struct bpf_dynptr meta;
+	__u8 *dst, *src;
+
+	bpf_skb_load_bytes(ctx, sizeof(struct ethhdr), payload, sizeof(payload));
+	src = payload;
+
+	/* 1. Regular write */
+	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	bpf_dynptr_write(&meta, 0, src, chunk_len, 0);
+	src += chunk_len;
+
+	/* 2. Write to an offset-adjusted dynptr */
+	bpf_dynptr_adjust(&meta, chunk_len, bpf_dynptr_size(&meta));
+	bpf_dynptr_write(&meta, 0, src, chunk_len, 0);
+	src += chunk_len;
+
+	/* 3. Write at an offset */
+	bpf_dynptr_write(&meta, chunk_len, src, chunk_len, 0);
+	src += chunk_len;
+
+	/* 4. Write to a slice starting at an offset */
+	dst = bpf_dynptr_slice_rdwr(&meta, 2 * chunk_len, NULL, chunk_len);
+	if (!dst)
+		return TC_ACT_SHOT;
+	__builtin_memcpy(dst, src, chunk_len);
+
+	return TC_ACT_UNSPEC; /* pass */
+}
+
+/* Pass an OOB offset to dynptr read, write, adjust, slice. */
+SEC("tc")
+int ing_cls_dynptr_offset_oob(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	__u8 md, *p;
+	int err;
+
+	err = bpf_dynptr_from_skb_meta(ctx, 0, &meta);
+	if (err)
+		goto fail;
+
+	/* read offset OOB */
+	err = bpf_dynptr_read(&md, sizeof(md), &meta, META_SIZE, 0);
+	if (err != -E2BIG)
+		goto fail;
+
+	/* write offset OOB */
+	err = bpf_dynptr_write(&meta, META_SIZE, &md, sizeof(md), 0);
+	if (err != -E2BIG)
+		goto fail;
+
+	/* adjust end offset OOB */
+	err = bpf_dynptr_adjust(&meta, 0, META_SIZE + 1);
+	if (err != -ERANGE)
+		goto fail;
+
+	/* adjust start offset OOB */
+	err = bpf_dynptr_adjust(&meta, META_SIZE + 1, META_SIZE + 1);
+	if (err != -ERANGE)
+		goto fail;
+
+	/* slice offset OOB */
+	p = bpf_dynptr_slice(&meta, META_SIZE, NULL, sizeof(*p));
+	if (p)
+		goto fail;
+
+	/* slice rdwr offset OOB */
+	p = bpf_dynptr_slice_rdwr(&meta, META_SIZE, NULL, sizeof(*p));
+	if (p)
+		goto fail;
+
+	return TC_ACT_UNSPEC;
+fail:
+	return TC_ACT_SHOT;
+}
+
 /* Reserve and clear space for metadata but don't populate it */
 SEC("xdp")
 int ing_xdp_zalloc_meta(struct xdp_md *ctx)

-- 
2.43.0


