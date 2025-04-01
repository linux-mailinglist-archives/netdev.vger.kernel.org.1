Return-Path: <netdev+bounces-178565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30FEA7791F
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2F797A383D
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE07C1F12EA;
	Tue,  1 Apr 2025 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="TyHMHuWW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3631E1C22
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504746; cv=none; b=po0+r7vYkbf6iNgUOjQPBWtarz2JCqsAVjRFMSO+4InmszWHa4tJ251CDX40fpx/stBX3lc5qFQbsOfYGU4xg8TRPqxTzfeFzJTJulqR/AjonViDmWkc3t0lYILKy/ojjR0CPjPmLaFcu2CmmSmQhdZ+ys7IbOJJU+yJC0a+w20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504746; c=relaxed/simple;
	bh=eWza1Uj4fmHQlvuDleTNnRT9cX4gAE4qYkdYLL8RKLU=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=axmq8qysaoL6q5q35Jmls46tNOmZTIYzWY35jRKcltMblbNOKJqTIhHn0Xbduv+8A/MQj7NCKkmxWcv4XRKOvMRI3m+WsImCmS/TcZGmrAe2wF4O0GI518nz98YidxxIKKqZ8NedJjO01HpkL3KlcwqsHza7pigtbIqkRgvpGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=TyHMHuWW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1efc457bso838761f8f.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 03:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1743504737; x=1744109537; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E+Ss3FG8YVMs1Z9lPo5iO4P1N5xfxEuAvsPaF7B5nyI=;
        b=TyHMHuWWZ4JIl56xcYLTIpTV6tZf1/w8BkacuO+qecQdHiVG2XkbE1zbtKISHFoFWN
         NllFPaDWhGcmcP9S/VGU5rGGVvrhLzZXoZMYeyyAO6uKE9qf463KZE1QNQ3JIwkogrzZ
         9IBxSEGdlsa4F5rpUw1ACyNnHhUI/xbggOW2CTygfYxr2mssWLKJ5auavPQ7vokQgJPd
         1V1KKkfJpQRa3pl/rdu+TRn26wbPB3R04jFk7M7LMaWgBW0khOpFTQpKU78Tl1NxOlJI
         skeIoIexFJydOII4N6ctK1QX9GoyWRVwtHUi1lBHY0QjRBwKXGHA6bRYq1ylKb7bu1Tq
         CwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743504737; x=1744109537;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+Ss3FG8YVMs1Z9lPo5iO4P1N5xfxEuAvsPaF7B5nyI=;
        b=B/qMhi9CakdHTWjATKxYc8G70sNT4mMOU/9AON1niESb6alpGgE50XvM7TCCjlWnwk
         HOKNex8038Q1G3xUJ/cUzZqvAIq26bdfv5AWgICM8sDwqzNcOsd18P2onJaaklizVFf0
         pTWLP6VqQ4AsVTzSvb/qcrIM/u7fYScANFjIsz9LnNBVeclAvJFQq6MoZnVSs1cNeKtR
         ktqwzP7WyWflAoUDMPWxyUxxXdDPxS7HsP/ALZNwO1vietKzEZkfr0+wqBUXwUDV4wgV
         IEsQ6UzHjrQIUIS82cEHyEQvVD9mXFBRZ5PKcxpXI4JRYRJhPSRHEJ4l257m06sdE5SL
         i57A==
X-Gm-Message-State: AOJu0YyQCnU9ZP1ZJKLB4BXYXnnjvP2tWuL0a4mFxtzDOemlp9mD9JtJ
	nKap1syYdHxQivn0tgE1/G29mbIuWcE8cLutHzBphfXSqvf7IbppzSJWSQy8+gej5GOdWkuuDjr
	L2Q==
X-Gm-Gg: ASbGncvPzF0WlreWpTO2JMhexNPvS2mw3yT616y8Lc7OYjsAJzu7glpnv42b0r0giDO
	OOv61flTJ4bGlXeEK+bt7qRnViTAgXxHvcBEsgDzjfYGmyvl4iKPy3Rte6QtRsQck60lFMax7ef
	qj2lG4uBfH9YFUUTEnZTo+Qhg353X6Q15PERsb2Q7aBPSyvOR2AMckPZIExWGhwNB2UNG1FMNmX
	1U9NtaKIN4MJJDhX9DAZUzmyvndgwp+xW3WIw8g5u8ym03t5N3S1sWyWmpF3onhUbLue0DXjL9Y
	oS5+vtSynZHCKldMu7b8BynNH3+WujZGaif4DzU/iLQqNPCwh65z
X-Google-Smtp-Source: AGHT+IG7CU/J/S+PYYOLiPGauYV1N5WI7DSjfcFzPgJvOez3WoxLMz9+fSqU24v8pAoZXstzFvtTXg==
X-Received: by 2002:a05:6000:4405:b0:39a:d336:16 with SMTP id ffacd0b85a97d-39c121188d3mr7433253f8f.34.1743504736642;
        Tue, 01 Apr 2025 03:52:16 -0700 (PDT)
Received: from [192.168.2.3] ([109.227.147.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fccfd9bsm153189815e9.20.2025.04.01.03.52.16
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 03:52:16 -0700 (PDT)
Message-ID: <9a6e59fcc08cb1ada36aa01de6987ad9f6aaeaa4.camel@hazent.com>
Subject: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on MicroBlaze:
 Packets only received after some buffer is full
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro.gamez@hazent.com>
To: netdev@vger.kernel.org
Date: Tue, 01 Apr 2025 12:52:15 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

I have a custom PCB board fitting a AMD/Xilinx Artix 7 FPGA with a Microbla=
ze design
inside that uses Xilinx' AXI 1G/2.5G Ethernet Subsystem connected via DMA.

This board and HDL design have been tested and in production since 2016 usi=
ng
kernel 4.4.43 without any issue. The hardware part of the ethernet is DP836=
20
running in 100base-FX mode, which back in the day required a small patch to
dp83848.c from myself that has been in the kernel since.

I am now trying to upgrade to a recent kernel (v6.13) and I'm facing some s=
trange
behavior of the ethernet system. The most probable cause is a misconfigurat=
ion
on my part of the device tree, since things have changed since then and I'v=
e found
the device tree documentation confusing, but I can't discard some kind of b=
ug,
for I have never seem something similar to this.

Relevant boot messages:

xilinx_axienet 40c00000.ethernet eth0: PHY [axienet-40c00000:01] driver [TI=
 DP83620 10/100 Mbps PHY] (irq=3DPOLL)
xilinx_axienet 40c00000.ethernet eth0: configuring for phy/mii link mode
xilinx_axienet 40c00000.ethernet eth0: Link is Up - 100Mbps/Half - flow con=
trol off

Now, transmission from the Microblaze seems to work fine, but reception how=
ever does not.
I run tcpdump on the Microblaze and I can see that there's some kind of buf=
fering occuring,
as a single ARP packet sent from my directly connected computer won't reach=
 tcpdump unless
I send also a big chunk of data via, for example, multicast, or after enoug=
h time of ping flooding.

It's not however a matter of sending a big chunk of data at the beginning, =
it seems like the
buffer empties once full and the process starts back again, so a single pin=
g packet won't be
received after the buffer has emptied.

I can see that interrupts increase, but not as fast as they occur when usin=
g old kernel.
For example, in the ping case, kernel 4.43 will notify that there was an in=
terrupt
for each single ping packet received with ping -c 1 (so no coalescing shena=
nigans can occur),
but the new kernel won't show any increase in the number of interrupts, so =
it means
that the DMA core is either not generating the irq for some reason or isn't=
 even
executing the DMA transfer at all.

Output packets, however, do seem to be sent expeditely and received in my w=
orking computer
as soon as I sent them from the Microblaze.

I guess I may have made some mistake in upgrading the DTS to the new format=
, although
I've tried the two available methods (either setting node "dmas" or using "=
axistream-connected"
property) and both methods result in the same boot messages and behavior.

By crafting properly sized UDP multicast packets (so I don't have to rely o=
n ARP which isn't
working due to timeouts), I've been able to determine I need to send 131072=
 bytes before
reception can truly occur, although it somehow seems like sending multicast=
 UDP
packets won't trigger receiving IRQ unless I have a specific UDP listener p=
rogram running on
the Microblaze. I'm quite confused about that too.

So please, if anyone could inspect the DTS for me and/or guide me on how to=
 debug this, I'd be grateful.

These are the relevant parts of the DTS for kernel 6.13, which I've hand cr=
afted with help
from Documentation/devicetree/bindings and peeking at xilinx_axienet_main.c=
:


axi_ethernet_0_dma: dma@41e00000 {
	compatible =3D "xlnx,axi-dma-1.00.a";
	#dma-cells =3D <1>;
	reg =3D <0x41e00000 0x10000>;
	interrupt-parent =3D <&microblaze_0_axi_intc>;
	interrupts =3D <7 1 8 1>;
	xlnx,addrwidth =3D <32>;
	xlnx,datawidth =3D <32>;
	xlnx,include-sg;
	xlnx,sg-length-width =3D <16>;
	xlnx,include-dre =3D <1>;
	xlnx,axistream-connected =3D <1>;
	xlnx,irq-delay =3D <1>;
	dma-channels =3D <2>;
	clock-names =3D "s_axi_lite_aclk", "m_axi_mm2s_aclk", "m_axi_s2mm_aclk", "=
m_axi_sg_aclk";
	clocks =3D <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>;
	dma-channel@41e00000 {
		compatible =3D "xlnx,axi-dma-mm2s-channel";
		xlnx,include-dre =3D <1>;
		interrupts =3D <7 1>;
		xlnx,datawidth =3D <32>;
	};
	dma-channel@41e00030 {
		compatible =3D "xlnx,axi-dma-s2mm-channel";
		xlnx,include-dre =3D <1>;
		interrupts =3D <8 1>;
		xlnx,datawidth =3D <32>;
	};
};
axi_ethernet_eth: ethernet@40c00000 {
	compatible =3D "xlnx,axi-ethernet-1.00.a";
	reg =3D <0x40c00000 0x40000>, <0x41e00000 0x10000>;
	phy-handle =3D <&phy1>;
	xlnx,rxmem =3D <0x1000>;
	phy-mode =3D "mii";
	xlnx,txcsum =3D <0x2>;
	xlnx,rxcsum =3D <0x2>;
	clock-names =3D "s_axi_lite_clk", "axis_clk", "ref_clk", "mgt_clk";
	clocks =3D <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>;
/*	axistream-connected =3D <&axi_ethernet_0_dma>; */
	dmas =3D <&axi_ethernet_0_dma 0>, <&axi_ethernet_0_dma 1>;
	dma-names =3D "tx_chan0", "rx_chan0";
	mdio {
		#address-cells =3D <1>;
		#size-cells =3D <0>;
		phy1: ethernet-phy@1 {
			device_type =3D "ethernet-phy";
			reg =3D <1>;
		};
	};
};


And these are same parts of the DTS for kernel 4.43 which worked fine.
These were created with help from Xilinx tools.

axi_ethernet_0_dma: dma@41e00000 {
	#dma-cells =3D <1>;
	compatible =3D "xlnx,axi-dma-1.00.a";
	interrupt-parent =3D <&microblaze_0_axi_intc>;
	interrupts =3D <7 1 8 1>;
	reg =3D <0x41e00000 0x10000>;
	xlnx,include-sg ;
	dma-channel@41e00000 {
		compatible =3D "xlnx,axi-dma-mm2s-channel";
		dma-channels =3D <0x1>;
		interrupts =3D <7 1>;
		xlnx,datawidth =3D <0x8>;
		xlnx,device-id =3D <0x0>;
	};
	dma-channel@41e00030 {
		compatible =3D "xlnx,axi-dma-s2mm-channel";
		dma-channels =3D <0x1>;
		interrupts =3D <8 1>;
		xlnx,datawidth =3D <0x8>;
		xlnx,device-id =3D <0x0>;
	};
};
axi_ethernet_eth: ethernet@40c00000 {
	axistream-connected =3D <&axi_ethernet_0_dma>;
	axistream-control-connected =3D <&axi_ethernet_0_dma>;
	clock-frequency =3D <83250000>;
	clocks =3D <&clk_bus_0>;
	compatible =3D "xlnx,axi-ethernet-1.00.a";
	device_type =3D "network";
	interrupt-parent =3D <&microblaze_0_axi_intc>;
	interrupts =3D <3 0>;
	phy-mode =3D "mii";
	reg =3D <0x40c00000 0x40000>;
	xlnx =3D <0x0>;
	xlnx,axiliteclkrate =3D <0x0>;
	xlnx,axisclkrate =3D <0x0>;
	xlnx,gt-type =3D <0x0>;
	xlnx,gtinex =3D <0x0>;
	xlnx,phy-type =3D <0x0>;
	xlnx,phyaddr =3D <0x1>;
	xlnx,rable =3D <0x0>;
	xlnx,rxcsum =3D <0x2>;
	xlnx,rxlane0-placement =3D <0x0>;
	xlnx,rxlane1-placement =3D <0x0>;
	xlnx,rxmem =3D <0x1000>;
	xlnx,rxnibblebitslice0used =3D <0x1>;
	xlnx,tx-in-upper-nibble =3D <0x1>;
	xlnx,txcsum =3D <0x2>;
	xlnx,txlane0-placement =3D <0x0>;
	xlnx,txlane1-placement =3D <0x0>;
	phy-handle =3D <&phy0>;
	axi_ethernetlite_0_mdio: mdio {
		#address-cells =3D <1>;
		#size-cells =3D <0>;
		phy0: phy@1 {
			device_type =3D "ethernet-phy";
			reg =3D <1>;
			ti,rx-internal-delay =3D <7>;
			ti,tx-internal-delay =3D <7>;
			ti,fifo-depth =3D <1>;
		};
	};
};



Best regards,

--=20
=C3=81lvaro G. M.

