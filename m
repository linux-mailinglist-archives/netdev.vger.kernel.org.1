Return-Path: <netdev+bounces-73305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746C785BD1C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 14:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1640B1F22BA6
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D93B6A03B;
	Tue, 20 Feb 2024 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI+7nwL4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9B6A00F
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435479; cv=none; b=Cwhk9AlEpTU46Ke/uoFZk8oJsp4TL6Khzpx2I/WgHIhc7kmarkBpqw8RoAXdw3E69gx98Ooy+Ls8CSPr2R2dN9/xKH33Y1WQos7V8pj1JnIgB6pltzhIVl54mIFh7KlZROG+mmMfic/zaqWV5ru8/tSumtjcLKpN5ZxdurSIZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435479; c=relaxed/simple;
	bh=BNwpqN3c7BqebP6LLRFElUCtfWshD+fwJZGJiax3sbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okiEK/++ZnY6B6m9td+Rt1TkPeRckeANF6D1stCuhOos5K3lvvwmMUCmSyZ3WFhJZkhq2LWIS6jXlKDK/vmmZdgF9bFa65xQCHcslAW30vtKuc94KLls0UzNjzjvn30sQaWxzo2m1tN2pl3/c5Z5ZRgq8i5/PnM56ezhDdk7j1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI+7nwL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE118C433C7;
	Tue, 20 Feb 2024 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708435479;
	bh=BNwpqN3c7BqebP6LLRFElUCtfWshD+fwJZGJiax3sbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pI+7nwL4sieiEP0Sei2UW5sPDgmRZaUq6H09hoewAgu+omB09DUXMcRGKgAkJ9uIM
	 2Fpg4pTgK9PQD92BDciPcI4lzx5HP58cIDCqj1Wp9mi1Ta2LTHicW0OifW2bhalyED
	 qjHMQsRyPt6n/lZ6ZbV8qM8bTSSWS2c1iiMITyKcxy8LllmqlpxUU7LqyBYkZOFrrS
	 asUM4R5i4RF9WspyZ0rq0ts/Q5HPN0CxDEN+nMoRS8/IbedPtcykYYgEGkijrspx9f
	 4Uv6/9GrJoYX466IsWMSper3QTlG0KIx2VP++UWudlGHzLsZSI4Pa91Nggg9xFW9F4
	 ZWtvNU9DeLTOg==
Date: Tue, 20 Feb 2024 13:24:35 +0000
From: Simon Horman <horms@kernel.org>
To: Dave Taht <dave.taht@gmail.com>
Cc: Michael Welzl <michawe@ifi.uio.no>,
	Linux Kernel Network Developers <netdev@vger.kernel.org>,
	bloat@lists.bufferbloat.net,
	BBR Development <bbr-dev@googlegroups.com>
Subject: Re: [Bloat] Trying to *really* understand Linux pacing
Message-ID: <20240220132435.GK40273@kernel.org>
References: <1BAA689A-D44E-4122-9AD8-25F6D024377E@ifi.uio.no>
 <CAA93jw6di-ypNHH0kz70mhYitT_wsbpZR4gMbSx7FEpSvHx3qg@mail.gmail.com>
 <B4827A61-6324-40BB-9BDE-3A87DEABB65C@ifi.uio.no>
 <CAA93jw5vFc6i8GebrXCXmtNaFU03=WkD6K83hgepLQzvHCj6Vg@mail.gmail.com>
 <CADVnQynGsNmPbXkdhy71AnpvfoBwhLi5qWwVJZQK5LiiA3V_rg@mail.gmail.com>
 <DE7C9FBC-8E67-408B-A1A3-3FE04FC71F51@ifi.uio.no>
 <CAA93jw6ycxsz4XvkE3F=MnLvFrBW66buNpCHOwPEn40x5JkpJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA93jw6ycxsz4XvkE3F=MnLvFrBW66buNpCHOwPEn40x5JkpJw@mail.gmail.com>

On Mon, Feb 19, 2024 at 09:02:24AM -0500, Dave Taht wrote:
> also your investigation showed me a probably bug in cake's
> gso-splitting. thanks!
> 
> However, after capturing the how as you just have, deeper
> understanding the effects on the network itself of this stuff would be
> great.

Hi Dave,

Please don't top-post on the Netdev ML.

Thanks!

