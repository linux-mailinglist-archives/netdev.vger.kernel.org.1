Return-Path: <netdev+bounces-299482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id anKcCtAJMGovMQUAu9opvQ
	(envelope-from <netdev+bounces-299482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:18:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D01CC6870B2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:18:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=T4ffCKJX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299482-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299482-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48D0F300CE9A
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104B93ED135;
	Mon, 15 Jun 2026 14:18:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562F3F9F39
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:18:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533130; cv=none; b=APm1SWEYYJ/6so1f256v+ftmdv32O7T7XwKsNmDgBd4cIuzswI19J9snSTNEvWbb9L9OmP0/7HJr/kROhEZl3bvfDMheTaaD7WiGw5IthsBEf+ZZNLrTsF6r0aQJM7poya1Qo0rJFoYoEgKdkfowvhK635fOv4z6dwjaORMYa6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533130; c=relaxed/simple;
	bh=taTuI/uTOMXjIXPXu667WK4H5vUawgRfjbE0mglsoXM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzNB2zzX09SC0iySxEh0RGaNIy5aMwHdd6zMZ1Zc352uobi9Qc2Ha5K+26wbFB0dX4sOYRaOgiA7wbcKmFIujIut/xS9TbeYmV6aF5iPh4owJxxpD9vCHO+OwWgSc4LdZlSectPEUZ6T9bdwjrIVVvbzy1NbqcVf66j3hWVvL5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4ffCKJX; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so20451565e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533123; x=1782137923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hkIb+b4xA4Dtv3ljZrlwMo9RpQWTNWYQCjFJM6rj18U=;
        b=T4ffCKJXecs/GEA3jL3SD9gnWfr2vZCj6s+uKJMMshsFFDI+ko8XEr6+TbrR8m3i5w
         YV/D8ZbqmYPpF8gP4XFZ50gbvntssElJc3kN83H/4Vs7DK0Srnk9CzW+6MVRfPz4Kbzq
         avGNXPh8FXrGXCoRwi/vCEP/+kSUUrwkwejWyKqyhvKfrVeLm4xGZL5jUwRvDBfbIZYk
         tL5CaCze5IdjLR9/VmmIpv1mzMGGg7wbZk7Vpam05Y5OlPp//KEFH+BsI7Af/xf+sxf0
         2AhsWkNBEkbr17ObfDRHyZMX7Ynul1uB5Z6S5jQGFmPApFw+qbZYV1xjjLABhsHL53qp
         Ltpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533123; x=1782137923;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkIb+b4xA4Dtv3ljZrlwMo9RpQWTNWYQCjFJM6rj18U=;
        b=oAqN9ZKzBWASE7zEdCbJtGU0s7hDCAYuAd4trgkTVHDCF6YD8JcVcU4cpNqHKlpCN0
         RQ1n+wUFugygSSU8aKNsB1hxzN6u4nFiF9JASIIFzMnYn3pZYhiw43mNO5yoVL7juMQF
         CfgSMvzyAOLgEUOK8vMYxXJaeSRZQhNZeUgGb9e9NQp/jXQ0gtfSc41HU8psBnXG8Dx5
         N6ShaPjr3g50a3kh2Q48QqaYpQA5ruqmxzqR2w9Qhg/pMZI6ufzPd4YKs3dT0rP1/wsj
         gEEan3QNEvke0UW0vBT0Ni5Hc42BxrX0VTsklpmJW4VbPEuyG9F2j8484SCckinL2Uj4
         IftA==
X-Forwarded-Encrypted: i=1; AFNElJ9vONE7KfXmRnfv6P65VGyGfC5nDlFC+YZb9MJ+T86csuDwWG9YrkO9qymh7kguhkw+20Yf9cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKtoTT3/+hf0My6DE62pwG/tD/NqhavoZ7yBdaYPKrBPzX4u5
	85FsQm8456tA5LS+Jk+kf/EGLeWhjdIIpxIyeVSzMgBmOOwvhWygNDp2
X-Gm-Gg: Acq92OE0whTHH7QETrQhuQ5aWDrazhGWqyKoj/GVKiNtNDzhbwPaCuHcV1CdNoOhF9b
	YnF67cmv8mnpjMPHo/r5La8R5I1X/lh+sqewUWe22bUNxy/sQg3cHg4ZKXeaXXi6+Yo7XWw6/qw
	Cg8MDSx60pGsFDbV/aonypi9VyAAIjIIbmHdqvh/2glB/5+yHqsyZDav/ECTRIya7Vv3yy5unjd
	RnmfyrXY2fW2L9mApIbQh1JD3vw344DGx39UkSHJYDdjJgGRK9kYYMyzaKWaZakMLIp48Lq+iJg
	C/QRche6p+CBPPVesPNXzm1mNopguylOVOPDPOOkQHBbUETbsLyXS7EfOz0wevt6GDiUZ1zD3xY
	043FUtm9oq4w+kveRe4oFbfhUIi6loeiRafrfQ03/cGds2U2hyqEiVAD+Efu9jJGSTAnPduj7Jz
	F2XLhdz+yr8usdHUwNn9NCyw3Cn/zmhXymhnmHsXqVbNliXZ3ZsSnPzA==
X-Received: by 2002:a05:600c:3153:b0:490:e5c1:b897 with SMTP id 5b1f17b1804b1-490ec4fe7c2mr195111285e9.20.1781533122746;
        Mon, 15 Jun 2026 07:18:42 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202edec6sm283566035e9.3.2026.06.15.07.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:18:42 -0700 (PDT)
Message-ID: <6a3009c2.561280e1.2acd9f.2f06@mx.google.com>
X-Google-Original-Message-ID: <ajAJvXT9R7UrMqQA@Ansuel-XPS.>
Date: Mon, 15 Jun 2026 16:18:37 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v7 01/12] net: phylink: keep and use MAC
 supported_interfaces in phylink struct
References: <20260615122950.22281-1-ansuelsmth@gmail.com>
 <20260615122950.22281-2-ansuelsmth@gmail.com>
 <371a1df7-084c-4431-bd00-0045298e3212@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <371a1df7-084c-4431-bd00-0045298e3212@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299482-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mx.google.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D01CC6870B2

On Mon, Jun 15, 2026 at 03:33:34PM +0200, Maxime Chevallier wrote:
> Hello Christian,
> 
> On 6/15/26 14:29, Christian Marangi wrote:
> > Add in phylink struct a copy of supported_interfaces from phylink_config
> > and make use of that instead of relying on phylink_config value.
> > 
> > This in preparation for support of PCS handling internally to phylink
> > where a PCS can be removed or added after the phylink is created and we
> > need both a reference of the supported_interfaces value from
> > phylink_config and an internal value that can be updated with the new
> > PCS info.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/phy/phylink.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 087ac63f9193..4d59c0dd78db 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -60,6 +60,11 @@ struct phylink {
> >  	/* The link configuration settings */
> >  	struct phylink_link_state link_config;
> >  
> > +	/* What interface are supported by the current link.
> > +	 * Can change on removal or addition of new PCS.
> > +	 */
> > +	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
> 
> Can you clarify a bit what you mean here ? Is that the combination of the
> interfaces the MAC supports AND the currently in-use PCS ?
> 

Combination of interface the MAC supports and the currently attached PCS
(not the current one in use)

The fact that it can change is due to the fact that PCS can be attached
later and supported_interfaces can be updated accordingly.

-- 
	Ansuel

