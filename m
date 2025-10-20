Return-Path: <netdev+bounces-230816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3964BF012B
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFCF3B2080
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943C42727EE;
	Mon, 20 Oct 2025 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FWCLp+Ly"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2D1339A4;
	Mon, 20 Oct 2025 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950866; cv=none; b=nxfSpQmSYbYEa62Zls5rZzVRa47HCE9jNjJHq8vlTS9H6fCIEI3ur4wEW0Re/frQ+zfyU3wIR9t0p+NlFOPwgL+EMrNd56kWIBo/uv1QGbtsrUGkJ4CIXeM9jLztRZC34GVR8AFgp0DYjErZomHdsTonBgu7vkbAtyc+3R8ogAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950866; c=relaxed/simple;
	bh=s3TW/r7T2badC/ZEIZc34MmPgtv5S92LlxEm/4siFKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArgWeRNo5W9+YPY2DVr2iuhg8wJ77gJtdnko3Njrhf574hdHdMx7QcQgJF11Sg2lYEhcmLDgoY2CNTGTG+XSGVHYOC18MYuyaQWcroImLddCqQWVYfX6xoSogia7pgThZriwKZwVqITBn7D4EiPnwOJVETwB3sSDdP0dk6sNLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FWCLp+Ly; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8DB32C0AFE3;
	Mon, 20 Oct 2025 09:00:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 14310606D5;
	Mon, 20 Oct 2025 09:00:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7EABE102F0848;
	Mon, 20 Oct 2025 11:00:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760950851; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tPSoQs2CvGi5u9WAZU9trHNjsn5O33QJQeQZz6ZOGo8=;
	b=FWCLp+LymzTBtoxTpwCzYeqpC03RM5EI7AN7m04pAvK1k+3K7S9RkJKa6pxKOrt+rYFmhC
	TzdH1nu7WX2+ytv8jxRU37msTsvka2trXNIPTurDBqWBzyXvGqX4DPlZ3HD/aDIcvyOeMW
	EBmZzwmJStLSpTECQHbKP4h17C0oNr8BJCSaFRR2VINwm/jdSU+0RnPA9fqHOQuebw5zFg
	kamhtAmJBEGnhwkcK5Da+rZXiArfdes8X5DCXTBN/RPTjSaetFawm4FK4Yq5JF6clVjy8O
	I85axUH+b6Xe0ojYvTG7FwBzfKttPZzsrtiS/emYYBx+WPKDIXEJAPw0HvX/zQ==
Date: Mon, 20 Oct 2025 11:00:40 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: stmmac: Allow supporting coarse
 adjustment mode
Message-ID: <20251020110040.18cf60c9@kmaincent-XPS-13-7390>
In-Reply-To: <d40cbc17-22fa-4829-8eb0-e9fd26fc54b1@bootlin.com>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
	<20251015102725.1297985-3-maxime.chevallier@bootlin.com>
	<20251017182358.42f76387@kernel.org>
	<d40cbc17-22fa-4829-8eb0-e9fd26fc54b1@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Sat, 18 Oct 2025 09:42:57 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hi Jakub,
>=20
> On 18/10/2025 03:23, Jakub Kicinski wrote:
> > On Wed, 15 Oct 2025 12:27:22 +0200 Maxime Chevallier wrote: =20
> >> The DWMAC1000 supports 2 timestamping configurations to configure how
> >> frequency adjustments are made to the ptp_clock, as well as the report=
ed
> >> timestamp values.
> >>
> >> There was a previous attempt at upstreaming support for configuring th=
is
> >> mode by Olivier Dautricourt and Julien Beraud a few years back [1]
> >>
> >> In a nutshell, the timestamping can be either set in fine mode or in
> >> coarse mode.
> >>
> >> In fine mode, which is the default, we use the overflow of an accumula=
tor
> >> to trigger frequency adjustments, but by doing so we lose precision on=
 the
> >> timetamps that are produced by the timestamping unit. The main drawback
> >> is that the sub-second increment value, used to generate timestamps, c=
an't
> >> be set to lower than (2 / ptp_clock_freq).
> >>
> >> The "fine" qualification comes from the frequent frequency adjustments=
 we
> >> are able to do, which is perfect for a PTP follower usecase.
> >>
> >> In Coarse mode, we don't do frequency adjustments based on an
> >> accumulator overflow. We can therefore have very fine subsecond
> >> increment values, allowing for better timestamping precision. However
> >> this mode works best when the ptp clock frequency is adjusted based on
> >> an external signal, such as a PPS input produced by a GPS clock. This
> >> mode is therefore perfect for a Grand-master usecase.
> >>
> >> We therefore attempt to map these 2 modes with the newly introduced
> >> hwtimestamp qualifiers (precise and approx).
> >>
> >> Precise mode is mapped to stmmac fine mode, and is the expected defaul=
t,
> >> suitable for all cases and perfect for follower mode
> >>
> >> Approx mode is mapped to coarse mode, suitable for Grand-master. =20
> >=20
> > I failed to understand what this device does and what the problem is :(
> >=20
> > What is your ptp_clock_freq? Isn't it around 50MHz typically?=20
> > So 2 / ptp_freq is 40nsec (?), not too bad? =20
>=20
> That's not too bad indeed, but it makes a difference when acting as
> Grand Master, especially in this case because you don't need to
> perform clock adjustments (it's sync'd through PPS in), so we might
> as well take this opportunity to improve the TS.
>=20
> >=20
> > My recollection of the idea behind that timestamping providers
> > was that you can configure different filters for different providers.
> > IOW that you'd be able to say:
> >  - [precise] Rx stamp PTP packets=20
> >  -  [approx] Rx stamp all packets
> > not that you'd configure precision of one piece of HW.. =20
>=20
> So far it looks like only one provider is enabled at a given time, my
> understanding was that the qualifier would be used in case there
> are multiple timestampers on the data path, to select the better one
> (e.g. a PHY that supports TS, a MAC that supports TS, we use the=20
> best out of the two).

No, we do not support multiple timestampers at the same time.
For that IIUC we would have to add a an ID of the source in the packet. I
remember people were talking about modifying cmsg.=20
This qualifier is indeed a first step to walk this path but I don't think
people are currently working on adding this support for now.=20

> However I agree with your comments, that's exactly the kind of feedback
> I was looking for. This work has been tried several times now each
> time with a different uAPI path, I'm OK to consider that this is out
> of the scope of the hwprov feature.
>=20
> > If the HW really needs it, just lob a devlink param at it? =20
>=20
> I'm totally OK with that. I'm not well versed into devlink, working mostly
> with embedded devices with simple-ish NICs, most of them don't use devlin=
k.
> Let me give it a try then :)

meh, I kind of dislike using devlink here. As I said using timestamping
qualifier is a fist step for the multiple timestamping support. If one day =
we
will add this support, if there is other implementation it will add burden =
on
the development to track and change all the other implementation. Why don't=
 we
always use this qualifier parameter even if it is not really for simultaneo=
us
timestamping to avoid any future wrong development choice.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

