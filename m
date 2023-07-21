Return-Path: <netdev+bounces-19970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 751D975D0EA
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EA51C21776
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B22D200D9;
	Fri, 21 Jul 2023 17:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE71F95D
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:51:44 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F9F30FF
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:51:42 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9926623e367so356565166b.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689961901; x=1690566701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qsue7q3KeO/R7eub1Ra03WnPj1VH7Ba7p54G2z6hqSg=;
        b=HHEIdoPNpIB2IsMwtzh8uMTIyv/FbrVcJKQIWtKehwssITRTPAp2hWU4fZ/ozaGW0E
         sk1LuTwET0GoQM66UGV3VHxMKjweJ8Oyu1Mf+RxeGZMGdICXrWJo/DuLsXaKrCCoYyXq
         gGWC1lwLqkQLFHilUzrEqawNmcKsPD5x61CBf4h245+37h7xuhbJt/oAQwIn0ZQGa8Xa
         aNdw7cJqtNaJ8zhTMS8V7ZsAZrtb3PjLtqETa2QGIk2nOdFMXvZVzXhtGMuGThEcHYlA
         nx8H7jV3SKVMeD7YnKpAOSTcd1JoNRDGRtbgZZ5RE/odHXM6QyuotVg/Z/CVs5lSZ4+F
         9kJQ==
X-Gm-Message-State: ABy/qLbL6wTzqtJb9iemFHlVKdll66g9IcldkS6ZeqEn6Rwac0RsOWji
	6M37asm8LVvixBWBCaJrUu3NPxJ6vCtjIhhq8nKi6M9n
X-Google-Smtp-Source: APBJJlFnitYnAsVMhi75TmNjXz79NR3xkB0MQZ393aIY035GJEywTCPgGz6X0GdM5XgaXpz1FIcsUw==
X-Received: by 2002:a17:906:5a5d:b0:99b:5a73:4d06 with SMTP id my29-20020a1709065a5d00b0099b5a734d06mr2039981ejc.20.1689961900994;
        Fri, 21 Jul 2023 10:51:40 -0700 (PDT)
Received: from localhost.members.linode.com ([2a01:7e01::f03c:93ff:fead:d776])
        by smtp.gmail.com with ESMTPSA id oy11-20020a170907104b00b0098822e05539sm2460669ejb.191.2023.07.21.10.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:51:40 -0700 (PDT)
From: valis <sec@valis.email>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pctammela@mojatatu.com,
	victor@mojatatu.com,
	ramdhan@starlabs.sg,
	billy@starlabs.sg
Subject: [PATCH net 1/3] net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free
Date: Fri, 21 Jul 2023 17:48:54 +0000
Message-Id: <20230721174856.3045-2-sec@valis.email>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721174856.3045-1-sec@valis.email>
References: <20230721174856.3045-1-sec@valis.email>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
Cc: stable@vger.kernel.org
---
 net/sched/cls_u32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 5abf31e432ca..19aa60d1eea7 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -826,7 +826,6 @@ static struct tc_u_knode *u32_init_knode(struct net *net, struct tcf_proto *tp,
 
 	new->ifindex = n->ifindex;
 	new->fshift = n->fshift;
-	new->res = n->res;
 	new->flags = n->flags;
 	RCU_INIT_POINTER(new->ht_down, ht);
 
-- 
2.30.2


