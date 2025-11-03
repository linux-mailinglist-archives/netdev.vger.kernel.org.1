Return-Path: <netdev+bounces-235052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F174C2B94A
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 13:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4892188DEEF
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 12:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2265307ADD;
	Mon,  3 Nov 2025 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTlJv5jk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17C1DE3B5
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172041; cv=none; b=cFj6FDDvnRRmHX7G/klCE0cwZDPL62xS1KKeMYFdb0kZl84BIvxxLzLZqyRTpsTgP94n7vsMYgD/EO1FP7xHYN65/XWsnUH10fWvG6in5/KbiejlF3On6J4OaJWpcjZ4lTt7eLusRk2M/Xnxtk4hsvsGce8orjyt7xyQNAlDFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172041; c=relaxed/simple;
	bh=94R+AypRncUPftDElkOk+ULlHwRR1wl4lcQdo4G8YQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZWGs3eADlOVDXxfTVtGkphx5NvwgCbd4wMv2crV/fnsLhvZqcBDcnXr05puU4xzLWk8Zhj6AKfeGWfdKVONIHTq6lIkyY+j1f+1jGpTYGjrrW7CaEXjJJEeZ52IraaLjEQKtClwK/JMSSU5j1o74W3nITtjgtzuXyDNCz5rvTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTlJv5jk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47103531eeeso2993575e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 04:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762172038; x=1762776838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvThRY4eNfW5Inji/W0VKFrAjmGKVWgkAa2RGmz2+O0=;
        b=gTlJv5jkcxbWQ9JQFj16xBE88yC03haKjq/vuTxX+U+9qurlHO7DHFYU7y9t+00WM/
         q0zOeLKUvlJnScb5GqFxxz0cf0z6DXYTTUSafiSZ++YzQV/+XCYb+R50wg5dWCIy9Zhf
         PmbreiprM4F9RpBySjZTE4HpzHxKT9/iZ03Cti2xTOoUUedUzHr+tn1WS92T58j15nij
         iBtYU3QAJDaUO69HRR7Ht0F8lrH1fdpg5nK8jj7jre7LwfR89T6p/NbZSlTrY01PQoof
         aVWt/RAG91QP0XsVUNKB/jWtQTTRw4JVbdMJmenXKt9QcZUO5OD7NzN1iHeuhYB/+khZ
         4NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172038; x=1762776838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvThRY4eNfW5Inji/W0VKFrAjmGKVWgkAa2RGmz2+O0=;
        b=gW8hGHLrBQNGEesY06Ehj2SNq/7blxIuQt+/NY92bbrGWcbPfl7GIXdAm2b3NqPcf9
         yi0mY1Cw1eaEqVqlebkXcLAlb4RZbV9pxCyqzD6Kz58eVexzvGqGwgxIzVxiX02OlTdF
         3rg+/UAoRdIvdEBBLHFXJ+2FSEsXD1X3/9HvbeUquRFMvtTqWDwI7GX+yrOZ9B9mF55c
         Y6fSpspqRYor9kocq5aD39itkzy1JbdzmZN2T6IMyedZ0SPhdzvCxp9d5VuQKJ/62Omh
         w2m9rg2uZNqAX84RFDNgqzXRYALrS+JOIFbetZZ2xB8O7g+zCiRNnjDMIcxJ0AYaAuO9
         bkdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyCBp3VWgWSaswvUg1UlNipHjj5jl9qZkXfeY3VdV/o/KW2au893g0FQRumBv8RI+7y+mKcuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+I+mZv9RwEK4ricBgC+EWpdWvNLM82lA6O4gRUmm/f2Pxf66
	IfzIwvEkmn6HE4KP8w9xsUq2gYSJl9An1QaCjOzFZHVcPDrV278LUDpm
X-Gm-Gg: ASbGncvffX+GcQAsls3dKAiswSo53KxqxEO3uD8/HfZkmcui+PG0cOK4mEBlovZBFE4
	lFYDh42WMmNMb5SNe+I4xcl0RdFje2KGtyIpLAtF9uqvFQfs4Fd4LDGHrDj5sOWisok5pD+GC1l
	9Iq5lS0BNrQVCs/QgsK5SYDoVa9zjk8EBOBGcW2AjjMj6uDu1wreHurDNSbgpot+KuRTCcWOWiw
	tFK8rEffy/Sx5w3lPPQbOUmOqp7DHV2aHiS53go1VGTWH6bRMZZJ1sozVe9hXYoNZQUsAr0wKbx
	h3qVjuofu1f4L5aE7dO78HLaTA5upodTAp1BjThGwYo65rp4MSfLyAKP7ErRAc8OZP5G9QY03G3
	WDv0y+FnoLkULvrFlqgP9xucLIWetPsh6c3lt9joBwLc5DwV6wCS+LNfzt0JYo6Yk1+f129LE71
	vDWdg=
X-Google-Smtp-Source: AGHT+IGQt2Q95D+Meobm86HVWwUHLHSku+aRz/VeZME+I3ZAsJ3m+6wdDTCQZ+nPhU3uPW8S3WqRpQ==
X-Received: by 2002:a05:600c:19c6:b0:477:10c4:b52 with SMTP id 5b1f17b1804b1-4773090238fmr57140915e9.8.1762172037406;
        Mon, 03 Nov 2025 04:13:57 -0800 (PST)
Received: from skbuf ([2a02:2f04:d406:ee00:7144:c922:dc8a:113d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c23b8d9sm173739975e9.0.2025.11.03.04.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:13:56 -0800 (PST)
Date: Mon, 3 Nov 2025 14:13:53 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
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
Message-ID: <20251103121353.dbnalfub5mzwad62@skbuf>
References: <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
 <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
 <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
 <aQh7Zj10C7QcDoqn@shell.armlinux.org.uk>
 <aQiBjYNtJks2/mrw@oss.qualcomm.com>
 <20251103104820.3fcksk27j34zu6cg@skbuf>
 <aQiP46tKUHGwmiTo@oss.qualcomm.com>
 <aQiVWydDsRaMz8ua@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="56qp7pmq6cw7fsz2"
Content-Disposition: inline
In-Reply-To: <aQiVWydDsRaMz8ua@shell.armlinux.org.uk>


--56qp7pmq6cw7fsz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2025 at 11:43:23AM +0000, Russell King (Oracle) wrote:
> On Mon, Nov 03, 2025 at 04:50:03PM +0530, Mohd Ayaan Anwar wrote:
> > On Mon, Nov 03, 2025 at 12:48:20PM +0200, Vladimir Oltean wrote:
> > > 
> > > As Russell partially pointed out, there are several assumptions in the
> > > Aquantia PHY driver and in phylink, three of them being that:
> > > - rate matching is only supported for PHY_INTERFACE_MODE_10GBASER and
> > >   PHY_INTERFACE_MODE_2500BASEX (thus not PHY_INTERFACE_MODE_SGMII)
> > > - if phy_get_rate_matching() returns RATE_MATCH_NONE for an interface,
> > >   pl->phy_state.rate_matching will also be RATE_MATCH_NONE when using
> > >   that interface
> > > - if rate matching is used, the PHY is configured to use it for all
> > >   media speeds <= phylink_interface_max_speed(link_state.interface)
> > > 
> > > Those assumptions are not validated very well against the ground truth
> > > from the PHY provisioning, so the next step would be for us to see that
> > > directly.
> > > 
> > > Please turn this print from aqr_gen2_read_global_syscfg() into something
> > > visible in dmesg, i.e. by replacing phydev_dbg() with phydev_info():
> > > 
> > > 		phydev_dbg(phydev,
> > > 			   "Media speed %d uses host interface %s with %s\n",
> > > 			   syscfg->speed, phy_modes(syscfg->interface),
> > > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_NONE ? "no rate adaptation" :
> > > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_PAUSE ? "rate adaptation through flow control" :
> > > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_USX ? "rate adaptation through symbol replication" :
> > > 			   "unrecognized rate adaptation type");
> > 
> > Thanks. Looks like rate adaptation is only provisioned for 10M, which
> > matches my observation where phylink passes the exact speeds for
> > 100/1000/2500 but 1000 for 10M.
> 
> Hmm, I wonder what the PHY is doing for that then. stmmac will be
> programmed to read the Cisco SGMII in-band control word, and use
> that to determine whether symbol replication for slower speeds is
> being used.
> 
> If AQR115C is indicating 10M in the in-band control word, but is
> actually operating the link at 1G speed, things are not going to
> work, and I would say the PHY is broken to be doing that. The point
> of the SGMII in-band control word is to tell the MAC about the
> required symbol replication on the link for transmitting the slower
> data rates over the link.
> 
> stmmac unfortunately doesn't give access to the raw Cisco SGMII
> in-band control word. However, reading register 0xf8 bits 31:16 for
> dwmac4, or register 0xd8 bits 15:0 for dwmac1000 will give this
> information. In that bitfield, bits 2:1 give the speed. 2 = 1G,
> 1 = 100M, 0 = 10M.

It might be Linux who is forcing the AQR115C into the nonsensical
behaviour of advertising 10M in the SGMII control word while
simultanously forcing the PHY MII to operate at 1G with flow control
for the 10M media speed.

We don't control the latter, but we do control the former:
aqr_gen2_config_inband(), if given modes == LINK_INBAND_ENABLE, will
enable in-band for all media speeds that use PHY_INTERFACE_MODE_SGMII.
Regardless of how the PHY was provisioned for each media speed, and
especially regardless of rate matching settings, this function will
uniformly set the same in-band enabled/disabled setting for all media
speeds using the same host interface.

If dwmac_integrated_pcs_inband_caps(), as per Russell's patch 1/3,
reports LINK_INBAND_ENABLE | LINK_INBAND_DISABLE, and if
aqr_gen2_inband_caps() also reports LINK_INBAND_ENABLE | LINK_INBAND_DISABLE,
then we're giving phylink_pcs_neg_mode() all the tools it needs to shoot
itself in the foot, and select LINK_INBAND_ENABLE.

The judgement call in the Aquantia PHY driver was mine, as documented in
commit 5d59109d47c0 ("net: phy: aquantia: report and configure in-band
autoneg capabilities"). The idea being that the configuration would have
been unsupportable anyway given the question that the framework asks:
"does the PHY use in-band for SGMII, or does it not?"

Assuming the configuration at 10Mbps wasn't always broken, there's only
one way to know how it was supposed to work: more dumping of the initial
provisioning, prior to our modification in aqr_gen2_config_inband().
Ayaan, please re-print the same info with this new untested patch applied.
I am going to assume that in-band autoneg isn't enabled in the unmodified
provisioning, at least for 10M.

Russell's request for the integrated PCS status is also a good parallel
confirmation that yes, we've entered a mode where the PHY advertises
SGMII replication at 10M.

--56qp7pmq6cw7fsz2
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-phy-aquantia-add-inband-setting-to-the-aqr_gen2_.patch"

From b91162e5dae8e20b477999c4f2fcdb98c219d663 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 3 Nov 2025 14:03:55 +0200
Subject: [PATCH] net: phy: aquantia: add inband setting to the
 aqr_gen2_read_global_syscfg() print

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 41f3676c7f1e..f06b7b51bb7d 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -839,6 +839,7 @@ static int aqr_gen2_read_global_syscfg(struct phy_device *phydev)
 
 	for (i = 0; i < AQR_NUM_GLOBAL_CFG; i++) {
 		struct aqr_global_syscfg *syscfg = &priv->global_cfg[i];
+		bool inband;
 
 		syscfg->speed = aqr_global_cfg_regs[i].speed;
 
@@ -849,6 +850,7 @@ static int aqr_gen2_read_global_syscfg(struct phy_device *phydev)
 
 		serdes_mode = FIELD_GET(VEND1_GLOBAL_CFG_SERDES_MODE, val);
 		rate_adapt = FIELD_GET(VEND1_GLOBAL_CFG_RATE_ADAPT, val);
+		inband = FIELD_GET(VEND1_GLOBAL_CFG_AUTONEG_ENA, val);
 
 		switch (serdes_mode) {
 		case VEND1_GLOBAL_CFG_SERDES_MODE_XFI:
@@ -896,12 +898,13 @@ static int aqr_gen2_read_global_syscfg(struct phy_device *phydev)
 		}
 
 		phydev_dbg(phydev,
-			   "Media speed %d uses host interface %s with %s\n",
+			   "Media speed %d uses host interface %s with %s, inband %s\n",
 			   syscfg->speed, phy_modes(syscfg->interface),
 			   syscfg->rate_adapt == AQR_RATE_ADAPT_NONE ? "no rate adaptation" :
 			   syscfg->rate_adapt == AQR_RATE_ADAPT_PAUSE ? "rate adaptation through flow control" :
 			   syscfg->rate_adapt == AQR_RATE_ADAPT_USX ? "rate adaptation through symbol replication" :
-			   "unrecognized rate adaptation type");
+			   "unrecognized rate adaptation type",
+			   str_enabled_disabled(inband));
 	}
 
 	return 0;
-- 
2.43.0


--56qp7pmq6cw7fsz2--

