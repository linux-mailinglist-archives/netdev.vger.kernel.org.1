Return-Path: <netdev+bounces-125628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87FA96E013
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 18:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6CA1C20D83
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECAB1A01D9;
	Thu,  5 Sep 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZgZpHhGV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349C19EEB0
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554612; cv=none; b=C2JViL/7SLYofKcHct1OG3/PU8d2qxMcWIUHUmYY+M8YjUpdQFHHaHY9oiKeX3rzhxJu5GrVu23euMqhdEy1UOkofNdhTE4WCZ7nUKWst6J5DLNt/uw5OfZw2kb9CYsWNUplur6h9KLKNwKBQKb6I70rPkX2XyidMpzG05DbEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554612; c=relaxed/simple;
	bh=c7m+RNyq7iAjsBTay5Gjc6yi5+rmYBoTjqtXT+27Ecs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DasDwGkAQFOECTtv0OvHcWqTr/UcaKlNde7ML10ZP+2743T1JwTdy7DN0OT8yA4x5w488jLIzoKLkn88TckYVGiblvVIbja2pXbEIi/tsFkNIvWxZzk6wyCfIJWVvlEB9bv8YD3jNym3Q7qPFru0a7FZANc3n72FGagxhGO7blI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZgZpHhGV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a86c476f679so140789366b.1
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725554608; x=1726159408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9/Cl4pns2tvY2+ex2I7VzPKJmEi9tuK1Vum+Ld5DXw=;
        b=ZgZpHhGVJh5N2A/lMrtG3RzRcBAcAkw5QwAsHDHWu1i0n4n1O0tR+otEU7nfw15lD5
         wETq84/L8Jo1ZImayOTRnhZ5CT3UEw8mz6GSCT/w103tkpbanEkSo8/KcMfUJ2ziZMX+
         putGeW/TVBjI3ZOjPprwPYvDMcDE5eoof1iE8eCmkAmGyqqpHcF8Uwk/XdTXHApO6+hU
         bLEGJjkQm2gho3TQAhJlm3p9LZjNNaCoXJY7L/ipp0zsmExPosPNtabUpfSfm+TlOA39
         VnGPzE7xpCp7dwvlBam7G+tsBC3wz+KhNvBevec9HmNfujZ0DuzRzAf42HvfPnHInwxU
         C5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725554608; x=1726159408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9/Cl4pns2tvY2+ex2I7VzPKJmEi9tuK1Vum+Ld5DXw=;
        b=s5uSqEiW14moYbgtoTUxxhRBnmJCamvy6ssoCY500tCmLePdnednoP3ovnNURlglF1
         7cg/n9IaN8x6owNl44CIiF+2P0WSGpsGxH9yq8S/nRlOYeYAUoVw7Luiug/GKcPQKoS8
         izqxD4nzgHbDsHq3NhSA65p5hAXqM/kKP3uFhWZFck1YgDpcymaq3QIcJ9n5g46X6jz7
         hCNmR5GwYZzvILbajSSpvsDmRxodgPicHSdIe22RFbByZccYWV4TpwBRZUitgjSUrR/g
         i0Ibf8/MM7AZCY6vrO6J+u9Zc5MNbDHVQAUBnpAJj7lJ7F9GQhxfLa7laFLmzT7RPtvN
         svpw==
X-Forwarded-Encrypted: i=1; AJvYcCUtftzXBl354w+1sm8WPABPUUfhTTvFax/jPrgnyVE7ry+DoyZ42vSG9mCGya+C0RjkZpuWQ7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+8GOUTl3JBbSFJ9qXl199/Yqj2f0Y9L+TsabqEEfyqIzaRZR
	lttHpNnXe55IArbvFMx+8FaJtIt49kjDwBZ9RVEtQKuZu8ORFXVDiX8SHPT0xcs=
X-Google-Smtp-Source: AGHT+IEz20rh2z3FuTn3FqdARHdBZA33h+CRI0+H4sggZcuGroEd9OHEiz6QTkjQzE4FTjN3pv3RUA==
X-Received: by 2002:a17:907:dab:b0:a86:743a:a716 with SMTP id a640c23a62f3a-a89b96f8af8mr1230712666b.53.1725554607887;
        Thu, 05 Sep 2024 09:43:27 -0700 (PDT)
Received: from localhost (host-80-182-198-72.retail.telecomitalia.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d0easm156239566b.102.2024.09.05.09.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:43:27 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 5 Sep 2024 18:43:35 +0200
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 03/11] PCI: of_property: Sanitize 32 bit PCI address
 parsed from DT
Message-ID: <Ztnft3p3tb_kP1jc@apocalypse>
References: <Zszcps6bnCcdFa54@apocalypse>
 <20240903222644.GA126427@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903222644.GA126427@bhelgaas>

Hi Bjorn,

On 17:26 Tue 03 Sep     , Bjorn Helgaas wrote:
> On Mon, Aug 26, 2024 at 09:51:02PM +0200, Andrea della Porta wrote:
> > On 10:24 Wed 21 Aug     , Bjorn Helgaas wrote:
> > > On Tue, Aug 20, 2024 at 04:36:05PM +0200, Andrea della Porta wrote:
> > > > The of_pci_set_address() function parses devicetree PCI range
> > > > specifier assuming the address is 'sanitized' at the origin,
> > > > i.e. without checking whether the incoming address is 32 or 64
> > > > bit has specified in the flags.  In this way an address with no
> > > > OF_PCI_ADDR_SPACE_MEM64 set in the flags could leak through and
> > > > the upper 32 bits of the address will be set too, and this
> > > > violates the PCI specs stating that in 32 bit address the upper
> > > > bit should be zero.
> 
> > > I don't understand this code, so I'm probably missing something.  It
> > > looks like the interesting path here is:
> > > 
> > >   of_pci_prop_ranges
> > >     res = &pdev->resource[...];
> > >     for (j = 0; j < num; j++) {
> > >       val64 = res[j].start;
> > >       of_pci_set_address(..., val64, 0, flags, false);
> > >  +      if (OF_PCI_ADDR_SPACE_MEM64)
> > >  +        prop[1] = upper_32_bits(val64);
> > >  +      else
> > >  +        prop[1] = 0;
> > > 
> > > OF_PCI_ADDR_SPACE_MEM64 tells us about the size of the PCI bus
> > > address, but the address (val64) is a CPU physical address, not a PCI
> > > bus address, so I don't understand why of_pci_set_address() should use
> > > OF_PCI_ADDR_SPACE_MEM64 to clear part of the CPU address.
> > 
> > It all starts from of_pci_prop_ranges(), that is the caller of
> > of_pci_set_address().
> 
> > val64 (i.e. res[j].start) is the address part of a struct resource
> > that has its own flags.  Those flags are directly translated to
> > of_pci_range flags by of_pci_get_addr_flags(), so any
> > IORESOURCE_MEM_64 / IORESOURCE_MEM in the resource flag will
> > respectively become OF_PCI_ADDR_SPACE_MEM64 /
> > OF_PCI_ADDR_SPACE_MEM32 in pci range.
> 
> > What is advertised as 32 bit at the origin (val64) should not become
> > a 64 bit PCI address at the output of of_pci_set_address(), so the
> > upper 32 bit portion should be dropped. 
> 
> > This is explicitly stated in [1] (see page 5), where a space code of 0b10
> > implies that the upper 32 bit of the address must be zeroed out.
> 
> OK, I was confused and thought IORESOURCE_MEM_64 was telling us
> something about the *CPU* address, but it's actually telling us
> something about what *PCI bus* addresses are possible, i.e., whether
> it's a 32-bit BAR or a 64-bit BAR.
> 
> However, the CPU physical address space and the PCI bus address are
> not the same.  Generic code paths should account for that different by
> applying an offset (the offset will be zero on many platforms where
> CPU and PCI bus addresses *look* the same).
> 
> So a generic code path like of_pci_prop_ranges() that basically copies
> a CPU physical address to a PCI bus address looks broken to me.

Hmmm, I'd say that a translation from one bus type to the other is
going on nonetheless, and this is done in the current upstream function
as well. This patch of course does not add the translation (which is
already in place), just to do it avoiding generating inconsistent address.


> 
> Maybe my expectation of this being described in DT is mistaken.

Not sure what you mean here, the address being translated are coming from
DT, in fact they are described by "ranges" properties.

Many thanks,
Andrea

> Bjorn

