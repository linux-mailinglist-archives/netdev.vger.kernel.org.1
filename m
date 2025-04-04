Return-Path: <netdev+bounces-179238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF88A7B76A
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 07:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916613B7987
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 05:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24C81607A4;
	Fri,  4 Apr 2025 05:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="PwUx4SRV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36972E62C0
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743745095; cv=none; b=pQW1REsqAt4pnkJh2LlKsp3WTPURUMz+ks62DVI922TQ1IqD61AWKrvaeg/Nfam4//tUxKJxq5Swki+7lOt/q3rZYT+bwZJvw3AxYih2NUdjFuqfr+8BLYBVTL19hsg/XUGlmBYFD/l7IyHjAsIZul3SwH7K1C9VGggQ0cOjuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743745095; c=relaxed/simple;
	bh=bUWd7xCg056Sy9z/tW+OrUOp3iWjHzxnGOqnESFpaQY=;
	h=Message-ID:Subject:From:To:Date:References:Content-Type:
	 MIME-Version; b=QBixVFhDEEVsb9CeRDHTtE0Bw7P7rBcMhakLk/Y0Pi8dMfJnPCTCKtLW19vMyzkg6xS+YRVVbJpCgg9eF4Pra6EBE+OFTwWu0wCfS92GiqvIU7nkb0AXoX5dUjzLYvjA/W4dsbE1KagpA7AIMPwuRCtbzAXL4dOFtL7IjNjbEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=PwUx4SRV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c266c1389so1084438f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 22:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1743745091; x=1744349891; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references:date
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxUJeQ/M4IrY8FL/vOcMQiOKK+o3pje6beF8kdDLlWU=;
        b=PwUx4SRVzogPkdWAwB0ln+CorvaqFXEVqphk23SRaafhsZ591Y+InNkFwscT6uXoR2
         /HuzQ1KZEaPdRcQgv9kE3j1KIk/hpfoo+27AVQmTBTnzG8xusrsasQU/cD2jKItisxhB
         e9vxSUK7E1/5Gswi/ifKgg6J1gGEa1Ywdtvu2iM9w0LvLLdr+V51wcamA0GVVVUHN+aF
         EQ6uNXLzLx61keNlAeEumfKOQ8qlyZTBQDJkkRPI/XzZ8ftm7fYdPjRlClNVAfLXXVyj
         GMC7wYQBfN3YZzbrlEaqY9f0BD/dsrb+V94XEV4Kpt6ZketW1Z1nhCvcM45hpbHu/zMg
         uikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743745091; x=1744349891;
        h=mime-version:user-agent:content-transfer-encoding:references:date
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rxUJeQ/M4IrY8FL/vOcMQiOKK+o3pje6beF8kdDLlWU=;
        b=QqlfPq4ESE4mt/+zgN4n2boKaiCGQbaQObQKdkguYEg1C+6mYBR4AnwQDwkLDQyxJj
         afmifoV+ame+TsaoPB5xe9bivW+jHADdKAcpV2kUVHq3gIrULUqaqJzNE/XuJd0GnX4K
         l8FzXwP6J5T6X676skMAC2R+7R9MwRxrtxoyD1TP8oVcdlQfzfcH5VE9r7EtA2JmOvyZ
         9H6czvFJjnJhbI89i6cPNvIztF9zU48YZ4apysO8NSyDrip4WvOU2TNnVJR4FyS1hIh5
         pJMXZ6Ec6ePdWCMBgss875Tcs/zDOhZF1KYG6Mo4H8kRnxheAPQZA5a8v2mQLK1pexy8
         ZDDA==
X-Gm-Message-State: AOJu0YxS35cnt94TTbyV0DYX/wJbHWpoaIX37VYvlpo3gy5/PxBJZRUb
	d9OXufXppCVsjKkZjTTsIuFUfOzh9Mu7HRZ9fc0oLV/QoODcwUUgSs5YSCa7iKpyk5VqjCU8t2g
	drg==
X-Gm-Gg: ASbGncuLml4LZsm0KiNu/rE+RV5Ex9lTqAAMKMtL97FzQSzFgdKUoM3Wpy1oAVkLNJq
	gzrz+F2HNkTJxyYCaXFOF2gJ5yHc/41c+faCNqe/FplSMQVJX2+wI8MpUzbp0rIoPcMjRr+dZYF
	2nfpgQN+4tanORI1sCDzcHuaKtshn1Tqa7yF6C8L0rifSjuf29RoqWe9vcGroowSpGmMa5RnJym
	iRBhd6jgETBh0mGygnPCBFBN4FYZc2UCivi7I7TkoZFVN+2MBSeNRhJIo4UVVd1z3WytpblPFU/
	BVt/IGTi0HC5x64jDCG7g5JvdEXDzhiq0PrSBoRQX++Hf6NiPkBj
X-Google-Smtp-Source: AGHT+IG7w3/pxPhwuQTumDr+KGzqWxQ45Gr+jnXzY57hmrQCbZu/d5JEf5E/oGpJMWCEMwfusB1q2g==
X-Received: by 2002:a5d:64cd:0:b0:390:eebc:6f32 with SMTP id ffacd0b85a97d-39d1466220fmr841271f8f.48.1743745090503;
        Thu, 03 Apr 2025 22:38:10 -0700 (PDT)
Received: from [192.168.2.3] ([109.227.147.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226b39sm3383738f8f.85.2025.04.03.22.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 22:38:10 -0700 (PDT)
Message-ID: <4909677fbf94dcbe5949a2a88292439302109920.camel@hazent.com>
Subject: Fwd: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on
 MicroBlaze: Packets only received after some buffer is full
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro.gamez@hazent.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	 <kuba@kernel.org>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Date: Fri, 04 Apr 2025 07:38:09 +0200
References: <c9861f0b98ecd199873585e188099b6fa877cc56.camel@hazent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Sorry, I'm resending this email in text-only mode, I sent HTML version and =
got rejected by the list.

Hi Suraj,

On Thu, 2025-04-03 at 13:58 +0000, Gupta, Suraj wrote:
> >=20
> > If I remove "dmas" entry and provide a "axistream-connected" one, thing=
s get a little
> > better (but see at the end for some DTS notes). In this mode, in which =
dmaengine is
> > not used but legacy DMA code inside axienet itself, tcpdump -vv shows p=
ackets
> > incoming at a normal rate. However, the system is not answering to ARP =
requests:
> >=20
> Could you please check ifconfig for any packet drop/error?

In all three cases (using old dma style, using dmaengine with default value=
s and using dmaengine with buffers set to 128)
the behavior is the same:

After a few udp packets:

eth0      Link encap:Ethernet  HWaddr 06:00:0A:BC:8C:02 =20
          inet addr:10.188.140.2  Bcast:10.188.143.255  Mask:255.255.248.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:213 errors:0 dropped:81 overruns:0 frame:0
          TX packets:17 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:95233 (93.0 KiB)  TX bytes:738 (738.0 B)

After manually adding =C2=A0ARP entries and running a short run of iperf3:

# iperf3 -c 10.188.139.1
Connecting to host 10.188.139.1, port 5201
[  5] local 10.188.140.2 port 54004 connected to 10.188.139.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.01   sec  3.38 MBytes  28.2 Mbits/sec    0    133 KBytes    =
  =20
[  5]   1.01-2.00   sec  3.75 MBytes  31.5 Mbits/sec    0    133 KBytes    =
  =20
[  5]   2.00-3.01   sec  3.75 MBytes  31.4 Mbits/sec    0    133 KBytes    =
  =20
[  5]   3.01-4.01   sec  3.63 MBytes  30.4 Mbits/sec    0    133 KBytes    =
  =20
[  5]   4.01-5.00   sec  3.75 MBytes  31.6 Mbits/sec    0    133 KBytes    =
  =20
[  5]   5.00-6.00   sec  3.63 MBytes  30.4 Mbits/sec    0    133 KBytes    =
  =20
[  5]   6.00-7.00   sec  3.75 MBytes  31.5 Mbits/sec    0    133 KBytes    =
  =20
[  5]   7.00-8.01   sec  3.63 MBytes  30.2 Mbits/sec    0    133 KBytes    =
  =20
[  5]   8.01-9.01   sec  3.63 MBytes  30.4 Mbits/sec    0    133 KBytes    =
  =20

^C[  5]   9.01-46.69  sec  4.50 MBytes  1.00 Mbits/sec    0    133 KBytes  =
    =20
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-46.69  sec  37.5 MBytes  6.74 Mbits/sec    0            sender
[  5]   0.00-46.69  sec  0.00 Bytes  0.00 bits/sec                  receive=
r
iperf3: interrupt - the client has terminated
# ifconfig=20
eth0      Link encap:Ethernet  HWaddr 06:00:0A:BC:8C:02 =20
          inet addr:10.188.140.2  Bcast:10.188.143.255  Mask:255.255.248.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:14121 errors:0 dropped:106 overruns:0 frame:0
          TX packets:27360 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:1015380 (991.5 KiB)  TX bytes:41127297 (39.2 MiB)

The number of RX and dropped packets (81/213 vs 106/14121) doesn't seem pro=
portional to the number of received packets.

I've been able to gather that dropped packets increase by 1 with each arpin=
g that I send to the microblaze, but
*only* if tcpdump is *not* running.

So, I can run tcpdump -vv, send quite a lot of arping, I see them all on sc=
reen and dropped number of packets do not increase.
Once I stop tcpdump, I send a single arping and tx dropped packets increase=
 by 1, every time.


> > On the other hand, and since I don't know how to debug this ARP issue, =
I went back
> > to see if I could diagnose what's happening in DMA Engine mode, so I pe=
eked at the
> > code and I saw an asymmetry between RX and TX, which sounded good given=
 that
> > in dmaengine mode TX works perfectly (or so it seems) and RX is heavily=
 buffered.
> > This asymmetry lies precisely on the number of SG blocks and number of =
skb
> > buffers.
> >=20

> > I couldn't see what was wrong with new code, so I just went and replace=
d the
> > RX_BD_NUM_DEFAULT value from 1024 down to 128, so it's now the same siz=
e as
> > its TX counterpart, but the kernel segfaulted again when trying to meas=
ure
> > throughput. Sadly, my kernel debugging abilities are not much stronger =
than this, so
> > I'm stuck at this point but firmly believe there's something wrong here=
, although I
> > can't see what it is.
> >=20
> > Any help will be greatly appreciated.
> >=20
> This doesn't looks like be the reason as driver doesn't uses lp->rx_bd_nu=
m  and lp->tx_bd_num to traverse skb ring in DMAengine flow. It uses axiene=
t_get_rx_desc() and axienet_get_tx_desc() respectively, which uses same siz=
e as allocated.
> Only difference between working and non-working I can see is increasing R=
x skb ring size. But later you mentioned you tried to bring it down to 128,=
 could you please confirm small size transfer still works?

Setting this number to a low value seems to solve the buffering issue, but =
not the thing about missed ARP packets.


> FYI, basic ping and iperf both works for us in DMAengine flow for AXI eth=
ernet 1G designs. We tested for full-duplex mode. But I can see half duplex=
 in your case, could you please confirm if that is expected and correct?

Our connection is via a fiber SFP =C2=A0(should've mentioned that earlier, =
sorry) or with an cabled SFP
(which I am using right now), through dp83620, which in this mode does not =
support autonegotiation
but as far as I know init should support full duplex, I'll check it out and=
 reach back.

Now that you noticed this, I can tell you that kernel 4.4.43 reported full =
duplex, and kernel 6.13
reports full duplex only in dmaengine mode, in old dma mode it reports half=
 duplex.

Old kernel:
# ethtool eth0
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full=20
                                100baseT/Half 100baseT/Full=20
        Supported pause frame use: No
        Supports auto-negotiation: Yes
        Advertised link modes:  100baseT/Full=20
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 1
        Transceiver: external
        Auto-negotiation: off
        Link detected: yes


Configuring network: xilinx_axienet 40c00000.ethernet eth0: PHY [axienet-40=
c00000:01] driver [TI DP83620 10/100 Mbps PHY] (irq=3DPOLL)
xilinx_axienet 40c00000.ethernet eth0: configuring for phy/mii link mode
xilinx_axienet 40c00000.ethernet eth0: Link is Up - 100Mbps/Full - flow con=
trol off


Thanks, best regards,

--=C2=A0
=C3=81lvaro G. M.


