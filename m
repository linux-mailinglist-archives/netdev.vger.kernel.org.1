Return-Path: <netdev+bounces-161296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5060A20865
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08AE3A915B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 10:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF66519D06A;
	Tue, 28 Jan 2025 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BovqRX7E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9319C554;
	Tue, 28 Jan 2025 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738059695; cv=none; b=PLgKYWfyPaw/8j2yNkzQxViOT25h8/RMEVFWFI+MFBsAH9XzIyUn5Vow/fM0T2jNDl/6/6xNYWqX0Lhx2gTXbwjTdDmVGd3EZJ1TESaZfP0Q8GYI0MWov85t0YhV6vwx2+XnafkrjzYWTshwTqOC1zQfTkK/WSHCEEdljcy6MYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738059695; c=relaxed/simple;
	bh=0XASCeuAcMttOtn9QoTNYDO18j+QS5Cs+5vG8sdFr+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc5FCWLChPU0hDg7cP6eunoh5JLqERC342JPRdqpkmDEOuwC3jJGMmQRBMMqBbZvsk0JXzuA9cudE3TB0FbLDyHgbJnSCrNhHNdm2X6zdNy+ti7GdSYs77oM3zKlImmAsQwlHFdF1rFQKPS4b1iZtEsEX76wAz5zSa0NcbDOgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BovqRX7E; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e971a2a0so308365f8f.1;
        Tue, 28 Jan 2025 02:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738059692; x=1738664492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oIQsVpnqr7R+B16aPV5zm4mu1Hot0Atbueuy1SVTXwM=;
        b=BovqRX7ElWK28xjKAK935J5EFHb+G/IbA+GWNgK+3Q6jecwNR4+V3wR/5I0J+9gw0b
         a8DGBaeDjwODa2BACr2X5Kf6Q17FmIlPOOaPAB1Jusl1OK7pOwkfqT7IkY/0MhMIyqJU
         JR4qpz6xTWf5DcRKABD9QLqc9ga8sX0vnq1MSWRIAeCDkfoAT5GzpjQos4Ae+IadqrjY
         p8Y0oVtHxxRQBKfjEewiGtW3lzXQ3eqGrhX0igusP00fy3myK8fiAgMvwv2LFkloffFP
         ycEYAZLS8SCNRqgifTwQPEElPFfGjd1iiZTpaW/nWE+JWs2OZ93EYQC/2K8PX6xKVimM
         KDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738059692; x=1738664492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIQsVpnqr7R+B16aPV5zm4mu1Hot0Atbueuy1SVTXwM=;
        b=GWs1ltkYnfewj8d7Dvymn/9HdtRIslG9rdV4gt/i2G8X8E68a9XHszLCCvQmDz00Gr
         3atnQBTyPiQIGc44qndtEbEwD6Sjsml6+SQPPu5UCXnvu9BvsAYz4VtL/91VvOBQEXC5
         D5r9YUnscGZtUfZpmlyqFvt8WJmzHiYv2p8eOvUn7QwrGHC9sufJA81pZDQRDCl2uhWc
         ehFglPX3H+fAuXLmISSccJ59Pymg6xsuVZcL2c+IASGEPBDk76PU1NR2AxjhrUte/f3f
         9nbPFL05EfFBFGzkAPZoOPyuyG4Vli0WQNGlISLQszC87feHrKVF8BqGziACidg3zvvU
         e4tw==
X-Forwarded-Encrypted: i=1; AJvYcCUP2oP/ctQNy8n+24Qe7e9fO4UalCZcJKHJ2ALVxuS+w2CeD5mTh387ohW5dKm+1XBdbl12WhGocu+rxts=@vger.kernel.org, AJvYcCXtBb+nrHUA2I7b2OYXybkl4xTPe48h0c7Qesv9RR08koIBFwenF9oqITRQ7hjj8u6mxUSz9Gtw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+jhOxQOA8x5RfBatEvAxSGBUZBKV/X+Ec83+M8irGpPDYmyK
	a4+Vb1Iq5lON89wWVn1YmPBx9QtHGRxV3pG9TZoH1IRvEDkafNsi
X-Gm-Gg: ASbGncua6df6s0jRqXfzTBd/OG/QnhWpyOAj/R/zG9RjLrDZTYQ0NqxN8y0fgZsNFQq
	UjAjnrweRDkjRS6ihPdI8BQ0MX3QoikgJFylLG9IuVD5GYLKmtSGfVUT4n2XgLCMfgSFCSVE+LC
	58WykNGDejVEbc4A7FJQD1z1gzPTPMYAx+aQGFJSFtOj1FtuMdRXTUJifKHoDhTFASqz3xGtkiG
	EE/9sLYMMqwWlrKzBQDdmOvCZ015VtRm6e2Buk58tTddDIZ04p7y/ssD2d6fZGG1X2G7aN4jUfW
	HNvXwQ75RrXGhg==
X-Google-Smtp-Source: AGHT+IHeGWSm5F9O8Y5jy8I1MLXz1Y/ZRPDn9Osiw3/yE9LxvaojJxByC3XRyw82kBbPjaN4e8gVJw==
X-Received: by 2002:a5d:5e11:0:b0:38b:ed21:c2ad with SMTP id ffacd0b85a97d-38bf57b2ca3mr11537087f8f.10.1738059691905;
        Tue, 28 Jan 2025 02:21:31 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d6f8sm13483193f8f.28.2025.01.28.02.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 02:21:31 -0800 (PST)
Date: Tue, 28 Jan 2025 12:21:28 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <20250128102128.z3pwym6kdgz4yjw4@skbuf>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>

On Tue, Jan 28, 2025 at 09:24:45AM +0000, Russell King (Oracle) wrote:
> On Mon, Jan 27, 2025 at 07:32:25PM -0800, Tristram.Ha@microchip.com wrote:
> > For 1000BaseX mode setting neg_mode to false works, but that does not
> > work for SGMII mode.  Setting 0x18 value in register 0x1f8001 allows
> > 1000BaseX mode to work with auto-negotiation enabled.
> 
> I'm not sure (a) exactly what the above paragraph is trying to tell me,
> and (b) why setting the AN control register to 0x18, which should only
> affect SGMII, has an effect on 1000BASE-X.
> 
> Note that a config word formatted for SGMII can result in a link with
> 1000BASE-X to come up, but it is not correct. So, I highly recommend you
> check the config word sent by the XPCS to the other end of the link.
> Bit 0 of that will tell you whether it is SGMII-formatted or 802.3z
> formatted.

I, too, am concerned about the sentence "setting neg_mode to false works".
If this is talking about the only neg_mode field that is a boolean, aka
struct phylink_pcs :: neg_mode, then setting it to false is not
something driver customizable, it should be true for API compliance,
and all that remains false in current kernel trees will eventually get
converted to true, AFAIU. If 1000BaseX works by setting xpcs->pcs.neg_mode
to false and not modifying anything else, it should be purely a
coincidence that it "works", since that makes the driver comparisons
with PHYLINK_PCS_NEG_* constants meaningless.

> According to the KSZ9477 data, the physid is 0x7996ced0 (which is the
> DW value according to the xpcs header file). We also read the PMA ID
> (xpcs->info.pma). Can this be used to identify the KSZ9477 without
> introducing quirks?

If nothing else works, and it turns out that different IP integrations
report the same value in ID registers but need different handling, then
in principle the hack approach is also on the table. SJA1105, whose
hardware reads zeroes for the ID registers, reports a fake and unique ID
for the XPCS to identify it, because it, like the KSZ9477 driver, is in
control of the MDIO read operations and can selectively manipulate their
result.

