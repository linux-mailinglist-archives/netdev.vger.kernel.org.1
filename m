Return-Path: <netdev+bounces-81966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C4388BF14
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD10B26ED1
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBF76F06F;
	Tue, 26 Mar 2024 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="jPTrlZ4H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9067A04
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448147; cv=none; b=ehhivobfPBBMbMhFocWs1Kg5EuxBhQGXqVDV+eRYn92TY3xd00IpXKSqX39Z1+hXuLdDtWhRUw3gUjZIIpUwo00jVxswiSE948ALbuNrvZx97dOddoKKMaBasMSzIpEyHJHR7TnQ+W3Fb2fPmhlu7+pAxr45CJj7EwBGd0ZtjAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448147; c=relaxed/simple;
	bh=djIyxHQXg9LMS+10uh5V4dqBu3eyfNdtobBCVn6BOOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KG3W0rV49o8E4O7S7QhJp6QwkVj/clyyawPiZYHgMP0lxF8G4mdgFKMCCWxwGuxiDoI4Ltl5BgKqQm2/WPQPAGjqYmmMT6pbtZVq0VwEbC8u0hH2ugE3xVqPhC+/l1wqDzd6LfaQZ+7f/Q0MZpywDRIg+hHPdnppWxfSuU+2CH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=jPTrlZ4H; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341cf28e055so1251240f8f.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711448144; x=1712052944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMvdSrKOet2j2j0islGkHR/rklL0ZcdZ3YUXMPQWIeI=;
        b=jPTrlZ4HSgacLfrWnUST1D9fGQuGlkXgf4u63Zsnk0uVwf11pIqAnVf3KoxqwGFRgL
         JDsc5px/Jw3ajQ/sv3oZXp4Es8kOTTjDVNPTh3hKXg7pp5vtrG0D31ad7KemEv9gATe6
         w05ex2o81zj4k6hp0hhY1dRoW9papK9uHZRQmkwrLBkUb9HHiqTiyqGQak+4xsaOU0n7
         YzQKorKPLxutmlnnWq7rPJlQnDBCI8c66cYMrinGh4b/IWe6KH3HuDTjRJXATW9b6B4Z
         do1HKPjHQV9+vkmAs98g7tiZbelgSkiLlsCJ4hZdEKGRlH8UlPoer08xUKgYT+day+lS
         gIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448144; x=1712052944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMvdSrKOet2j2j0islGkHR/rklL0ZcdZ3YUXMPQWIeI=;
        b=Q/eTZOZwhWpy+R3sZZNV3ZbAfu3aavx45NLUaG/8DE9WNCa9MeToZ/6+6HjnU/l9zB
         gYJ4Pfai02Gy33IhjjTCpWmDorQOXM1Ovjl6KxFxHJ4yzNeXa2GCFcsLgkdvC+MnFa1c
         BQpAALv262qv4fOi/WZNVVlx8iMuBpEvO0P74eFxrn1S++k5/BpeLw8c/T07+PxI5A2k
         vAyK1HBYB0rVWoC+TMndXorztLikv4JDq/F4P0NfYyhaPlFCb7EFh64b24ReCQpaiGPp
         KzjgvNn2w9op7cPzgXkttVvjooRuvY+os7PBuzC/bb+OJA8JvXzs+tUMG7Z5NLzS14sK
         Impw==
X-Forwarded-Encrypted: i=1; AJvYcCWttLM8lJ13NEG1cRfoKw9W4uR80EYZ3KCkmr4ix+Qx3Ovbmxa6tv2xnnrI9CdqTqAHuJWf31+hc4elyKift6d5gUC37HwU
X-Gm-Message-State: AOJu0Yx90Logt8BP02/sLHs54MVEtJG2FyIFKnZIDw7DvcW0B/J6noUf
	Bv5e1yI5+G+KZS7pmFd+sYsQ4VHrzSIrvKjrNlLeFezILA2bqYp4JVVRVxAP3N0=
X-Google-Smtp-Source: AGHT+IEHdVK1zowcKGRyP/ZFBeCiA4Xz9Uwaa3wtj+sK4a2CzzVaD08K+Blo0eVE+LvsZSocHh3E9Q==
X-Received: by 2002:a05:6000:147:b0:33e:7d7e:9af4 with SMTP id r7-20020a056000014700b0033e7d7e9af4mr6645799wrx.12.1711448144108;
        Tue, 26 Mar 2024 03:15:44 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id co20-20020a0560000a1400b00341d4722a9asm1891743wrb.21.2024.03.26.03.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:15:42 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v2 bpf-next 3/3] bpf: add a check for struct bpf_fib_lookup size
Date: Tue, 26 Mar 2024 10:17:42 +0000
Message-Id: <20240326101742.17421-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326101742.17421-1-aspsk@isovalent.com>
References: <20240326101742.17421-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct bpf_fib_lookup should not grow outside of its 64 bytes.
Add a static assert to validate this.

Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 1205dd777dc2..786d792ac816 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -87,6 +87,9 @@
 
 #include "dev.h"
 
+/* Keep the struct bpf_fib_lookup small so that it fits into a cacheline */
+static_assert(sizeof(struct bpf_fib_lookup) == 64, "struct bpf_fib_lookup size check");
+
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
 
-- 
2.34.1


