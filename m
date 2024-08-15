Return-Path: <netdev+bounces-118890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6979536E1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05BD1C2110A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F52B1A7076;
	Thu, 15 Aug 2024 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkMkBcgB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710519F49B;
	Thu, 15 Aug 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735070; cv=none; b=XzhLuGEb9iAiB2kDzYdDJ4GO5hCGZRHaOUyVRFX91bSQXH5ndNfMjckjapAurPmNHPASVeQuWnLetpqyy3QNjODJ3vERP3FmJ2qbstTTQJsGtkhU3GMFr6mgw2EZFjNooGt346Cmx/6CRSsiABTQXE4tWFG+6pds1SYNf9YB2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735070; c=relaxed/simple;
	bh=Eh+3dI9QYcV4aXS/Haj8Qthw9TJbckiHfHF7kk6QLlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rI/SO0iqLRuWNgYdaUzyXKIRL95LTKtA2ag88YllJetOLtbIcigomhVbdubm7vYcdwE2fFohrBZWrMCUqtvHxAu686zOycT0H7Q9m4g0iV6n+DOWvXqlu+9q5i7eNwzBgQQjcYiy7500ZzFLKwYoH1BI3sJGhsAG04Ctn23UWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkMkBcgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC2AC32786;
	Thu, 15 Aug 2024 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735069;
	bh=Eh+3dI9QYcV4aXS/Haj8Qthw9TJbckiHfHF7kk6QLlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkMkBcgBHp5hFSpGS1WLK3TjCWQMtDw9ZwumXUf5IxiL6NUxRvJ/EvUqAqYC0Sr7X
	 OkoBRkXW5FBpVDkMhMgZO+t76ZW1QItnebpdp4r3yVElbG3tUj+UYycWGYsw8j89Me
	 N8H0QSoSKsjdROgz/gNCm3cX776x9U5fzFqwbwyGMdj9e3w2rwLOEYEetWZiLkkFSv
	 ZfNVG8WpKQ0dN43FBMkpZolYi30cxSz28KZB2hzl4wNmFJ29G49QMKo4kdp4crCZNC
	 edoneoUT3EdCIYpw4gkbbuzAkfVqpHIyWzxoeoovTt1sp3f8WbYNMfzEFDdukAYvm5
	 JjXfUyzk44Q/A==
Date: Thu, 15 Aug 2024 16:17:44 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>
Subject: Re: [PATCH net-next 1/4] net: xilinx: axienet: Always disable
 promiscuous mode
Message-ID: <20240815151744.GL632411@kernel.org>
References: <20240812200437.3581990-1-sean.anderson@linux.dev>
 <20240812200437.3581990-2-sean.anderson@linux.dev>
 <20240815145832.GG632411@kernel.org>
 <9d67d2b0-e4bd-466a-ad60-e40d4b1fc4e7@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d67d2b0-e4bd-466a-ad60-e40d4b1fc4e7@linux.dev>

On Thu, Aug 15, 2024 at 11:14:41AM -0400, Sean Anderson wrote:
> On 8/15/24 10:58, Simon Horman wrote:
> > On Mon, Aug 12, 2024 at 04:04:34PM -0400, Sean Anderson wrote:
> >> If prmiscuous mode is disabled when there are fewer than four multicast
> >> addresses, then it will to be reflected in the hardware. Fix this by
> >> always clearing the promiscuous mode flag even when we program multicast
> >> addresses.
> >> 
> >> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> ---
> >> 
> >>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >> 
> >> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> >> index ca04c298daa2..e664611c29cf 100644
> >> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> >> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> >> @@ -451,6 +451,10 @@ static void axienet_set_multicast_list(struct net_device *ndev)
> >>  	} else if (!netdev_mc_empty(ndev)) {
> >>  		struct netdev_hw_addr *ha;
> >>  
> >> +		reg = axienet_ior(lp, XAE_FMI_OFFSET);
> >> +		reg &= ~XAE_FMI_PM_MASK;
> >> +		axienet_iow(lp, XAE_FMI_OFFSET, reg);
> >> +
> > 
> > Hi Sean,
> > 
> > I notice that this replicates code in another part of this function.
> > And that is then factored out into common code as part of the last
> > patch of this series.
> > 
> > I guess that it is in the wash, but perhaps it would
> > be nicer to factor out the common promisc mode setting code
> > as part of this patch.
> > 
> > Otherwise, this LGTM.
> 
> I thought about doing that, but it would have required changing the
> indentation of ~10 lines and I thought it would be easier to review
> the patch without that noise.

Sure, I was also wrestling with that in my mind.
I think we can stick with what you have :)

Reviewed-by: Simon Horman <horms@kernel.org>


