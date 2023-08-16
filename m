Return-Path: <netdev+bounces-27979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB66877DCEE
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C0528186A
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D415D521;
	Wed, 16 Aug 2023 09:04:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB74EC2F0
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3F6C433C7;
	Wed, 16 Aug 2023 09:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692176662;
	bh=REMwEjRAuGGUNub8MjF70Ki94HhcjToaLVxfqRVlIN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=by6qNAA3bF8j8o4Hf1DhqpEF0Wadt73h669D1uzBiCSkGg2XbxQ3T5mkwD7yif7t3
	 3QA9JybAQM4hfsePpGwD66U/17hpe8YdBSzvFpBONFgBGxdcCv/VzWoZOUxCVkQeSa
	 qVkOct89R5gMVRM3vi3Q8LYLH34xRL/pxTXFVStHUpGVBJ4/ADfKJOLV9v0EuOqfLe
	 KQ5XDdiKkEbFt4PDABhXHgj8fbmJ84HAHsYzFrGWNGpDaa2omZdEHP1RwrQ/AP6QZ9
	 RBmM2YZ8CEhF2mkASt+VOjbaWkDBd968rVUnjhN5Yv/j4BWZssa+tRrDBUejs1+kCQ
	 BMkr0vWfuVmTQ==
Date: Wed, 16 Aug 2023 11:04:18 +0200
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
	vladbu@nvidia.com, mleitner@redhat.com,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH RFC net-next 2/3] Expose tc block ports to the datapath
Message-ID: <ZNyREolbSoaMz8VA@vergenet.net>
References: <20230815162530.150994-1-jhs@mojatatu.com>
 <20230815162530.150994-3-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815162530.150994-3-jhs@mojatatu.com>

On Tue, Aug 15, 2023 at 12:25:29PM -0400, Jamal Hadi Salim wrote:
> The datapath can now find the block of the port in which the packet arrived at.
> It can then use it for various activities.
> 
> In the next patch we show a simple action that multicast to all ports except for
> the port in which the packet arrived on.
> 
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

...

> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index a976792ef02f..be4555714519 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c

...

> @@ -1737,9 +1738,12 @@ int tcf_classify(struct sk_buff *skb,
>  		 const struct tcf_proto *tp,
>  		 struct tcf_result *res, bool compat_mode)
>  {
> +	struct qdisc_skb_cb *qdisc_cb = qdisc_skb_cb(skb);

Hi Jamal,

Does the line above belong inside the condition immediately below?
It seems potentially unused otherwise.

>  #if !IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
>  	u32 last_executed_chain = 0;
>  
> +	qdisc_cb->block_index = block->index;
> +
>  	return __tcf_classify(skb, tp, tp, res, compat_mode, NULL, 0,
>  			      &last_executed_chain);
>  #else
> -- 
> 2.34.1
> 
> 

