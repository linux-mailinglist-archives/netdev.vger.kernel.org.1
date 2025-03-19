Return-Path: <netdev+bounces-176225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3DAA6969C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196BA19C56DA
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622791F4164;
	Wed, 19 Mar 2025 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCA/lPHK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C0D1DE884;
	Wed, 19 Mar 2025 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405729; cv=none; b=ZAuinyce2NxZAJhz3qy5o+8zBm355waz9KOrZNiUxSyu+LEmD6KxnWTJ7gvVwXDUDrvKpyIu72gtB3SoN3g6IOWhBOnGLXMP4pr+OGim54Lmpowt1j0hnJYVZLg+5RVj0qZYBdQwAHRAQNocVsKavhTZFD9g533Ut9Y+tKy6pGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405729; c=relaxed/simple;
	bh=jnqO2p2Qq7nw2JzfcwEWR2c/dtS2CGK7pf/si8gXck4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWFQxp6sBBFuQzs+wh0CwkxhhYIQzgIflfOd2DeU+pzfG2CAczy261vAI53lQctxH1akfJsNKSHbr4JuUabOo0duGavmLvDpps3VlFuLjIU45vsXM24TpYbeLmAint7jLvyQAbCUJOGUKY3Zh0bWgt3MC45tFBJCKE/qk/KRXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCA/lPHK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43690d4605dso33850125e9.0;
        Wed, 19 Mar 2025 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742405725; x=1743010525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kMwj7frU9C+JMewVysLEIPKtFhd/+J0/bkuB6R7eySo=;
        b=LCA/lPHK6C9dEcmY/entdx2WmESdlFP2AT9f60UKrQGnhHDd+EcGKSDW7rGFnAX42a
         Q8eeVmAQkpeRiJL2ek8H63tUGMZczmnfv0ijvCDI4BGOlpIR9PtIndQIh+LXqVJ7VKd4
         EE96anVrwfJRkixKJNUibY5BS+09De3o/jRfBK3tVnRM/22mWtfmYkvB5C6lMSLbPumL
         u3Uo0DZkEyfRGHV1G4aAX/FSpcX7kKlfJb7yzh02CvkmBbKBd0bUTiGvvdW7DSRydP9W
         wi+lOd9Lp53Bn8ObDXJ4mVuPI2AFzqYiC6MheeigOJdZf5zdav8wjE3qrtawsf54S5Wu
         BEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742405725; x=1743010525;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMwj7frU9C+JMewVysLEIPKtFhd/+J0/bkuB6R7eySo=;
        b=u1HnLD99t5SaacDtpeVmes0sJsQy0mgUiGzkvXIzq0WOrxxOdQ8mY0pmvSrluHlVDm
         0aLb86JCimjqa/tvKzHZ3Kp92JVD49qgWNvm7sk0JgR1ydaLwlbp0ZciQ4/32rCt1Kq/
         nTfH4M8gQtbNaGt0kD37bdU3rZbYzMML4zAB6Fla+wpub/Aaz7nP7xY0yFL/4kKrTwXF
         mE7hPXLGtjAe9hNRIWjGXoMI1FzutrYwejMfscj+iWlDMDdaBiVq/7nbXZqIZBGI7Qip
         Xr0VVYsK00Czoc0DNytP+ENyC75TOB3FUKRfQAwGDFdDalBxkAM4AysfAr8ReVK9KeSG
         12sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr4oed9n7kwGtOr7TEuHl0E2Zgo6ZI9fOQG657/l9Q6LyCILJ0sGFi8bG/vwT4q/2ZxpzqRnxA2tiv@vger.kernel.org, AJvYcCW4suQZoJJatVXyQlc8CQcWgokq7hjOa2iDC0TNApRYHZJM1/1gqqWARr94g3VB8VI0jdJkz8a+@vger.kernel.org, AJvYcCWhDoI9lfiWEVLE/I/uR/MEOJFBU5d/rK/boyB+B0595FCGSVxNrEi8qfyLWGd1g+t5fP59cVWRW09qs6NF@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdPIJCPDYpeoaT7uqYD/p4tlpL4PEFC0mpb7ULV6NF/QRICt2
	0T/u0/DDY8LqisShjGlAX4ql7Sivo2MBscUkDyD+NnVQzfzjJtsv
X-Gm-Gg: ASbGnctKtrZAOkLoEKGie9zHYOwx/Tby4E69bsvK5mY82KQ5110eeCieKKerfghfhwi
	57Rn5MoD07/kIv4+T/Lvsj1KAIl/2kjyNobh4ypZ6gCe1d80ZKj76TendnozHb5aCTvHwjyZSVj
	YZ+pXK1Cy7JeDgH7WfXI3xUa9HbkBUK6sApio1ur0ZE/vVFJaeyf1PuHYqfPPe8nNYQcXqDmlX/
	MOa40pt/AgM+RjRcBlV468off2FbQ1j5//naUmnhN/Ng9g47j6QPGqNaIqQMjdrHfnMhD/QBiyI
	tAizAiB03XVpLXbNXolz8YDw5lY+MubuW4H9PSIqmBwpuxPdAZfpTWw4WoPpsIyUBz/Ep06i5zO
	d
X-Google-Smtp-Source: AGHT+IFrgenJdaeJ2uhjAO7hZAVmm7ASxKzTrlK8JQAI4IsgIx6L8BW3JZsCpjY8dERlJUXmVhWYbQ==
X-Received: by 2002:a05:600c:1c23:b0:43c:f513:958a with SMTP id 5b1f17b1804b1-43d43798dd6mr29055515e9.13.1742405725133;
        Wed, 19 Mar 2025 10:35:25 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35f7sm21761885f8f.13.2025.03.19.10.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:35:24 -0700 (PDT)
Message-ID: <67db005c.df0a0220.f7398.ba6b@mx.google.com>
X-Google-Original-Message-ID: <Z9sAWbQniEbYDIPv@Ansuel-XPS.>
Date: Wed, 19 Mar 2025 18:35:21 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 3/6] net: phylink: Correctly handle PCS probe
 defer from PCS provider
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-4-ansuelsmth@gmail.com>
 <Z9rplhTelXb-oZdC@shell.armlinux.org.uk>
 <67daee6c.050a0220.31556f.dd73@mx.google.com>
 <Z9r4unqsYJkLl4fn@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9r4unqsYJkLl4fn@shell.armlinux.org.uk>

On Wed, Mar 19, 2025 at 05:02:50PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 19, 2025 at 05:18:50PM +0100, Christian Marangi wrote:
> > > >  	linkmode_fill(pl->supported);
> > > >  	linkmode_copy(pl->link_config.advertising, pl->supported);
> > > > -	phylink_validate(pl, pl->supported, &pl->link_config);
> > > > +	ret = phylink_validate(pl, pl->supported, &pl->link_config);
> > > > +	/* The PCS might not available at the time phylink_create
> > > > +	 * is called. Check this and communicate to the MAC driver
> > > > +	 * that probe should be retried later.
> > > > +	 *
> > > > +	 * Notice that this can only happen in probe stage and PCS
> > > > +	 * is expected to be avaialble in phylink_major_config.
> > > > +	 */
> > > > +	if (ret == -EPROBE_DEFER) {
> > > > +		kfree(pl);
> > > > +		return ERR_PTR(ret);
> > > > +	}
> > > 
> > > This does not solve the problem - what if the interface mode is
> > > currently not one that requires a PCS that may not yet be probed?
> > 
> > Mhhh but what are the actual real world scenario for this? If a MAC
> > needs a dedicated PCS to handle multiple mode then it will probably
> > follow this new implementation and register as a provider.
> > 
> > An option to handle your corner case might be an OP that wait for each
> > supported interface by the MAC and make sure there is a possible PCS for
> > it. And Ideally place it in the codeflow of validate_pcs ?
> 
> I think you've fallen in to the trap of the stupid drivers that
> implement mac_select_pcs() as:
> 
> static struct phylink_pcs *foo_mac_select_pcs(struct phylink_config *config,
> 					      phy_interface_t interface)
> {
> 	struct foo_private *priv = phylink_to_foo(config);
> 
> 	return priv->pcs;
> }
> 
> but what drivers can (and should) be doing is looking at the interface
> argument, and working out which interface to return.
> 
> Phylink is not designed to be single interface mode, single PCS driver
> despite what many MAC drivers do. Checking the phylink_validate()
> return code doesn't mean that all PCS exist for the MAC.
>
> > > I don't like the idea that mac_select_pcs() might be doing a complex
> > > lookup - that could make scanning the interface modes (as
> > > phylink_validate_mask() does) quite slow and unreliable, and phylink
> > > currently assumes that a PCS that is validated as present will remain
> > > present.
> > 
> > The assumption "will remain present" is already very fragile with the
> > current PCS so I feel this should be changed or improved. Honestly every
> > PCS currently implemented can be removed and phylink will stay in an
> > undefined state.
> 
> The fragility is because of the way networking works - there's nothing
> phylink can do about this.
> 
> I take issue with "every PCS currently implemented" because it's
> actually not a correct statement.
> 
> XPCS as used by stmmac does not fall into this.
> The PCS used by mvneta and mvpp2 do not fall into this.
> The PCS used by the Marvell DSA driver do not fall into this.
> 
> It's only relatively recently with pcs-lynx and others that people have
> wanted them to be separate driver-model devices that this problem has
> occurred, and I've been pushing back on it saying we need to find a
> proper solution to it. I really haven't liked that we've merged drivers
> that cause this fragility without addressing that fragility.
> 
> I've got to the point where I'm now saying no to new drivers that fail
> to address this, so we're at a crunch time when it needs to be
> addressed.
> 
> We need to think about how to get around this fragility. The need to
> pre-validate the link modes comes from the netdev ethtool user
> interface itself - the need to tell userspace what link modes can be
> supported _before_ they get used. This API hasn't been designed with
> the idea that parts of a netdev might vanish at any particular time.
>
> > > If it goes away by the time phylink_major_config() is called, then we
> > > leave the phylink state no longer reflecting how the hardware is
> > > programmed, but we still continue to call mac_link_up() - which should
> > > probably be fixed.
> > 
> > Again, the idea to prevent these kind of chicken-egg problem is to
> > enforce correct removal on the PCS driver side.
> > 
> > > Given that netdev is severely backlogged, I'm not inclined to add to
> > > the netdev maintainers workloads by trying to fix this until after
> > > the merge window - it looks like they're at least one week behind.
> > > Consequently, I'm expecting that most patches that have been
> > > submitted during this week will be dropped from patchwork, which
> > > means submitting patches this week is likely not useful.
> > 
> > Ok I will send next revision as RFC to not increase the "load" but IMHO
> > it's worth to discuss this... I really feel we need to fix the PCS
> > situation ASAP or more driver will come. (there are already 3 in queue
> > as stressed in the cover letter)
> 
> Yes, we do need to fix it, but we need to recognise _all_ the issues
> it creates by doing this, and how we handle it properly.
> 
> Right now, it's up to the MAC driver to get all the PCS it needs
> during its probe function, and *not* in the mac_select_pcs() method
> which has no way to propagate an error to anywhere sensible that
> could handle an EPROBE_DEFER response.
> 
> My thoughts are that if a PCS goes away after a MAC driver has "got"
> it, then:
> 
> 1. we need to recognise that those PHY interfaces and/or link modes
>    are no longer available.
> 2. if the PCS was in-use, then the link needs to be taken down at
>    minimum and the .pcs_disable() method needs to be called to
>    release any resources that .pcs_enable() enabled (e.g. irq masks,
>    power enables, etc.)
> 3. the MAC driver needs to be notified that the PCS pointer it
>    stashed is no longer valid, so it doesn't return it for
>    mac_select_pcs().

But why we need all these indirect handling and checks if we can
make use of .remove and shutdown the interface. A removal of a PCS
should cause the entire link to go down, isn't a dev_close enough to
propagate this? If and when the interface will came up checks are done
again and it will fail to go UP if PCS can't be found.

I know it's a drastic approach to call dev_close but link is down anyway
so lets reinit everything from scratch. It should handle point 2 and 3
right?

For point 1, additional entry like available_interface? And gets updated
once a PCS gets removed??? Or if we don't like the parsing hell we map
every interface to a PCS pointer? (not worth the wasted space IMHO)

> 
> There's probably a bunch more that needs to happen, and maybe need
> to consider how to deal with "pcs came back".. but I haven't thought
> that through yet.
>

Current approach supports PCS came back as we check the global provider
list and the PCS is reachable again there.
(we tasted various scenario with unbind/bind while the interface was
up/down)

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
	Ansuel

