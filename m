Return-Path: <netdev+bounces-230843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E296BF0704
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380C518A146A
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A342F8BC3;
	Mon, 20 Oct 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+LXGSHf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716372F83DE
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954899; cv=none; b=LVP4NQItyCaNKU4jq7dLcK5wsE3XLouUvliw9xKOMpFI1uiUG47CoVKA9wDpBP/7RXVwiNcha22UE4I5qur1Bz25cSoCPsEKr7TWMNqdSry6zmKq5uOlOTgy3XphOKW+FOu90x5QuHnGd2pPN5lLmNMAkqizZ/Xl4Ofju366kLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954899; c=relaxed/simple;
	bh=3jpdvDqGOYLHoLCn/nU4DYQHHqOxsf54UKbJKcsMiBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeHzvV6G4tWPtbIpYzFgcxuRgCEAnPdcGrxjqIBB3qlzryRJ+7NvYQkfG8VITfR6Us65H9UHGqpNIn/isFOkCjjLOqE2Lk0YFpvR4lIxDvpAo51p5VfL3e34xn8UAxhpRdNUZ//+8qIP5pNXtoTOqJrSQeFOZ54jaNTznFMmVTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+LXGSHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245D2C4CEF9;
	Mon, 20 Oct 2025 10:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760954898;
	bh=3jpdvDqGOYLHoLCn/nU4DYQHHqOxsf54UKbJKcsMiBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+LXGSHfcC0lDaCQ5gsSycjIG8+bik1nZW/tIU0SeZ/rLrJrygoIVkB2eDqqXYwSw
	 7e6BRh0g/2PHCN04Hsi3jNNnVWaCr9AfNXGvtfKu2/uSuY0X4Zy8HjJPjIc3RmKoJT
	 hMdadV51A+n98/vEtYfjPBtdI0ZCqODyPFs/h1yjWr0gwUG1+Ik5rZvQoqONKK8sQx
	 LWhBQ6LCv67wLTNVjz5ZQZItviBdOm60tS1sJKeJ5lZZGLdk80xPVrqU4fvwSAirQg
	 eTcRyItU5WzsCwixmaocr/qNfyxmTPPLLNfhUuR5YiTAN+yZ7Jn9SdiZNzKA0Cc0sk
	 sKPpNfyEhETbQ==
Date: Mon, 20 Oct 2025 11:08:14 +0100
From: Simon Horman <horms@kernel.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next] tsnep: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <aPYKDkBaoWuxuNBl@horms.kernel.org>
References: <20251017203430.64321-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017203430.64321-1-gerhard@engleder-embedded.com>

+ Vadim

On Fri, Oct 17, 2025 at 10:34:30PM +0200, Gerhard Engleder wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> I took over this patch from Vladimir Oltean. The only change from my
> side is the adaption of the commit message. I hope I mentioned his work
> correctly in the tags.
> 
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6.
> 
> It is time to convert the tsnep driver to the new API, so that
> timestamping configuration can be removed from the ndo_eth_ioctl()
> path completely.
> 
> The driver does not need the interface to be down in order for
> timestamping to be changed. Thus, the netif_running() restriction in
> tsnep_netdev_ioctl() is not migrated to the new API. There is no
> interaction with hardware registers for either operation, just a
> concurrency with the data path which is fine.
> 
> After removing the PHY timestamping logic from tsnep_netdev_ioctl(),
> the rest is almost equivalent to phy_do_ioctl_running(), except for the
> return code on the !netif_running() condition: -EINVAL vs -ENODEV.
> Let's make the conversion to phy_do_ioctl_running() anyway, on the
> premise that a return code standardized tree-wide is less complex.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> Tested-by: Gerhard Engleder <gerhard@engleder-embedded.com>

Hi Gerhard, Vladimir, Vadim, all,

Recently Vadim has been working on converting a number of drivers to
use ndo_hwtstamp_get() and ndo_hwtstamp_set(). And this includes a
patch, rather similar to this one, for the tsnep [1].

I think it would be good to agree on the way forward here.

[1] https://lore.kernel.org/all/20251016152515.3510991-7-vadim.fedorenko@linux.dev/

...

