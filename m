Return-Path: <netdev+bounces-12720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB254738A95
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 18:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEFD1C20EC7
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429E319904;
	Wed, 21 Jun 2023 16:14:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FADAC15E
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 16:14:53 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D40C186;
	Wed, 21 Jun 2023 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ik7rJHaj1qzSs2X3MBG7iKEMNpHmxnSx/M+1Kzp2joY=; b=otdvDzqfkar6RS4pYFoDbzEzpq
	JiN4CSjoBZNtghkEbKsI1RX5gmvM6tiW/Dr566PB7PEyCctqx8zFajPymPf5MymYszlRGwSq3Tc3g
	GxqLybgBqao4pj6kJIszUNHKhsoeVIC/m4p07vccvLnZp/FBUW1D6/54RdI4ADtXNYW8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qC0T5-00HA64-GG; Wed, 21 Jun 2023 18:14:03 +0200
Date: Wed, 21 Jun 2023 18:14:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Evan Quan <evan.quan@amd.com>, rafael@kernel.org, lenb@kernel.org,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mario.limonciello@amd.com, mdaenzer@redhat.com,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	hdegoede@redhat.com, jingyuwang_vip@163.com, lijo.lazar@amd.com,
	jim.cromie@gmail.com, bellosilicio@gmail.com,
	andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
	arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 1/8] drivers/acpi: Add support for Wifi band RF
 mitigations
Message-ID: <d2dba04d-36bf-4d07-bf2b-dd06671c45c6@lunn.ch>
References: <20230621054603.1262299-1-evan.quan@amd.com>
 <20230621054603.1262299-2-evan.quan@amd.com>
 <3a7c8ffa-de43-4795-ae76-5cd9b00c52b5@lunn.ch>
 <216f3c5aa1299100a0009ddf4e95b019855a32be.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216f3c5aa1299100a0009ddf4e95b019855a32be.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > Do only ACPI based systems have:
> > 
> >    interference of relatively high-powered harmonics of the (G-)DDR
> >    memory clocks with local radio module frequency bands used by
> >    Wifi 6/6e/7."
> > 
> > Could Device Tree based systems not experience this problem?
> 
> They could, of course, but they'd need some other driver to change
> _something_ in the system? I don't even know what this is doing
> precisely under the hood in the ACPI BIOS

If you don't know what it is actually doing, it suggests the API is
not very well defined. Is there even enough details that ARM64 ACPI
BIOS could implement this? 

> > > +/**
> > > + * APIs needed by drivers/subsystems for contributing frequencies:
> > > + * During probe, check `wbrf_supported_producer` to see if WBRF is supported.
> > > + * If adding frequencies, then call `wbrf_add_exclusion` with the
> > > + * start and end points specified for the frequency ranges added.
> > > + * If removing frequencies, then call `wbrf_remove_exclusion` with
> > > + * start and end points specified for the frequency ranges added.
> > > + */
> > > +bool wbrf_supported_producer(struct acpi_device *adev);
> > > +int wbrf_add_exclusion(struct acpi_device *adev,
> > > +		       struct wbrf_ranges_in *in);
> > > +int wbrf_remove_exclusion(struct acpi_device *adev,
> > > +			  struct wbrf_ranges_in *in);
> > 
> > Could struct device be used here, to make the API agnostic to where
> > the information is coming from? That would then allow somebody in the
> > future to implement a device tree based information provider.
> 
> That does make sense, and it wouldn't even be that much harder if we
> assume in a given platform there's only one provider

That seems like a very reasonable assumption. It is theoretically
possible to build an ACPI + DT hybrid, but i've never seen it actually
done.

If an ARM64 ACPI BIOS could implement this, then i would guess the low
level bits would be solved, i guess jumping into the EL1
firmware. Putting DT on top instead should not be too hard.

	Andrew

