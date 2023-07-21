Return-Path: <netdev+bounces-19969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 454BE75D0E5
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F4B1C2178A
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58E9200D6;
	Fri, 21 Jul 2023 17:50:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999DA27F00
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:50:42 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC7E30FF
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:50:36 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-993d1f899d7so351491866b.2
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689961835; x=1690566635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FoY4di1zk4+4cLRxmr0huhu+U7XsnWGFHlmoXGlmVkQ=;
        b=JCwopZm9TzUflWCRsMm6dtW3eJ7sTqXavwevglgMM2DBELwndxEOUe92Vj0W3EEJBz
         u4Mbkx+x+HN4P4HxOiYMgTpy8OiWAiQPgg2KiuxM/j8M2LWTH1OEuOUbKaYsf8y8oy8l
         o2WGE9tEHLny9u4G9rOM7RPTh6sJq9OH+2MpWPzBnTlEmEZaUn2UDk4Ut0aSxsaMdwL9
         jm8iLpHx31E9vWXK+NZNj9luFH56UtPXTnmQvf2pIjoAAIdnMSVDjc5rwKxjcrv3VGni
         oUyJ3aZFSX2Aaxk8HPoJ2cjTd1gvktXYzhajH0iH58PWiiThRSeHB4DDq82Ze0rTdQDU
         rzSQ==
X-Gm-Message-State: ABy/qLYoWJ//hWw9FaQHz8+hjEdrZugo1j2bnwq2kT4IXCxfSGy/4mfH
	SYp36occnoeaKoy9ZLASJRXF/m3em9wMRyoQCupGfbtp
X-Google-Smtp-Source: APBJJlE3jpcwL4zGvNngj2ew8zHOlYBod9GLJGHnuGWGG8nZw2UpQ6F+PwT1XmhMYCyowahIMw2reg==
X-Received: by 2002:a17:907:75d0:b0:993:da87:1c7b with SMTP id jl16-20020a17090775d000b00993da871c7bmr2176184ejc.10.1689961834981;
        Fri, 21 Jul 2023 10:50:34 -0700 (PDT)
Received: from localhost.members.linode.com ([2a01:7e01::f03c:93ff:fead:d776])
        by smtp.gmail.com with ESMTPSA id oy11-20020a170907104b00b0098822e05539sm2460669ejb.191.2023.07.21.10.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:50:34 -0700 (PDT)
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
Subject: [PATCH net 0/3] net/sched Bind logic fixes for cls_fw, cls_u32 and cls_route
Date: Fri, 21 Jul 2023 17:48:53 +0000
Message-Id: <20230721174856.3045-1-sec@valis.email>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Three classifiers (cls_fw, cls_u32 and cls_route) always copy 
tcf_result struct into the new instance of the filter on update.

This causes a problem when updating a filter bound to a class,
as tcf_unbind_filter() is always called on the old instance in the 
success path, decreasing filter_cnt of the still referenced class 
and allowing it to be deleted, leading to a use-after-free.

This patch set fixes this issue in all affected classifiers by no longer
copying the tcf_result struct from the old filter.

valis (3):
  net/sched: cls_u32: No longer copy tcf_result on update to avoid
    use-after-free
  net/sched: cls_fw: No longer copy tcf_result on update to avoid
    use-after-free
  net/sched: cls_route: No longer copy tcf_result on update to avoid
    use-after-free

 net/sched/cls_fw.c    | 1 -
 net/sched/cls_route.c | 1 -
 net/sched/cls_u32.c   | 1 -
 3 files changed, 3 deletions(-)

-- 
2.30.2


