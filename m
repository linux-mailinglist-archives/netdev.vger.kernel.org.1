Return-Path: <netdev+bounces-148921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 575DC9E373B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2246B23845
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F831A0B07;
	Wed,  4 Dec 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud+O3Qf6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19918A6BC;
	Wed,  4 Dec 2024 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306836; cv=none; b=gguEuupht4sgDoZq1VRjWnXY6pKX106EXgag/Bx3B7wvXLdE9RE8nYdFCIoPt5ey/pK6llTKMSCDDxH0Vtdx1D340PJdJa+70LB4y9/fD/K0pQRMTyk5/sjcLgTyBKBpaKhizGp9IDt4D7xXs83TtzUKSFkd8xmJOd8Bzr/iCvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306836; c=relaxed/simple;
	bh=Trj3DyQwScsjZrJ7U1V/ZklO8IyMz0UiLqJb5kd0ujw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3NbIDh8P65Vd2c8TAWqcWnbF3Om3L3kolKjM7OJHj8KEaN/U1JumtZd/R5Shz0RWWAgT9FB0Ywu91JuWT3dRu8izI2BlyE63EidqKHQP6ftR3mNyLiNC02a5KOiOhk5hygtCGlALqpLF/5rjyMglCZb2tL4O9oF+YZPDmdN74k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud+O3Qf6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434aafd68e9so54250875e9.0;
        Wed, 04 Dec 2024 02:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733306833; x=1733911633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rZdzII5ceMbqNid98twXA3JIe19RaQfzWoabBNJlaDw=;
        b=Ud+O3Qf6w9QCZFHQfB1IWB7+BdDNrC8+tzsVhXm8xYJqn07di7GUJ/NvZRTOAOWQML
         RIoJX8J9BWAIuHwqrLBMzzz+HuokI7JT/8YRa/oACDTZG/ZQuHkgBkVUvrJblHEzwnsa
         nIWWmRq9SYFPB/UBybVyrUVy0XtLPvW9CmMVKJ1IDp3tBCawnPBDawf4ydyCkQ7vM0+m
         uxYITbh/aNGkH6QLySoec5LsBFV4G0QTiKT40AlidivdC4Pwi2tuMg9tBSJ4YSGeM9Lh
         fdPpauoTpzNGPIPOb1BDUuUfJ/k/BFWaTEZF1vnqXaedBabUmmHzud/BjNJgbcd+dUuh
         HHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733306833; x=1733911633;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZdzII5ceMbqNid98twXA3JIe19RaQfzWoabBNJlaDw=;
        b=qmj2hrGCGsJ9/PgiER4jK7ckl5W6CwHYuc8AV3KQJ9vqWBDIxBx4v+lHCyz6EKkwk1
         aKuREueJHlZAKJAkolF6JY7DAXjY+6ELOofni77xO1iLSlKCOoHldmSyCkH8shh4n+X1
         IQZFQ63x81hKN+uJ+yX/fGRrcQQzRCcDpibIq2ELedrho7WreX952ab9ufdOdknJVaSr
         qv1i36CNGNjZCalqUCxkev+aAW73Qi8CGKMPc3vEeWtyVvIOjZq0YnKNhANJd+j2K3jo
         oe3KIxqcdjB4LEjltT0uUktzJl8dCzU8zRdTzbq2NPyVuygBCoUTDFCxibZoeR6pQpyQ
         9f3g==
X-Forwarded-Encrypted: i=1; AJvYcCVDdl9iVsxCLEx6dPUV9cNcxp5XNYITV0myzemz1B7GC2S5onpa+mddWYmGdP4Z7pqtJQf4c1+PET+KoIj1@vger.kernel.org, AJvYcCWdjb2Y7zf/uon9vdtVcInh/m1dgxoDh+qhl/I+Dd1FQSBy0hcKrhMwSNcPyy6AoMOlJLMvL4QZcbh5@vger.kernel.org, AJvYcCXr/Hn99TGYvE6v113JEad7zldI4bbjFz231JJtoOgC99aLNwlxse7l2gWeOZKrx+t0WGOGulga@vger.kernel.org
X-Gm-Message-State: AOJu0YyKXSsqdlCQKIlYASL1kqVqE47XgnSq4FyEPqZuTHdsr+msSymR
	mBp1nwPz3l8xjFT9S+QTrCi29tjuYNL9GOGRAghlHaKrio4scrx9
X-Gm-Gg: ASbGncurUGAae0JV7Knjd8mJR+VS4seyLf5K+AHdWaMoWI0wYb898oiSh84eMpjrBKr
	u48YPfuaAWu61vTulkEIqZjTSfZ+rvfD7T0s/794Oytgkz1EEwfF79g9FkwJa6Tx1Gush8BB9hM
	seDat8nu5kVGHDMG7FqES97Bo0NkuiYTSwPNOnkjtKen8DFob0N2syjSyOJ6qII0GSpwa7GTOxG
	Y8RBO29zsnuoD50dWnbmpq2YPyJytkLp0tM6uPbjGnNRfnpGKhdpUhROV7sqyUbANLMd+SmJOva
	sVdZYQ==
X-Google-Smtp-Source: AGHT+IEmZW0+P/p4vKIwz6T1TOfzZOiXdf7VDC1j/nrxeJE9ePKA3vig1n3t7LFh49rBaBnOmNjmTQ==
X-Received: by 2002:a05:600c:1c8b:b0:434:a386:6ae with SMTP id 5b1f17b1804b1-434d09b14c7mr47619305e9.7.1733306832419;
        Wed, 04 Dec 2024 02:07:12 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0d4778dsm14329018f8f.45.2024.12.04.02.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:07:11 -0800 (PST)
Message-ID: <675029cf.df0a0220.1d1837.a877@mx.google.com>
X-Google-Original-Message-ID: <Z1ApzDEAyyRrHy4u@Ansuel-XPS.>
Date: Wed, 4 Dec 2024 11:07:08 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v8 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
References: <20241204072427.17778-1-ansuelsmth@gmail.com>
 <20241204072427.17778-4-ansuelsmth@gmail.com>
 <20241204100922.0af25d7e@fedora.home>
 <67501d7b.050a0220.3390ac.353c@mx.google.com>
 <Z1Af3YaN3xjq_Gtb@shell.armlinux.org.uk>
 <675021f1.050a0220.34c00a.3a0c@mx.google.com>
 <Z1AoSSDqAbEisuzK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1AoSSDqAbEisuzK@shell.armlinux.org.uk>

On Wed, Dec 04, 2024 at 10:00:41AM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 04, 2024 at 10:33:33AM +0100, Christian Marangi wrote:
> > On Wed, Dec 04, 2024 at 09:24:45AM +0000, Russell King (Oracle) wrote:
> > > > Added 5000 as this is present in documentation bits but CPU can only go
> > > > up to 2.5. Should I drop it? Idea was to futureproof it since it really
> > > > seems they added these bits with the intention of having a newer switch
> > > > with more advanced ports.
> > > 
> > > Is there any mention of supporting interfaces faster than 2500BASE-X ?
> > >
> > 
> > In MAC Layer function description, they say:
> > - Support 10/100/1000/2500/5000 Mbps bit rates
> > 
> > So in theory it can support up to that speed.
> 
> Maybe the internal IP supports this but the SoC doesn't?
> 
> However, I was asking about interfaces rather than speeds - so RGMII,
> SGMII, 2500BASE-X... is there a mention of anything else?
>

I can see mention of 5g Base-R so I assume supported but in the sdk
there isn't any code to configure it/I don't have any hardware.

(and documentation is empty for anything PCS related for register, just
block diagram)

I can ask it that is expected to work tho.

-- 
	Ansuel

