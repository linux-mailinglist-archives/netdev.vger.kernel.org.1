Return-Path: <netdev+bounces-56306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641280E78C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A61F21556
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CCD584DA;
	Tue, 12 Dec 2023 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT4xQhXz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B7899
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 01:27:37 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50be10acaf9so5367517e87.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 01:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702373255; x=1702978055; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ufvIJHeIo/PBbhY4IrKjJQsW+RgxOXqNive8v/EoIXo=;
        b=bT4xQhXzUS2FVKxNHOYSMersTtdpSnNa9TO2mKx2zg5NId+zSyXk+Z4Ktwz/ijCYO8
         ehSiHnaAB288GafKebFnIu9nLwyH2xZo+pj/SKVKgErdmXDrNLbVMgVBPjOOhRn7h/1A
         KBwHzCfBO05wQXJAM/UlIJKJ3NjyZ3n0LziXCAh9YeQo96Kt5D4ONTUJ0c9jG0GvU2T+
         Z+IeMBTdD88/+oECWJEKeETb43YfVgIKJe3Ba67UW31JRKKLz34rpzxzZLueGPpErJV/
         NB3egODv/tw1vqfvI5yZY+JJwbz25H+KPmU/hwEkanzgObWoTu8nLeZmc53/ILsWenSg
         F0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702373255; x=1702978055;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufvIJHeIo/PBbhY4IrKjJQsW+RgxOXqNive8v/EoIXo=;
        b=Zv4DpG7ax9OkfV2u42Wcktgu4HOj2VkZ8o/nQZuBUo43bgQFtz4ndUnBgr3xgvACtx
         IYxS8M+cpvQVeiJESUzVjEsgZR4Ke7W0HAWsuxXFIo/vzDN5GqUoUqV1a7jgNghJDivY
         /BONeJ38al+HJTaGFPUAAypfUDS7+KJ5TTZv0PN1kAcDZAE+TOkj7/DjP+Xd5wWpo5z6
         pt08CUmlW5tNFymzUvREu4UuhheR3cBeUdim8b/03IDbohAd+iDiofucOsTMqsr7DhLw
         BwcHTPW/p6jUSANZb2sc2r9qQqsweHTgVoijILCpLhJyK0RfD62q3KEpO02jUvFifq7K
         HKGQ==
X-Gm-Message-State: AOJu0YzWJBxh12HD4RolYPw6rAKkU1d3dPRQ0caIcFkfJhvVbpK03af/
	KfURkizwuNp/KWKhRKRxP3k=
X-Google-Smtp-Source: AGHT+IH8E50MtYeZP2sUE2EV7R5TfkqWJXdDN3lePMfqDGAsQRMTyaqE6qfNi07teioSb6t0chE4eA==
X-Received: by 2002:ac2:46ce:0:b0:50d:1842:551d with SMTP id p14-20020ac246ce000000b0050d1842551dmr2629479lfo.13.1702373255279;
        Tue, 12 Dec 2023 01:27:35 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id cf12-20020a056512280c00b0050a7572c9f6sm1307889lfb.101.2023.12.12.01.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:27:34 -0800 (PST)
Date: Tue, 12 Dec 2023 12:27:32 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Richard Tresidder <rtresidd@electromag.com.au>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	vinschen@redhat.com, netdev@vger.kernel.org
Subject: Re: STMMAC Ethernet Driver support
Message-ID: <rfg3fj2rhjxsnpula4tqhvdmmzdszlyebgaf2qxa4ncwb3gczo@wxf5graxwmib>
References: <e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au>
 <20231208101216.3fca85b1@kernel.org>
 <8a0850d8-a2e4-4eb0-81e1-d067f18c2263@electromag.com.au>
 <41903b8b-d145-4fdf-a942-79d7f88f9068@electromag.com.au>
 <f47b0230-1513-4a81-9d78-3f092b979c48@electromag.com.au>
 <2139624b-e098-457a-bda4-0387d576b53a@lunn.ch>
 <8ba4d31f-9436-43ad-afd7-997a4d3a4bf2@electromag.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ba4d31f-9436-43ad-afd7-997a4d3a4bf2@electromag.com.au>

On Tue, Dec 12, 2023 at 11:57:22AM +0800, Richard Tresidder wrote:
> 
> <font face="monospace">Richard Tresidder</font>
> 
> 
> On 12/12/2023 12:16 am, Andrew Lunn wrote:
> > > We use the SOC's internal  STMMAC interface to connect to a Marvel switch IC
> > > and expose each port individually using vlan, I'd forgot that part.
> > > It's an  88E6352-xx-TFJ2I000  device utilising the 'marvell,mv88e6085'
> > > compatible driver  in drivers\net\dsa\mv88e6xxx
> > Its odd you need VLANs. Each port should already be exposed to the
> > host as netdev interfaces. That is what DSA does.
> > 
> >       Andrew
> Hi Andrew
>    I'll read further on that one as this is the first time I've had to dig
> into this side of the system.
> It had always "just worked".
> The ports show up in an 'ip l' list in the same style as a vlan with an @
> symbol, naming isn't quite vlan style though.
> That in concert with the fact this 'vlan_feature' line broke things has
> possibly distorted my view of how they're propagated.
> It's a rather trimmed down busybox image, so I'm missing some tools I'd
> usually use to examine stuff.
> 
> This is the config in the dts
> **************************************
> //------------------------------------------------------------------------------
> // connected to dsa network switch
> &gmac1 {

>   clock-names = "stmmaceth", "clk_ptp_ref";

Just a side note irrelevant to the topic. You might be interested to
know STMMAC driver expects to have the PTP reference clock source
passed with the "ptp_ref" name, not "clk_ptp_ref".

-Serge(y)

>   clocks = <&emac1_clk &hps_eosc1>;
>   f2h_ptp_ref_clk;
>   fixed-link {
>     speed = <1000>;
>     full-duplex;
>   };
> };
> 
> //------------------------------------------------------------------------------
> &mdio1 {
>   #address-cells = <1>;
>   #size-cells = <0>;
> 
>   switch0: switch0@0 {
>     compatible = "marvell,mv88e6085";
>     #address-cells = <1>;
>     reg = <0>;
>     //reset-gpios = <&pio_a0 2 GPIO_ACTIVE_LOW>;
> 
>     dsa,member = <0 0>;
> 
>     ports {
>       #address-cells = <1>;
>       #size-cells = <0>;
> 
>       port@2 {
>         reg = <2>;
>         label = "lan1";
>         phy-handle = <&switch1phy2>;
>       };
> 
>       port@3 {
>         reg = <3>;
>         label = "lan2";
>         phy-handle = <&switch1phy3>;
>       };
> 
>       port@4 {
>         reg = <4>;
>         label = "lan3";
>         phy-handle = <&switch1phy4>;
>       };
> 
>       port@5 {
>         reg = <5>;
>         label = "wifi";
>         fixed-link {
>           speed = <100>;
>           full-duplex;
>         };
>       };
> 
>       port@6 {
>         reg = <6>;
>         label = "cpu";
>         ethernet = <&gmac1>;
>         fixed-link {
>           speed = <1000>;
>           full-duplex;
>         };
>       };
> 
>     };
> 
>     mdio {
>       #address-cells = <1>;
>       #size-cells = <0>;
>       switch1phy2: switch1phy2@2 {
>         reg = <2>;
>         marvell,reg-init = <0 0x10 0 0x0200>; // Sense only on Rx Energy
> Detect, no FLPs sents
>       };
>       switch1phy3: switch1phy3@3 {
>         reg = <3>;
>         marvell,reg-init = <0 0x10 0 0x0200>; // Sense only on Rx Energy
> Detect, no FLPs sents
>       };
>       switch1phy4: switch1phy4@4 {
>         reg = <4>;
>         marvell,reg-init = <0 0x10 0 0x0200>; // Sense only on Rx Energy
> Detect, no FLPs sents
>       };
>     };
> 
>     };
> };
> *************************************************
> 
> This is how they appear using 'ip l'
> The @ symbol got me as I've usually associated this with vlan's in my day to
> day networking.
> But the config files don't configure them as vlans.
> *************************************************
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1508 qdisc mq qlen 1000
>     link/ether 04:91:62:cf:4f:06 brd ff:ff:ff:ff:ff:ff
> 3: sit0@NONE: <NOARP> mtu 1480 qdisc noop qlen 1000
>     link/sit 0.0.0.0 brd 0.0.0.0
> 4: lan1@eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
> qlen 1000
>     link/ether 04:91:62:cf:4f:06 brd ff:ff:ff:ff:ff:ff
> 5: lan2@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue qlen
> 1000
>     link/ether 04:91:62:cf:4f:06 brd ff:ff:ff:ff:ff:ff
> 6: lan3@eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
> qlen 1000
>     link/ether 04:91:62:cf:4f:06 brd ff:ff:ff:ff:ff:ff
> 7: wifi@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue qlen
> 1000
>     link/ether 04:91:62:cf:4f:06 brd ff:ff:ff:ff:ff:ff
> 
> *************************************************
> 
> And these are the systemd config files
> No vlan mentioned in there..
> *************************************************
> /etc/systemd/network/eth0.network
> [Match]
> Name=eth0
> 
> [Network]
> 
> /etc/systemd/network/lan.network
> [Match]
> Name=lan*
> 
> [Network]
> DHCP=yes
> BindCarrier=eth0
> LinkLocalAddressing=yes
> 
> [DHCP]
> UseDomains=yes
> ClientIdentifier=mac
> 
> *************************************************
> 
> Cheers
>    Richard
> 

