Return-Path: <netdev+bounces-55103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B21809660
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 00:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28BB1F2137C
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 23:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1574E61E;
	Thu,  7 Dec 2023 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FX/H7lnN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC563D5B
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 15:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701990024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHDiIUO4wGrJXoCtVtKVrp/X3ZZZ6xuRsMz/PFdLYt4=;
	b=FX/H7lnNmV28PEb2ViVH/Xd4P3Ldbt3rnjeMeAAT3V7D0k8vHGZfBq5GWhcSC/2aoZwkSF
	sairp5f0BFsGL+NJJgdxflnttdiNlpQZaFId8BbzX+CpaGPQ/fh1sgUJ7uk3+rnQZN1i2M
	CX0rv5iJuh0CR4zniUTpYU32gxmlmRU=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-FfE316c8M26eAm5oe8LXDQ-1; Thu, 07 Dec 2023 18:00:19 -0500
X-MC-Unique: FfE316c8M26eAm5oe8LXDQ-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-db401df7735so1965271276.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 15:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701990019; x=1702594819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHDiIUO4wGrJXoCtVtKVrp/X3ZZZ6xuRsMz/PFdLYt4=;
        b=PYtuZl/Olyu/BQ8uWJ0omXWaN41cRuq+CYQ5ZBJe/hqY7N/sgdiKdZX901y0ipDuXy
         dDjR03PhbSXiny0e8WGMTssKGwaZ5w4vuSWy7lKUOvnPZOp23q3dM7sWfKBnLLoc8U6Y
         uFWxYSfeEmv3SiJLIw5M0fqwQX2CnOXgNAV+yYSwzZK/RxoWgGSXHyHk6kCgxlZysmGK
         AcnCliJ8YCEZo6+gCGqCLXrF7vbh3x/8xNDlOfGVyPJBRZJCBn970iOhtUGWbJHJmdsy
         v8674W1Dc96SN2DRXGzL4aB+AXycVnqDCILUza4QvZa8OGYvWk/lDxphp+279KWt6V7O
         1fAw==
X-Gm-Message-State: AOJu0Yw9JdZpWOr5Gt4apJWmchg+NNYGJ2Z6NOFP1157rUKQTxEF1HYA
	yv/2WUZXTV7ckaAZp2kHn7o/KTCL4i82RLEZfAaKY9UZGMQ81vMRcdyhYq1+H9zRWqyxr28s7iP
	zzoa3ntfOpnxRBZd3
X-Received: by 2002:a25:b0a1:0:b0:db5:50a4:5d8d with SMTP id f33-20020a25b0a1000000b00db550a45d8dmr2980165ybj.62.1701990018897;
        Thu, 07 Dec 2023 15:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0avpExtnb0QEhd4giNpUXpAE03lNhEmhlHgyYyxAylqZ06Xwo4E+/RgU0lzyhjqXned4R+g==
X-Received: by 2002:a25:b0a1:0:b0:db5:50a4:5d8d with SMTP id f33-20020a25b0a1000000b00db550a45d8dmr2980142ybj.62.1701990018572;
        Thu, 07 Dec 2023 15:00:18 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id p5-20020a05621415c500b0067ac2df0199sm271427qvz.128.2023.12.07.15.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 15:00:18 -0800 (PST)
Date: Thu, 7 Dec 2023 17:00:15 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH net-next v2] net: stmmac: don't create a MDIO bus if
 unnecessary
Message-ID: <nx2qggr3aget4t57qbosj6ya5ocq47t6w33ve5ycabs5mzvo7c@vctjvc5gip5d>
References: <20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com>
 <e64b14c3-4b80-4120-8cc4-9baa40cdcb75@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e64b14c3-4b80-4120-8cc4-9baa40cdcb75@lunn.ch>

On Thu, Dec 07, 2023 at 10:30:23PM +0100, Andrew Lunn wrote:
> On Wed, Dec 06, 2023 at 05:46:09PM -0600, Andrew Halaney wrote:
> > The stmmac_dt_phy() function, which parses the devicetree node of the
> > MAC and ultimately causes MDIO bus allocation, misinterprets what
> > fixed-link means in relation to the MAC's MDIO bus. This results in
> > a MDIO bus being created in situations it need not be.
>
> Please extend that with something like....
>
> This is bad, because ....
>
> Most 'clean' driver unconditionally create the MDIO bus. But stmmac is
> not that clean, and has to keep backwards compatibility to some old
> usage. I'm just wondering what this patch actually brings us, and is
> it worth it. Is it fixing a real bug, or just an optimisation?
>
>    Andrew
>

It is an optimization for speeding up time to link up. I already sent
out v3 moments before this arrived, I'll be sure to capture that more
clearly in v4 (and wait a little longer before respinning it).

I'm trying to optimize this device configuration (as shown in the commit):
"""
    Here's[1] an example where there is no MDIO bus or fixed-link for
    the ethernet1 MAC, so no MDIO bus should be created since ethernet0
    is the MDIO master for ethernet1's phy:

        &ethernet0 {
                phy-mode = "sgmii";
                phy-handle = <&sgmii_phy0>;

                mdio {
                        compatible = "snps,dwmac-mdio";
                        sgmii_phy0: phy@8 {
                                compatible = "ethernet-phy-id0141.0dd4";
                                reg = <0x8>;
                                device_type = "ethernet-phy";
                        };

                        sgmii_phy1: phy@a {
                                compatible = "ethernet-phy-id0141.0dd4";
                                reg = <0xa>;
                                device_type = "ethernet-phy";
                        };
                };
        };

        &ethernet1 {
                phy-mode = "sgmii";
                phy-handle = <&sgmii_phy1>;
        };
"""

I'm seeing that ethernet1 scans the whole MDIO bus created for it, and
finds nothing, wasting time in the process. Since there's no mdio bus
described (since it's vacant) you get something like this call order:

    stmmac_mdio_register()
    of_mdiobus_register(new_bus, mdio_node) // mdio_node is NULL in this case
    __of_mdiobus_register(mdio, np, owner)  // this doesn't set phy_mask since np == NULL
    __mdiobus_register(mdio, owner)
    mdiobus_scan_bus_c22(bus)
    mdiobus_scan_c22()                      // Called PHY_MAX_ADDR times, probing an empty bus

Which is causing a good bit of delay in the time to link up, each
attempted probe is taking about 5 ms and that's just benchmarking the
get_phy_c22_id() calls, if you look at the whole loop it's greater (but I
am unsure if that's just scheduling contention or something else going
on, once I realized we were doing this work unnecessarily I decided to
try and remove it)

I know you said the standard is to make the MDIO bus unconditionally, but
to me that feels like a waste, and describing say an empty MDIO bus
(which would set the phy_mask for us eventually and not scan a
bunch of phys, untested but I think that would work) seems like a bad
description in the devicetree (I could definitely see describing an
empty MDIO bus getting NACKed, but that's a guess).

Please let me know if you disagree with that logic and have some
alternative solutions for optimizing. In either case I think this code
needs some cleaning so I'll carry this through. It also seems that
unconditional creation of the MDIO bus is something that's biting some
stmmac variants that lack an MDIO controller based on Serge's latest
comments on v3:

    https://lore.kernel.org/netdev/jz6ot44fjkbmwcezi3fkgqd54nurglblbemrchfgxgq6udlhqz@ntepnnzzelta/

Thanks,
Andrew


