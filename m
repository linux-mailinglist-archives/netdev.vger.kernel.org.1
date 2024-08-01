Return-Path: <netdev+bounces-115103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9AF9452AC
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 20:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8BD1C21C8A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FB2143747;
	Thu,  1 Aug 2024 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbaLTTzg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E120813D282
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722536553; cv=none; b=EdItBcx3Os4NNFoF8I9JnCm14D8Hoeo8zjOgm0CHdz/ymOekR/XMmkLCkAA5ztS2UlgVGythhkE3ROMxFLuE60yPAQ36BaK5VviD9Diutihul1cl8XKQpR9YLe7pPHFAnfb/UxJNSt/g/zv+TuA45+avNtsHB02QX/+em8JoE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722536553; c=relaxed/simple;
	bh=T6kxLzGHdsjVzKiRZW4fFkv+jeUpjSkel0KZgA3eQGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF36FiQ5k0gX95S7N56grshWEYKuxh/sdCjHAdH2m/lt5M3MRdvBMrIX9JL5IpGDjWAR6tudJzE1XO+t80Nxa28UnGd6Rl9qlqb/kPYkUXZa9fnDUkFeAKGJ3zU7gkj5MQnE5nLvLabIPf6YWAMVoTvTcMhECMF8epLNymE6ZZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbaLTTzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052EEC32786;
	Thu,  1 Aug 2024 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722536552;
	bh=T6kxLzGHdsjVzKiRZW4fFkv+jeUpjSkel0KZgA3eQGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lbaLTTzgAbs90uhMWH/hQXcUthUmiBg3vu2ccmew4XBlzo5v16iKGUdU/4R0jCAVO
	 ikcd/8wXGB9flStWbb06MDk8O0uIxJVgmABEaRCRt9BYDcsAQHcZ5Djq1gf4DIBIZ/
	 7QYDYkfnMIQV24Cc61Dhszw7dlomHu4PgziJt6pbXdPdAXVc4Oac61QEmiSKIHkhJW
	 ev1rsLa8iwLWWcpgwoKnP8WyXH86c8QgOdO+eOGv5j/Hb5Xs9w7XkzXfhSU2AQEDej
	 0ZgfFTgzw8kAWm6ZILd7ez5ieNm2h4iam0dqyRIAIN5IAOsyUmvn1tmh1LpOYX+V9C
	 szv2xBYQW04/g==
Date: Thu, 1 Aug 2024 19:22:28 +0100
From: Simon Horman <horms@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	netdev@vger.kernel.org, felipe@sipanda.io
Subject: Re: [PATCH 07/12] flow_dissector: Parse vxlan in UDP
Message-ID: <20240801182228.GY1967603@kernel.org>
References: <20240731172332.683815-1-tom@herbertland.com>
 <20240731172332.683815-8-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731172332.683815-8-tom@herbertland.com>

On Wed, Jul 31, 2024 at 10:23:27AM -0700, Tom Herbert wrote:
> Parse vxlan in a UDP encapsulation
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  net/core/flow_dissector.c | 57 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c

...

> @@ -756,6 +758,55 @@ __skb_flow_dissect_gre(const struct sk_buff *skb,
>  	return FLOW_DISSECT_RET_PROTO_AGAIN;
>  }
>  
> +static enum flow_dissect_ret
> +__skb_flow_dissect_vxlan(const struct sk_buff *skb,
> +			 struct flow_dissector *flow_dissector,
> +			 void *target_container, const void *data,
> +			 __be16 *p_proto, int *p_nhoff, int hlen,
> +			 unsigned int flags)
> +{
> +	struct vxlanhdr *hdr, _hdr;
> +	__be16 protocol;
> +
> +	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
> +				   &_hdr);
> +	if (!hdr)
> +		return FLOW_DISSECT_RET_OUT_BAD;
> +
> +	/* VNI flag always required to be set */
> +	if (!(hdr->vx_flags & VXLAN_HF_VNI))
> +		return FLOW_DISSECT_RET_OUT_BAD;
> +
> +	if (hdr->vx_flags & VXLAN_F_GPE) {

Hi Tom,

Sparse flags an byte-order miss match on the line above.
I expect this would resolve it (completely untested!):

	if (hdr->vx_flags & cpu_to_be32(VXLAN_F_GPE))

...

