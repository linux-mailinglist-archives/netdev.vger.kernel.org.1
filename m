Return-Path: <netdev+bounces-179758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB2CA7E73B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AC8173A42
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389A1211487;
	Mon,  7 Apr 2025 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW3aOxmo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A646207DE0;
	Mon,  7 Apr 2025 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044409; cv=none; b=ktirTV3Lw9wmXTuIZ9i78VLck2+2ilPdUK1LAs9oxlPbA5DjoaW9RGj6OAyIL3J4u7wo1YsN3mK0PEyckoxfl20pmd2a+iy2nngavsKbIphJQdptT71boQFn6Y5+ug8oyHny+FN/CiF6+GP1P9qx1tj9/MeGfxw9p4KtIpBDvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044409; c=relaxed/simple;
	bh=RfwQQ9O80Lh+rIRuZORWFQZO7TkItzudgoruhM85HTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ez3xbY3JwnZc4/ImEEwYXAygXac+tkVmxzxJ984F8eLsTuKwJ3HYhkVO9PFhCLLcaoZVQ9Aq5wbT/U1FjEGDVrtvc3Co/ZFF5h+KPot241J1bZSoW0+Zl86qDqfTzc56y8i/mta0ZxZnJhTiqr+CaUopASbN+Ho313zmirRpaMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW3aOxmo; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so5300816d6.1;
        Mon, 07 Apr 2025 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744044405; x=1744649205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rcI46lTVSeHRR6PCsmQIdJkenRV/ajFn4WU+i3FnG5M=;
        b=aW3aOxmoBg2he8g2OxahlFJUjZfUWdCNU46zja91Ejcmz2GH1KTmSVucxyM7b4Mnvt
         WO3DxISZdarhm9msu/R9YaQdSJUf85n25Wh8ZE4zOEeRv2J+hzG9nxYghtGsWRxvHVt+
         eGm3UPSqYXh2L/VYOimg/1wAuy7aEaOkbk9oY7xlX2ZgdfO1UhzU9IXbjUIiZOOJI+4q
         epozO5tmdVm1igai8GY4sYKqrdTJ3lXY7Q7w9l1Ojf6ISY/dv2Jfx1Zq2F3Ke2Nmr0wi
         2I4ETx4VF0PFYr9BYHRiVgBZWwXmPPge/gC68JfraEHeVWsFQHEC1VTvfRWuG+xNm5Xn
         yYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744044405; x=1744649205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcI46lTVSeHRR6PCsmQIdJkenRV/ajFn4WU+i3FnG5M=;
        b=thNiCmp+i+2yG2YhH7k/3JOsj5LfJ9QjnRB5eXZGrSlUG83SFLKB5Tiv3+Krw45j6/
         Cn52W+PDyvRUXgW0ifUDldmoAV1AHE3ptso4PlX8smFHRXcJjzPEszg8BBK5XQuAQ/pq
         vvtJrybtVh+fuDPUnWJE9nJ7ufc+MvjXeGFSz2/lNnXTyDRu94wUNFc8InjpFZbZR3O/
         dFsYmFvHlEvFSmQXG33qBUxFCG4xtldx5r02EAvS7wFF35suXqvcdNMg86Lywt8FHrmc
         52yb9/i7JRcNPqLWQl+Tfi2n084IvGggvA57yC/hEEcdAAA33lMknfifLxDZ6jtvJPX3
         Il4A==
X-Forwarded-Encrypted: i=1; AJvYcCVJsAmHuW/sMfa+8v7ANs7biS+6NawtjVNyZLESFwKIk/CSgqWo8ZQQ6civl5Y6WS7EuOdR1JPUtfwS@vger.kernel.org, AJvYcCWEiLQDh9KPZSV4WS2MWNah3sp+HgMxxiwVqrYvZrGIzJ8ZnEt6t4NBqhrmpxg72dNhMoORYfiGZvHiwTOL@vger.kernel.org, AJvYcCWfOqnVWf1UaatN/4CkVCLMvwhqPFw2rr74HfRZTcnxbyEBgK5i+kFl3QRwqDEbRiEs7oSJOeRr@vger.kernel.org, AJvYcCXJPDSUZgH8JaEWvv0CrplsmTaNg4jJNOU0UK224VpLs1ULSvd1sSSc2EmroBc1nf6jfqxNoa0BJDKB@vger.kernel.org
X-Gm-Message-State: AOJu0YzTbOlK7fPbFV2Gc8Z0IHD7x9yDCTTmkNV8taWQPw3DNc+5K9XP
	u6nc3d8eeODaEz9PdBnJxrw5jfhTRKmTUxVx2xCZCyzoP2+Ua0LuCIjRFC/H7fUsgwLVVHrVEz/
	hZFiiHglH3EJWTnIoPqy/NuAn9AU=
X-Gm-Gg: ASbGncu1NN0JOp2YDFHRo9JYUlJMYOGXAJ1fKLxAna/SGMp8bdrPdnwyf1avgdm9YMA
	kMB2si0q/kjf30Jw29ZLvlsAXJEC45SlJ0XjGf+TJo7gyqmVyPiplfV4qDTQaWaJIK9SjoMcL+p
	ojjWAy8KQJHNgSfy0Fyfo1LKzs
X-Google-Smtp-Source: AGHT+IHn1NWvGQNUg+cTWq77arIBOMg99zSiThdNcGxwwVSUpNgoUD/iAcjqlZYjSbS/ACMXvRhNvnrbFKc+S9VTrwY=
X-Received: by 2002:a05:6214:1307:b0:6e2:3761:71b0 with SMTP id
 6a1803df08f44-6f0d24ed16bmr3696846d6.5.1744044405300; Mon, 07 Apr 2025
 09:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
 <20250407182738.498d96b0@kmaincent-XPS-13-7390> <720b6db8-49c5-47e7-98da-f044fc38fc1a@linux.dev>
In-Reply-To: <720b6db8-49c5-47e7-98da-f044fc38fc1a@linux.dev>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Mon, 7 Apr 2025 18:46:34 +0200
X-Gm-Features: ATxdqUHTe6GO-vqbSM3EmiJ-FaS0XfNSqylpsewp4c0XXyMi1WCC05uIygoRAqs
Message-ID: <CA+_ehUyAo7fMTe_P0ws_9zrcbLEWVwBXDKbezcKVkvDUUNg0rg@mail.gmail.com>
Subject: Re: [RFC net-next PATCH 00/13] Add PCS core support
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, upstream@airoha.com, 
	Heiner Kallweit <hkallweit1@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Clark Wang <xiaoning.wang@nxp.com>, 
	Claudiu Beznea <claudiu.beznea@microchip.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Conor Dooley <conor+dt@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Jonathan Corbet <corbet@lwn.net>, Joyce Ooi <joyce.ooi@intel.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Li Yang <leoyang.li@nxp.com>, 
	Madalin Bucur <madalin.bucur@nxp.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Michal Simek <michal.simek@amd.com>, Naveen N Rao <naveen@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Rob Herring <robh+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Robert Hancock <robert.hancock@calian.com>, 
	Saravana Kannan <saravanak@google.com>, Shawn Guo <shawnguo@kernel.org>, UNGLinuxDriver@microchip.com, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 7 apr 2025 alle ore 18:33 Sean Anderson
<sean.anderson@linux.dev> ha scritto:
>
> On 4/7/25 12:27, Kory Maincent wrote:
> > On Thu,  3 Apr 2025 14:18:54 -0400
> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >
> >> This series adds support for creating PCSs as devices on a bus with a
> >> driver (patch 3). As initial users,
> >>
> >> - The Lynx PCS (and all of its users) is converted to this system (patch 5)
> >> - The Xilinx PCS is broken out from the AXI Ethernet driver (patches 6-8)
> >> - The Cadence MACB driver is converted to support external PCSs (namely
> >>   the Xilinx PCS) (patches 9-10).
> >>
> >> The last few patches add device links for pcs-handle to improve boot times,
> >> and add compatibles for all Lynx PCSs.
> >>
> >> Care has been taken to ensure backwards-compatibility. The main source
> >> of this is that many PCS devices lack compatibles and get detected as
> >> PHYs. To address this, pcs_get_by_fwnode_compat allows drivers to edit
> >> the devicetree to add appropriate compatibles.
> >
> > I don't dive into your patch series and I don't know if you have heard about it
> > but Christian Marangi is currently working on fwnode for PCS:
> > https://lore.kernel.org/netdev/20250406221423.9723-1-ansuelsmth@gmail.com
> >
> > Maybe you should sync with him!
>
> I saw that series and made some comments. He is CC'd on this one.
>
> I think this approach has two advantages:
>
> - It completely solves the problem of the PCS being unregistered while the netdev
>   (or whatever) is up
> - I have designed the interface to make it easy to convert existing
>   drivers that may not be able to use the "standard" probing process
>   (because they have to support other devicetree structures for
>   backwards-compatibility).
>

I notice this and it's my fault for taking too long to post v2 of the PCS patch.
There was also this idea of entering the wrapper hell but I scrapped that early
as I really feel it's a workaround to the current problem present for
PCS handling.

And the real problem IMHO is that currently PCS handling is fragile and with too
many assumptions. With Daniel we also discussed backwards-compatibility.
(mainly needed for mt7621 and mt7986 (for mediatek side those are the 2
that slipped in before it was correctly complained that things were
taking a bad path)

We feel v2 permits correct support of old implementations.
The ""legacy"" implementation pose the assumption that PCS is never removed
(unless the MAC driver is removed)
That fits v2 where a MAC has to initially provide a list of PCS to
phylink instance.
With this implementation, a MAC can manually parse whatever PCS node structure
is in place and fill the PCS.

As really the "late" removal/addition of a PCS can only be supported with fwnode
implementation as dedicated PCS driver will make use of that.

I honestly hope we can skip having to enter the wrapper hell.
Anyway I also see you made REALLY GOOD documentation. Would be ideal to
collaborate for that. Anyway it's up to net maintainers on what path to follow.

Just my 2 cent on the PCS topic.

