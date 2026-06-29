Return-Path: <netdev+bounces-302486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id siFIArIdQmr80QkAu9opvQ
	(envelope-from <netdev+bounces-302486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:24:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 944426D6F75
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:24:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UoKebr6L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302486-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302486-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B5CF3021D36
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13C73C457D;
	Mon, 29 Jun 2026 07:18:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F73C4547
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:18:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717492; cv=none; b=cf5EyEq9udVOoO49llwgAZAtqiCaq3sW1yBZ72rPUYHS7tu0GV/G1se1w7pEnqeK0DvA8JmkZknB73silu6ZpBIjSWxCWAOJlyDrvwY/nn1RH9QWBT56bdjEhqN02yfLsTuX5MLeLhP758QopkCcZnpAjmTIIfwZOoZU7b2XUpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717492; c=relaxed/simple;
	bh=blN7kUYjZ29Lu9JrwtLJvpjU1Wy8lfqujnHxweqK+8c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyagHCB/h5ZeF/AFb3agkak2z/MeNNUW/WBHFLUo0JHZJv8XPxUi28SAHAP32XQj7zi/S15a8s2QD1cawOGdVSJEUYmJr5N0jKlcnZm24RjwJlggYWb4vvIzA16fl8tf88oSCJSiD81NOFXnspjDC23kVOBXF3zuC1UMmlZHUcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoKebr6L; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47122683cf3so593888f8f.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 00:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782717487; x=1783322287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BovyFstc80MYHmYyIZVG50kULX+1YfHlAuIHPTiI6jk=;
        b=UoKebr6L7g61S2ib1/fbHXwppvTCC1ASPVOG2gTWyXjTEcnJTr1ZZ1tFbyCkBNX28I
         ay9ZQqGMkmaKqeiUNL1Bpy+ituRDCsTu/jrTTful/YsQ2V4upAJBk1RlUzHnFE9F7iSy
         Js1x1pW7T8syZXAMpb57x+17cn2zG3kTfBddZIGdcHwvZHOrz7jgTy3bLZSPOWXhcwaN
         8zc6BJLiedrnyhgzyP+TwCMskBECBxC/d3Dw7oYdqOCuPPd1d84yvCVWdq6Lx6En/Rgt
         knW2V5g7iTNkQhlBWIoSQbBRyuezOLGGLv/URcDeJtqZD8CfouiGkrVZPu4z0tPrf6Ys
         VK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782717487; x=1783322287;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BovyFstc80MYHmYyIZVG50kULX+1YfHlAuIHPTiI6jk=;
        b=emp65J3++dweJDQRLMS/9Lxl89yMXD9pFkqghZCZ4Kex7flyRSlIP0/9WnmGglNwdD
         KMX5GX2RKRPJcWNc4fsXmPF8SvYXJ0ynM0PeH7DszHGLgfAkagY4J0QjcDT+bsVukjUk
         w4hgi4G3uxlyQVGx7aBJ/6mbg0I6msm8MkyI4MHyaL6f2Pnd6YCpxCW7RweKXnV/7UXS
         0U+/j2ijoiW+Gfrz9TrNgeSTC33k8cq3Uj+NDpXkRVXdE4xtie8dqK6Z1s7E27aUHoCr
         ZLWi034xnEz/jhOOqAHDT8IaSC7IQ87/az5nNPEgvpIjVK0sduc3dE5a/39hOQkaeZ92
         dU6g==
X-Forwarded-Encrypted: i=1; AHgh+RqpQi9D0mDmDEdQfu5bqpInTpY24AohvlBPL8bm2IjP76pxtRe3U/qeBSHeHhhE8NbXEDNJIX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZW8g6iHXMxNM09Xz4aCjHppwPF9w4aqImHebP/nGgulSihwo
	hKyK9LTBLEKDsVEbvo+16XYfuBRLeM/4kvLQqjmn/GwcR/4STr170gsS
X-Gm-Gg: AfdE7cl4NyhfrHPRUTFvRC+NU6eltX9b8Mq+n/oFtFjEL1eEgVu73bzyV0HUv22Ou/b
	0mSe8ahPQWTyNgvjBx3+PtMIOyMWPlfWsCSTEUzzdHXxpCDaMJCXKvK89/mmOtNHUljwUgRYN/y
	SPVPapQkiq8Fx+pK0SlTP/0Gx44WtRwJvyk8+QfQfVKStMTBJz1A5rXsRz3qFDunTwPji8X3P8U
	bM+bcQ7aq1vLJ0VO078HVDrLkxQxE8AauqOS6d+1+ryhi2596C7smmgT5khViZA0hIDuMlcxoT5
	LpCmDdk+3bU3ewdPqjZIfkIdixqHuWvKen/adO2Hi3KOC1TonqqOGbrgZVDkmTFEoRu9Y3ih7WS
	VQSzSTYenJSSF7pWnhvho/2cLoGyp7Sfg/WXE6a4E8brnyuQpS5msxzDElIqmVOcBXtGfgFkbhV
	y6888D0z++zjVyx5ECoLmwRDiFZIi99fWCK8pcRTRU8YUD94H8PBj5gcuC39f07iDoOS0=
X-Received: by 2002:a5d:6a48:0:b0:46d:32:3340 with SMTP id ffacd0b85a97d-46fb8d93892mr12284633f8f.36.1782717486707;
        Mon, 29 Jun 2026 00:18:06 -0700 (PDT)
Received: from Ansuel-XPS. (host-80-183-219-152.pool80183.interbusiness.it. [80.183.219.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47290ed4377sm13297042f8f.37.2026.06.29.00.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:18:05 -0700 (PDT)
Message-ID: <6a421c2d.1e0bfc4f.b2eb6.06fb@mx.google.com>
X-Google-Original-Message-ID: <akIcKbA8zsoalq-G@Ansuel-XPS.>
Date: Mon, 29 Jun 2026 09:18:01 +0200
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
Subject: Re: [RFC PATCH net-next v8 03/12] net: phylink: add
 phylink_release_pcs() to externally release a PCS
References: <20260618125752.1223-1-ansuelsmth@gmail.com>
 <20260618125752.1223-4-ansuelsmth@gmail.com>
 <a271385e-302d-45c7-a1df-aebd380b427b@bootlin.com>
 <6a3fc312.6161eb1e.3441bb.c0de@mx.google.com>
 <178defc6-8e60-4b0b-b3b0-f0f2a4003b68@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178defc6-8e60-4b0b-b3b0-f0f2a4003b68@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302486-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mx.google.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 944426D6F75

On Mon, Jun 29, 2026 at 09:04:49AM +0200, Maxime Chevallier wrote:
> Hi Christian,
> 
> On 6/27/26 14:33, Christian Marangi wrote:
> > On Thu, Jun 25, 2026 at 04:13:14PM +0200, Maxime Chevallier wrote:
> >> Hello Christian,
> >>
> >> On 6/18/26 14:57, Christian Marangi wrote:
> >>> Add phylink_release_pcs() to externally release a PCS from a phylink
> >>> instance. This can be used to handle case when a single PCS needs to be
> >>> removed and the phylink instance needs to be refreshed.
> >>>
> >>> On calling phylink_release_pcs(), the PCS will be removed from the
> >>> phylink internal PCS list and the phylink supported_interfaces value is
> >>> reparsed with the remaining PCS interfaces.
> >>>
> >>> Also a phylink resolve is triggered to handle the PCS removal.
> >>>
> >>> The flag force_major_config is set to make phylink resolve reconfigure
> >>> the interface (even if it didn't change).
> >>> This is needed to handle the special case when the current PCS used
> >>> by phylink is removed and a major_config is needed to propagae the
> >>> configuration change. With this option enabled we also force mac_config
> >>> even if the PHY link is not up for the in-band case.
> >>>
> >>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>> ---
> >>>  drivers/net/phy/phylink.c | 56 +++++++++++++++++++++++++++++++++++++++
> >>>  include/linux/phylink.h   |  2 ++
> >>>  2 files changed, 58 insertions(+)
> >>>
> >>> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> >>> index c38bcd43b8c8..064d6f5a06da 100644
> >>> --- a/drivers/net/phy/phylink.c
> >>> +++ b/drivers/net/phy/phylink.c
> >>> @@ -158,6 +158,8 @@ static const phy_interface_t phylink_sfp_interface_preference[] = {
> >>>  static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
> >>>  
> >>>  static void phylink_run_resolve(struct phylink *pl);
> >>> +static void phylink_link_down(struct phylink *pl);
> >>> +static void phylink_pcs_disable(struct phylink_pcs *pcs);
> >>>  
> >>>  /**
> >>>   * phylink_set_port_modes() - set the port type modes in the ethtool mask
> >>> @@ -918,6 +920,60 @@ static void phylink_resolve_an_pause(struct phylink_link_state *state)
> >>>  	}
> >>>  }
> >>>  
> >>> +/**
> >>> + * phylink_release_pcs - Removes a PCS from the phylink PCS available list
> >>> + * @pcs: a pointer to the phylink_pcs struct to be released
> >>> + *
> >>> + * This function release a PCS from the phylink PCS available list if
> >>> + * actually in use. It also refreshes the supported interfaces of the
> >>> + * phylink instance by copying the supported interfaces from the phylink
> >>> + * conf and merging the supported interfaces of the remaining available PCS
> >>> + * in the list and trigger a resolve.
> >>> + */
> >>> +void phylink_release_pcs(struct phylink_pcs *pcs)
> >>> +{
> >>> +	struct phylink *pl;
> >>> +
> >>> +	ASSERT_RTNL();
> >>> +
> >>> +	pl = pcs->phylink;
> >>> +	if (!pl)
> >>> +		return;
> >>> +
> >>> +	mutex_lock(&pl->state_mutex);
> >>> +
> >>> +	list_del(&pcs->list);
> >>> +	pcs->phylink = NULL;
> >>> +
> >>> +	/*
> >>> +	 * Check if we are removing the PCS currently
> >>> +	 * in use by phylink. If this is the case, tear down
> >>> +	 * the link, force phylink resolve to reconfigure the
> >>> +	 * interface mode, disable the current PCS and set the
> >>> +	 * phylink PCS to NULL.
> >>> +	 */
> >>> +	if (pl->pcs == pcs) {
> >>> +		phylink_link_down(pl);
> >>> +		phylink_pcs_disable(pl->pcs);
> >>> +
> >>> +		pl->force_major_config = true;
> >>> +		pl->pcs = NULL;
> >>> +	}
> >>> +
> >>> +	mutex_unlock(&pl->state_mutex);
> >>> +
> >>> +	/* Refresh supported interfaces */
> >>> +	phy_interface_copy(pl->supported_interfaces,
> >>> +			   pl->config->supported_interfaces);
> >>> +	list_for_each_entry(pcs, &pl->pcs_list, list)
> >>> +		phy_interface_or(pl->supported_interfaces,
> >>> +				 pl->supported_interfaces,
> >>> +				 pcs->supported_interfaces);
> >>
> >> I've given more thought to that 'supported_interfaces' thing. This
> >> patchset redefines the meaning of
> >>
> >>   pl->config->supported_interfaces
> >>
> >> Currently, it's filled by the MAC driver and means "Every interface
> >> we can support, including the ones provided by PCSs that we can use
> >> with this MAC".
> >>
> >> It now becomes "Every interface we support without needing a PCS", at
> >> least the way I understand that.
> >>
> > 
> > Wait but with the current code using the OR logic, it still follows
> > "Every interface we can support...". The modes that needs a PCS are
> > specificed with the pcs_interfaces mask in phylink_config.
> 
> you current code is correct, I was mostly concerned about the doc
> that goes along with it :)

Oh yep thanks, I will update also that entry. Also maybe check the .rst
introduced and tell me if something is confusing or badly described.

> 
> So in the end, we'd have something like (simplified):
> 
> pl->config.supported_interfaces = RGMII_xx | SGMII | 1000BaseX
> pl->config.pcs_interfaces = SGMII | 1000BaseX
> 
> pcs->supported_interface = SGMII| 1000BaseX
> 
> correct ?
> 

Correct. phylink_config describing that for SGMII and 1000BaseX a PCS is
required and the related PCS declaring support for those modes.

Code will skip searching for a PCS for RGMII.

> > 
> > The late add and release operates on the phylink supported_interfaces ONLY
> > when the MAC didn't specify support for it (by removing it as only the PCS
> > will declare support for it)
> > 
> > The confusion is present because everything is validated later on
> > major_config so those supported_interfaces are just an HINT that are later
> > verified with get_caps and with the pcs_validate OPs.
> > 
> > Adding the supported_interfaces to phylink is really to keep an original
> > reference of the value. This is to address a pattern I have notice where
> > the MAC driver always OR the interfaces with the one supported by the PCS.
> > (I remember it was pointed out by Russell)
> > 
> > But I'm more than open to discussion as this is something marginal to the
> > whole implementation, I'm also questioning if this OR is actually useful to
> > anything on the nth tought on this.
> > 
> > One thing that I notice is that parsing this early with AND might be
> > problematic at phylink_create, but I still have to evaluate that.
> > 
> > My take is that would be good to have some review also on the other logic
> > as I think I reached a point where Sashiko starts to comments on more or
> > less unreal problem.
> 
> True, TBH all the fwnode part is something I'm a bit less familiar with though
> so maybe someone else can browse through that.
> 
> FWIW, I've tested that whole series on a board that has "legacy" PCS board
> that has mvpp2 and 2 possible PCSs, and it seems to work fine so no regressions
> there :)
> 
> A side note with the "legacy" naming, I'd rather have it called "built-in" or
> something like that, I don't see a clear path to porting the existing code to
> fwnode without breaking DT compat, as it's likely we'll have to remove the PCS
> register ranges out of the MAC's range. 

I think also built-in might be confusing as a SoC might have a PCS built-in
but just as a separate device on a different register map.

A better description might be "externally-managed" but that is very long...

Also the use of fwnode and DT is just to reference them and use the normal
helper but the implementation is liberal on custom implementation for the
current code.

Everything is around the pcs_interface mask, num_possible_pcs and the
fill_available_pcs.

Nobody stops from implementing custom parser in fill_available_pcs and
return a PCS pointer created directly by the MAC. (In such case late and
release won't be needed as everything is present when phylink_create is
called)

On OpenWrt we migrated every SoC that used ""exotic"" pcs reference (Qcom,
Realtek, MTK, Airoha) but I don't have a board that used something like the
'pcs' property.

> 
> Thanks for this work anyway, this is great !
> 
> Maxime

-- 
	Ansuel

