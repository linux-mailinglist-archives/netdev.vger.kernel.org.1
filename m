Return-Path: <netdev+bounces-54370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC911806CB7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2934F1C20A11
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FA83034E;
	Wed,  6 Dec 2023 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHxsw7HF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704BE9C
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:54:43 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d87a8228e0so1941482a34.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 02:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701860082; x=1702464882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J730iItaW8fpD9bcYiCc3WSDtwgBtsyA2Jb0R83edv4=;
        b=QHxsw7HFS9rnfyTOK+IzOzanHaRe/j5offkGH1PY1dvVTZotl4gvvbTBhhyUC8bOZ1
         k6NkKMqH/S16hK5ui1TAFNtoVi1DFbYwRI+ZAgHbR/3aFJIjfEeI5WxeN+YmYBZjKE3l
         HJ2GHeZ+oOD5pbhaL8AX3jHyiL/BAw8XlE2gbX43GOpEl9x3v3vohuWPFnA+JBaEsXbc
         40McjTqm1Wn991RhU7ShzvpZj9vsronMaQsgx8imNE4a8lVbgT3jY+CCwFR7quprmWPn
         /FHULuxyMDL1e+CXykSo4BsptA3DiI9FMAtVk80i6ku8yNYqGOrejch9ZGZzdJlyS3h5
         xxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860083; x=1702464883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J730iItaW8fpD9bcYiCc3WSDtwgBtsyA2Jb0R83edv4=;
        b=YXRreV/A1SUmCV41oNjNWlczcJ0fjVMDLyph8A3jPKCLskElgOQSn0VyFCFwavLKpL
         iqGGx0mD73ziShlx7e9Yykr8WykBepiS31eiKUs8zsQOBy5GwNArtaDSyTWi3g0RzRb3
         cU3cUmPJ1xpnmMolVk5jErtRkqfT1qkpK2H2ZYh5W8ZGtyJrHaonJnzsrTgAt/v0GI/y
         kyTIEmQKh8tAlNZiOPgbl00orOvwRoRVKn0oiOo58my/g5SQnU3nEQHaVW356WRC15gj
         hJX2cuVjKWN6VrxDCo0+HHhP1A6wh4uCY7PzpE4m2NzmHyyMLeVvVTIH0RNPvAwZ5bGz
         CDIw==
X-Gm-Message-State: AOJu0YwAaxoUDBgWaiixDlo6JBZg8LrsjUH+fD91ulPTJaGaBV4gl08p
	tB1jx7MxjzgeTUdMQI5l+P4=
X-Google-Smtp-Source: AGHT+IEVWGAs6VmJ6gEEtOq16rEzedYFdHy4Uqdvgzphsz0NsAg1Zhi+SY0iNk9q2PpSNior2r90BQ==
X-Received: by 2002:a05:6830:1117:b0:6d6:4ebf:1557 with SMTP id w23-20020a056830111700b006d64ebf1557mr580766otq.21.1701860082740;
        Wed, 06 Dec 2023 02:54:42 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id n15-20020a638f0f000000b005c6801efa0fsm5388796pgd.28.2023.12.06.02.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:54:41 -0800 (PST)
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
	jasowang@redhat.com,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v7 2/4] page_pool: halve BIAS_MAX for multiple user references of a fragment
Date: Wed,  6 Dec 2023 18:54:17 +0800
Message-Id: <20231206105419.27952-3-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231206105419.27952-1-liangchen.linux@gmail.com>
References: <20231206105419.27952-1-liangchen.linux@gmail.com>
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


