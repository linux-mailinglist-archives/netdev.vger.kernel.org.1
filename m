Return-Path: <netdev+bounces-209460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AF8B0F978
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A69B165004
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D57246773;
	Wed, 23 Jul 2025 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bhVFvens"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71819242D87
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292226; cv=none; b=S/Rz38YvoebQY4fdYxJgNRX6mjic4ts/y3CkU8OxlKmPm2Be5XRVZhuH6vhAemvXWtAGWEMVVoIUxBpi5CPIpZYwUX4b/gbydCZC8+Hg5wnBgCK42RwrJM/JmqBBq3Xf1Rm2o4DBrICxWV5gjEgq00jn9Zd1a49HdU5/A3RSYWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292226; c=relaxed/simple;
	bh=ZdWC8dc9bcf9bebUOUUL6dsSV4GwxjE/zf3sMRTdS8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pn/WnFlXeJ1Dbjz7v52B/RPs2oxBMtncw3mTnq/RBLVbnSRtZV5/+Y1U37EWbRtnDn/++8MOIjMvkM2L8EiFMx6XmrCWlpxZjfiuQ/+8m8DSqBkjnHJduxotELmOXnmSWk62qp7YMj6TLcvzyyfEOBFGCfhKueouL7IX2R8uPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bhVFvens; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so223122a12.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753292223; x=1753897023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pB8VN9MFwmxNix8cyZZQ7rAZN5StauQsln4/SihEow=;
        b=bhVFvens+T2RElXV02/pA/Ix3N7YkjKdcgaAjAbyurMoLXP2tdYPAZfQYAqlcJhVva
         iOXX+FG7RYYnBZL6Bc5Cm/iiD+AdLseOxizN/hCW7ogGXEN2i27orPtNq3MBwGremrcA
         0ClFqUo0eHQlCiGIDBuHvJPiZgDfB5XOfWfQx8SjXQpzeqfy4XFY4sd4wp360N45APVe
         OjvP4t+8C8kzr9mfSGg0sedTA8pak6PbycJia/ylMEtgQ5IEEFnty66YtaE6hRGi66vf
         cf+PR/OiF6WI/RruQu+Djga2NtOxQdoY7Nzl3j6UAwzFcNN2rG5yN2/rsazM6wPw3AGy
         8x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292223; x=1753897023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pB8VN9MFwmxNix8cyZZQ7rAZN5StauQsln4/SihEow=;
        b=CxKZLqjUuLYxguT5ZO6J2fX13wyQqVB/sUrmHaPJ6jwtts0lLXtnNq83F0T7052+v9
         eDIEp08me7jI28sajSj7M0V60R1JH/9u79Vr4XtKthzX9GfpnhvJflbogXTGi5JixTEO
         bJf5HPUcbtJuLWDKZPjDt+yvXoXiL1J23N139wVSPr+nGhB51yiDSqCF+yZ9otZiA+jA
         MLpNROeVdiDOQygv2ogO4Pdn7eL1oyT3WrsoSeskbBJjBcu6qWktlebYFFL/KlWOBeSp
         KqRI9EgNyw+QQrNy7G2XwyrGtu2riOv8VRI0Iajw8piimU4qbt8qM7RoId4FwcYeNBrP
         qoVA==
X-Forwarded-Encrypted: i=1; AJvYcCVm9G0sLj/aqoz7Qjday6+CBbUes1OepoUywuz8l8yCqo+YhTF7764V/JqenjLVm7fTR7IMC5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxribA+LU5M+/S66XNb3aLn3O/nUK5yCBr//V2237meBPBciwh0
	53p8nifwUJU2vwJS+7sNlJWff2sMep32uDj91iCUYOocE/C3aIolQ/iv8u8s1iH1avA=
X-Gm-Gg: ASbGncv1UKwNaaEHwOKwEU41a0K9hDaA0pZsscACwo+yP4DFg/PDLDN2o2vhzDvhC6c
	ZuCQ3DIfU2N5jZYZ1rJUHDrh4qy8kUrGLCmwc5ADCLYYqRIwfX1BlQOOiOwSsQ1I2tLfRs5klm/
	Cbgqvq7NCMwR6nJKw55Gx46NsU361U48D3vAInCmUJUgUsWSy+aYPnWbPGAt/btdp31jLRtODXc
	HR0SWJf7FzjJv34Ad4+CA3hoblqVxoSCo9R4lYQjkirKyWZ7aOTmVYNAc0uW5DuKvzSPtPEdcnV
	JV73Bm7iHkQWEx0cmIfCtEuf5DYKt/gmLKqK+0cfTsqOBKPiBcZZL41W4vAxrmL6d7aXLMyv8H3
	hJKU+5HSSI34VE/SZ2e3H1Kbw+2PxJn2WpJ4m79DQqd9QrWbeG28CSfZVNl9b/WWKi9f+hPZ3FH
	CcFrDIjg==
X-Google-Smtp-Source: AGHT+IGai89R6Ps0k0EIfh0snFvrHiImQej3jQTU2YfE1WOBBREIaHq0IVK1tOMChMgVom+Idr6t+A==
X-Received: by 2002:a05:6402:34c4:b0:612:dc41:c622 with SMTP id 4fb4d7f45d1cf-6149b42ee6fmr3572877a12.9.1753292222524;
        Wed, 23 Jul 2025 10:37:02 -0700 (PDT)
Received: from cloudflare.com (79.184.149.187.ipv4.supernova.orange.pl. [79.184.149.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f36f6bsm8809654a12.27.2025.07.23.10.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:37:01 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 23 Jul 2025 19:36:53 +0200
Subject: [PATCH bpf-next v4 8/8] selftests/bpf: Cover read/write to skb
 metadata at an offset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-skb-metadata-thru-dynptr-v4-8-a0fed48bcd37@cloudflare.com>
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
In-Reply-To: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
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


