Return-Path: <netdev+bounces-50705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 152C27F6CF1
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 08:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A6DB20FB8
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 07:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E887E5247;
	Fri, 24 Nov 2023 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA8rtDH5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94F7D4E
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 23:35:26 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-280351c32afso1414422a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 23:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700811326; x=1701416126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wf42jdW+6K8AfiyHVKHn1gShiAo7E/o6JslnDYKix8=;
        b=LA8rtDH57cmU9cXm8gNs6G6kFsgPvmHHZcRB77XRmZcJv/9F/eUnHs+aHj/6au/jX9
         n24+Z3jvIua5VbuhiXhTSCGz9MNpDm+M5RC3/HhNl5uCLck5TyloqFG/81QjR17Ey8lv
         yX4Uxui8Hwm4XRUol/uGbuaeBW/Wh9tY9+sEoX8X9c11HzDz7Ss1kcveOixWABWzRw9o
         WsV00wkTHv193aMp0KNJQ7wRCmtPZHGgppl0V+vA4ZlVwjXK4SP1W7QXQ9CyDYMJbGA8
         ZYnDPoj0vSvPNiRdviZkNBT4c3C4yDaDI9FNCUe7R+kqWpjfX2JJuKaw1nBAZXknavQJ
         /wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700811326; x=1701416126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wf42jdW+6K8AfiyHVKHn1gShiAo7E/o6JslnDYKix8=;
        b=Q+HkqUgcp+/ljc7QlLyBGOWaGtq64cZ8sorOrZLPNJTrPVXysEfr3fZXSDnP94AnLD
         FdRxuSdU8btz09bwXHIXApr8LiX57kdg2gb2tDm7T1JiI77xApIl3vOKJhQ/sldixSWr
         fKj+BHZ3cihNqQfOHmxea2gLIFEv4WyMLU//2QnYU8SPvmznInMPj315eGghhNKrce/h
         /HX5uXt6aNM6phsCIYEhDlgdX+n0Ol3FkZPLGpWRno1ASaeheaShdfzBQeuF9Pxs9p1y
         Vox3fCVW8w2qUN3udReiFJbyYwwuWrUAy8vnOWRToSEjeAxbcYIb+mcViBJKD86n1Pkb
         ePlw==
X-Gm-Message-State: AOJu0YxiIoemRm0gwz5SkW+2F0GxBoDTZaD09IZMhpqoQ2GSJ/4zTdMh
	8h/NHqSyITJDQ0w/Sm5ROdg=
X-Google-Smtp-Source: AGHT+IFqMZHO8+ERbxfOGumOXWVCKIXwMpvkdMGN1wW1029LzQCwFYJqLpbWoY21lciZ/9bahTIfaw==
X-Received: by 2002:a17:90a:bb95:b0:285:68f3:80c0 with SMTP id v21-20020a17090abb9500b0028568f380c0mr1910144pjr.12.1700811325979;
        Thu, 23 Nov 2023 23:35:25 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902e84f00b001b9d7c8f44dsm2499329plg.182.2023.11.23.23.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:35:24 -0800 (PST)
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
Subject: [PATCH net-next v3 2/3] page_pool: halve BIAS_MAX for fragment multiple user references
Date: Fri, 24 Nov 2023 15:34:38 +0800
Message-Id: <20231124073439.52626-3-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231124073439.52626-1-liangchen.linux@gmail.com>
References: <20231124073439.52626-1-liangchen.linux@gmail.com>
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
---
 net/core/page_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 0c6c2b11aabe..24b83dfe6968 100644
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


