Return-Path: <netdev+bounces-223241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC2B587CA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9659616A963
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95062DAFC7;
	Mon, 15 Sep 2025 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS8XHuwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260EF2D23B6
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976486; cv=none; b=c796G52z9sImfD8FA17wSt4viUc5uSGp6+Q+mR9dIu6+C3IJjyVyHGV7905Rk6RxK5o3fZaHHg8/+NoOjZNKPHJtTWOyGmVqnDRKU818TeVwlIozef9D9kn9a0BY9+esh5Qjz5aph/JjOdcH6CTMB5oZNlJcjVthC0ulEbXj6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976486; c=relaxed/simple;
	bh=PqADVuytLCSFixjsgre0NuqnLXWbEqGLC5ZW3nvlK6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6eca7ry6HOSK2DW4Om4gZ3BhSE15nYCuz1u4/oMkbLzRr4g8LGkEOdLZ9XFN5JiV7E0d1ZOzHNuf7hTCKdyXq5yLLGmXGai15DQjmu22zILCRxU0IHnCXF9710PvCNQmvhtoa0aD1iujnwefveAPazSqT3+Kgixu2PfW3QuTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS8XHuwQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5229007f31so3185645a12.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757976484; x=1758581284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZATemqB7xyfzlXpuzPYv9jqgsTKcWFN1RS3zoew7LIs=;
        b=GS8XHuwQ6N4NLPnoI3FiTlhiGiwf+yYtcHyq5LNtGpQr/Hmdtn5Fr9z7qze0mlGP4b
         4K3JCisOc0VAWe0V1/kSpr9uYpn1pGyn589hOattW+o/4KrPNPjzj4MGUFqho/hL3C5Z
         R63OAy85ZcAEtXSygDxEisHAncLIdf6A6LLm+vg9kZWnTedfHeJYO8NKwDsAyncdg/99
         uuV8ukl0Wdno39t2d+BTXKQjVR1eOHHmNE/C8WOtf8n2tiLl1X9bD1a5PUtqOM05vlYu
         i70xTyiandZqZj7nzCA37fRpC3GCOAcHIaTuMuogGz8JEFyP7jQygjWQdhWXnLMzMl0o
         yzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976484; x=1758581284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZATemqB7xyfzlXpuzPYv9jqgsTKcWFN1RS3zoew7LIs=;
        b=GeOsyIC8WAPGgLVAr5W3N8EKraWojDpBhFhNu7XpnStsaAwYJQ3nGl+Lov4+LBvMtH
         dyZtGnk32rVF7aZmKuj5A6BgJQcPZq4jOPrr8B+SCea0Tn+yAEx4Sb3eVpMXcEBmQNlZ
         QRboK5/s7QLL+rhl5U6Y5cfWBCk5KZJPg3hTo2HQCJRT6Uulk2s5pExwSflccIxL/ISb
         Iroh3cO4ruSsPcgWRwhULHR22QhnnVd5lerf+EZq5UVQhDzzOcqpavb3u0YKSmp5qqzB
         Ikr3+1T+VkrN6dKN0WUoZ1+6CWrdfPwGy7b2UV9ae/V/MWs0zRrawmmQEgoLBf1Mn97h
         V4xA==
X-Gm-Message-State: AOJu0YwB3rpWrL1isUE1sdx+VOEAtMq0OzBEo0I7CRjp3RZgCi8Gf8jl
	u6rWJ1/r1ZRGLEqTSCVgXqmtd+etm0MG2tdPPGtO78rE9AaYDaw/IhvP
X-Gm-Gg: ASbGnct5kYV4a/hKeJdw0raX//8LKbLd70eINkijpBh2dUrRV/4hlvAV27VzgZX0GPk
	4wpzj2ZIYZ1O/yxaUlHNWlADbFe2ifSW/Sj5/EU8GQg9SevPvrnj/wAjnPsVfEHHAae9zkkwwNi
	ybOkHnS+WK6mrhmwjygbI0CLeuDZaea4t9P/g/94GjJkZRxzp7sbfVrBm8Ggl/8kZatBUDlP/hf
	h/axrQOZifUj/+5pHs1jo1ocbo5KPC7dgUNJVhBFYGqT31L6dZ4tL/zb51W0MYToFJ7F+GUiuxc
	JKqtU4Jprxylhz41NVI0hH5RB0930tFLAZMfvuVC6LpPU+DpFPC3dYoVSivGuj+c3Ye65Upf7qw
	MjelTOOgl9dkEORtfgg53yNij
X-Google-Smtp-Source: AGHT+IFXN3/ckPvLsJL6xQ4zrXgiAV8E2rtnlNd8kU63QP/WEhESIpkUBgDk5raYysiF+uUTf/U6FA==
X-Received: by 2002:a17:902:dac2:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-25d242f2f21mr190289945ad.11.1757976484358;
        Mon, 15 Sep 2025 15:48:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a7a0sm142004205ad.89.2025.09.15.15.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:48:04 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/6] bpf: Support pulling non-linear xdp data
Date: Mon, 15 Sep 2025 15:47:57 -0700
Message-ID: <20250915224801.2961360-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915224801.2961360-1-ameryhung@gmail.com>
References: <20250915224801.2961360-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kfunc, bpf_xdp_pull_data(), to support pulling data from xdp
fragments. Similar to bpf_skb_pull_data(), bpf_xdp_pull_data() makes
the first len bytes of data directly readable and writable in bpf
programs. If the "len" argument is larger than the linear data size,
data in fragments will be copied to the linear data area when there
is enough room. Specifically, the kfunc will try to use the tailroom
first. When the tailroom is not enough, metadata and data will be
shifted down to make room for pulling data.

A use case of the kfunc is to decapsulate headers residing in xdp
fragments. It is possible for a NIC driver to place headers in xdp
fragments. To keep using direct packet access for parsing and
decapsulating headers, users can pull headers into the linear data
area by calling bpf_xdp_pull_data() and then pop the header with
bpf_xdp_adjust_head().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/filter.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0b82cb348ce0..3a24c4db46f9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12212,6 +12212,100 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 	return 0;
 }
 
+/**
+ * bpf_xdp_pull_data() - Pull in non-linear xdp data.
+ * @x: &xdp_md associated with the XDP buffer
+ * @len: length of data to be made directly accessible in the linear part
+ *
+ * Pull in non-linear data in case the XDP buffer associated with @x is
+ * non-linear and not all @len are in the linear data area.
+ *
+ * Direct packet access allows reading and writing linear XDP data through
+ * packet pointers (i.e., &xdp_md->data + offsets). The amount of data which
+ * ends up in the linear part of the xdp_buff depends on the NIC and its
+ * configuration. When an eBPF program wants to directly access headers that
+ * may be in the non-linear area, call this kfunc to make sure the data is
+ * available in the linear area. Alternatively, use dynptr or
+ * bpf_xdp_{load,store}_bytes() to access data without pulling.
+ *
+ * This kfunc can also be used with bpf_xdp_adjust_head() to decapsulate
+ * headers in the non-linear data area.
+ *
+ * A call to this kfunc may reduce headroom. If there is not enough tailroom
+ * in the linear data area, metadata and data will be shifted down.
+ *
+ * A call to this kfunc is susceptible to change the buffer geometry.
+ * Therefore, at load time, all checks on pointers previously done by the
+ * verifier are invalidated and must be performed again, if the kfunc is used
+ * in combination with direct packet access.
+ *
+ * Return:
+ * * %0         - success
+ * * %-EINVAL   - invalid len
+ */
+__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)x;
+	int i, delta, shift, headroom, tailroom, n_frags_free = 0, len_free = 0;
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	void *data_hard_end = xdp_data_hard_end(xdp);
+	int data_len = xdp->data_end - xdp->data;
+	void *start, *new_end = xdp->data + len;
+
+	if (len <= data_len)
+		return 0;
+
+	if (unlikely(len > xdp_get_buff_len(xdp)))
+		return -EINVAL;
+
+	start = xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->data_meta;
+
+	headroom = start - xdp->data_hard_start - sizeof(struct xdp_frame);
+	tailroom = data_hard_end - xdp->data_end;
+
+	delta = len - data_len;
+	if (unlikely(delta > tailroom + headroom))
+		return -EINVAL;
+
+	shift = delta - tailroom;
+	if (shift > 0) {
+		memmove(start - shift, start, xdp->data_end - start);
+
+		xdp->data_meta -= shift;
+		xdp->data -= shift;
+		xdp->data_end -= shift;
+
+		new_end = data_hard_end;
+	}
+
+	for (i = 0; i < sinfo->nr_frags && delta; i++) {
+		skb_frag_t *frag = &sinfo->frags[i];
+		u32 shrink = min_t(u32, delta, skb_frag_size(frag));
+
+		memcpy(xdp->data_end + len_free, skb_frag_address(frag), shrink);
+
+		len_free += shrink;
+		delta -= shrink;
+		if (bpf_xdp_shrink_data(xdp, frag, shrink, false))
+			n_frags_free++;
+	}
+
+	if (unlikely(n_frags_free)) {
+		memmove(sinfo->frags, sinfo->frags + n_frags_free,
+			(sinfo->nr_frags - n_frags_free) * sizeof(skb_frag_t));
+
+		sinfo->nr_frags -= n_frags_free;
+
+		if (!sinfo->nr_frags)
+			xdp_buff_clear_frags_flag(xdp);
+	}
+
+	sinfo->xdp_frags_size -= len_free;
+	xdp->data_end = new_end;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12239,6 +12333,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
+BTF_ID_FLAGS(func, bpf_xdp_pull_data)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
-- 
2.47.3


