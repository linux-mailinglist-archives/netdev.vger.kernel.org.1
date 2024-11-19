Return-Path: <netdev+bounces-146236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEAC9D263B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C84AB2C29B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD341CBE96;
	Tue, 19 Nov 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr5JIHIl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA41C4A0C;
	Tue, 19 Nov 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020371; cv=none; b=eFBqNZO4Va3b4ewZHcLdpGyYBRlCLnMQqmoF7IXwgqWgqEt60qjCDbOzZGaGaOcX5kcmUJkAkL/PH7lf1u7X/xyU/tgyKDXHujxh1xVZ5KBKXOM7bd+ZDNTAimWSZCralWCe0zLsC6aXGjM39W7EdbEdmJiMvV83AjY8lFQ89Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020371; c=relaxed/simple;
	bh=0Pc541MawFM6msnNwoO7usHE+Osm+SK8gs9XtT+jjYw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrGG5Ll6Jd7IhF1s3J/LgFUEfamz7cCo0k6LlKyt+EqmiJscXm2kwHLYTJiSMyF3LVx8wvmmZtCTDYVsk+D8sCOGQXh+WyZoLSjqH5SZQQXwT7MlQ03aOC/lMFl8d6WKO6PuOrcyiIkN14y5ZxfhLV9EmzogA0chvopJcrUU9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yr5JIHIl; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cfddb70965so1326206a12.0;
        Tue, 19 Nov 2024 04:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732020368; x=1732625168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k5/gaiAv8h6HJm8JV5izVAzWfhwGHsfvkAT3QjKySqk=;
        b=Yr5JIHIl4ZhNR063wMTPSQ7dpcigEynzwOO3JYXlxsq3jgj0wqXzHzO85AqEkX1FPQ
         z4Pos2YgUqzeDqRESaErFY2zI28n+Bqcq6ESzoN35f2mt8JTdxgXvpCJxYZdmwuD2xSY
         N1AiFPwjIuL7o2O1o2KD4TceywvHagXHL7rmPGeOV9b1gFUmkiCrxTKgo7wLLMa/YShm
         KSg7kSNPXxAM2uCDVauF/Mh5NAARTa3BhxdW0u/vRasbx84n3e/glFPTyyDJtTenSGix
         3eMtu/qmzEMwAb7iZVLa6rVSJzVytnSyyWofXDIuN6soX4Ug3ufrjOpSxzUNoKPWb0eI
         itCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732020368; x=1732625168;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5/gaiAv8h6HJm8JV5izVAzWfhwGHsfvkAT3QjKySqk=;
        b=ECtwDxJilThN8KslyUeARSwXxP4qRPnBrwnv+bclxyzF+snSvEvbGSzSImXVSO6J86
         qGy7y296sM4ZefHiZ7sLyuHwEKliPUCMNGjVqRffUDRO8gQ2hkR57TRI/SKUXlGBeUux
         9jFQEHxRDsNurJM9wAFqqp4F6sR1Y/+EgfF8fJrVTLeU03l46sOEwkCg8ADWU49KIl3Z
         8p5QuxHzAaZMZnR6per3Srx2Py3GN8uuVIilK4qJ0rosc8PSafFk0YX03i4rlWlt2mNx
         RwRjpxJZhwKu4E1vRYrSvNlNH0r99+DLRd0RvDmr8x1RDXhJuruL3QaYluUYjF7w30l+
         magA==
X-Forwarded-Encrypted: i=1; AJvYcCUGwYX0pYtIgNywewcy0BN6+Z+F114YXsf5bvzHx2ZAwGlVi63DyYjJc1k25x3vKUFU2KyPpvIl@vger.kernel.org, AJvYcCWAuv9+HkGva1GH/QA4jzLxW5xE+vtgUVCmkIzf7Wf8e3PoWaHWg3jeA+h56ZYVijvi7F3pjCFAbjOIYolZ@vger.kernel.org, AJvYcCXDOUPUmCVtALuXBngSR9ojbWoJWzo+djAYiZhq46ISr3k6Lk6N3EU920Qv44yhot/v9ddh4xvMuncK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+qu9frlk3saD2/kg/iF6s7bOuGJI2zbwP4d2PCYXgF0j/T38A
	JTyTwPPj6pEsgiBAT7FCHsNAPMHqvSDdXJ1l1u+TIsZ1/XUtS0dX
X-Google-Smtp-Source: AGHT+IHCYZ3NKhKPZWjj2AvexgxpQZKs0aHkGi3venZoVOafZ13nTepAJ8dEvaexbzt3d9JyKwNwfg==
X-Received: by 2002:a05:6402:268e:b0:5cf:bcce:7422 with SMTP id 4fb4d7f45d1cf-5cfbcce7560mr6787204a12.6.1732020367487;
        Tue, 19 Nov 2024 04:46:07 -0800 (PST)
Received: from Ansuel-XPS. ([62.19.98.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfcb3edce9sm1966351a12.35.2024.11.19.04.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 04:46:07 -0800 (PST)
Message-ID: <673c888f.a70a0220.26ea38.88b1@mx.google.com>
X-Google-Original-Message-ID: <ZzyIi1Bsz5djjEGX@Ansuel-XPS.>
Date: Tue, 19 Nov 2024 13:46:03 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v7 0/4] net: dsa: Add Airoha AN8855 support
References: <20241117132811.67804-1-ansuelsmth@gmail.com>
 <20241118144859.4hwgpxtql5fplcyt@skbuf>
 <673b88ea.5d0a0220.17b04a.bc4b@mx.google.com>
 <f8c50ee6-a3d7-45eb-9c11-8018cc4043cb@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8c50ee6-a3d7-45eb-9c11-8018cc4043cb@redhat.com>

On Tue, Nov 19, 2024 at 12:10:19PM +0100, Paolo Abeni wrote:
> On 11/18/24 19:35, Christian Marangi wrote:
> > On Mon, Nov 18, 2024 at 04:48:59PM +0200, Vladimir Oltean wrote:
> >> On Sun, Nov 17, 2024 at 02:27:55PM +0100, Christian Marangi wrote:
> >>> This small series add the initial support for the Airoha AN8855 Switch.
> >>>
> >>> It's a 5 port Gigabit Switch with SGMII/HSGMII upstream port.
> >>>
> >>> This is starting to get in the wild and there are already some router
> >>> having this switch chip.
> >>>
> >>> It's conceptually similar to mediatek switch but register and bits
> >>> are different. And there is that massive Hell that is the PCS
> >>> configuration.
> >>> Saddly for that part we have absolutely NO documentation currently.
> >>>
> >>> There is this special thing where PHY needs to be calibrated with values
> >>> from the switch efuse. (the thing have a whole cpu timer and MCU)
> >>
> >> Have you run the scripts in tools/testing/selftests/drivers/net/dsa/?
> >> Could you post the results?
> > 
> > Any test in particular? I'm working on adding correct support for them
> > in OpenWrt. Should I expect some to fail?
> 
> Unfortunatelly this landed on netdev too close to the merge window. I'll
> unable to apply it on time and process the net-next PR as expected even
> if it would receive ack from the DSA crew right now.
> 
> @Christian, you will have to repost it after the merge window.
>

It's ok, just any timeframe? Guess 2 weeks till net-next reopens? (just
to put a remainder on the calendar so I won't forget)

-- 
	Ansuel

