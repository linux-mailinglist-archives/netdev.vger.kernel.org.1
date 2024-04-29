Return-Path: <netdev+bounces-92050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74BA8B531A
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FB71C202F9
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 08:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986F717557;
	Mon, 29 Apr 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gPBRLD/0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC3171B0
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379206; cv=none; b=ca+Hhq3vTnSimGqv264t0xbm0vrXBYFT6JmbdJZZ1x4QVujYbaINAcbKm15pHQjCEv0n4ZGed/hYyHWNVU1ic/syigXMK8c8Wm3aa49OSt8hRr8QaqIkBdpxlrPRM4UKQvv3P2m4K2hFsIhFMF7OO7QczwAxLPyLRVrYxqyyZuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379206; c=relaxed/simple;
	bh=oLLG2VZVpj1tWm+4guJMf5Cu2uCyByUZfFE2T0nQJz8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3cLGVvJ6ULxrGp3rO+ijuacI54mgCjEuefKwed1cUJeYRof2n3A6Luw1fK9oqa9KJ1TAuv2LDTdM7H02ewEJvonevms4AdOsjdl2+QapyNs7kpA6gimuS76RfbJGaEliRBMHX4YKw709jPYh4J4rmQ5756xjDnFGNmJ9tlpZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gPBRLD/0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714379205; x=1745915205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oLLG2VZVpj1tWm+4guJMf5Cu2uCyByUZfFE2T0nQJz8=;
  b=gPBRLD/0dd/v1eM9noeExcHfTrYqTGA8Ml7/1CEVEQWHjbwD4w0qE5Jf
   wJKBodPnvxQ5jZcjIai5KXGX3oZXyc2wlO6wQXFJpUBuuMXWBarMfItTq
   z3joO0RmaN2vpKAvlxCuhDSmwPWp+PWcHsm8qDEtftwNTs7YpeJCGzSHv
   iMVcTU4Zoy7M6tGsZiIBfAltBtO+Q0VEOFk1N3GodqloKSpssMg5XYBAb
   u0BGCQVeDgy4GOJkQJK9Waw+z0NqNZpaj5juFWQYKcG/Ig32N9uTv0asS
   a6S6f4O+V2VElzinCsYroS/LSs8OF/8TU9/Y7xqKq/HIjmKVpTUs87tsy
   g==;
X-CSE-ConnectionGUID: junxQ3PiTqimaw+FWC0voQ==
X-CSE-MsgGUID: k5O6FnzIROqiCwd8vQHhKA==
X-IronPort-AV: E=Sophos;i="6.07,239,1708412400"; 
   d="scan'208";a="253987768"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Apr 2024 01:26:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 01:26:05 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 29 Apr 2024 01:26:03 -0700
Date: Mon, 29 Apr 2024 08:26:02 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: sfp: allow use 2500base-X for 2500base-T
 modules
Message-ID: <20240429082602.s33pdgc24ldsxyjg@DEN-DL-M70577>
References: <E1s15rv-00AHyk-5S@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <E1s15rv-00AHyk-5S@rmk-PC.armlinux.org.uk>

> Allow use of 2500base-X interface mode for PHY modules that support
> 2500base-T.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
 

