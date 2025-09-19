Return-Path: <netdev+bounces-224921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1F1B8B9B8
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 01:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9890A1CC2A95
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 23:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822AD2D837B;
	Fri, 19 Sep 2025 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEWlBe0x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D42D63E5
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323398; cv=none; b=HifizBEtS5RpdPzIvbNlaRpDbYf6Zkge4FadkZm3WS09nS3yN8bpG9E5SygDG1oSldyWokPOD9jbwReytqxGa6eKSzL0NcjFRe9vwwav87xTUoEvbd0emPJPQb5VY2GCoIQP20WYpayqwhzDv72xqijIMnNIldubjhV8zFDhL9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323398; c=relaxed/simple;
	bh=+yQ2t/9d9UA/mVKr5d0OjMVjTE9IXyYN7Q4NbTHwiPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohpAXsBKtr5/L3DpI+dBTjACpSH83GEJWoZD1cKgc8F+iAUINvfeNQiINPzWVZBmrOhQM2niRV5rVeQaL1HHzBUo2RLkiHK01st8ku3OKbtVKrLNO5YKL/8MiUWJlGHNDB0Y3Rg+qK6HGegDmj7yrmZ1fP68a8ATD7esOtzQnpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEWlBe0x; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5241e51764so2008309a12.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 16:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323396; x=1758928196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLUY+Ej39kKeF/fRLSX0Y2NuiiPlaB3PPnfSYtai7d0=;
        b=gEWlBe0xJIPv7yPMtG5teiinCLkE9RAvsAMtaFm0cVQWgkqVtepPWPWvlH8I9occUU
         FQIKgXIFigHh0KMepXajahxzYgpQhdwyUQ95KFnlK+8hdnUokrZDpABAtX4WHrCxo491
         lX0BlUSeHHaLgapFd/VGW8ZzQxVpE+8K79hludr4/6/PIwed9M4A8glVwAHU9XfkWtHA
         gblRO6Hhpjd739N/NJo36QRO9BbT6H0qsLPSlLBCDOF/OjTousReTYe+BCG/zmGSOQEn
         qyZH27rq/l+OkDORRXpXJErC/KOroglI02Ryhym7FohLLfd/RLaz82Iw4xbRGyJqLgKo
         kAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323396; x=1758928196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLUY+Ej39kKeF/fRLSX0Y2NuiiPlaB3PPnfSYtai7d0=;
        b=XGUucljpIpsfTuRYcv8RskuSBbNEGv4Tb+io7shDmXPCA6o7RbmYslN3geqJ3RpyLg
         yDBBk3MK67sROywjC8MrfAbgTfrFq/QuV377ewhFI2S8DGnYY6HMKGrBkLRU7ghHlXHA
         Q0Nuz1I7DlOKtq6IAfrDD3+AjUtclrp5PUcTrXXR+8Fg6/ZykK9AKhPICEFO+OkhFMQq
         qy+S5utErn0soaF+ccANgYL8zdtJ4rf6eQGBokZ5tD5BlKm1v/M+XFi81A82g4lf0HV2
         NHYfVf17ceoHczXBldC40UiKNS5su0in6/UxFRjo6ymvBqPpcNXeQlNaxUaT8VChsZnt
         YVlw==
X-Gm-Message-State: AOJu0YzrdA9EM/239BHRf8O16mzID2rJG4JMsTy2+J8Q6aA9tkxFac4x
	kE1/OjoBbwcVRtUBwl0BPEEkDaYQHKa2+KuDx+cgOIkpXDKXqXatVdT/
X-Gm-Gg: ASbGnct15OkjOacKIre9O+qcu5pcXSLSkYfDGlTd3On98JJ7GyRzLeeA6VmdfifUhYm
	z0hfrt0FADZhAoX+PI5l2SRefxEAlCC/9UQL18dNUUm9ToRJZ8lcbLBjy6MeagSVz8RWIjwhJu4
	LmSYuqrDVR7gvSto10GAa/kZp4gU1NvKGflKo2SY/96ePIVVRkLYyCWcPKAF/aa7cLq2vnNXw9S
	HAn1iEvl4vx7J5lF3MmUqNAI6NHhhdYLPUFU2pjFivIBiGROrjodFD7DuWvOidGeI2Uk2fjwiJZ
	vLTaiBQUhd7OaSoysEpCQlF3tfcdnXJyljwdZoH4nVQtleVtgyUyTWgMw4kZr9WMRsG0R21qADd
	PgIsCYElkIUGO
X-Google-Smtp-Source: AGHT+IGBuXsl6R4V5EqnTgvZQms86QQWDY8uhGERn6CEwBzMSMvaPW84EnLBhdlTWy9eIun1MA+8Aw==
X-Received: by 2002:a17:903:3c70:b0:268:b8a:5a26 with SMTP id d9443c01a7336-269ba55fa7dmr71990615ad.54.1758323396077;
        Fri, 19 Sep 2025 16:09:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e2046788dsm14064825ad.72.2025.09.19.16.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:09:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 3/7] bpf: Support pulling non-linear xdp data
Date: Fri, 19 Sep 2025 16:09:48 -0700
Message-ID: <20250919230952.3628709-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919230952.3628709-1-ameryhung@gmail.com>
References: <20250919230952.3628709-1-ameryhung@gmail.com>
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

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/filter.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8cae575ad437..6c8a075a3016 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12214,6 +12214,98 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 	return 0;
 }
 
+/**
+ * bpf_xdp_pull_data() - Pull in non-linear xdp data.
+ * @x: &xdp_md associated with the XDP buffer
+ * @len: length of data to be made directly accessible in the linear part
+ *
+ * Pull in data in case the XDP buffer associated with @x is non-linear and
+ * not all @len are in the linear data area.
+ *
+ * Direct packet access allows reading and writing linear XDP data through
+ * packet pointers (i.e., &xdp_md->data + offsets). The amount of data which
+ * ends up in the linear part of the xdp_buff depends on the NIC and its
+ * configuration. When a frag-capable XDP program wants to directly access
+ * headers that may be in the non-linear area, call this kfunc to make sure
+ * the data is available in the linear area. Alternatively, use dynptr or
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
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	int i, delta, shift, headroom, tailroom, n_frags_free = 0;
+	void *data_hard_end = xdp_data_hard_end(xdp);
+	int data_len = xdp->data_end - xdp->data;
+	void *start;
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
+	}
+
+	for (i = 0; i < sinfo->nr_frags && delta; i++) {
+		skb_frag_t *frag = &sinfo->frags[i];
+		u32 shrink = min_t(u32, delta, skb_frag_size(frag));
+
+		memcpy(xdp->data_end, skb_frag_address(frag), shrink);
+
+		xdp->data_end += shrink;
+		sinfo->xdp_frags_size -= shrink;
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
+		if (!sinfo->nr_frags) {
+			xdp_buff_clear_frags_flag(xdp);
+			xdp_buff_clear_frag_pfmemalloc(xdp);
+		}
+	}
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12241,6 +12333,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
+BTF_ID_FLAGS(func, bpf_xdp_pull_data)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
-- 
2.47.3


