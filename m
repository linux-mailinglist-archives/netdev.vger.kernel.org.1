Return-Path: <netdev+bounces-243511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B6ECA2DAD
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 09:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB3F430161B4
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766843112D2;
	Thu,  4 Dec 2025 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLm/MtBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E72296BC9
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764838009; cv=none; b=ROWHbH6asB/2S3mxqeBrd0fR6dRwRc114/sf1n890dtUrrlqTecbHQXwy+XfyQXZpCq+iMkic/RVnRzd90uH8s1EWCuz4t+u6teoFb85WZCRVRC1oSgABR+5PXiiyPsV4yyD67AkpyBEkhrPCDFdHOftTTsOLEMPWzuIra2/tkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764838009; c=relaxed/simple;
	bh=5MsyoJKTr4eF88k1DWmG9hWB82ikFU21rjVWJP2KK98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL7T27BniqYtboq1QDecHe5ch2KkDasgQqxnpAXsLnR4xFpfzm94n1EdA1hnh89DVekQf9hVOreXr9k6vBftBv8Cw/iTRU/XNSEuIMHXjqj0uWZYddloH/zCdPXC5lb193JrbXi4OWjMKRAXyf/Ysiv3z90/mKA61CKYNl2CReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLm/MtBQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b2dd19681so18217f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 00:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764838006; x=1765442806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gWkHWPtGsg+Xm2BeS7xJzUOT5NNUY3njkadNQnGgQus=;
        b=BLm/MtBQGTNRwRJRFyRi5jVzfmwabYWe7ze/aX0XawQwmTs2pbl6/Agw3K4FaCFZ5A
         dUVraczCDXpr5qmSGRFX6XFvKfCwrucKb5agcLsbOKMhN5lRRUjxorKuZ2c9Chbd0HPT
         91/CcV7cPGw9hNS4FKURR5tbWLZxArGEPC1xnJ/QERxtZOgDc10SGWiA5f+evL9iC7VB
         fmZMhKysrnoyYuOue76usX4b4OVjr5nRSOyZNhm/Cd/c3stdkQnawYFSF5nMgqlmFKjC
         VwSYoz+sSyxOSx8xmWhR7Atep90L2LViUrMadS9XtGo6xzOPaFZYLLqKinDD1273XV/0
         fdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764838006; x=1765442806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWkHWPtGsg+Xm2BeS7xJzUOT5NNUY3njkadNQnGgQus=;
        b=gbCYW/hHee47ANfgbL+sbMDq6VRWtuxXd/4t89EAD9MUqkIZ7b+aMs2o7R4z0HbYmu
         F8wDbQIQxPH4vBL1g07WxkzJ9h/8dUuMLQ3yZwFXhMwM0UJVxjhGdGBChyyXk0Nz01aJ
         UOWDf+zmquqPF01SxN/iZxEYuBZ0XT9hPa0pHjEABB5xhKdMmhc8nsMYJ2M0SM7P+owP
         SGWGSag7CY8AFe11wXgYxXB9cO0QkU7a0Rqh1cm56q3JP7qAfyPdi/tcYqv04izHXP/V
         isqK3Srr6rhUzEvlUJ10cVBm/b408Al1c3cIINZ7+yKmz+2ar+2xyW1O35HCNnKTQkHb
         IGxg==
X-Forwarded-Encrypted: i=1; AJvYcCXW159fRRSZ5g5kWySHFbLzGnOoyCH6B/Ffc5C7o9BdAD5FFVIqrPENeEGV7cFOb81tJn4F/J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+6AAWlBvUCJrDo3eL0r/+/1K7ZZwtLAtrRvk8mr1shgDabYT
	xh6jdJ4DajCD8XhtLKRYmRw3KJkJDoZQV6NLf2trZQDEnBLRtqw5tT+n
X-Gm-Gg: ASbGnct928MUqzaJys5VoDDfZjMTwjV5puzSJWm7oMXWC1FDCXZO4HjjGOaDZfLKk+T
	cKNsoXfq34UxD3kaNlbnuaFa34B7HKbdNDJBxwW3ejtQwz+HNAD/nb9uCOM41FEdE5/sqeqJYkc
	vL0wIEgyjJgkfK92BCFs5BzNI6kNrHpf2YBPZmdZSgf3f3WIFaRdZ3LOYVq0fe1fBX2T/dDdIfb
	B2X7AZ/3TGks57TcTfhNDGqENzTg+ejogyps923tkcRkv1ZORxfYd9mgujvVHxj9TLCB6J2Iu16
	ZVIYSMZNwDYehynJ/Le4/f4gBuA47SzQ4TLlJbMMrYFWzqiYiZKR2GF4fD76dxUoei8erWc9ihS
	5+SaNwrvNCeJ8ZLk0dyUXBBjyORZCb+d2KX7RNCgsrlpKDPyMhjtDxWJIynPK5FumIcQewcp8ym
	lJKIY=
X-Google-Smtp-Source: AGHT+IFVTKZwo4vPlKApACc3OUpSIbjv0D99Exxz+P0II6Wh2U2WWgrCkhuhzseDjkfyaPOAoYhevA==
X-Received: by 2002:a5d:5f95:0:b0:42b:2c53:3ab9 with SMTP id ffacd0b85a97d-42f755890bamr2616039f8f.1.1764838005553;
        Thu, 04 Dec 2025 00:46:45 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:dbb2:245d:2cf5:21d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d2226d0sm1950044f8f.21.2025.12.04.00.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 00:46:44 -0800 (PST)
Date: Thu, 4 Dec 2025 10:46:41 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 0/3] net: dsa: initial support for MaxLinear
 MxL862xx switches
Message-ID: <20251204084641.fmha6irlfgkazsuw@skbuf>
References: <cover.1764717476.git.daniel@makrotopia.org>
 <20251203202605.t4bwihwscc4vkdzz@skbuf>
 <cover.1764717476.git.daniel@makrotopia.org>
 <20251203202605.t4bwihwscc4vkdzz@skbuf>
 <aTDGX5sUjaXzqRRn@makrotopia.org>
 <aTDGX5sUjaXzqRRn@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTDGX5sUjaXzqRRn@makrotopia.org>
 <aTDGX5sUjaXzqRRn@makrotopia.org>

On Wed, Dec 03, 2025 at 11:23:11PM +0000, Daniel Golle wrote:
> On Wed, Dec 03, 2025 at 10:26:05PM +0200, Vladimir Oltean wrote:
> > How does this switch architecture deal with SFP cages? I see the I2C
> > controllers aren't accessible through the MDIO relay protocol
> > implemented by the microcontroller. So I guess using the sfp-bus code
> > isn't going to be possible. The firmware manages the SFP cage and you
> > "just" have to read the USXGMII Status Register (reg 30.19) from the
> > host? How does that work out in practice?
> 
> In practise the I2C bus provided by the switch IC isn't used to connect
> an SFP cage when using the chip with DSA. Vendors (Adtran,
> BananaPi/Sinovoip) rather use an I2C bus of the SoC for that.
> I suppose it is useful when using the chip as standalone switch.
> 
> The firmware does provide some kind of limited access to the PCS, ie.
> status can be polled, interface mode can be set, autonegotiation can be
> enabled or disabled, and so on (but not as nice as we would like it to
> be). In that way, most SFP modules and external PHYs can be supported.
> 
> See
> 
> https://github.com/frank-w/BPI-Router-Linux/commit/c5f7a68e82fe20b9b37a60afd033b2364a8763d8
> 
> In general I don't get why all those layers of abstraction are actually
> needed when using a full-featured OS on the host -- it'd be much better
> to just have direct access to the register space of the switch than
> having to deal with that firmware API (the firmware can also provide a
> full web UI, SNMP, a CLI interface, ... -- imho more of an obstacle than
> a desirable feature when using this thing with DSA).

I'm not sure I understand either, but is it possible that since the base
Ethernet switch IP was already MDIO-based, Maxlinear wanted to offer a
single programming interface for the entire SoC as visible from an
external host, so that's why they continued exposing the other stuff
that they did in MMD 30 (temperature sensor, LEDs, etc) using this North
Korean guided tour kind of approach.

I am noting that there also seems no way to control the 'GPIO' pins as
GPIO from the external host. No way to set a direction or a value on
them. They seem to be "GPIO" only for the microcontroller.

It also seems possible that Maxlinear studied what other MDIO-based DSA
drivers offer, and they wanted to keep things in line with that,
(over)simplifying access to resources to keep things tidy when they are
all driven from DSA.

Although for other switches like the NXP SJA1110 (which has a SPI-to-AHB
bridge to gain direct access into sub-devices that are also mapped in the
microcontroller's address space) I try to push for the MFD model to be
used, for better scalability outside of drivers/net/dsa/, I think that
trying to horseshoe MFD on top of the MxL86252, at least in the way exposed
by the MDIO slave API implemented by its microcontroller, would be
overkill and a big a mistake.

But before I give my OK on your driver design choice, could you:
- confirm that the Zephyr-based MDIO slave firmware is the single
  external register access method for these chips in production? No
  register access or other special communication protocol with the
  microcontroller over Ethernet, no secret SPI-to-AHB bridge that can be
  used when there is no firmware running? The firmware image is maintained
  by Maxlinear, and their customers can't customize it, right?
- make a list of all the subsystems you foresee this chip will register
  itself with? Essentially how will it drive the sub-devices that the
  firmware does give it access to.

So what I'm trying to gauge is how complex this driver will be in its
fully developed form, to make sure it won't suffer from early underdesign
issues.

