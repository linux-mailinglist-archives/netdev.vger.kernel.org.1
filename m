Return-Path: <netdev+bounces-56231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE0A80E375
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC82A282D7A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FD6D518;
	Tue, 12 Dec 2023 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkKGnFWe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428889B
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:47:01 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d0bb7ff86cso46331365ad.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702356421; x=1702961221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J730iItaW8fpD9bcYiCc3WSDtwgBtsyA2Jb0R83edv4=;
        b=ZkKGnFWe2QV4MqqwdVSC7SMyPkbhdAPYeHdb4/caoktTHYJ0eX2i63brwyoILJPzqL
         RLm1OjKrOELD0Q3D51k3ahOVvqVUrXPuqty0thQ1jpcnCLvS0CjO5Ks4rhZ5Ghlg6iXz
         Y8Rd2NL7u5nylehT5O8fgtrBgFsWadsrvpVaRAK4aYVYwegPBjA6e8g88F7DCLFzAAWa
         EefmIk/+hACRXGxZ5kUIaO8ZVm0OIccN0MRkxk7l/OzSGejo5StY7G3+pyri8XatPabA
         c2YEoxhp1yZmDOP4Ncui9JAPs+m6k9am18GVvw3Wb7oy59fJd3zlQuXLTac6JVFIHIDv
         7UwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702356421; x=1702961221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J730iItaW8fpD9bcYiCc3WSDtwgBtsyA2Jb0R83edv4=;
        b=M5jP4kx1ADOAJjLyYgXayJ94TVAD7i3YFdnYKTkS3lzvb2rXRr1BkqS8nZXYj2Or8v
         jLsHgE6o6xdVLjEidOUXH/nK0ofk3AI3n3XWx2FTEAmU5u0osOtdudFAp/KK36kxIHe7
         Oq0f5Qr2/TlIOgflglkLZ8twIk0CVrVSLd4LL3m1+N8tZlcgUZWX7CgEvTMrScmgLsid
         crDV5lcEq8FGQoOHXyMlXZgM4GX6zsFpZlAmgximfiAqDmT2TkUUtDL6JwZKR1C15Qjg
         t4pGgoMM4r/uSknusK+B3+TcAQr2H2S9gSh67ticF+4OqBzKEMAByQKJjf3ZDTyZapi2
         V7CA==
X-Gm-Message-State: AOJu0Yz/LkSArwemf4fmvqgAh2sKVCJo0K921G+/vG/Az47JEP85DDxX
	jygoul1trATXmrqbz9WGLVA=
X-Google-Smtp-Source: AGHT+IGkzBHebNvw/5HRjapPZ7VK4RiFwjvP7xk1riUV6fcwFnr0QZYg5hhTZoUbfC4Fx2LxXV47Mw==
X-Received: by 2002:a17:903:1210:b0:1d1:cc20:451d with SMTP id l16-20020a170903121000b001d1cc20451dmr6921252plh.65.1702356420717;
        Mon, 11 Dec 2023 20:47:00 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902848300b001d33e6521b9sm36143plo.14.2023.12.11.20.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:46:59 -0800 (PST)
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
	almasrymina@google.com,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v9 2/4] page_pool: halve BIAS_MAX for multiple user references of a fragment
Date: Tue, 12 Dec 2023 12:46:12 +0800
Message-Id: <20231212044614.42733-3-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212044614.42733-1-liangchen.linux@gmail.com>
References: <20231212044614.42733-1-liangchen.linux@gmail.com>
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


