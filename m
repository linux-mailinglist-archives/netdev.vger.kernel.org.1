Return-Path: <netdev+bounces-177606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F383AA70BAF
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5C61886198
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647B266B55;
	Tue, 25 Mar 2025 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw0srGt7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE7E266591;
	Tue, 25 Mar 2025 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935287; cv=none; b=mdbrhUFsft61pPgEgF0AhXcZW0rHHnzHSnAFvIXHeZLJTtk6+Vzd2KSsJ2TGpcyexjmzsf80HgbOx95/CTbsr9bodpr9iUSI7QR42JlDXjiY4S7IeaBbuG7hDZ3XEiSV+HsZl7orggWOMHUnNYLBUboNAb6ECs0ZzGy4rqgHQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935287; c=relaxed/simple;
	bh=NGwV71ouwRn8P44y4aAqa9mJWu7Iye7dn0XvhDpFZOI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxoKxMKfqPptYhy3F+DVb3EgXsUWIk8P3d4NpdyjkQDUH2PFDdgypAnX2z1iI6l2CYFISwNsAJAeZ27HRoM2n0f2SxbiGOB10LQbJ5Pjs4dkzXZWPpD+e4idfq9IU48LBS2YX1SuHHg79Kn1Csa1Fd2C2+48rTDaCaLR5RWorbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dw0srGt7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43948021a45so53299485e9.1;
        Tue, 25 Mar 2025 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742935284; x=1743540084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ObDluC7htwMnBsTKfbVBbC9NKP/ElE+eUTaBtGCq1so=;
        b=dw0srGt7LlsLUWfMvu1/x6i5hdD5bsYGAXBO1fKj8x35FtJdF6bxr1OsNCRcxYUXnD
         YQKNmnipJVFFOkQh4xPob+/9Mt+MO+dNZzWI5uvRLG3F4ucK/EzMzTOWQlgiBWWebAF+
         yC3pzJ30GRV/oNpb9C6GCBPvXdlRV3laioMFsm+v+2ubIYORNMGb2lQWM8CGc8AHl+JO
         w95dN7cTtgQsy/6vA1LpOH9ukTtDrdnnq9iUxy0HynzFWqu9s1cIhiQ3F+yCDPCH89uc
         8+qD943PRkH3FvWeJ+/Q66zAwgwt80c97kbPtM+yn1JqZubs4bY/fjwBFoUbMFkVIaKy
         MIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935284; x=1743540084;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObDluC7htwMnBsTKfbVBbC9NKP/ElE+eUTaBtGCq1so=;
        b=TuDiBREPz3vxRFZlwxrLKm+EgcrF+8bbgfA/IHsyvWu6TbhE1jGu/DcZdXmtHVmsGi
         oDTNsMdJZ8GKZGp7Nd7KGaT2QmXA5kOnfO5Xof6ZTD6W4YvKtsuFU4GFxluZ4wLivSiI
         6sZPDQN2FouRzwhHXro6cr1NrZtgeYrAKxTQy4B7xm54XT8gUeVxVjOA+67wZ0i1NiBN
         7s7AdLiC8/bUYeTKKn0B+xSxQ063zOzgX4G901d1CG+AaMjQUzrb2ylcMSsA9iiSNgZ0
         VLLB5lU7xbrjtHp/1/uRW6Yq+WmGPKigYwXAB6I3Shx8zbBtLNz4fL3E6fIVL+XCsKqC
         yBuw==
X-Forwarded-Encrypted: i=1; AJvYcCUWa9oQDLUyB6dJD8VrYKgPGCBVrkch58SukfQDZJC1UMO7wEFin6dvn1SAL415bAcSO1VAtkv5@vger.kernel.org, AJvYcCVgSUj4rn+rQZSM0oQILVDuTyUkf4euawi9FjA36LSEMxhCTii9O6yodLd3aOJecjsoTy/oW+2X+XyaIFwa@vger.kernel.org, AJvYcCX6fZWGBlBxUYaGgGTwnuIPHjrDM9xmuJqtqTqx9Te6d4uKY7ioKv+BD9Vr6CvOLMt4lloxkpBjoV7V@vger.kernel.org
X-Gm-Message-State: AOJu0YxyiBGTqUaAeiK66i8ZkA7H/xImxfkWaDQxvYCDsR0fmSCiV9Qf
	PNnp7e0Ms9Y3GxyYLlpyTBqfs+y+IWjTVGhf2lWhpoJhBXtSbqmK
X-Gm-Gg: ASbGncugi32P7FNcy1zrp7itmKbG0JvtjzYhu/MuIHF2ezwENwfPGASH5c4fFKXnnFx
	COBAB9mGVo/vnIivixH/iqcfFDiObHg9vt3o9V/kIncvvRhDPs3H1fjvTkzTFBWKjfNUoINzYFv
	TxMoZwiit/t/B+CJYivFQK6rnMB7NQqjLfDGN1IFKt8zE8rQxny55AgsVljpoIwt4wjDTil6hBl
	aobf7VLO+5KDpHuFb6HpXPYyaFjBL+K+PJGOKomQ9gLVMIauM0xdd7kH5fIYNqi/T+5bKAsdJHP
	RPir391yi/JWs5WxIP5mmywPeGeDfNqEpOBwufWN992zxcvZn9cqicYIRgh+z6iZQkz535OtzHM
	j
X-Google-Smtp-Source: AGHT+IEnjy2hTMKMPgPy3Js4eIkxvZAQFMajHMEoTEcvVY2vaBzZm658GE79LL1+20hG96Jtz32P9Q==
X-Received: by 2002:a05:600c:12ca:b0:43d:7588:6688 with SMTP id 5b1f17b1804b1-43d75886820mr11370355e9.12.1742935283184;
        Tue, 25 Mar 2025 13:41:23 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9decbsm160143145e9.27.2025.03.25.13.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:41:22 -0700 (PDT)
Message-ID: <67e314f2.050a0220.f130b.7b84@mx.google.com>
X-Google-Original-Message-ID: <Z-MU8LVYhPuuU6GD@Ansuel-XPS.>
Date: Tue, 25 Mar 2025 21:41:20 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: phy: Add support for new Aeonsemi PHYs
References: <20250323225439.32400-1-ansuelsmth@gmail.com>
 <f0c685b0-b543-4038-a9bd-9db7fc00c808@lunn.ch>
 <67e1692c.050a0220.2b4ad0.c073@mx.google.com>
 <a9abc0c6-91c2-4366-88dd-83e993791508@lunn.ch>
 <67e29bce.050a0220.15db86.84a4@mx.google.com>
 <4f865b3a-0568-4fef-a56d-6360dfbd18f6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f865b3a-0568-4fef-a56d-6360dfbd18f6@lunn.ch>

On Tue, Mar 25, 2025 at 09:33:26PM +0100, Andrew Lunn wrote:
> On Tue, Mar 25, 2025 at 01:04:30PM +0100, Christian Marangi wrote:
> > On Mon, Mar 24, 2025 at 04:16:09PM +0100, Andrew Lunn wrote:
> > > On Mon, Mar 24, 2025 at 03:16:08PM +0100, Christian Marangi wrote:
> > > > On Mon, Mar 24, 2025 at 03:03:51PM +0100, Andrew Lunn wrote:
> > > > > > Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
> > > > > > AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
> > > > > > AS21210PB1 that all register with the PHY ID 0x7500 0x7500
> > > > > > before the firmware is loaded.
> 
> Do you have details of how these different PHY differ? Do they have
> different features?
>

No but I can ask more details. From what I can assume, gigabit, 2.5g 10g
and probably a PHY that expose multiple port (PHY package thing)

> > Ok update on this... The PHY report 7500 7500 but on enabling PTP clock,
> > a more specific ""family"" ID is filled in MMD that is 0x7500 0x9410.
> 
> Do they all support PTP?
> 

With PTP it's not the PTP we think but I guess it's something internal to
the PHY to actually start it. From comments it's called PTP Clock...

> > They all use the same firmware so matching for the family ID might not
> > be a bad idea... The alternative is either load the firmware in
> > match_phy_device or introduce some additional OPs to handle this
> > correctly...
> > 
> > Considering how the thing are evolving with PHY I really feel it's time
> > we start introducing specific OP for firmware loading and we might call
> > this OP before PHY ID matching is done (or maybe do it again).
> 
> You cannot download firmware before doing some sort of match, because
> you have no idea what PHY you actually have until you do a match, and
> if the PHY needs firmware.
> 
> match_phy_device() gives you a bit more flexibility. It will be called
> for every PHY on the board, independent of the ID registers. So you
> can read the ID registers, see if it is at least a vendor you know how
> to download firmware to, do the download, and then look at the ID
> registers again to see if it is the version of the PHY you want to
> drive. If not, return -ENODEV, and the core will try the next driver
> entry.
>

I'm finishing preparing V2 and I'm curious what you will think of the
implementation.

The approach I found works good is permit PHY device to register a
second time and the PHY driver toggle this.

This way in a PHY driver we register OPs for the to-be-init PHY and then
we probe the real one.

-- 
	Ansuel

