Return-Path: <netdev+bounces-222679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58CEB556BD
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C255C01C5
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E32848B0;
	Fri, 12 Sep 2025 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuJkLv4o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799E279351;
	Fri, 12 Sep 2025 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703922; cv=none; b=XMhIXxwhuKVzhI3YtRwXgPEhtIrM8fqcg4J37S5d9gVqcnalm7qSEUcjLl6qXQhTfl9DdBEI4MI33vLQ9YQTqnPou3V8vmrNh2+d/cA3/6T64JoWDY1YI1k8vcfEEzXiFlXppeq2+K5rpU07443UDPt/zwsLkyCJu0C3WSKhovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703922; c=relaxed/simple;
	bh=RKdauv/AdcWwEL1f3Fr7fXZqk6LC/PBKfY0hTYKghUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFVRyC3RvQxnJWGnlivyQr3+EkEHjmWlRR5HiyF4A+N9OinchvJ/+GvfxGRHyxQsqjwWphaak2+FwNzaL02TKdsvIi1iqFc5s5Eoze6mRFrqhgYFb2qvxSttoNAmWQP6G8k4msdTPqHqZN9jAbPrFTTYWO3JBgr2ja7Q7JBTkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuJkLv4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FEEC4CEF1;
	Fri, 12 Sep 2025 19:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757703921;
	bh=RKdauv/AdcWwEL1f3Fr7fXZqk6LC/PBKfY0hTYKghUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuJkLv4oxDB4Jq6Wxu/bhBWMFDu6NmEu9KV9VrAd29q8NVeHoluognzCyg3xBgX3F
	 pZ4fS/I71RoAwbYzb6Hz8vAjzIDysVEhctVZ5g1IiQP4gw8KZNkjMjyk91vc2lEA3X
	 I1NE9vx+B/KUGc6225RxMgSvBby8FnOr8H1zpX2e5zZ/gvOFUNykaqt0uWdlLs0yoJ
	 C/VsMO73MjjuqXEGvfzi8tYcAIoV7j7iSYHuwkY4rBywD53mxRfUH+mPxvQdSHUcir
	 2exzxmi9IOnl4eCxmBcDfHHZ9O5MjEWmYeVqrCXbHi717NBR0W+G1pwLYQh4nKTw/w
	 /mkNqjNdZNmxw==
Date: Fri, 12 Sep 2025 20:05:17 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix unhandled errors in
 rxgk_verify_packet_integrity()
Message-ID: <20250912190517.GE224143@horms.kernel.org>
References: <2038804.1757631496@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2038804.1757631496@warthog.procyon.org.uk>

On Thu, Sep 11, 2025 at 11:58:16PM +0100, David Howells wrote:
>     
> rxgk_verify_packet_integrity() may get more errors than just -EPROTO from
> rxgk_verify_mic_skb().  Pretty much anything other than -ENOMEM constitutes
> an unrecoverable error.  In the case of -ENOMEM, we can just drop the
> packet and wait for a retransmission.
> 
> Similar happens with rxgk_decrypt_skb() and its callers.
> 
> Fix rxgk_decrypt_skb() or rxgk_verify_mic_skb() to return a greater variety
> of abort codes and fix their callers to abort the connection on any error
> apart from -ENOMEM.
> 
> Also preclear the variables used to hold the abort code returned from
> rxgk_decrypt_skb() or rxgk_verify_mic_skb() to eliminate uninitialised
> variable warnings.
> 
> Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lists.infradead.org/pipermail/linux-afs/2025-April/009739.html
> Closes: https://lists.infradead.org/pipermail/linux-afs/2025-April/009740.html
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


