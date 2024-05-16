Return-Path: <netdev+bounces-96723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B82B8C7590
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 14:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA921C209B5
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 12:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCD2145FF5;
	Thu, 16 May 2024 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8JHdMeg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC0145A06;
	Thu, 16 May 2024 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861017; cv=none; b=faNLQeTtGSF2M2vvY9C2ovIkLbs4ohLFNnQOAv29Iy1CTST7eBOX3RTkAe48CBGt4g2F4D7vbpPQ+pNxjFXW8P+pf7kfax3ovpI96Nx+g+2QfDOFWgj03nK1JopK2chy//5DVaOHG1OCFmNLpw0Q3TlTQJCPHciBiyeCtxDTATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861017; c=relaxed/simple;
	bh=ao3vT+/wgbwOmNIGPIj0yiu9lABcaUGxyDAadsmJeK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHlkVQdBtCXEbtpkah+BMvXbJZ95p7jBCuQDc4bHktDhgjryqGgDJ2/dWe0HKhqipLC9jbPZftq2TlPM6nVqq9FYrkyGWbJ66WHs1OnOgn7YU7PvNEaEp4D4X4P1T4eVbeJ0JREYez7x+5M140Kb13ieqF+xfz80bp6DvIpWO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8JHdMeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47DBC113CC;
	Thu, 16 May 2024 12:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715861016;
	bh=ao3vT+/wgbwOmNIGPIj0yiu9lABcaUGxyDAadsmJeK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8JHdMegnhJJfdQwfbG/Po0osKXDtPq89J2E86h/wMBCidUzF6BQOxsmrHLHc1/zy
	 eSwX59oExTKxdILgy2f3icMFNHrBtS0+uH3QYYyqLUH3tdTn6ksBbs8KdOLCNF84zd
	 7mK9EYogE0k2pKc6YMajLgYfNcBgFBYk/6Ic498ttBbNE4bsa3YFSyDe3rvp8SLD6W
	 Ft0EZ9yD9mNwrOEuAKrnj9dsP0+TaghtkGZVCP5aT3HpqdezEwSKz5mD9II0m8+KnF
	 CqGijKUefTUEF1/XdhLAqp34mAdsYYrxrfmrhDWoLlJgP+SS3sBs8H6EwjW1O1h8C0
	 zGnvxeIOrr++w==
Date: Thu, 16 May 2024 13:03:32 +0100
From: Simon Horman <horms@kernel.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com
Subject: Re: [PATCH net] nfc: nci: Fix handling of zero-length payload
 packets in nci_rx_work()
Message-ID: <20240516120332.GB443134@kernel.org>
References: <20240515151757.457353-1-ryasuoka@redhat.com>
 <20240516084348.GF179178@kernel.org>
 <ZkXQ5h8fla1KhX6A@zeus>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkXQ5h8fla1KhX6A@zeus>

On Thu, May 16, 2024 at 06:24:54PM +0900, Ryosuke Yasuoka wrote:
> Thank you for your review and comment, Simon.
> 
> On Thu, May 16, 2024 at 09:43:48AM +0100, Simon Horman wrote:
> > Hi Yasuoka-san,
> > 
> > On Thu, May 16, 2024 at 12:17:07AM +0900, Ryosuke Yasuoka wrote:
> > > When nci_rx_work() receives a zero-length payload packet, it should
> > > discard the packet without exiting the loop. Instead, it should continue
> > > processing subsequent packets.
> > 
> > nit: I think it would be clearer to say:
> > 
> > ... it should not discard the packet and exit the loop. Instead, ...
> 
> Great. I'll update commit msg like this.
> 
> > > 
> > > Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> > > Closes: https://lore.kernel.org/lkml/20240428134525.GW516117@kernel.org/T/
> > 
> > nit: I'm not sure this Closes link is adding much,
> >      there are more changes coming, right?
> 
> No. I just wanna show the URL link as a reference where this bug is
> found. This URL discuss a little bit different topic as you know.
> 
> In the following discussion [1], Jakub pointed out that changing
> continue statement to break is not related to the patch "Fix
> uninit-value in nci_rw_work". So I posted this new small patch before
> posting v5 patch for "Fix: uninit-value in nci_rw_work".
> 
> If Closes tag is not appropriate, I can remove this in this v2 patch.
> What do you think?

Thanks, if it was me I would drop the Closes tag.

> [1] https://lore.kernel.org/all/20240510190613.72838bf0@kernel.org/

...

