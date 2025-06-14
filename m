Return-Path: <netdev+bounces-197844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863C4ADA043
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 00:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7F2172E3D
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393C01FBCA7;
	Sat, 14 Jun 2025 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th1BuHmU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414725634;
	Sat, 14 Jun 2025 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749940458; cv=none; b=mI3AiQdhyizQwyTlhIZZz/e3jSMbVNYXKT0MMdCplSB/nLt2d6JP/HpuG5tEIDEgrzXay1pxpJPMgiieojrckqLtgKDrclQ1gaxsnwT4JqXBYuzfUEfdCbDRfAbBH5eKmfEKJQ2XED83tULBX0cisiZ7g0/qtqkqcyIn8bihedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749940458; c=relaxed/simple;
	bh=Ik3lpHePvjWRJWYumMp523LMBYYbHBwcF6Zgt2MNpb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GduY2etvsGh4IFd933RaQKKY5RoACBdAnCsloAZ6iqADqYg2kTHrmj1CdB35COTebXfA3iQV71NkJgFhpLcdimlrTxM+pfvf4ad2RJHcCJ1hMn/hoAtNM92NcCWCXuKxSjq578m4XOrEZww6BxTkcKYdIwBS04jyO3agZ2S76jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th1BuHmU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so77207f8f.0;
        Sat, 14 Jun 2025 15:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749940453; x=1750545253; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eElX0K0mVGFpZdZanLnRJGH007mVfDUZMyXart8hp4s=;
        b=Th1BuHmU0reeFb7Zs9Arvam2nX2JnzAyFaw7Yy7mcXTZ43B6O1TS6ifHpq8nqssjit
         mH//UYm1nmJcWyMqLjDd7CQDFwC6pVr/LXDkLd0mO16ar5mevL8eQoyk3sfDqTNCnPpR
         4EhnWym1qycm6m9PLTnRkkyRuNLxqaAJiOzuB/n4KQg9idEIKqHOHPuAjwCPH8daI458
         UdRIVPFtBAVT9shd5iMgdgnHfzwTOxANRl0ciWRMilDiBcK5oLgi7evV0vRcFKyt3cmH
         xo3l5nXNX2UjFP9AAtq/pxMujaQqo49rBs0KJjS5zFG2h8tR/IxXcPa1Wj+Bk354rKPJ
         1fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749940453; x=1750545253;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eElX0K0mVGFpZdZanLnRJGH007mVfDUZMyXart8hp4s=;
        b=UkVUAiIecwhrf0aZVMEpBNsALCKROuKFpJql/ZMFeEViqrSkvrpXk1rcaD/7g2QsSJ
         IRfBSN0Pxfh0TeTM2QgCloxgvLzv7v1WEegk7M0whEj4P7u06+2RgQ/7q/ThwTvxOrie
         HNYf++QRMDMiUibfgogKYgd7sHG9b2a/peILCUwlyjFWkDuSRsM+RgWQdKNKRF+ylqJs
         5b3eOSa4+JTOUy9N+so15yk5/GN4Z88kWdmRVLwe1NmKwJFcrwj7MFAQ5GovDQUMZ4wP
         QVMux/e3m2BTWHUxxukHbgP6nP7/rC4GzsuvSXn9EbX6siLcuysVXmXcruAlD5ou3AW6
         tY/A==
X-Forwarded-Encrypted: i=1; AJvYcCUekMmdy5FktUBGAVaOEF90+1n1qmKCB42DLS4tpKOdXzTDcTARNoVl88Hym6O5DKwx6vIrxyaHQ4GV@vger.kernel.org, AJvYcCWoACtsoKAWbDlPbaMKuhGKOIFTGS5Sxks8yYGah+Nfluw872EOV65GwHm/b9Nhje9xH6C3ZyURHNphfiwz@vger.kernel.org, AJvYcCX669OinbAfHQ5JGr72x3LYA/oxFcsgP5TZgohDbn2t1oA9ntYL4evaKNpdDcGdumm6BSkewF0B@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+kW+BvQ/oaM1bXlJZ3EiC6W8Gxp5AV81RglFFBD+D6Qvmx65
	d+D6k59FJtvSqA7lVGJSbH38qLSxsuLtZ4MliHbfWoH9r5t8t4+4MYxD
X-Gm-Gg: ASbGncsBQsJHAQNNfFSqOX9xK0KOPmTaRJi/jZpmnFx2AwXTymmjzdhXSRFe1K4IqPU
	qBOma2FjFb565o2v4T5v73j1LcyZa5QgrcLxueBiUetTv+iy/KRd5+lys8me2aykXuFQmZlmlJt
	TVWYXyQcz7ek9shMitme5ravJL0fdVAardhOQrFl8+BDunaBnqx9LQNU3u0UeA+jT7WbV7M/iII
	gO4V7GhDSj+s8iNDRwpj1hgUQkZsDkTu/ghMbZyZV8zLYDaPgB3NERyk52OHBPoeXo9pilSZndt
	UHk5CDFOW/9gVyhQvzj5X+J1l5N+0QUcANqjLQnX6Wem2PXVWfOfzdSIXqvXBQqErWaRmNdkyww
	oxkU+Cw==
X-Google-Smtp-Source: AGHT+IHUSSE4wReaeDL8ecMX9RxikoVG4MsNqeGENvR2wr/CiqJiGVOf4JzoiiQACFFziT0S6EILMw==
X-Received: by 2002:a05:6000:4308:b0:3a5:2cb5:642f with SMTP id ffacd0b85a97d-3a572e7a032mr4130209f8f.34.1749940452671;
        Sat, 14 Jun 2025 15:34:12 -0700 (PDT)
Received: from giga-mm-7.home ([2a02:1210:8608:9200:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532ddd29ffsm92955675e9.0.2025.06.14.15.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 15:34:12 -0700 (PDT)
Message-ID: <55df35f66eeb8580b21337e4b2738801117c125a.camel@gmail.com>
Subject: Re: [PATCH net-next RFC 0/3] riscv: dts: sophgo: Add ethernet
 support for cv18xx
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen
 Wang	 <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,  Richard Cochran
 <richardcochran@gmail.com>, Yixun Lan <dlan@gentoo.org>, Thomas Bonnefille	
 <thomas.bonnefille@bootlin.com>, Ze Huang <huangze@whut.edu.cn>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev,
 	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Longbin Li	
 <looong.bin@gmail.com>
Date: Sun, 15 Jun 2025 00:34:24 +0200
In-Reply-To: <05194937-8db3-4d90-9d03-9836c734fce1@lunn.ch>
References: <20250611080709.1182183-1-inochiama@gmail.com>
	 <7a4ceb2e0b75848c9400dc5a56007e6c46306cdc.camel@gmail.com>
	 <e84c95fa52ead5d6099950400aac9fd38ee1574e.camel@gmail.com>
	 <05194937-8db3-4d90-9d03-9836c734fce1@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Sorry for confusion Andrew,

On Sun, 2025-06-15 at 00:20 +0200, Andrew Lunn wrote:
> > Also ethtool seems to be incompatible with mdio muxes :(
>=20
> Please could you expand on that, because i don't know of a problem
> with mdio muxes and ethtool.

everything seems to be fine with ethtool and mdio mux!
(I accidentally mixed up host and target consoles)

# ethtool eth0
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full=20
                                100baseT/Half 100baseT/Full=20
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full=20
                                100baseT/Half 100baseT/Full=20
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Half 10baseT/Full=20
                                             100baseT/Half 100baseT/Full=
=20
        Link partner advertised pause frame use: Symmetric Receive-only
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: external
        Auto-negotiation: on
        Supports Wake-on: d
        Wake-on: d
        Current message level: 0x0000003f (63)
                               drv probe link timer ifdown ifup
        Link detected: yes

But we do have some troubles with the internal PHY with Inochi's patches
on SG2000, the above "Link detected: yes" is actually without cable
inserted.

--=20
Alexander Sverdlin.

