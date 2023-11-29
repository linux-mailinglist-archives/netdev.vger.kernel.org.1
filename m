Return-Path: <netdev+bounces-52116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEA67FD590
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 12:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3751628340C
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00D71C6B4;
	Wed, 29 Nov 2023 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJE3YEDo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B4784
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 03:24:40 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfafe3d46bso40421375ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 03:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701257079; x=1701861879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J730iItaW8fpD9bcYiCc3WSDtwgBtsyA2Jb0R83edv4=;
        b=MJE3YEDomm+q64RgS20iNU4RPU2TQtqr0PuVkvC2o63KjVPGHw0Xgzq5Sg1N6vGY4n
         cWLkRsPpVqx9pasoHboCVrX/bx/gZEmWsm3O0jasn/nVrRzJZJ0ocGLGbHssos2zvQb3
         llFJuF/PDYeb7BLz8rPMDd0u7QEItjsN0JSwJdaEu1JSmBRR5mZwKrs53q2Nu1Ha2MGG
         JvanYvdRjsHb+vRWVT6lhxrvYfqx1WZt9Whl9gWe8EjQt6gccnR53wGRVZctW55OrbdG
         c3x12x6210DVIgw40n43NR8q1BB6h3S2Lr7DbFGo2DBpYW9wicRLw7b/lltwnBR/dJV4
         ++cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701257079; x=1701861879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J730iItaW8fpD9bcYiCc3WSDtwgBtsyA2Jb0R83edv4=;
        b=HxvFTFgysGdGJVy+Eq2Sw7/mazBc4CUqP1foCo1+IwF7CSSLQpjuKOpdgTqLOSPZxM
         46QnDdLAmEz8GibpA/vbp1rubeK6m4GEiSM6pji+pLzsLMJXTy2bC/hMiK5OXUDrfj7N
         4x6YWtF+LGTOlgEexH6Q8aWsnQsE9PmaK2uHQdMqIR5wdtO5i0j5Z7GBJ3QnPJp6Z5UO
         kLSBXXXRt92ibFaY8i6wSQMf4HumgYaIl4W4Eyttnbwn2D2kZDEwJTXMvQg5HzbBdiI1
         t/rCzowkduxOrBIWHuCgc/My5816m8x3H5d+jZYdivR1EKWFbNg3j8PBWzqBjVrIRZWC
         Zp6g==
X-Gm-Message-State: AOJu0Yxcl42rtaFJNavkY382N70uPde57wQZmIoyY/0U1Bkm6mc7B73Q
	cvdTfxy3+8jjx36ndXvo1X8=
X-Google-Smtp-Source: AGHT+IGend3+KRvVWg3wiKEnDCJRXZQxRXIpsrnkvu2W3MzYQdcBsY89G98gXH/coDoEQKUh9fTDxQ==
X-Received: by 2002:a17:903:32c8:b0:1cf:73ff:b196 with SMTP id i8-20020a17090332c800b001cf73ffb196mr24920528plr.8.1701257079629;
        Wed, 29 Nov 2023 03:24:39 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001cfd0ed1604sm5460710plc.87.2023.11.29.03.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 03:24:38 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Cc: netdev@vger.kernel.org,
	linux-mm@kvack.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v5 2/4] page_pool: halve BIAS_MAX for multiple user references of a fragment
Date: Wed, 29 Nov 2023 19:23:02 +0800
Message-Id: <20231129112304.67836-3-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231129112304.67836-1-liangchen.linux@gmail.com>
References: <20231129112304.67836-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Referring to patch [1], in order to support multiple users referencing the
same fragment and prevent overflow from pp_ref_count growing, the initial
value of pp_ref_count is halved, leaving room for pp_ref_count to increment
before the page is drained.

[1]
https://lore.kernel.org/all/20211009093724.10539-3-linyunsheng@huawei.com/

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 net/core/page_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 106220b1f89c..436f7ffea7b4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -26,7 +26,7 @@
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
-#define BIAS_MAX	LONG_MAX
+#define BIAS_MAX	(LONG_MAX >> 1)
 
 #ifdef CONFIG_PAGE_POOL_STATS
 /* alloc_stat_inc is intended to be used in softirq context */
-- 
2.31.1


