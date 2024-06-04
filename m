Return-Path: <netdev+bounces-100536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BB58FB050
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7951C2330D
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 10:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5C01448EE;
	Tue,  4 Jun 2024 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaqpuTDr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6284142E8C;
	Tue,  4 Jun 2024 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717498023; cv=none; b=HUar25Oh1+mqZSv1Ov37ZAix+Q5ZK2bXOvjTzUvTZ+3/bOL5rPao4YUedqooW9QnD/8RhsKU2/F+xfahuIYIwdVROX/dNq5VCwBDwakbdEEDa/N4sGbzNVwzaF3JcmPUUiT2dMCK4SWIZ9QaGYfdd36bYwvIJSBUal2vVYhXD+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717498023; c=relaxed/simple;
	bh=dGwYb1vYwfxkIeBZZHZVtgIKIQx88FnRJvKyKhqdiqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3aTkYALojttfeReED/xoUUFuVfnEzFMuxrH8/jDg76K155qrnMWv8GrRdZYD034K+yBsqYdXuCqzgNKNHsejbCkQPmpKokQ95uyS8jhHmlWxQsO7MnpCFyNOvkmTPwDteJMWnIx13B9fkvIhJoV+usRrQAGDJt8yfk3zyDqPDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaqpuTDr; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b8b638437so937009e87.3;
        Tue, 04 Jun 2024 03:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717498020; x=1718102820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5WLooy2A7mlEfBwUMQTaBlwD5VzPh4lOZOOGWiXZ1k=;
        b=PaqpuTDrezLXIlcvpE0tMilnYnQyJ1M4vx7wGS/VyYgRwxllu4hk7PW+/qyOz9V5Ft
         iC7aewevUXnLuf+3uqTBXjybAufw6opVvOoSdhST2UxetLlfyoRbdoTvAYbcL0o9aIN4
         kF3/s8yp/U4+tIkiBOd/OBX+Pk6rEm2dxM3WQWqQTYcMf8uA/5iftbUxfwCbpmWloSxa
         CFi80Iw6caXYt3zitWdokHX0S06olzEHX2KNbwRue2ea57RbTt2XkcjiAnAEaUetR1Kc
         h2EDEVpoYP5YQ9UNiGWQbTW1FitK1LHjSUPmm/MqtxJf0mp0jrPBD66q+PLu/KIG9GKf
         nLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717498020; x=1718102820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5WLooy2A7mlEfBwUMQTaBlwD5VzPh4lOZOOGWiXZ1k=;
        b=Zdndo2Z8E/H321pXiBUqsmErkCCS52QAiAdmnxWPUQunU2eMgbsFSkxy38XRaXHH67
         6JyLGkIIO6mN6W4p0xHQaXsB9GTNR8pDpr+H/r6XYM7O/CfSBRS/6hsRkyT4ujc7YGIw
         pyyOdhPvz3vr0nYMnjy9N+9usEXYNg84Sz9bTeMwZUqQmtYnkOD48I7ibw/owGQGkbam
         QpELg/g2wdeUDnTD9wG5GnBGfEXoA0pxWa51U9HkN5cGSZDZcKAvAarNGO+XqUFoz0+W
         BoOjUdHPxncYmpE0iDumBtOZsgYSLU6v68Fh+J2/+ClmRKvzPxb7jjwEG0YM6YJj1sEE
         gliw==
X-Forwarded-Encrypted: i=1; AJvYcCUk5cUUWCn9SdeA4Dgb6TufJgePvQjqH/hl9AsG9fTheG5M5okmnewUGElpVFWNjnIOgfMHliPU98YVBRy31IcD5Jr3RaI5gLeIPNCJQAvnsXz49PUmjPhbq6hk3YL+x7kPlTvTNdSkVHtuaBVpTDsNQwpv0DItMiuu0pQCLRntOQ==
X-Gm-Message-State: AOJu0YxOkMu7XAdhLfhex8lG48+S9/HACDYYSXgUxfhHS0dgruZIBji6
	F5gcdc36BXzr+OAbU2aUfW8g3B/XiZPIKDnhIQVaBErsQRYWlqsp
X-Google-Smtp-Source: AGHT+IFhpB4oLFNLONqB/WZnWU7eWkrmPR/i/a2NYKmzouexZTEd/9HPokyqyfou7PCwNPXhTpzSEw==
X-Received: by 2002:ac2:59c9:0:b0:52b:84bd:345e with SMTP id 2adb3069b0e04-52b8970c011mr6949767e87.43.1717498019597;
        Tue, 04 Jun 2024 03:46:59 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b9e2404d5sm394822e87.297.2024.06.04.03.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 03:46:59 -0700 (PDT)
Date: Tue, 4 Jun 2024 13:46:55 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 10/10] net: stmmac: Add DW XPCS specified via
 "pcs-handle" support
Message-ID: <q6u6g6aqabsgwqwzrzi4q5nhw4qxuykleotfzwcds5gztxi5ji@e6nui6k6lrk7>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-11-fancer.lancer@gmail.com>
 <2lpomvxhmh7bxqhkuexukztwzjfblulobepmnc4g4us7leldgp@o3a3zgnpua2a>
 <Zl2G+gK8qpBjGpb3@shell.armlinux.org.uk>
 <equlcrx6dgdtrmrlnxxhdunpghw46sjcyn5z6m6lszyiddbag4@eo6oeotzsxef>
 <Zl7ehKqLlzTUQIJG@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl7ehKqLlzTUQIJG@shell.armlinux.org.uk>

On Tue, Jun 04, 2024 at 10:29:40AM +0100, Russell King (Oracle) wrote:
> On Tue, Jun 04, 2024 at 12:04:57PM +0300, Serge Semin wrote:
> > On Mon, Jun 03, 2024 at 10:03:54AM +0100, Russell King (Oracle) wrote:
> > > I can't think of a reasonable solution to this at the moment. One
> > > solution could be pushing this down into the platform code to deal
> > > with as an interim solution, via the new .pcs_init() method.
> > > 
> > > We could also do that with the current XPCS code, since we know that
> > > only Intel mGBE uses xpcs. This would probably allow us to get rid
> > > of the has_xpcs flag.
> > 
> > Basically you suggest to move the entire stmmac_pcs_setup() to the
> > platforms, don't you? The patch 9 of this series indeed could have
> > been converted to just moving the entire PCS-detection loop from
> > stmmac_pcs_setup() to the Intel-specific pcs_init.
> 

> Yes, it's not like XPCS is used by more than one platform, it's only
> Intel mGBE. So I don't see why it should have a privileged position
> over any other PCS implementation that stmmac supports (there's now
> three different PCS.)
> 

Alas DW XPCS has already got a more privileged position. The STMMAC
driver calls the XPCS driver methods here and there (supported ifaces,
EEE or PHY setup). Unless these calls are converted to some
standard/new phylink_pcs calls IMO it would be better to preserve the
default DW XPCS init at least for the "pcs-handle" property to
motivate the platform drivers developers to follow some pre-defined
device description pattern (e.g. defining DW XPCS devices in device
tree), but leave the .pcs_init() for some platform-specific PCS inits
(including which have already been implemented).

As I already mentioned DW XPCS is of Synopsys vendor. The IP-core has
been invented to provide a bridge between the Synopsys MAC IP-cores
and PMA (mainly Synopsys PMAs) for the 1G/10G links like 1000Base-X,
and 10GBase-X/-R/-KX4/-KR. The reason we see just a single use-case
of the XPCS in the driver is that even though the STMMAC driver has DW
XGMAC support the driver is mainly utilized for the 1G MACs (I don't
see any platform currently having DW XGMAC defined). Since DW GMAC/QoS
Eth can be configured to have the standard PHY interfaces available
there is no need in XPCS in these cases (except a weird Intel mGBE).

But when it comes to DW XGMAC it can be synthesized with GMII and XGMII
interfaces only. These're exactly interfaces which DW XPCS supports on
upstream. Thus basically the DW XPCS IP-core has been mainly produced
for been utilized in a couple with DW XGMAC providing a ready-to-use
solution for the XFP/SFP(+) ports or backplane-based applications. So
should we have more DW XGMACs supported in the kernel we would have met
more DW XPCS defined in there too.

> If you don't want the code in the Intel driver, then what could be
> done is provide a core implementation that gets hooked into the
> .pcs_init() method.

I don't mind converting patch 9 to moving the XPCS registration in the
Intel-specific .pcs_init() (especially seeing it's just a single
xpcs_create_mdiodev() call), but having the "pcs-handle" property
handled generically in the STMMAC core would be a useful thing to have
(see my reasoning above).

-Serge(y)

> 
> The same is probably true of other PCSes if they end up being shared
> across several different platforms.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

