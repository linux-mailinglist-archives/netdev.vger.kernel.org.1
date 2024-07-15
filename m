Return-Path: <netdev+bounces-111491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E76C9315EC
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC89DB21BA7
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331B018D4CE;
	Mon, 15 Jul 2024 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQFobfmL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8218C180
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050773; cv=none; b=u7JvgqivWAb1UV0e1gZWh4mSboJj4y7KdUkGqEp8VMARGJ20Uuq6YCMpGU9GdaiRMU5cTObQ2QTLc1ICkfJexJCPcMEwrojGlR3hQ+UAFgzQGeKlNxyuO98WVL+wL/i5HFlMbrsGBkFHvEM4g3sOTVTalEGQqy9sHoVVKI1rhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050773; c=relaxed/simple;
	bh=g+Yhp/SRR/rjK6LtyITOcOXqz1gSrvLgj5w71QKDiq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/V5cMOF36DQBrsMEPQd6E5CWnFrprtGGwLVfT20+vyhr+92vngBlFp6srVeyzvqAs3CUXPKvjajJrb7eif/ey+P4zEtG7xudeakupR2uTxL0q+wk5xbF1laKVxBKVs0Uo8QlPAfOzdE6mxigNJIx0s093r7+UpGYidbvcwq5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQFobfmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A57C32782;
	Mon, 15 Jul 2024 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721050772;
	bh=g+Yhp/SRR/rjK6LtyITOcOXqz1gSrvLgj5w71QKDiq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pQFobfmLIi9hk5k7fEUd6tdZ147k/sUN16RUFHwFKMx9G/WiL9zCz7nDs9tEPJrXe
	 dQ+IrUSxw/YGEfAtwapwd7XQJurRUCOzOP5qyM9+cPddbc7LYl8i1oCJC8K7qqSMJZ
	 xF1TruQ+/QquEtmlsy1G/qiW5+/USbrleRGkTN3QfM3yHXMxNp6tO10AhUbNcxln6d
	 s7QjI912DCPBJ7FEBZ/qY/oSqFkZy8Z55uRUPxsbAaQzNbT1QasENJrJmSSJfaj8gu
	 sGSpLCRVGT+vT3pFs854vpBVp8JdkTwk/UXgt/6177wCVahEgR6TDdMlklOHln9zdF
	 NafRsDYVIYwnw==
Date: Mon, 15 Jul 2024 06:39:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>, Michal
 Kubecek <mkubecek@suse.cz>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Wei Fang <wei.fang@nxp.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>
Subject: Re: Netlink handler for ethtool --show-rxfh breaks driver
 compatibility
Message-ID: <20240715063931.16bbe350@kernel.org>
In-Reply-To: <20240715132253.jd7u3ompexonweoe@skbuf>
References: <20240711114535.pfrlbih3ehajnpvh@skbuf>
	<IA1PR11MB626638AF6428C3E669F3FD4FE4A12@IA1PR11MB6266.namprd11.prod.outlook.com>
	<20240715115807.uc5nbc53rmthdbpu@skbuf>
	<20240715061137.3df01bf2@kernel.org>
	<20240715132253.jd7u3ompexonweoe@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 16:22:53 +0300 Vladimir Oltean wrote:
> On Mon, Jul 15, 2024 at 06:11:37AM -0700, Jakub Kicinski wrote:
> > On Mon, 15 Jul 2024 14:58:07 +0300 Vladimir Oltean wrote:  
> > > Looking at Documentation/networking/ethtool-netlink.rst, I see
> > > ETHTOOL_GRXRINGS has no netlink equivalent. So print_indir_table()
> > > should still be called with the result of the ETHTOOL_GRXRINGS ioctl
> > > even in the netlink case?  
> > 
> > How about we fall back to the old method if netlink returns EOPNOTSUPP
> > for CHANNELS_GET? The other API is a bit of a historic coincidence.  
> 
> Explain "historic coincidence" like I'm 5?

The definition I have in mind is that the design can't be well
understood without taking into account the history, i.e. the order
in which things were developed and the information we were working
with at the time.

In this case, simply put, GRXRINGS was added well before GCHANNELS
and to assign any semantic distinction between GRXRINGS and GCHANNELS 
is revisionist, for lack of a better word.

I could be wrong, but that's what I meant by "historic coincidence".

