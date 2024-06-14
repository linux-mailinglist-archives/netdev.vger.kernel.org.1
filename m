Return-Path: <netdev+bounces-103671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FB3908FE6
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FB41C22A71
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56156180A76;
	Fri, 14 Jun 2024 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKUjiGpb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D82616D9CF;
	Fri, 14 Jun 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381833; cv=none; b=J4x+ln88W5SBviZmVlgpoXKsjLU3lrYeN/8lSOGVogVFCR+DBOjpXj1XiZksTftNp3qb8jp8MRhgprGBF86aPm+phV951uJYXsUj7t7N+retJVlgU/Y65sXxMfOLfLWtLBp21UUANEe47MDsyGs/QbucEc1+VNdjzDIGxHzfX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381833; c=relaxed/simple;
	bh=rUDbAwt/h0GLgZcxweo77P+njhdjO7sRzKJA4DU7QAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSdn8C3TYUA9q+HUOmlyDb8g2rVqEdE7k7DTOmR7/JobzfLHthNRST9egObZkqKOeHseuqn9WAAfo0RirOQWZTH3FCdYOfBCYgTn5s2HdhNLb09IktO/W2BuuRkrTOLaHX3mxl3jvJzXQo80W1PLhpJLuxIvy3Hij3TdgBQc75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKUjiGpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C72C32786;
	Fri, 14 Jun 2024 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718381832;
	bh=rUDbAwt/h0GLgZcxweo77P+njhdjO7sRzKJA4DU7QAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WKUjiGpbQ6vSgDikdQrtYjmcjpk5Y6w5mtfEOsK+zcO/QlUYDq49zp1kT4Nk3exJb
	 4FZpwSLehgZQIIaS8Fzvd3K4TjM3m97afoydWqtCD7nNxTZuKP3R7nFPvlwp/s6B2R
	 eTXNWfcad4lxtI0m9stOKdpQ1fe9dZWkKyrvlyU053KI0RxoWxMZ9mfrRnmB7hs0g3
	 h7UH5g7UtACMfBFCq330U8BiXlR6zR11zLrlBnoggnwwxWwGftWpHXyPpv8oobpsDp
	 EGh/4vaZAwS5p0ekOYbjG23g2J9gD1LDrH1quUzwpLz5Ux8K+pblsKZ0S89UnNSllr
	 dG7BQG286BijA==
Date: Fri, 14 Jun 2024 17:17:08 +0100
From: Simon Horman <horms@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	i.maximets@ovn.org, dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 7/9] net: openvswitch: do not notify drops
 inside sample
Message-ID: <20240614161708.GU8447@kernel.org>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
 <20240603185647.2310748-8-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603185647.2310748-8-amorenoz@redhat.com>

On Mon, Jun 03, 2024 at 08:56:41PM +0200, Adrian Moreno wrote:
> The OVS_ACTION_ATTR_SAMPLE action is, in essence,
> observability-oriented.
> 
> Apart from some corner case in which it's used a replacement of clone()
> for old kernels, it's really only used for sFlow, IPFIX and now,
> local emit_sample.
> 
> With this in mind, it doesn't make much sense to report
> OVS_DROP_LAST_ACTION inside sample actions.
> 
> For instance, if the flow:
> 
>   actions:sample(..,emit_sample(..)),2
> 
> triggers a OVS_DROP_LAST_ACTION skb drop event, it would be extremely
> confusing for users since the packet did reach its destination.
> 
> This patch makes internal action execution silently consume the skb
> instead of notifying a drop for this case.
> 
> Unfortunately, this patch does not remove all potential sources of
> confusion since, if the sample action itself is the last action, e.g:
> 
>     actions:sample(..,emit_sample(..))
> 
> we actually _should_ generate a OVS_DROP_LAST_ACTION event, but we aren't.
> 
> Sadly, this case is difficult to solve without breaking the
> optimization by which the skb is not cloned on last sample actions.
> But, given explicit drop actions are now supported, OVS can just add one
> after the last sample() and rewrite the flow as:
> 
>     actions:sample(..,emit_sample(..)),drop
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


