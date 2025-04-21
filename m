Return-Path: <netdev+bounces-184363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D802A94FE5
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 13:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6E43A67EC
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0102627E7;
	Mon, 21 Apr 2025 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="Wx+ttWjb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC8261597
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233937; cv=none; b=kgLn3fiShRAzrsAA/WxJ/d0aPSYlxozGTYe40IHthpb6+Wq0fX367x2EPmgbGHgcsl7g2tLCImxR19O5TvSUTsJwgXMus/My7jCvfWAdCg/ZB8BaabouSAOjByFI/aEUgS1NCX3J/8dHNDFIph6r4HsoHKLquELu1GhuKeejMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233937; c=relaxed/simple;
	bh=N8N4dQ7nqdpkOnizefKBGLxYoDa2EMFGKJyJrHHOh4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BCXdCZNaZQrPOjZKdFn/29xhOwRhETVCW7CLj61Lma0qdPIVzAPq/nIfN9dQAjf3sirYOL4q9AIcFscjIYH3xqLDa87Mg+c6nKBVwmQjN56sGMaPgA9yegIWewg6KvU+mntbX9UkdN7LouJeWscDPCMfJ0CYerrzSh396uqvABg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=Wx+ttWjb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-440685d6afcso36582925e9.0
        for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1745233932; x=1745838732; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g3BRYEJFI388NPMFrakTMjsENshM+U0CL6Zyv5bfO+4=;
        b=Wx+ttWjb6wVTVff0No2oHC1xiZ7UhkqdHZqPGjKNKp+xwxTq6qt20JZdGBl3fk4ujo
         OEK2TaMeiMS9zJ2f0g1L7poJuSxS2ANb1oYQn490vLtuRmT7OxGgvuC8xmN5+LkR1Vyy
         A0IRzUndrKd9S8p7bUCnJAAxrVudMoFtG2hPgQZC07roz5nsyifcjEk2EYPHySh2NSZw
         sqeprpq65u1jd9Z+dIvUd1eOkIWWjm5DFzfc60jYDpyGV1lyQQHlqrqNvQXyeAW38rbt
         iNWOnjwlit919n3vhVg1+gLjF4m4FF2ynidjHroLEJhTnuPeRU8WVzjOVtHwoUxUhVCR
         OsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745233932; x=1745838732;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3BRYEJFI388NPMFrakTMjsENshM+U0CL6Zyv5bfO+4=;
        b=Tb62iNK8o2359gq/AsOaFtU+WyIKh+/Y2mnh4ZgRNvJ/qcPkVDrK2B7BZMCNScZep1
         j4ODVC3IQ/VHkx7mHgUqEBYI/0vu17h10g4yID9zL/FQT5+Kt+yJk7ZQpFU6+ZUYmOlQ
         ssouuSQrW3NDQAc6F/yjBkgLSts1zhwi7YKaX7TqUZUhJST5uj6UfDopzdFnjblg5car
         cFJhtVLlHUA/mnN71jVJ0GXCJyF1gM+TSEWHumu1UlLkvDud4qx+t3SWm5yCImUdUi4x
         hLCR/ZeVy4mAqqNZboZw+1jlz5naZgpK4S1Gr3E2GmneNG4fKegxXMbcjSbCtQb0P6yB
         Hnyw==
X-Gm-Message-State: AOJu0YxIww1UYkEzmEF3QWYREgArRe3rfstphXwGZcbicdsBgF2h1xl8
	LPnOJwUB4ijkMbxwSY7P2SkMJbxRVcC0P0BzxDg6jiDls+VX89Az+XOfmOanqw==
X-Gm-Gg: ASbGncur7RgySH3XE7CaYkgmr2hCd5sQUSeiivvE/Tj1U912VLVRHPXQAxq3RjGDNtl
	IZ7qUNuRbvPGIseuG10ldiPTQaM2cB3rGqQEIInO82gBjFjn72th504p2zVmGdO3lugi/11ookH
	NokQwpdSoAhw2dGNq+BDB9qhDwpS7swC1KilpBy8TZf008+gHrgnCpDk+p6LwE4KiPq32/AQDQT
	BG01ldTdjRRLz+e8g5R8aj0gBHi8u+E+44zUyQ+KvHIrZ9FEDPEV+vbt0bkggpE5O9z187+TfQk
	W6pdz0toP65M778kxs8y+H9Ujix4bIWSUtn/fgl06SC4k+yP
X-Google-Smtp-Source: AGHT+IEYKvMIHqhdw05+ghlqwk6kYvIKenvUGBZMziiqKj7Vd2LvwbgZKlaYSHtHJzPd7pDeD8bquA==
X-Received: by 2002:a05:600c:3107:b0:43d:fa59:be38 with SMTP id 5b1f17b1804b1-4406ac1a119mr87681775e9.32.1745233932137;
        Mon, 21 Apr 2025 04:12:12 -0700 (PDT)
Received: from [192.168.2.3] ([109.227.147.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d56328asm131465595e9.0.2025.04.21.04.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 04:12:11 -0700 (PDT)
Message-ID: <3c61fbdbcd1c1ef94a60e4e4452eb99e998f1bd8.camel@hazent.com>
Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on
 MicroBlaze: Packets only received after some buffer is full
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro.gamez@hazent.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Katakam, Harini"	
 <harini.katakam@amd.com>, "Pandey, Radhey Shyam"
 <radhey.shyam.pandey@amd.com>,  Jakub Kicinski	 <kuba@kernel.org>
Date: Mon, 21 Apr 2025 13:12:11 +0200
In-Reply-To: <BL3PR12MB6571E207F5BA03CAA08E174FC9B72@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <9a6e59fcc08cb1ada36aa01de6987ad9f6aaeaa4.camel@hazent.com>
					 <20250402100039.4cae8073@kernel.org>
				 <80e2a74d4fcfcc9b3423df13c68b1525a8c41f7f.camel@hazent.com>
				 <MN0PR12MB59537EB05F07459513A2301EB7AE2@MN0PR12MB5953.namprd12.prod.outlook.com>
			 <ce56ed7345d2077a7647687f90cf42da57bf90c7.camel@hazent.com>
			 <MN0PR12MB59539CF99653EC1F937591AAB7B42@MN0PR12MB5953.namprd12.prod.outlook.com>
		 <573ae845a793527ddb410eee4f6f5f0111912ca6.camel@hazent.com>
		 <BL3PR12MB6571795778D97F64C39C3B71C9B72@BL3PR12MB6571.namprd12.prod.outlook.com>
	 <40a0dfa8116ecccd5e39f2cd186e9f19e43fe7d0.camel@hazent.com>
	 <BL3PR12MB6571E207F5BA03CAA08E174FC9B72@BL3PR12MB6571.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-10 at 07:10 +0000, Gupta, Suraj wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> > -----Original Message-----
> > From: =C3=81lvaro G. M. <alvaro.gamez@hazent.com>
> > Sent: Thursday, April 10, 2025 12:24 PM
> > To: Gupta, Suraj <Suraj.Gupta2@amd.com>
> > Cc: netdev@vger.kernel.org; Katakam, Harini <harini.katakam@amd.com>; P=
andey,
> > Radhey Shyam <radhey.shyam.pandey@amd.com>; Jakub Kicinski
> > <kuba@kernel.org>
> > Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on Mic=
roBlaze:
> > Packets only received after some buffer is full
> >=20
> > Caution: This message originated from an External Source. Use proper ca=
ution
> > when opening attachments, clicking links, or responding.
> >=20
> >=20
> > On Thu, 2025-04-10 at 06:25 +0000, Gupta, Suraj wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >=20
> > > > -----Original Message-----
> > > > From: =C3=81lvaro G. M. <alvaro.gamez@hazent.com>
> > > > Sent: Wednesday, April 9, 2025 6:40 PM
> > > > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Jakub
> > > > Kicinski <kuba@kernel.org>
> > > > Cc: netdev@vger.kernel.org; Katakam, Harini
> > > > <harini.katakam@amd.com>; Gupta, Suraj <Suraj.Gupta2@amd.com>
> > > > Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on=
 MicroBlaze:
> > > > Packets only received after some buffer is full
> > > >=20
> > > > Caution: This message originated from an External Source. Use prope=
r
> > > > caution when opening attachments, clicking links, or responding.
> > > >=20
> > > >=20
> > > > On Wed, 2025-04-09 at 11:14 +0000, Pandey, Radhey Shyam wrote:
> > > > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > > >=20
> > > > > > -----Original Message-----
> > > > > > From: =C3=81lvaro G. M. <alvaro.gamez@hazent.com>
> > > > > > Sent: Wednesday, April 9, 2025 4:31 PM
> > > > > > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Jakub
> > > > > > Kicinski <kuba@kernel.org>
> > > > > > Cc: netdev@vger.kernel.org; Katakam, Harini
> > > > > > <harini.katakam@amd.com>; Gupta, Suraj <Suraj.Gupta2@amd.com>
> > > > > > Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet=
) on
> > MicroBlaze:
> > > > > > Packets only received after some buffer is full
> > > > > >=20
> > > > > > On Thu, 2025-04-03 at 05:54 +0000, Pandey, Radhey Shyam wrote:
> > > > > > > [...]
> > > > > > >  + Going through the details and will get back to you . Just
> > > > > > > to confirm there is no vivado design update ? and we are only
> > > > > > > updating linux kernel to
> > > > > > latest?
> > > > > > >=20
> > > > > >=20
> > > > > > Hi again,
> > > > > >=20
> > > > > > I've reconsidered the upgrading approach and I've first upgrade=
d
> > > > > > buildroot and kept the same kernel version (4.4.43). This has
> > > > > > the effect of upgrading gcc from version
> > > > > > 10 to version 13.
> > > > > >=20
> > > > > > With buildroot's compiled gcc-13 and keeping this same old
> > > > > > kernel, the effect is that the system drops ARP requests.
> > > > > > Compiling with older gcc-10, ARP requests are
> > > > >=20
> > > > > When the system drops ARP packet - Is it drop by MAC hw or by sof=
tware
> > layer.
> > > > > Reading MAC stats and DMA descriptors help us know if it reaches
> > > > > software layer or not ?
> > > >=20
> > > > I'm not sure, who is the open dropping packets, I can only check
> > > > with ethtool -S
> > > > eth0 and this is its output after a few dozens of arpings:
> > > >=20
> > > > # ifconfig eth0
> > > > eth0      Link encap:Ethernet  HWaddr 06:00:0A:BC:8C:01
> > > >           inet addr:10.188.140.1  Bcast:10.188.143.255  Mask:255.25=
5.248.0
> > > >           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
> > > >           RX packets:164 errors:0 dropped:99 overruns:0 frame:0
> > > >           TX packets:22 errors:0 dropped:0 overruns:0 carrier:0
> > > >           collisions:0 txqueuelen:1000
> > > >           RX bytes:11236 (10.9 KiB)  TX bytes:1844 (1.8 KiB)
> > > >=20
> > > > # ethtool -S eth0
> > > > NIC statistics:
> > > >      Received bytes: 13950
> > > >      Transmitted bytes: 2016
> > > >      RX Good VLAN Tagged Frames: 0
> > > >      TX Good VLAN Tagged Frames: 0
> > > >      TX Good PFC Frames: 0
> > > >      RX Good PFC Frames: 0
> > > >      User Defined Counter 0: 0
> > > >      User Defined Counter 1: 0
> > > >      User Defined Counter 2: 0
> > > >=20
> > > > # ethtool -g eth0
> > > > Ring parameters for eth0:
> > > > Pre-set maximums:
> > > > RX:             4096
> > > > RX Mini:        0
> > > > RX Jumbo:       0
> > > > TX:             4096
> > > > Current hardware settings:
> > > > RX:             1024
> > > > RX Mini:        0
> > > > RX Jumbo:       0
> > > > TX:             128
> > > >=20
> > > > # ethtool -d eth0
> > > > Offset          Values
> > > > ------          ------
> > > > 0x0000:         00 00 00 00 00 00 00 00 00 00 00 00 e4 01 00 00
> > > > 0x0010:         00 00 00 00 18 00 00 00 00 00 00 00 00 00 00 00
> > > > 0x0020:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > 0x0030:         00 00 00 00 ff ff ff ff ff ff 00 18 00 00 00 18
> > > > 0x0040:         00 00 00 00 00 00 00 40 d0 07 00 00 50 00 00 00
> > > > 0x0050:         80 80 00 01 00 00 00 00 00 21 01 00 00 00 00 00
> > > > 0x0060:         00 00 00 00 00 00 00 00 00 00 00 00 06 00 0a bc
> > > > 0x0070:         8c 01 00 00 03 00 00 00 00 00 00 00 00 00 00 00
> > > > 0x0080:         03 70 18 21 0a 00 18 00 40 25 b3 80 40 25 b3 80
> > > > 0x0090:         03 50 01 00 08 00 01 00 40 38 12 81 00 38 12 81
> > > >=20
> > > >=20
> > > >=20
> > >=20
> > > As per registers dump, packet is not dropped by MAC. It's dropping so=
mewhere in
> > the software layer.
> > > Since you started bisecting linux commits, could you please try rever=
ting
> > suspected commit and check if that's actually the first bad commit?
> > >=20
> >=20
> > I already kinda did, please read the whole message quoted below.
> >=20
> > * To summarize:
> > Kernel commit 324cefaf1c723625e93f703d6e6d78e28996b315^ =3D
> > 679500e385fc4d65c3fac5bfbe6ee55d65698f20 works fine Kernel commit
> > 324cefaf1c723625e93f703d6e6d78e28996b315 drops packets
> >=20
> > But using commit 324cefaf1c723625e93f703d6e6d78e28996b315 and adding pr=
intk
> > around suspect lines, solves the issue. Looks a like a compiler bug.
> >=20
> > * New information from yesterday's email:
> > Reverting commit 324cefaf1c723625e93f703d6e6d78e28996b315 on kernel 6.1=
3.8
> > does not solve the issue. Neither does tinkering around with printks
> >=20
> >=20
>=20
> I didn't suspected that commit last time as it was unrelated to the issue=
. Could you please try effectively bisecting linux,  keeping other things s=
ame? For the starting you can try bisecting among AXI ethernet commits and =
see if it's related to AXI ethernet changes or something else?
>=20

And rightfully so, the commit is basically replacing a chunk of code with=
=20
another that does exactly the same, although using a different comparison
structure (if vs switch) and calling a function.

So, I've managed to build kernel 6.13.8 with the same gcc version (5.4) as
I used to compile kernel 4.4.14 and the problem has solved itself.

I am now completely sure that the compiler is the one responsible. Going ba=
ck
to gcc 5.4 has solved my ethernet issues without touching a single line of
kernel code.

Using gcc 13 causes the behavior I described, and bisecting the kernel with
gcc 13 definitely points to that commit, which of course isn't the bad acto=
r,
but is somehow triggering the fault; so for now I'll just keep using gcc 5.=
4

Conversations on gcc bugzilla point to Microblaze architecture being in
the process of being deprecated, as it doesn't seem to gather much attentio=
n
and there are standing bugs:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D118280

We'll probably be deprecating Microblaze internally and I will definitely
will recommend not using it anymore. Maybe Microblaze V could be a nice
alternative, but AFAIK it doesn't have an MMU yet and Linux probably won't
run in it, so...

Thanks a lot for your guidance, I've learned a lot diagnosing this and you
guys pointed me at things I didn't know about. And please forgive all
the misdirection, I blamed axienet driver and net code when they were innoc=
ent.

Best regards


> > > > Running tcpdump makes it so that ifconfig dropped value doesn't
> > > > increment and shows me ARP requests (although it won't reply to
> > > > them), but just setting the interface as promisc do not.
> > > >=20
> > > > If you can give me any indications on how to gather more data about
> > > > DMA descriptors I'll try my best.
> > > >=20
> > > > This is using internal's emaclite dma, because when using dmaengine
> > > > there's no dropping of packets, but a big buffering, and kernel
> > > > 6.13.8, because in series ~5.11 which I'm also working with, axiene=
t
> > > > didn't have support for reading statistics from the core.
> > > >=20
> > > > I assume the old dma code inside axienet is to be deprecated, and I
> > > > would be pretty glad to use dmaengine, but that has the buffering
> > > > problem. So if you want to focus efforts on solving that issue I'm
> > > > completely open to whatever you all deem more appropriate.
> > > >=20
> > >=20
> > > We're not planning to make DMAengine flow default soon as there is so=
me
> > significant work and optimizations required there which are under progr=
ess.
> > > But this buffering issue we didn't observe on our platforms last time=
 we ran it with
> > linux v6.12.
> > >=20
> >=20
> > I just tried dmaengine on 6.12 and have the same buffering issue.
> >=20
> > Did you try on Microblaze too or only on Zynq?
>=20
> We have tested with ZynqMP AXI 1G ethernet.
>=20
> >=20
> >=20
> >=20
> > > > I can even add some ILA to the Vivado design and inspect whatever
> > > > you think could be useful
> > > >=20
> > > > Thanks
> > > >=20
> > > > >=20
> > > > > > replied to. Keeping old buildroot version but asking it to use
> > > > > > gcc-11 will cause the same issue with kernel 4.4.43, so
> > > > > > something must have happened in between those gcc versions.
> > > > > >=20
> > > > > > So this does not look like an axienet driver problem, which I
> > > > > > first thought it was, because who would blame the compiler in f=
irst instance?
> > > > > >=20
> > > > > > But then things started to get even stranger.
> > > > > >=20
> > > > > > What I did next, was slowly upgrading buildroot and using the
> > > > > > kernel version that buildroot considered "latest" at the point
> > > > > > it was released. I reached a point in which the ARP requests
> > > > > > were being dropped again. This happened on buildroot 2021.11,
> > > > > > which still used
> > > > > > gcc-10 as the default and kernel version 5.15.6. So some gcc bu=
g
> > > > > > that is getting triggered on gcc-11 in kernel 4.4.43 is also
> > > > > > triggered on gcc-10 by
> > > > kernel 5.15.6.
> > > > > >=20
> > > > > > Using gcc-10, I bisected the kernel and found that this commit
> > > > > > was triggering whatever it is that is happening, around 5.11-rc=
2:
> > > > > >=20
> > > > > > commit 324cefaf1c723625e93f703d6e6d78e28996b315 (HEAD)
> > > > > > Author: Menglong Dong <dong.menglong@zte.com.cn>
> > > > > > Date:   Mon Jan 11 02:42:21 2021 -0800
> > > > > >=20
> > > > > >     net: core: use eth_type_vlan in __netif_receive_skb_core
> > > > > >=20
> > > > > >     Replace the check for ETH_P_8021Q and ETH_P_8021AD in
> > > > > >     __netif_receive_skb_core with eth_type_vlan.
> > > > > >=20
> > > > > >     Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> > > > > >     Link: https://lore.kernel.org/r/20210111104221.3451-1-
> > > > > > dong.menglong@zte.com.cn
> > > > > >     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > > > >=20
> > > > > >=20
> > > > > > I've been staring at the diff for hours because I can't
> > > > > > understand what can be wrong about this:
> > > > > >=20
> > > > > > diff --git a/net/core/dev.c b/net/core/dev.c index
> > > > > > e4d77c8abe76..267c4a8daa55
> > > > > > 100644
> > > > > > --- a/net/core/dev.c
> > > > > > +++ b/net/core/dev.c
> > > > > > @@ -5151,8 +5151,7 @@ static int __netif_receive_skb_core(struc=
t
> > > > > > sk_buff **pskb, bool pfmemalloc,
> > > > > >         skb_reset_mac_len(skb);
> > > > > >     }
> > > > > >=20
> > > > > > -   if (skb->protocol =3D=3D cpu_to_be16(ETH_P_8021Q) ||
> > > > > > -       skb->protocol =3D=3D cpu_to_be16(ETH_P_8021AD)) {
> > > > > > +   if (eth_type_vlan(skb->protocol)) {
> > > > > >         skb =3D skb_vlan_untag(skb);
> > > > > >         if (unlikely(!skb))
> > > > > >             goto out;
> > > > > > @@ -5236,8 +5235,7 @@ static int __netif_receive_skb_core(struc=
t
> > > > > > sk_buff **pskb, bool pfmemalloc,
> > > > > >              * find vlan device.
> > > > > >              */
> > > > > >             skb->pkt_type =3D PACKET_OTHERHOST;
> > > > > > -       } else if (skb->protocol =3D=3D cpu_to_be16(ETH_P_8021Q=
) ||
> > > > > > -              skb->protocol =3D=3D cpu_to_be16(ETH_P_8021AD)) =
{
> > > > > > +       } else if (eth_type_vlan(skb->protocol)) {
> > > > > >             /* Outer header is 802.1P with vlan 0, inner header=
 is
> > > > > >              * 802.1Q or 802.1AD and vlan_do_receive() above co=
uld
> > > > > >              * not find vlan dev for vlan id 0.
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > Given that eth_type_vlan is simply this:
> > > > > >=20
> > > > > > static inline bool eth_type_vlan(__be16 ethertype) {
> > > > > >         switch (ethertype) {
> > > > > >         case htons(ETH_P_8021Q):
> > > > > >         case htons(ETH_P_8021AD):
> > > > > >                 return true;
> > > > > >         default:
> > > > > >                 return false;
> > > > > >         }
> > > > > > }
> > > > > >=20
> > > > > > I've added a small printk to see these values right before the
> > > > > > first time they are
> > > > > > checked:
> > > > > >=20
> > > > > > printk(KERN_ALERT  "skb->protocol =3D %d, ETH_P_8021Q=3D%d
> > > > > > ETH_P_8021AD=3D%d, eth_type_vlan(skb->protocol) =3D %d",
> > > > > >        skb->protocol, cpu_to_be16(ETH_P_8021Q),
> > > > > > cpu_to_be16(ETH_P_8021AD), eth_type_vlan(skb->protocol));
> > > > > >=20
> > > > > > And each ARP ping delivers a packet reported as:
> > > > > > skb->protocol =3D 1544, ETH_P_8021Q=3D129 ETH_P_8021AD=3D43144,
> > > > > > skb->eth_type_vlan(skb->protocol) =3D 0
> > > > > >=20
> > > > > > To add insult to injury, adding this printk line solves the ARP
> > > > > > deafness, so no matter whether I use eth_type_vlan function or
> > > > > > manual comparison, now ARP packets aren't dropped.
> > > > > >=20
> > > > > > Removing this printk and adding one inside the if-clause that
> > > > > > should not be happening, shows nothing, so neither I can
> > > > > > directly inspect the packets or return value of the wrong
> > > > > > working code, nor can I indirectly proof that the wrong branch =
of the if is
> > being taken.
> > > > > > This reinforces the idea of a compiler bug, but I very well cou=
ld be wrong.
> > > > > >=20
> > > > > > Adding this printk:
> > > > > > diff --git i/net/core/dev.c w/net/core/dev.c index
> > > > > > 267c4a8daa55..a3ae3bcb3a21
> > > > > > 100644
> > > > > > --- i/net/core/dev.c
> > > > > > +++ w/net/core/dev.c
> > > > > > @@ -5257,6 +5257,8 @@ static int __netif_receive_skb_core(struc=
t
> > > > > > sk_buff **pskb, bool pfmemalloc,
> > > > > >                  * check again for vlan id to set OTHERHOST.
> > > > > >                  */
> > > > > >                 goto check_vlan_id;
> > > > > > +       } else {
> > > > > > +           printk(KERN_ALERT "(1) skb->protocol is not type
> > > > > > + vlan\n");
> > > > > >         }
> > > > > >         /* Note: we might in the future use prio bits
> > > > > >          * and set skb->priority like in vlan_do_receive()
> > > > > >=20
> > > > > > is even weirder because the same effect: the message does not
> > > > > > appear but ARP requests are answered back. If I remove this
> > > > > > printk, ARP requests are
> > > > dropped.
> > > > > >=20
> > > > > > I've generated assembly output and this is the difference
> > > > > > between having that extra else with the printk and not having i=
t.
> > > > > >=20
> > > > > > It doesn't even make much any sense that code would even reach
> > > > > > this region of code because there's no vlan involved in at all =
here.
> > > > > >=20
> > > > > > And so here I am again, staring at all this without knowing how=
 to proceed.
> > > > > >=20
> > > > > > I guess I will be trying different and more modern versions of
> > > > > > gcc, even some precompiled toolchains and see what else may be =
going on.
> > > > > >=20
> > > > > > If anyone has any hindsight as to what is causing this or how t=
o
> > > > > > solve it, it'd be great if you could share it.
> > > > > >=20
> > > > > > Thanks!
> > > > > >=20
> > > > > > --
> > > > > > =C3=81lvaro G. M.

