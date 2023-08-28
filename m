Return-Path: <netdev+bounces-31119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C43478B8B0
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 21:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE760280EDF
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 19:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6059A14268;
	Mon, 28 Aug 2023 19:53:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752D134D4
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 19:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF402C433C7;
	Mon, 28 Aug 2023 19:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693252381;
	bh=Yom10pS92wdRSYs7MMH5STtco6BRgjP6/p9EqBRAtn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S3y0uSMMhuCiroW6/i3cm8cWt/rUUu7A/IVUuA75uDni5AeV48nudNPi0DUvQRVkI
	 Se9m0CZAqNNAsyjvY0jW9yrl7/wykk1zSvcnwUTgwlQhV8htZjnIIBnGU4+4T2sq6d
	 NRYceHtdB7PjsuIxggiDCyTLWMgNS+ID7Fc5Ihnk5vfDAAnqS3HatBjyKamdOV0SwL
	 ItMEhZDBzYNBeJmv8UzgyyoolVoS9lTrrl1EtudQshAK19M/mqeyB707765w1WxztM
	 7PogX19kFLP1+3vdJud06+zyyaBYfEnHh9PofWIO/mK7kDObbAV1eA/1gAYvU2zttn
	 dPtnupeW3IIMA==
Date: Mon, 28 Aug 2023 12:52:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, victor@mojatatu.com
Subject: Re: [PATCH net-next v2 4/4] net/sched: cls_route: make netlink
 errors meaningful
Message-ID: <20230828125259.13361cbb@kernel.org>
In-Reply-To: <20230825155148.659895-5-pctammela@mojatatu.com>
References: <20230825155148.659895-1-pctammela@mojatatu.com>
	<20230825155148.659895-5-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Aug 2023 12:51:48 -0300 Pedro Tammela wrote:
> Use netlink extended ack and parsing policies to return more meaningful
> errors instead of the relying solely on errnos.

Hm, I don't see the changes to the policy, or anything meaningful 
in the existing one.

> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index 1e20bbd687f1..b34cf02c6c51 100644
> --- a/net/sched/cls_route.c
> +++ b/net/sched/cls_route.c
> @@ -400,30 +400,32 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
>  		if (new && handle & 0x8000)
>  			return -EINVAL;
>  		to = nla_get_u32(tb[TCA_ROUTE4_TO]);
> -		if (to > 0xFF)
> -			return -EINVAL;
>  		nhandle = to;
>  	}
>  
> +	if (tb[TCA_ROUTE4_FROM] && tb[TCA_ROUTE4_IIF]) {
> +		NL_SET_ERR_MSG(extack,
> +			       "'from' and 'fromif' are mutually exclusive");

Let's point at one of them? NL_SET_ERR_MSG_ATTR() ?

> +		return -EINVAL;
> +	}
> +
>  	if (tb[TCA_ROUTE4_FROM]) {
> -		if (tb[TCA_ROUTE4_IIF])
> -			return -EINVAL;
>  		id = nla_get_u32(tb[TCA_ROUTE4_FROM]);
> -		if (id > 0xFF)
> -			return -EINVAL;
>  		nhandle |= id << 16;
>  	} else if (tb[TCA_ROUTE4_IIF]) {
>  		id = nla_get_u32(tb[TCA_ROUTE4_IIF]);
> -		if (id > 0x7FFF)
> -			return -EINVAL;
>  		nhandle |= (id | 0x8000) << 16;
>  	} else
>  		nhandle |= 0xFFFF << 16;
>  
>  	if (handle && new) {
>  		nhandle |= handle & 0x7F00;
> -		if (nhandle != handle)
> +		if (nhandle != handle) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "Unexpected handle %x (expected %x)",
> +					   handle, nhandle);

How about: Handle mismatch constructed: %x (expected: %x)?

>  			return -EINVAL;
> +		}
>  	}
>  
>  	if (!nhandle) {
> @@ -478,7 +480,6 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
>  	struct route4_filter __rcu **fp;
>  	struct route4_filter *fold, *f1, *pfp, *f = NULL;
>  	struct route4_bucket *b;
> -	struct nlattr *opt = tca[TCA_OPTIONS];
>  	struct nlattr *tb[TCA_ROUTE4_MAX + 1];
>  	unsigned int h, th;
>  	int err;
> @@ -489,10 +490,12 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
>  		return -EINVAL;
>  	}
>  
> -	if (opt == NULL)
> +	if (NL_REQ_ATTR_CHECK(extack, NULL, tca, TCA_OPTIONS)) {
> +		NL_SET_ERR_MSG_MOD(extack, "missing options");
>  		return -EINVAL;
> +	}
>  
> -	err = nla_parse_nested_deprecated(tb, TCA_ROUTE4_MAX, opt,
> +	err = nla_parse_nested_deprecated(tb, TCA_ROUTE4_MAX, tca[TCA_OPTIONS],
>  					  route4_policy, NULL);
>  	if (err < 0)
>  		return err;
-- 
pw-bot: cr

