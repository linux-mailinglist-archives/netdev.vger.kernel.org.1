Return-Path: <netdev+bounces-223916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5FCB7FA63
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26FD1C03FB8
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3282730C628;
	Wed, 17 Sep 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVBdaj0v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C6630BBA2
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101296; cv=none; b=PjniWlXAgJI30thrW26clS77ozTIxtcq5jXXDG9fLW9UXtX5LND3d2JqufVFx7uZi+NUbpDsa3yneUyvXoZX8o8s/ZaRa2f4NGIh3g7Pk2FNJDKmNqCfGarYhhSsu58p4xTKndjqylIcxq8YXdLVoiwAnE/RTODsQM5EeziHN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101296; c=relaxed/simple;
	bh=BvQk4uuZWQQsyS0bgCtnD8Q2EwGdUDl2hTU4IVjcj60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5prTmSPp9j7PmbgMqroK5AePyVO11ix0yv8pE6fsZu52QILUXbMHsaujIGQAopl79iT0EXvq/tozPPQa/PnFFy5p1ncxNwsB8j8ZWhsKM1hgwyF/2CoSESSNQH8m2A+wc4mcFDH4pwMWaTIxjJs66HQTD0UHNeUPM19pmklGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVBdaj0v; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b00f6705945so90662366b.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758101292; x=1758706092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o12PIdH5jrLINYaBDIAtrFJQyb2acUWsg9n32mRR/5k=;
        b=JVBdaj0v/hbdVqguRjn5NCfyLNTxtb92X6WozyadXPvjm1nA2NMlGS90yPHrzAmhga
         1Lyoabc15pQmnhheTJOk4wcAHWmO+CgdNy6s8LEFAZvzGZekBr6sdob1FCrxJ7rh0ZmX
         I9Srq9Hzkn6SxPg666qvtIiJ2eWYT9jVlM2ZngQcMGRjjPIQCaKglmuPDHglI0ExRBP9
         KYp4XiqR+xoVDPRtx8+s1ob69xsjHM/BffPrSGs1fXHZnXGflZOHliwsH2F7UWtsAa5s
         ExtsxTARDKVsO+Sav4OiaCVvP+EvkcVDh23Pa4bmIEXVVulzMmXXuEnHc8VpFgvTI/4H
         8TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758101292; x=1758706092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o12PIdH5jrLINYaBDIAtrFJQyb2acUWsg9n32mRR/5k=;
        b=jkcZesrGYZbK5cu/ylWndTIiaUu9I2kzLpHQ18FcLQQ53LNuyxMGu+zg6JfhA+UULS
         WF3IUmRZ6fgA1whmPup3WV9ozZuFEODVCrPXWOeSAEowLDEphyudSnP7Wq9p6iyW+m0h
         +093Blg1sxtvuN/s2qVaoEvNItBajyDiajMtn6pDnVML3QteLSOTTJZfz9vECActzNhA
         nXH6nOz0WiMLp48CSo25vsqkBWpjj5N/iTV31queTeRVhvRJuX93B+lzEgGg11aLiYEd
         3qrdwAqDQMriloA8JsTbVd11ZG2tmIGjHKMDLWqu6MB5ag3BDRIIItUTrBanp9jaLuXy
         aEFw==
X-Forwarded-Encrypted: i=1; AJvYcCXe1edL/akUDskmpb6ayjJOaEZjEf/2OMxrPoQ73XT9E9VLhvuq7Vo25TIP7nfIQCcBDz4hLFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyspAZd95NLlT7XWEGdm51Idc/adALiq8KCS+MFcFs+A1Ihj9m
	eH6zz7IEGdbx9pmLVr8aNW43gflp+LbFaR5pQoa5+wD9v8Dyf71kZbmE
X-Gm-Gg: ASbGncvLXt41lMQjnekSjRee2X02QSyZddjiuHD1PtORO0nRFXDyVKMMZ+GCakSq12c
	/lvJfRgg8tSVQKW0L0S6z4eCeputShNs6CY46K5PWSV8FXYyh41ykCNL2CN/2cHYcqTfGdOSGO0
	GzsTDpJ4um9/AKSrw9pO27KSVS+6ZkGhIU6x/24HrlAhdY+tlFFF9wj3mpcv+em4xO3VemAhLLa
	E3BTTCn6zxwHGirtG+PiylXOfXr2aI4vU4bXvx5TL6A+sMd7oJccKDISiYVLKaErhcrJhMUyzld
	igwvef6wmZ78Aw2cKlE1NHP3g7JFZFzGwfI818OTh/ypPf+Vbr6yR7PAa2T7jXVyC994GP0Sf2p
	lIE+tbyuc63RSmjs=
X-Google-Smtp-Source: AGHT+IHvszT87WzP63vcOaexO/pLxfMWcRX57JUYYOxi6z+V5togEaPi0QjDbwzVUWpwnuisJKwZww==
X-Received: by 2002:a17:907:7f9f:b0:b04:7b5b:850a with SMTP id a640c23a62f3a-b1bb5598e03mr85457666b.4.1758101292043;
        Wed, 17 Sep 2025 02:28:12 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1c40fe2df8sm74103266b.18.2025.09.17.02.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:28:10 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:28:07 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v18 0/8] net: dsa: Add Airoha AN8855 support
Message-ID: <20250917092807.uui2qwva2sqbe6sp@skbuf>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915104545.1742-1-ansuelsmth@gmail.com>

On Mon, Sep 15, 2025 at 12:45:36PM +0200, Christian Marangi wrote:
> It's conceptually similar to mediatek switch but register and bits
> are different. And there is massive list of register for the PCS
> configuration.
> Saddly for that part we have absolutely NO documentation currently.

Please add in the next revision a more convincing argument for not
reusing the mt7530 driver control flow. Regmap fields can abstract a
lot, and the driver can select a completely different phylink_pcs for
different hardware.

I don't see in the short change log included here any mentions related
to the mt7530, but I'm not going to search the mailing lists since Nov
2024 for any previous discussions about this...

Also, let's try not to reach v20.. Please try to collect a full round of
feedback from people who commented before when submitting a new version,
pinging people if necessary. You want to make sure that their previous
feedback was addressed.

> TEST: lan2: Multicast IPv4 to joined group                          [ OK ]
> TEST: lan2: Multicast IPv4 to unknown group                         [XFAIL]
>         reception succeeded, but should have failed
> TEST: lan2: Multicast IPv4 to unknown group, promisc                [ OK ]
> TEST: lan2: Multicast IPv4 to unknown group, allmulti               [ OK ]
> TEST: lan2: Multicast IPv6 to joined group                          [ OK ]
> TEST: lan2: Multicast IPv6 to unknown group                         [XFAIL]
>         reception succeeded, but should have failed
> TEST: lan2: Multicast IPv6 to unknown group, promisc                [ OK ]
> TEST: lan2: Multicast IPv6 to unknown group, allmulti               [ OK ]
> TEST: lan2: 1588v2 over L2 transport, Sync                          [ OK ]
> TEST: lan2: 1588v2 over L2 transport, Follow-Up                     [ OK ]
> TEST: lan2: 1588v2 over L2 transport, Peer Delay Request            [ OK ]
> TEST: lan2: 1588v2 over IPv4, Sync                                  [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv4, Follow-Up                             [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv4, Peer Delay Request                    [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv6, Sync                                  [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv6, Follow-Up                             [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv6, Peer Delay Request                    [FAIL]
>         reception failed

Do you know why it won't receive PTP over IP? It seems strange, given it
receives other IP multicast (even unregistered). Is it a hardware or a
software drop? What port counters increment? Does it drop PTP over IP
only on local termination, or does it also fail to forward it? What
about the packet makes the switch drop it?

> TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
> TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
> TEST: VLAN upper: Unicast IPv4 to primary MAC address               [ OK ]
> TEST: VLAN upper: Unicast IPv4 to macvlan MAC address               [ OK ]
> TEST: VLAN upper: Unicast IPv4 to unknown MAC address               [ OK ]
> TEST: VLAN upper: Unicast IPv4 to unknown MAC address, promisc      [ OK ]
> TEST: VLAN upper: Unicast IPv4 to unknown MAC address, allmulti     [ OK ]
> TEST: VLAN upper: Multicast IPv4 to joined group                    [ OK ]
> TEST: VLAN upper: Multicast IPv4 to unknown group                   [XFAIL]
>         reception succeeded, but should have failed
> TEST: VLAN upper: Multicast IPv4 to unknown group, promisc          [ OK ]
> TEST: VLAN upper: Multicast IPv4 to unknown group, allmulti         [ OK ]
> TEST: VLAN upper: Multicast IPv6 to joined group                    [ OK ]
> TEST: VLAN upper: Multicast IPv6 to unknown group                   [XFAIL]
>         reception succeeded, but should have failed
> TEST: VLAN upper: Multicast IPv6 to unknown group, promisc          [ OK ]
> TEST: VLAN upper: Multicast IPv6 to unknown group, allmulti         [ OK ]
> TEST: VLAN upper: 1588v2 over L2 transport, Sync                    [ OK ]
> TEST: VLAN upper: 1588v2 over L2 transport, Follow-Up               [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over L2 transport, Peer Delay Request      [ OK ]
> TEST: VLAN upper: 1588v2 over IPv4, Sync                            [FAIL]
>         reception failed
> ;TEST: VLAN upper: 1588v2 over IPv4, Follow-Up                       [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over IPv4, Peer Delay Request              [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over IPv6, Sync                            [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over IPv6, Follow-Up                       [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over IPv6, Peer Delay Request              [FAIL]
>         reception failed

The same thing happens with VLAN too...

> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to joined group   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group   [XFAIL]
>         reception succeeded, but should have failed
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to joined group   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group   [XFAIL]
>         reception succeeded, but should have failed
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Sync   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Sync   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to joined group   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group   [XFAIL]
>         reception succeeded, but should have failed
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to joined group   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group   [XFAIL]
>         reception succeeded, but should have failed
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Sync   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Sync   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
>         reception failed

And over bridge ports...

