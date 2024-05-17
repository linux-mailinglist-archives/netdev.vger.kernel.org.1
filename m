Return-Path: <netdev+bounces-96998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113FD8C89A7
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E2B1C2111E
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D015C12F58E;
	Fri, 17 May 2024 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6QFgWcF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C6399
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961432; cv=none; b=Q9YygMt9pOZI97TIgHtjE99EJzAQxIQeoiffoyQqCVXvCZkV1HEikOUxl5tHnDiaLs54aHwJIwa96MohW3LTdJ2NTqbXmFQcP5TCNM4nxjm7M3KBAyK23qPQtD0zVvzhEUh7Jtw0s9FaWXTYI7BwsfE+hpo87MbcjwfxSMQXNGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961432; c=relaxed/simple;
	bh=1Tz5L7JmgM0dqfyVC49JGKC9pQ7e3W3qDnAlnrlWMUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPVhsfS5de9zGh4e+qSQWVaW5UrO5IFU4YrWGLYn3P3vaen4ixVz0U5kkqLhXdHjJbae7AdLGa6QkLNZ54ge/YPHmJtd93Lmfk8q9Ont/r+3w9h4LT6Dh26cmg655L6NY1anTm7I1wpHOx8AzJzYjdIzH/s21jPj7xcLv1UXVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6QFgWcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D430EC2BD10;
	Fri, 17 May 2024 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715961432;
	bh=1Tz5L7JmgM0dqfyVC49JGKC9pQ7e3W3qDnAlnrlWMUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6QFgWcFKdzr2D139V5sJc1nSG+9LvQkba9WNRKeT4csx69yb5DXujfDawx7tIZlt
	 d1fyCh0r+4d/GgrhKebXp8Yt1feNVT+bD3rM3bO9JdGoN+tCm5RIFOIdCL8ieD2llB
	 6E8E/lOB7/2r3iZQ+S9uZpzEkKJMTkZ/GEO3xvSQsQPpeirYXJRLqjlggN7vba6mkt
	 vlHZggjUOMGZgLoKJberbM9tpslCh0J5QkCQCkUA5GB5kATrhXiifnptxe74FcWAgx
	 G4z8zDV+A5striJa9wXNJgY8YkZOieJ6uuElnwPqP3YFOWiEdPCvnQsunrJ1juR+MO
	 +MB45+fnp95vw==
Date: Fri, 17 May 2024 16:57:07 +0100
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
	hagarhem@amazon.de
Subject: Re: [PATCH] net: esp: cleanup esp_output_tail_tcp() in case of
 unsupported ESPINTCP
Message-ID: <20240517155707.GG443576@kernel.org>
References: <20240516080309.1872-1-hagarhem@amazon.com>
 <20240517122238.GE443576@kernel.org>
 <20240517131757.GA12613@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517131757.GA12613@amazon.com>

On Fri, May 17, 2024 at 01:17:57PM +0000, Hagar Hemdan wrote:
> On Fri, May 17, 2024 at 01:22:38PM +0100, Simon Horman wrote:
> > On Thu, May 16, 2024 at 08:03:09AM +0000, Hagar Hemdan wrote:
> > > xmit() functions should consume skb or return error codes in error
> > > paths.
> > > When the configuration "CONFIG_INET_ESPINTCP" is not used, the
> > > implementation of the function "esp_output_tail_tcp" violates this rule.
> > > The function frees the skb and returns the error code.
> > > This change removes the kfree_skb from both functions, for both
> > > esp4 and esp6.
> > > 
> > > This should not be reachable in the current code, so this change is just
> > > a cleanup.
> > > 
> > > This bug was discovered and resolved using Coverity Static Analysis
> > > Security Testing (SAST) by Synopsys, Inc.
> > > 
> > > Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> > > Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> > 
> > Hi Hagar,
> > 
> > If esp_output() may be the x->type->output callback called from esp_output()

Hi Hagar,

FTR, I meant to say "If ... called from xfrm_output_one()",
but I don't think that effects the direction of the conversation
at this point.

> > then I agree that this seems to be a problem as it looks like a double free
> > may occur.
> > 
> > However, I believe that your proposed fix introduces will result in skb
> > being leaked leak in the case of esp_output_done() calling
> > esp_output_tail_tcp(). Perhaps a solution is for esp_output_done()
> > to free the skb if esp_output_tail_tcp() fails.
> > 
> > I did not analyse other call-chains, but I think such analysis is needed.
> > 
> > ...
> Hi Simon,
> 
> I see all calls to esp_output_tail_tcp() is surrounded by the condition
> "x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP" which I see
> it is related to enabling of CONFIG_INET_ESPINTCP configuration 
> (introduced in this commit e27cca96cd68 ("xfrm: add espintcp (RFC 8229)").
> 
> For calling of x->type->output (resolved to esp_output()) in
> xfrm_output_one(), I see there is no double free here as esp_output()
> calls esp_output_tail() which calls esp_output_tail_tcp() only if 
> x->encap->encap_type == TCP_ENCAP_ESPINTCP which points to the first 
> implementation of esp_output_tail_tcp(). This first definition 
> doesn't free skb.
> 
> So my understanding is the 2nd esp_output_tail_tcp() should not be
> called and this is why I called WARN_ON() as this func is unreachable.
> Removing free(skb) here is just for silencing double free Coverity 
> false positive.
> Is there something else I miss?

Thanks, I missed the important detail that calls to esp_output_tail_tcp()
are guarded by "x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP".

Assuming that condition is always false if CONFIG_INET_ESPINTCP is not set,
then I agree with your analysis and I don't see any problems with your
patch.

It might be worth calling out in the commit message that the WARN_ON
is added because esp_output_tail_tcp() should never be called if
CONFIG_INET_ESPINTCP is not set.

