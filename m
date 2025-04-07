Return-Path: <netdev+bounces-179539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE718A7D8CF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D474E178E3E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A322687C;
	Mon,  7 Apr 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="eWpTeNlf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1657A228CA9
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016266; cv=none; b=GbbA8g3cGNKVSoUBraa9952cFHeDYKhBZvlaVNCMV2Z2qOelZAgrmm3CDnhKVBWLlYVjplBg4HN2zA5V/HzPH5ttkPxLf8z9r3teva5hpO/KmYrYX5nkN66tIa9MaIX9xXCmu6/yCNTbdjpazRNvoKVN30pnAfnEfBcXZijKilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016266; c=relaxed/simple;
	bh=RpbN82QUrdqC04tbCpk+G+olXpWnxygy3kggO/x12Pg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UxxGicCfTL8sluio1UvYJTf/DA51W04nMLl5Ee6H5h3gz0JB4pYqpm3j/DR7rVv3QOkzP1nFp9go5Ilxy8nUOP6Z4adklrmcR7QKE5UeSmk8l8R7e3SzEXIN0pYmdu7ONj/pAEkH3Evtbklx2SBrUJOtQ7xQGfdnyKxzQXJZxio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=eWpTeNlf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43690d4605dso26627085e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1744016261; x=1744621061; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTFgZ0+8zV1IjemYSyGmwV/+Ag+RISmj9XlH++ptlDw=;
        b=eWpTeNlfAHz9E1gc/dYsmaIyot7fDDxNgeBUzZeJwZwdeir8UVh3LO4BP0jA1sU7S+
         82LUGWtZLRqYEQAKpkMhvZZJ11pVMH90AJF2ppGTz1+IqatPqWT8mF0I7SKenEfozKxu
         rMLEMRofGdGwuHbMFnlTbtbOm3Ywm3XKwyxiJC+qQjqVrWOhvCucunlvhUSmC7CNd13F
         EwziY9Han15841cElYN9etzak+1I23iAOuj8GAlSIHV3HZYnceqJbTY8qi5HqxhAT2MN
         gA7Hv185dm7lU+dbtAYDd4leWVo1mlnmA5pt3Zf5cI7RkqJawoHcVqZCcP11UQuWGGXp
         k0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016261; x=1744621061;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTFgZ0+8zV1IjemYSyGmwV/+Ag+RISmj9XlH++ptlDw=;
        b=WWiFhgUP1aa+EWm8yqKQvABJawrAcet7EiKnOV6cGz7cKsGLgL2XFMnpkuoOF/YBPc
         SfTe3fHSe0C3wKsF+ZtdNe6+Wa8Kh0nlZiPrKkb6ORHcIeV55IQrY7DuIk19vrZV3tk3
         Y8IKSwJu1LX9F0m4BihAr+zUdZVr2r76r2Rh9LwqahTn4YHefE8A16dD9DKGQ7RD3FYY
         JRZe8f9fHVQJL9+E+itg6lw02cM/H3Go/pRflL3vp6HmMn/UzFI+CSXJ62Qty6TEN0Tk
         qhXRqI9xo7S2phyBj9rpQ5+M3iNciK7VCfuN+DCL8OBVwvU3cFWqzMJ03tkSLJh6nzG3
         hbqw==
X-Gm-Message-State: AOJu0YwUmo14bIzB4maLv3/ydU+bIMtbBuyWu6NBK0bY9c6fstADahxJ
	A7cPbuvXWbdxB36UShsZgmwv/92KxK+ZmStAJ1uNfr4uJ2JzXUEHO9CoTXTLxZSZM60m0RLWUeG
	umQ==
X-Gm-Gg: ASbGncumW/vHI1JJcgNA0W6cEw7nxOsQpX11LdYjmfuK2QbfbJkb8gb9kfpfeDP6Ox4
	hvq+N8FNmu/rYxZ4QKGW2whMuSVywBZ0VzL1mr2Q5PGp6L8gKSbhWcj3UQJJVTsSYXSrzElzIhD
	Zm5tz9JsFWzlugD8lzOUSxHrEFCk8o7OElr1Ob6S4GpAn06vZ2xBmbdcBpoMbv7e2P0Em8pn4gc
	/lHOiu7LvZiVCNfXGrM7q61Kj7VG/s4fxRCN9u8gdUp2AAX8LN4nCETciRJUaTDJypPrLxvwIkh
	IVAUjYdjggafV2mboBfI5aVwIak+SdEmw0PjnjZdRPLL0Bccozdh
X-Google-Smtp-Source: AGHT+IE1Uc0n2vpEVttP+KcmJr13D+HfiuTM3dv+J+hq9pDaKZ8zOttp6gbly61u6lLXOsD9kj5awQ==
X-Received: by 2002:a05:600c:1385:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-43ecf85f4e8mr102702295e9.12.1744016261149;
        Mon, 07 Apr 2025 01:57:41 -0700 (PDT)
Received: from [192.168.2.3] ([109.227.147.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1630de9sm125763565e9.1.2025.04.07.01.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:57:40 -0700 (PDT)
Message-ID: <2a220c71a7428dd38a18ebd17408f4d7d8e0cc33.camel@hazent.com>
Subject: Re: Fwd: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on
 MicroBlaze: Packets only received after some buffer is full
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro.gamez@hazent.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	 <kuba@kernel.org>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Date: Mon, 07 Apr 2025 10:57:39 +0200
In-Reply-To: <4909677fbf94dcbe5949a2a88292439302109920.camel@hazent.com>
References: <c9861f0b98ecd199873585e188099b6fa877cc56.camel@hazent.com>
	 <4909677fbf94dcbe5949a2a88292439302109920.camel@hazent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi again

> On Thu, 2025-04-03 at 13:58 +0000, Gupta, Suraj wrote:
> >=20
> >=20
> > FYI, basic ping and iperf both works for us in DMAengine flow for AXI e=
thernet=C2=A0
> > 1G designs. We tested for full-duplex mode. But I can see half duplex i=
n your case,
> > could you please confirm if that is expected and correct?

I've implemented a very basic block diagram on Vivado for Digilent Nexys Vi=
deo board,
which fits a 1G phy from realtek. The behaviour is exactly the same: using =
dmaengine
makes it so that a great big chunk of data needs to arrive before it reache=
s the kernel,
whereas using old dma code in axienet.c, even though doesn't have that buff=
ering effect,
still drops ARP request packets.

The exact same design works in the same kernel I had running on my board, 4=
.4.43

If you have this tested on other boards, I must assume it's just a matter o=
f my DTS
being defective, so I'm attaching the whole thing here alongside kernel con=
fig,
and I've created a github repo with the buildroot and Vivado projects in ca=
se you
want to take a look at them: https://github.com/agamez/axinet_debug, but it=
's
simply the basics. I've included snapshots of DMA and ethernet configuratio=
n
in the repository so you don't even need to create it if you don't want to.

# ifconfig eth0 192.168.99.2
xilinx_axienet 40c00000.ethernet eth0: PHY [axienet-40c00000:01] driver [RT=
L8211E Gigabit Ethernet] (irq=3DPOLL)
xilinx_axienet 40c00000.ethernet eth0: configuring for phy/rgmii link mode
xilinx_axienet 40c00000.ethernet eth0: Link is Up - 1Gbps/Full - flow contr=
ol rx/tx

# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 02:10:20:30:40:50 =20
          inet addr:192.168.99.2  Bcast:192.168.99.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2 errors:0 dropped:2 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:340 (340.0 B)  TX bytes:0 (0.0 B)



/dts-v1/;
/ {
	#address-cells =3D <1>;
	#size-cells =3D <1>;
	compatible =3D "xlnx,microblaze";
	model =3D "Xilinx MicroBlaze";
	cpus {
		#address-cells =3D <1>;
		#cpus =3D <1>;
		#size-cells =3D <0>;
		microblaze_0: cpu@0 {
			reg =3D <0>;
			bus-handle =3D <&amba_pl>;
			clock-frequency =3D <100000000>;
			clocks =3D <&clk_cpu>;
			compatible =3D "xlnx,microblaze-9.5";
			d-cache-baseaddr =3D <0x80000000>;
			d-cache-highaddr =3D <0x8fffffff>;
			d-cache-line-size =3D <0x10>;
			d-cache-size =3D <0x8000>;
			device_type =3D "cpu";
			i-cache-baseaddr =3D <0x80000000>;
			i-cache-highaddr =3D <0x8fffffff>;
			i-cache-line-size =3D <0x20>;
			i-cache-size =3D <0x8000>;
			interrupt-handle =3D <&microblaze_0_axi_intc>;
			model =3D "microblaze,9.5";
			timebase-frequency =3D <100000000>;
			xlnx,addr-tag-bits =3D <0xd>;
			xlnx,allow-dcache-wr =3D <0x1>;
			xlnx,allow-icache-wr =3D <0x1>;
			xlnx,area-optimized =3D <0x0>;
			xlnx,async-interrupt =3D <0x1>;
			xlnx,avoid-primitives =3D <0x0>;
			xlnx,base-vectors =3D <0x00000000>;
			xlnx,branch-target-cache-size =3D <0x0>;
			xlnx,cache-byte-size =3D <0x8000>;
			xlnx,d-axi =3D <0x1>;
			xlnx,d-lmb =3D <0x1>;
			xlnx,d-lmb-mon =3D <0x0>;
			xlnx,data-size =3D <0x20>;
			xlnx,dc-axi-mon =3D <0x0>;
			xlnx,dcache-addr-tag =3D <0xd>;
			xlnx,dcache-always-used =3D <0x1>;
			xlnx,dcache-byte-size =3D <0x8000>;
			xlnx,dcache-data-width =3D <0x0>;
			xlnx,dcache-force-tag-lutram =3D <0x0>;
			xlnx,dcache-line-len =3D <0x4>;
			xlnx,dcache-use-writeback =3D <0x0>;
			xlnx,dcache-victims =3D <0x8>;
			xlnx,debug-counter-width =3D <0x20>;
			xlnx,debug-enabled =3D <0x1>;
			xlnx,debug-event-counters =3D <0x5>;
			xlnx,debug-external-trace =3D <0x0>;
			xlnx,debug-latency-counters =3D <0x1>;
			xlnx,debug-profile-size =3D <0x0>;
			xlnx,debug-trace-size =3D <0x2000>;
			xlnx,div-zero-exception =3D <0x1>;
			xlnx,dp-axi-mon =3D <0x0>;
			xlnx,dynamic-bus-sizing =3D <0x0>;
			xlnx,ecc-use-ce-exception =3D <0x0>;
			xlnx,edge-is-positive =3D <0x1>;
			xlnx,enable-discrete-ports =3D <0x0>;
			xlnx,endianness =3D <0x1>;
			xlnx,fault-tolerant =3D <0x0>;
			xlnx,fpu-exception =3D <0x0>;
			xlnx,freq =3D <0x4f64b50>;
			xlnx,fsl-exception =3D <0x0>;
			xlnx,fsl-links =3D <0x0>;
			xlnx,i-axi =3D <0x0>;
			xlnx,i-lmb =3D <0x1>;
			xlnx,i-lmb-mon =3D <0x0>;
			xlnx,ic-axi-mon =3D <0x0>;
			xlnx,icache-always-used =3D <0x1>;
			xlnx,icache-data-width =3D <0x0>;
			xlnx,icache-force-tag-lutram =3D <0x0>;
			xlnx,icache-line-len =3D <0x8>;
			xlnx,icache-streams =3D <0x1>;
			xlnx,icache-victims =3D <0x8>;
			xlnx,ill-opcode-exception =3D <0x1>;
			xlnx,imprecise-exceptions =3D <0x0>;
			xlnx,interconnect =3D <0x2>;
			xlnx,interrupt-is-edge =3D <0x0>;
			xlnx,interrupt-mon =3D <0x0>;
			xlnx,ip-axi-mon =3D <0x0>;
			xlnx,lockstep-select =3D <0x0>;
			xlnx,lockstep-slave =3D <0x0>;
			xlnx,mmu-dtlb-size =3D <0x4>;
			xlnx,mmu-itlb-size =3D <0x2>;
			xlnx,mmu-privileged-instr =3D <0x0>;
			xlnx,mmu-tlb-access =3D <0x3>;
			xlnx,mmu-zones =3D <0x2>;
			xlnx,num-sync-ff-clk =3D <0x2>;
			xlnx,num-sync-ff-clk-debug =3D <0x2>;
			xlnx,num-sync-ff-clk-irq =3D <0x1>;
			xlnx,num-sync-ff-dbg-clk =3D <0x1>;
			xlnx,number-of-pc-brk =3D <0x1>;
			xlnx,number-of-rd-addr-brk =3D <0x0>;
			xlnx,number-of-wr-addr-brk =3D <0x0>;
			xlnx,opcode-0x0-illegal =3D <0x1>;
			xlnx,optimization =3D <0x0>;
			xlnx,pc-width =3D <0x20>;
			xlnx,pvr =3D <0x2>;
			xlnx,pvr-user1 =3D <0x00>;
			xlnx,pvr-user2 =3D <0x00000000>;
			xlnx,reset-msr =3D <0x00000000>;
			xlnx,sco =3D <0x0>;
			xlnx,trace =3D <0x0>;
			xlnx,unaligned-exceptions =3D <0x1>;
			xlnx,use-barrel =3D <0x1>;
			xlnx,use-branch-target-cache =3D <0x0>;
			xlnx,use-config-reset =3D <0x0>;
			xlnx,use-dcache =3D <0x1>;
			xlnx,use-div =3D <0x1>;
			xlnx,use-ext-brk =3D <0x0>;
			xlnx,use-ext-nm-brk =3D <0x0>;
			xlnx,use-extended-fsl-instr =3D <0x0>;
			xlnx,use-fpu =3D <0x0>;
			xlnx,use-hw-mul =3D <0x2>;
			xlnx,use-icache =3D <0x1>;
			xlnx,use-interrupt =3D <0x2>;
			xlnx,use-mmu =3D <0x3>;
			xlnx,use-msr-instr =3D <0x1>;
			xlnx,use-pcmp-instr =3D <0x1>;
			xlnx,use-reorder-instr =3D <0x1>;
			xlnx,use-stack-protection =3D <0x0>;
		};
	};
	clocks {
		#address-cells =3D <1>;
		#size-cells =3D <0>;
		clk_cpu: clk_cpu@0 {
			#clock-cells =3D <0>;
			clock-frequency =3D <100000000>;
			clock-output-names =3D "clk_cpu";
			compatible =3D "fixed-clock";
			reg =3D <0>;
		};
		clk_bus_0: clk_bus_0@1 {
			#clock-cells =3D <0>;
			clock-frequency =3D <100000000>;
			clock-output-names =3D "clk_bus_0";
			compatible =3D "fixed-clock";
			reg =3D <1>;
		};
	};
	amba_pl: amba_pl {
		#address-cells =3D <1>;
		#size-cells =3D <1>;
		compatible =3D "simple-bus";
		ranges ;
		microblaze_0_axi_intc: interrupt-controller@41200000 {
			#interrupt-cells =3D <2>;
			compatible =3D "xlnx,xps-intc-1.00.a";
			interrupt-controller ;
			reg =3D <0x41200000 0x10000>;
			xlnx,kind-of-intr =3D <0x06>;
			xlnx,num-intr-inputs =3D <0x06>;
		};
		axi_timer_0: timer@41c00000 {
			clock-frequency =3D <100000000>;
			clocks =3D <&clk_bus_0>;
			compatible =3D "xlnx,xps-timer-1.00.a";
			interrupt-parent =3D <&microblaze_0_axi_intc>;
			interrupts =3D <0 2>;
			reg =3D <0x41c00000 0x10000>;
			xlnx,count-width =3D <0x20>;
			xlnx,gen0-assert =3D <0x1>;
			xlnx,gen1-assert =3D <0x1>;
			xlnx,one-timer-only =3D <0x0>;
			xlnx,trig0-assert =3D <0x1>;
			xlnx,trig1-assert =3D <0x1>;
		};
		axi_uartlite_0: serial@40600000 {
			clock-frequency =3D <100000000>;
			clocks =3D <&clk_bus_0>;
			compatible =3D "xlnx,xps-uartlite-1.00.a";
			current-speed =3D <115200>;
			device_type =3D "serial";
			interrupt-parent =3D <&microblaze_0_axi_intc>;
			interrupts =3D <1 0>;
			port-number =3D <0>;
			reg =3D <0x40600000 0x10000>;
			xlnx,baudrate =3D <0x2580>;
			xlnx,data-bits =3D <0x8>;
			xlnx,odd-parity =3D <0x0>;
			xlnx,s-axi-aclk-freq-hz-d =3D "100.00";
			xlnx,use-parity =3D <0x0>;
		};
		axi_ethernet_0_dma: dma@41e00000 {
			compatible =3D "xlnx,axi-dma-1.00.a";
			#dma-cells =3D <1>;
			reg =3D <0x41e00000 0x10000>;
			interrupt-parent =3D <&microblaze_0_axi_intc>;
			interrupts =3D <4 1 5 1>;
			xlnx,addrwidth =3D <32>;
			xlnx,datawidth =3D <32>;
			xlnx,include-sg;
			xlnx,sg-length-width =3D <16>;
			xlnx,include-dre =3D <1>;
			xlnx,axistream-connected =3D <1>;
			xlnx,irq-delay =3D <0>;
			dma-channels =3D <2>;
			clock-names =3D "s_axi_lite_aclk", "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",=
 "m_axi_sg_aclk";
			clocks =3D <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>;
			dma-channel@41e00000 {
				compatible =3D "xlnx,axi-dma-mm2s-channel";
				xlnx,include-dre =3D <1>;
				interrupts =3D <4 1>;
				xlnx,datawidth =3D <32>;
			};
			dma-channel@41e00030 {
				compatible =3D "xlnx,axi-dma-s2mm-channel";
				xlnx,include-dre =3D <1>;
				interrupts =3D <5 1>;
				xlnx,datawidth =3D <32>;
			};
		};
		axi_ethernet_eth: ethernet@40c00000 {
			compatible =3D "xlnx,axi-ethernet-1.00.a";
			reg =3D <0x40c00000 0x40000>;
			phy-handle =3D <&phy1>;
			interrupt-parent =3D <&microblaze_0_axi_intc>;
			interrupts =3D <3 0>;
			xlnx,rxmem =3D <0x8000>;
			max-speed =3D <100000>;
			phy-mode =3D "rgmii";
			xlnx,txcsum =3D <0x2>;
			xlnx,rxcsum =3D <0x2>;
			clock-names =3D "s_axi_lite_clk", "axis_clk", "ref_clk", "mgt_clk";
			clocks =3D <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>;
			axistream-connected =3D <&axi_ethernet_0_dma>;
			dmas =3D <&axi_ethernet_0_dma 0>, <&axi_ethernet_0_dma 1>;
			dma-names =3D "tx_chan0", "rx_chan0";
			axi_ethernetlite_0_mdio: mdio {
				#address-cells =3D <1>;
				#size-cells =3D <0>;
				phy1: phy@1 {
				/*	compatible =3D "ethernet-phy-id001c.c915", "realtek,RTL8211E", "ethe=
rnet-phy-ieee802.3-c22"; */
					device_type =3D "ethernet-phy";
					reg =3D <1>;
				};
			};
		};

	};
};
/ {
	chosen {
		bootargs =3D "console=3DttyUL0,9600 uio_pdrv_genirq.of_id=3Dgeneric-uio";
		linux,stdout-path =3D &axi_uartlite_0;
		stdout-path =3D &axi_uartlite_0;
	};
	aliases {
		serial0 =3D &axi_uartlite_0;
	};
	memory {
		device_type =3D "memory";
		reg =3D <0x80000000 0x0fffffff>;
	};
};
&axi_ethernet_eth {
	local-mac-address =3D [02 10 20 30 40 50];
};


This is my kernel configuration. Buildroot sets later initramfs.

CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_PREEMPT=3Dy
CONFIG_LOG_BUF_SHIFT=3D16
CONFIG_KERNEL_BASE_ADDR=3D0x80000000
CONFIG_XILINX_MICROBLAZE0_FAMILY=3D"artix7"
CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=3D1
CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR=3D1
CONFIG_XILINX_MICROBLAZE0_USE_BARREL=3D1
CONFIG_XILINX_MICROBLAZE0_USE_DIV=3D1
CONFIG_XILINX_MICROBLAZE0_USE_HW_MUL=3D2
CONFIG_XILINX_MICROBLAZE0_USE_FPU=3D2
CONFIG_XILINX_MICROBLAZE0_HW_VER=3D"8.30.a"
CONFIG_HZ_100=3Dy
CONFIG_CMDLINE_BOOL=3Dy
CONFIG_CMDLINE=3D"earlycon console=3DttyUL0,9600"
CONFIG_HIGHMEM=3Dy
CONFIG_NET=3Dy
CONFIG_PACKET=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_DEVTMPFS=3Dy
CONFIG_DEVTMPFS_MOUNT=3Dy
CONFIG_MTD=3Dy
CONFIG_MTD_CMDLINE_PARTS=3Dy
CONFIG_MTD_BLOCK=3Dy
CONFIG_MTD_SPI_NOR=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_XILINX_AXI_EMAC=3Dy
CONFIG_REALTEK_PHY=3Dy
CONFIG_DP83848_PHY=3Dy
CONFIG_DP83620_PHY=3Dy
CONFIG_DP83869_PHY=3Dy
CONFIG_SERIAL_UARTLITE=3Dy
CONFIG_SERIAL_UARTLITE_CONSOLE=3Dy
CONFIG_I2C=3Dy
CONFIG_I2C_CHARDEV=3Dy
CONFIG_I2C_XILINX=3Dy
CONFIG_SPI=3Dy
CONFIG_SPI_XILINX=3Dy
CONFIG_SPI_SPIDEV=3Dy
CONFIG_GPIOLIB=3Dy
CONFIG_GPIO_XILINX=3Dy
CONFIG_SENSORS_IIO_HWMON=3Dy
CONFIG_REGULATOR=3Dy
CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
CONFIG_FB=3Dy
CONFIG_FB_XILINX=3Dy
CONFIG_DMADEVICES=3Dy
CONFIG_XILINX_DMA=3Dy
CONFIG_UIO=3Dy
CONFIG_UIO_PDRV_GENIRQ=3Dy
CONFIG_IIO=3Dy
CONFIG_AD799X=3Dy
CONFIG_XILINX_XADC=3Dy
CONFIG_JFFS2_FS=3Dy
CONFIG_SQUASHFS=3Dy
CONFIG_SQUASHFS_LZ4=3Dy
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=3Dy
CONFIG_ROMFS_FS=3Dy
CONFIG_ROMFS_BACKED_BY_BOTH=3Dy
CONFIG_NFS_FS=3Dy
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_MAGIC_SYSRQ=3Dy


Thanks a lot,

--=20
=C3=81lvaro G. M.

