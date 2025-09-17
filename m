Return-Path: <netdev+bounces-223918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBA1B7CFB4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6534D483592
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAE630AAD0;
	Wed, 17 Sep 2025 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERoodyij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C22E2DD8
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102044; cv=none; b=nm42+NbY+YeTxCG2+5M72JbNJp/K1/RNbs2p8OOoZW9jS+M40mHP8JE2ilzR/DkgXyX8Ond2Ef2wLLKKoKiBdY89a+HEzBYwMUsUsBDX0JWsQiidiokbr69qZbyxle6jC7NmQa3Cn1WtSXlm+INwvaP/UNTYeDgQc3CeqdoLolI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102044; c=relaxed/simple;
	bh=zSjy7JweDiNuMf5jSMkd9oxm+C8V6Vitiz++md+Z5wA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCTcOTiXQksdzlAy39NcBbvALdegyRJXHMrfwL8/X1UdUTWzgcYyWi9YzC1Emd1WESK+qkCxo0SifgCBAzFhXIzV+/LL8RwozFq9SOa2yAIkNYX3dpr9KFNT7ll42MQaCYLPil6UjjNCs7Sixnz211VNWaNZax1PmXBQnuan1hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERoodyij; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45f31adf368so17950915e9.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758102041; x=1758706841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5jQzjfISWXhmjsCWqCbC/EKcBa3nhvEnsbsmWDiienE=;
        b=ERoodyij9l6elDm96pZmjoicW11zuXES0xakR0gZ7eir1MityQQSHczT5364tELhkI
         M7kU+1aXeCnf2I6XXiN8m5U8EOcSEV3aJaG4HPuAHdm59RofChn6nhcULVyPcv1XJdY/
         WKg1rqmX45He4/DEcxhMskAgppemfZHb77JcTqKYU5NGbkRz0XxORq3Cjla7/WWuHU2N
         A4ZZi8QC91AQy3H3i6mIIOiMslImfd9KOuY8p7COLTeNnf7W4Zm+3qmaEKJb9+z1cRwi
         rqVWVVQlBtQZJEey4jO+bN0YCp+/fvvlO452llSwy2r987CItldKtdIW3sdQdOdJw8RF
         tJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758102041; x=1758706841;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jQzjfISWXhmjsCWqCbC/EKcBa3nhvEnsbsmWDiienE=;
        b=bpUTHlijO2oP9O1WvFOmHcbWWOeq79+Dpk/HcH3RqXLi3DXQhYrS3dRUBUgkTfmPQy
         ZVj/y4IqAp+JfO79BgPQ4+MwaBUDduSqvGBLHQtupFubrylPj5k4XeExF40Ep3pCu0Uu
         qBkmqtQEiFBkJHbsT2uKehWf5LhVE21XAsmVumhaATsGL8ovtyCnubYZUx6McY6ZLCdu
         Z12Ir/xUi2HU9ZfviMW4yPBaIASg+4FI6khSLHEKhuoaiXtakWcISu2q8TUvA9AzE7m8
         YKZijjdhmaM2V4FbM8urhZwE8CJca6ugO0/L1LAp4J7yf+czxf9xs6IlQOXlCFVsaXM/
         PNGA==
X-Forwarded-Encrypted: i=1; AJvYcCUnAVJ+DxRmVcksEkbPD27fUgjGDRT5S/C7qL3khGAkiw5UtEw9dnAAlEIidznJC7H16K10pjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09yJ193j7AZTGOehQqr+UgNj8euVI6JmEHEgEYzr5FEZmI0aV
	kTKNoTCw4gDfsg9+JJd6hkcbuRjswFEK7RbfLcgWDqDMZGTvEWQU203Y
X-Gm-Gg: ASbGncu2bt3H3Ld5e9ByOjjmw+exDWPYLxB1JehqbVQoCryh7/7HuVYvB8LQGru2PzJ
	+4VTbHJml3w12inR4VoyP2x6PhKqeQszNP/6AmPJy8rP3oMH6wJA+EpLW580hqD8rPBu0nOv4+T
	THhk2f2Own4ipWOMMMIPpbLc8hc643VGhcZDIqiEnpgdnrkps6Mu+5I9LKwPAWx6kvf3ToavYlu
	/RgPvo62ze8OqL55YgiSFXwvfjEj6guy1TdDxhIi6rnu9nOM9Gt5trloiPZlWkJbkoWsHdp3v5T
	zM2mbZ2mqYTfievRzeT9vnFijGScG7XvYnT86VzWFzigSewGJDnOQ8i0mnPGh59XYbOPWnXR2zl
	C+6z2M5DgOONTOgfH6CUT48yY6KSmUPjVWXjQMxYY7W2SYm2+u3/5CM1Fg31mTGnQuT6Ubw==
X-Google-Smtp-Source: AGHT+IG1Z5gfPhstZ8Qe0/f0tZQDFllaZrwj1CdOj/WzkKpXcRN9xT6g090i2kZL7HUgri/YALYN1g==
X-Received: by 2002:a05:600c:190e:b0:45d:d9ca:9f8a with SMTP id 5b1f17b1804b1-46206655f96mr10607395e9.27.1758102040358;
        Wed, 17 Sep 2025 02:40:40 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613eb27f25sm30833585e9.23.2025.09.17.02.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:40:39 -0700 (PDT)
Message-ID: <68ca8217.050a0220.81571.9fda@mx.google.com>
X-Google-Original-Message-ID: <aMqCFMC3zeBPyOCQ@Ansuel-XPS.>
Date: Wed, 17 Sep 2025 11:40:36 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
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
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250917092807.uui2qwva2sqbe6sp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917092807.uui2qwva2sqbe6sp@skbuf>

On Wed, Sep 17, 2025 at 12:28:07PM +0300, Vladimir Oltean wrote:
> On Mon, Sep 15, 2025 at 12:45:36PM +0200, Christian Marangi wrote:
> > It's conceptually similar to mediatek switch but register and bits
> > are different. And there is massive list of register for the PCS
> > configuration.
> > Saddly for that part we have absolutely NO documentation currently.
> 
> Please add in the next revision a more convincing argument for not
> reusing the mt7530 driver control flow. Regmap fields can abstract a
> lot, and the driver can select a completely different phylink_pcs for
> different hardware.
> 
> I don't see in the short change log included here any mentions related
> to the mt7530, but I'm not going to search the mailing lists since Nov
> 2024 for any previous discussions about this...
>

Ok will add additional info.

But In short the FDB and VLAN part are very different. The FDB logic to
dump entry add and remove is entirely different.

And the mt7530 itself is full of unrelated function (specific to the
first revision of the mt7530 switch) so I have to move lots of code
around.

If asked I can do it but I have to also introduce lots of extra change.

> Also, let's try not to reach v20.. Please try to collect a full round of
> feedback from people who commented before when submitting a new version,
> pinging people if necessary. You want to make sure that their previous
> feedback was addressed.
> 
> > TEST: lan2: Multicast IPv4 to joined group                          [ OK ]
> > TEST: lan2: Multicast IPv4 to unknown group                         [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: lan2: Multicast IPv4 to unknown group, promisc                [ OK ]
> > TEST: lan2: Multicast IPv4 to unknown group, allmulti               [ OK ]
> > TEST: lan2: Multicast IPv6 to joined group                          [ OK ]
> > TEST: lan2: Multicast IPv6 to unknown group                         [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: lan2: Multicast IPv6 to unknown group, promisc                [ OK ]
> > TEST: lan2: Multicast IPv6 to unknown group, allmulti               [ OK ]
> > TEST: lan2: 1588v2 over L2 transport, Sync                          [ OK ]
> > TEST: lan2: 1588v2 over L2 transport, Follow-Up                     [ OK ]
> > TEST: lan2: 1588v2 over L2 transport, Peer Delay Request            [ OK ]
> > TEST: lan2: 1588v2 over IPv4, Sync                                  [FAIL]
> >         reception failed
> > TEST: lan2: 1588v2 over IPv4, Follow-Up                             [FAIL]
> >         reception failed
> > TEST: lan2: 1588v2 over IPv4, Peer Delay Request                    [FAIL]
> >         reception failed
> > TEST: lan2: 1588v2 over IPv6, Sync                                  [FAIL]
> >         reception failed
> > TEST: lan2: 1588v2 over IPv6, Follow-Up                             [FAIL]
> >         reception failed
> > TEST: lan2: 1588v2 over IPv6, Peer Delay Request                    [FAIL]
> >         reception failed
> 
> Do you know why it won't receive PTP over IP? It seems strange, given it
> receives other IP multicast (even unregistered). Is it a hardware or a
> software drop? What port counters increment? Does it drop PTP over IP
> only on local termination, or does it also fail to forward it? What
> about the packet makes the switch drop it?
> 

From what they said there isn't any support for 1588v2 (PTP) on the Switch other
than L2 (that I think they simply forward)

I can ask more info on the topic, will also check what counters
increment.

> > TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
> > TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
> > TEST: VLAN upper: Unicast IPv4 to primary MAC address               [ OK ]
> > TEST: VLAN upper: Unicast IPv4 to macvlan MAC address               [ OK ]
> > TEST: VLAN upper: Unicast IPv4 to unknown MAC address               [ OK ]
> > TEST: VLAN upper: Unicast IPv4 to unknown MAC address, promisc      [ OK ]
> > TEST: VLAN upper: Unicast IPv4 to unknown MAC address, allmulti     [ OK ]
> > TEST: VLAN upper: Multicast IPv4 to joined group                    [ OK ]
> > TEST: VLAN upper: Multicast IPv4 to unknown group                   [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: VLAN upper: Multicast IPv4 to unknown group, promisc          [ OK ]
> > TEST: VLAN upper: Multicast IPv4 to unknown group, allmulti         [ OK ]
> > TEST: VLAN upper: Multicast IPv6 to joined group                    [ OK ]
> > TEST: VLAN upper: Multicast IPv6 to unknown group                   [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: VLAN upper: Multicast IPv6 to unknown group, promisc          [ OK ]
> > TEST: VLAN upper: Multicast IPv6 to unknown group, allmulti         [ OK ]
> > TEST: VLAN upper: 1588v2 over L2 transport, Sync                    [ OK ]
> > TEST: VLAN upper: 1588v2 over L2 transport, Follow-Up               [FAIL]
> >         reception failed
> > TEST: VLAN upper: 1588v2 over L2 transport, Peer Delay Request      [ OK ]
> > TEST: VLAN upper: 1588v2 over IPv4, Sync                            [FAIL]
> >         reception failed
> > ;TEST: VLAN upper: 1588v2 over IPv4, Follow-Up                       [FAIL]
> >         reception failed
> > TEST: VLAN upper: 1588v2 over IPv4, Peer Delay Request              [FAIL]
> >         reception failed
> > TEST: VLAN upper: 1588v2 over IPv6, Sync                            [FAIL]
> >         reception failed
> > TEST: VLAN upper: 1588v2 over IPv6, Follow-Up                       [FAIL]
> >         reception failed
> > TEST: VLAN upper: 1588v2 over IPv6, Peer Delay Request              [FAIL]
> >         reception failed
> 
> The same thing happens with VLAN too...
> 
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to joined group   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group   [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to joined group   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group   [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Sync   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Sync   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to joined group   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group   [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to joined group   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group   [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Sync   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Sync   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
> >         reception failed
> 
> And over bridge ports...

-- 
	Ansuel

