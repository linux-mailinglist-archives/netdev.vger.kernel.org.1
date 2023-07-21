Return-Path: <netdev+bounces-19971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7B875D0EE
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C5A2823F8
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293A20F84;
	Fri, 21 Jul 2023 17:51:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A7C1F95D
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:51:48 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FDD3583
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:51:47 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-992ace062f3so347594866b.2
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689961906; x=1690566706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSijvnszXhE3b49+Y3EXbvfDOtBUeH5bGFxEhu9ubiE=;
        b=SZoRImxpSGYZZtnj05Wibq95btTc3goh5/E2+lZ8nfJlyOyAyeWjZHurSWzdkSidVr
         4PcXa/QpPeoBsH9JiiPBrLQdEWG2cWgRaDi+q2hLrN9MsM8/JTqkC8yNaNpJpWbfzoQz
         ULNpxuO0YnOce4NpogAuXhcN5nvaTqA/LrRi0Uf//KywrsbvsRvdPtUxRt2FkWWPzRza
         jbM9TSHAWFtKcIz9d5owEy6+3vZFzKdg5AAe3Wwyge9nup08p1A7xVq6fQhhLJXW4LS5
         hiNLgDnKSyoOcEcoY2Vj0uk8PxL+kdX+iY06Ls1ARgS4R+Zg7lJGrf82QF38yyq75xEa
         2ggg==
X-Gm-Message-State: ABy/qLbNmCfAMeJxAolIyD2/ZbzyjqTyBzEvvNL5suK0EYqD6iO5TS87
	259QTUogaXE2NCZrHErea+qlBvwgttlv/EDdtW81kiE/
X-Google-Smtp-Source: APBJJlEZ+TydG6NTi8Vd58b5mUky/i6/GfdgaLfS6m4vlCcnFXzzOMISWRUyz/WWu5PvYoj2a3ObRg==
X-Received: by 2002:a17:906:11a:b0:991:fef4:bb9 with SMTP id 26-20020a170906011a00b00991fef40bb9mr2222822eje.58.1689961905884;
        Fri, 21 Jul 2023 10:51:45 -0700 (PDT)
Received: from localhost.members.linode.com ([2a01:7e01::f03c:93ff:fead:d776])
        by smtp.gmail.com with ESMTPSA id oy11-20020a170907104b00b0098822e05539sm2460669ejb.191.2023.07.21.10.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:51:45 -0700 (PDT)
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
Subject: [PATCH net 2/3] net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
Date: Fri, 21 Jul 2023 17:48:55 +0000
Message-Id: <20230721174856.3045-3-sec@valis.email>
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

When fw_change() is called on an existing filter, the whole
tcf_result struct is always copied into the new instance of the filter.

This causes a problem when updating a filter bound to a class,
as tcf_unbind_filter() is always called on the old instance in the 
success path, decreasing filter_cnt of the still referenced class 
and allowing it to be deleted, leading to a use-after-free.

Fix this by no longer copying the tcf_result struct from the old filter.

Fixes: e35a8ee5993b ("net: sched: fw use RCU")
Reported-by: valis <sec@valis.email>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Signed-off-by: valis <sec@valis.email>
Cc: stable@vger.kernel.org
---
 net/sched/cls_fw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index 8641f8059317..c49d6af0e048 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -267,7 +267,6 @@ static int fw_change(struct net *net, struct sk_buff *in_skb,
 			return -ENOBUFS;
 
 		fnew->id = f->id;
-		fnew->res = f->res;
 		fnew->ifindex = f->ifindex;
 		fnew->tp = f->tp;
 
-- 
2.30.2


