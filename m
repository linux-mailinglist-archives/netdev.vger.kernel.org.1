Return-Path: <netdev+bounces-213293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262D2B24711
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4DF3AE9EF
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4160921256F;
	Wed, 13 Aug 2025 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2ca1AB1f"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09B523D7D3;
	Wed, 13 Aug 2025 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080238; cv=none; b=QwHEuRm+eDFFhOGH4t1GaLoqyMob63cxg2oMtf7DFHpLFQPWRvM2jqxpE2F9sE7P063+kuxSCKy9aH8V+of3nmSHZjoBvtAk15aFX/S+cwQQYJvx7tqCDTXFDwWyi0DHSxe78PylWmviVxQbx0FZYl4VBoLy8DVGc99c9Q561Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080238; c=relaxed/simple;
	bh=lrNpZlB9umeXwTmjGE2GqJw5dnth5DCUMuZn4g5clAo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2M6ArfXughSIg8EjLQTS1QAmCbr9fZ93pLei3OHiao+BJiaU2k1hwpj5wcMTpazUJ7tJa95rFmLYdjPyT6Rjb1WB4Mz7PadipfrKkI2N0/2Mc0OdFIBWvbUI/PLDls/adAN7WVKZeOFJ742LOx3QfxxYqgQToWK/YDq87GducQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2ca1AB1f; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755080236; x=1786616236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lrNpZlB9umeXwTmjGE2GqJw5dnth5DCUMuZn4g5clAo=;
  b=2ca1AB1fMtm4lyLXtMdTgobyZfhbZGoFIvcOdws8xcBrGz4k69RXVEuW
   lVqz18yAMH6ATq5P6ZAVGPE7zY6hqK12USKBgeJ/UX6qtBNzuEFRMGwpe
   aTiqqUCS9EMoWWzqVaLltBp6gkU/jKdpAmwoW8fmZiVWuye9y1tAWopVd
   gre21shE2sUORIyQEE9fdQ7KndVY/LANHDqlidcmICvyLsx9tFKr29kIh
   dv0mP/vdq+YSkQaYINyfPQPhCRMuC0K4kx3702U8lROqkfe8Beg30kmzy
   PUocPBhv5ApZ0sDEXpbDBfNs3gwGsriJam+QgpK+PVEshCZJuf2xEGN3S
   g==;
X-CSE-ConnectionGUID: 1xXjHcfyR+iACABg/xuIgQ==
X-CSE-MsgGUID: Z/+MFsDASBqEvft3BQqCHw==
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="276534688"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2025 03:17:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 13 Aug 2025 03:16:44 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 13 Aug 2025 03:16:43 -0700
Date: Wed, 13 Aug 2025 12:13:28 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<alok.a.tiwari@oracle.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 0/3] net: phy: micrel: Add support for lan8842
Message-ID: <20250813101328.7jpaqnxyf6ku7fht@DEN-DL-M31836.microchip.com>
References: <20250813063044.421661-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250813063044.421661-1-horatiu.vultur@microchip.com>

The 08/13/2025 08:30, Horatiu Vultur wrote:
> Add support for LAN8842 which supports industry-standard SGMII.
> While add this the first 3 patches in the series cleans more the
> driver, they should not introduce any functional changes.
> 
> v2->v3:
> - add better defines for page numbers
> - fix the statis->tx_errors, it was reading the rx_errors by mistake
> - update lanphy_modify_page_reg to keep lock over all transactions
> 
> v1->v2:
> - add the first 3 patches to clean the driver
> - drop fast link failure support
> - implement reading the statistics in the new way
> 
> Horatiu Vultur (3):
>   net: phy: micrel: Introduce lanphy_modify_page_reg
>   net: phy: micrel: Replace hardcoded pages with defines
>   net: phy: micrel: Add support for lan8842

Argh... by mistake I drop one of the patches. I will need to send a new
version.

> 
>  drivers/net/phy/micrel.c   | 714 +++++++++++++++++++++++++++----------
>  include/linux/micrel_phy.h |   1 +
>  2 files changed, 522 insertions(+), 193 deletions(-)
> 
> -- 
> 2.34.1
> 

pw-bot: cr

-- 
/Horatiu

