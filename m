Return-Path: <netdev+bounces-131107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F37C98CB53
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 04:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E6A1C22603
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 02:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E968D28E7;
	Wed,  2 Oct 2024 02:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcqU0M8U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C430E23AD
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 02:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727837112; cv=none; b=RO3kHZ9854dA8SIVfiG4PLbLLjC3msTSbhpnZ4EXpAd70K/hp7vSe9FW1tECM3JstLl+0BqsRauRF9UN747imdNiGm+EDyqx5lNBz8BlNPZMYzTSotWqDj+2emLuzDBFSrw0/oMgYfpb5bqyqYez5zSa7P0VMANV3gEL56PKOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727837112; c=relaxed/simple;
	bh=SlrtSVXcwUXhPK91iRs6hKw9lP7crMspAOT5rXy31XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUdd8BKUg1mzp6j69dOxqs/O7Slh+mxWnqLBZtrr5lxyXlzNudXib3mkEhONqNIAJRA7uJOvx86XmxhOBT8BLrkECCVMMxfVlfpeg7P7ceJaZIgrYlakiHvfHFUA/7+BznvYzMfecfK62riNuYzqGRAFf2CQceRCINq03gd8fLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcqU0M8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5F7C4CEC6;
	Wed,  2 Oct 2024 02:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727837112;
	bh=SlrtSVXcwUXhPK91iRs6hKw9lP7crMspAOT5rXy31XU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NcqU0M8UHFd12putrgrfBoLuUcgHhGZNoOG5cubVHeq4LdcWlaXFRoKqNSjW4T3sL
	 J6oJiG5T5Tlyuw+VTNv6mWHZ26sYo8yTBSkktRfZeG8sQswDTvxRI3J7qfxrDEG7In
	 MNmEgfufBPJo2LJkOeS89YDsjPr2L+1F0b3ImG9pLsBwrMzH2LC1Y/liLv/IfcIwDX
	 S2God2/hvpcAB4Ub5ga+Q68BxNZM6rNoW3OSXSS4XNuKHDGZwrDQn/0WkZ5qYwelgO
	 AWDvizm6PQvOXEYV765V0fWxP4TpFkvi2gVlU0ZKxKa9MkygHPbFsEfVTzV6K++Jcq
	 so3p6bnSoho4g==
Message-ID: <9e2a0a83-844c-49c1-bc87-ea5dcbe0b846@kernel.org>
Date: Tue, 1 Oct 2024 20:45:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] ipv4: Convert ip_route_input_slow() and its
 callers to dscp_t.
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <cover.1727807926.git.gnault@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <cover.1727807926.git.gnault@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/24 1:28 PM, Guillaume Nault wrote:
> Prepare ip_route_input_slow() and its call chain to future conversion
> of ->flowi4_tos.
> 
> The ->flowi4_tos field of "struct flowi4" is used in many different
> places, which makes it hard to convert it from __u8 to dscp_t.
> 
> In order to avoid a big patch updating all its users at once, this
> patch series gradually converts some users to dscp_t. Those users now
> set ->flowi4_tos from a dscp_t variable that is converted to __u8 using
> inet_dscp_to_dsfield().
> 
> When all users of ->flowi4_tos will use a dscp_t variable, converting
> that field to dscp_t will just be a matter of removing all the
> inet_dscp_to_dsfield() conversions.
> 
> This series concentrates on ip_route_input_slow() and its direct and
> indirect callers.
> 
> Guillaume Nault (5):
>   ipv4: Convert icmp_route_lookup() to dscp_t.
>   ipv4: Convert ip_route_input() to dscp_t.
>   ipv4: Convert ip_route_input_noref() to dscp_t.
>   ipv4: Convert ip_route_input_rcu() to dscp_t.
>   ipv4: Convert ip_route_input_slow() to dscp_t.
> 

LGTM:

Reviewed-by: David Ahern <dsahern@kernel.org>


