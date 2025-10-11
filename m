Return-Path: <netdev+bounces-228583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1711BCF233
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 10:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 033F74E7C3D
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 08:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C173238C36;
	Sat, 11 Oct 2025 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbckeqYr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B657235074
	for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171264; cv=none; b=HLwszBIrmUXKalfxXRMmMvvQKLoyCbuJEoBXqoIh5j3eMYPjNURVLrkxg15erDw9RiRzOxaT9B8Rt/ANBU/YRGvlg3uqKRMHLIxaQMOl9XHl6ai9OQsYJhIOCOWW6A9RtexYDN85W1+/dTAUJ6VSR6gcV5X1BcYyT8LOvBysVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171264; c=relaxed/simple;
	bh=r95oH5GbkUOVXpI5nlGaWqGgXfXqMTaFecuIS27pkx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcNsN0JTlf25uWWdtkBaUWZdloePuYNpiWGgXJx769nVdf/j5GWXClwP/CGnyfPXcRFSKlkKkTy8xQjMBjLVJcN1QEe9REjWpo+ieUbZIOQlPgxvuSX/AfEZNW8sKeNorK96J5eJuFjgTbIfwWIx1Z8kdLbiisVI4fTc+2poXDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbckeqYr; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-36d77ae9de5so21270291fa.2
        for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 01:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760171256; x=1760776056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r95oH5GbkUOVXpI5nlGaWqGgXfXqMTaFecuIS27pkx8=;
        b=NbckeqYrtuwuA/gQ/2gPNcpI2d8CENatmE+TClmcpUpoUUa5817PQV297ux7NIR4p0
         nTSt/Rf1idCP2cQj7XqFOfx6kSmSgwhb/VTjTxq+kzx67YHlzPNrmTe3O2v4EORttYXO
         m3hWXCl0OkjMJTXIqOhJLF+3jA5TWzaq+pUaUf/MqK2mmLSmE7J7MxchG7+laDNAwsy4
         MoaGMje0IKkUUeA89nZd3dfrlpP5TN0L3iZWHLleCpfHcxSlwTj3Rf8XwmiXQ1uN0LxH
         9eO5xDUS1wJmnzxKdjRAW7brJjJ1IVoV/yjm0zGlblwwnIRxgOCgMwngE2NzW08gwf9h
         8GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171256; x=1760776056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r95oH5GbkUOVXpI5nlGaWqGgXfXqMTaFecuIS27pkx8=;
        b=dNa+rsr6n1y+Oy+sWWrOhYhK/BIlFh89itQ2x4PQKtw23XGzmLgYSYxqA5DWOUB/wb
         QJzKcjZH8MD0X/0vDNRwmYWYQBOCKEIbNkl1Gb6CRM2R/mgcG3yL/W4OQMeC65hhqxV6
         3vEBTYlLPYuJNh8jMZEIhYuznPU/vGoZIGXX8NmNPvoI9mBp1WGjq0VkHF2ybkttj4J9
         rH2p4EgnKmLHHGftzVqorqKfe5ctaM44aTln54wqPARuY+k4k0slyUYffyYf4CXc15t5
         E0rUhF8+a/Sa8JI9Vk1iygHuJWqhto4FS3LkNFzIIMWPOfNgyi0hoVshfZqgdcwdqOOB
         E/0w==
X-Forwarded-Encrypted: i=1; AJvYcCU1a+oEU2qoTjuMWfpe+kp4FG7CFc7Fr3YMT78V+mij/faA8sZ0B08zCG9HRD4x2JYHGFR2CbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPWbF6OC+W63aNHSziK/VVI4+Y2FCIB12AmLNLr8tIwoz3p0O
	LdZNF38fJOEWYnhPtRigaT6qwqnZO30hCQzftbP9xHdXxZCn4pl9eVW5GaQU6eJFWROqXLAXxb8
	yVDHPTWonoqFM0S1mGrZIZ4lWyvPPOU8=
X-Gm-Gg: ASbGncs5+w7QeO/+kUor7/Cm5rz+M1ivgnA66PJa1GK0gN/jZqf9SH/fhhhnfitn6TU
	CORU4mb/1NWcb3HeIkrqS/OOhIXpfFrKJMBX0a1090cUWW/L3jVW9T9o3u1BfmrBp6Gww6jm3wz
	xlbFeis8Yu0yZZXfxX4jVKpI0HVi+AD4H/w5Vjzpxo9NgknfQuMBw9n9RYI1icDiQJEakoxKAfv
	drYf0Yr2kPE74SJM3LgpY4EvmcPd0f/ysFn
X-Google-Smtp-Source: AGHT+IGJCLDt3s/Ad2Kslk35KMxhOBmufBzkiQdY4j+DcxoO4hZ+WRXdBjByfsAv42RY5rg/QH3wm4QkKHh7CV+5qXE=
X-Received: by 2002:a2e:9a16:0:b0:375:d1fa:4b76 with SMTP id
 38308e7fff4ca-37609ef1253mr38871061fa.45.1760171255835; Sat, 11 Oct 2025
 01:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <wL97kjSJHOArswIoM2huzx9vV9M9uh0SoCZtDVYo-HJFeCwZXraoJ4kc0l1hkxt1XLsejTsRCRCkTqASpo98zAUyfmYoCfzGD3vkaThigVA=@proton.me>
 <aM_L1Hbind29q_Z_@shell.armlinux.org.uk> <mgCCIJjGoUsB3nhQPO_r2E4X7JvDb5_40Aq9GVv5OoH6OXxsKCuO3lnlVSHj-zH00KV5AY66F4VE6bed9R5yu8SM_jNeBpdGDYAkBNq7hXA=@proton.me>
 <aNEVX9ew-5kPB22u@shell.armlinux.org.uk> <GyVvHJnPCxv3x_uGwaDIu_KKQgeFhh24x4aRcVQ0WQVr4tjxubB3qeWiSGVmwy8VbKrAQ2nF0iUDLHPTgE7M9ZiOqW1XQ5nTYgzyIcl-VZc=@proton.me>
 <fw_IlfASLLWC-FISSL4_CyGBtQ4GIHUyP2yekbr82wpiTNryNcql8NAqEdY37qE8AlZjMe4fLdo7I0yYsBaZpYhwB8Eq8GVxYNLUgcTjI7s=@proton.me>
In-Reply-To: <fw_IlfASLLWC-FISSL4_CyGBtQ4GIHUyP2yekbr82wpiTNryNcql8NAqEdY37qE8AlZjMe4fLdo7I0yYsBaZpYhwB8Eq8GVxYNLUgcTjI7s=@proton.me>
From: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Date: Sat, 11 Oct 2025 10:27:24 +0200
X-Gm-Features: AS18NWAEFUJYVfgkWo9Do79GYOK0ZP5BTcr9THwX4FRQQOvcEBJQVX385pq_ZrQ
Message-ID: <CAHzn2R3+ow2fJfiZ6Wfd+WMBkEDcgxAR19EtJefrgWWOCniwLg@mail.gmail.com>
Subject: Re: Marvell 375 and Marvel 88E1514 Phy network problem: mvpp2 or DTS related?
To: Zoo Moo <zoomoo100@proton.me>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ZM,

Have you checked pinctrl settings? The MDIO looks like properly
working, so I'd double-check if the pins that are assigned to RGMII in
U-Boot (I assume the interface works there), are not overriden by e.g.
wrong device tree configuration in kernel.

Best regards,
Marcin


=C5=9Br., 1 pa=C5=BA 2025 o 05:05 Zoo Moo <zoomoo100@proton.me> napisa=C5=
=82(a):
>
> On Wednesday, September 24th, 2025 at 11:33 AM, Zoo Moo <zoomoo100@proton=
.me> wrote:
> >
>
> > On Monday, 22 September 2025 at 19:22, Russell King (Oracle) linux@arml=
inux.org.uk wrote:
> >
>
> > > On Mon, Sep 22, 2025 at 08:58:49AM +0000, Zoo Moo wrote:
> > >
>
> > > > Sent with Proton Mail secure email.
> > > >
>
> > > > On Sunday, 21 September 2025 at 19:56, Russell King (Oracle) linux@=
armlinux.org.uk wrote:
> > > >
>
> > > > > On Sun, Sep 21, 2025 at 09:05:18AM +0000, Zoo Moo wrote:
> > > >
>
> > > > > > Hi,
> > > >
>
> > > > > > Bodhi from Doozan (https://forum.doozan.com) has been helping m=
e try to get Debian to work on a Synology DS215j NAS. The DS215j is based o=
n a Marvell Armada 375 (88F6720) and uses a Marvel 88E1514 PHY.
> > > >
>
> > > > > Probably wrong RGMII phy-mode. I see you're using rgmii-id. Maybe=
 that
> > > > > isn't correct. Just a guess based on the problems that RGMII norm=
ally
> > > > > causes.
> > > >
>
> > > > Hi Russell,
> > > >
>
> > > > Thanks, we did try different drivers (gmii, sgmii), but they didn't=
 help, details in this message https://forum.doozan.com/read.php?2,138851,1=
39291#msg-139291.
> > >
>
> > > What I was meaning was not to try stuff like "SGMII", but try the oth=
er
> > > three flavours of RGMII. In other words:
> > >
>
> > > rgmii
> > > rgmii-txid
> > > rgmii-rxid
> > >
>
> > > If u-boot works, and it's using RGMII, then it's definitely one of th=
e
> > > four flavours of RGMII interface.
> > >
>
> > > No need to post the failures of the testing to the forums - just say
> > > here whether any of those result in packet flow or not. Nothing else
> > > should change - the only difference between these modes are the timin=
gs
> > > of the RGMII interface, and having the wrong mode is the most common
> > > reason for RGMII not working.
> > >
>
> > > Thanks.
> > >
>
> > > --
> > > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> >
>
> >
>
> > Thanks Russel,
> >
>
> > I tried all flavours again (rgmii, rgmii-id, rgmii-txid and rgmii-rxid)=
, but all resulted in the same outcome.
> >
>
> > ifconfig shows it sends packets, but nothing is received. I cannot dete=
ct it actually sending any packets from the device though.
> >
>
> > For example:
> >
>
> > root@(none):~# ifconfig eth0 192.168.27.111 netmask 255.255.255.0 up hw=
 ether 00:11:22:33:44:55
> > [ 31.727773][ T2055] mvpp2 f10f0000.ethernet eth0: PHY [f10c0054.mdio-m=
ii:01] driver [Marvell 88E1510] (irq=3DPOLL)
> > [ 31.738178][ T2055] mvpp2 f10f0000.ethernet eth0: configuring for phy/=
rgmii-txid link mode
> > [ 36.007360][ T10] mvpp2 f10f0000.ethernet eth0: Link is Up - 1Gbps/Ful=
l - flow control off
> >
>
> > root@(none):~# dhclient eth0
> > root@(none):~# ifconfig eth0
> > eth0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST> mtu 1500
> >
>
> > inet 192.168.27.111 netmask 255.255.255.0 broadcast 192.168.27.255
> > inet6 <IP6 ADDRESS> prefixlen 64 scopeid 0x20<link>
> >
>
> > ether 00:11:22:33:44:55 txqueuelen 2048 (Ethernet)
> > RX packets 0 bytes 0 (0.0 B)
> > RX errors 0 dropped 0 overruns 0 frame 0
> > TX packets 71 bytes 4858 (4.7 KiB)
> > TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0
> >
>
> > Do I need to adjust the internal delays? rx-internal-delay-ps/tx-intern=
al-delay-ps
> >
>
> > (reference: https://www.thegoodpenguin.co.uk/blog/linux-ethernet-phy-mo=
de-bindings-explained/)
> >
>
> > Is it something we can determine by looking at the Synology kernel sour=
ce?
>
>
> Hi,
>
> Any other suggestions I could try to debug this issue?
>
> Appreciate any suggestions.
>
> Cheers,
> ZM

