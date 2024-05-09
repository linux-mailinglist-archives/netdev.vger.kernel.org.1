Return-Path: <netdev+bounces-94898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 474518C0F71
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9241FB20EB2
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C3714B091;
	Thu,  9 May 2024 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr6IyuWE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B514AD2B
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256962; cv=none; b=CRU+XFCED+aITPQhP5KQ5S77lInoWMI0OeapDBlz70oym8vZD52ngfNBJTr65HVTNQqb8VZS6KYAqqW32fFmeB6NW2kabUaJm9t5XHZq9kT3WVptjSoa4mJaBNhld2RyBKd/3OSi3/ZVrwb32PM6fIQNGegD8vQBOhTe7oNfWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256962; c=relaxed/simple;
	bh=AlKF5hqu3ys4BFzbY8urC9qXjUfMnPXhA8moycX5dQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX0GLcXA9YZIGYH3y8v5182sdPlO1yBbhRCFVvG+gM2XNkU4hn4KRey25ORhOYnDpqqUkEHuvqb6TXNtLVJyYHJTvgINV5kB/GLXmMKvbQOTniGajJPwmpNhg19uRRSMDV7gzoRnLgPDDQ3Xi+vSilITMZs6L6jDqkxIgmb5kag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr6IyuWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3AFC116B1;
	Thu,  9 May 2024 12:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715256961;
	bh=AlKF5hqu3ys4BFzbY8urC9qXjUfMnPXhA8moycX5dQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lr6IyuWECko5OnoXC9Z54SHMBP6fbgKfIi99WSX+Z73rLICTFkW9zoiM5SlTcyKlY
	 I7n1REDAwCVYwjDTQNC6VZP68DUPfSv0W/nCxLFkggXkzb34FpuKS6ftb3rtONM8tu
	 u7oKRZMTjB6ezCo/m67JcxKVvkd5B9BQ0tvC/m9lTiTDXSF9VZsTgfwhq5XMq2zdFG
	 rFH7X28GkbBli2I0xE4CSJt93sT4FOS9RhtXg1Z3i8BkQ+G8DK0bofZhNcEsAFnBQh
	 TvONAiSs+WDL6V+sI3T4HlX7fGlYw2jvE+tMQwUg9EiHVcGWNzNQi+HTpgnNSPGkbn
	 jnZ9uk9HtAonQ==
Date: Thu, 9 May 2024 13:15:57 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de
Subject: Re: [PATCH net-next,v3 05/12] gtp: use IPv6 address /64 prefix for
 UE/MS
Message-ID: <20240509121557.GO1736038@kernel.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
 <20240506235251.3968262-6-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506235251.3968262-6-pablo@netfilter.org>

On Tue, May 07, 2024 at 01:52:44AM +0200, Pablo Neira Ayuso wrote:
> Harald Welte reports that according to 3GPP TS 29.060:
> 
>     PDN Connection: the association between a MS represented by one IPv4
> address and/or one IPv6 prefix and a PDN represented by an APN.
> 
> this clearly states that IPv4 is a single address while IPv6 is a single prefix.
> 
> Then, 3GPP TS 29.061, Section 11.2.1.3:
> 
>     For APNs that are configured for IPv6 address allocation, the GGSN/P-GW
> shall only use the Prefix part of the IPv6 address for forwarding of mobile
> terminated IP packets. The size of the prefix shall be according to the maximum
> prefix length for a global IPv6 address as specified in the IPv6 Addressing
> Architecture, see RFC 4291 [82].
> 
> RFC 4291 section 2.5.4 states
> 
>     All Global Unicast addresses other than those that start with binary 000
> have a 64-bit interface ID field (i.e., n + m = 64) ...
> 
> 3GPP TS 29.61 Section 11.2.1.3.2a:
> 
>     In the procedure in the cases of using GTP-based S5/S8, P-GW acts as an
> access router, and allocates to a UE a globally unique /64 IPv6 prefix if the
> PLMN allocates the prefix.
> 
> Therefore, compare IPv6 address /64 prefix only since MS/UE is not a single
> address like in the IPv4 case.
> 
> Reject IPv6 address with EADDRNOTAVAIL if it lower 64 bits of the IPv6 address
> from the control plane are set.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <horms@kernel.org>


