Return-Path: <netdev+bounces-108928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6414B92642B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876821C24D11
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41817DA20;
	Wed,  3 Jul 2024 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T81mnmLO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7017D89A
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018767; cv=none; b=JdLaVXp8dVA+plb+qFX9is+zb+nYIP30NLnvqUYUydncq+LG3qN6BCUEuVcL69nlEXLYGKSRTOBq39UHWZkZmoawSF7Qh6/kWn3sXpAnUtQJn51t7iFA9vNjhu8sxnRlnICu8/7ldRyH5yuiOnwV+K308+rfqRsjEad5CbiQZag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018767; c=relaxed/simple;
	bh=e0YCTH41Gdm5vtUrDP/SI58YkPPTn4s5OzkKOtEYrcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eCsS3VQL4lxWGP0+yEz4oOU+owSzYd1cyF6CA2IJImuwW/Hhdt5ZS8UDAooKSetAvMis02tCojwvD4Y0jEmme40HJ2if8+eDH/0Q2iBLixy+3399smqHofHRLGI/62GaIRiIC9w5euWe294iOYAoCQaQO5psA+e8Cgo2oeohrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T81mnmLO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720018765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ST1F0P0+nP34su7WHb54RKXImlVi/y78rBhLYV2QDE=;
	b=T81mnmLOpqhVRxxFf8NtnPba48VT/pC+qFl5LIo1Dd5ebAuAjd40+sUX3dW5ZgvOvoWxay
	98vpp6/L6zEsQfHUfqXz1MtGf+51mds5IY+dlOew0VjgkWTI+tuXIlPZ9Z0TqSULDaSgC8
	QidOmwuf9+WRC8ZFONwyk/CKMKylTS0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-pE78gmIZNQWjnfh9aNZN4g-1; Wed,
 03 Jul 2024 10:59:23 -0400
X-MC-Unique: pE78gmIZNQWjnfh9aNZN4g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CC3D1954B11;
	Wed,  3 Jul 2024 14:59:22 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59DE31955F4B;
	Wed,  3 Jul 2024 14:59:20 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: dev@openvswitch.org,  pshelar@ovn.org,  netdev@vger.kernel.org, Dumitru
 Ceara <dceara@redhat.com>, Marcelo Leitner <mleitner@redhat.com>
Subject: Re: [PATCH net-next] openvswitch: prepare for stolen verdict coming
 from conntrack and nat engine
In-Reply-To: <20240703104640.20878-1-fw@strlen.de> (Florian Westphal's message
	of "Wed, 3 Jul 2024 12:46:34 +0200")
References: <20240703104640.20878-1-fw@strlen.de>
Date: Wed, 03 Jul 2024 10:59:18 -0400
Message-ID: <f7t34oqplmh.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Florian,

Florian Westphal <fw@strlen.de> writes:

> At this time, conntrack either returns NF_ACCEPT or NF_DROP.
> To improve debuging it would be nice to be able to replace NF_DROP
> verdict with NF_DROP_REASON() helper,
>
> This helper releases the skb instantly (so drop_monitor can pinpoint
> precise location) and returns NF_STOLEN.
>
> Prepare call sites to deal with this before introducing such changes
> in conntrack and nat core.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---

AFAIU, these changes are only impacting the existing NF_DROP cases, and
won't impact how ovs + netfilter communicate about invalid packets.  One
important thing to note is that we rely on:

 * Note that if the packet is deemed invalid by conntrack, skb->_nfct will be
 * set to NULL and 0 will be returned.

Based on this, my understanding is if packet isn't part of a valid
connection, skb->_nfct is NULL and NF_ACCEPT is returned.

If this changes, those flow pipelines matching on ct_state(+inv+trk)
will no longer function as expected since we will bail early.  I think
this comment will also apply to the act_ct change as well.

>  net/openvswitch/conntrack.c | 47 +++++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 10 deletions(-)
>
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> index 3b980bf2770b..8eb1d644b741 100644
> --- a/net/openvswitch/conntrack.c
> +++ b/net/openvswitch/conntrack.c
> @@ -679,6 +679,8 @@ static int ovs_ct_nat(struct net *net, struct sw_flow_key *key,
>  		action |= BIT(NF_NAT_MANIP_DST);
>  
>  	err = nf_ct_nat(skb, ct, ctinfo, &action, &info->range, info->commit);
> +	if (err != NF_ACCEPT)
> +		return err;
>  
>  	if (action & BIT(NF_NAT_MANIP_SRC))
>  		ovs_nat_update_key(key, skb, NF_NAT_MANIP_SRC);
> @@ -697,6 +699,22 @@ static int ovs_ct_nat(struct net *net, struct sw_flow_key *key,
>  }
>  #endif
>  
> +static int verdict_to_errno(unsigned int verdict)
> +{
> +	switch (verdict & NF_VERDICT_MASK) {
> +	case NF_ACCEPT:
> +		return 0;
> +	case NF_DROP:
> +		return -EINVAL;
> +	case NF_STOLEN:
> +		return -EINPROGRESS;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  /* Pass 'skb' through conntrack in 'net', using zone configured in 'info', if
>   * not done already.  Update key with new CT state after passing the packet
>   * through conntrack.
> @@ -735,7 +753,7 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
>  
>  		err = nf_conntrack_in(skb, &state);
>  		if (err != NF_ACCEPT)
> -			return -ENOENT;
> +			return verdict_to_errno(err);
>  
>  		/* Clear CT state NAT flags to mark that we have not yet done
>  		 * NAT after the nf_conntrack_in() call.  We can actually clear
> @@ -762,9 +780,12 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
>  		 * the key->ct_state.
>  		 */
>  		if (info->nat && !(key->ct_state & OVS_CS_F_NAT_MASK) &&
> -		    (nf_ct_is_confirmed(ct) || info->commit) &&
> -		    ovs_ct_nat(net, key, info, skb, ct, ctinfo) != NF_ACCEPT) {
> -			return -EINVAL;
> +		    (nf_ct_is_confirmed(ct) || info->commit)) {
> +			int err = ovs_ct_nat(net, key, info, skb, ct, ctinfo);
> +
> +			err = verdict_to_errno(err);
> +			if (err)
> +				return err;
>  		}
>  
>  		/* Userspace may decide to perform a ct lookup without a helper
> @@ -795,9 +816,12 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
>  		 * - When committing an unconfirmed connection.
>  		 */
>  		if ((nf_ct_is_confirmed(ct) ? !cached || add_helper :
> -					      info->commit) &&
> -		    nf_ct_helper(skb, ct, ctinfo, info->family) != NF_ACCEPT) {
> -			return -EINVAL;
> +					      info->commit)) {
> +			int err = nf_ct_helper(skb, ct, ctinfo, info->family);
> +
> +			err = verdict_to_errno(err);
> +			if (err)
> +				return err;
>  		}
>  
>  		if (nf_ct_protonum(ct) == IPPROTO_TCP &&
> @@ -1001,10 +1025,9 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
>  	/* This will take care of sending queued events even if the connection
>  	 * is already confirmed.
>  	 */
> -	if (nf_conntrack_confirm(skb) != NF_ACCEPT)
> -		return -EINVAL;
> +	err = nf_conntrack_confirm(skb);
>  
> -	return 0;
> +	return verdict_to_errno(err);
>  }
>  
>  /* Returns 0 on success, -EINPROGRESS if 'skb' is stolen, or other nonzero
> @@ -1039,6 +1062,10 @@ int ovs_ct_execute(struct net *net, struct sk_buff *skb,
>  	else
>  		err = ovs_ct_lookup(net, key, info, skb);
>  
> +	/* conntrack core returned NF_STOLEN */
> +	if (err == -EINPROGRESS)
> +		return err;
> +
>  	skb_push_rcsum(skb, nh_ofs);
>  	if (err)
>  		ovs_kfree_skb_reason(skb, OVS_DROP_CONNTRACK);


