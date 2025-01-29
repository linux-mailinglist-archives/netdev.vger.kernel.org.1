Return-Path: <netdev+bounces-161556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E9DA22505
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 21:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A01188606F
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEFD1DFE02;
	Wed, 29 Jan 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4+Zx2YO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4F18FC65
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738181651; cv=none; b=RD6v3PW07BbyYaSiUfGjBi4N9yWbgg4oTx9Kk3MKtvEBBbZU67evArgQHg0EX2hejNo41s/ucnyB7RYRKlUxu4wshT4zH3sH50HyzmKTb0p3n7kh8RorNkpedPtrx10DBlbq6D4OF/6SY6MBVPaLHea5esnkuDnCKNzLMDWWAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738181651; c=relaxed/simple;
	bh=yx3yY/slSq5xw8TnnIPisPq9WFOY4us/KORWOt0txpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iw25JSTmZnHBVlXzW24aF5V6ngDm/mcU/PIRycw8TBllHGzW7c/hdgHJTPNp8ZmzB2AlNnn5GENwENGMr4UssDukcMsB+aojPtmJY8QX8JhNidUv6gBOp5urEwxXaVyZCfI1uL24V9sqRHkoizpGHBwMaHCyZ1cG54Rdl05r5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4+Zx2YO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8791DC4CED1;
	Wed, 29 Jan 2025 20:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738181649;
	bh=yx3yY/slSq5xw8TnnIPisPq9WFOY4us/KORWOt0txpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I4+Zx2YOs/LPGAf/ubcZoa5aGbTaq7MhRAp2ZjmpGVz66jsJlF4op2qzOHyu9JCtA
	 qaY9cV9M3Qc4yc3r6AieC5gl7NOM8s8kM8GJrBqXXwaktvEjAoAH4N+hbuQhl4E69Y
	 sSqbrclKeFGjGi2JnjPwquZpP1Ev6elUsJUU7rlAjbmajou2INleKhnio27Y0HmxN5
	 ggpIQXP6HWDZhJ3/qIkTQH9Jgw8x9acL6u16y9zJW+WK1HzvO1cghs6nt1Blw82ybY
	 mJ0Qz7sz+NoRIoNVXyXE8f2YkTPGcXpk5c3cvDdloY/qcGKXQEfZ18rfTOO8b5dsdB
	 EpehJVCEjwErw==
Date: Wed, 29 Jan 2025 12:14:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dsahern@kernel.org
Subject: Re: [PATCH net 2/2] net: ipv6: fix dst ref loops in rpl, seg6 and
 ioam6 lwtunnels
Message-ID: <20250129121408.0fe5d481@kernel.org>
In-Reply-To: <4a30a0aa-2893-4f6a-a858-61e51b2430b2@uliege.be>
References: <20250129021346.2333089-1-kuba@kernel.org>
	<20250129021346.2333089-2-kuba@kernel.org>
	<4a30a0aa-2893-4f6a-a858-61e51b2430b2@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 17:50:14 +0100 Justin Iurman wrote:
> > +		if (dst->lwtstate != cache_dst->lwtstate) {
> > +			local_bh_disable();
> > +			dst_cache_set_ip6(&ilwt->cache, cache_dst, &fl6.saddr);
> > +			local_bh_enable();
> > +		}  
> 
> I agree the above patch fixes what kmemleak reported. However, I think 
> it'd bring the double-reallocation issue back when the packet 
> destination did not change (i.e., cache will always be empty). I'll try 
> to come up with a solution...

True, dunno enough about use cases so I may be missing the point.
But the naive solution would be to remember that the tunnel "doesn't
re-route" and use dst directly, instead of cache_dst?

