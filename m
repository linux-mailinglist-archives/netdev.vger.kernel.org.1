Return-Path: <netdev+bounces-166794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7AFA3756D
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B1518830A6
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178431991DD;
	Sun, 16 Feb 2025 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H4q8uVsk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22841DF78
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722121; cv=none; b=QBkpG35wrdP8NFQJWysYHzOOEo4GgBZKGg6+AWxBpoQ9IxsKB3EM3GSfb7zSHtLzdG/8rfe4mOFtnmarJHN8qbm1ki+vRaM0Q/6G1d5l5lJB54D3fhPimu1q+29Uv7Ek0ZcxKhztHXA1n/td4aEc4fadz1ENWQiERrJtrCxG8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722121; c=relaxed/simple;
	bh=FHGvcORbXYPHiW3ah+wlOwSeMTvHUb5U5zZ7W1582R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McX+74dLIc7V/j25fZwev1V57mpD1WKtJoAwxb3GqCzzqhk8ChIbv64LahreqGdTM6+Ojw8rtn6+8ABeJpsRoiRZaYQYvbpMyf0Bx8Vx7Ve+tPTbpiMuM2neziDXPDTwvm8aaZ5zEPpTcj7g66HLBOVi/z1katMta3viUkuY0+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H4q8uVsk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TtoPxWzHabnLVTzuaN4IaK0Lt+B0O9KqxYH9fRYweDA=; b=H4q8uVskNrNM4D2OgBuuwy6N3n
	hb+AJJ2jzPvweU+PGAq27kXNE0aT08NSzArH5sIX9Uw1HwajavZhiSvG3rcgfSo7zX/oluLyS23yQ
	y+StzTk/ClbCqILT1W92UiJa4iMSNBnJ6+lwA2QdIUYfUuE5z8wL0B+lBfEFkcr+Ffsg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjhBv-00EhAh-F5; Sun, 16 Feb 2025 17:08:23 +0100
Date: Sun, 16 Feb 2025 17:08:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pierre@stackhpc.com,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [net v1] devlink: fix xa_alloc_cyclic error handling
Message-ID: <263574a4-4411-487b-bbb2-f3ff11daa19f@lunn.ch>
References: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>
 <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch>
 <64053332-cee0-49d8-a3ae-9ec0809882c0@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64053332-cee0-49d8-a3ae-9ec0809882c0@stanley.mountain>

On Sun, Feb 16, 2025 at 06:06:48PM +0300, Dan Carpenter wrote:
> On Fri, Feb 14, 2025 at 02:44:49PM +0100, Andrew Lunn wrote:
> > On Fri, Feb 14, 2025 at 02:24:53PM +0100, Michal Swiatkowski wrote:
> > > Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
> > > from xa_alloc_cyclic() in scheduler code [1]. The same is done in
> > > devlink_rel_alloc().
> > 
> > If the same bug exists twice it might exist more times. Did you find
> > this instance by searching the whole tree? Or just networking?
> > 
> > This is also something which would be good to have the static
> > analysers check for. I wounder if smatch can check this?
> 
> That's a great idea, thanks!  I'll try a couple experiments and see what
> works tomorrow.  I've add these lines to check_zero_to_err_ptr.c
> 
>    183          max = rl_max(estate_rl(sm->state));
>    184          if (max.value > 0 && !sval_is_a_max(max))
>    185                  sm_warning("passing non-max range '%s' to '%s'", sm->state->name, fn);
>    186  
> 
> I'm hoping this one works.  It complains about any positive returns
> except for when the return is "some non-zero value".
> 
>    194                  if (estate_get_single_value(tmp->state, &sval) &&
>    195                      (sval.value < -4096 || sval.value > 0)) {
>    196                          sm_warning("passing invalid error code %lld to '%s'", sval.value, fn);
>    197                          return;
>    198                  }
> 
> This one might miss some bugs but it should catch most stuff and have few
> false positives.  Both of them work on this example.
> 
> net/devlink/core.c:122 devlink_rel_alloc() warn: passing non-max range '(-4095)-(-1),1' to 'ERR_PTR'
> net/devlink/core.c:122 devlink_rel_alloc() warn: passing invalid error code 1 to 'ERR_PTR'

Nice. In networking, ethernet PHYs, there are a few functions ending
in _changed() have the same behaviour:

 * Returns negative errno, 0 if there was no change, and 1 in case of change

So there is the potential for the same issue with
mdiobus_modify_changed(), phy_modify_changed(),
phy_modify_mmd_changed(), phy_modify_paged_changed(). Hope this helps
with testing.

	Andrew

