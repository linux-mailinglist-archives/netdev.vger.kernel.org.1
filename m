Return-Path: <netdev+bounces-224849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFE2B8AE68
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18BC1CC43F4
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECD9279DA4;
	Fri, 19 Sep 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwXCAb/A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5A27932F
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306071; cv=none; b=omOXVp8AVw2ffCmcMC1ZTpW+2ky7w3FdfBOIH89XqM7FGffQeOlZg7/FR6kfd6Krz0g5gCMdzXRk5fmw+JBJG0BtigzAXxY3DO93L/3UKOicaxaQ6ttT6MAeAf8KCfa9mn1/mBPzdSJRtfJZFOU+fWa8BjK9JeqCOfDMF3/mQ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306071; c=relaxed/simple;
	bh=nDmjbXMAaaARovoem/jblg2PIL/t10TLTSxc9dzhj3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1TwkYTHFoD6Bi0DDG+yKwNe8wblwyUQFkn4oJrLbOARISht/BKgUSwg0eILZnw8IW5qQ5u5NN2+ZLnPYcSpeG8E++gBJMFYuEztdbB8t6uqSBUX0P5omqtn41abdebDPRqDSsznvq4Wg0dZN6ayEAKRFeZ1ePYH2vZsYz4EZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwXCAb/A; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77ccb67f8e5so2779589b3a.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306069; x=1758910869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OETsLPmcZGNpLSshaaiLeOj8LUgrE6er4wP4vFEBZK0=;
        b=IwXCAb/AXm9t3CvNNzBj75yETEeqB9hy6p2kh3q6MQ/ViHllE2Dp6Pr/ISVHs868Ru
         Iwv9q7OMf9ZRfBDYP/aU/Qe/SQyGd4ro7aJai5Vh/owIQkolvUQT21B64VqQT9caBAhF
         j8/l7sB3A3Y7S6r39MQiLqUjva9DOk/Z7UzTl8pyA17D+8y/k/b/WB/kRAmZoftqeqRK
         QmJeWb0erhqwju1ng4cm4zPrMajeop+lYrmWwZJ0EmpVhtVSLFA6oKjMw2APaJBO1lgU
         MSmPsHFbTrijorY4SAQKyeuOVF58suYXbrrk+xmmq7TSL0kF2ICqUw4SRoYe/eSoG081
         z7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306069; x=1758910869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OETsLPmcZGNpLSshaaiLeOj8LUgrE6er4wP4vFEBZK0=;
        b=MiehWy0liZ4EnUH5tEt9rWPXEK+woGvdNaOXPNwun47VY7lfZ2ueIx8/5w2zHBjYPK
         FMDOWupcLIO0/l7WbxHfuVYXyXNCWipBeSt76DjSifAT0mxJMkn6+jGVwx0TvQyK6sn6
         Un5uCPLvEqH3/Pl9Vu4EwNJGs2nPpf/i0n4szLP5Q5tTc94d9HODxJPI+cVcdI1nswaR
         Y/w/wYh1HkOlmla4rQIaONQrMP2JnghFdQASGM1BIq4ipAIUAVM5ahjxle4xKordSKOC
         V0/7pItr1HPfpXPz5DlU1jWSKy6OCFQquSqqLygrKuAKa1GCncTD9ph55Z8kgz8I6Mho
         aOVQ==
X-Gm-Message-State: AOJu0YzQ/fFwEPw77aAaNisP/BuALBkeStkH3MHxMwA2VAiBMMqiVf5b
	Zax6obWeOOhaeuKwM4xMuGfLh2KDXrY+PYF6OGlo3N6RS4nXvlgI/NCE
X-Gm-Gg: ASbGncsweRcOgLvssIcwwKuwvx/GwVpvaoMzL/XRjyixYo07NZL3uCWLlVwKj9P716x
	nUefV4KKL2YCRxU4o0DDgxJa1g1zZUbGePkPri8gy6vbiRVxO42FrEaC9HbO9tCaWBlBV9ayEgg
	OVKymQR5oOW77K/JwZPA3+0WVp41nILGMIK+p80n31BrqNYzxoQAHrnRBCnrNhiA1npvN9I6Uxy
	rKa0HI959kyq3Zlj4/bNsC2Z1qaz3lIk8lSqMffW3CJvdvfWLdiaYgnb+jB7coAfpuUITaYe1d/
	MfLB6t0hUVGNDuqp5muTxYJQDfX28u7e620Z+Djd+Mam0yoGyjzFSuyDTK5EADEJz6jCmcMCf+Y
	26o1jp9fvsU/0gA==
X-Google-Smtp-Source: AGHT+IE36S9k5lpTrGeJlvbGtSz1lrC9/LBJsU6I964nM8zdfGmxXi1+riNNVd2n6eF0q6LS2DTZ9g==
X-Received: by 2002:a05:6a00:71c1:b0:77e:a3ca:4208 with SMTP id d2e1a72fcca58-77ea3ca444dmr3303800b3a.21.1758306068840;
        Fri, 19 Sep 2025 11:21:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe75e320sm5968626b3a.64.2025.09.19.11.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:21:08 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 7/7] selftests: drv-net: Pull data before parsing headers
Date: Fri, 19 Sep 2025 11:21:00 -0700
Message-ID: <20250919182100.1925352-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919182100.1925352-1-ameryhung@gmail.com>
References: <20250919182100.1925352-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for drivers to generate xdp packets with data residing
entirely in fragments. To keep parsing headers using direcy packet
access, call bpf_xdp_pull_data() to pull headers into the linear data
area.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/net/lib/xdp_native.bpf.c        | 89 +++++++++++++++----
 1 file changed, 74 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 521ba38f2ddd..df4eea5c192b 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -14,6 +14,8 @@
 #define MAX_PAYLOAD_LEN 5000
 #define MAX_HDR_LEN 64
 
+extern int bpf_xdp_pull_data(struct xdp_md *xdp, __u32 len) __ksym __weak;
+
 enum {
 	XDP_MODE = 0,
 	XDP_PORT = 1,
@@ -68,30 +70,57 @@ static void record_stats(struct xdp_md *ctx, __u32 stat_type)
 
 static struct udphdr *filter_udphdr(struct xdp_md *ctx, __u16 port)
 {
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
 	struct udphdr *udph = NULL;
-	struct ethhdr *eth = data;
+	void *data, *data_end;
+	struct ethhdr *eth;
+	int err;
+
+	err = bpf_xdp_pull_data(ctx, sizeof(*eth));
+	if (err)
+		return NULL;
+
+	data_end = (void *)(long)ctx->data_end;
+	data = eth = (void *)(long)ctx->data;
 
 	if (data + sizeof(*eth) > data_end)
 		return NULL;
 
 	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
-		struct iphdr *iph = data + sizeof(*eth);
+		struct iphdr *iph;
+
+		err = bpf_xdp_pull_data(ctx, sizeof(*eth) + sizeof(*iph) +
+					     sizeof(*udph));
+		if (err)
+			return NULL;
+
+		data_end = (void *)(long)ctx->data_end;
+		data = (void *)(long)ctx->data;
+
+		iph = data + sizeof(*eth);
 
 		if (iph + 1 > (struct iphdr *)data_end ||
 		    iph->protocol != IPPROTO_UDP)
 			return NULL;
 
-		udph = (void *)eth + sizeof(*iph) + sizeof(*eth);
-	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
-		struct ipv6hdr *ipv6h = data + sizeof(*eth);
+		udph = data + sizeof(*iph) + sizeof(*eth);
+	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ipv6h;
+
+		err = bpf_xdp_pull_data(ctx, sizeof(*eth) + sizeof(*ipv6h) +
+					     sizeof(*udph));
+		if (err)
+			return NULL;
+
+		data_end = (void *)(long)ctx->data_end;
+		data = (void *)(long)ctx->data;
+
+		ipv6h = data + sizeof(*eth);
 
 		if (ipv6h + 1 > (struct ipv6hdr *)data_end ||
 		    ipv6h->nexthdr != IPPROTO_UDP)
 			return NULL;
 
-		udph = (void *)eth + sizeof(*ipv6h) + sizeof(*eth);
+		udph = data + sizeof(*ipv6h) + sizeof(*eth);
 	} else {
 		return NULL;
 	}
@@ -145,17 +174,34 @@ static void swap_machdr(void *data)
 
 static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 {
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
 	struct udphdr *udph = NULL;
-	struct ethhdr *eth = data;
+	void *data, *data_end;
+	struct ethhdr *eth;
+	int err;
+
+	err = bpf_xdp_pull_data(ctx, sizeof(*eth));
+	if (err)
+		return XDP_PASS;
+
+	data_end = (void *)(long)ctx->data_end;
+	data = eth = (void *)(long)ctx->data;
 
 	if (data + sizeof(*eth) > data_end)
 		return XDP_PASS;
 
 	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
-		struct iphdr *iph = data + sizeof(*eth);
-		__be32 tmp_ip = iph->saddr;
+		struct iphdr *iph;
+		__be32 tmp_ip;
+
+		err = bpf_xdp_pull_data(ctx, sizeof(*eth) + sizeof(*iph) +
+					     sizeof(*udph));
+		if (err)
+			return XDP_PASS;
+
+		data_end = (void *)(long)ctx->data_end;
+		data = (void *)(long)ctx->data;
+
+		iph = data + sizeof(*eth);
 
 		if (iph + 1 > (struct iphdr *)data_end ||
 		    iph->protocol != IPPROTO_UDP)
@@ -169,8 +215,10 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 			return XDP_PASS;
 
 		record_stats(ctx, STATS_RX);
+		eth = data;
 		swap_machdr((void *)eth);
 
+		tmp_ip = iph->saddr;
 		iph->saddr = iph->daddr;
 		iph->daddr = tmp_ip;
 
@@ -178,9 +226,19 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 
 		return XDP_TX;
 
-	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
-		struct ipv6hdr *ipv6h = data + sizeof(*eth);
+	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
 		struct in6_addr tmp_ipv6;
+		struct ipv6hdr *ipv6h;
+
+		err = bpf_xdp_pull_data(ctx, sizeof(*eth) + sizeof(*ipv6h) +
+					     sizeof(*udph));
+		if (err)
+			return XDP_PASS;
+
+		data_end = (void *)(long)ctx->data_end;
+		data = (void *)(long)ctx->data;
+
+		ipv6h = data + sizeof(*eth);
 
 		if (ipv6h + 1 > (struct ipv6hdr *)data_end ||
 		    ipv6h->nexthdr != IPPROTO_UDP)
@@ -194,6 +252,7 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 			return XDP_PASS;
 
 		record_stats(ctx, STATS_RX);
+		eth = data;
 		swap_machdr((void *)eth);
 
 		__builtin_memcpy(&tmp_ipv6, &ipv6h->saddr, sizeof(tmp_ipv6));
-- 
2.47.3


