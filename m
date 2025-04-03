Return-Path: <netdev+bounces-178962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8FCA79B80
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 07:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95673A7277
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 05:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE22D1494D8;
	Thu,  3 Apr 2025 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="z747dYeK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86B919DFAB
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743659105; cv=none; b=l2PB1PPbmize4qJdTAhGtymQ9knU+bmkC64g92rBovj+qymFDNMA7L8pHdCzu3aUS+Pmr80j94vGD/JVAGUhEBA/DyYJtdw3NTPWL5+0bswcPB0SqbosmDTcZIvIy/dfrR28H2ZZjv+Zcyqut0sXDYi4qWAQB11tgBO7bIR8Poo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743659105; c=relaxed/simple;
	bh=T0RWda93CJvZhFDaGjvEJqXfe8RMDiVjS6EE/wFU7kQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lf9SfGBd+/kbj/MO8css2CSb4DRTvadkSrrBs+BljdNOvf3itfoQwklk0LEYTZ/O9AEVP3tF8AiyohkjamVpi2ihrEoejBa7yjM1crgrTazlpkTYOGnYW1uWQadmdGvjUUjLuwA/H2gxLCxD1OS1ErkFGLoRpSXi2NcnZJU64T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=z747dYeK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43948021a45so4084045e9.1
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 22:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1743659101; x=1744263901; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n50a4wdH4fuJa9CE6QlWo0Q61C3ezcRNXVbBzQ9o9NI=;
        b=z747dYeKFeDogkUWNT9IiALemUsvXei+dPB1wpd/c7taeaA6qJv8zavwHA/MZEyAVT
         VaF83/cITUko7YNOW9mUbLZzhg2vlCMUw7q89sVB7rLc4cO6MIgo84cqmBHc6kTRsdXO
         2wzFoaMreMysbsP65f1YKja3S1RGluXiwzmw/SSv12zf+F44YQcxQN7bm8iv8NbSiVM0
         x9Wt0rfF5XGMIm13TLvZnKcE9/u0frLW9Q+BthIv0TCM7QjX+B6pBczQ2PkRv1mzAMpk
         Ff8eJAJgKybJrCHwIidMF4n0fsqaLV/o8atAnFyrZCif0vLWhQND9/smbOaMGvI5Ay77
         ayIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743659101; x=1744263901;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n50a4wdH4fuJa9CE6QlWo0Q61C3ezcRNXVbBzQ9o9NI=;
        b=mPylNnEXo1XnZQCtIbW6TMXFyL9UZF3h0YwznunX6GqRLPZ58UVYXooRvbvxbpAzmh
         aHfxwqbjB1h4fJa759CIaoquGGhd4c86KnQjlkek2x35WOhJ/5Kqz0TEUt1sh5ygrAoo
         QGbFadt9oj/Dxjj9OXRIOuBo3BvPFiauxKllM+ZCrxK/P8lLM2MX60E1t4yZdaPDSmFI
         UXMzph6kouahonjRM6qjj3UqVMnasLYDDWijN7XfOPJj2I50W7jcl96fIHiHWMG0GlDY
         DjtiA9svknxN+7i2JHL7tnMUA6/Z/ZqmwwSn6lXiHmPL2QKThC2p0ot5XNbrkoAY65qf
         7E/w==
X-Gm-Message-State: AOJu0YwBnoty8aiKGIw3SK6DiMEA3St+iPLSBkkgvpLVuumP4GkCOLiZ
	gBaTFS7vWMtHUJvfsKvQngZ5ePomvJPhJDLPDy/KdXSuzuzWTDCe9/WXfgrKH1GteORiFij8XQU
	ASw==
X-Gm-Gg: ASbGnctMu7DhBOHT3fKhbW1jGfQp07U+1NPdRo7xrwI/V+vIrHgGRh4aBsBK4do3nHb
	1S2aYUl7zdfEZxM5YEe8Rj16nwZG68sSlQ0ajnarUmxjXX6qdydi4/GhUVlPF96D9qlyn9ZF+ec
	91/UXZMa+ombFwVVg/QN+eIGr/ksK5JCMgB8g8Js17wdEbqQIAh4LCWSP4Uk7vFdke3vDJM5JKQ
	Xnl6+mqr1cc1oEOI7wpjilCmEZWfePeGywRUvPELwAHMSaxQ2vJPbAq81VEEzlcOYM4lH+6NgxG
	DqV/vMSl5aiVWD3RlX2CQqjGvZc5UfxFLzIQhNlvSuzj6dUj/Lqj
X-Google-Smtp-Source: AGHT+IFqNtxwJcCe3/OipxZDyGFpFLZtRCA3IInVIL76QE4YawRQ5RfpUBciwCb2MA8PmCWjGNWcNQ==
X-Received: by 2002:a05:600c:6d16:b0:43d:fa59:bced with SMTP id 5b1f17b1804b1-43dfa59bd8fmr96783645e9.32.1743659100587;
        Wed, 02 Apr 2025 22:45:00 -0700 (PDT)
Received: from [192.168.2.3] ([109.227.147.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2f4sm7765695e9.19.2025.04.02.22.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 22:45:00 -0700 (PDT)
Message-ID: <80e2a74d4fcfcc9b3423df13c68b1525a8c41f7f.camel@hazent.com>
Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on
 MicroBlaze: Packets only received after some buffer is full
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro.gamez@hazent.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Date: Thu, 03 Apr 2025 07:44:59 +0200
In-Reply-To: <20250402100039.4cae8073@kernel.org>
References: <9a6e59fcc08cb1ada36aa01de6987ad9f6aaeaa4.camel@hazent.com>
	 <20250402100039.4cae8073@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi


On Wed, 2025-04-02 at 10:00 -0700, Jakub Kicinski wrote:
> +CC Radhey, maintainer of axienet

Thanks, I don't know why I didn't think of that.

So, I can provide a little more information and I definitely believe now th=
ere
are some issues with this driver.

> On Tue, 01 Apr 2025 12:52:15 +0200 =C3=81lvaro "G. M." wrote:
> > I guess I may have made some mistake in upgrading the DTS to the new fo=
rmat, although
> > I've tried the two available methods (either setting node "dmas" or usi=
ng "axistream-connected"
> > property) and both methods result in the same boot messages and behavio=
r.

This has happened not to be true, I'm sorry for the confusion. Using node "=
dmas"
enables use_dmaengine and produces the effect I explained: data is only rec=
eived
after a 2^17 bytes buffer is filled.=20

If I remove "dmas" entry and provide a "axistream-connected" one, things ge=
t a
little better (but see at the end for some DTS notes). In this mode, in whi=
ch
dmaengine is not used but legacy DMA code inside axienet itself, tcpdump -v=
v
shows packets incoming at a normal rate. However, the system is not answeri=
ng to
ARP requests:

00:02:37.800814 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 10.188=
.140.2 tell 10.188.139.1, length 46
00:02:38.801974 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 10.188=
.140.2 tell 10.188.139.1, length 46
00:02:39.804137 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 10.188=
.140.2 tell 10.188.139.1, length 46
00:02:40.806434 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 10.188=
.140.2 tell 10.188.139.1, length 46
00:02:41.808084 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 10.188=
.140.2 tell 10.188.139.1, length 46
00:02:42.810592 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 10.188=
.140.2 tell 10.188.139.1, length 46
00:02:43.813155 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 10.188=
.140.2 tell 10.188.139.1, length 46

Here's the normal answer for a second device running old 4.4.43 kernel
connected to the same switch:

00:21:12.057326 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 10.188=
.140.1 tell 10.188.139.1, length 46
00:21:12.057905 ARP, Ethernet (len 6), IPv4 (len 4), Reply 10.188.140.1 is-=
at 06:00:0a:bc:8c:01 (oui Unknown), length 28
00:21:13.059460 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 10.188=
.140.1 tell 10.188.139.1, length 46
00:21:13.060031 ARP, Ethernet (len 6), IPv4 (len 4), Reply 10.188.140.1 is-=
at 06:00:0a:bc:8c:01 (oui Unknown), length 28
00:21:14.060502 ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 10.188=
.140.1 tell 10.188.139.1, length 46
00:21:14.061051 ARP, Ethernet (len 6), IPv4 (len 4), Reply 10.188.140.1 is-=
at 06:00:0a:bc:8c:01 (oui Unknown), length 28

The funny thing is that once I manually add arp entries in both my computer
and the embedded one, I can establish full TCP communication and iperf3 sho=
ws
a relatively nice speed, similar to the throughput I get with old 4.4.43 ke=
rnel.

# arp -s 10.188.139.1 f4:4d:ad:02:11:29
# iperf3 -c 10.188.139.1
Connecting to host 10.188.139.1, port 5201
[  5] local 10.188.140.2 port 55480 connected to 10.188.139.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.01   sec  3.63 MBytes  30.1 Mbits/sec    0    130 KBytes    =
  =20
[  5]   1.01-2.01   sec  3.75 MBytes  31.5 Mbits/sec    0    130 KBytes    =
  =20
[  5]   2.01-3.01   sec  3.63 MBytes  30.4 Mbits/sec    0    130 KBytes    =
  =20
[  5]   3.01-4.01   sec  3.75 MBytes  31.4 Mbits/sec    0    130 KBytes    =
  =20
[  5]   4.01-5.01   sec  3.75 MBytes  31.4 Mbits/sec    0    130 KBytes    =
  =20
[  5]   5.01-6.01   sec  3.75 MBytes  31.5 Mbits/sec    0    130 KBytes    =
  =20
[  5]   6.01-7.01   sec  3.75 MBytes  31.6 Mbits/sec    0    130 KBytes    =
  =20
[  5]   7.01-7.75   sec  2.63 MBytes  29.5 Mbits/sec    0    130 KBytes    =
  =20
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-7.75   sec  28.6 MBytes  31.0 Mbits/sec    0            sender
[  5]   0.00-7.75   sec  0.00 Bytes  0.00 bits/sec                  receive=
r
iperf3: interrupt - the client has terminated
# iperf3 -c 10.188.139.1 -R
Connecting to host 10.188.139.1, port 5201
Reverse mode, remote host 10.188.139.1 is sending
[  5] local 10.188.140.2 port 45582 connected to 10.188.139.1 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.03   sec  5.13 MBytes  41.9 Mbits/sec                 =20
[  5]   1.03-2.03   sec  5.38 MBytes  44.8 Mbits/sec                 =20
[  5]   2.03-3.02   sec  5.38 MBytes  45.6 Mbits/sec                 =20
[  5]   3.02-4.02   sec  5.38 MBytes  45.2 Mbits/sec                 =20
[  5]   4.02-5.01   sec  5.38 MBytes  45.4 Mbits/sec                 =20
[  5]   5.01-5.30   sec  1.50 MBytes  43.2 Mbits/sec                 =20
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-5.30   sec  0.00 Bytes  0.00 bits/sec                  sender
[  5]   0.00-5.30   sec  28.1 MBytes  44.5 Mbits/sec                  recei=
ver
iperf3: interrupt - the client has terminated

I had never seen a device able to fully stablish communication except for
replying to MAC requests, so I'm not sure what's happening here.


On the other hand, and since I don't know how to debug this ARP issue, I
went back to see if I could diagnose what's happening in DMA Engine mode,
so I peeked at the code and I saw an asymmetry between RX and TX, which
sounded good given that in dmaengine mode TX works perfectly (or so it seem=
s)
and RX is heavily buffered. This asymmetry lies precisely on the number
of SG blocks and number of skb buffers.=20

Both bd_nums are defined in the same way:
        lp->rx_bd_num =3D RX_BD_NUM_DEFAULT; // =3D 1024
        lp->tx_bd_num =3D TX_BD_NUM_DEFAULT; // =3D 128


But the skb ring size is defined in a different fashion:
        lp->tx_skb_ring =3D kcalloc(TX_BD_NUM_MAX, sizeof(*lp->tx_skb_ring)=
, // =3D 4096
                                  GFP_KERNEL);
	...
        lp->rx_skb_ring =3D kcalloc(RX_BUF_NUM_DEFAULT, sizeof(*lp->rx_skb_=
ring), // =3D 128
                                  GFP_KERNEL);

So, for TX we allocate space for up to 4096 buffers but by default use 128.
For RX we allocate space for 128 buffers but somehow are setting 1024 as
the default bd number.

The fact that RX_BD_NUM_DEFAULT is used nowhere else is also a signal
that there was some mistake here, so I went and replaced all RX_BUF_NUM_DEF=
AULT
occurances with RX_BD_NUM_DEFAULT, so that both TX and RX skb rings
are declared and operated with using the same strategy:

  sed -i '/^#define/!s#RX_BUF_NUM_DEFAULT#RX_BD_NUM_MAX#g' xilinx_axienet_m=
ain.c

Doing this solved the buffering problem, although the system still doesn't =
reply
to ARP requests, and when I tried to run an iperf3 test after manually addi=
ng arp tables,
the kernel segfaulted (so I probably shouldn't have blindly 'sed' like that=
 :)

# iperf3 -c 10.188.139.1
Connecting to host 10.188.139.1, port 5201
[  5] local 10.188.140.2 port 46356 connected to 10.188.139.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.01   sec   640 KBytes  5.18 Mbits/sec    3   84.8 KBykernel =
task_size exceed
Oops: Exception in kernel mode, sig: 11
CPU: 0 UID: 0 PID: 147 Comm: iperf3 Not tainted 6.13.8 #13
 Registers dump: mode=3D8269B900
 r1=3D00000000, r2=3D00000000, r3=3D00000000, r4=3D00000010
 r5=3D00000000, r6=3D000005F2, r7=3DFFFF7FFF, r8=3D00000000
 r9=3D00000000, r10=3D00000000, r11=3D00000000, r12=3DCF5FF24C
 r13=3D00000000, r14=3DC241AB70, r15=3DC0383EB8, r16=3D00000000
 r17=3DC0383EC0, r18=3D000005F0, r19=3DC10124A0, r20=3D480F8520
 r21=3D4831F960, r22=3D00000000, r23=3D00000000, r24=3DFFFFFFEA
 r25=3DC12BE0A8, r26=3DC12BE03C, r27=3DC12BE020, r28=3D00000122
 r29=3D00000100, r30=3D000065A2, r31=3DC120F780, rPC=3DC0383EC0
 msr=3D000046A2, ear=3DFFFFFFFA, esr=3D00000312, fsr=3D00000000
Kernel panic - not syncing: Aiee, killing interrupt handler!
---[ end Kernel panic - not syncing: Aiee, killing interrupt handler! ]---
tes      =20

I couldn't see what was wrong with new code, so I just went and replaced
the RX_BD_NUM_DEFAULT value from 1024 down to 128, so it's now the same siz=
e as
its TX counterpart, but the kernel segfaulted again when trying to measure
throughput. Sadly, my kernel debugging abilities are not much stronger than=
 this,
so I'm stuck at this point but firmly believe there's something wrong here,
although I can't see what it is.

Any help will be greatly appreciated.


DTS NOTES:
Using old DMA code inside xilinx_axienet_main.c requires removing "dmas" en=
try
and add a reference to DMA device either via axistream-connected or by addi=
ng
resources manually to the node. Referring to the node linked by axistream-c=
onnected
requires a DMA node to exist, but its compatible string can't be xlnx,axi-d=
ma-1.00.a,
because then AXI DMA driver will lock onto it and axienet will complain abo=
ut
the device being busy. So my solution for this is to use a not compatible s=
tring.
As such, with the following DTS I can establish TCP connections as long as
ARP tables are manually entered:


axi_ethernet_0_dma: dma@41e00000 {
	/* NOTE THE NOT */
	compatible =3D "notxlnx,axi-dma-1.00.a";
	#dma-cells =3D <1>;
	reg =3D <0x41e00000 0x10000>;
	interrupt-parent =3D <&microblaze_0_axi_intc>;
	interrupts =3D <7 1 8 1>;
	xlnx,addrwidth =3D <32>;  // Tama=C3=B1o de direcci=C3=B3n en bits
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
	reg =3D <0x40c00000 0x40000>;
	phy-handle =3D <&phy1>;
	interrupt-parent =3D <&microblaze_0_axi_intc>;
	interrupts =3D <3 0>;
	xlnx,rxmem =3D <0x1000>;
	max-speed =3D <100000>;
	phy-mode =3D "mii";
	xlnx,txcsum =3D <0x2>;
	xlnx,rxcsum =3D <0x2>;
	clock-names =3D "s_axi_lite_clk", "axis_clk", "ref_clk", "mgt_clk";
	clocks =3D <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>;
	axistream-connected =3D <&axi_ethernet_0_dma>;
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

So this mode of working would definitely NOT need AXI DMA, and this hack
with the compatible string should not be needed if the dependency with AXI =
DMA
was removed.

Best regards,

--=20
=C3=81lvaro G. M.

