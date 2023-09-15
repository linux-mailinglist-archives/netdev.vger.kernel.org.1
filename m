Return-Path: <netdev+bounces-34190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A5C7A2859
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 22:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9BD1C2032D
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAF21B26D;
	Fri, 15 Sep 2023 20:45:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22E11CAA
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 20:45:19 +0000 (UTC)
Received: from out-228.mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282D9186
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:45:18 -0700 (PDT)
Message-ID: <aaa5aa34-6437-5013-ea3f-95330614908a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694810716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZu5o0cgVYXAFH7d9696U+gHAz/I7CL0OXnkm5dCDf8=;
	b=ArCTnuBFrZVZMvsfRzsFhqroZehMZUBRALdUc4bMzmQq2Q7492lBhGukC9uInB4RKhrBz2
	7ehHSbx2VaI3j8kX6772ZWNTwZtohLKarNF9PJFco5jmi3IkQtEVRK2Yu9CPOrOuyV6aBI
	qFnY9fBRoFi2xRIgc83tvyG7JBzFIk4=
Date: Fri, 15 Sep 2023 21:45:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: sched: qfq: dont intepret cls results when asked to
 drop
Content-Language: en-US
To: Ma Ke <make_ruc2021@163.com>, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230915142355.3411527-1-make_ruc2021@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230915142355.3411527-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 15/09/2023 15:23, Ma Ke wrote:
> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
> assume that res.class contains a valid pointer.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>   net/sched/sch_qfq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index 546c10adcacd..91c323eff012 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -696,6 +696,8 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
>   	fl = rcu_dereference_bh(q->filter_list);
>   	result = tcf_classify(skb, NULL, fl, &res, false);
>   	if (result >= 0) {
> +		if (result == TC_ACT_SHOT)
> +			return NULL;

The same comment again - the check is meaningless.

>   #ifdef CONFIG_NET_CLS_ACT
>   		switch (result) {
>   		case TC_ACT_QUEUED:
> @@ -703,8 +705,6 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
>   		case TC_ACT_TRAP:
>   			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
>   			fallthrough;
> -		case TC_ACT_SHOT:
> -			return NULL;
>   		}
>   #endif
>   		cl = (struct qfq_class *)res.class;


