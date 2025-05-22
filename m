Return-Path: <netdev+bounces-192641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AEDAC0A0C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BCB4A7A20
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90271286D53;
	Thu, 22 May 2025 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQLKd20Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE601F09B3;
	Thu, 22 May 2025 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747910758; cv=none; b=jUonOzbdm2Hx4ZOAzc15uTMorGZlocNDpbW1fDIvQPoCgEnnvyykxG3D3tehGPkt2v7mwxp1uURJYLMOBhlVJ96JWDsSGLzg4rmFj0NF7RjlHaoW38oXZm0LM+5t0Paghs4CPgGXdYmvtd0032Yi2OYcXqVR9NnS7GjFC1zinfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747910758; c=relaxed/simple;
	bh=nDcDTTGWl2yNVjSeuRh+ALACWWAJZtCLqBjSo46X0nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdPQfqsKj9KGW+3MNfkuY5o8dobbbsR1kKxkKk4aTEXQgeY2ikW+iPGle6mg52FTTB8LKEoR+IxTWjRUCdQk2C2CZmPfFVix/0yiJveOB0zb191ut3ZSkK42+B02T0EHI+93Rd35c/LYagU/vQ/2qLt4JzAbm0qke3r0GDA3GYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQLKd20Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076FCC4CEE4;
	Thu, 22 May 2025 10:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747910757;
	bh=nDcDTTGWl2yNVjSeuRh+ALACWWAJZtCLqBjSo46X0nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQLKd20YrDh9cKYVTE2CAwkfGzxze+YXO4wa8qmjDPQmdxJC64hmQB8mUj5vaJt5k
	 DFETI4Fy1JZRYDt/GXijPQeTVnQpNBccKokd6z8j+C/h4ZKITM/SDsN7HoCov0y35k
	 I2LsL/XSonjFI2DZ4EkSkODwTuI4MreNj1Pd0H65m+ZOxt6PexJj0M1CGJuzLJ1hfn
	 +2otw82IqooOsAUyTY5Iu+DTe/42rPczBzB91Ac1ruVfs0EJY+wWq+eqftHE0K09pD
	 1iIL/X3CAFRS50UMuiHObK6pj89PSaWUoxOQVXwTG/tfVZgMteRi2QEBHvTAA08TIU
	 C8EIrpHaiL90w==
Date: Thu, 22 May 2025 11:45:51 +0100
From: Lee Jones <lee@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v7 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
Message-ID: <20250522104551.GD1199143@google.com>
References: <20250507124358.48776-9-ivecera@redhat.com>
 <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
 <2e3eb9e3-151d-42ef-9043-998e762d3ba6@redhat.com>
 <aBt1N6TcSckYj23A@smile.fi.intel.com>
 <20250507152609.GK3865826@google.com>
 <b095ffb9-c274-4520-a45e-96861268500b@redhat.com>
 <20250513094126.GF2936510@google.com>
 <6f693bb5-da3c-4363-895f-58a267e52a18@redhat.com>
 <20250522073902.GC8794@google.com>
 <7421647b-ae85-4f34-843c-02f1fb21d7f3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7421647b-ae85-4f34-843c-02f1fb21d7f3@redhat.com>

On Thu, 22 May 2025, Ivan Vecera wrote:

> 
> 
> On 22. 05. 25 9:39 dop., Lee Jones wrote:
> > On Tue, 13 May 2025, Ivan Vecera wrote:
> > 
> > > On 13. 05. 25 11:41 dop., Lee Jones wrote:
> > > > On Mon, 12 May 2025, Ivan Vecera wrote:
> > > > 
> > > > > On 07. 05. 25 5:26 odp., Lee Jones wrote:
> > > > > > On Wed, 07 May 2025, Andy Shevchenko wrote:
> > > > > > 
> > > > > > > On Wed, May 07, 2025 at 03:56:37PM +0200, Ivan Vecera wrote:
> > > > > > > > On 07. 05. 25 3:41 odp., Andy Shevchenko wrote:
> > > > > > > > > On Wed, May 7, 2025 at 3:45 PM Ivan Vecera <ivecera@redhat.com> wrote:
> > > > > > > 
> > > > > > > ...
> > > > > > > 
> > > > > > > > > > +static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
> > > > > > > > > > +       { .channel = 0, },
> > > > > > > > > > +       { .channel = 1, },
> > > > > > > > > > +       { .channel = 2, },
> > > > > > > > > > +       { .channel = 3, },
> > > > > > > > > > +       { .channel = 4, },
> > > > > > > > > > +};
> > > > > > > > > 
> > > > > > > > > > +static const struct mfd_cell zl3073x_devs[] = {
> > > > > > > > > > +       ZL3073X_CELL("zl3073x-dpll", 0),
> > > > > > > > > > +       ZL3073X_CELL("zl3073x-dpll", 1),
> > > > > > > > > > +       ZL3073X_CELL("zl3073x-dpll", 2),
> > > > > > > > > > +       ZL3073X_CELL("zl3073x-dpll", 3),
> > > > > > > > > > +       ZL3073X_CELL("zl3073x-dpll", 4),
> > > > > > > > > > +};
> > > > > > > > > 
> > > > > > > > > > +#define ZL3073X_MAX_CHANNELS   5
> > > > > > > > > 
> > > > > > > > > Btw, wouldn't be better to keep the above lists synchronised like
> > > > > > > > > 
> > > > > > > > > 1. Make ZL3073X_CELL() to use indexed variant
> > > > > > > > > 
> > > > > > > > > [idx] = ...
> > > > > > > > > 
> > > > > > > > > 2. Define the channel numbers
> > > > > > > > > 
> > > > > > > > > and use them in both data structures.
> > > > > > > > > 
> > > > > > > > > ...
> > > > > > > > 
> > > > > > > > WDYM?
> > > > > > > > 
> > > > > > > > > OTOH, I'm not sure why we even need this. If this is going to be
> > > > > > > > > sequential, can't we make a core to decide which cell will be given
> > > > > > > > > which id?
> > > > > > > > 
> > > > > > > > Just a note that after introduction of PHC sub-driver the array will look
> > > > > > > > like:
> > > > > > > > static const struct mfd_cell zl3073x_devs[] = {
> > > > > > > >           ZL3073X_CELL("zl3073x-dpll", 0),  // DPLL sub-dev for chan 0
> > > > > > > >           ZL3073X_CELL("zl3073x-phc", 0),   // PHC sub-dev for chan 0
> > > > > > > >           ZL3073X_CELL("zl3073x-dpll", 1),  // ...
> > > > > > > >           ZL3073X_CELL("zl3073x-phc", 1),
> > > > > > > >           ZL3073X_CELL("zl3073x-dpll", 2),
> > > > > > > >           ZL3073X_CELL("zl3073x-phc", 2),
> > > > > > > >           ZL3073X_CELL("zl3073x-dpll", 3),
> > > > > > > >           ZL3073X_CELL("zl3073x-phc", 3),
> > > > > > > >           ZL3073X_CELL("zl3073x-dpll", 4),
> > > > > > > >           ZL3073X_CELL("zl3073x-phc", 4),   // PHC sub-dev for chan 4
> > > > > > > > };
> > > > > > > 
> > > > > > > Ah, this is very important piece. Then I mean only this kind of change
> > > > > > > 
> > > > > > > enum {
> > > > > > > 	// this or whatever meaningful names
> > > > > > > 	..._CH_0	0
> > > > > > > 	..._CH_1	1
> > > > > > > 	...
> > > > > > > };
> > > > > > > 
> > > > > > > static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
> > > > > > >           { .channel = ..._CH_0, },
> > > > > > >           ...
> > > > > > > };
> > > > > > > 
> > > > > > > static const struct mfd_cell zl3073x_devs[] = {
> > > > > > >           ZL3073X_CELL("zl3073x-dpll", ..._CH_0),
> > > > > > >           ZL3073X_CELL("zl3073x-phc", ..._CH_0),
> > > > > > >           ...
> > > > > > > };
> > > > > > 
> > > > > > This is getting hectic.  All for a sequential enumeration.  Seeing as
> > > > > > there are no other differentiations, why not use IDA in the child
> > > > > > instead?
> > > > > 
> > > > > For that, there have to be two IDAs, one for DPLLs and one for PHCs...
> > > > 
> > > > Sorry, can you explain a bit more.  Why is this a problem?
> > > > 
> > > > The IDA API is very simple.
> > > > 
> > > > Much better than building your own bespoke MACROs.
> > > 
> > > I will try to explain this in more detail... This MFD driver handles
> > > chip family ZL3073x where the x == number of DPLL channels and can
> > > be from <1, 5>.
> > > 
> > > The driver creates 'x' DPLL sub-devices during probe and has to pass
> > > channel number that should this sub-device use. Here can be used IDA
> > > in DPLL sub-driver:
> > > e.g. ida_alloc_max(zldev->channels, zldev->max_channels, GFP_KERNEL);
> > > 
> > > This way the DPLL sub-device get its own unique channel ID to use.
> > > 
> > > The situation is getting more complicated with PHC sub-devices because
> > > the chip can provide UP TO 'x' PHC sub-devices depending on HW
> > > configuration. To handle this the MFD driver has to check this HW config
> > > for particular channel if it is capable to provide PHC functionality.
> > > 
> > > E.g. ZL30735 chip has 5 channels, in this case the MFD driver should
> > > create 5 DPLL sub-devices. And then lets say channel 0, 2 and 4 are
> > > PHC capable. Then the MFD driver should create 3 PHC sub-devices and
> > > pass 0, 2 resp. 4 for them.
> > 
> > Where is the code that determines which channels are PHC capable?
> 
> It is not included in this series and will be added once the PTP driver
> will be added. But the code looks like:
> 
> for (i = 0; i < ZL3073X_MAX_CHANNELS; i++) {
> 	if (channel_is_in_nco_mode(..., i)) {
> 		struct mfd_cell phc_dev = ZL3073X_CELL("zl3073x-phc", i);
> 		rc = devm_mfd_add_devices(zldev->dev,
> 					  PLATFORM_DEVID_AUTO, &phc_dev,
> 					  1, NULL, 0, NULL);
> 		...
> 	}
> }

It's the channel_is_in_nco_mode() code I wanted to see.

What if you register all PHC devices, then bomb out if
!channel_is_in_nco_mode()?  Presumably this can / should also live in
the PHC driver as well?

-- 
Lee Jones [李琼斯]

