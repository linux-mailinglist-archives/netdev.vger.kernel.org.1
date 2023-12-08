Return-Path: <netdev+bounces-55354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D0C80A90A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF341F2111D
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E451DFE9;
	Fri,  8 Dec 2023 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyAoYNhX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57942199F
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 08:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702053226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXw0XZZEim7nEEhz34fa5B4jxIHSBv8a2Eg+0Dnfzpg=;
	b=KyAoYNhXVJUv7MC4P6NNRagRGkmvQ7J4Jocst9wPoBkgjWO6NO6iIGb/iRGDG++m9UJ0xR
	QPUyU2AjkkxAxRdNlAFNw6gKH+rbgDFUropulT70wRpu4oAkrQbQ+lLRfGa6g81gQwCbWs
	s/fwfpvSNca/vzNs9bxd8ww3nKfIknQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-wpNsdxVTMky3bz2IF8M8rA-1; Fri, 08 Dec 2023 11:33:44 -0500
X-MC-Unique: wpNsdxVTMky3bz2IF8M8rA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77f360c8a64so223663085a.0
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 08:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053224; x=1702658024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXw0XZZEim7nEEhz34fa5B4jxIHSBv8a2Eg+0Dnfzpg=;
        b=Hw1rlA1ufxzx8tXpvRtewJqqOz461UGB8mPQw1ACmIpnsNQ8z+klyvLRxGh5wlQB4n
         9wlsK44NdW8rrKB7U11zegiKY4KAiAp717QqXGrsTVGNFIf1AvfMiour76sdG30heiIu
         kxNFv8u6jjoWSpQroTER9seIqwvgSJaLi1jRN2ZuBpgnPO90pB4c/tPIahJjubVx+hIZ
         vwHh0tL6hO/wMh5IHyty5tcyhZvQH79acf/fZKcyBoRBiyjVEIjYfSFgxX0Lt4ASwGWT
         TMD8Yi0vLCQ+xMg2FFYNsjYpYU1N8VyMqDgM9GHzIM/itPPqnt3Y/LYdxNHdHDALSOdy
         Wz7Q==
X-Gm-Message-State: AOJu0Yzo9vR+i197TPvbxzdo+xHqi2XXZMwlIoknsO3ocEooEXeGCDDj
	87TJim3voJiIEgUTq3M2jxfA3SVqDRNaD1nwg08IRP5LXsWNE2HKPpoGi2iQ4c5g3f+bQ31ksJw
	i7HhdEGuhLJtwUP6F
X-Received: by 2002:ac8:5f8f:0:b0:423:b118:100a with SMTP id j15-20020ac85f8f000000b00423b118100amr397494qta.1.1702053224384;
        Fri, 08 Dec 2023 08:33:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH9bHNB0WsJAVj+oZ5YejD6BIs/ceRUycn4p6BwtXybFF1QZpkQFOT/VWn88opyf/TmalPZw==
X-Received: by 2002:ac8:5f8f:0:b0:423:b118:100a with SMTP id j15-20020ac85f8f000000b00423b118100amr397476qta.1.1702053224087;
        Fri, 08 Dec 2023 08:33:44 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id p20-20020ac87414000000b00423dfab8fc3sm929789qtq.32.2023.12.08.08.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:33:43 -0800 (PST)
Date: Fri, 8 Dec 2023 10:33:41 -0600
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
Message-ID: <plvbqgi2bwlv5quvpiwplq7cxx6m5rl3ghnfhuxfx4bpuhyihl@zmydwrtwdeg6>
References: <20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com>
 <e64b14c3-4b80-4120-8cc4-9baa40cdcb75@lunn.ch>
 <nx2qggr3aget4t57qbosj6ya5ocq47t6w33ve5ycabs5mzvo7c@vctjvc5gip5d>
 <9eddb32d-c798-4e1b-b0ea-c44d31cc29bf@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eddb32d-c798-4e1b-b0ea-c44d31cc29bf@lunn.ch>

On Fri, Dec 08, 2023 at 02:14:41PM +0100, Andrew Lunn wrote:
> > I know you said the standard is to make the MDIO bus unconditionally, but
> > to me that feels like a waste, and describing say an empty MDIO bus
> > (which would set the phy_mask for us eventually and not scan a
> > bunch of phys, untested but I think that would work) seems like a bad
> > description in the devicetree (I could definitely see describing an
> > empty MDIO bus getting NACKed, but that's a guess).
> 
> DT describes the hardware. The MDIO bus master exists. So typically
> the SoC .dtsi file would include it in the Ethernet node. At the SoC
> level it is empty, unless there is an integrated PHY in the SoC. The
> board .dts file then adds any PHYs to the node which the board
> actually has.
> 
> So i doubt adding an empty MDIO node to the SoC .dtsi file will get
> NACKed, it correctly describes the hardware.

Agreed, thanks for helping me consider all the cases. In my particular
example it would make sense to have SoC dtsi describe the mdio bus,
leave it disabled, and boards enable it and describe components as
necessary.

So you have let's say these 8 abbreviated cases:

Case 1 (MDIO bus used with phy on bus connected to MAC):

	ethernet {
		status = "okay";
		phy-handle = <&phy0>;
		phy-mode = "rgmii";

		mdio {
			status = "okay";

			phy0: phy@0 {
			};
		};
	};

Case 2 (MDIO bus used but MAC's connect fixed-link):

	ethernet {
		status = "okay";
		phy-mode = "rgmii";

		fixed-link {
		};

		mdio {
			status = "okay";

			switch/unrelated-phy {
			};
		};
	};

Case 3 (MDIO bus used but MAC's connected to another bus's phy):

	ethernet {
		status = "okay";
		phy-handle = <&phy1>;
		phy-mode = "rgmii";

		mdio {
			status = "okay";

			switch/unrelated-phy {
			};
		};
	};

Case 4 (MDIO bus disabled/unused, connected fixed-link):

	ethernet {
		status = "okay";
		phy-mode = "rgmii";

		fixed-link {
		};

		mdio {
			status = "disabled";
		};
	};

Case 5 (MDIO bus disabled/unused, connected to another bus's phy):

	ethernet {
		status = "okay";
		phy-handle = <&phy1>;
		phy-mode = "rgmii";

		mdio {
			status = "disabled";
		};
	};

Case 6 (MDIO bus not described, connected fixed-link):

	ethernet {
		status = "okay";
		phy-mode = "rgmii";

		fixed-link {
		};
	};

Case 7 (MDIO bus not described, connected to a different bus's phy):

	ethernet {
		status = "okay";
		phy-handle = <&phy1>;
		phy-mode = "rgmii";
	};

Case 8 (MDIO bus not described, but phy on MDIO bus is connected to MAC,
        legacy description[2] in my commit message):

	ethernet {
		status = "okay";
	};


If we look at the logic in stmmac today about how to handle the MDIO
bus, you've got basically:

	if !fixed-link || mdio_node_present()
		of_mdiobus_register(np)

Applying current stmmac logic to our cases...

Case 1 (MDIO bus used with phy on bus connected to MAC):
    MDIO bus made, no unnecessary scanning

Case 2 (MDIO bus used but MAC's fixed-link):
    MDIO bus made, no unnecessary scanning

Case 3 (MDIO bus used but MAC's connected to another bus's phy):
    MDIO bus made, no unnecessary scanning

Case 4 (MDIO bus disabled/unused, connected fixed-link):
    MDIO bus attempted to be made, fails -ENODEV due to disabled
    and stmmac returns -ENODEV from probe too

Case 5 (MDIO bus disabled/unused, connected to another bus's phy):
    MDIO bus attempted to be made, fails -ENODEV due to disabled
    and stmmac returns -ENODEV from probe too

Case 6 (MDIO bus not described, connected fixed-link):
    MDIO bus not created

Case 7 (MDIO bus not described, connected to a different bus's phy):
    MDIO bus created, but the whole bus is scanned

Case 8 (MDIO bus not described, but phy on MDIO bus is connected to MAC,
        legacy description[2] in my commit message):
    MDIO bus created, the whole bus is scanned and the undescribed but
    necessary phy is found


The things I note of interest are cases 4, 5, 7, 8. Cases 4/5 are a bug in
stmmac IMO, which breaks the devicetree description you mentioned as
ideal in my case. Case 7 is the one I'm currently working with, and the
devicetree can be updated to match case 5, but right now case 7 makes a
bus and scans it needlessly which isn't great. It _sounds_ like to me
Serge knows of stmmac variants that also *do not* have an MDIO controller,
so they'd fall in this case too and really shouldn't create a bus. Case 8
is the legacy one that I wish didn't exist, but it does, and for that
reason we should continue to make a bus and scan the whole thing if we can't
figure out what the MAC's connected to.

So in my opinion there's 3 changes I want to make based on all the
use cases I could think of:

    1. This patch, which improves the stmmac logic and stops making
       a bus for case 7
    2. A new patch to gracefully handle cases 4/5, where currently if the
       MDIO bus is disabled in the devicetree, as it should be,
       stmmac handles -ENODEV from of_mdiobus_register() as a failure
       instead of gracefully continuing knowing this is fine and dandy.
    3. Clean up the sa8775p dts to have the MDIO bus described in the
       SoC dtsi and left disabled instead of undescribed (a more
       accurate hardware description).

Please let me know if you see any holes in my logic, hopefully the
wall of text is useful in explaining how I got here.

Thanks,
Andrew


