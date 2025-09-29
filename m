Return-Path: <netdev+bounces-227169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604E5BA97CF
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469A5188F828
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15045309DAB;
	Mon, 29 Sep 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UZhiI78i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580693093CB
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154965; cv=none; b=Sx8V7lVRGRqPHhQScifPjryoJwBirpqjm/kg3qd7rTchNsoSfQVMrlO+Rnh02sMp7URHI1I8Ll4AjtqICOfFa8OhmT220uBGu6mRsgP1ePqlQrlkMOfVH9BfK90yN90KOT0tje+nFNOP6alcNxWUSl8whjJALFTsLE+H7pdZVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154965; c=relaxed/simple;
	bh=b+r8GilGqrGu4YUtulWgCPKpjDIlXpmUjP6hTfknSog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rjoVyyf5y82l9Zoz4T1G3o+LdDx2QWyq1aM6+a7jle7RBNCIEmH5QwhQvZKSKJDy7fOn5D4oxVJq3AWKH4J8V5Ey+BY6toVqcszPSNegR8vm6efai9b/1+Y6oEzP5A+CIM1NdlkPk/EL4ZBd6wL7egaEpbLbvOv52H/GXN59iYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UZhiI78i; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso4099610a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154961; x=1759759761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PdczIob3dePKxvyvAYTgj30vryGl7GoxlZy/f11n2Ww=;
        b=UZhiI78i/oQEKzMl5DrljjeMMqfksD3C2vQtklTH1Jp8guA+LP2JsuJY9pR5tyVpr4
         r/eokPrFLHGua7vmcs2JNMLyr0IJbMfKfcLBqrBA8z5X8PASPrZJlCZAp5ba3Kwvl0oq
         ov1HZbXXJ9v6b/IgOndJETW0m2fd03T5MRPZih/VGRGzn+o85erh5SXZIPouio2CNXk+
         Yc2YD+fz0Pf9nfWfw8T15iWurtoK17asxIpoaZ0eHIOPpx0i/+RNPngzS/vlXp0yawao
         inU2l3tA+nAC0Bg3zq7Ilb9GLGGXJa8Qh76+hnYrVs+DxfXv4R/DIRmjjZxso736HJ6i
         yd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154961; x=1759759761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdczIob3dePKxvyvAYTgj30vryGl7GoxlZy/f11n2Ww=;
        b=TGSYFfz8llPX1GKy25nGyyVLtgIO6J3C3jRMiG3BHEhGJswLBOUPlqvnA626r/09FC
         9eSaewlBU2XRLoahZnj1FcIshamdiRlYP+qTNorpzADNloCyQ/S62XNMaGklSeNPYZ/V
         tVQAFEq9PyEKi4KYw1iOVkq8tqfqdrSGTvQ03cDHP8AFLwNjTd2VKuikzkZNVFTv1OsL
         KL5sT/wJyZoMjJu+85k1wNZkCSb+/X8mCOjaZkN2D5cmLzWFe1AxtGd+QipQczY1rm/Z
         LzwYnIFfExmx5G31hGFEM4PlQxihJazF2BGNR9tHEburMPhEiAX5u/O/jRTxT9d1TRjm
         Tm/w==
X-Gm-Message-State: AOJu0YxFSBgviGj4Sg4oM+B9Cfsz9j0DBnNWtQojTvAF+VtBj1J88tFx
	vH6Sua+mIZk9iRzr5ouG65w2Xbvl1aLryv88nJUzwTpIhh3Z3TrnCHjbp+lD9zYhRvpo+gOgN7L
	QtFwv
X-Gm-Gg: ASbGncuLXGzb57m9HlrA2S4VBrrXdnyHkdXTTF2OyocAy4jPu4wocCbf/dllREYZNSa
	cVOYk2Hs2BmrgiaOAGAn4I0+J3bOY8Xg+4lBl8ti8K/u/q6V1Yhzd+aSKhEbjDdR2K4gN9IhiWu
	2fWklYmA2miF56/FfvKLM2mbcQ0xAImCtZDJyF8aJy5aKTpP9z0hOZaYfxh8/mTZgxrPGw/0lTI
	tFfA6I4xsJfKYwcTRnImngMEojHnbKtuqCqQ9a/QQLSsV9cWOhNVYdLIIfyOFO5Q8GgkEpdiAJZ
	Uuo8Ilnm2xOPWSkAymOx8bDk3r1WHUD+FFk9raW3YQBqfqVg/NHoSwkB2Dg5Wr07iz8JiVZIJtZ
	vdoXBaXiK+S0iinbFLCQuhyD4rJsnJcEBbg+sFjLuuWTYTidBcnowiSxdLOO7P5MvNARqeC16no
	09qseyHFru+CgZyxHD
X-Google-Smtp-Source: AGHT+IFn0p2Y3H/fjT7ex9aHKbC25wWninqvM/E69Bk41VpuM+yxIw4v7oHwZ84XmpMSvBP15l6bgA==
X-Received: by 2002:aa7:db47:0:b0:634:b5a7:3cf with SMTP id 4fb4d7f45d1cf-6365af2b6e7mr510906a12.15.1759154961224;
        Mon, 29 Sep 2025 07:09:21 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae321csm8076524a12.24.2025.09.29.07.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:07 +0200
Subject: [PATCH RFC bpf-next 2/9] net: Helper to move packet data and
 metadata after skb_push/pull
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-2-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Lay groundwork for fixing BPF helpers available to TC(X) programs.

When skb_push() or skb_pull() is called in a TC(X) ingress BPF program, the
skb metadata must be kept in front of the MAC header. Otherwise, BPF
programs using the __sk_buff->data_meta pseudo-pointer lose access to it.

Introduce a helper that moves both metadata and a specified number of
packet data bytes together, suitable as a drop-in replacement for
memmove().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fa633657e4c0..d32b62ab9f31 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4514,6 +4514,80 @@ static inline void skb_metadata_clear(struct sk_buff *skb)
 	skb_metadata_set(skb, 0);
 }
 
+/**
+ * skb_data_move - Move packet data and metadata after skb_push() or skb_pull().
+ * @skb: packet to operate on
+ * @len: number of bytes pushed or pulled from &sk_buff->data
+ * @n: number of bytes to memmove() from pre-push/pull &sk_buff->data
+ *
+ * Moves both packet data (@n bytes) and metadata. Assumes metadata is located
+ * immediately before &sk_buff->data prior to the push/pull, and that sufficient
+ * headroom exists to hold it after an skb_push(). Otherwise, metadata is
+ * cleared and a one-time warning is issued.
+ *
+ * Use skb_postpull_data_move() or skb_postpush_data_move() instead of calling
+ * this helper directly.
+ */
+static inline void skb_data_move(struct sk_buff *skb, const int len,
+				 const unsigned int n)
+{
+	const u8 meta_len = skb_metadata_len(skb);
+	u8 *meta, *meta_end;
+
+	if (!len || (!n && !meta_len))
+		return;
+
+	if (!meta_len)
+		goto no_metadata;
+
+	meta_end = skb_metadata_end(skb);
+	meta = meta_end - meta_len;
+
+	if (WARN_ON_ONCE(meta_end + len != skb->data ||
+			 meta + len < skb->head)) {
+		skb_metadata_clear(skb);
+		goto no_metadata;
+	}
+
+	memmove(meta + len, meta, meta_len + n);
+	return;
+
+no_metadata:
+	memmove(skb->data, skb->data - len, n);
+}
+
+/**
+ * skb_postpull_data_move - Move packet data and metadata after skb_pull().
+ * @skb: packet to operate on
+ * @len: number of bytes pulled from &sk_buff->data
+ * @n: number of bytes to memmove() from pre-pull &sk_buff->data
+ *
+ * See skb_data_move() for details.
+ */
+static inline void skb_postpull_data_move(struct sk_buff *skb,
+					  const unsigned int len,
+					  const unsigned int n)
+{
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+	skb_data_move(skb, len, n);
+}
+
+/**
+ * skb_postpush_data_move - Move packet data and metadata after skb_push().
+ * @skb: packet to operate on
+ * @len: number of bytes pushed onto &sk_buff->data
+ * @n: number of bytes to memmove() from pre-push &sk_buff->data
+ *
+ * See skb_data_move() for details.
+ */
+static inline void skb_postpush_data_move(struct sk_buff *skb,
+					  const unsigned int len,
+					  const unsigned int n)
+{
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+	skb_data_move(skb, -len, n);
+}
+
 struct sk_buff *skb_clone_sk(struct sk_buff *skb);
 
 #ifdef CONFIG_NETWORK_PHY_TIMESTAMPING

-- 
2.43.0


