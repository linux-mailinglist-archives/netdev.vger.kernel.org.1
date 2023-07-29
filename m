Return-Path: <netdev+bounces-22545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4777F767F27
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 14:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08EA282643
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 12:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC5514AB3;
	Sat, 29 Jul 2023 12:32:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A841643B
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 12:32:28 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B32C2D71
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 05:32:26 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-768054797f7so252843885a.2
        for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 05:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690633945; x=1691238745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZU0afenvFJMfep7in4CutaC38zgJ4hrc4NI08nas3YE=;
        b=4sSseOJaGwrHQJcyu63vTO1fwIadcNt3Xc+1vJp6rmUVv9YlwBjkiWirDxVuOclZEN
         5Frg86Mf60wdlaJZXNfI2mR5SIzs883ygJNkWhSUTisMvn545l8SE5GPZBrqt3q3gjB+
         TZySN550n+RBJB0YHCTiT7/vh6ZOxvpsomzySIPXm43F2xMUQZbkyGL91+Yu7b6vyvzU
         8GkI7JqkPwtGpGmscENACK94INe9bYpID8L+RaPB15ieTkKRqrjjoytnqWRKoZeDlpyU
         fQzGMTk9ukpnShI8c5KpfvUsZV5F6hBpP6GvP3efyanKqA2SzKZ7u1ce7sP5JlF80Fds
         yQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690633945; x=1691238745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZU0afenvFJMfep7in4CutaC38zgJ4hrc4NI08nas3YE=;
        b=PJIPQHHPzNhzQKaZaJujpX2ycdpOufagdzE3/ddLfA6cT+4ZmEs37ozQu0LEnjKiqS
         aNOlfU7tBFrU1IDr8Ac3jFC6gWqGwBBEJB7p8ezLqfo4aYR6JzGNuMANvAqFV2bK6I02
         +IPFaYY+BUnQzBhofAowm+32ffSdnSJFeRQNV6mACNMtzovB7hvmusdK+cBxpDJaiDoz
         sDz2CAFqdaY0tHBBasX7LcR+9HbhllkUyQkIm1MPw3NgoVuCRiG7psk14H7MwqHFmeGy
         efwvM6qy3uFR2Fsp/1+Tcacdr/KvbPpgl25cj37mfFpxH9VcNpHks7OFFUAabemCeldV
         xsxQ==
X-Gm-Message-State: ABy/qLbtmzON6qpdho4GgXN9Z+Zi6VtrKJsVukZiGVH3uci9jlTSrmZE
	cDJwsDOZkNu0Co/Ur3OwqR/s4A==
X-Google-Smtp-Source: APBJJlFyjbtSWX4rGsjPSN48BRV0zA7+My3BBt8E2xEX+EcKPJCCTg+gQNNcnf4gxDmB4dLgwuGfVQ==
X-Received: by 2002:a05:620a:d81:b0:767:e04c:8d6e with SMTP id q1-20020a05620a0d8100b00767e04c8d6emr5534328qkl.51.1690633945537;
        Sat, 29 Jul 2023 05:32:25 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id x12-20020a0ce0cc000000b006263c531f61sm2024716qvk.24.2023.07.29.05.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 05:32:25 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	sec@valis.email,
	ramdhan@starlabs.sg,
	billy@starlabs.sg,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 1/3] net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free
Date: Sat, 29 Jul 2023 08:32:00 -0400
Message-Id: <20230729123202.72406-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230729123202.72406-1-jhs@mojatatu.com>
References: <20230729123202.72406-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: valis <sec@valis.email>

When u32_change() is called on an existing filter, the whole
tcf_result struct is always copied into the new instance of the filter.

This causes a problem when updating a filter bound to a class,
as tcf_unbind_filter() is always called on the old instance in the
success path, decreasing filter_cnt of the still referenced class
and allowing it to be deleted, leading to a use-after-free.

Fix this by no longer copying the tcf_result struct from the old filter.

Fixes: de5df63228fc ("net: sched: cls_u32 changes to knode must appear atomic to readers")
Reported-by: valis <sec@valis.email>
Reported-by: M A Ramdhan <ramdhan@starlabs.sg>
Signed-off-by: valis <sec@valis.email>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_u32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 907e58841fe8..da4c179a4d41 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -826,7 +826,6 @@ static struct tc_u_knode *u32_init_knode(struct net *net, struct tcf_proto *tp,
 
 	new->ifindex = n->ifindex;
 	new->fshift = n->fshift;
-	new->res = n->res;
 	new->flags = n->flags;
 	RCU_INIT_POINTER(new->ht_down, ht);
 
-- 
2.34.1


