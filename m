Return-Path: <netdev+bounces-249476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF08ED19A54
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67AD83002940
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF3A2BD5B4;
	Tue, 13 Jan 2026 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koHONHtz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8502882D0
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316240; cv=none; b=g/wA8hV6NiS1/I8Cr4D++jKlDxpzDAJQokIhpvD2wQtUPS0uCtkvAWqVIgaMC4Urx5VoSDuh6G+q8OfJCO0puqVFRWvz3AiU+3PX0CMdtjLWjwYZekvw2quBFglhFNV0Iz6Q2WVvOG8xTasUW5OP7IK7MGeAanCfZfDn5wap6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316240; c=relaxed/simple;
	bh=YWHxoLNGH2PLo0cBwASlxNC9mjTQKZKN1bkIjvL6+rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecwgtS6RI7lb+ecFezYJoznvVL1Nqy4GeKHPP8IoyazDzjyVKCTct1cooIZGA9c9P2Iwb1FSzJVGduz3p4OnqHCznz5h8qljQooolzisxCjT+8aKqpTNGQY3Xd3pPCpJvFvZZRc/+4rp6I4wVzyZTIgGhJ9P8WHon1xrYBEtyCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koHONHtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E0BC116C6;
	Tue, 13 Jan 2026 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768316240;
	bh=YWHxoLNGH2PLo0cBwASlxNC9mjTQKZKN1bkIjvL6+rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=koHONHtzToSZC71NWMBPbrRdd3uEBYmE76CrUIIoOBNzJOuG/R7MIPpXM8LgbBQ6A
	 yR+HWvDqzV4e4+WZI1GVGGAfY1kG7/LYjephMQ2AQv1dHAMdrSbJ4hcWPU2PUSqmFj
	 SDr/Qn34hantVE1/3QBMAcGbsHvUS/0+LVpvpHQPVXLVQhugK8PpYqo2TTxkOG+AZH
	 F8R3iaxJnpN3HXTe6nDhh59Zne3DHcUBEg2ZHVN9uyI2FWBjWfdwsWoNkpwNogVOUC
	 PLh8sAJABaBhfAqh11BPjmba4qlvX8T2E3ir4rpUOh7Q1xCRQJJxVXLfi7lljMrSEn
	 RqY5cAj7yjVRA==
Date: Tue, 13 Jan 2026 14:57:16 +0000
From: Simon Horman <horms@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next 4/6] xfrm: add XFRM_MSG_MIGRATE_STATE for
 single SA migration
Message-ID: <aWZdTOXTn_YBKKhv@horms.kernel.org>
References: <cover.1767964254.git.antony@moon.secunet.de>
 <3558d8c20a0a973fd873ca6f50aef47a9caffcdc.1767964254.git.antony@moon.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3558d8c20a0a973fd873ca6f50aef47a9caffcdc.1767964254.git.antony@moon.secunet.de>

On Fri, Jan 09, 2026 at 02:38:05PM +0100, Antony Antony wrote:
> Add a new netlink method to migrate a single xfrm_state.
> Unlike the existing migration mechanism (SA + policy), this
> supports migrating only the SA and allows changing the reqid.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

...

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index ef832ce477b6..04c893e42bc1 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1967,7 +1967,8 @@ static inline int clone_security(struct xfrm_state *x, struct xfrm_sec_ctx *secu
>  
>  static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
>  					   struct xfrm_encap_tmpl *encap,
> -					   struct xfrm_migrate *m)
> +					   struct xfrm_migrate *m,

Hi Antony,

Not strictly related to this patch, but FWIIW, it seems that m could be
const in this call stack.  And, moreover, I think there would be some value
in constifying parameters throughout xfrm.

> +					   struct netlink_ext_ack *extack)
>  {
>  	struct net *net = xs_net(orig);
>  	struct xfrm_state *x = xfrm_state_alloc(net);
> @@ -1979,9 +1980,13 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
>  	memcpy(&x->lft, &orig->lft, sizeof(x->lft));
>  	x->props.mode = orig->props.mode;
>  	x->props.replay_window = orig->props.replay_window;
> -	x->props.reqid = orig->props.reqid;
>  	x->props.saddr = orig->props.saddr;
>  
> +	if (orig->props.reqid != m->new_reqid)
> +		x->props.reqid = m->new_reqid;
> +	else
> +		x->props.reqid = orig->props.reqid;
> +

Claude Code with Review Prompts [1] flags that until the next
patch of this series m->new_reqid is used uninitialised in the following
call stack:

xfrm_do_migrate -> xfrm_migrate -> xfrm_state_migrate -> xfrm_state_clone_and_setup

Also, while I could have missed something, it seems to me that it is
also uninitialised in this call stack:

pfkey_migrate -> xfrm_migrate -> xfrm_state_migrate -> xfrm_state_clone_and_setup

[1] https://github.com/masoncl/review-prompts/

>  	if (orig->aalg) {
>  		x->aalg = xfrm_algo_auth_clone(orig->aalg);
>  		if (!x->aalg)
> @@ -2059,7 +2064,6 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
>  			goto error;
>  	}
>  
> -

nit: this hunk doesn't seem related to the rest of the patch.

>  	x->props.family = m->new_family;
>  	memcpy(&x->id.daddr, &m->new_daddr, sizeof(x->id.daddr));
>  	memcpy(&x->props.saddr, &m->new_saddr, sizeof(x->props.saddr));

...

> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c

...

> +static inline unsigned int xfrm_migrate_state_msgsize(bool with_encap, bool with_xuo)

Please don't use the inline keyword in .c files unless there is a
demonstrable - usually performance - reason to do so.
Rather, please let the compiler inline (or not) code as it sees fit.

> +{
> +	return NLMSG_ALIGN(sizeof(struct xfrm_user_migrate_state)) +
> +		(with_encap ? nla_total_size(sizeof(struct xfrm_encap_tmpl)) : 0) +
> +		(with_xuo ? nla_total_size(sizeof(struct xfrm_user_offload)) : 0);
> +}
> +

...

> +static int xfrm_send_migrate_state(const struct xfrm_user_migrate_state *um,
> +				   const struct xfrm_encap_tmpl *encap,
> +				   const struct xfrm_user_offload *xuo)
> +{
> +	int err;
> +	struct sk_buff *skb;
> +	struct net *net = &init_net;
> +
> +	skb = nlmsg_new(xfrm_migrate_state_msgsize(!!encap, !!xuo), GFP_ATOMIC);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	err = build_migrate_state(skb, um, encap, xuo);
> +	if (err < 0) {
> +		WARN_ON(1);
> +		return err;

skb seems to be leaked here.

Also flagged by Review Prompts.

> +	}
> +
> +	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_MIGRATE);
> +}

...

