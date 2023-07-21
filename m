Return-Path: <netdev+bounces-19972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9686D75D0EF
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C85281E70
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D47200DB;
	Fri, 21 Jul 2023 17:52:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D11F95D
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:52:00 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A30635B3
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:51:56 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9928abc11deso339920266b.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689961914; x=1690566714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frEdms5HYbKWvE7jkMnHGSIO92fXsFYBjlqmZl6Wyo4=;
        b=RNkqx+b8avEIvMpkaAuKDT60fqybpNACbJqZHarXXTnNUM13SqWfAyQxJmGx9Rdkhg
         3E4tQ9GToFF3hX3950b0FrUmgPmM7AF7QcIfDuiH0FkmeoOH/qcTPL6eTluHJpghKbki
         TL8bWcfT/lW1YryMUbHnekFCiLeoFT7tsfYqaiXrhoL+WDRQrL6L20o4MIBNMO8EMeVJ
         nT30lpmhUFlL2KFIFQd/mSjVt/k4TbFLn6END3vHNpPmRCcBTyIOqW8qExcfN5j0gKb1
         zKCjGf600XuDBEB1kW/Ikh22MENyEYFKiQuvCaZXho9urBEPfUiyV01rV2/MMFnFk6xe
         C7Bw==
X-Gm-Message-State: ABy/qLbMNY9fEvkohgJcqWkVSkc8jQAP58ZEF4lXtHXqctx2l0Lz+Gm5
	v5Yx37iNw7XrkMAKEIal/ZMIQWQ+5/UN1AJNcsX14MGq
X-Google-Smtp-Source: APBJJlEsHGb0aT+5HeHhKudgXlsu7zv83ut4WTjlLfkSjHBuUawno53l7uhF4qlI8yMvFlVF1EZsog==
X-Received: by 2002:a17:906:778e:b0:994:3395:942f with SMTP id s14-20020a170906778e00b009943395942fmr2348646ejm.17.1689961914717;
        Fri, 21 Jul 2023 10:51:54 -0700 (PDT)
Received: from localhost.members.linode.com ([2a01:7e01::f03c:93ff:fead:d776])
        by smtp.gmail.com with ESMTPSA id oy11-20020a170907104b00b0098822e05539sm2460669ejb.191.2023.07.21.10.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:51:54 -0700 (PDT)
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
Subject: [PATCH net 3/3] net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free
Date: Fri, 21 Jul 2023 17:48:56 +0000
Message-Id: <20230721174856.3045-4-sec@valis.email>
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

When route4_change() is called on an existing filter, the whole
tcf_result struct is always copied into the new instance of the filter.

This causes a problem when updating a filter bound to a class,
as tcf_unbind_filter() is always called on the old instance in the 
success path, decreasing filter_cnt of the still referenced class 
and allowing it to be deleted, leading to a use-after-free.

Fix this by no longer copying the tcf_result struct from the old filter.

Fixes: 1109c00547fc ("net: sched: RCU cls_route")
Reported-by: valis <sec@valis.email>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Signed-off-by: valis <sec@valis.email>
Cc: stable@vger.kernel.org
---
 net/sched/cls_route.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index d0c53724d3e8..1e20bbd687f1 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -513,7 +513,6 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	if (fold) {
 		f->id = fold->id;
 		f->iif = fold->iif;
-		f->res = fold->res;
 		f->handle = fold->handle;
 
 		f->tp = fold->tp;
-- 
2.30.2


