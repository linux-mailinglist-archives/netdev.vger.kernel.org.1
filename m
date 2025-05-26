Return-Path: <netdev+bounces-193426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1B1AC3F08
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D461896EE4
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 12:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA5F1DF26B;
	Mon, 26 May 2025 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYi1wd5M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C54817CA1B
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748261059; cv=none; b=JwYdWjZpZJ5RApvi3sLTNtmesSxMg6k815mZ8/w6spKg1lhUpiUe5VPY2fY0dYSNpNX9FJQnxzidfqNF+BUIC14BfPfp+oeZZxNuyYwxfTdmDcvudzTEDiizV5mlrESvvi74w6hbLmv8mk8G0FEj0x2hRt4gitHmNH/xCGjELaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748261059; c=relaxed/simple;
	bh=Yjglp7gVqEfXqX9p/c5sm4OhJsIPQOgO025Yai4d4IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWJKgkWzdFkhAXF8lNtBJCT+hsgQhzkPu5KzLA/5/2GS+yqtseV4Gk9vimht+XxUgB/ElrJZ5JeD3GPD6Xt2KaVEgcxqhQvIelKh+kMJ+dCd3uUsoe/U6s5XpJibNldO8DOe2r6HxrHJyqXSxmBZ2rnI4G61GtJSOMaTvRFBh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYi1wd5M; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748261057; x=1779797057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yjglp7gVqEfXqX9p/c5sm4OhJsIPQOgO025Yai4d4IE=;
  b=AYi1wd5M31Onpb277c7f5kTgd7N/NN20Mnz6yHnwbTH0ezFM6lowRxXc
   KoQZcaSIZgLKYNtyo03hlOmie7NLO/iLJl92BF04DLSD4RqC4Zvnp8dMz
   yoMseNPjWd7DVw3E8cNK22fME6XjlFMY5qRJKr5vr16yt+judYiqoeupW
   N13RkqkP17xuJ4PbKLW624GVgW5vWtIlIWFK4yfrq1Hba5numFDReBSCp
   JGpXiFIwSes4QKtOdiDxTHTCUgUD4apg5JLiMHljJpaFFX5hINPHYwf9G
   n0AshLk9Zbmg+ApYA3XRhTSqiMTJE8PM2xXkEiHVOw7IWyltBKDELcA5p
   A==;
X-CSE-ConnectionGUID: ALyeyPyJTdyDQv3aKMy35w==
X-CSE-MsgGUID: c/jmPZf5RUq25mo2UTqDuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="49350520"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="49350520"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 05:04:16 -0700
X-CSE-ConnectionGUID: FfDtBwgdSVyDtm3LDXZVXQ==
X-CSE-MsgGUID: G05iTOX5S6+W7oMALt3TBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="143317309"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 26 May 2025 05:04:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 63629376; Mon, 26 May 2025 15:04:13 +0300 (EEST)
Date: Mon, 26 May 2025 15:04:13 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: netdev@vger.kernel.org, michael.jamet@intel.com, YehezkelShB@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <20250526120413.GQ88033@black.fi.intel.com>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>

On Mon, May 26, 2025 at 01:47:58PM +0200, Ricard Bejarano wrote:
> > Simple peer-to-peer, no routing nothing. Anything else is making things
> > hard to debug. Also note that this whole thing is supposed to be used as
> > peer-to-peer not some full fledged networking solution.
> 
> > Let's forget bridges for now and anything else than this:
> >  Host A <- Thunderbolt Cable -> Host B
> 
> Right, but that's precisely what I'm digging into: red->blue runs at line speed,
> and so does blue->purple. From what I understand about drivers and networking,
> it doesn't make sense then that the red->blue->purple path drops down so much in
> performance (9Gbps to 5Mbps), especially when the reverse purple->blue->red path
> runs at ~930Mbps (which lines up with the purple->blue link's speed).

Yes but you are adding things into the mix. I'm trying to understand if
there is something in the drivers I maintain that I need to look. I'm not
networking maintainer so I cannot help in generic networking related
issues.

> > So instead of 40 Gb/s with lane bonding you get 10 Gb/s (although there are
> > some limitations in the DMA side so you don't get the full 40 Gb/s but
> > certainly more than what the 10 Gb/s single lane gives you).
> 
> Right, but I'm getting 5Mbps, with an M.
> That's 1800x times slower than the 9Gbps I get on the other way around on direct
> (non-forwarded, non-bridged) traffic. I'm sure I don't have hardware for 40Gbps,
> but if I'm getting ~9Gbps one way, why am I not getting similar performance the
> other way.

Yes but you are bridging two networks here if I understand correctly.

> It's not the absolute performance that bugs me, but the massive assymmetry in
> both ways of the very same ports and cable.

Do you see that asymmetry with only single link? E.g with two (just two)
hosts? If yes can you provide full dmesg of the both sides?

> > You missed the attachment?
> 
> Yup, sorry. I've attached both the original tblist output and the reversed one.
> 
> > Well, if the link is degraded to 10 Gb/s then I'm not sure there is nothing
> > more I can do here.
> 
> This I don't understand.

I missed the asymmetry. I was talking about single link not the bridged
topology. For bridging part you can ask the network folks but I would first
like to see if there is anything in the link that can cause this.

