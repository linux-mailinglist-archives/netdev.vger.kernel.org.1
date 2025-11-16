Return-Path: <netdev+bounces-238928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF64C611F9
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 10:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93863B96AD
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 09:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD07262FFC;
	Sun, 16 Nov 2025 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI8WW9P5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CDD8634C
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763284409; cv=none; b=AWZfW8MVn/22czBvXQcgnY69qOMbiIQsQ1Oh1OUY2JiuFabKDa6AfMOTsKnDOKkANmp2Xvou7HcLax3kCr6pcP4GQ55cmmbLfKExNYDNjeKpLTVunnSlViaq7Rydd3Abzzjn4A7ZrNRyrG5EyCYPz4ChkvUk3b/bcsSTEY5NRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763284409; c=relaxed/simple;
	bh=BkWoUxz2hh26KqyrNr39DUMdACas5qd/J5T8s6lZCO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeNEdsdbpeHFTRcjuSkneGTmQ1LEAjJy+mXm5P72w4bHZzpDi79ShWPHKw7e00iHNztts5fEs+fs5cFx38FThacp/G+R9+KoIvFIJXb8Gt0/iRbZBnZp+1sheuKvF2lyKXFn4b7lY5AvGnzWBgRSmnuTK/fCr2elZ18pjmJ0jnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI8WW9P5; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63bc1aeb427so2914298d50.3
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 01:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763284406; x=1763889206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNVcTrKvmoNAxnJtsbT6YNfDn6knC6baCtCdNjXtbuU=;
        b=mI8WW9P5f0iniDglfHG61JvRPCBkR+QoQyeT8oYMQjM0h0XXln1/ywgTBwsqhJbnx5
         iUTyYnLgE67UtKcy3G9fJdL0WQlnYCrV3ageBIoBWz6EN9e2tgEC5MYnX8mVB6wXEFYK
         ORzyz3dtmIEaw4EHF/7CyA5b90B7cMq/06toL7STS3I0WXn4JmG7ymo49J/troFQpb0J
         iNbqFfnFQtTIQIOBdaf6pEsKqsMm/aUp/XWT+b2F19gXCMgozcyH5npo96F4FZxQkwtH
         eS/PgQb9wi/kGT35f5jBQg9N99RSdn0ueiYyd+HWqjDftCQyoVjDABNu3xpMgnD1WM/J
         uEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763284406; x=1763889206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JNVcTrKvmoNAxnJtsbT6YNfDn6knC6baCtCdNjXtbuU=;
        b=e5MC2JbHPkGkaNkt5Ff5nhV44x0ah6V/TnrwudkwmJCDASL0EtEGtnGPn/ZgbpkB+7
         nUotz41D2Rj8q4u6jMqIILvUuhQTDDrH6ScZhGSqEwIZDGh1gTVmDhY1I1SRdIQJsoyd
         Rw9Dxd24WyX/RbL9FHXLHMOLhIif8gHP8fSYFAgo1wCoskqhy/aawWqlgalm8NGnP+n6
         6TdusIG7lf3EGUGp6m0LN5eXWkNM/Plrit3FAElISauzvhJ0P9mkJEBvTQufbmMfxqDl
         uebntcF5VejkzaZFwBCZm8igoPp0OPY2K5rMNdDnfUBb8k/Iqg7vOa34wVkSmfOQBzMa
         RJAg==
X-Forwarded-Encrypted: i=1; AJvYcCWWISvIqVoHxCckRxV5F0EpUcB/gvOkorFPUk6Bvx9g10OkPXchOKyJeKTcWliZ7KzNFa/Y2Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh5+JvBXhIMFRv4xXViqyPuHeoPXQljoegwMwlH1tnNEe0TkBS
	DZxl9bzz3N+m/Z1fweAN+YHt0EBMkgNTqZKE43lwqPBtiUPSuSpSy/nFlgtR/9cLlm4jH6iirI5
	ltRlk57vp4ZtYDd/wtPGNz7rtU5xRduk=
X-Gm-Gg: ASbGnctnxXyOT0ugn9Yqxl91fv1LMMri6ezvrbho9vz8sbyAgJtT15c4b1WtNw3tnMS
	uIp+dIdBaYCIEXooCPjIqFNL4Cq2l5AePrYMTSmDKvltT1TK030HcZdo57VF0HpdcrsylU68Yh0
	KSeS/fudpi0E0eILBim32izEcuE777PnNnBfLcY+BLYRVsVri/zTe/GOx3J4ANvqRd7a/2qHZQ/
	yVdY5496ruYinrWdMYW0fnJCXNpOdnoE/4dPcf3VEJT2tw1Mjnur3tGukQ5TYMZzFHTV+f90Qvi
	LX/ajwvseBr0L9Y=
X-Google-Smtp-Source: AGHT+IGOgWtGvmjQMBDkdB1UQc7aAwuEfB9id/q/7KUXPQcw/751DQs9toKRWGddtMhJ7MEMpbMIskXgiXr7OQmXHt0=
X-Received: by 2002:a53:d006:0:b0:641:f5bc:6944 with SMTP id
 956f58d0204a3-641f5bc71acmr3429058d50.72.1763284406364; Sun, 16 Nov 2025
 01:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN9vWDK=36NUdTtZhPMu7Yh15kGv+gkE35A93dU0qg01z5VkbA@mail.gmail.com>
 <67c7ccab-2377-46bf-b59d-01a6d8d7e8f4@gmail.com>
In-Reply-To: <67c7ccab-2377-46bf-b59d-01a6d8d7e8f4@gmail.com>
From: Michael Zimmermann <sigmaepsilon92@gmail.com>
Date: Sun, 16 Nov 2025 10:13:15 +0100
X-Gm-Features: AWmQ_bki3vsF0c4XZ0is8F_wrw9Q0-AOUjfzQQw-K0HrEBqay1RF_VmJBra_U8Q
Message-ID: <CAN9vWDJvD9TZAwKUu8NSfbLZTLkNga8AR7LQ4qTTwEDxLr8brw@mail.gmail.com>
Subject: Re: RTL8127AF doesn't get a link over SFP+ DAC
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:54=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 11/13/2025 6:30 PM, Michael Zimmermann wrote:
> > Hi,
> >
> > I have a RT8127AF card from DIEWU:
> > https://24wireless.info/diewu-txa403-and-txa405 .
> > The card is detected just fine:
> > [125201.683763] r8169 0000:08:00.0 eth1: RTL8127A, xx:xx:xx:xx:xx:xx,
> > XID 6c9, IRQ 143
> > [125201.683770] r8169 0000:08:00.0 eth1: jumbo features [frames: 16362
> > bytes, tx checksumming: ko]
> > [125201.688543] r8169 0000:08:00.0 enp8s0: renamed from eth1
> > [125201.715519] Realtek Internal NBASE-T PHY r8169-0-800:00: attached
> > PHY driver (mii_bus:phy_addr=3Dr8169-0-800:00, irq=3DMAC)
> > [125202.277034] r8169 0000:08:00.0 enp8s0: Link is Down
> >
> > This is what ethtool shows:
> > Settings for enp8s0:
> >         Supported ports: [ TP    MII ]
> >         Supported link modes:   10baseT/Half 10baseT/Full
> >                                 100baseT/Half 100baseT/Full
> >                                 1000baseT/Full
> >                                 10000baseT/Full
> >                                 2500baseT/Full
> >                                 5000baseT/Full
> >         Supported pause frame use: Symmetric Receive-only
> >         Supports auto-negotiation: Yes
> >         Supported FEC modes: Not reported
> >         Advertised link modes:  10baseT/Half 10baseT/Full
> >                                 100baseT/Half 100baseT/Full
> >                                 1000baseT/Full
> >                                 10000baseT/Full
> >                                 2500baseT/Full
> >                                 5000baseT/Full
> >         Advertised pause frame use: Symmetric Receive-only
> >         Advertised auto-negotiation: Yes
> >         Advertised FEC modes: Not reported
> >         Speed: Unknown!
> >         Duplex: Unknown! (255)
> >         Auto-negotiation: on
> >         master-slave cfg: preferred slave
> >         master-slave status: unknown
> >         Port: Twisted Pair
> >         PHYAD: 0
> >         Transceiver: internal
> >         MDI-X: Unknown
> >         Supports Wake-on: pumbg
> >         Wake-on: d
> >         Link detected: no
> >
> > and `ip a`:
> > 10: enp8s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
> > fq_codel state DOWN group default qlen 1000
> >     link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
> >     altname enxXXXXXXXXXXXX
> >
> > And that's it, the link never comes up. The 10G Mikrotik switch on the
> > other side sees that the module is inserted on its side, but doesn't
> > show any change when I plug in the RTL8127AF.
> >
> > It works in Windows 11 and it also works with the r8127 Linux driver
> > downloaded from Realteks website:
> > https://www.realtek.com/Download/List?cate_id=3D584 :
> >
> > [129318.976134] r8127: This product is covered by one or more of the
> > following patents: US6,570,884, US6,115,776, and US6,327,625.
> > [129318.976175] r8127  Copyright (C) 2025 Realtek NIC software team
> > <nicfae@realtek.com>
> >                  This program comes with ABSOLUTELY NO WARRANTY; for
> > details, please see <http://www.gnu.org/licenses/>.
> >                  This is free software, and you are welcome to
> > redistribute it under certain conditions; see
> > <http://www.gnu.org/licenses/>.
> > [129318.988293] r8127 0000:08:00.0 enp8s0: renamed from eth1
> > [129318.997092] enp8s0: 0xffffd49ec9140000, xx:xx:xx:xx:xx:xx, IRQ 137
> > [129319.421629] r8127: enp8s0: link up
> >
> > ethtool with realteks driver shows something quite interesting:
> > Settings for enp8s0:
> >         Supported ports: [ TP ]
> >         Supported link modes:   1000baseT/Full
> >                                 10000baseT/Full
> >         Supported pause frame use: No
> >         Supports auto-negotiation: No
> >         Supported FEC modes: Not reported
> >         Advertised link modes:  1000baseT/Full
> >                                 10000baseT/Full
> >         Advertised pause frame use: No
> >         Advertised auto-negotiation: No
> >         Advertised FEC modes: Not reported
> >         Speed: 10000Mb/s
> >         Duplex: Full
> >         Auto-negotiation: off
> >         Port: Twisted Pair
> >         PHYAD: 0
> >         Transceiver: internal
> >         MDI-X: on
> >         Supports Wake-on: pumbg
> >         Wake-on: g
> >         Current message level: 0x00000033 (51)
> >                                drv probe ifdown ifup
> >         Link detected: yes
> >
> > auto-negotiation is off, even though it's enabled on my Mikrotik
> > switch. "ethtool -s enp8s0 autoneg on" (or off) on the realtek driver
> > succeeds but doesn't change what ethtools status shows. "ethtool -s
> > enp8s0 autoneg off" on the mainline driver does fail with:
> > netlink error: link settings update failed
> > netlink error: Invalid argument
> >
> > So while I have no idea why things are not working, my best theory is
> > that auto-negotiation isn't supported (properly) and the mainline
> > driver doesn't support disabling it.
> >
> Realtek uses a proprietary way to deal with the SFP and hides it
> behind the internal PHY. The SFP signals aren't exposed.
> When in fiber mode the internal PHY doesn't behave fully compliant
> with clause 22 any longer. E.g. link status isn't reported by the
> PHY, but only via a proprietary register.
> To cut a long story short: Fiber mode isn't supported by r8169
> at the moment.
>
> > Thanks
> > Michael
>

Thanks for the hint. I've spent some time understanding and comparing
both drivers and testing a couple of things and was actually able to
get it working with r8169. After some more testing and code cleanup
I'll send a patch.

