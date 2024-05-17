Return-Path: <netdev+bounces-96948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6EA8C8632
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 14:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3791C20EB1
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D773940BE6;
	Fri, 17 May 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf2L3rRQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B418651;
	Fri, 17 May 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715948563; cv=none; b=Hc/fI7w9fXJBxnpStpGCwGIWg9akPpQgvK353TGjGYE7szlatjNrSadQIIg6V2zaY2BHt5Wgch5TSE2Wk5XOltKxmCOxNquQmLNo3DseSt50E9hOFhd2/JhRI12hWnmSs9p+6rmXKZM+NZpOrahFnBvBqg0hJOzUCZnjj6Hxy9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715948563; c=relaxed/simple;
	bh=GStUMf9ZPNcQRDuiycSc19qAYoifeOrKAZJLIJFG/gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAwM7ySSljpcV+jVEeoV9ehPazjuzYsE0uh5w7VDkms2NahyC5mcV1C44fIYdd5v9GNpXnVlL+azVrWVsQrc1+mohY1o3+Pi+VVS0c9uY4kscxgJAZeM+oJNCMWvzBuc13rIwkaejsnbdSrJZi6irt/fBtvET/NvcZ3yXVXQQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf2L3rRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11977C2BD10;
	Fri, 17 May 2024 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715948563;
	bh=GStUMf9ZPNcQRDuiycSc19qAYoifeOrKAZJLIJFG/gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mf2L3rRQ6yt2IjgijzYg/GRRT/rsSy/5szZHWxFVepe5BXuO1PaKXMtlW5yBXffKE
	 7AjiaCdXCZyTzgTIchIrz7CV9ekS5ai+mvXfwLDGhYEsxgrN2czNRBWaSOxj02MP+7
	 FJYox7U1AWHfWqSbcsTUahNx+48+ZGcCIN50UQy8EgvBTWbDgM9Yc3LIs9RSorlpb3
	 /a8GRKN5ZYW0lUwkjjCZFvxl1liR4+1CtRhXyWvV90Xe8kJEJTc2aH/gjEgiDhqaZy
	 4eS/0uoJWcHm7gOXyCDjYjbbt3nXWpBqXZOQ8IdC133S1AV8icnkVWohbLLGAF132u
	 vd4XhgrHnH7uQ==
Date: Fri, 17 May 2024 13:22:38 +0100
From: Simon Horman <horms@kernel.org>
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: Norbert Manthey <nmanthey@amazon.de>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: esp: cleanup esp_output_tail_tcp() in case of
 unsupported ESPINTCP
Message-ID: <20240517122238.GE443576@kernel.org>
References: <20240516080309.1872-1-hagarhem@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516080309.1872-1-hagarhem@amazon.com>

On Thu, May 16, 2024 at 08:03:09AM +0000, Hagar Hemdan wrote:
> xmit() functions should consume skb or return error codes in error
> paths.
> When the configuration "CONFIG_INET_ESPINTCP" is not used, the
> implementation of the function "esp_output_tail_tcp" violates this rule.
> The function frees the skb and returns the error code.
> This change removes the kfree_skb from both functions, for both
> esp4 and esp6.
> 
> This should not be reachable in the current code, so this change is just
> a cleanup.
> 
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
> 
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>

Hi Hagar,

If esp_output() may be the x->type->output callback called from esp_output()
then I agree that this seems to be a problem as it looks like a double free
may occur.

However, I believe that your proposed fix introduces will result in skb
being leaked leak in the case of esp_output_done() calling
esp_output_tail_tcp(). Perhaps a solution is for esp_output_done()
to free the skb if esp_output_tail_tcp() fails.

I did not analyse other call-chains, but I think such analysis is needed.

...

