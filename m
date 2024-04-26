Return-Path: <netdev+bounces-91716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A368B38C0
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC10284B3C
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC11C147C6C;
	Fri, 26 Apr 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="U45GH/3i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B521F956
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139029; cv=none; b=gx7zZq/i+ill7iGu4dpaUzP/t3WVIBvP2UUstW+J8mvFchS69SdZjWVIeyPNJ2GQOKzEKAmLLezBGPtdcuIO7Od5aVGly2LWDB3pqpt7XkkazRenNBRAAPjCnmoRhU+JFhUMMvYKVsa/an2Rl3ZYYp5v7KJMZYYy3QD4jeLcvQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139029; c=relaxed/simple;
	bh=a+FhSu2HYxTSpMdXpqJUagO+fDitZfC5iUHXC88BMUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qp0X+8pIE1hv81T+L3723Oi0yAodrpw80HFO7lSvieNdL0ailAkb/UWYLoLnzvmvTB0uRUyQ+6OqmOc9E07scgzUP6s0nkhwegLtnt+v6tLQcvhTA6/MeFu0my67d471mkIX9M6wnwBOiiaDCq1ivCJfv8KWI1X8ufVbwO+XSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=U45GH/3i; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2dd19c29c41so25389781fa.3
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714139025; x=1714743825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RCEU03ytUnyS/k9uk8i6ewH6Jfz6JZcqkxF2lHuJUw=;
        b=U45GH/3i3Jn8nwULxX6F9JK/gTLbQcYKBS7CSrrDXEE4ar8NNpCaMW0fyBXB4HvGX2
         lMFDgLWgCDgIBAwkSsoItpor0svOYLYI0EQHgrgftnK4jgewYcguvxkSZW81Fiqr0zMC
         Iadel/U/J33SqFX56BCicVdFlPZRtibKdVD8fmbLiaWh4PwLqD0m9l9rjRRtFUnw77SL
         Wt3DjV9VI+D7q1u926lXE2NhT0WfKhOlDtmig/w2QLvp4bI4lbW2Rl3DVJASQnpQrh8o
         ZC/CxRGX8cDVs9aTGqGotlz4bnaB2PgmZaZ/aVxInyL7tYd4NO6kornza+xtYogEWhNu
         EYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139025; x=1714743825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RCEU03ytUnyS/k9uk8i6ewH6Jfz6JZcqkxF2lHuJUw=;
        b=QAERUbkBPBmoPhNHebOFwz0nAEOUIvTb5NYGKdpednHpy8hoEJwdp6lzjmlJiQDFv6
         japRkq4FI/Hp+eBagXHRMIccl9zjDaSQBehf/YgylJxGD61lTzbfGM2gdUPVksf7wC5c
         QLzsJTMVfgtFIzNG4pYvLFap9vhJIszDFFE6V9zoouJ6vOx/3Y7JlUZw8KvtEFyntvP6
         Dm5B1o+GAQmodtIuYOSwSL6t5mF35iK3jR4H3RHmeVg6g/dz3DgDP42LfNDEVQ7yxlDf
         +1PXuKRasuEIE1T7ACpxHHq9TEs2rAWJmETe5V+MQX4KCPlL63XLbY+deOMXr92DkEdb
         U/xg==
X-Forwarded-Encrypted: i=1; AJvYcCVt4Xg0Jq2e7zyMDhuU2NFh+yGKxKkbRr2d35QlSH7q4Xcg/7LXg1usEZXJmusEXBCNryRSBs2xpcxvfNy2/2b1KsoNB8yU
X-Gm-Message-State: AOJu0Ywms2v+nItoCCZvLu//jCK8Mj68ZBfdm0eTM3agE+1DD6b0vV0z
	lTcZe/KwISO1pBU6iiIwlonW0fA/cDFUHtfQdx/dx9JKngCFcn7rdzHRyw+9ff8mZy1bdVO5gAT
	P
X-Google-Smtp-Source: AGHT+IGpPk1uDerXKMZKaO4BE8uYo0Visize6y5ZopF8rSBYuG1R3x/w67Mti7+Q0/j6YL51SLz39g==
X-Received: by 2002:a2e:94c3:0:b0:2da:e7f7:7315 with SMTP id r3-20020a2e94c3000000b002dae7f77315mr1617260ljh.45.1714139024589;
        Fri, 26 Apr 2024 06:43:44 -0700 (PDT)
Received: from localhost (89-24-35-126.nat.epc.tmcz.cz. [89.24.35.126])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c358900b00419f7b73c55sm22741338wmq.0.2024.04.26.06.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:43:43 -0700 (PDT)
Date: Fri, 26 Apr 2024 15:43:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Knitter, Konrad" <konrad.knitter@intel.com>, kuba@kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: Extend auxbus device
 naming
Message-ID: <Ziuvjj8h7GzsL9RF@nanopsycho>
References: <20240423091459.72216-1-sergey.temerkhanov@intel.com>
 <ZiedKc5wE2-3LlaM@nanopsycho>
 <MW3PR11MB468117FD76AC6D15970A6E1080112@MW3PR11MB4681.namprd11.prod.outlook.com>
 <Zie0NIztebf5Qq1J@nanopsycho>
 <3a634778-9b72-4663-b305-3be18bd8f618@intel.com>
 <ZikgQhVpphnaAOpG@nanopsycho>
 <3877b086-142d-4897-866e-e667ca7091d7@intel.com>
 <ZiuNxivU-haEQ5fC@nanopsycho>
 <39daba1e-5fbe-495e-8398-200434f89230@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39daba1e-5fbe-495e-8398-200434f89230@intel.com>

Fri, Apr 26, 2024 at 02:49:40PM CEST, przemyslaw.kitszel@intel.com wrote:
>On 4/26/24 13:19, Jiri Pirko wrote:
>> Wed, Apr 24, 2024 at 06:56:37PM CEST, jacob.e.keller@intel.com wrote:
>> > 
>> > 
>> > On 4/24/2024 8:07 AM, Jiri Pirko wrote:
>> > > Wed, Apr 24, 2024 at 12:03:25AM CEST, jacob.e.keller@intel.com wrote:
>> > > > 
>> > > > 
>> > > > On 4/23/2024 6:14 AM, Jiri Pirko wrote:
>> > > > > Tue, Apr 23, 2024 at 01:56:55PM CEST, sergey.temerkhanov@intel.com wrote:
>> > > > > > 
>> > > > > > 
>> > > > > > > -----Original Message-----
>> > > > > > > From: Jiri Pirko <jiri@resnulli.us>
>> > > > > > > Sent: Tuesday, April 23, 2024 1:36 PM
>> > > > > > > To: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>
>> > > > > > > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Kitszel,
>> > > > > > > Przemyslaw <przemyslaw.kitszel@intel.com>
>> > > > > > > Subject: Re: [PATCH iwl-next v2] ice: Extend auxbus device naming
>> > > > > > > 
>> > > > > > > Tue, Apr 23, 2024 at 11:14:59AM CEST, sergey.temerkhanov@intel.com
>> > > > > > > wrote:
>> > > > > > > > Include segment/domain number in the device name to distinguish
>> > > > > > > between
>> > > > > > > > PCI devices located on different root complexes in multi-segment
>> > > > > > > > configurations. Naming is changed from ptp_<bus>_<slot>_clk<clock>  to
>> > > > > > > > ptp_<domain>_<bus>_<slot>_clk<clock>
>> > > > > > > 
>> > > > > > > I don't understand why you need to encode pci properties of a parent device
>> > > > > > > into the auxiliary bus name. Could you please explain the motivation? Why
>> > > > > > > you need a bus instance per PF?
>> > > > > > > 
>> > > > > > > The rest of the auxbus registrators don't do this. Could you please align? Just
>> > > > > > > have one bus for ice driver and that's it.
>> > > > > > 
>> > > > > > This patch adds support for multi-segment PCIe configurations.
>> > > > > > An auxdev is created for each adapter, which has a clock, in the system. There can be
>> > > > > 
>> > > > > You are trying to change auxiliary bus name.
>> > > > > 
>> > > > > 
>> > > > > > more than one adapter present, so there exists a possibility of device naming conflict.
>> > > > > > To avoid it, auxdevs are named according to the PCI geographical addresses of the adapters.
>> > > > > 
>> > > > > Why? It's the auxdev, the name should not contain anything related to
>> > > > > PCI, no reason for it. I asked for motivation, you didn't provide any.
>> > > > > 
>> > > > 
>> > > > We aren't creating one auxbus per PF. We're creating one auxbus per
>> > > > *clock*. The device has multiple clocks in some configurations.
>> > > 
>> > > Does not matter. Why you need separate bus for whatever-instance? Why
>> > > can't you just have one ice-ptp bus and put devices on it?
>> > > 
>> > > 
>> > 
>> > Because we only want ports on card A to be connected to the card owner
>> > on card A. We were using auxiliary bus to manage this. If we use a
>> 
>> You do that by naming auxiliary bus according to the PCI device
>> created it, which feels obviously wrong.
>> 
>> 
>> > single bus for ice-ptp, then we still have to implement separation
>> > between each set of devices on a single card, which doesn't solve the
>> > problems we had, and at least with the current code using auxiliary bus
>> > doesn't buy us much if it doesn't solve that problem.
>> 
>> I don't think that auxiliary bus is the answer for your problem. Please
>> don't abuse it.
>> 
>> > 
>> > > > 
>> > > > We need to connect each PF to the same clock controller, because there
>> > > > is only one clock owner for the device in a multi-port card.
>> > > 
>> > > Connect how? But putting a PF-device on a per-clock bus? That sounds
>> > > quite odd. How did you figure out this usage of auxiliary bus?
>> > > 
>> > > 
>> > 
>> > Yea, its a multi-function board but the functions aren't fully
>> > independent. Each port has its own PF, but multiple ports can be tied to
>> > the same clock. We have similar problems with a variety of HW aspects.
>> > I've been told that the design is simpler for other operating systems,
>> > (something about the way the subsystems work so that they expect ports
>> > to be tied to functions). But its definitely frustrating from Linux
>> > perspective where a single driver instance for the device would be a lot
>> > easier to manage.
>> 
>> You can always do it by internal accounting in ice, merge multiple PF
>> pci devices into one internal instance. Or checkout
>> drivers/base/component.c, perhaps it could be extended for your usecase.
>> 
>> 
>> > 
>> > > > 
>> > > > > Again, could you please avoid creating auxiliary bus per-PF and just
>> > > > > have one auxiliary but per-ice-driver?
>> > > > > 
>> > > > 
>> > > > We can't have one per-ice driver, because we don't want to connect ports
>> > > >from a different device to the same clock. If you have two ice devices
>> > > > plugged in, the ports on each device are separate from each other.
>> > > > 
>> > > > The goal here is to connect the clock ports to the clock owner.
>> > > > 
>> > > > Worse, as described here, we do have some devices which combine multiple
>> > > > adapters together and tie their clocks together via HW signaling. In
>> > > > those cases the clocks *do* need to communicate across the device, but
>> > > > only to other ports on the same physical device, not to ports on a
>> > > > different device.
>> > > > 
>> > > > Perhaps auxbus is the wrong approach here? but how else can we connect
>> > > 
>> > > Yeah, feels quite wrong.
>> > > 
>> > > 
>> > > > these ports without over-connecting to other ports? We could write
>> > > > bespoke code which finds these devices, but that felt like it was risky
>> > > > and convoluted.
>> > > 
>> > > Sounds you need something you have for DPLL subsystem. Feels to me that
>> > > your hw design is quite disconnected from the Linux device model :/
>> > > 
>> > 
>> > I'm not 100% sure how DPLL handles this. I'll have to investigate.
>> 
>> DPLL leaves the merging on DPLL level. The ice driver just register
>> entities multiple times. It is specifically designed to fit ice needs.
>> 
>> 
>> > 
>> > One thing I've considered a lot in the past (such as back when I was
>> > working on devlink flash update) was to somehow have a sort of extra
>> > layer where we could register with PCI subsystem some sort of "whole
>> > device" driver, that would get registered first and could connect to the
>> > rest of the function driver instances as they load. But this seems like
>> > it would need a lot of work in the PCI layer, and apparently hasn't been
>> > an issue for other devices? though ice is far from unique at least for
>> > Intel NICs. Its just that the devices got significantly more complex and
>> > functions more interdependent with this generation, and the issues with
>> > global bits were solved in other ways: often via hiding them with
>> > firmware >:(
>> 
>> I think that others could benefit from such "merged device" as well. I
>> think it is about the time to introduce it.
>
>so far I see that we want to merge based on different bits, but let's
>see what will come from exploratory work that Sergey is doing right now.
>
>and anything that is not a device/driver feels much more lightweight to
>operate with (think &ice_adapter, but extended with more fields).
>Could you elaborate more on what you have in mind? (Or what you could
>imagine reusing).

Nothing concrete really. See below.

>
>offtop:
>It will be a good hook to put resources that are shared across ports
>under it in devlink resources, so making this "merged device" an entity
>would enable higher layer over what we have with devlink xxx $pf.

Yes. That would be great. I think we need a "device" in a sense of
struct device instance. Then you can properly model the relationships in
sysfs, you can have devlink for that, etc.

drivers/base/component.c does merging of multiple devices, but it does
not create a "merged device", this is missing there. So we have 2
options:

1) extend drivers/base/component.c to allow to create a merged device
   entity
2) implement merged device infrastructure separatelly.

IDK. I believe we need to rope more people in.


>
>> 
>> 
>> > 
>> > 
>> > I've tried explaining the issues with this to HW designers here, but so
>> > far haven't gotten a lot of traction.
>> > 
>> > > > We could make use of ice_adapter, though we'd need some logic to manage
>> > > > devices which have multiple clocks, as well as devices like the one
>> > > > Sergey is working on which tie multiple adapters together.
>> > > 
>> > > Perhaps that is an answer. Maybe we can make DPLL much more simple after
>> > > that :)
>> > 
>> > The only major issue with ice_adapter is the case where we have one
>> > clock connected to multiple adapters, but hopefully Sergey has some
>> > ideas for how to solve that.
>> > 
>> > I think we can mostly make the rest of the logic for the usual case work
>> > via ice_adapter:
>> > 
>> > 1) we already get an ice_adapter reference during early probe
>> > 2) each PF knows whether its an owner or not from the NVM/firmware interface
>> > 3) we can move the list of ports from the auxbus thing into ice_adapter,
>> > possibly keeping one list per clock number, so that NVMs with multiple
>> > clocks enabled don't have conflicts or put all ports onto the same clock.
>> > 
>> > I'm not sure how best to solve the weird case when we have multiple
>> > adapters tied together, but perhaps something with extending how the
>> > ice_adapter lookup is done could work? Sergey, I think we can continue
>> > this design discussion off list and come up with a proposal.
>> > 
>> > We also have to be careful that whatever new solution also handles
>> > things which we got with auxiliary bus:
>> > 
>> > 1) prevent issues with ordering if a clock port loads before the clock
>> > owner PF. If the clock owner loads first, then we need to ensure the
>> > port still gets initialized. If the clock owner loads second, we need to
>> > avoid issues with things not being setup yet, i.e. ensure all the
>> > structures were already initialized (for example by initializing lists
>> > and such when we create the ice_adapter, not when the clock owner loads).
>> > 
>> > 2) prevent issues with teardown ordering that were previously serialized
>> > by the auxiliary bus unregister bits, where the driver unregister
>> > function would wait for all ports to shutdown.
>> > 
>> > I think this can be done correctly with ice_adapter, but I wanted to
>> > point them out because we get them implicitly with the current design
>> > with auxiliary bus.
>

