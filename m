Return-Path: <netdev+bounces-148918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D429E36BD
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357D42818C7
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8604C1AF0BA;
	Wed,  4 Dec 2024 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AclPQvOS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C012B1AB6D8;
	Wed,  4 Dec 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304821; cv=none; b=AJonBSqHQtJ/uAaPVI67TiCb5dRfoWuOAI9bUjabXJWR9f5zOo2t7UxrtC1TVoeqWm+Q0w7bExtTovFvjfjgMwH2dOBYL4e8pmMVzFARUkFS6PS4/FFKixJgNSbQsh9S3tLVirNZ3xePINXjE3oxLZHbotnniKnvnPuDHPMcb1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304821; c=relaxed/simple;
	bh=RIZW/WfNZyrOeWlTB6eYY7isnBUW5eKR31/FdBoXGbU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caRmsv9JQ13G7l3qIM8c1rGSh1ckc29j+9GMg3RyrE8Z1SWy3476lwLqF+//kFav+tpOqebprVNKUAwAQbe01siAmtk8LjFIeOmM+0ZtmudtftCJqI3IqJHfJUJZLGjD/MOao275P3oZuwxzvB2BbE4Fe/8MIzbFMbtWzI+zo4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AclPQvOS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso57746875e9.1;
        Wed, 04 Dec 2024 01:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733304818; x=1733909618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0lKyObJsYIZ+s7QoNlqdjkApw/9Igt91fCr/HAkbPEo=;
        b=AclPQvOSnDs6Eot11Eslrl9aTk4FbseOfLmUcDa8q2pOZUNcMvyXl8cgfmfTbeV0q0
         atelsTER5fnWYUUMKdVrpOMtNzXGSvt6bOxMFIem0sf4YUctzs24xVJCbapdu3GtsIS1
         WZElSm6zE2DqNM1aw/LTkwIZfaoZGE0TOGVZsK78yvXRTQhVZKVoqDV3R2B8Y9XBRfHE
         mUnIEa7C2NS0/i2+2j/HzF2Mnf9PCdkRZfH1tUIcaQGrwFBfQU8yjyP6v7FJfm/gh9yi
         1sLFKl3O1jPiSN6naPziMv4YB7SEfhM/jmCr/PsXsRIMbCqgjWdxWIntVSsHbN3bUJzJ
         0Kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733304818; x=1733909618;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lKyObJsYIZ+s7QoNlqdjkApw/9Igt91fCr/HAkbPEo=;
        b=aEFhbmG1uhK1m38GN0pgpkFqhZujk/0b02PGlRvgGRSTZp8Rdb2LpY/hslDAshNRE4
         TigrTpRsgJcfseTmJCfSfT2n8xq7Ry1xvUFYl9kdBX53xVXZgvZlcxpbk7aq02gsq64j
         f6Fr5tnlGUx34C31jIeALhvlcxt/VixqwOTE60Gxgvysq2c8N3QbLlmMSAN1mp5y8WxE
         lnkoG0UhXmlpPXTZQcX55YNNAWUGQsBivInDjvJx6JqJlCkMBD7/D77nXSYXBeREshDH
         qYM7h6koOXHMKXtdTEkujeR2Y6surylHvMGiP8MfClAaIp271+ZhBJbOvUTJ8nIcqldq
         2O8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8TwlKdtzvvG5kgEpdDT2gaBLQk5bj7Gt61/IzFx7Ff2ZaiNM93HXUDG6X8IUTSkFThU9uVGHXVeUIdSn@vger.kernel.org, AJvYcCWcBj1BxEVOY1JNMpDosE0PUalNJ/Cd3YWo948bHYYX5zP4YoF7hsdHMKzXcQrOAzWxIbS2YDgLgoyF@vger.kernel.org, AJvYcCXPvH76srWyF7W3RVoNjcXQjmeOlhHBz+nS5I84HCcK9h9q4z+X46EILWe2DhrDWaSLB2pz0Js/@vger.kernel.org
X-Gm-Message-State: AOJu0YzFBhRirTWj3Xj6XQSpB/7YbGBkl1xe8QtXOB94kyawNd5e1nw4
	dV+FRcwi76iSXcED4yRhf5RnYgqDld/qVyH7fh0P2OdJwKb5e1PzI/SOZA==
X-Gm-Gg: ASbGncuS+3Ax7vax7IMtsIOhMB8Oqb82zAkgPw+JeOtc4/pNHQxP96dEdA7rhfZUgrQ
	64ZIrmwhWLNpy1Eu02/Ra3tXgvIi/uGz1muoXYOAIysiS3qnDYclYqdR14Zp7/Y4+oh8XawYm6e
	b+en3d1YCsgLF8OCerTJ3WN8pyHgBpiEal1WGe59UJatdTHDs/rIX1uVqSobB5rXfLuWpxYGOBr
	NvO6QKCB0XxnSN4vOrKbqmtobTE/WhSRqPLsDliF7EMqVwJ7KEG3OSW9n1Kf9bpLwpi4QFMK7JU
	ypXrhQ==
X-Google-Smtp-Source: AGHT+IH/s8dECPHycbZW4A5CqIvcbgj0fpA7rWE3Kg3D1zgk6Q5Z6J5agkhMd5wneZvBY5ksUhkntA==
X-Received: by 2002:a05:600c:3596:b0:431:50cb:2398 with SMTP id 5b1f17b1804b1-434d48291b5mr18322755e9.2.1733304817815;
        Wed, 04 Dec 2024 01:33:37 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b14csm18364155e9.2.2024.12.04.01.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 01:33:37 -0800 (PST)
Message-ID: <675021f1.050a0220.34c00a.3a0c@mx.google.com>
X-Google-Original-Message-ID: <Z1Ah7YFSAGnTlWfw@Ansuel-XPS.>
Date: Wed, 4 Dec 2024 10:33:33 +0100
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1Af3YaN3xjq_Gtb@shell.armlinux.org.uk>

On Wed, Dec 04, 2024 at 09:24:45AM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 04, 2024 at 10:14:31AM +0100, Christian Marangi wrote:
> > On Wed, Dec 04, 2024 at 10:09:22AM +0100, Maxime Chevallier wrote:
> > > > +	case 5:
> > > > +		phy_interface_set_rgmii(config->supported_interfaces);
> > > > +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> > > > +			  config->supported_interfaces);
> > > > +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > > > +			  config->supported_interfaces);
> > > > +		break;
> > > > +	}
> > > > +
> > > > +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > > > +				   MAC_10 | MAC_100 | MAC_1000FD;
> > > 
> > > For port 5, you may also add the MAC_2500FD capability as it supports
> > > 2500BASEX ?
> > > 
> > 
> > I didn't account for the CPU port that runs at 2.5. The LAN port are
> > only 1g. Will add or maybe add the 2500FD only for cpu port?
> > 
> > Maybe Russel can help in this?
> 
> *ll* please.

emabrassing... sorry.

> 
> Well, 2500BASE-X runs at 2.5G, so if MAC_2500FD isn't set in the mask,
> validation will fail for 2500BASE-X.
> 
> > > > +		case SPEED_5000:
> > > > +			reg |= AN8855_PMCR_FORCE_SPEED_5000;
> > > > +			break;
> > > 
> > > There's no mention of any mode that can give support for the 5000Mbps
> > > speed, is it a leftover from previous work on the driver ?
> > > 
> > 
> > Added 5000 as this is present in documentation bits but CPU can only go
> > up to 2.5. Should I drop it? Idea was to futureproof it since it really
> > seems they added these bits with the intention of having a newer switch
> > with more advanced ports.
> 
> Is there any mention of supporting interfaces faster than 2500BASE-X ?
>

In MAC Layer function description, they say:
- Support 10/100/1000/2500/5000 Mbps bit rates

So in theory it can support up to that speed.

-- 
	Ansuel

