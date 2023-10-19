Return-Path: <netdev+bounces-42596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664F67CF7D5
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C90281659
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E3A1DFE8;
	Thu, 19 Oct 2023 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OMaf916y"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41573156F3
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 12:00:53 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14875136
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 05:00:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9bf22fe05so53114075ad.2
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697716850; x=1698321650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7MqzCn5z9sc3xLiS0TjD71DTwTzVkWYSBF1gVBH140=;
        b=OMaf916yBVqlHFe0BwPb3MC3EBkvSDewja2C/2ZXQNEF0wmlvSv/KeErnJavykFCDP
         2sxcAYzKW1ate2jGChJBTYzDbYtLqIjXorzW7U5c85Yx+426aPMniBETArpCRgJvSCH/
         oXKJAMEbcnvdWjChgddrlUFCxeNk3EguD3y+VrLg1TiJl0ERsAiHcIUHNhHHKZUvbvRQ
         jUs0sDCaIQe3k7qaSB3hYlppFFB9d+pUFrrkXv0jPvHMggNY94olZmjOWUvXpEcrc6ND
         NGhhYNVhU1I9azvqi/T2xOS0qX0B87iA+KGW8syXkUHeBJsfk9QoXRX8d04LRIzn/TNV
         1msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697716850; x=1698321650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7MqzCn5z9sc3xLiS0TjD71DTwTzVkWYSBF1gVBH140=;
        b=GU8+wqw4D2P5LssZsq5kcwKPJS3ii+8lhTMvdB8KKxEm3T7Gvxo3T6wBprtFgSg5OE
         1ZaSKKHZPM2VRXMpxSHrxQ5nRKURgm9J/xCDB0oWctGUDS4BEA8LTTUuYLHBsj0nJvaF
         bc81uf50ZRB2VB5a9pvXBJRDnA9TUlDt5BrI4pkMmAuIs4kzoORxgp86AMsOdnFv327d
         QHubu8blEIb/RfeqviY55sy4X1olQnvTU5L0SBe/Jd83nJ9cHfbYuIt/fVNzWlY9+Q9C
         99DU51RRz2QezaC+BoM0K2bvK+e9zg8STskN3j2kF8UZA+DrEvjlW9lfi7ZvZlnjporM
         8C9w==
X-Gm-Message-State: AOJu0YyeS0jM9BIOftFLK18nPgvO3z6prSxfWws+j/VIlT4wyVKIfUIr
	Z36RR/mVSnpJgj/QAKJmdOd8CQ==
X-Google-Smtp-Source: AGHT+IGN09o1Q9j44/zIeUHNFtWEncrYubO/c9yLNO4WlC9wEokKEtFxxYCUPqROzYola5FoTREwrA==
X-Received: by 2002:a17:902:dac5:b0:1ca:4ad7:682f with SMTP id q5-20020a170902dac500b001ca4ad7682fmr2419059plx.26.1697716850434;
        Thu, 19 Oct 2023 05:00:50 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jg9-20020a17090326c900b001c727d3ea6bsm1785646plb.74.2023.10.19.05.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:00:50 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shakeel Butt <shakeelb@google.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH net v3 2/3] sock: Doc behaviors for pressure heurisitics
Date: Thu, 19 Oct 2023 20:00:25 +0800
Message-Id: <20231019120026.42215-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231019120026.42215-1-wuyun.abel@bytedance.com>
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are now two accounting infrastructures for skmem, while the
heuristics in __sk_mem_raise_allocated() were actually introduced
before memcg was born.

Add some comments to clarify whether they can be applied to both
infrastructures or not.

Suggested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 net/core/sock.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 4412c47466a7..45841a5689b6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3069,7 +3069,14 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	if (allocated > sk_prot_mem_limits(sk, 2))
 		goto suppress_allocation;
 
-	/* guarantee minimum buffer size under pressure */
+	/* Guarantee minimum buffer size under pressure (either global
+	 * or memcg) to make sure features described in RFC 7323 (TCP
+	 * Extensions for High Performance) work properly.
+	 *
+	 * This rule does NOT stand when exceeds global or memcg's hard
+	 * limit, or else a DoS attack can be taken place by spawning
+	 * lots of sockets whose usage are under minimum buffer size.
+	 */
 	if (kind == SK_MEM_RECV) {
 		if (atomic_read(&sk->sk_rmem_alloc) < sk_get_rmem0(sk, prot))
 			return 1;
@@ -3090,6 +3097,11 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 		if (!sk_under_memory_pressure(sk))
 			return 1;
+
+		/* Try to be fair among all the sockets under global
+		 * pressure by allowing the ones that below average
+		 * usage to raise.
+		 */
 		alloc = sk_sockets_allocated_read_positive(sk);
 		if (sk_prot_mem_limits(sk, 2) > alloc *
 		    sk_mem_pages(sk->sk_wmem_queued +
-- 
2.37.3


