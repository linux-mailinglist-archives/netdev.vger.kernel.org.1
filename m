Return-Path: <netdev+bounces-217247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9951CB3804D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630177B5DDB
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D2734A301;
	Wed, 27 Aug 2025 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JrwxX8bL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9710434A328
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291733; cv=none; b=c1Ptz1ILWz0iB5PH9YsXpD0iW9kWG/MpgZrbalXPISm6Xt4AzQU6a0+BsWwUhOH5yTvSyyITswmjrZ/Gy0+ClXu/RCQBNUBMpqXytZQd3eaegIsRSLtI8XgKq8DXQB7OttoRKIAZwWCgxQI8u3L+On9yW41aOwXC5qBzx/g4+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291733; c=relaxed/simple;
	bh=hUoasQnCGasuL2bHEECdPbjoocMmyF4EX7JMYC3YOH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OEiaTEy2DbitpyOUZDnt1GaIoRchnOh6bp7DCdJ6bYgLk0Sx7zW8TP2//mUWPx12vERvVKFECr3lbilUdsG/72LKVvjgaP9z3zKnLGuuh2HqQSRHsq4Cfipj1OWgNdd4m6EEijcQg2el/modP9LuEXeQVwsUe23MR849e/6T+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JrwxX8bL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7a8dd3dso1008866966b.3
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 03:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1756291728; x=1756896528; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lL19xfHMBfEDs48X3K+oV8VPfeHvbok1+JBxYOZS28U=;
        b=JrwxX8bL2YcdBz5x0AOh+CA+Ane56S2aUbd+YdY3PyY7Ikj2v/RHA0O2bwTvwc000c
         G40Y57Mb6WpeZ6c+fzTNsqHhM5zZCjqMxOjYMhPNIrFpVCPoFU3uKWtBktiPj0h6qjB8
         hnvnuyrtjrnjJuYHGyFKo352O20VH74oD4S2B5jgGYgKCrtotEipd27Yww4t8GUOHRIN
         v5o3FIxbriFx/IZ0iFT0Re5tm03s7nw8OD2ZWtiVysOa49mh5YJZJigU4pQTyHb2Ya3e
         B1b81sp1g4NTjYSPAzcMMStq+oIVLgf0wXI9geBI8WAuOkfQuXN2A5jtCCA1BdN6KqtN
         GU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756291729; x=1756896529;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lL19xfHMBfEDs48X3K+oV8VPfeHvbok1+JBxYOZS28U=;
        b=KGzgLKVb7PWK+ZpcjfcB4OZnx9lzCgMAyznz5sxuYDiV1MRZFcvB9Usi78xrV6XNXa
         gq8O1AZauCRKvDxcExDc8OCJKLTVfih3Y80AwPlkaM0Ax75riN7oq2pHVNRplAOT4raT
         0+8d9/lh5MjI60ncnDzKDS8ga7MSwN/SIjTw4qIdxRrvXLn+QBGbdqQtrx0xwGwij9H+
         kvYTx9VSIZklIfJUVLW0CGSxi7z+K2K5NQQaSwseOdb+PGWjH62ccQf6mRe+MGLBeRPa
         XPE6WvpZ4CJTWrb8YfNdXTp/0RPQfPKrfEOpYQRLsDHPz9Sjkw9qEq9ihcqgXjX2i3ZR
         YSUg==
X-Forwarded-Encrypted: i=1; AJvYcCV7BpLGrmRadPxzohX+CFwb7UtYR06VkhlaBe2YHtr5tgNpqxggNYI/hgF3+A7EUyaPbPrPxJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhjl26Kj79j7nIch9u8VXtjCdRtyUA9C2aGEUT2UTfTciQBUE7
	zRULjgHx0eoPwpNHMk35m0cJSv7b6MLEN276cPd8ttoVyyup1R/SGP4XHCeZGDuhS+s=
X-Gm-Gg: ASbGncthkPkoFwT2aWz93kFMyvomAPQ6e0WsmIt2/1l56WoDJZI9Ze6snaj9IDY44zn
	nEVgea1Q2qpdylvjLXTADxgHSc+kGxPnvLidfCL1zB2UUCdQiFb501BCFF0TQJU3gslS2fnEBOI
	vl4q8wpIY1kZsIZm/YKCmgT39IuGmYDw1jEQMQNoqFwrMTIjQi4talCBFRT7Y4w3118iT4Zt16k
	XE+T1Vc48suO9i0sGAwjHGfuiP9WkuW0RROKr16RTPsRLV8MLnngVbctcr+8mR/6vS7EkJy4FwO
	c/if1ezEGQi2aDpdbVQndWtaIw60ykKuearbdbx+CRZJubxOiGSnaIzf/8ccClBbOD9ARFvi9t0
	epRy9OoI/0uDLmtjFso/RnSqtlORuqO6LDZ9kePI2zfb47BrXCRXasoJrMEDS5QEt8833
X-Google-Smtp-Source: AGHT+IEVADrPJMUJPey3grHp2K9MK686lufQkO5QVcW/tIjMAy10SkXHsy6F5Gw27EFMbLCTtMlK5w==
X-Received: by 2002:a17:907:d06:b0:af9:6065:fc84 with SMTP id a640c23a62f3a-afe29437cafmr2078631166b.27.1756291728550;
        Wed, 27 Aug 2025 03:48:48 -0700 (PDT)
Received: from cloudflare.com (79.191.55.218.ipv4.supernova.orange.pl. [79.191.55.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8c74194dsm534171166b.35.2025.08.27.03.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:48:47 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 27 Aug 2025 12:48:29 +0200
Subject: [PATCH bpf-next] bpf: stub out skb metadata dynptr read/write ops
 when CONFIG_NET=n
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-dynptr-skb-meta-no-net-v1-1-42695c402b16@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAHzirmgC/x2MQQqEMAwAvyI5G9CAWvcr4kHbqEE2lrYsLuLfL
 R4HZuaCyEE4wqe4IPBPohyaoS4LsNukK6O4zEAVNZWhDt1ffQoY9xm/nCbUA5UT2o4s2dYY1zP
 k2Ade5HzHA8x+ydKZYLzvB4W+AihyAAAA
X-Change-ID: 20250827-dynptr-skb-meta-no-net-c72c2c688d9e
To: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 kernel-team@cloudflare.com, netdev@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.15-dev-07fe9

Kernel Test Robot reported a compiler warning - a null pointer may be
passed to memmove in __bpf_dynptr_{read,write} when building without
networking support.

The warning is correct from a static analysis standpoint, but not actually
reachable. Without CONFIG_NET, creating dynptrs to skb metadata is
impossible since the constructor kfunc is missing.

Fix this the same way as for skb and xdp data dynptrs. Add wrappers for
loading and storing bytes to skb metadata, and stub them out to return an
error when CONFIG_NET=n.

Fixes: 6877cd392bae ("bpf: Enable read/write access to skb metadata through a dynptr")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508212031.ir9b3B6Q-lkp@intel.com/
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h | 26 ++++++++++++++++++++++++++
 kernel/bpf/helpers.c   |  6 ++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9092d8ea95c8..5b0d7c5824ac 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1779,6 +1779,20 @@ void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
 void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset);
+
+static inline int __bpf_skb_meta_load_bytes(struct sk_buff *skb,
+					    u32 offset, void *to, u32 len)
+{
+	memmove(to, bpf_skb_meta_pointer(skb, offset), len);
+	return 0;
+}
+
+static inline int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
+					     const void *from, u32 len)
+{
+	memmove(bpf_skb_meta_pointer(skb, offset), from, len);
+	return 0;
+}
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
 				       void *to, u32 len)
@@ -1818,6 +1832,18 @@ static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
 {
 	return NULL;
 }
+
+static inline int __bpf_skb_meta_load_bytes(struct sk_buff *skb, u32 offset,
+					    void *to, u32 len)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
+					     const void *from, u32 len)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_NET */
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 401b4932cc49..85761e347190 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1778,8 +1778,7 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		memmove(dst, bpf_skb_meta_pointer(src->data, src->offset + offset), len);
-		return 0;
+		return __bpf_skb_meta_load_bytes(src->data, src->offset + offset, dst, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1839,8 +1838,7 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 	case BPF_DYNPTR_TYPE_SKB_META:
 		if (flags)
 			return -EINVAL;
-		memmove(bpf_skb_meta_pointer(dst->data, dst->offset + offset), src, len);
-		return 0;
+		return __bpf_skb_meta_store_bytes(dst->data, dst->offset + offset, src, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;




