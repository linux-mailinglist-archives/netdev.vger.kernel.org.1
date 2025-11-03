Return-Path: <netdev+bounces-235006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3104BC2B22D
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517C43B62C0
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6902FABF8;
	Mon,  3 Nov 2025 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cevsnj/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB11DE3A4
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166908; cv=none; b=eGDG1bXIyDo5QO9CwAphoGPz8UJ031W7R9WeJ6Fkn1SQvWslK/DagWrW+1k534tSW/XYr1bLVaMjckm/RKMXbbPHrIREXDVSEgq39LKro6cuF3UUL/eDKNuImgni0BZvuntiYHzKpPP6CVJiZ3ZTDHMWGx8+Ip3q7lqj0hpb1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166908; c=relaxed/simple;
	bh=zR8m1qbQRz9XWrZGV54/95RKZ4jTNlcX/unLFNHmNNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWWnWyXLgmeC/quwRhoN2qGRuMdyOu28CeBXfwE3/Kc7jb0hgWj7kcbXDsGoz69d7dc/dp00I3kkY9ELTaagHME11xqPhKSXk7q7VUTbPHBpF+n/33UDKbRmTWjju/laQnIPhSsYwerhKNqCoGxt9tjs8dJNI3XnIKBtRKxBuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cevsnj/E; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c5e0f94eso264508f8f.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 02:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762166905; x=1762771705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oT9RtigCr8SXNb36gcbFehyubQYXLfyyxsU6nQOAO4g=;
        b=cevsnj/EdSPO9L3UbZrw2I13Au0WlIFeF9z2oB1XPjmWhmeVpjxUxgKtJU0HZtYX1T
         35v207nVg1QrRIovKozQOBS/AEw5fDTW3dCPBTpAKQyV06L8ZC0uZqAsOirqg5PT0Kea
         CkI553nz5eaP1XDafm7VXdodLajMRCH7whP9tvYiEAxFCbpXyYATQ+0eKZeeKps1B0D3
         MwZ5CN0krG+OjgOOWNeqHXqUxOsG6Tabmm3HG0308yeGYsnEE+PBGzilsdy2aG71Oulx
         BzXVUCNiT+vDFGemmuw81Qn2TkCrTZn3smwpejnHbxulCyI2xzLtUAOk42cIxi5VoDBH
         w6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166905; x=1762771705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT9RtigCr8SXNb36gcbFehyubQYXLfyyxsU6nQOAO4g=;
        b=mtkWgpuxca10M/gLXlnS7j8jh1hzm9Cz/ka2eFS8sEgeWuoRMDgcZqEJxl3pzWtO0v
         y+L/I3wNfK3AIZt3oJqBXaBRwUiTKLiNyvEER6BajO3jKpMAUe26NPRNYnYhWT6OB4J3
         /vzNsYzyyvr5l6ECbW7Bj4HcLaveQlQyfBalOvEZrrM/ceDXo8wh9PPqM8eD7PV09s6t
         IEtHYDZ1/zQGzN+PnaIj/ovtIQMM/PFMSGR9mTmb8LrhPuKYlY9O9f0AvX0Fs8cm8OoV
         4nv4/p2oWD6ZZGNn9nTFoHiF28XRvbZKXbtY1uu0cdNMD5ihcywgeDlf/UrQ/OZEwpPD
         VD9A==
X-Forwarded-Encrypted: i=1; AJvYcCUTFm2RukNkHWL5TQtlVngB7hUNz5VzKssT85yw5vOgWkTmo1fsrL2MUvL8W4WEVREgkzRfKAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGKqiC1pNL0roBTXRg+6tsgObqZXjz+V/u9SsOBEMQRc7+K9H3
	qbh9lfZHuagf9aPN3vSKGOVqTu9RDXvgUu2J6CmHO+JgzdpEa10hRNqL
X-Gm-Gg: ASbGnctXnO3HoLcbhEzv+5tpGVAIpQgOmH7KsxhbrwF0clhqzgY44CE2J7RHnnfeLgZ
	q+7IZRFD3u8FfF5mJB6nauWiYH7JNkzc/qztI23xR4oBXT0PI0dl9XpZHubWum8h+nbjUym+5Ch
	ABw13JyXYN32D09M02KOgw5IOlbRyZiDH2GgxeQB8h9nRfHNmuvu/pV/GWOsJO9q1838ycj0jYi
	Hic2L639yMz1QRAS/hhGo6PnihMtFSGJxvAOWaIgXAwfI7iTTPBioCTiSANcUKGWj78tMUc6w4H
	55FbGU3ptByhlJ5bPkRufdR+9seMUvoSfV6I1tCqmO8qZko50/Srt0Oz8xpDtjVKvHsSx/Bk6VF
	D6JPccCDbY7MPptCTcUe65+Qp/IC6BaLkFSp9Iw8dHWzLMwd6/79lS32M72Psd1ndtWxT
X-Google-Smtp-Source: AGHT+IFDkHIlGH+UICeedNY8tuFUMLJ68lqu5VoPcOTjTIWj9r93aVIljpR0UjzUe74VKQmlKp+fEQ==
X-Received: by 2002:a5d:5f50:0:b0:429:b4ce:c692 with SMTP id ffacd0b85a97d-429bd6a77bcmr5661427f8f.7.1762166904243;
        Mon, 03 Nov 2025 02:48:24 -0800 (PST)
Received: from skbuf ([2a02:2f04:d406:ee00:7144:c922:dc8a:113d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429d12e1173sm7767173f8f.42.2025.11.03.02.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:48:23 -0800 (PST)
Date: Mon, 3 Nov 2025 12:48:20 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <20251103104820.3fcksk27j34zu6cg@skbuf>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <aQExx0zXT5SvFxAk@oss.qualcomm.com>
 <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
 <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
 <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
 <aQh7Zj10C7QcDoqn@shell.armlinux.org.uk>
 <aQiBjYNtJks2/mrw@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQiBjYNtJks2/mrw@oss.qualcomm.com>

On Mon, Nov 03, 2025 at 03:48:53PM +0530, Mohd Ayaan Anwar wrote:
> On Mon, Nov 03, 2025 at 09:52:38AM +0000, Russell King (Oracle) wrote:
> > On Mon, Nov 03, 2025 at 02:28:24PM +0530, Mohd Ayaan Anwar wrote:
> > > On Thu, Oct 30, 2025 at 03:22:12PM +0000, Russell King (Oracle) wrote:
> > > > On Thu, Oct 30, 2025 at 03:19:27PM +0000, Russell King (Oracle) wrote:
> > > > > > 
> > > > > > This is probably fine since Bit(9) is self-clearing and its value just
> > > > > > after this is 0x00041000.
> > > > > 
> > > > > Yes, and bit 9 doesn't need to be set at all. SGMII isn't "negotiation"
> > > > > but the PHY says to the MAC "this is how I'm operating" and the MAC says
> > > > > "okay". Nothing more.
> > > > > 
> > > > > I'm afraid the presence of snps,ps-speed, this disrupts the test.
> > > > 
> > > > Note also that testing a 10M link, 100M, 1G and finally 100M again in
> > > > that order would also be interesting given my question about the RGMII
> > > > register changes that configure_sgmii does.
> > > > 
> > > 
> > > Despite several attempts, I couldn't get 10M to work. There is a link-up
> > > but the data path is broken. I checked the net-next tip and it's broken
> > > there as well.
> > > 
> > > Oddly enough, configure_sgmii is called with its speed argument set to
> > > 1000:
> > > [   12.305488] qcom-ethqos 23040000.ethernet eth0: phy link up sgmii/10Mbps/Half/pause/off/nolpi
> > > [   12.315233] qcom-ethqos 23040000.ethernet eth0: major config, requested phy/sgmii
> > > [   12.322965] qcom-ethqos 23040000.ethernet eth0: interface sgmii inband modes: pcs=00 phy=03
> > > [   12.331586] qcom-ethqos 23040000.ethernet eth0: major config, active phy/outband/sgmii
> > > [   12.339738] qcom-ethqos 23040000.ethernet eth0: phylink_mac_config: mode=phy/sgmii/pause adv=0000000,00000000,00000000,00000000 pause=00
> > > [   12.355113] qcom-ethqos 23040000.ethernet eth0: ethqos_configure_sgmii : Speed = 1000
> > > [   12.363196] qcom-ethqos 23040000.ethernet eth0: Link is Up - 10Mbps/Half - flow control off
> > 
> > If you have "rate matching" enabled (signified by "pause" in the mode=
> > part of phylink_mac_config), then the MAC gets told the maximum speed for
> > the PHY interface, which for Cisco SGMII is 1G. This is intentional to
> > support PHYs that _really_ do use rate matching. Your PHY isn't using it,
> > and rate matching for SGMII is pointless.
> > 
> > Please re-run testing with phy-mode = "sgmii" which you've tested
> > before without your rate-matching patch to the PHY driver, so the
> > system knows the _correct_ parameters for these speeds.
> > 
> Sorry, I forgot to mention that all the recent testing is being done on
> QCS9100 Ride R3 which has the AQR115C PHY.
> 
> My rate-matching patch was for IQ8 which has the QCA808X PHY. I am
> putting its testing on hold until we sort everything out on QCS9100
> first.
> 
> So, for AQR115C, what should be the way forward? It has support for rate
> matching. For 10M should I remove its .get_rate_matching callback?
> 
> 	Ayaan

As Russell partially pointed out, there are several assumptions in the
Aquantia PHY driver and in phylink, three of them being that:
- rate matching is only supported for PHY_INTERFACE_MODE_10GBASER and
  PHY_INTERFACE_MODE_2500BASEX (thus not PHY_INTERFACE_MODE_SGMII)
- if phy_get_rate_matching() returns RATE_MATCH_NONE for an interface,
  pl->phy_state.rate_matching will also be RATE_MATCH_NONE when using
  that interface
- if rate matching is used, the PHY is configured to use it for all
  media speeds <= phylink_interface_max_speed(link_state.interface)

Those assumptions are not validated very well against the ground truth
from the PHY provisioning, so the next step would be for us to see that
directly.

Please turn this print from aqr_gen2_read_global_syscfg() into something
visible in dmesg, i.e. by replacing phydev_dbg() with phydev_info():

		phydev_dbg(phydev,
			   "Media speed %d uses host interface %s with %s\n",
			   syscfg->speed, phy_modes(syscfg->interface),
			   syscfg->rate_adapt == AQR_RATE_ADAPT_NONE ? "no rate adaptation" :
			   syscfg->rate_adapt == AQR_RATE_ADAPT_PAUSE ? "rate adaptation through flow control" :
			   syscfg->rate_adapt == AQR_RATE_ADAPT_USX ? "rate adaptation through symbol replication" :
			   "unrecognized rate adaptation type");

