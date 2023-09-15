Return-Path: <netdev+bounces-34188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41CB7A283D
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 22:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D361C20F53
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD61511CA0;
	Fri, 15 Sep 2023 20:37:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697CB18E1F
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 20:37:32 +0000 (UTC)
Received: from out-229.mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F32FFB
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:37:28 -0700 (PDT)
Message-ID: <fda205c8-9b68-3333-a790-6191a03e0b67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694810246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9jUf0AezV9CUepWS4dSseHstKPiBlVXkzsuiSmuKZs=;
	b=cWsad2eNPDi2UIKGOD+rK2TaN1QvhdjuQcX8rGNgy8SnfvjEzileHeOHufHGj3aDmLH3MZ
	HTlyOocTWSj8YttEdbm9iyjRYNjHDlkY6KIxhOP3SPGMhhVN4H2QJ2jI4BBIXQ4my0x2I+
	l/4eRZcSrWx2fUkUpdRgaB8UEBOexiQ=
Date: Fri, 15 Sep 2023 21:37:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: sched: drr: dont intepret cls results when asked to
 drop
To: Ma Ke <make_ruc2021@163.com>, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230915142056.3411330-1-make_ruc2021@163.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230915142056.3411330-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 15/09/2023 15:20, Ma Ke wrote:
> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
> assume that res.class contains a valid pointer.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>   net/sched/sch_drr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
> index 19901e77cd3b..a535dc3b0e05 100644
> --- a/net/sched/sch_drr.c
> +++ b/net/sched/sch_drr.c
> @@ -310,6 +310,8 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
>   	fl = rcu_dereference_bh(q->filter_list);
>   	result = tcf_classify(skb, NULL, fl, &res, false);
>   	if (result >= 0) {
> +		if (result == TC_ACT_SHOT)
> +			return NULL;

With CONFIG_NET_CLS_ACT undefined tcf_classify can only return
TC_ACT_UNSPEC and the if statement above is always false.

Do you have any real issue you are trying to fix?

>   #ifdef CONFIG_NET_CLS_ACT
>   		switch (result) {
>   		case TC_ACT_QUEUED:
> @@ -317,8 +319,6 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
>   		case TC_ACT_TRAP:
>   			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
>   			fallthrough;
> -		case TC_ACT_SHOT:
> -			return NULL;
>   		}
>   #endif
>   		cl = (struct drr_class *)res.class;


