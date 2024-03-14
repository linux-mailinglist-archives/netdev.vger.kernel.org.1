Return-Path: <netdev+bounces-79890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F387BEB5
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63795B22B04
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC716FE06;
	Thu, 14 Mar 2024 14:18:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA796FE03
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425880; cv=none; b=utASkgN4xpoWQHN+GXDuGtnmk/RJcWJlXq7RU7YsKtF0BUIDM2tKguh4qtDn1tCyFr0VtmbovwzDbl4LV6Z6ktTHAME5YFTXdMXLH4GCNNv/RXac4HJG3zB/ubPcdYR+yY4n95A/0Fkt1A/H5xwM6RE59/vR2o6MtCvUyNHZxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425880; c=relaxed/simple;
	bh=QJTM+yoIukNkHsnskXPzBT52aY04xci+PyNqa1OkG7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzszCxNJOnTbPOd9ooQGBxk5xnXMZoTiohORJGY9jAaZfc0GmIlZIpPPkdofZCr2Pj5sp3/QvQnXjM5rmhGqqOSSsez2NQeYG3vNIWnlQQnwgr73DTZZCsYPTgnOyaVVewhgeCIZX9Tik1/1vyVgiESMXH/32FsLgP0ZIASf9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TwTtN6w81z2BgBX;
	Thu, 14 Mar 2024 22:15:24 +0800 (CST)
Received: from dggpemd100005.china.huawei.com (unknown [7.185.36.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 4225D1A0172;
	Thu, 14 Mar 2024 22:17:53 +0800 (CST)
Received: from localhost.huawei.com (10.137.16.203) by
 dggpemd100005.china.huawei.com (7.185.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 14 Mar 2024 22:17:52 +0800
From: renmingshuai <renmingshuai@huawei.com>
To: <jiri@resnulli.us>
CC: <caowangbao@huawei.com>, <davem@davemloft.net>, <jhs@mojatatu.com>,
	<liaichun@huawei.com>, <netdev@vger.kernel.org>, <renmingshuai@huawei.com>,
	<vladbu@nvidia.com>, <xiyou.wangcong@gmail.com>, <yanan@huawei.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter attached to the egress
Date: Thu, 14 Mar 2024 22:04:30 +0800
Message-ID: <20240314140430.3682-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <ZfLi17TuJpcd6KFb@nanopsycho>
References: <ZfLi17TuJpcd6KFb@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd100005.china.huawei.com (7.185.36.102)

>>---
>> net/sched/act_mirred.c                        |  4 +++
>> .../tc-testing/tc-tests/actions/mirred.json   | 32 +++++++++++++++++++
>> 2 files changed, 36 insertions(+)
>>
>>diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
>>index 5b3814365924..fc96705285fb 100644
>>--- a/net/sched/act_mirred.c
>>+++ b/net/sched/act_mirred.c
>>@@ -120,6 +120,10 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> 		NL_SET_ERR_MSG_MOD(extack, "Mirred requires attributes to be passed");
>> 		return -EINVAL;
>> 	}
>>+	if (tp->chain->block->q->parent != TC_H_INGRESS) {
>>+		NL_SET_ERR_MSG_MOD(extack, "Mirred can only be assigned to the filter attached to ingress");
>
>Hmm, that is quite restrictive. I'm pretty sure you would break some
>valid usecases.
Hmm, that is really quite restrictive. It might be better to Forbid mirred attached to egress filter
to mirror or redirect packets to the egress.

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index fc96705285fb..ab3841470992 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -152,6 +152,11 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
                return -EINVAL;
        }

+       if ((tp->chain->block->q->parent != TC_H_INGRESS) && (parm->eaction == TCA_EGRESS_MIRROR || parm->eaction == TCA_EGRESS_REDIR)) {
+               NL_SET_ERR_MSG_MOD(extack, "Mirred assigned to egress filter can only mirror or redirect to ingress");
+               return -EINVAL;
+       }
+
        switch (parm->eaction) {
        case TCA_EGRESS_MIRROR:
        case TCA_EGRESS_REDIR:

