Return-Path: <netdev+bounces-250514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24168D30A80
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1744A303ACE7
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC71379981;
	Fri, 16 Jan 2026 11:47:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC9156237;
	Fri, 16 Jan 2026 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768564079; cv=none; b=rLj0rCYtCSOu7EXcriEFQ2xTzXAFoo+23XIg0fOQn2HcaHWy2Pb6dipARcLTzjplTdcT5vd9H+7gmbwUGZDnJJOshkg3JpoLj+wu8xw5uz4cW264OmMsVN93kE9UaDcStQlV28W0/1SzA9eeOr6+6+2li3h6fbQ1m3l70dg6EPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768564079; c=relaxed/simple;
	bh=G61GHChez095a2ya1qSTH70HGFtX2GymqxpfbzIqmaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQg6wL+agEhwy1dbz0UvMi3qnME6KlckiB1xUCTo2XxIXkSqONKUrf8dZs94VQUWr1aIsGV11DzFWfFQOxy98/E5d9buaWRWsB/zFBVLZEZN5D4I+x6Zd/3sV/EqIWX/enD5lAG8+nxOd16ZoWDhyeN3zd9oeavAJGtj0X26kLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgiIr-000000001gp-13U9;
	Fri, 16 Jan 2026 11:47:45 +0000
Date: Fri, 16 Jan 2026 11:47:42 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen Minqiang <ptpt52@gmail.com>,
	Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: Re: [PATCH net-next v3 3/6] net: dsa: lantiq: allow arbitrary MII
 registers
Message-ID: <aWolXoaMUr-vlKxh@makrotopia.org>
References: <cover.1768519376.git.daniel@makrotopia.org>
 <c1b9bc590aa097c98816a3fda6931db9b3d080af.1768519376.git.daniel@makrotopia.org>
 <20260115191108.1a7eac9f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115191108.1a7eac9f@kernel.org>

On Thu, Jan 15, 2026 at 07:11:08PM -0800, Jakub Kicinski wrote:
> On Fri, 16 Jan 2026 00:07:37 +0000 Daniel Golle wrote:
> > +__diag_push();
> > +__diag_ignore_all("-Woverride-init",
> > +		  "logic to initialize all and then override some is OK");
> 
> This seems quite unjustified to save at a glance 4 lines of code.

So I'll spell it out instead. I kinda like the notion of default
initializers, it's much more obviously correct and impossible to
accidentally leave anything uninitialized (or rather wrongly initialized
with 0).

In lantiq_gswip.c it would look like this then:
	.mii_cfg = {
		[0] = GSWIP_MII_CFGp(0),
		[1] = GSWIP_MII_CFGp(1),
		[2 ... 4] = -1,
		[5] = GSWIP_MII_CFGp(5),
		[6] = -1,
	},
	.mii_pcdu = {
		[0] = GSWIP_MII_PCDU0,
		[1] = GSWIP_MII_PCDU1,
		[2 ... 4] = -1,
		[5] = GSWIP_MII_PCDU5,
		[6] = -1,
	},
...
	.mii_cfg = {
		[0] = GSWIP_MII_CFGp(0),
		[1 ... 4] = -1,
		[5] = GSWIP_MII_CFGp(5),
		[6] = -1,
	},
	.mii_pcdu = {
		[0] = GSWIP_MII_PCDU0,
		[1 ... 4] = -1,
		[5] = GSWIP_MII_PCDU5,
		[6] = -1,
	},

