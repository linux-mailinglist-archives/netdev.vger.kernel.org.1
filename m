Return-Path: <netdev+bounces-241207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F118DC818E5
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DF7F4E6072
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8673164A6;
	Mon, 24 Nov 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UgOVioeD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEF315776
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001755; cv=none; b=RDh0v6hM15Cyr4UiOWlwFitg62OjdLMnVgjbvyh3tc8bu0xu+jJadLowgJa9eEAIrIP3W5tikam33LdP/DZKU+g0zRdkmilEFsMojaLqCza8XFGpLrWTnCK5vkROLOzswqsRcO9E8OcK5om7bT4Zdo69CaksFmdY2ysUyGEjfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001755; c=relaxed/simple;
	bh=oMHmrv504DpK3sDJkcM25UNgfzziW6gjvBfOPGWboAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwjMv9QefnLYFzVBYexUcdGdecOZAVI0J7iaSMjbXZjs46QR9dPhiZR6f2TNXI3O0ptN9vtCpBj8cgOnxNYkkQ5jCY5aYDBmQT9CL2Om4a9OGYs4yTHM0RH1GMHKoC2c+nw+uKXZHtG+MJ9kAPo+fcukooFeXcLXqGJ7h/FcYAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UgOVioeD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b735b7326e5so935696566b.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001752; x=1764606552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhn4HZ+NklBudGUcJpb0YU7dEzH4q1ZmXiPPH0r44sQ=;
        b=UgOVioeDVjqo/nGzrhqvJLaZQZHIQphTNlw72KEdstHUjjuA/RPpZOp9+uBi9bquP0
         CflqAbVFhFBncpNJcY4yA9CNOsVS2HburkXu9ias35NuGYzRXdu685g93xVy/k9Jrp9Q
         EdMVaT0lisGzIIZzz/UtMEHEtpcoBl1Dg85O7AMJ+88tubHoZPYy1Jc9G1v9Mhggw4Yt
         0sxBay3cJJw1FdbpsdkwTffcNWZf4Y96iTz8TEKHhCg10kLuWneOTyxvRT0Ph34RQwDP
         XpAv2lEbHtlWCVzOBf/p+x3OpDyTFBBFpSZJUKiXmXrVqLz+8+Wkg+y/Eg02ghS4Rj9V
         XNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001752; x=1764606552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xhn4HZ+NklBudGUcJpb0YU7dEzH4q1ZmXiPPH0r44sQ=;
        b=Aj6qb8/gRVBYWOBZNu7ZznLUCV3K6u5EI3x7e2jhFGhezTZy0rYiJ0uEUdzys+4qd0
         R5N3lz79O2ceYd+uF5KxtGsG/D5mYceF7FiYS0agEornKQe2MOnWHGygrh0XMjTwwuJ3
         REV5FN3g9sj02nnPb/jFMYJLZZKDyyLtk8hxStcJaX9IqAVcIhu1/HqvNu1RIOdN/jwD
         zefaPloIY/PIj0/BsusJc4uX0oIEMT2NvuPmaQnZrEqf7n1ZGmLZcC/Dgh4UlqjSAnZI
         GOe2vkgQLHPsqdwcE0FPyZWd6ZB+/vr0f8mCGPJFQTe7KnPryG2r7cnmk/71Ws63fD8m
         aP5A==
X-Gm-Message-State: AOJu0YwxJjbpniCr+QfZGwbwwrp/xQ85OT1iy3QjNuzh39f+DI6b5821
	EJSH22PixY5gYjTWSzl74AZbEIvKOkcpjxkFvXBhIt8DuZTvZ2m3Zi913BrCSrMl+JzyQjk4LN+
	zSjW1
X-Gm-Gg: ASbGncuglYxq+69g6QgbKiv/j9Md6ZQEJSzbIggI5etAEXkWfose11Jhr2/Y/WABgCd
	YC6i8cRZANHawiY+VJ3wM8Y1p3snmBGd94T8KdjSs+WoMq23qC4Nanx4CDg95TqmIsWgFs+73W7
	erZmpdm9hrfugFqRlXphvzxPkx4vI9RmdA9DdtsgiOgG6O/G3LfR12AhBLO8UkWY+MNfUAZu5Ik
	CAXByZ9dQ4pAH3mcA5yDfpW+HwW+gVPZxOOuHulWO8hHeMjnO7c6D1luwHriPM3eyXDpbhSL/FR
	Zk9UiPqvlPD6HTfuvTHHcSdaJoFt/qFY7TqCtAgmZGj4K+I4RzAeF25r9aZQbfsh2P+nenFkgSX
	yE5YlFSRGi19C+HUBcPswbRAG0yPZf34HHQWPEeDitTSWf8iJkwEyFa1K6ESSt9U6Gwy03WPN6T
	8n7O/adRgI0m2A8kpoFjcPNW5ZzkNyKG7hL5zh14Yl6RQFV3UyEIc1UIBXBr+ftHBegNU=
X-Google-Smtp-Source: AGHT+IECGRVSsWRNXmYcKxV5LDYypMTtGC8QkxnmYHqpUHSkrZ3kzEj2PwsVnIA2MG6aZtx2uH5moA==
X-Received: by 2002:a17:907:6d1c:b0:b72:e158:8229 with SMTP id a640c23a62f3a-b766ef1d289mr1592228966b.15.1764001752217;
        Mon, 24 Nov 2025 08:29:12 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d3bf64sm1316680566b.16.2025.11.24.08.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:11 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:38 +0100
Subject: [PATCH RFC bpf-next 02/15] i40e: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-2-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..11eff5bd840b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -310,8 +310,8 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	if (likely(!xdp_buff_has_frags(xdp)))

-- 
2.43.0


