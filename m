Return-Path: <netdev+bounces-50524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E811B7F6068
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259D01C203B8
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615FE250E9;
	Thu, 23 Nov 2023 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bPFoM0lz"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2392F10F8;
	Thu, 23 Nov 2023 05:36:49 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1DD8FF818;
	Thu, 23 Nov 2023 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700746608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faoI2KwHEPy1FqnMSXrUntxVGy1KjNLj5WWRWRO+gvQ=;
	b=bPFoM0lzHYnDnXRN6XvN1sryMr7AxcewhuY4AabxZx0mJfSD8dwv6/t9Web+WJBAmy1ufL
	T3xtRy7zLsvtP2jsjmGLUPucmKJIcs2fQrNXQCAKHrmwQnbmpsXjkRXp+pyznwUO/6LF52
	t7+HsdGVYm2mz734Iog2sMZ5AmxFk5Xkh2ArfBmwsPf5dstN7Yf8wf3rdHekvzP7BmRpvJ
	7WPde8hR9Kmm3xfZAmY0OfXR6rfuJuyJH1R2R5gc0ijqTz4MSlFz26k8LQFLXzQ6FxY5kK
	WmKFiBSRGtNHYYiQ5bpoT+4R/lWt0nlp9xRif+4MzQ/PNkBbm0aqeFbmvgoCvQ==
Date: Thu, 23 Nov 2023 14:36:45 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 05/10] net: ethtool: Allow passing a phy
 index for some commands
Message-ID: <20231123143645.0202d6b9@device.home>
In-Reply-To: <d7090506-68f9-4935-a0e9-b3143362b838@lunn.ch>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
	<20231117162323.626979-6-maxime.chevallier@bootlin.com>
	<d7090506-68f9-4935-a0e9-b3143362b838@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue, 21 Nov 2023 02:08:37 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +	if (dev) {
> > +		if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
> > +			u32 phy_index = nla_get_u32(tb[ETHTOOL_A_HEADER_PHY_INDEX]);
> > +
> > +			phydev = link_topo_get_phy(&dev->link_topo, phy_index);  
> 
> struct phy_device *link_topo_get_phy(struct link_topology *lt, int phyindex)
> 
> We have u32 vs int here for phyindex. It would be good to have the
> same type everywhere.

Indeed I messed-up the typing for that variable, shame as it's the core
of that series :(

I'll get it right for the next version.

> 
> > +			if (!phydev) {
> > +				NL_SET_ERR_MSG_ATTR(extack, header, "no phy matches phy index");
> > +				return -EINVAL;
> > +			}
> > +		} else {
> > +			/* If we need a PHY but no phy index is specified, fallback
> > +			 * to dev->phydev
> > +			 */
> > +			phydev = dev->phydev;
> > +		}
> > +	}
> > +
> > +	req_info->phydev = phydev;  
> 
> Don't forget to update Documentation/networking/ethtool-netlink.rst.

Yep I'll squeeze the documentation bit here.

Thanks for the review,

Maxime

>       Andrew


