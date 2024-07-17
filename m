Return-Path: <netdev+bounces-111904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1AC9340B2
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 18:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149672827CD
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1548181D1E;
	Wed, 17 Jul 2024 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLJvnS8J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0991822CC
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234703; cv=none; b=uMT2NFWHZDvjKl9mjz9Esm7NFJRvhKNSXemQPmDEKmMf0vg39DgopGn4HXwf+samhE4YgTUG23fbySr4x7EtppS7nnNU1EERy5u4opRXTRq/vvB6b02c5DifVxzj9JWuW77i51uJsjAWTVPH+kaYkr8G/xijk4tBOvDj7DxFBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234703; c=relaxed/simple;
	bh=Fn+Lq6P6efRTL/3K52MnTwwZ9y10ySH+LiLX/lxr51g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2/kGGdFnPvr9dJ1mFsOu5yNYjLvvQp+HSIovoVZ+2yIigIOTQsOLgzRDOGQ7kZ36i5jlR6vs4ax73KjVwf8B/58VMRezxqOmTcYAc+IxW5/hzcda73Beedp98sjDUDCGklZXalmhqqWYwvQZcJvrjZwDPJJiCoWyVzs/rPM0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLJvnS8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2592FC2BD10;
	Wed, 17 Jul 2024 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721234702;
	bh=Fn+Lq6P6efRTL/3K52MnTwwZ9y10ySH+LiLX/lxr51g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RLJvnS8J1wPv1pEU+ddx/R3YGGXIBqPRDRMCsHKz3c9gnN++R+fX8k8fM25YyDg04
	 8jjcRl+zqiYDk/exFyQep3ribANNL73YUEOHaTXGq61aXVqH3WN9aOqrCVpn3l05On
	 SU/dVV+eAjKElcW036qZR1CKAgYtRLWwvAERFj20mLJramei+hXZgxVa8FZlOxKLt3
	 7AE9A8PD1ZgnTiZUHzGoKibaknGVQn7+23C8Q5r0VDyPIXlEojVis1KLwJqTHl7O9i
	 DdJSm6ank0afSC0eHcpC9ZpJdVzIIK8H09awoUPV70qcj0UpkaHqPrmxXaUMvpFB2f
	 fXPdIGv/0AETg==
Date: Wed, 17 Jul 2024 09:45:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>, Michal
 Kubecek <mkubecek@suse.cz>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Wei Fang <wei.fang@nxp.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>
Subject: Re: Netlink handler for ethtool --show-rxfh breaks driver
 compatibility
Message-ID: <20240717094501.2e60075d@kernel.org>
In-Reply-To: <20240715154653.kcqcazsndp4nrqqh@skbuf>
References: <20240711114535.pfrlbih3ehajnpvh@skbuf>
	<IA1PR11MB626638AF6428C3E669F3FD4FE4A12@IA1PR11MB6266.namprd11.prod.outlook.com>
	<20240715115807.uc5nbc53rmthdbpu@skbuf>
	<20240715061137.3df01bf2@kernel.org>
	<20240715132253.jd7u3ompexonweoe@skbuf>
	<20240715063931.16bbe350@kernel.org>
	<20240715150543.wvqdfwzes4ptvd4m@skbuf>
	<20240715082600.770c1a89@kernel.org>
	<20240715154653.kcqcazsndp4nrqqh@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 18:46:53 +0300 Vladimir Oltean wrote:
> > They can provide a different number? Which number is the user
> > supposed to trust? Out of the 4 APIs we have? Or the NIC has
> > a different ring count depending on the API?  
> 
> To stay on point on GRXRINGS vs GCHANNELS, "man ethtool" does say
> "A channel is an IRQ and the set of queues that can trigger that IRQ."
> Doesn't sound either (a) identical or (b) that you can recover the # of
> rings from the # of channels, unless you make an assumption about how
> they are distributed to IRQs...

A bit short on time to write a proper reply, but thinking some more
about it, I think you're right. The choice of channels is not great.
It works today, but if we start stacking multiple Rx queues on a single
IRQ one day - things will get complicated. So let's go back to GRXRINGS
for now.

