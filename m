Return-Path: <netdev+bounces-128308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785B978F22
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 10:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC0E1C21EA2
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B1B13CFBD;
	Sat, 14 Sep 2024 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm2w91O1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9E79CC;
	Sat, 14 Sep 2024 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726303113; cv=none; b=n0/wglhw+mj8okixGeaAw/ehUloKVs204E8eFNrzc33r6QFbmIcJsd/8fHb6OiFevHnO0ILf322ibBE4HU0rBu5yJj47QinDmEvInP0iSV7lOihehcpJ94a/TL+zQibPHVYIuaXI7bDlo6jFao8N/kMLOU7jit6o/BBHcQSkK8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726303113; c=relaxed/simple;
	bh=PKtoMpXxtMNQgMD2WWGoiAlbw1hPMweydHUrcUGVJZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zlr0Vzheq6guMm4XHOxoh7e1UEBBCwAtka//wW2vXErq3IRuads4lrtwy9yC7dtGrHbJuDdnj7WSr8e9vJaLJ5mdtoUpoX06MoHUjo2wQS0mCmlEAz54teSjHJgajOMPNpeg2DuunumSY+T7PblANkfk+6jqdAIJbTpmvG1qIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pm2w91O1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72665C4CEC0;
	Sat, 14 Sep 2024 08:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726303113;
	bh=PKtoMpXxtMNQgMD2WWGoiAlbw1hPMweydHUrcUGVJZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pm2w91O18pRTdtAcxA5uCMQMvGqPsnuL+ALkfiPQuz8oE3qESOGi9ZD/V0hUapLnp
	 wSO4FFCylWMqc6gVtBIcz2zlBH2704dC1xZINogm8mLpt75+LwU/TYJ4rfIbnepC2T
	 o5Q8uFOUWLGcXmkOK0tYCVnXakHoi/DDsdN51G8dbHoJ9DWCthyv6tH6fu3IGVFJbJ
	 vUjLCxMGTBQvAkJi/vteaZwAMmdbQry0thmV3Nz19gNgNvEqoKWTuu/jZ5BLaVit47
	 5FTv4bbK4eAUhBQohtpd/YdZ3btToTXDfk+gYuC1CnrDJuzrAGv6GO1nKD1H8zAHGi
	 Vrkdgz/w8Jm4Q==
Date: Sat, 14 Sep 2024 09:38:28 +0100
From: Simon Horman <horms@kernel.org>
To: Aakash Menon <aakash.r.menon@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lars.povlsen@microchip.com,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com, aakash.menon@protempis.com,
	horatiu.vultur@microchip.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sparx5: Fix invalid timestamps
Message-ID: <20240914083828.GC8319@kernel.org>
References: <20240913193357.21899-1-aakash.menon@protempis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913193357.21899-1-aakash.menon@protempis.com>

On Fri, Sep 13, 2024 at 12:33:57PM -0700, Aakash Menon wrote:
> Bit 270-271 are occasionally unexpectedly set by the hardware.
> 
> This issue was observed with 10G SFPs causing huge time errors (> 30ms) in PTP.
> 
> Only 30 bits are needed for the nanosecond part of the timestamp, clear 2 most significant bits before extracting timestamp from the internal frame header.

Hi Aakash,

Thanks for your patch.

I'll leave the review of the code change itself to others,
but here is some feedback on process.

Please line-wrap patch descriptions at 75 columns wide.

Link: https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format

Assuming this is a bug fix, a Fixes tag should be present.
It should go just before the signed-off-by line (or other tags),
with no blank lines in between.

I'm wondering if this Fixes tag is appropriate:

Fixes: 70dfe25cd866 ("net: sparx5: Update extraction/injection for timestamping")
> Signed-off-by: Aakash Menon <aakash.menon@protempis.com>

Also, for reference, fixes for Networking should, in general,
be targeted at the net tree.

	Subject: [PATCH net] ...

And lastly, if you do post a new patch, be sure to wait 24h since
the original patch posting before doing so.

Link: https://docs.kernel.org/process/maintainer-netdev.html

...

