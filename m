Return-Path: <netdev+bounces-51981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2077FCD48
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E771F20FC7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EC2523D;
	Wed, 29 Nov 2023 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avoeFuAX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388A1C4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:12:39 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfb2176150so32306995ad.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 19:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701227558; x=1701832358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J730iItaW8fpD9bcYiCc3WSDtwgBtsyA2Jb0R83edv4=;
        b=avoeFuAXrkPUmXwK/Ot+ymO938r+HmAhaSV37hxcaCsKb7BlAVY5O2aQHTOs8xtGnE
         Z51dnL5VwgoRRzum4jEsWMb8Z2pUL990dx9p53G2eKNSQ12xj5H+OK9lHFPZKv2wiBg+
         zehIENPNWGJxLOaK33rbyI0wj1LfN7n0cdvv2r98OaQNlGUKfPa361eUU2O4uGwovUeF
         Lil/JtNd4Mj7BnFqydzZGFWCPuIiWA3/R9qFfW9RbCuGFErPjciCN5qNJ//TYlJuf+hL
         D8RTMn05YsxWL6YO+wyn8OJpY+6p9Z62q+cibYHXVpNyCScreImEYI3pmqH+w7UgAm++
         wi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701227558; x=1701832358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J730iItaW8fpD9bcYiCc3WSDtwgBtsyA2Jb0R83edv4=;
        b=aUDKUoxey2DYV9p/jgeiVr8sjg/VOk0QVKz08ltiGxYPm/4SrABX+MhQBuTKweSual
         7KTnn47BOZrXyFyNFqQPscn/RAB3oBHoxmcUJRjR9weBs0w7IQkWrfZwF8/DVC54XTbb
         sXLAZQBP3Mq/cPcc/EA2DW3QAQCw9p1gS1riwX4Ka1N3l9Kmfg/jlaoCvtVjvOnQ5LjC
         mktZlaQCLYo7+1IHOY8FpUxP+RFjFpJL59Jc927lep8IkWv5sm4nQP5dGB5U/Kt54e0b
         jA2xNvn/YiwcT7J93v/1HvvyxyAOmFx3o3DBs5FfAInEi2Pte1ftgJhaWjyPdqxabe8o
         EpJQ==
X-Gm-Message-State: AOJu0Yypz6UzxWJ8seiAkyNIwQcpHBEkc2tXYRFY0bKr/Uq10bwffzil
	InS4n5d/PdX4Ucc1b/a5dl8=
X-Google-Smtp-Source: AGHT+IGYXLVo1NNNtgJ/QtuwkfBx/NejTGXsFL4B5BbOjJdwBdcu1OXTINGtvSssk1ZvptJWfIrOkQ==
X-Received: by 2002:a17:902:ab47:b0:1cf:cbf4:6f7e with SMTP id ij7-20020a170902ab4700b001cfcbf46f7emr9827526plb.14.1701227558738;
        Tue, 28 Nov 2023 19:12:38 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b001cfc46baa40sm5669287plx.158.2023.11.28.19.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 19:12:37 -0800 (PST)
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
Subject: [PATCH net-next v4 2/4] page_pool: halve BIAS_MAX for multiple user references of a fragment
Date: Wed, 29 Nov 2023 11:11:59 +0800
Message-Id: <20231129031201.32014-3-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231129031201.32014-1-liangchen.linux@gmail.com>
References: <20231129031201.32014-1-liangchen.linux@gmail.com>
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


