Return-Path: <netdev+bounces-180763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 698A7A8259C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6C14A3729
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1C226159A;
	Wed,  9 Apr 2025 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="HeQePJiY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683B629A0
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204203; cv=none; b=oW5hilFZPHDHfDWQMTfcO1HjXueKYBemmRhqX94dHxWs0FC01tKBL+yChE/R6zvOwzit+D3EfcgMWQglHGnVdbbsQD3sIFuWhvCKTNhmwQopGaZLIIjKkvg5laPUi8etFKwagN6VcQ136z3LX3lASh+ymGhuU7ymrYYSUiP6efY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204203; c=relaxed/simple;
	bh=0QsZXp1kwnYMT0ririRLCSH8gnC7cPSbbcK+C5vJ4rU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CbGQtv2grNWML5Va259tdkaFWD4EHhSrbbU1u9kT5AbE87S7CKCgKGM4t2EqIxhb+mD+HnT7JP3vDLfjiOMfRICMFcVZAeMhznSe9pKxV/WNaDzjNzCnHkt2fKifQxluXM+QgFVaO5zwvoZ4B81VIlLFf9O6KnqCF2Qf9coAjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=HeQePJiY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso833847666b.3
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 06:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1744204198; x=1744808998; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x+KfK/XzOXfwWuXD/PpqYGuODz7cec1/ltmqrDc8nps=;
        b=HeQePJiYF6pW9+Wc1GweKP1IXhjzdmCju9B0PCRxZidhx/Lb44NZUfWsG0qyvhvd41
         V9724MKGGpp5T/rpQIoPYWlVR/UDVT+Zh3xsvWXY+i8s22ZgQNZtkSB078FPZs60Yw3H
         edoeUUCqpZmDr80gESAB+/pqaVMP/ENju6CsA8sy6mldVlpnqLMmtKGw04N6ZWgA1qJB
         BuntnIFOetR22HPbGWxeCKWvD8Ku31IpmnNz9s4OHm92cmOdus7mxncAyFuXkkBQfBlV
         7EKl5b+D8UB6C45hb9pulkZUMBS6OoJWTB90hu0xe0mqarglCrC3kd4DTouqbR6UcZMD
         lxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744204198; x=1744808998;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x+KfK/XzOXfwWuXD/PpqYGuODz7cec1/ltmqrDc8nps=;
        b=p/lFCYmK+AMMz1uHL2ZSXoxuiI+nqvCWZCGDsjj7daYzvZ8YqOJXAwAcIuM9lPpFrn
         oabfdt4HCHYfMS5SkycXV9H1M/qDt6FZ44H9zuHuRhDYaUA6i6ooBnbhscDaCw2cRDEm
         p+5UiBZlR45bKS0lPFWChyVuM50p6NEAUloRgeRt190kkO5OPbOfVEXEGlqn3MppxZpT
         rvHM0O0HeZQvQnHupaffPA/J93uY15ZovsP4k/zSqZFTiGoiVUdWFGwgYDHXMZZj7EjA
         DeDJh6hE3NF8rWcHXH/VlMtC7RBnh4HwkfadzCf1MBTNOw3vfA89cL3bXTSbs2/i7dkd
         hpOw==
X-Gm-Message-State: AOJu0Ywjir0tA5su5yjv8SZ+IpcoLcelP02fvzIxH7KgGf9RtdjtFXSW
	6DEnfTR2dqoczY/1Wm0ZmUvKpIbBuM89gkZ85ELKgIMhlBrqrwaHjQbkR/siUg==
X-Gm-Gg: ASbGncvXDORNc35G+X0EqUut1folIvRDGR5PB+dgbWYRJIqRVhqgkDGfhAi5NGjYN7G
	eEx/ZEAz1a3EhoAzq7VvDqKt1oL/Q1C0eLnP5DbZkcTvmwFYvXCQVVfXcEIxGhod3hYmnqnfowe
	qjYpxd8EIVFdF92WSIJSZ9c6rArm3K4UwwmpYoSRr5dFfBASOHnw+t2gHq6ZhnPZIvU2xQiaXlK
	EmziS+B/D2ywhlWMJ4iq3R7Chbk+gepX57U+JKzrmQefgw4hI0mB/9Mv+tXzJO0VS3PPiu3yRXc
	q9m037QhOP3t1t7Xcz9UYoZhTyljVLtaAoMkqAaFIaRC+NuQ
X-Google-Smtp-Source: AGHT+IEJO0WjdgXOjXJqZPftUFQkpS6u3BM4TNcGdroUlKAuuGmTMKinuIf0AidjcQlLK1aelrsOqw==
X-Received: by 2002:a17:906:248a:b0:aca:abff:b427 with SMTP id a640c23a62f3a-acaabffc0edmr19595266b.52.1744204198022;
        Wed, 09 Apr 2025 06:09:58 -0700 (PDT)
Received: from [192.168.2.3] ([109.227.147.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce7322sm92151066b.164.2025.04.09.06.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:09:57 -0700 (PDT)
Message-ID: <573ae845a793527ddb410eee4f6f5f0111912ca6.camel@hazent.com>
Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on
 MicroBlaze: Packets only received after some buffer is full
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro.gamez@hazent.com>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Katakam, Harini"
	 <harini.katakam@amd.com>, "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Date: Wed, 09 Apr 2025 15:09:56 +0200
In-Reply-To: <MN0PR12MB59539CF99653EC1F937591AAB7B42@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <9a6e59fcc08cb1ada36aa01de6987ad9f6aaeaa4.camel@hazent.com>
			 <20250402100039.4cae8073@kernel.org>
		 <80e2a74d4fcfcc9b3423df13c68b1525a8c41f7f.camel@hazent.com>
		 <MN0PR12MB59537EB05F07459513A2301EB7AE2@MN0PR12MB5953.namprd12.prod.outlook.com>
	 <ce56ed7345d2077a7647687f90cf42da57bf90c7.camel@hazent.com>
	 <MN0PR12MB59539CF99653EC1F937591AAB7B42@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-09 at 11:14 +0000, Pandey, Radhey Shyam wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> > -----Original Message-----
> > From: =C3=81lvaro G. M. <alvaro.gamez@hazent.com>
> > Sent: Wednesday, April 9, 2025 4:31 PM
> > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Jakub Kicinski
> > <kuba@kernel.org>
> > Cc: netdev@vger.kernel.org; Katakam, Harini <harini.katakam@amd.com>; G=
upta,
> > Suraj <Suraj.Gupta2@amd.com>
> > Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on Mic=
roBlaze:
> > Packets only received after some buffer is full
> >=20
> > On Thu, 2025-04-03 at 05:54 +0000, Pandey, Radhey Shyam wrote:
> > > [...]
> > >  + Going through the details and will get back to you . Just to
> > > confirm there is no vivado design update ? and we are only updating l=
inux kernel to
> > latest?
> > >=20
> >=20
> > Hi again,
> >=20
> > I've reconsidered the upgrading approach and I've first upgraded buildr=
oot and kept
> > the same kernel version (4.4.43). This has the effect of upgrading gcc =
from version
> > 10 to version 13.
> >=20
> > With buildroot's compiled gcc-13 and keeping this same old kernel, the =
effect is that
> > the system drops ARP requests. Compiling with older gcc-10, ARP request=
s are
>=20
> When the system drops ARP packet - Is it drop by MAC hw or by software la=
yer.
> Reading MAC stats and DMA descriptors help us know if it reaches software
> layer or not ?

I'm not sure, who is the open dropping packets, I can only check with
ethtool -S eth0 and this is its output after a few dozens of arpings:

# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 06:00:0A:BC:8C:01 =20
          inet addr:10.188.140.1  Bcast:10.188.143.255  Mask:255.255.248.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:164 errors:0 dropped:99 overruns:0 frame:0
          TX packets:22 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:11236 (10.9 KiB)  TX bytes:1844 (1.8 KiB)

# ethtool -S eth0
NIC statistics:
     Received bytes: 13950
     Transmitted bytes: 2016
     RX Good VLAN Tagged Frames: 0
     TX Good VLAN Tagged Frames: 0
     TX Good PFC Frames: 0
     RX Good PFC Frames: 0
     User Defined Counter 0: 0
     User Defined Counter 1: 0
     User Defined Counter 2: 0

# ethtool -g eth0
Ring parameters for eth0:
Pre-set maximums:
RX:		4096
RX Mini:	0
RX Jumbo:	0
TX:		4096
Current hardware settings:
RX:		1024
RX Mini:	0
RX Jumbo:	0
TX:		128

# ethtool -d eth0
Offset		Values
------		------
0x0000:		00 00 00 00 00 00 00 00 00 00 00 00 e4 01 00 00=20
0x0010:		00 00 00 00 18 00 00 00 00 00 00 00 00 00 00 00=20
0x0020:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
0x0030:		00 00 00 00 ff ff ff ff ff ff 00 18 00 00 00 18=20
0x0040:		00 00 00 00 00 00 00 40 d0 07 00 00 50 00 00 00=20
0x0050:		80 80 00 01 00 00 00 00 00 21 01 00 00 00 00 00=20
0x0060:		00 00 00 00 00 00 00 00 00 00 00 00 06 00 0a bc=20
0x0070:		8c 01 00 00 03 00 00 00 00 00 00 00 00 00 00 00=20
0x0080:		03 70 18 21 0a 00 18 00 40 25 b3 80 40 25 b3 80=20
0x0090:		03 50 01 00 08 00 01 00 40 38 12 81 00 38 12 81=20



Running tcpdump makes it so that ifconfig dropped value doesn't increment a=
nd shows
me ARP requests (although it won't reply to them), but just setting the int=
erface as promisc do not.

If you can give me any indications on how to gather more data about DMA des=
criptors
I'll try my best.

This is using internal's emaclite dma, because when using dmaengine there's=
 no dropping
of packets, but a big buffering, and kernel 6.13.8, because in series ~5.11=
 which I'm
also working with, axienet didn't have support for reading statistics from =
the core.

I assume the old dma code inside axienet is to be deprecated, and I would b=
e
pretty glad to use dmaengine, but that has the buffering problem. So if you
want to focus efforts on solving that issue I'm completely open to whatever
you all deem more appropriate.

I can even add some ILA to the Vivado design and inspect whatever you
think could be useful

Thanks

>=20
> > replied to. Keeping old buildroot version but asking it to use gcc-11 w=
ill cause the
> > same issue with kernel 4.4.43, so something must have happened in betwe=
en those
> > gcc versions.
> >=20
> > So this does not look like an axienet driver problem, which I first tho=
ught it was,
> > because who would blame the compiler in first instance?
> >=20
> > But then things started to get even stranger.
> >=20
> > What I did next, was slowly upgrading buildroot and using the kernel ve=
rsion that
> > buildroot considered "latest" at the point it was released. I reached a=
 point in which
> > the ARP requests were being dropped again. This happened on buildroot 2=
021.11,
> > which still used gcc-10 as the default and kernel version 5.15.6. So so=
me gcc bug
> > that is getting triggered on gcc-11 in kernel 4.4.43 is also triggered =
on gcc-10 by
> > kernel 5.15.6.
> >=20
> > Using gcc-10, I bisected the kernel and found that this commit was trig=
gering
> > whatever it is that is happening, around 5.11-rc2:
> >=20
> > commit 324cefaf1c723625e93f703d6e6d78e28996b315 (HEAD)
> > Author: Menglong Dong <dong.menglong@zte.com.cn>
> > Date:   Mon Jan 11 02:42:21 2021 -0800
> >=20
> >     net: core: use eth_type_vlan in __netif_receive_skb_core
> >=20
> >     Replace the check for ETH_P_8021Q and ETH_P_8021AD in
> >     __netif_receive_skb_core with eth_type_vlan.
> >=20
> >     Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> >     Link: https://lore.kernel.org/r/20210111104221.3451-1-
> > dong.menglong@zte.com.cn
> >     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >=20
> >=20
> > I've been staring at the diff for hours because I can't understand what=
 can be wrong
> > about this:
> >=20
> > diff --git a/net/core/dev.c b/net/core/dev.c index e4d77c8abe76..267c4a=
8daa55
> > 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -5151,8 +5151,7 @@ static int __netif_receive_skb_core(struct sk_buf=
f **pskb,
> > bool pfmemalloc,
> >         skb_reset_mac_len(skb);
> >     }
> >=20
> > -   if (skb->protocol =3D=3D cpu_to_be16(ETH_P_8021Q) ||
> > -       skb->protocol =3D=3D cpu_to_be16(ETH_P_8021AD)) {
> > +   if (eth_type_vlan(skb->protocol)) {
> >         skb =3D skb_vlan_untag(skb);
> >         if (unlikely(!skb))
> >             goto out;
> > @@ -5236,8 +5235,7 @@ static int __netif_receive_skb_core(struct sk_buf=
f **pskb,
> > bool pfmemalloc,
> >              * find vlan device.
> >              */
> >             skb->pkt_type =3D PACKET_OTHERHOST;
> > -       } else if (skb->protocol =3D=3D cpu_to_be16(ETH_P_8021Q) ||
> > -              skb->protocol =3D=3D cpu_to_be16(ETH_P_8021AD)) {
> > +       } else if (eth_type_vlan(skb->protocol)) {
> >             /* Outer header is 802.1P with vlan 0, inner header is
> >              * 802.1Q or 802.1AD and vlan_do_receive() above could
> >              * not find vlan dev for vlan id 0.
> >=20
> >=20
> >=20
> > Given that eth_type_vlan is simply this:
> >=20
> > static inline bool eth_type_vlan(__be16 ethertype) {
> >         switch (ethertype) {
> >         case htons(ETH_P_8021Q):
> >         case htons(ETH_P_8021AD):
> >                 return true;
> >         default:
> >                 return false;
> >         }
> > }
> >=20
> > I've added a small printk to see these values right before the first ti=
me they are
> > checked:
> >=20
> > printk(KERN_ALERT  "skb->protocol =3D %d, ETH_P_8021Q=3D%d
> > ETH_P_8021AD=3D%d, eth_type_vlan(skb->protocol) =3D %d",
> >        skb->protocol, cpu_to_be16(ETH_P_8021Q), cpu_to_be16(ETH_P_8021A=
D),
> > eth_type_vlan(skb->protocol));
> >=20
> > And each ARP ping delivers a packet reported as:
> > skb->protocol =3D 1544, ETH_P_8021Q=3D129 ETH_P_8021AD=3D43144,
> > skb->eth_type_vlan(skb->protocol) =3D 0
> >=20
> > To add insult to injury, adding this printk line solves the ARP deafnes=
s, so no matter
> > whether I use eth_type_vlan function or manual comparison, now ARP pack=
ets
> > aren't dropped.
> >=20
> > Removing this printk and adding one inside the if-clause that should no=
t be
> > happening, shows nothing, so neither I can directly inspect the packets=
 or return
> > value of the wrong working code, nor can I indirectly proof that the wr=
ong branch of
> > the if is being taken. This reinforces the idea of a compiler bug, but =
I very well could
> > be wrong.
> >=20
> > Adding this printk:
> > diff --git i/net/core/dev.c w/net/core/dev.c index 267c4a8daa55..a3ae3b=
cb3a21
> > 100644
> > --- i/net/core/dev.c
> > +++ w/net/core/dev.c
> > @@ -5257,6 +5257,8 @@ static int __netif_receive_skb_core(struct sk_buf=
f **pskb,
> > bool pfmemalloc,
> >                  * check again for vlan id to set OTHERHOST.
> >                  */
> >                 goto check_vlan_id;
> > +       } else {
> > +           printk(KERN_ALERT "(1) skb->protocol is not type vlan\n");
> >         }
> >         /* Note: we might in the future use prio bits
> >          * and set skb->priority like in vlan_do_receive()
> >=20
> > is even weirder because the same effect: the message does not appear bu=
t ARP
> > requests are answered back. If I remove this printk, ARP requests are d=
ropped.
> >=20
> > I've generated assembly output and this is the difference between havin=
g that extra
> > else with the printk and not having it.
> >=20
> > It doesn't even make much any sense that code would even reach this reg=
ion of
> > code because there's no vlan involved in at all here.
> >=20
> > And so here I am again, staring at all this without knowing how to proc=
eed.
> >=20
> > I guess I will be trying different and more modern versions of gcc, eve=
n some
> > precompiled toolchains and see what else may be going on.
> >=20
> > If anyone has any hindsight as to what is causing this or how to solve =
it, it'd be great
> > if you could share it.
> >=20
> > Thanks!
> >=20
> > --
> > =C3=81lvaro G. M.

