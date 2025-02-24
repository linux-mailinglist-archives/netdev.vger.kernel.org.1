Return-Path: <netdev+bounces-169091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26842A428E6
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C24188E64D
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CBD265CBC;
	Mon, 24 Feb 2025 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1eyv4aR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183426136C
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416294; cv=none; b=er5eSC9OTh8/WBe9Rd6NQtMeiCbhHHZ0630DLg374xBWNUq3dxhr/8Xg8yIKLvk7VxGXahFDS3vI3FK12eFNJsLxSgb9Sg6aE3UM+GZp86cXPj6GuoAqLl5112tiqNWdIIpWDUb9FxO/3JundA6v6oXExkRukPM8BTca+lqPyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416294; c=relaxed/simple;
	bh=snpjrBnx+nyAZcP88VHtXtp8SL/AaIMXNSrdfgx5c1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ob/VhRbDBaPpADK38PUndohZL4yPQmPKfsf9MpUmNWJGbzjxU6m47HrMSumNU22VxU0y3fsVdAz4Y54zV2VkyMYP1SFvonnWNjE1Oz85ZPu3jZ6Fb01Rs0Jo4O305KcdsAZNtBy1W9ERIExIzrKXb5E9uEa7ghoP9Y/zncBkLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1eyv4aR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FFCC4CEDD;
	Mon, 24 Feb 2025 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740416294;
	bh=snpjrBnx+nyAZcP88VHtXtp8SL/AaIMXNSrdfgx5c1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d1eyv4aRrfiJwRA9YI3YQd90Tk9XPK/tN6fSFCuZFbTxyHSwOB/AYvr+3QMTS0c73
	 ZOdZeYcg3XzSF82wj9sWLW4LdHE5D3ZjgHVI89HpC0SH2aOIQ5/lIU5o5zhoxuaD6Z
	 l0jc/KBI/h5Uynp8Igj/8X9PWpUkuHIkeuruD+0iDQ3WyQogI6YytYlCuQCZLTaPe9
	 d/mTnqBuMCW4mKGIzr1YDeQ/ZYieg8MxvYbYjkIA95SUlDcgliSB9Sdj2GZykU28JY
	 0ZzHIWbs6OZvLqErsGRym+h5xj5p2TiDvxirzK4VprPRscMDle86TSJYftOFA3v+uc
	 nWlAUao40FM3g==
Message-ID: <5b9f16c1-450c-4a39-be2c-634b4f1864b5@kernel.org>
Date: Mon, 24 Feb 2025 09:58:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 v2] tc: Fix rounding in tc_calc_xmittime and
 tc_calc_xmitsize.
Content-Language: en-US
To: Jonathan Lennox <jonathan.lennox@8x8.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
References: <20250216221444.6a94a0fe@hermes.local>
 <B6A0B441-A9C9-40B5-8944-B596CB57CF0E@8x8.com>
 <395fdc3a-258c-494f-914d-5da3861c0496@kernel.org>
 <789337E1-213F-4FAE-A5D4-4647C0A288E1@8x8.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <789337E1-213F-4FAE-A5D4-4647C0A288E1@8x8.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/24/25 9:36 AM, Jonathan Lennox wrote:

####

> The problem is that tc_calc_xmittime and tc_calc_xmitsize round from
> double to int three times — once when they call tc_core_time2tick / tc_core_tick2time
> (whose argument is int), once when those functions return (their return value is int),
> and then finally when the tc_calc_* functions return.  This leads to extremely
> granular and inaccurate conversions.
> 
> As a result, for example, on my test system (where tick_in_usec=15.625,
> clock_factor=1, and hz=1000000000) for a bitrate of 1Gbps, all tc htb burst
> values between 0 and 999 bytes get encoded as 0 ticks; all values between
> 1000 and 1999 bytes get encoded as 15 ticks (equivalent to 960 bytes); all
> values between 2000 and 2999 bytes as 31 ticks (1984 bytes); etc.
> 
> The patch changes the code so these calculations are done internally in
> floating-point, and only rounded to integer values when the value is returned.
> It also changes tc_calc_xmittime to round its calculated value up, rather than
> down, to ensure that the calculated time is actually sufficient for the requested
> size.

####

put that blurb as the commit message and re-send.

Thanks,

> 
> 
> Can you let me know the desired style for commit messages — how much of this
> explanation should be in it?  I can submit a v3 with the desired explanation in
> the commit message.
> 
> Thanks!
> 
> Jonathan Lennox
> 


