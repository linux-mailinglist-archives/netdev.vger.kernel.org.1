Return-Path: <netdev+bounces-67437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4708436EC
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 07:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28171F2AA29
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 06:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBBD4E1A8;
	Wed, 31 Jan 2024 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f724HpMR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B063E496
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706683250; cv=none; b=YUcHVDsjlrQskjI6ZEYdO/EKBEvGjBG5CSlRr+7QLNvDSjg3y2nNGLb+xRhS/VF1PRkJBsVcAfQB9TrQiBxM+ay/u256mvIlgamCfqTFZUqrBnsEdn5Mz+pwEOEGTjBGN9SGb5B7jA5Pf3KqNwDh87wXvfubVlUKLb7Ciyrfz/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706683250; c=relaxed/simple;
	bh=UICTwqsBFDrXmAIgYZVBQMDeLjA/8fIOmmrguJ8MdYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kY+hYq9vrA6KE+H/hBodi52gKKwe/6lggTor/OvMFfLlvb46ZyVNjonKQc/0a4Ik7ICWILDo6usn8JR/zxys1u7uRrkP6VUAj5t33XGEdMjty16tOWutF+5TA8vGurt0BXV6eBabI2xoxbe+A0UNZP8lWHC1JmRpLcl56i/q5ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f724HpMR; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc223d20a29so4416806276.3
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 22:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706683247; x=1707288047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjNf2dCaNYpLB7TRGn31e6KV5r+kwnaQBIfaig0u3eU=;
        b=f724HpMR/h41w2nuF5pZyphJqtwLfHYK806azQtefrandv16zeJJCImMGzdsXDg/6i
         q8jF6jmNZtfmaKXOnmcDsHfWrASy35SMASSXcmKhf+AbySs1LPYQnA4+0jemmp/Z1In9
         P94bqNGvWMQA/2sHl0li3NeFclQGG4goPCKPDDRkhk1N49forfnHsu84u4AlDXmQNoL9
         k4BzwwYzJ+30RjaGZlh3lMTCOmdjQnGE14oCslK7wFlHxOl1OntvKJ0saTTzZ73mr/Ee
         6WPhb0a1fX5Mnos7zbj5S0Q62+UgBqzsvM1rOR15R/Dnme6YiEIc13OvEK3Cr3PWNIib
         aa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706683247; x=1707288047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjNf2dCaNYpLB7TRGn31e6KV5r+kwnaQBIfaig0u3eU=;
        b=dpC1UdLYQrVk91ofo8PzNLF/b/qNAZeiz9CbYu8CjIQR9z3svCPH3o4I13zS+1dIoi
         T4XjbdL9ert2pIZDc6BCgKKO9+scTUzGJkt345mxeWg0PBgdthKYf60ZNUbsefuxpD9f
         ouAlBe13Km2WlleSqmkVnUPY7XZUu7Y4/Pu/pAKFmANK4Nq89Vkltrot0SiaOPvzmVO3
         daoeapg/XDmbdCKJfc61hc5JsSxwgHMhrKu859HH1jxDDx95AImMPZ/n4t2rX7OMZhcK
         4li4lltn+LZXUdzUlXYJLkDEl36Z1Ma4aXiyZcPaL7cF0YbaeIwDpftm2g/PRnU18bFy
         xutg==
X-Gm-Message-State: AOJu0Yx82eOXtL786pdxCQRb9Wbeu3tg7Hwxc2r3FX+tt6bP5npsfq9z
	tcXcGcoSFBTXAezrMaW9AVnj5PqW73CXeE4Hqe3T+LL81NaMKEk2Yzg0fdeJYkk=
X-Google-Smtp-Source: AGHT+IFZG73APVMZR6jRsyp7l5wvAuxTthqU3G620TsFuSn592ADhrbFuy2BzPs2zXu0QPKqSbHlxg==
X-Received: by 2002:a25:abc1:0:b0:dc2:82b0:1686 with SMTP id v59-20020a25abc1000000b00dc282b01686mr1002591ybi.33.1706683247401;
        Tue, 30 Jan 2024 22:40:47 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:7a8:850:239d:3ddc])
        by smtp.gmail.com with ESMTPSA id y9-20020a2586c9000000b00dc228b22cd5sm3345683ybm.41.2024.01.30.22.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 22:40:47 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next 2/5] net/ipv6: Remove unnecessary clean.
Date: Tue, 30 Jan 2024 22:40:38 -0800
Message-Id: <20240131064041.3445212-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131064041.3445212-1-thinker.li@gmail.com>
References: <20240131064041.3445212-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The route here is newly created. It is unnecessary to call
fib6_clean_expires() on it.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 net/ipv6/route.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 98abba8f15cd..dd6ff5b20918 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3765,8 +3765,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	if (cfg->fc_flags & RTF_EXPIRES)
 		fib6_set_expires(rt, jiffies +
 				clock_t_to_jiffies(cfg->fc_expires));
-	else
-		fib6_clean_expires(rt);
 
 	if (cfg->fc_protocol == RTPROT_UNSPEC)
 		cfg->fc_protocol = RTPROT_BOOT;
-- 
2.34.1


