Return-Path: <netdev+bounces-249970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C9D21C09
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5347302C22F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4288E38F93F;
	Wed, 14 Jan 2026 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc+9D2gZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93E38BF88
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768433001; cv=none; b=boGKLFxiW4eFO5dbZIbApi+4FnZkbtLlRd4T54ZCntsoEn5IhmEpJ7ZCDXh1idwegnO5jac9zDnpGynijtdz1NVFPKLPAPxPWtj/ZgX2BjGmFfs3pGfBJ61xkG4q6Brm89RveMHLx/PYs/mtRoLF0PWenW0DVPOxoqpbqkZGV5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768433001; c=relaxed/simple;
	bh=YiyUQfkSaIElDi7DWsUtoz83fczJ2veGj2vBak7VAek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En9BIp5R+y4MpaxTjDWwUOr5HG/BjYiJRgeSkjOGxknDNf21jwmQxei4a02TbPilS++8DA0JIfBI4qxYbKJsXzDmXUmaLb9hiwcNaEYfvJIyLlIMTxTlg/aJkSBp7GbgywN+2V8iVZtXYSkBf+khdt1xXDsHCSdPur1e7TX5VUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jc+9D2gZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b7d213fd6so50091a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 15:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768432985; x=1769037785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=szBzzvBv+sYCVdavoxbvL6YOzF442VfrPGrmySl0JY8=;
        b=Jc+9D2gZVZSJTtOpnfYUwYSx33J6Y+PdwWnyNX8yxYtpJ410L+/k661tr0pLyOckgI
         lJ06fiez7Fqz7LuoTd0THWbaUbk0JtKkK7A/O5M5qj1Fz8KwD6APkWNc4hVl8B7hr9iL
         aubya1DD5zlZ4ezzlV729dl13EA1ixHhQ5tIV9Qtl4H/BxujRVFzQ5wsXrA+ytkvgawf
         P/sk3QFNrM9zU2Ul2LzY1FfIyi2sf0W9NMNaL30J4ekAGf4YLAJ1+KuMNiH7mKD9U6dg
         m7LmcHYPafMCjeumsd9udN1SZyTFnUrgZJd5z9I6a0NzqXR+PoEMUtPbD3Rf5kJRvVfm
         YknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768432985; x=1769037785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szBzzvBv+sYCVdavoxbvL6YOzF442VfrPGrmySl0JY8=;
        b=hBtdWbTDs5FHxKrQtwdD4ah2TXypQ60PJ9LKfO7htp7RJ657Sv4TB4Rex0BCSgzK0P
         9hCOlIVgXVcSQjg5lBf9UNx5a8LvvHhfKgLoyZP+y3O3atR4naXZRBvjhU2WZku6Sggv
         qEILyIAV5FBiD726Vlg/5mT+NKG6JeYywcx7d99E40WP2xOtx9awrwr2lkObCeo2KG5+
         swo/AN41UDzbwfAvmBNS/MtkafR7GECUUwUsvWtpAj1xFko4EGHz1hQy/8DNTWCIFeeb
         MMX6dJX9lD/hPPpfh5AZHeAXmq5eNGP97APpKWD7wYkzgnR3fp06uoh/Mtdur0S3qvM8
         PHfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCaOT3EWk0znYKksPi5vgaSDITQn+Kzse3lM0EcnmYgLUFK8N2jB2aJlU/r0Jrw7O7LFXN9Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMGbkNTlsozQ/bRnDcrOb/rjYTLDqXVrmnue2YKe/Gm0E4HIz
	mvoKg2kcCQbBRW2IHLwCBAl2wD1x+MXoNdgUsIe21juWHxOCR9ulA/Hh
X-Gm-Gg: AY/fxX618qK91Fpty47oa3jHFi+QQTe2T63LSPvPc81vXhxTpekfcHpvwx2E8k/hWEZ
	aFgk1+PXtPh5hSV4nf0ub7vwaqavMu9yvHc+srg3NpDIz4gchQZyGb1EH5KxoDNYfJcJbfAD1K6
	x3MDlBCfyGmtDolOW/8zo1OXjwb0k8dbcIrPq5gC9FGp2X3lqHVbjZg61S3/6Qrsvuhnasjo+nJ
	2uSzz/BQSUe4FWeRMo2+0jFj6XFhXZeWIxnjKabbcBQ47fsFhNZdQY8ChXR206i4jwU+rzMhGcD
	7yPA7dgs5eYYcHNjkauryHw/sRLvx6yQ67DLJwB+Vt7KD1xqT+ijpF2ElaHZuk64HO9sSWtEKhf
	BVHPtDyPbV8KPUbo50aMVApO+oLpbiqunZft87VI+4IbbEp2UKBilSy85m86jHAZVjhTGBlk+X+
	qOuw==
X-Received: by 2002:a17:907:6e8a:b0:b87:3c3a:cb7e with SMTP id a640c23a62f3a-b8761296875mr195929266b.6.1768432984716;
        Wed, 14 Jan 2026 15:23:04 -0800 (PST)
Received: from skbuf ([2a02:2f04:d703:5400:d5b0:b41:b5b3:8c4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm734252566b.67.2026.01.14.15.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 15:23:02 -0800 (PST)
Date: Thu, 15 Jan 2026 01:22:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v5 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <20260114232259.2bvvijqa3rwrsgsu@skbuf>
References: <cover.1768225363.git.daniel@makrotopia.org>
 <cover.1768225363.git.daniel@makrotopia.org>
 <169e8a64d3f4db3139f2c85ac5164c52ca861156.1768225363.git.daniel@makrotopia.org>
 <169e8a64d3f4db3139f2c85ac5164c52ca861156.1768225363.git.daniel@makrotopia.org>
 <20260114225736.c7w3tpfol7bdc4so@skbuf>
 <aWgjnJEAV4M3WrcP@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWgjnJEAV4M3WrcP@makrotopia.org>

On Wed, Jan 14, 2026 at 11:15:40PM +0000, Daniel Golle wrote:
> On Thu, Jan 15, 2026 at 12:57:36AM +0200, Vladimir Oltean wrote:
> > On Mon, Jan 12, 2026 at 01:52:52PM +0000, Daniel Golle wrote:
> > > Add very basic DSA driver for MaxLinear's MxL862xx switches.
> > > 
> > > In contrast to previous MaxLinear switches the MxL862xx has a built-in
> > > processor that runs a sophisticated firmware based on Zephyr RTOS.
> > > Interaction between the host and the switch hence is organized using a
> > > software API of that firmware rather than accessing hardware registers
> > > directly.
> > > 
> > > Add descriptions of the most basic firmware API calls to access the
> > > built-in MDIO bus hosting the 2.5GE PHYs, basic port control as well as
> > > setting up the CPU port.
> > > 
> > > Implement a very basic DSA driver using that API which is sufficient to
> > > get packets flowing between the user ports and the CPU port.
> > > 
> > > The firmware offers all features one would expect from a modern switch
> > > hardware, they will be added one by one in follow-up patch series.
> > > 
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > > v5:
> > >  * output warning in .setup regarding unknown pre-configuration
> > >  * add comment explaining why CFGGET is used in reset function
> > > 
> > > RFC v4:
> > >  * poll switch readiness after reset
> > >  * implement driver shutdown
> > >  * added port_fast_aging API call and driver op
> > >  * unified port setup in new .port_setup op
> > >  * improve comment explaining special handlign for unaligned API read
> > >  * various typos
> > > 
> > > RFC v3:
> > >  * fix return value being uninitialized on error in mxl862xx_api_wrap()
> > >  * add missing descrition in kerneldoc comment of
> > >    struct mxl862xx_ss_sp_tag
> > > 
> > > RFC v2:
> > >  * make use of struct mdio_device
> > >  * add phylink_mac_ops stubs
> > >  * drop leftover nonsense from mxl862xx_phylink_get_caps()
> > >  * use __le32 instead of enum types in over-the-wire structs
> > >  * use existing MDIO_* macros whenever possible
> > >  * simplify API constants to be more readable
> > >  * use readx_poll_timeout instead of open-coding poll timeout loop
> > >  * add mxl862xx_reg_read() and mxl862xx_reg_write() helpers
> > >  * demystify error codes returned by the firmware
> > >  * add #defines for mxl862xx_ss_sp_tag member values
> > >  * move reset to dedicated function, clarify magic number being the
> > >    reset command ID
> > > 
> > >  MAINTAINERS                              |   1 +
> > >  drivers/net/dsa/Kconfig                  |   2 +
> > >  drivers/net/dsa/Makefile                 |   1 +
> > >  drivers/net/dsa/mxl862xx/Kconfig         |  12 +
> > >  drivers/net/dsa/mxl862xx/Makefile        |   3 +
> > >  drivers/net/dsa/mxl862xx/mxl862xx-api.h  | 177 +++++++++
> > >  drivers/net/dsa/mxl862xx/mxl862xx-cmd.h  |  32 ++
> > >  drivers/net/dsa/mxl862xx/mxl862xx-host.c | 230 ++++++++++++
> > >  drivers/net/dsa/mxl862xx/mxl862xx-host.h |   5 +
> > >  drivers/net/dsa/mxl862xx/mxl862xx.c      | 433 +++++++++++++++++++++++
> > >  drivers/net/dsa/mxl862xx/mxl862xx.h      |  24 ++
> > >  11 files changed, 920 insertions(+)
> > >  create mode 100644 drivers/net/dsa/mxl862xx/Kconfig
> > >  create mode 100644 drivers/net/dsa/mxl862xx/Makefile
> > >  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-api.h
> > >  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
> > >  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.c
> > >  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.h
> > >  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.c
> > >  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.h
> > > 
> > > +static int mxl862xx_setup(struct dsa_switch *ds)
> > > +{
> > > +	struct mxl862xx_priv *priv = ds->priv;
> > > +	int ret;
> > > +
> > > +	ret = mxl862xx_reset(priv);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = mxl862xx_wait_ready(ds);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = mxl862xx_setup_mdio(ds);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	dev_warn(ds->dev, "Unknown switch pre-configuration, ports may be bridged!\n");
> > 
> > Nack. User space needs to be in control of the forwarding domain of the
> > ports, and isolating user ports is the bare minimum requirement,
> > otherwise you cannot even connect the ports of this device to a switch
> > without creating L2 loops.
> > 
> > It seems that it is too early for this switch to be supported by
> > mainline. Maybe in staging...
> 
> In order to avoid the detour via staging, from my perspective there are two
> ways to go from here:
> 
> a) Keep nagging MaxLinear to provide a switch firmware with an additional
> firmware command which flushes the pre-configuration and puts the switch
> in a well-defined state (all ports isolated, learning disabled) for DSA.
> 
> b) Extend the patch to cover all the API calls needed to do this
> manually (more than double of LoC).
> 
> Obviously a) would be better for me and you, but MaxLinear indicated they
> prefer not to release an new firmware adding that feature at this point.
> 
> b) would allow me to proceed right away, but it would burden reviewers
> with a rather huge patch for initial support for this switch.
> For the sake of making review more easy I'd prefer to still keep this
> in a series of not terribly huge patches rather than a single patch
> which immediately brings in everything (ie. have bridge and bridgeport
> configuration in one patch, FDB access in the next, ...). Would a
> series adding everything needed to end up with isolated ports be
> acceptable?
> 
> Please let me know what you think.

Do you have the additional work required to isolate user ports prepared
on some branch that can be pre-reviewed? I'm not sure that I have all
information to make an informed comment.

