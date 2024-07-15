Return-Path: <netdev+bounces-111530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA71931788
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C0F1C21235
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F5918EA98;
	Mon, 15 Jul 2024 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ph0dJc8H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7D18C35B
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057163; cv=none; b=Rkpa/r+BW+2s/0KraB/LdyhbgpHIThp+INjYkUh1moUqvhYkvObZ6lZvWh7Iu6aWlUgRr7y25fXwfF1Yw9fBArz7j4yQ7rGWjOL6lI5ru8V8tDVOnvr2mluQK8TVnAucidPo/G/CUl5eGUM37BKfAqkCFXgQVNz9Jxkk7rB8WP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057163; c=relaxed/simple;
	bh=znGvyjTORceX1GewmKfD0yr01wOkn6ojfBV4Bd0N8uU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAux9VvrybiWbw+fi0PoF/0EcPvdhQcWtUV0SIFE3Z6Z1oXDzUWdiVNWvSy7219DVyQUiIqKo4FwaVG0Frwz/F5rZIRjE0ZNpAXx8594vWaPC2gogLO5FUDOLQ9nImRUhVZv2dXLOK4V6O8j9HiMdNK1TgYrTqXzIwGgZDyCBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ph0dJc8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0FBC32782;
	Mon, 15 Jul 2024 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721057162;
	bh=znGvyjTORceX1GewmKfD0yr01wOkn6ojfBV4Bd0N8uU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ph0dJc8H6mt0Iz0L6MuPBM+8SN4dfO/+Bf3CzIt3UP6Mmv5d0ElfXfeZmxJE2VTLh
	 rT8Tl3DbwbRan8Fl2jBxNhsMGj24U7IOHHfQ/aL/7uYFiSS+bQWqWp1rmsTBqK1tka
	 IHJTUIU8XT8St2p73iYbbGc4MOoGW4dOwKEyXfejKB2G3nRc4pY44WDH/I2kAAv2oE
	 gxa4SISirnpNWtfI2x807oy/FeKQrhSrefzX6/DcsQ4KAo9LQz/L4mihORoaNDqnC9
	 ozohL+3VSnGCbGmtVzl9EDidmteZL8kaHoiy3/zesAsg5vs9QhpaVH8QAeKixCR2zQ
	 OOOYTezm0BE0Q==
Date: Mon, 15 Jul 2024 08:26:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>, Michal
 Kubecek <mkubecek@suse.cz>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Wei Fang <wei.fang@nxp.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>
Subject: Re: Netlink handler for ethtool --show-rxfh breaks driver
 compatibility
Message-ID: <20240715082600.770c1a89@kernel.org>
In-Reply-To: <20240715150543.wvqdfwzes4ptvd4m@skbuf>
References: <20240711114535.pfrlbih3ehajnpvh@skbuf>
	<IA1PR11MB626638AF6428C3E669F3FD4FE4A12@IA1PR11MB6266.namprd11.prod.outlook.com>
	<20240715115807.uc5nbc53rmthdbpu@skbuf>
	<20240715061137.3df01bf2@kernel.org>
	<20240715132253.jd7u3ompexonweoe@skbuf>
	<20240715063931.16bbe350@kernel.org>
	<20240715150543.wvqdfwzes4ptvd4m@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 18:05:43 +0300 Vladimir Oltean wrote:
> On Mon, Jul 15, 2024 at 06:39:31AM -0700, Jakub Kicinski wrote:
> > The definition I have in mind is that the design can't be well
> > understood without taking into account the history, i.e. the order
> > in which things were developed and the information we were working
> > with at the time.
> > 
> > In this case, simply put, GRXRINGS was added well before GCHANNELS
> > and to assign any semantic distinction between GRXRINGS and GCHANNELS 
> > is revisionist, for lack of a better word.  
> 
> Are you saying a channel is a ring?

The information about rings can be computed based on channels as
currently used by drivers.

> Semantical differences / lack thereof aside - it is factually not the
> same thing to report a number retrieved through a different UAPI
> interface in the netlink handler variant for the same command.
> You have the chance of either reporting a different number on the same
> NIC

They can provide a different number? Which number is the user
supposed to trust? Out of the 4 APIs we have? Or the NIC has
a different ring count depending on the API?

> or GCHANNELS not being implemented by its driver.
> 
> revisionist
> noun
> someone who examines and tries to change existing beliefs about how
> events happened or what their importance or meaning is

Why not also look up "for lack of a better word" :|

> > I could be wrong, but that's what I meant by "historic coincidence".  
> 
> And the fact that ethtool --show-rxfh uses GCHANNELS when the kernel is
> compiled with CONFIG_ETHTOOL_NETLINK support, but GRXRINGS when it isn't,
> helps de-blur the lines how?

IDK what you mean, given the slice of my message you're responding to.

> I can't avoid the feeling that introducing GCHANNELS into the mix is
> what is revisionist :( I hope I'm not missing something.

You are missing the fact that other parts of the stack use different
APIs. Why does RXFH need its own way of reading queue count if we have
channels and rx queue count in rtnl?

> I'm just a simple user, I came here because the command stopped working,
> not because I want to split hairs.

Plainly :|

