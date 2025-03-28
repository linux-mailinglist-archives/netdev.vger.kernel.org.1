Return-Path: <netdev+bounces-178048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 997E7A741F8
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 02:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE747A7CBB
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316E17BD6;
	Fri, 28 Mar 2025 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcrJmwEE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B145A93D;
	Fri, 28 Mar 2025 01:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743124565; cv=none; b=W1GvB8J9FpM1GHyyH/7lVUIJ7ptzRwHOq8jPfQ6if04zOqA1yfXy5C/qqZCBZOk/4Ncpm9GOr8TfZEAjnQaPy8Uq9XWVTMto3GsvZu+Gm5BIVKafrCHKwisnW9o9CCYDikP/slOCc0JLrRsb/WfDN+hBbcBdpbhB5cw0iopz9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743124565; c=relaxed/simple;
	bh=mDz+9brZysZquTfm2+M9O5hGiHuIMLDuXcet9vHSdPs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LuMfL72DRU1+FzE0KDkyT8NHKPaaIjoGIKinQO95o8LGdEefrwl8dOdUtWi6I6uJfUjA60oAGRIFB2xNeRcjwNDbWn0+31jURq0IZdlS1lrjqLBVwmbWugUHP6V/EuuDePIBhSUG/8+Wl1u3rO2rm3bDWamyT2MU6l4rC0mW8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcrJmwEE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223fd89d036so38062815ad.1;
        Thu, 27 Mar 2025 18:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743124563; x=1743729363; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UktKUUVgFXfpNQzRoxlwygzcOcwN5oFlxC5sDzVSosE=;
        b=QcrJmwEETl8QbWIrlSsF5SWru9XfvybjYAZmbWUYmmNQkeDxbiGrKLIqOSfgUt1j0T
         vjpXiSnvyoChy5pQiC2n+JRjrnSACm2o+Yxejvdy1pJdPg5ogo2ADf1qkktDw+IWPZJq
         1yT+MiVq2btCNn8MLryG+sDCSQg3lxdWS4gKJcaERZRZQv4H7xUjp74p0hvPeqr/JMAP
         m6/NY7ZUGLDrtvmJQnVzxTupyJj0L0hL7nYS2mKzePTHvOApz5EMrq5g3HzR8QghAgrz
         KlWkdsGVjGwnkNB9UkDIVaFpVB4Tb1RhW9K9UugE+HyRb/AlqvH4BtvCrwK1kOcV+wLU
         SBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743124563; x=1743729363;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UktKUUVgFXfpNQzRoxlwygzcOcwN5oFlxC5sDzVSosE=;
        b=ZoCORwpWucjNUrwNNuGPDPZ6IXJjbxLSEzYskVfoYxCve0/41bwlpjYLEX68Trkb0+
         0eb0IcXFQOToPnIGd2uWGP2p5IaQb1XEQm4JKt+gf5Z9rKDqruv2Bgx7GN+N5MA9A23s
         Ra3NeofnDUq+peGYb+f9LUpl5XZkJDmiY/yS+8//zk5yZ7/f0Mvd5ZATT6wy8XKPHlQM
         L7+utv0HphhZLuomexs22ILmNqlUxH2t9avUyAAXhoUfTtPkbLSZuAv1xkAjDTgoNXxF
         Z3uKF2JL631YQbNNne1u918hvhqM2RnvaMoaiYTS2qLLKgqK4tndXilTdLEKLO3VT9HV
         RwLg==
X-Forwarded-Encrypted: i=1; AJvYcCWhusT1xj4mv0zjoBNESjsdGG8OtQGx+t+8VyqQcuF60vAv7hYCb+PlJ14p8qtGAun/hpY50Nq9/cPJ3k8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaAnAwX9vPQzeky6IB/v3p+jc5cfkU1J7H6K6nC2kQPNfcoo/v
	R0qsaZwHd6eFeTo32TBt8teJTuS9eqtQ0GV+NKq8VlT4mU8QNxMy
X-Gm-Gg: ASbGncsRS79pKMNI/ANkqozXZY8ArC2n2lb989rZDL03iCKw4KBvthLdtCKVw7H+km7
	v1VC1mQ3x0Y6dTAiBOzB4WbhrgwXnNhrqFDdaUVQ3AvdSwEfJJtG6at/JxfjCYrlModQdqofJ7q
	jO5g7a/ugqninNy1Z/bHptlBluB7WN3a29974XPbA+i0uB1j0TLH5pZf/3abAsOnD6vhUvvkInp
	aE2C/5PVb/l3AzmNRvD88kj9eEvH3NBFPO3c86xy49kS3d9KvPB3EmTEinM1CrbljYINV1HVxfJ
	T6MGdCRYzQT1lEevJw0a/gtqcKoNG/iUjjfIvypYa1hlKNUm2M8ZPfDf6TXa/1FQMJpBn4Dru6d
	SxyeOCX+iky9knfawIQcTSMEEGgfXt24/aWc=
X-Google-Smtp-Source: AGHT+IFsa4ooa9WyM+hXEZ/VKN3czMhSBprfgrFtEeIEImHL9Em/a0EmMkNmL2FmVwvZNwNZ3kwIyg==
X-Received: by 2002:a05:6a00:4fc1:b0:736:5c8e:bab8 with SMTP id d2e1a72fcca58-73960e10bdemr8365322b3a.3.1743124563325;
        Thu, 27 Mar 2025 18:16:03 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73970def6d9sm549308b3a.10.2025.03.27.18.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 18:16:02 -0700 (PDT)
Message-ID: <8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net, 
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>, Russell
 King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,  =?ISO-8859-1?Q?K=F6ry?=
 Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>
Date: Thu, 27 Mar 2025 18:16:00 -0700
In-Reply-To: <20250307173611.129125-10-maxime.chevallier@bootlin.com>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
	 <20250307173611.129125-10-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-07 at 18:36 +0100, Maxime Chevallier wrote:
> When phylink creates a fixed-link configuration, it finds a matching
> linkmode to set as the advertised, lp_advertising and supported modes
> based on the speed and duplex of the fixed link.
>=20
> Use the newly introduced phy_caps_lookup to get these modes instead of
> phy_lookup_settings(). This has the side effect that the matched
> settings and configured linkmodes may now contain several linkmodes (the
> intersection of supported linkmodes from the phylink settings and the
> linkmodes that match speed/duplex) instead of the one from
> phy_lookup_settings().
>=20
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/phylink.c | 44 +++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index cf9f019382ad..8e2b7d647a92 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -802,12 +802,26 @@ static int phylink_validate(struct phylink *pl, uns=
igned long *supported,
>  	return phylink_validate_mac_and_pcs(pl, supported, state);
>  }
> =20
> +static void phylink_fill_fixedlink_supported(unsigned long *supported)
> +{
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported);
> +}
> +

Any chance we can go with a different route here than just locking
fixed mode to being only for BaseT configurations?

I am currently working on getting the fbnic driver up and running and I
am using fixed-link mode as a crutch until I can finish up enabling
QSFP module support for phylink and this just knocked out the supported
link modes as I was using 25CR, 50CR, 50CR2, and 100CR2.

Seems like this should really be something handled by some sort of
validation function rather than just forcing all devices using fixed
link to assume that they are BaseT. I know in our direct attached
copper case we aren't running autoneg so that plan was to use fixed
link until we can add more flexibility by getting QSFP support going.

