Return-Path: <netdev+bounces-191929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B3ABDF04
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB3C4C7D30
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5EE25229C;
	Tue, 20 May 2025 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md9NPdqk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0972505AA
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754599; cv=none; b=ROJ34BpvrfsJHBfYo6fu00rEPn4rpJzn283Uy4nOwOcz/Zdv0qw5tDgd/qd4MdnYoP5goxo5KBdO8Ch24wQ8EY/5HXHBF/55MSXW8VSmwT3wppE6vHJykqso4aioTLkBU0uhL5dt+VjjZkZrYAfyH69Xeonb/29AiR30XCE8HRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754599; c=relaxed/simple;
	bh=Lf7BAQNzi4tD4sGfxZUQ6flBpqPpoYjYEIoWMzVF2aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTAQucA+9sxNRZg9o2z9z/1ulnKAIAv95y7lMPMywryUsoegnPDb8zeIzCcAPVQImVtGrDV98MjADbFCi9t3Gw8O7iI0q8+fK1SEiz+mHG4rOuerGV3XvjwuH3/l1m0WpSecW1uO/+OF4i6Zf8wDpPsF+pdnW7/uFcZE/RGywk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md9NPdqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6D8C4CEEA;
	Tue, 20 May 2025 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747754599;
	bh=Lf7BAQNzi4tD4sGfxZUQ6flBpqPpoYjYEIoWMzVF2aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=md9NPdqkQzHtpKodjf+XUCOz2G8W3iezT1XBDcBgJ2PySjUvV8R/oKRtAMsaUq2mZ
	 VvwmRdiOc50q5wQMm9/tTPm+ArFOdM17MOuC0P1jJ/NNgfcDGUAXbplN1F4ODXW6Jv
	 dOo5OzjilTs0XLB3jqfY44fjPo8YMBIOVjsjTWwvbpZZWHxfpUkr40FvqCpU3TgCoA
	 wAaPNe9UFYNV/9IRgRqbA5uR2Pml28rTAJUokfVbHvQo6UkGwEDoyE3vsL3zbkmh/+
	 jUzy+JU+VVeQzZ4WYXD01wRdMkGsRPyyWoACJXdg2R1OUv21g9aqW3YIBf1wURQFxe
	 0Xj0Z+ehAULtQ==
Date: Tue, 20 May 2025 16:23:15 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mctp: use nlmsg_payload() for netlink
 message data extraction
Message-ID: <20250520152315.GB365796@horms.kernel.org>
References: <20250520-mctp-nlmsg-payload-v1-1-93dd0fed0548@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520-mctp-nlmsg-payload-v1-1-93dd0fed0548@codeconstruct.com.au>

On Tue, May 20, 2025 at 03:02:10PM +0800, Jeremy Kerr wrote:
> Jakub suggests:
> 
> > I have a different request :) Matt, once this ends up in net-next
> > (end of this week) could you refactor it to use nlmsg_payload() ?
> > It doesn't exist in net but this is exactly why it was added.
> 
> This refactors the additions to both mctp_dump_addrinfo(), and
> mctp_rtm_getneigh() - two cases where we're calling nlh_data() on an
> an incoming netlink message, without a prior nlmsg_parse().
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
>  net/mctp/device.c | 4 ++--
>  net/mctp/neigh.c  | 5 ++++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mctp/device.c b/net/mctp/device.c
> index 7c0dcf3df3196207af6e1a1c002f388265c49fa1..4d404edd7446e187dd3aa18ee2086c4e2e3da3ee 100644
> --- a/net/mctp/device.c
> +++ b/net/mctp/device.c
> @@ -120,8 +120,8 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
>  	int ifindex = 0, rc;
>  
>  	/* Filter by ifindex if a header is provided */
> -	if (cb->nlh->nlmsg_len >= nlmsg_msg_size(sizeof(*hdr))) {
> -		hdr = nlmsg_data(cb->nlh);
> +	hdr = nlmsg_payload(cb->nlh, sizeof(*hdr));
> +	if (hdr) {
>  		ifindex = hdr->ifa_index;
>  	} else {
>  		if (cb->strict_check) {

Hi Jeremy,

This looks like a refactor, as per the commit message.
All good.

> diff --git a/net/mctp/neigh.c b/net/mctp/neigh.c
> index 590f642413e4ef113a1a9fa96cb548b98cb55621..05b899f22d902b275ca1e300542a8d546d59ea15 100644
> --- a/net/mctp/neigh.c
> +++ b/net/mctp/neigh.c
> @@ -250,7 +250,10 @@ static int mctp_rtm_getneigh(struct sk_buff *skb, struct netlink_callback *cb)
>  		int idx;
>  	} *cbctx = (void *)cb->ctx;
>  
> -	ndmsg = nlmsg_data(cb->nlh);
> +	ndmsg = nlmsg_payload(cb->nlh, sizeof(*ndmsg));
> +	if (!ndmsg)
> +		return -EINVAL;
> +

But is this one a bug fix?

>  	req_ifindex = ndmsg->ndm_ifindex;
>  
>  	idx = 0;
> 
> ---
> base-commit: f685204c57e87d2a88b159c7525426d70ee745c9
> change-id: 20250520-mctp-nlmsg-payload-0711973470bf
> 
> Best regards,
> -- 
> Jeremy Kerr <jk@codeconstruct.com.au>
> 

