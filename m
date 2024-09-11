Return-Path: <netdev+bounces-127569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6321E975C09
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53DCB23A2F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28371BC07D;
	Wed, 11 Sep 2024 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cVdNGgsw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45601C2E9
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087524; cv=none; b=X1GiFuLMvW2tLwhNOmAbnJko71aqBrhNNobUhD0XtM8GiNntrmc/oaS/eNhOBHHCwZA+CSye0w8WbH6yEcRdcekf7s4IZ1kYaHQXUx3OXugEjPFdhYM3zO7dGGfEGIjWASlCcRzT4maTdiGV5ALRl9bpxvGlNeSmhp3VjXlNZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087524; c=relaxed/simple;
	bh=D1fHgIdQfkUBtWdVqUq5gZu7uUUn9awQLJClmfSX02c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVZWyZulqhDH4To2W3GNMpzO7XJq6SL/dlzo5Gj4yPFN9V7CLDcR9wf0S65CoKHlYcgTfVfOJnGuCmFwDKjJb3RHOmajq2LCvDhtsZ9gZgbRfFyzjsV6M0t3EvpxoNGnyfn0l4J3tmwb/1wAYZPNF9qxhaRuzaCdsOiG1kuPl7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cVdNGgsw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NKxpnKThnuRb1DCyK1P3S9wNVBFay/ooTSE9FrEWQw4=; b=cVdNGgswF/2o5LdM2Np9IDF3i/
	M17YKzdodL6A3UBSdzU+V5LDdIHSZE5qJEh7EWbfdlIwuAwLraB0CWrUqx9KreaHIL1uUwma4EfJq
	5Ju3ETvZp7vILeygG+6mt7Juz8ixM3yWlSewB56SCiGOxdW4V+q4jxiYX3XmRt9V8Sm0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soUD9-007Fce-OD; Wed, 11 Sep 2024 22:45:11 +0200
Date: Wed, 11 Sep 2024 22:45:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexander Duyck <alexanderduyck@fb.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] eth: fbnic: add initial PHC support
Message-ID: <4c720c2e-7a60-4f94-96bd-94ab59fa8905@lunn.ch>
References: <20240911124513.2691688-1-vadfed@meta.com>
 <20240911124513.2691688-3-vadfed@meta.com>
 <006042c0-e1d5-4fbc-aa7f-94a74cfbef0e@lunn.ch>
 <c1003a1b-cf6f-4332-b0c7-5461a164097e@linux.dev>
 <20240911131035.74c5e8f9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911131035.74c5e8f9@kernel.org>

On Wed, Sep 11, 2024 at 01:10:35PM -0700, Jakub Kicinski wrote:
> On Wed, 11 Sep 2024 20:49:51 +0100 Vadim Fedorenko wrote:
> > >> + * TBD: alias u64_stats_sync & co. with some more appropriate names upstream.  
> > > 
> > > This is upstream, so maybe now is a good time to decide?  
> > 
> > That's good question. Do we need another set of helpers just because of 
> > names? Obviously, the internals will be the same sequence magic.
> 
> Good question. To be clear we want a seq lock that goes away on 64b
> since what it protects is accessed on the fast path (potentially per
> packet). We could s/u64_stats/u64_seq/ the existing helpers. But that
> sounds like a lot for a single user. Dunno..

It does sound like a lot of a single user.

And what is the likelihood of this device ever being used on a 32 bit
system? It is a server class NIC. Are there still 32 bit servers in
use?

Maybe "depends on 64BIT" with a good commit message why?

	Andrew

