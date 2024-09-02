Return-Path: <netdev+bounces-124245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03125968AAA
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 17:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDD4283A14
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F051CB51F;
	Mon,  2 Sep 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp26qjRz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1221CB506
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289733; cv=none; b=i1dQ6HbDhyHsli1CAKs9S1WvHyloM8NbdzW1LDq5rQThE/jrLQ/+XXsNyaJ2+XKSEPNinEGOWpdC7iK/rN3iSwKZ34FSqz31KgdHmjfAX9hD2Q/lz1/IaupxpqYfyucFZQ6SohuJoH2ZLR8JVKKrJzNjxX4fOC3lRD8+AD6wXDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289733; c=relaxed/simple;
	bh=s80GzV8TUj/ry+7FU0Na9/he8AX5uCYzM0pqcREWfoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOrNaQiiaeWa2wEILNs3hoYef1PIEHWvGwT+t75U5JBBXzEy/u4RESFEUFLF5GSrhvE5LoWzzb4EZgzWMt7mGB4J/KSbw3Q6EyeGQritAO7/bF2sbN8+rIxAVeRa1ew748jQQu8gZiDMQvQuivthRX+EuJOQDkKVqJo1fezVbiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp26qjRz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42c53379a3fso3056435e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725289730; x=1725894530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBG4PQ/CpZsnZ2HX1NHwYJn+yDINEEs82pAtb3chHtk=;
        b=Xp26qjRzqywjFcIcBblmA5FDmvQ6h43FpoU+F1NI+Cnhu+9UCDPzP10wKk/ycpM3oG
         1dhH2KREepiujJmNHku53m6KaX+mmrxezd95d4FTZLx4pwgXIllZP19w1JRUVyXOkaHI
         YyRIqO4Bwyt4JI3NmBoOLuBMxlfBkM+s0LnEVyaaube1wK99wKs823XijorFmMZTjN+N
         tskxWkI3NY0frhR8PtOKwShxgHU8QaIB2YXF+/mdKE9HMEb14ddg0RyXfHKiBlGGyNRr
         sLOTeHBfjeRDC/TkbutSth7ijUHhtaJYooXlwb7JWflWcssJWACt18DQuTO3m3HkPqw1
         u3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725289730; x=1725894530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBG4PQ/CpZsnZ2HX1NHwYJn+yDINEEs82pAtb3chHtk=;
        b=b8bBpC8ZA24mX0tELBgNgTXO7WlXhA4kzNlHgLxVvBzKhLYdEfUjHsVcUASa+Fj+rH
         Omt3/O9kYyty6+Izn5PZsIKN3IUJ2eUdYXO6pFUSYIDjDb3yXEh2HLt2mRt+fe2NT0GG
         vybNFg5rjxZ02XHwQqQGyGpf8n6bZNPWZQkS1uS/O7Le4ghJvCIqaTPnFkjy8NZDbpoH
         mPFj+cP6WFcoYE+/G2FbN8atMBsrdMGy2wbLwkivGno/uMYe0G1IpJCGtr18ESF0gFFt
         qs2tj1XI6Q4FfjjaKOezTpaItgVKAa5/el27MI6B5AYjSLB0b7k/s+1bu/hbEj5nKmI5
         dw/A==
X-Forwarded-Encrypted: i=1; AJvYcCVk0Ah0nHD5TCX3lcu+xAlyFLtrHqWGjyd1fmnFC5eBicO2QUR1Dm/RfWXo+0NeRZOOmUdfK6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa5Rwny29xDrrGii3EJozwOMfT/XeouErVnSAS/mkrFbXUSBPI
	3a48NGzGOuVn8EK18cJp1lNApHj2/jIftlOcWx9O6FfNfxKjNGHZ
X-Google-Smtp-Source: AGHT+IFuPBDCOxNWdO30HwHJlrWFpCiUG4JFT1ttKWK4lEofe5Q0hulqGUKueDGrnk2FjxJ4CAte3A==
X-Received: by 2002:a05:6000:1f8d:b0:374:d0a1:6fbd with SMTP id ffacd0b85a97d-374d0a1720bmr717045f8f.8.1725289729548;
        Mon, 02 Sep 2024 08:08:49 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba8esm11704536f8f.50.2024.09.02.08.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 08:08:48 -0700 (PDT)
Date: Mon, 2 Sep 2024 18:08:45 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, woojung.huh@microchip.com,
	o.rempel@pengutronix.de, maxime.chevallier@bootlin.com
Subject: Re: [RFC net-next 1/2] net: ethtool: plumb PHY stats to PHY drivers
Message-ID: <20240902150845.jze45qvx4k3n7ijz@skbuf>
References: <20240829174342.3255168-1-kuba@kernel.org>
 <20240829174342.3255168-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829174342.3255168-2-kuba@kernel.org>

On Thu, Aug 29, 2024 at 10:43:41AM -0700, Jakub Kicinski wrote:
> Vladimir, I don't understand MM

MAC Merge / Frame Preemption in a nutshell:

- Frame is express if, after the preamble, it has a "normal" SFD of 0xD5

- Frame is preemptible if, after the preamble, it has an SFD of 0x07,
  0x19, 0xE6, 0x4C, 0x7F, 0xB3, 0x61, 0x52, 0x9E or 0x2A

express MAC handles express frames
preemptible MAC handles preemptible frames

ETHTOOL_MAC_STATS_SRC_EMAC counts express frames
ETHTOOL_MAC_STATS_SRC_PMAC counts preemptible frames
ETHTOOL_MAC_STATS_SRC_AGGREGATE counts both - also works when you don't know

Now you know as much as I do.

> but doesn't MM share the PHY?

It does, yes. There is a single set of MII lines, and distinction
between the express and preemptible MAC is done as described above.

I wouldn't expect the PHY to be aware of MAC Merge / Frame Preemption,
and thus, this component would normally not pay attention to the SFD of
the frames it's counting. The entire feature actually depends on the PHY
being unaware of the SFD, because they don't make PHYs "for" frame preemption.

Although, imaginably, just like we have PHYs which emit PAUSE frames,
and that technically means they have a MAC embedded inside, it would not
be impossible to twist standards such that the PHY handles FPE/MM.
This is only in the realm of theory, AFAIU, and I'm not suggesting we
should model the UAPI based on pure theory.

> Ocelot seems to aggregate which I did not expect.

Ocelot aggregates stats when the request is to aggregate them
(explicit ETHTOOL_MAC_STATS_SRC_AGGREGATE, and also default, for
comparability/ compatibility with unaware drivers). Otherwise it
reports them individually.

Also, the stats it reports into phy_stats->SymbolErrorDuringCarrier are
MAC stats. They count the number of frames received by the MAC with
RX_ER being asserted on the MII interface. So these could be counted by
either the MAC, or the PHY. The MAC is MM-aware, the PHY is probably not.

Though if I follow the thread, I'm not sure if this is exactly useful to
Oleksij, who would like to report an entirely different set of counters.

I never got the impression that the ETHTOOL_STATS_ETH_PHY structured
netlink counters were for NICs with embedded non-phylib PHYs. If they
are - sorry. I thought it was about those MAC counters which are
collected at the interface with the PHY.

