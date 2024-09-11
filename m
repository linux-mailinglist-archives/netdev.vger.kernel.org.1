Return-Path: <netdev+bounces-127588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AFA975D2E
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAF12857CD
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63E41BB686;
	Wed, 11 Sep 2024 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/QY/Pzg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF71885A8
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093540; cv=none; b=Al0APWasL9fSlaejuLWlZGRu3mbIqnZ5ShRGEUXIe5FjNtG0eqlP5ePbR0ifjx9bsSk7Jh24cZGiKXJXyfffSvcPV2b1Q07i3psz9J4+EYOJyU77MBxpj/3Yv8SBASNHSDYXBdXPn5pde1QJ238QaadO1Mr+zyczsTGOSiioW3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093540; c=relaxed/simple;
	bh=MH7eVIICBehm6rrwRo1VomRmFryYT0oORsOlNKawq5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5LDtjS6EhXm9Av7ZHyhC6QzbL24sYezt6Lt4IItE1/ND/fwluTpYSYTWBFTZiyqgeZoJeb27EhKK5gq11/ZCPy5oJoJRD0OATBKCe7SaBioB27iyxz52ZJyrggzslY0Yhu6RvnW3Ldy7VjnizMuUnAwuVKqMtzTvSxpEYyDZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/QY/Pzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FABC4CEC0;
	Wed, 11 Sep 2024 22:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726093540;
	bh=MH7eVIICBehm6rrwRo1VomRmFryYT0oORsOlNKawq5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p/QY/PzgJZNPDLtBH54nlbjb/yxWpKH6USSDIxavN7adUg+1vB1/NL5RrQi3PhJYc
	 H7p8PD1amP6w8NvbQmLucwNw7s8fXA1cfj3dz5exRszDUd9+ngCBbQqbrzwsER0v1n
	 JoF95/wjF5HbJ4wOJ8zsYPPbs6Ic77JvneNK992IGq35nzpbtH34zesk/4oD0Zfdgq
	 4gGAslE5U/zPjzAJBLgh4Z1lVR7DRAv8e8mVbe0y5Sn8+YGepAloKlOt5pcysPKkU9
	 KWGA3v4mUl0tADrXXb2jIe3FIL83Vd+qw/1A33LZsYWPTmrzVl4oNCRBnvuJO+izgh
	 tBoIahUApxWyA==
Date: Wed, 11 Sep 2024 15:25:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, David Ahern
 <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Alexander Duyck <alexanderduyck@fb.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] eth: fbnic: add initial PHC support
Message-ID: <20240911152539.4030764b@kernel.org>
In-Reply-To: <4c720c2e-7a60-4f94-96bd-94ab59fa8905@lunn.ch>
References: <20240911124513.2691688-1-vadfed@meta.com>
	<20240911124513.2691688-3-vadfed@meta.com>
	<006042c0-e1d5-4fbc-aa7f-94a74cfbef0e@lunn.ch>
	<c1003a1b-cf6f-4332-b0c7-5461a164097e@linux.dev>
	<20240911131035.74c5e8f9@kernel.org>
	<4c720c2e-7a60-4f94-96bd-94ab59fa8905@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 22:45:11 +0200 Andrew Lunn wrote:
> > > That's good question. Do we need another set of helpers just because of 
> > > names? Obviously, the internals will be the same sequence magic.  
> > 
> > Good question. To be clear we want a seq lock that goes away on 64b
> > since what it protects is accessed on the fast path (potentially per
> > packet). We could s/u64_stats/u64_seq/ the existing helpers. But that
> > sounds like a lot for a single user. Dunno..  
> 
> It does sound like a lot of a single user.
> 
> And what is the likelihood of this device ever being used on a 32 bit
> system? It is a server class NIC. Are there still 32 bit servers in
> use?
> 
> Maybe "depends on 64BIT" with a good commit message why?

Will this not apply all new MMIO devices? They will either be high
enough class to be only used on 64b systems, or built into a 64b SoC.

No strong feelings either way, but I think we'd need a better defined
guidance on when "depends on 64BIT" is acceptable and when developers
have to go thru the pain of using u64_stats_*.

