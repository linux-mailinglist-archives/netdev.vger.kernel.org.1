Return-Path: <netdev+bounces-225426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5910FB93980
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A365481025
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3AC2FFFB2;
	Mon, 22 Sep 2025 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt7l7Jg7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B9302CC0
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584045; cv=none; b=gA2fVCcWtJgzD3c+E2mk3iS3s+aGQlo358vEXY5G75G2xuRws68mGRhn16m+74qxgii5+5gFlHYsJnQWftFVeaLi/QOrt3p5S2MDGjPaNiHQJ2TbCkjRZ+D2HMbfiNKwxHltmowjczId62SdHran60Bvxj9Z361cw0NbIO+hf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584045; c=relaxed/simple;
	bh=CvB7wAHfgdBul3PQ6i0ELroLROtA5DthQR3Ag7xVOvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAFDU50W3nGnkuMNyEPxIrCaE8brs/N0OHMlxn7cu8huiL8+1BmAMtgGeCg/DHKyrYmimytEmJ3cgrOjiN1mUcGQjwAqrxkjb2XMxKI6KK9+NkLuiaYRZ0k9wOlooz4r+ophMKvehTwqrjjnZf6YYiDU4C2dZUD6XVO/ptogsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dt7l7Jg7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77ee6e252e5so3152421b3a.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758584043; x=1759188843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wWAVfIussNCxUuvbxqrgV61kFlD4I6iuv1vcANKXfE=;
        b=dt7l7Jg7HqW5EuBVpVJRmhPlb85eGJnVnQwBlDbbepB3LqPB+8fQlVSX7uXt1iWzzx
         DdrKoHfXDgfPVyakgUljV4/dQ/0IeGn/pMG/bpytNfiUP0LGZJAMeCBuUYFGUQx4JvRH
         k/JrfJgRbvEzvZ+MHzLHt1fL2HVYl98JnnBZqb2217/wIOqpJwWlLXU6QpC95CPUHmH6
         KlG7LVShsiqh5n+0EzeVOZN7YiZ3CKCZvpTF8hKuOhyw27tfcfKDUAIvMBKalSRLu/lu
         BRZm+aHWn+/HtovkupC1e1ASaMEo68UP3yhd32soNZkG0wyyDkGashyA7VLGndBqaZgq
         q25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584043; x=1759188843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wWAVfIussNCxUuvbxqrgV61kFlD4I6iuv1vcANKXfE=;
        b=vM3kTl929kEn/haeZw8AXYn+u94W59uKlkoaCC12FroiWUw7G8qrDBtk7tp0Q0j10E
         Oe7rL5lCh5EKK3Oiy76vgilRDzFTg0gHONkNsRusAHHUQw4jOmD8F2y5mp/dwV9BG7mL
         qugHQVxnhp5HSIsamR2UMeCo4Jfa06j7ry0OPBNhzT0fl9K6wM5zR0e5Phx0Ia7BbKFv
         LxgqrwpnwiGAvanpfua58z0ojW/jNidA3BsqmHBbS5VXQXwrBxeCyCv4iiMNw+tOSBWJ
         r9C1/yNS0Hlg9qZiGg5u800QRQC0f5BHl9NHV6d7cVjz7dWs0uZK5ngCOl08OoNM+bIB
         vWug==
X-Gm-Message-State: AOJu0YwMYcDHUryUAMV1KBh870KoQWlVlmXF5mD9/+o5aDCHjzkybPGV
	ZOB99CDTvcknZJDpSZV8nsr9E6H+X/fHGXjjY1Ir9FbPpCWtlJa5dBvR
X-Gm-Gg: ASbGncuBnhJxJxTe6xLFnJNi4hFno3a/3X5lwLFgYhnXIZKw/XMOl568lkogtljtp2X
	fGuOnDtLTbC6meoiic1l2hrmHJEuYV8k/dkeUbbQX7yTdV/N2hbDUDlBMQeB0QpyHjuyzcZ4wCu
	R1SPLYCFgh3JijgQSsWfTlAovFB8wSNHJTUBpX6HOqrPRlktDwDzdcXpPeZxRpc9aoFLTHO3Zer
	x8FT5xfH8NP2qm2R8GpSpcXQlDcIAFATBNrKyQaJecq8a1x+WnrEzc/lE4SCxUovWQKjrKPE5oP
	9IO+yZLAXGLz+FQH7Ht7bYBrjQ5vnOlIdgZ5yxMS/mOUPZW5qHRk3kZwIj/vPsS39hbinuIqJoc
	JyS4XcxriUVyD
X-Google-Smtp-Source: AGHT+IE/eyo0JlUPSZyJvi1ko3Bies00TZjmSQwidW85KrZRfQB+rl2jl4h3uE8hV44UgYbgvPHi5g==
X-Received: by 2002:a05:6a00:1790:b0:776:1de0:4617 with SMTP id d2e1a72fcca58-77f538b5d05mr620784b3a.11.1758584042546;
        Mon, 22 Sep 2025 16:34:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2fdfbffesm5076728b3a.73.2025.09.22.16.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:34:02 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 5/8] bpf: Make variables in bpf_prog_test_run_xdp less confusing
Date: Mon, 22 Sep 2025 16:33:53 -0700
Message-ID: <20250922233356.3356453-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922233356.3356453-1-ameryhung@gmail.com>
References: <20250922233356.3356453-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the variable naming in bpf_prog_test_run_xdp() to make the
overall logic less confusing. As different modes were added to the
function over the time, some variables got overloaded, making
it hard to understand and changing the code becomes error-prone.

Replace "size" with "linear_sz" where it refers to the size of metadata
and data. If "size" refers to input data size, use test.data_size_in
directly.

Replace "max_data_sz" with "max_linear_sz" to better reflect the fact
that it is the maximum size of metadata and data (i.e., linear_sz). Also,
xdp_rxq.frags_size is always PAGE_SIZE, so just set it directly instead
of subtracting headroom and tailroom and adding them back.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/bpf/test_run.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4a862d605386..2a0af50f177e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1207,9 +1207,9 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 {
 	bool do_live = (kattr->test.flags & BPF_F_TEST_XDP_LIVE_FRAMES);
 	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	u32 retval = 0, duration, max_linear_sz, size;
+	u32 linear_sz = kattr->test.data_size_in;
 	u32 batch_size = kattr->test.batch_size;
-	u32 retval = 0, duration, max_data_sz;
-	u32 size = kattr->test.data_size_in;
 	u32 headroom = XDP_PACKET_HEADROOM;
 	u32 repeat = kattr->test.repeat;
 	struct netdev_rx_queue *rxqueue;
@@ -1246,7 +1246,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	if (ctx) {
 		/* There can't be user provided data before the meta data */
-		if (ctx->data_meta || ctx->data_end != size ||
+		if (ctx->data_meta || ctx->data_end != kattr->test.data_size_in ||
 		    ctx->data > ctx->data_end ||
 		    unlikely(xdp_metalen_invalid(ctx->data)) ||
 		    (do_live && (kattr->test.data_out || kattr->test.ctx_out)))
@@ -1255,30 +1255,30 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		headroom -= ctx->data;
 	}
 
-	max_data_sz = PAGE_SIZE - headroom - tailroom;
-	if (size > max_data_sz) {
-		/* disallow live data mode for jumbo frames */
-		if (do_live)
-			goto free_ctx;
-		size = max_data_sz;
-	}
+	max_linear_sz = PAGE_SIZE - headroom - tailroom;
+	linear_sz = min_t(u32, linear_sz, max_linear_sz);
+
+	/* disallow live data mode for jumbo frames */
+	if (do_live && kattr->test.data_size_in > linear_sz)
+		goto free_ctx;
 
-	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom);
+	data = bpf_test_init(kattr, linear_sz, max_linear_sz, headroom, tailroom);
 	if (IS_ERR(data)) {
 		ret = PTR_ERR(data);
 		goto free_ctx;
 	}
 
 	rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
-	rxqueue->xdp_rxq.frag_size = headroom + max_data_sz + tailroom;
+	rxqueue->xdp_rxq.frag_size = PAGE_SIZE;
 	xdp_init_buff(&xdp, rxqueue->xdp_rxq.frag_size, &rxqueue->xdp_rxq);
-	xdp_prepare_buff(&xdp, data, headroom, size, true);
+	xdp_prepare_buff(&xdp, data, headroom, linear_sz, true);
 	sinfo = xdp_get_shared_info_from_buff(&xdp);
 
 	ret = xdp_convert_md_to_buff(ctx, &xdp);
 	if (ret)
 		goto free_data;
 
+	size = linear_sz;
 	if (unlikely(kattr->test.data_size_in > size)) {
 		void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
 
-- 
2.47.3


