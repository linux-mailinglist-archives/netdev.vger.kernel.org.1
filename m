Return-Path: <netdev+bounces-47930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEB47EBFA1
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E71B20B05
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B7E8F4F;
	Wed, 15 Nov 2023 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saLsWmP8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88337E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3A4C433C8;
	Wed, 15 Nov 2023 09:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700041286;
	bh=OAzWPsYo5D8WnJx6au21vBR29LjQjry6cVcjju6Rt80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saLsWmP8+gKE35hVSYjF8yDyGVuN8fH3oOl4tSkTCqk9kf3WNKEGUzKZjbo4DIPb8
	 aYM5knXBon4iLCwTu+jrcmuTylA52apRIpAPkUHWuz0R6KXuRaW8Xr/io96puieptn
	 Zt/jXwOFwaRQvT8sHTPgt052gXY6zGe9HTgktxDN4CoTLffeu31RSKh4wEH+MYs70x
	 Pa06evWSURkjLsmDmzTzH81nNch4kmDsuFTGbFHTXoZjsJRMgkKyL609KVR94X/Fsw
	 4ihczZPTM+IlUXLQb2C/f4xZcdg5EGVesmPaioyA91VHeu8Ul/OHvvzD88TVGz9oTf
	 6oqFtPbN54Fyw==
Date: Wed, 15 Nov 2023 09:41:22 +0000
From: Simon Horman <horms@kernel.org>
To: Johnathan Mantey <johnathanx.mantey@intel.com>
Cc: netdev@vger.kernel.org, sam@mendozajonas.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] Revert ncsi: Propagate carrier gain/loss events
 to the NCSI controller
Message-ID: <20231115094122.GL74656@kernel.org>
References: <20231113163029.106912-1-johnathanx.mantey@intel.com>
 <20231114194616.GG74656@kernel.org>
 <87bkbwvzwn.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkbwvzwn.fsf@intel.com>

On Tue, Nov 14, 2023 at 12:20:52PM -0800, Johnathan Mantey wrote:
> 
> Simon Horman <horms@kernel.org> writes:
> 
> > On Mon, Nov 13, 2023 at 08:30:29AM -0800, Johnathan Mantey wrote:
> > > This reverts commit 3780bb29311eccb7a1c9641032a112eed237f7e3.
> > > 
> > > The cited commit introduced unwanted behavior.
> > > 
> > > The intent for the commit was to be able to detect carrier loss/gain
> > > for just the NIC connected to the BMC. The unwanted effect is a
> > > carrier loss for auxiliary paths also causes the BMC to lose
> > > carrier. The BMC never regains carrier despite the secondary NIC
> > > regaining a link.
> > > 
> > > This change, when merged, needs to be backported to stable kernels.
> > > 5.4-stable, 5.10-stable, 5.15-stable, 6.1-stable, 6.5-stable
> > > 
> > > Fixes: 3780bb29311e ("ncsi: Propagate carrier gain/loss events to
> > > the NCSI controller")
> > > CC: stable@vger.kernel.org
> > > Signed-off-by: Johnathan Mantey <johnathanx.mantey@intel.com>
> > 
> > Hi Jonathan,
> > 
> > thanks for addressing my feedback on v2.
> > 
> > So far as addressing a regression goes, this looks good to me.
> > But I do wonder what can be done about the issue that
> > the cited commit was intended to address: will this patch regress things
> > on that front?
> 
> Unfortunately the original issue will reoccur. I'm not sure which behavior
> is worse. What's been present for the lifespan of the ncsi driver, or this
> new issue I've introduced. In both instances a cable unplug causes
> undesirable behavior. I'm going to investigate solving this for Intel's
> specific use case ATM. NCSI has numerous modes in which it can be
> configured. I don't have a good feel for how to generalize the code given
> the side effect introduced by my change.

Thanks Jonathan,

I agree that is a bit of a conundrum without a working fix available.
I would lean towards the old bug being somehow better than the new one -
better the devil you know than the one you don't.

So, FWIIW, from a pragmatic pov I'm happy with this patch.

Reviewed-by: Simon Horman <horms@kernel.org>


