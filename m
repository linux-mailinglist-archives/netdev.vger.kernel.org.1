Return-Path: <netdev+bounces-144560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0440D9C7C78
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD1B25F10
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E9B205AD7;
	Wed, 13 Nov 2024 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eXkJQaHL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F471885AF;
	Wed, 13 Nov 2024 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527837; cv=none; b=ijTVBvvu3DrQ3z8rCc/KD/CcKmw7UaXbPQt4PaYAjs89HCC5TTEvhMkDWPKNLjTk2ptp23lD7CutiCOSn73VU1UG2CP3vds7HCU40OWTMo6g2zLtythfyIHBNCFoqu+Vpcdc6k/dv+U85uD+rkT6gsaAzy8kwoX5CvrwlFNf9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527837; c=relaxed/simple;
	bh=EFwlFVmCHXk3Sk8HKhzEjXUN4PBq8y4pjhYC3z+PKbQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGfertV75VG4AsLwB0OIU1p5bZc29q4RhVUY483q6xrICkcCxcw1PvgU7/QQUQehYvDPEigPI9YOmH91Fv6eZjy4ZYE1HgSt0cdGM1mWCa7Lb3+pNQdZ8rzT5clXy3hRkLzi+R98zzy4QPzdafRehnYzz7R8p5YTXWfUQnomeiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eXkJQaHL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731527836; x=1763063836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EFwlFVmCHXk3Sk8HKhzEjXUN4PBq8y4pjhYC3z+PKbQ=;
  b=eXkJQaHLpHyH+xZMWGu8blqDmBLLhA8ZdBvoJ5Vb6QsAWtFsDdFZJ2z+
   Y5dToRSZS498PsZG+u0Cu5p25pkQ+MnDMKnRTHkL0noRtJ0YAYpKqkCPP
   G7idsVWtqkbv+ccyBZXF9qvZu+dkMbcojMHCHmYR2kB4XKeHxSV7hdcLn
   qBVHgebLaLgDIgaHuYy9MiWkbjqeLWGm5iQwZMv7bQO4S8UD+TeHdE13/
   IRHPPcZlSaqhxrmqeCKjFioaVfJTIxs2C8y2da6RxOH2BSz+BradgqGoO
   qLB5hKJ1xnumQQRY4ltjnQwHaD7DGh1ejsEoOZ5TWS09ngCGQaExttcOt
   g==;
X-CSE-ConnectionGUID: cmE7gSQUQnivEcTBJSdqxA==
X-CSE-MsgGUID: nSo+YzDOQ1iUvIzWAbNrOQ==
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="34277142"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2024 12:57:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Nov 2024 12:56:17 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 13 Nov 2024 12:56:15 -0700
Date: Wed, 13 Nov 2024 19:56:15 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Arnd Bergmann <arnd@arndb.de>,
	"Jens Emil Schulz =?utf-8?Q?=C3=98stergaard?="
	<jensemil.schulzostergaard@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: sparx5: add missing lan969x Kconfig
 dependency
Message-ID: <20241113195615.wotnc6jbkbckiwsj@DEN-DL-M70577>
References: <20241113115513.4132548-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241113115513.4132548-1-arnd@kernel.org>

Hi Arnd,

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sparx5 switchdev driver can be built either with or without support
> for the Lan969x switch. However, it cannot be built-in when the lan969x
> driver is a loadable module because of a link-time dependency:
> 
> arm-linux-gnueabi-ld: drivers/net/ethernet/microchip/sparx5/sparx5_main.o:(.rodata+0xd44): undefined reference to `lan969x_desc'
> 
> Add a Kconfig dependency to reflect this in Kconfig, allowing all
> the valid configurations but forcing sparx5 to be a loadable module
> as well if lan969x is.

Checked the different configurations and the change fixed it. Thanks!

> 
> Fixes: 98a01119608d ("net: sparx5: add compatible string for lan969x")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Side note: given that lan969x is always built as part of sparx5,
> wouldn't it make more sense to move all of it into the sparx5
> subdirectory?
> ---

IDK .. I think I prefer it *not* being hidden under the sparx5 dir. If
we have any guidelines for this, I will gladly comply. :-)

/Daniel

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>


