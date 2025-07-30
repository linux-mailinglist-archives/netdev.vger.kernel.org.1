Return-Path: <netdev+bounces-211024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4625AB163B8
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 17:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D52E17988F
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 15:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3D2DCBF1;
	Wed, 30 Jul 2025 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlV/QTYv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A252DBF78
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753889333; cv=none; b=Oq6abSdU/uzHqK4pNhpy7Oh0SF2Or3DS5P9cBPUv9y6OuVICd1rZnOszjOm0trGyKkHlbx3U0aD4JJNvEbZvf530ug0YmIzv2d3rt2povSH2YvBq8s1d/oqICmcoJYL+Vuv8+NrdzGRLGF1JviFFrMsSAxKXCSU7YVby8fifdrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753889333; c=relaxed/simple;
	bh=Ue+ccx0ZDote0/1x1M5PeVoJWdh1k9mxATHVs7yIKFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkpCBiojitvBJTJNINQXx/UVbaONZiSuDjjj+ef7yWSAWJMGnTmJa5oqSV9TbbAHvqMe301YP64jHWHKmLHKuP2pRjznCADrK3U+hHvcEV35r1CiW59sI1COWqS6HHi5Aha47ooL1xhajnaf4AefCpqlckxOUBBxZSSgoi9ezXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlV/QTYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03115C4CEF6;
	Wed, 30 Jul 2025 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753889332;
	bh=Ue+ccx0ZDote0/1x1M5PeVoJWdh1k9mxATHVs7yIKFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlV/QTYv5iOATY/iv07a54FTPF9zsj9Y11mBVoWBNGAVYJfWNVBBTLK6Cy4JJzZ8R
	 LrHWic4y2GLCaiPOWbrO48UlpLUVNDhnf/AVXkJtgCjPv9Q4/6LrN8Wj3cDzb5Yjp5
	 h5B9k7Q3Ly2m+JUyt6uSdTvsckMi9VHNI2KYa5rdA8jh/roCONV4kXHDazAyrXoA66
	 xbvMr1QIBrPWE8J2ze6WJsJypnlv9IrfkD2qHBW7ZXKW2dUkFqnvHmV89r4NBzQLN/
	 WLdaGdzDCVvqnb9JfHU+ysQWv+5BBQqhmrun/XNkgZcYBZFgwZi4LCZEAnOwkNgEBi
	 5UUrbCv2KmQfA==
Date: Wed, 30 Jul 2025 16:28:48 +0100
From: Simon Horman <horms@kernel.org>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
Message-ID: <20250730152848.GJ1877762@horms.kernel.org>
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
 <20250714165505.GR721198@horms.kernel.org>
 <CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
 <b7265975-d28c-4081-811c-bf7316954192@intel.com>
 <f44bfb41-d3bd-471c-916e-53fd66b04f27@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f44bfb41-d3bd-471c-916e-53fd66b04f27@intel.com>

On Wed, Jul 30, 2025 at 05:11:20PM +0300, Lifshits, Vitaly wrote:
> 
> 
> On 7/16/2025 1:25 PM, Ruinskiy, Dima wrote:
> > On 15/07/2025 0:30, Keller, Jacob E wrote:
> > > 
> > > 
> > > > -----Original Message-----
> > > > From: Simon Horman <horms@kernel.org>
> > > > Sent: Monday, July 14, 2025 9:55 AM
> > > > To: Lifshits, Vitaly <vitaly.lifshits@intel.com>
> > > > Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > > > kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org;
> > > > Ruinskiy, Dima
> > > > <dima.ruinskiy@intel.com>; Nguyen, Anthony L
> > > > <anthony.l.nguyen@intel.com>;
> > > > Keller, Jacob E <jacob.e.keller@intel.com>
> > > > Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private
> > > > flag and module
> > > > param to disable K1
> > > > 
> > > > On Thu, Jul 10, 2025 at 12:24:55PM +0300, Vitaly Lifshits wrote:
> > > > > The K1 state reduces power consumption on ICH family network
> > > > > controllers
> > > > > during idle periods, similarly to L1 state on PCI Express
> > > > > NICs. Therefore,
> > > > > it is recommended and enabled by default.
> > > > > However, on some systems it has been observed to have adverse side
> > > > > effects, such as packet loss. It has been established
> > > > > through debug that
> > > > > the problem may be due to firmware misconfiguration of
> > > > > specific systems,
> > > > > interoperability with certain link partners, or marginal electrical
> > > > > conditions of specific units.
> > > > > 
> > > > > These problems typically cannot be fixed in the field, and generic
> > > > > workarounds to resolve the side effects on all systems,
> > > > > while keeping K1
> > > > > enabled, were found infeasible.
> > > > > Therefore, add the option for system administrators to globally disable
> > > > > K1 idle state on the adapter.
> > > > > 
> > > > > Link: https://lore.kernel.org/intel-wired-
> > > > lan/CAMqyJG3LVqfgqMcTxeaPur_Jq0oQH7GgdxRuVtRX_6TTH2mX5Q@mail.gmail.
> > > > com/
> > > > > Link: https://lore.kernel.org/intel-wired-
> > > > lan/20250626153544.1853d106@onyx.my.domain/
> > > > > Link:
> > > > > https://lore.kernel.org/intel-wired-lan/Z_z9EjcKtwHCQcZR@mail-
> > > > > itl/
> > > > > 
> > > > > Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> > > > 
> > > > Hi Vitaly,
> > > > 
> > > > If I understand things correctly, this patch adds a new module parameter
> > > > to the e1000 driver. As adding new module parameters to
> > > > networking driver
> > > > is discouraged I'd like to ask if another mechanism can be found.
> > > > E.g. devlink.
> > > 
> > > One motivation for the module parameter is that it is simple to set
> > > it "permanently" by setting the module parameter to be loaded by
> > > default. I don't think any distro has something equivalent for
> > > devlink or ethtool flags. Of course that’s not really the kernel's
> > > fault.
> > > 
> > > I agree that new module parameters are generally discouraged from
> > > being added. A devlink parameter could work, but it does require
> > > administrator to script setting the parameter at boot on affected
> > > systems. This also will require a bit more work to implement because
> > > the e1000e driver does not expose devlink.
> > > 
> > > Would an ethtool private flag on its own be sufficient/accepted..? I
> > > know those are also generally discouraged because of past attempts
> > > to avoid implementing generic interfaces.. However I don't think
> > > there is a "generic" interface for this, at least based on my
> > > understanding. It appears to be a low power state for the embedded
> > > device on a platform, which is quite specific to this device and
> > > hardware design ☹
> > 
> > Basically what we are looking for here is, as Jake mentioned, a way for
> > a system administrator / "power-user" to "permanently" set the driver
> > option in order to mask the issue on specific systems suffering from it.
> > 
> > As it can sometimes manifest during early hardware initialization
> > stages, I'm concerned that just an ethtool private flag is insufficient,
> > as it may be 'too late' to set it after 'probe'.
> > 
> > Not being familiar enough with devlink, I do not understand if it can be
> > active already as early as 'probe', but given the fact that e1000e
> > currently does not implement any devlink stuff, this would require a
> > bigger (and riskier?) change to the code. The module parameter is fairly
> > trivial, since e1000e already supports a number of these.
> > 
> > I do not know the history and why module parameters are discouraged, but
> > it seems that there has to be some standardized way to pass user
> > configuration to kernel modules, which takes effect as soon as the
> > module is loaded. I always thought module parameters were that
> > interface; if things have evolved, I would be happy to learn. :)
> > 
> > --Dima
> 
> While I understand that module params are generally discouraged—as
> Jacob Keller pointed out—implementing the same functionality via devlink
> presents some challenges. Although it may be technically feasible, it
> would likely complicate configuration for sysadmins who need to disable
> K1 on affected systems.
> 
> In my view, extending an existing interface in an older driver is a safer
> and more pragmatic approach than introducing a new one, especially given the
> legacy nature of the devices involved. These systems are often beyond the
> scope of our current test coverage, and minimizing the risk of regressions
> is critical.
> 
> Regarding the ethtool private flag: while it may not address all potential
> link issues, it does help mitigate certain packet loss scenarios. My
> motivation for proposing it was to offer end-users a straightforward
> workaround—by setting the flag and retriggering auto-negotiation, they may
> resolve issues without needing to unload and reload the e1000e module.

Thanks Vitaly,

My opinion is that devlink is the correct way to solve this problem.
However, I do understand from the responses above (3) that this is somewhat
non-trivial to implement and thus comes with some risks. And I do accept
your argument that for old drivers, which already use module parameters,
some pragmatism seems appropriate.

IOW, I drop my objection to using a module parameter in this case.

What I would suggest is that some consideration is given to adding devlink
support to this driver. And thus modernising it in that respect. Doing so
may provide better options for users in future.

Thanks!

