Return-Path: <netdev+bounces-90376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8C18ADE9F
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 09:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED796281AA7
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 07:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038C481B9;
	Tue, 23 Apr 2024 07:53:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85D147F64
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858829; cv=none; b=ipMkE+fxGY1FxjapEsToml6go/+mQu9QJPkO0maBwWCZX9IPIepc8fcj9MuvNA17z2MtvY3pg/MOvAjhVcEQBnYcumuZW7+rsDAu/zolAPZjlwuT4e4ozW9qNO7M+qpdgPhRr1uBut6ITq5tw7LmxrLqJhfnsv97NNFjrvvFFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858829; c=relaxed/simple;
	bh=zWhHyWOZ0DozYrdj0bdbzzt5v8ToYVgsaf4r4t0Uy44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU8tQOnvndIREnOD4UBsiy1Mwn3zF35L8yLyzcGAjakgr9WKRJ7/abGZjjvdlVMarShW5Eh+g+oamfuM9HxEOuhtWFjcKr+bNMg36rBaVlTVFd2z3oC6E+lROItmR39+wAXpr8CvGDF79Qm+CaSwzX/25cVLsuZasTeTJ83HPy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 734AA101E682A;
	Tue, 23 Apr 2024 09:53:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2CD0C48A0C0; Tue, 23 Apr 2024 09:53:38 +0200 (CEST)
Date: Tue, 23 Apr 2024 09:53:38 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, sasha.neftin@intel.com,
	Roman Lozko <lozko.roma@gmail.com>,
	Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net] igc: Fix LED-related deadlock on driver unbind
Message-ID: <ZidpAp1CL3iKfcGz@wunner.de>
References: <20240422204503.225448-1-anthony.l.nguyen@intel.com>
 <96939b80-b789-41a6-bea6-78f16833bbc9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96939b80-b789-41a6-bea6-78f16833bbc9@intel.com>

On Mon, Apr 22, 2024 at 04:32:01PM -0700, Jacob Keller wrote:
> On 4/22/2024 1:45 PM, Tony Nguyen wrote:
> > Roman reports a deadlock on unplug of a Thunderbolt docking station
> > containing an Intel I225 Ethernet adapter.
> > 
> > The root cause is that led_classdev's for LEDs on the adapter are
> > registered such that they're device-managed by the netdev.  That
> > results in recursive acquisition of the rtnl_lock() mutex on unplug:
> > 
> > When the driver calls unregister_netdev(), it acquires rtnl_lock(),
> > then frees the device-managed resources.  Upon unregistering the LEDs,
> > netdev_trig_deactivate() invokes unregister_netdevice_notifier(),
> > which tries to acquire rtnl_lock() again.
> > 
> > Avoid by using non-device-managed LED registration.
> > 
> 
> Could we instead switch to using devm with the PCI device struct instead
> of the netdev struct?

No, unfortunately that doesn't work:

The unregistering of the LEDs would then happen after unbind of the
pci_dev, i.e. after igc_release_hw_control() and pci_disable_device().
The LED registers aren't even accessible at that point, but the LEDs
are still exposed in sysfs.  I tried that approach but then realized
it's a mistake:

https://lore.kernel.org/all/ZhBN9p1yOyciXkzw@wunner.de/

Andrew Lunn concurred and wrote that "LEDs need to be added and
explicitly removed within the life cycle of the netdev":

https://lore.kernel.org/all/7cfb1af7-3270-447a-a2cf-16c2af02ec29@lunn.ch/

We'd have to convert the igc driver to use devm_*() for everything to
avoid this ordering issue.  I don't think that's something we can do
at this point in the cycle.  The present patch fixes a regression
introduced with v6.9-rc1.


There's another reason this approach doesn't work:

The first argument to devm_led_classdev_register() has two purposes:
(1) It's used to manage the resource (i.e. LED is unregistered on unbind),
(2) but it's also used as the parent below which the LED appears in sysfs.

If I changed the argument to the pci_dev, the LED would suddenly appear
below the pci_dev in sysfs, instead of the netdev.  So the patch would
result in an undesired change of behavior.

Of course we can discuss introducing a new devm_*() helper which accepts
separate device arguments for the two purposes above.  But that would
likewise be something we can't do at this point in the cycle.

We discussed the conundrum of the dual-purpose device argument in a
separate thread for r8169 (which suffered from the same LED deadlock):

https://lore.kernel.org/all/20240405205903.GA3458@wunner.de/

Thanks,

Lukas

