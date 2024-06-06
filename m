Return-Path: <netdev+bounces-101226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5652A8FDCA3
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41221F23DC7
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6571401B;
	Thu,  6 Jun 2024 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhdLg9sg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75B8C0B
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640287; cv=none; b=L15zvnrCuJ07NAUN357fMxniyd16q/pi70KWZvx1704Jrj2IdFY1De/w8MLBbb3R3NUcGmLB7y6CN6+Xfvtl1+QfRHDTKgRgYsKdXAIh8T3C5PTeX9ccW8hNTk49F45aE6lELT/eYd+h+x+t0HBoRzs0wqg18A7iK4QBhd8Sbyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640287; c=relaxed/simple;
	bh=KNkRuBYRNzRi7impR7KY6QWySIaI+z9K2BpA7wqgJ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJdCrT2koy5aBeFee+2K5+kx5qYDdIB+GgBIziwxNJK/QapbA/rkcO6zx0Sb+7uzwqOuWicVTq+hqVs4IaxfC+ARWiwOib6LF7E7KxO+EVwP+xc1pmRQ3cvj8R0nGM4b8L7kRGSy/3uBG4aWVkNbMrTxzaeOt/dGnan1f1RXmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhdLg9sg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B826C2BD11;
	Thu,  6 Jun 2024 02:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717640286;
	bh=KNkRuBYRNzRi7impR7KY6QWySIaI+z9K2BpA7wqgJ+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NhdLg9sgmJI/JsJ2ZZvnLM2LEcrsx2JTbGlMdaOQD/F/U4ZWLXMt5aw+BmXYNqP6x
	 5Yd6ay8aWuCmXQHEhiToC4WPg0pZ1UTlfcKf5sOAVSRnTOU3S1v3PKDCZtI1DDZTAh
	 d3Q7DoHXysReodXRpWkzUE062eq/JvfDTbJm+fThiU325TvV2PcF3IAbQEzyvg7vNU
	 PGHQl81h8/wlVjKX/KHv5nQibFDKme5kjedfW3vin0oX9u8caI9PFBZiaFBvKYQypW
	 +jZTUwjXQGJdCHuNXeRkIOhCImPeTJ7igQYYp3NVUHzaolYgg68YveVfFeSggsWOd2
	 Zz0T9wpoJBmzA==
Date: Wed, 5 Jun 2024 19:18:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net: core: Unify dstats with tstats and
 lstats, add generic collection helper
Message-ID: <20240605191800.2b12df8d@kernel.org>
In-Reply-To: <ccb2a7fc282d7874bc3862dad1ca7002b713ac33.camel@codeconstruct.com.au>
References: <20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au>
	<20240605190212.7360a27a@kernel.org>
	<ccb2a7fc282d7874bc3862dad1ca7002b713ac33.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Jun 2024 10:11:51 +0800 Jeremy Kerr wrote:
> If we're not exporting the helpers, that means that drivers that use
> dstats wouldn't have a facility to customise the stats collection
> through a ndo_get_stats64() callback though (as can be done with
> tstats). Are you ok with that?
> 
> [the set of drivers that need that is currently zero, so more of a
> hypothetical future problem...]

Right, but I think "no exports unless there is an in-tree user"
is still a rule. A bit of a risk that someone will roll their own
per-cpu stats pointlessly if we lack this export. But let's try
to catch that in review..

