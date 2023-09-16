Return-Path: <netdev+bounces-34309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690EE7A3105
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 17:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4269B1C20B88
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA8914275;
	Sat, 16 Sep 2023 15:06:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE014015
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 15:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0675C433C7;
	Sat, 16 Sep 2023 15:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694876763;
	bh=LdwNM+hoVxGLKL8aspvRzHcYJa2o3pYdJ7X5XMKj9Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pa2ejGixJU/CeiUgyPXJ/HWjE4zIfIeGOMImJntAch1cRsfQBWqnE+WlryVn9hipp
	 ECwj/HGmE0613mT3jSGqw/l2OmoiaiDNiDxae2uSaqQiyqUKPgCpNQpueDIIsIKqBf
	 Jk7MbU+Iqa6p+YPHBMV6I9AEg+wdypMusllItwffOhm00C5PNcn9IxbYYUCXM79dQH
	 rn+IIVfyh9Qu01uX8lYbDTH5eacsrAIfqojHip1kRl9CD7AIY+ThxAXLJs9LiibBAm
	 EamLdr1wrxAUlORyiJD9Pkvzl9xEVmqQuFHaVxryZSNCr7+jr8IKyn1YHMr9bSw/JF
	 znTHP4bCn+jxA==
Date: Sat, 16 Sep 2023 17:05:58 +0200
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	sbhatta@marvell.com, edumazet@google.com, pabeni@redhat.com
Subject: Re: [net-next Patch] octeontx2-pf: Tc flower offload support for MPLS
Message-ID: <20230916150558.GD1125562@kernel.org>
References: <20230914110655.31222-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914110655.31222-1-hkelam@marvell.com>

On Thu, Sep 14, 2023 at 04:36:55PM +0530, Hariprasad Kelam wrote:

...

> @@ -738,6 +741,57 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
>  		}
>  	}
>  
> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_MPLS)) {
> +		struct flow_match_mpls match;
> +		u8 bit;
> +
> +		flow_rule_match_mpls(rule, &match);
> +
> +		if (match.mask->used_lses & OTX2_UNSUPP_LSE_DEPTH) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "unsupported LSE depth for MPLS match offload");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		for_each_set_bit(bit, (unsigned long *)&match.mask->used_lses,
> +				 FLOW_DIS_MPLS_MAX)  {
> +			/* check if any of the fields LABEL,TC,BOS are set */
> +			if (*((u32 *)&match.mask->ls[bit]) & 0xffffff00) {

Hi Hariprasad,

I wonder if we could avoid using the magic number 0xffffff00 above.
Perhaps ~MPLS_LS_TTL_MASK is appropriate?

Otherwise this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

