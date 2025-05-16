Return-Path: <netdev+bounces-190950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644BEAB96EE
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58EAC7A321C
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 07:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A6522ACFA;
	Fri, 16 May 2025 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q99XguMI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008722A819;
	Fri, 16 May 2025 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747382005; cv=none; b=qDw//hB9wla2h/hnmOdwIAFi4l5egoRBmUqliEl6+7EQmMbb47XrrVmMSPKXunszhd6IYPkcC2UoXWMxMhqpiMpYq4qvkecUeCYXCQe59hwtroSYXyCPYQaiyAKU6JmHSZtAogoeD5cTeokrsyKMOJbpAdpi/zMI/dcbjDPzm94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747382005; c=relaxed/simple;
	bh=VRYwJvlS/oPkw7h+ANDW8F6S+GBF6RqtdD8q4vdqTUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPaPofko1L1/AarAH2IOISfstEl7sX5vZvsB98D707hwH/nI5msHUenLSaT6Z6fjMI7HNRXZnRf0QXR6uwHZrO5a+q5rlNOIoIYyuo5j3UjZaXJQIi+v/ZMc6/PyobeLnE1ThVE7ojSzxEd/6b1m9MVhBoUdsqzjH+3GhQmaChw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q99XguMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D40DC4CEE4;
	Fri, 16 May 2025 07:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747382004;
	bh=VRYwJvlS/oPkw7h+ANDW8F6S+GBF6RqtdD8q4vdqTUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q99XguMIv33Z+vPyHpN5RT4ep5fNuBUeC0la/By8sXhmPU4UPHIuetCrS4xpRLADt
	 q5knwOmgErP4/Z9JhapU2SZLQWVSAeemiix+yqfSa+CVyCCBN/McF+mnieciyGBhdJ
	 f+nKzCKL6ZazHPm4LN7bTRJ6H/q69zUWyI2dOmbc=
Date: Fri, 16 May 2025 09:51:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Silicon Labs Kernel Team <linux-devel@silabs.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
Message-ID: <2025051612-stained-wasting-26d3@gregkh>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
 <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>
 <f1a4ab5a-f2ce-4c94-91eb-ab81aea5b413@lunn.ch>
 <D9W93CSVNNM0.F14YDBPZP64O@silabs.com>
 <2025051551-rinsing-accurate-1852@gregkh>
 <D9WTONSVOPJS.1DNQ703ATXIN1@silabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9WTONSVOPJS.1DNQ703ATXIN1@silabs.com>

On Thu, May 15, 2025 at 11:00:39AM -0400, Damien Riégel wrote:
> On Thu May 15, 2025 at 3:49 AM EDT, Greg Kroah-Hartman wrote:
> > On Wed, May 14, 2025 at 06:52:27PM -0400, Damien Riégel wrote:
> >> On Tue May 13, 2025 at 5:53 PM EDT, Andrew Lunn wrote:
> >> > On Tue, May 13, 2025 at 05:15:20PM -0400, Damien Riégel wrote:
> >> >> On Mon May 12, 2025 at 1:07 PM EDT, Andrew Lunn wrote:
> >> >> > On Sun, May 11, 2025 at 09:27:33PM -0400, Damien Riégel wrote:
> >> >> >> Hi,
> >> >> >>
> >> >> >>
> >> >> >> This patchset brings initial support for Silicon Labs CPC protocol,
> >> >> >> standing for Co-Processor Communication. This protocol is used by the
> >> >> >> EFR32 Series [1]. These devices offer a variety for radio protocols,
> >> >> >> such as Bluetooth, Z-Wave, Zigbee [2].
> >> >> >
> >> >> > Before we get too deep into the details of the patches, please could
> >> >> > you do a compare/contrast to Greybus.
> >> >>
> >> >> Thank you for the prompt feedback on the RFC. We took a look at Greybus
> >> >> in the past and it didn't seem to fit our needs. One of the main use
> >> >> case that drove the development of CPC was to support WiFi (in
> >> >> coexistence with other radio stacks) over SDIO, and get the maximum
> >> >> throughput possible. We concluded that to achieve this we would need
> >> >> packet aggregation, as sending one frame at a time over SDIO is
> >> >> wasteful, and managing Radio Co-Processor available buffers, as sending
> >> >> frames that the RCP is not able to process would degrade performance.
> >> >>
> >> >> Greybus don't seem to offer these capabilities. It seems to be more
> >> >> geared towards implementing RPC, where the host would send a command,
> >> >> and then wait for the device to execute it and to respond. For Greybus'
> >> >> protocols that implement some "streaming" features like audio or video
> >> >> capture, the data streams go to an I2S or CSI interface, but it doesn't
> >> >> seem to go through a CPort. So it seems to act as a backbone to connect
> >> >> CPorts together, but high-throughput transfers happen on other types of
> >> >> links. CPC is more about moving data over a physical link, guaranteeing
> >> >> ordered delivery and avoiding unnecessary transmissions if remote
> >> >> doesn't have the resources, it's much lower level than Greybus.
> >> >
> >> > As is said, i don't know Greybus too well. I hope its Maintainers can
> >> > comment on this.
> >> >
> >> >> > Also, this patch adds Bluetooth, you talk about Z-Wave and Zigbee. But
> >> >> > the EFR32 is a general purpose SoC, with I2C, SPI, PWM, UART. Greybus
> >> >> > has support for these, although the code is current in staging. But
> >> >> > for staging code, it is actually pretty good.
> >> >>
> >> >> I agree with you that the EFR32 is a general purpose SoC and exposing
> >> >> all available peripherals would be great, but most customers buy it as
> >> >> an RCP module with one or more radio stacks enabled, and that's the
> >> >> situation we're trying to address. Maybe I introduced a framework with
> >> >> custom bus, drivers and endpoints where it was unnecessary, the goal is
> >> >> not to be super generic but only to support coexistence of our radio
> >> >> stacks.
> >> >
> >> > This leads to my next problem.
> >> >
> >> > https://www.nordicsemi.com/-/media/Software-and-other-downloads/Product-Briefs/nRF5340-SoC-PB.pdf
> >> > Nordic Semiconductor has what appears to be a similar device.
> >> >
> >> > https://www.microchip.com/en-us/products/wireless-connectivity/bluetooth-low-energy/microcontrollers
> >> > Microchip has a similar device as well.
> >> >
> >> > https://www.ti.com/product/CC2674R10
> >> > TI has a similar device.
> >> >
> >> > And maybe there are others?
> >> >
> >> > Are we going to get a Silabs CPC, a Nordic CPC, a Microchip CPC, a TI
> >> > CPC, and an ACME CPC?
> >> >
> >> > How do we end up with one implementation?
> >> >
> >> > Maybe Greybus does not currently support your streaming use case too
> >> > well, but it is at least vendor neutral. Can it be extended for
> >> > streaming?
> >>
> >> I get the sentiment that we don't want every single vendor to push their
> >> own protocols that are ever so slightly different. To be honest, I don't
> >> know if Greybus can be extended for that use case, or if it's something
> >> they are interested in supporting. I've subscribed to greybus-dev so
> >> hopefully my email will get through this time (previous one is pending
> >> approval).
> >>
> >> Unfortunately, we're deep down the CPC road, especially on the firmware
> >> side. Blame on me for not sending the RFC sooner and getting feedback
> >> earlier, but if we have to massively change our course of action we need
> >> some degree of confidence that this is a viable alternative for
> >> achieving high-throughput for WiFi over SDIO. I would really value any
> >> input from the Greybus folks on this.
> >
> > So what you are looking for is a standard way to "tunnel" SDIO over some
> > other physical transport, right?  If so, then yes, please use Greybus as
> > that is exactly what it was designed for.
> 
> No, we want to use SDIO as physical transport. To use the Greybus
> terminology, our MCUs would act as modules with a single interface, and
> that interface would have "radio" bundles for each of the supported
> stack.
> 
> So we want to expose our radio stacks in Linux and Greybus doesn't
> define protocols for that, so that's kind of uncharted territories and
> we were wondering if Greybus would be the right tool for that. I hope
> the situation is a bit clearer now.

Yes, greybus does not expose a "wifi" protocol as that is way too device
specific, sorry.

So this just would be like any other normal SDIO wifi device then,
shouldn't be anything special, right?

thanks,

greg k-h

