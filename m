Return-Path: <netdev+bounces-233381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83485C12943
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386161A68575
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E5D24DCF6;
	Tue, 28 Oct 2025 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVyto20f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215052472A4
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615855; cv=none; b=A5wB3GXffEJAwPM4R4Q9fiUJq8G7VAFSzi/qDdNcwOvNaZaplL+MEJrDjUaQ52IB1FCZNdI3nK7CivWmgmrQat7vppnESuIAnDuUQo9SAkZMGx/vmmM5c4b8/Kb67m3y+Lp9DqftG2H3DRP3xf8YisxhwxYAEnXfCJWc9Nx+ERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615855; c=relaxed/simple;
	bh=6OI1emRH6YDI+gn1qZLUSdFkdTMpkf3y/4hsnZ2wg50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrWlIStxuoHeKrSFnbz5p+nAmbQctDc+SrqEQW95TK25gAzEsFwjaPhnq9XhZyYQ7yxf3PzneN5VbbzrZI3p3F7wEHG3PRzsqh7M1J4JrqGH8sseVzEv4wWTKvXys2iIcUWS7IEAyQpfBkwNVpmw31j4mUB8m0Zw4UP4wb2uMTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVyto20f; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b404a8be3f1so119259466b.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 18:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761615852; x=1762220652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8fuVJcJ3up+Cl+7OOOThez71Iipxn0vlF9LQWy19P8M=;
        b=HVyto20fwQc7JKZqPR5o9cn/cxVz21TNvXmO2EmmWpV+IIosbxgMTBGswrk/On1PJF
         tnyHe0JU6398lga/vIMhRtKOY3P9q4k8AX87KwZ9ugGbbuVPLMIF4vwvyDges8cCgQvZ
         ThiYhF0ecewl+gj7m7dVaHvafTOMDZqyyEAHyWzu5kGFi1gCEaMdAUG7smiaViverZAI
         S9ZT7/3p1b0zEFmF/WHSX1JOd/TeBId5IjbDM7apaxhXtIV2QE8rE7V8PK21SLqKZZot
         MzgtBOLZjzmT05C5Y/ds61U7a3ju0YbaypB6+wiEBuraKnUQ9CIm2lxucnJfXFxB5B8T
         5rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761615852; x=1762220652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fuVJcJ3up+Cl+7OOOThez71Iipxn0vlF9LQWy19P8M=;
        b=HIJ/EEz+hVCb1x8DnEWX2jZqgdeBa3Naeinz1aTI+eIJMGl1Kw8qOttaq5LZFR9GLA
         wEMkpiN77C6uJSNTQTs83Rz12z0xekjwkUWV1s+ES9hvIKxoWlqym1v/3jSj3z+XXJC+
         caHpmTMpvhfXUyUMbLc+oN8AeVTpUunOsAgvP0u6x3ltnAt4oH8wN/y7dODwRyggO8ay
         O/5ZPKnjAWW1DzkNLvEPhaDZA4SNimgEbWFpViS2KNzjTO7AE1KVVUpRo7sTEu4Cl8jk
         ykEAmtlrF54/PrBkSFZXfRdoImHkVJzlCLnktwbPSwW6jZA00k0ZBIHgSo0wHheh4j2j
         MzJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuyKU0PSsWmjoE1yLiYeVOUvvgSaEcFd62rqAyMQ1sNo0wzAm/otfom84ZPGrsOEvyEurxrXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXwzuO1S/23y+R1zlo8AI2u3SMtYAEKmhC7uZ8nbR8pJAll5k
	dkrTXhf8RYc5aksSwtmDSpBnKTDjZHRHog6QyEKeeApc/TWNuO9GKAls
X-Gm-Gg: ASbGnctanZ3FMi6dBhL00dqa7HiRmVDduAeLmL0dPBo9L7bUHjGj6Gvzxe1oW1E/is+
	tCXPDOeauXGN8EVdlITuaPQR7BGdCpXeqnpKl6cUade19n29gXNHwv2uTf9qqSqSIEQnJrXlffT
	ZaSFH2dpNIFr73yRl7pVUkKD4BRwyRRJA/OhYnLGI+UxYfjOthrt9uAN5pY4nU6boo6ooBQeIgU
	xMJHqNwYuJVySFSW7kekAL8WH5RYzumo1nQVcScH1vH4wK22QfVeUrTQkR744RQqKLezWRoLSdp
	EgMVcI5SAdTb4u2+/zJbKmf7THlAY2cc9/jDAyxttc192XHI7wivRprkjWK6TeWHKfKRwuPefld
	Z/+5pAclIFci5m6/T6wJw4SlmpPD7kkfxHzxkZZ1E6Zs2y/yoYk6SAV8rwjmS72TxenKBTyiJcU
	AJZ3g=
X-Google-Smtp-Source: AGHT+IH49TQqSextVqYwy4pwgYt3UARDdD6p/S8FeGOqkGQ3uH9tGtPcW/IIc8ns2pRc0oji4CQ0Gw==
X-Received: by 2002:a17:907:3d46:b0:b46:b8a9:ea6 with SMTP id a640c23a62f3a-b6dba5ffb38mr124389466b.9.1761615852413;
        Mon, 27 Oct 2025 18:44:12 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d406:ee00:3eb9:f316:6516:8b90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853e5138sm927773866b.44.2025.10.27.18.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 18:44:11 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:44:07 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 09/12] net: dsa: lantiq_gswip: add vendor
 property to setup MII refclk output
Message-ID: <20251028014407.x5jrwpw6f5rsfi5f@skbuf>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <869f4ea37de1c54b35eb92f1b8c55a022d125bd3.1761521845.git.daniel@makrotopia.org>
 <20251027233626.d6vzb45gwcfvvorh@skbuf>
 <aQAEyn08Q3DCedUU@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQAEyn08Q3DCedUU@makrotopia.org>

On Mon, Oct 27, 2025 at 11:48:26PM +0000, Daniel Golle wrote:
> On Tue, Oct 28, 2025 at 01:36:26AM +0200, Vladimir Oltean wrote:
> > On Sun, Oct 26, 2025 at 11:47:21PM +0000, Daniel Golle wrote:
> > > Read boolean Device Tree property "maxlinear,rmii-refclk-out" and switch
> > > the RMII reference clock to be a clock output rather than an input if it
> > > is set.
> > > 
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > >  drivers/net/dsa/lantiq/lantiq_gswip_common.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> > > index 60a83093cd10..bf38ecc13f76 100644
> > > --- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> > > +++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> > > @@ -1442,6 +1442,10 @@ static void gswip_phylink_mac_config(struct phylink_config *config,
> > >  		return;
> > >  	}
> > >  
> > > +	if (of_property_read_bool(dp->dn, "maxlinear,rmii-refclk-out") &&
> > > +	    !(miicfg & GSWIP_MII_CFG_MODE_RGMII))
> > > +		miicfg |= GSWIP_MII_CFG_RMII_CLK;
> > > +
> > 
> > What did you mean with the !(miicfg & GSWIP_MII_CFG_MODE_RGMII) test?
> > If the schema says "Only applicable for RMII mode.", what's the purpose
> > of this extra condition? For example, GSWIP_MII_CFG_MODE_GMII also has
> > the "GSWIP_MII_CFG_MODE_RGMII" bit (0x4) unset. Does this have any significance?
> 
> You are right, probably the best would be to test (if at all) that
> (miicfg == GSWIP_MII_CFG_MODE_RMIIM || miicfg ==
> GSWIP_MII_CFG_MODE_RMIIP) and only in this case allow setting the
> GSWIP_MII_CFG_RMII_CLK bit.
> 
> I forgot that there is older hardware which supports "full" MII, and MII
> MAC as well as MII PHY modes also shouldn't allow to set the
> GSWIP_MII_CFG_RMII_CLK bit to not end up with undefined behavior.

Yeah, actually you'd be looking at FIELD_GET(GSWIP_MII_CFG_MODE_MASK, miicfg)
rather than miicfg directly.

If the schema restricted "maxlinear,rmii-refclk-out" to be used only in
combination with phy-mode = "rmii" and "rev-rmii", in theory that should
be sufficient with no further driver checks. But some checks that at
least make sense don't seem to hurt.

