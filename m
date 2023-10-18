Return-Path: <netdev+bounces-42333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F8D7CE585
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE95B281BE8
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C86F3FE23;
	Wed, 18 Oct 2023 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="MsbIat7T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41713FB39
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 17:57:01 +0000 (UTC)
Received: from mx05lb.world4you.com (mx05lb.world4you.com [81.19.149.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498BA12E;
	Wed, 18 Oct 2023 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j0ePCYNkPHfa3H9jsrngby8guSC1IWe7RaxvVj9+FaY=; b=MsbIat7TOKssl45DTO3nM5wmxE
	y4eZYVNBvf4HdsA/3JbF4kBevsI3uOGqi7wrPp0pRp/d6ryREYJXDTdJdWzIaQxu18ck1G82Mar+c
	LZQXGdbeMAvIekOsX4xhUaF8UJiSQ9x28NaWzp80FlmEWWQMFsWE/aJQClvEnikF7I3Q=;
Received: from [88.117.60.21] (helo=[10.0.0.160])
	by mx05lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1qtAmk-00007M-2X;
	Wed, 18 Oct 2023 19:56:46 +0200
Message-ID: <27912b49-eb1a-4100-a260-03299e8efdd4@engleder-embedded.com>
Date: Wed, 18 Oct 2023 19:56:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/1] taprio: Add boundary check for
 sched-entry values
To: Lai Peter Jun Ann <jun.ann.lai@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1697599707-3546-1-git-send-email-jun.ann.lai@intel.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <1697599707-3546-1-git-send-email-jun.ann.lai@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18.10.23 05:28, Lai Peter Jun Ann wrote:
> Adds boundary checks for the gatemask provided against the number of
> traffic class defined for each sched-entry.
> 
> Without this check, the user would not know that the gatemask provided is
> invalid and the driver has already truncated the gatemask provided to
> match the number of traffic class defined.
> 
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> ---
>   net/sched/sch_taprio.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 1cb5e41..44b9e21 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -102,6 +102,7 @@ struct taprio_sched {
>   	u32 max_sdu[TC_MAX_QUEUE]; /* save info from the user */
>   	u32 fp[TC_QOPT_MAX_QUEUE]; /* only for dump and offloading */
>   	u32 txtime_delay;
> +	u8 num_tc;
>   };
>   
>   struct __tc_taprio_qopt_offload {
> @@ -1063,6 +1064,11 @@ static int fill_sched_entry(struct taprio_sched *q, struct nlattr **tb,
>   		return -EINVAL;
>   	}
>   
> +	if (entry->gate_mask >= q->num_tc) {

As far as I know within gate_mask every bit represents a traffic class.
So for 3 traffic classes at gate_mask of 0x7 is valid but this check
fails with 0x7 >= 3.

> +		NL_SET_ERR_MSG(extack, "Traffic Class defined less than gatemask");
> +		return -EINVAL;
> +	}
> +
>   	entry->interval = interval;
>   
>   	return 0;
> @@ -1913,6 +1919,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
>   		for (i = 0; i <= TC_BITMASK; i++)
>   			netdev_set_prio_tc_map(dev, i,
>   					       mqprio->prio_tc_map[i]);
> +
> +		q->num_tc = mqprio->num_tc;
>   	}
>   
>   	err = parse_taprio_schedule(q, tb, new_admin, extack);

