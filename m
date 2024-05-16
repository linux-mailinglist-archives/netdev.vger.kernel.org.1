Return-Path: <netdev+bounces-96773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18118C7AF5
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 19:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32011C20C04
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFC1154BF0;
	Thu, 16 May 2024 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xzDhDO0z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0A1429E;
	Thu, 16 May 2024 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879818; cv=none; b=aoGNOkhJgX5WCr4DTh90XET9VAHLtscP/GsQrnUXg7y2N0CZKOmbIgasoAJZdrwf03dnA3dN5nPdXgmCOIG/0AkZXRP+jA9Mxrca9VV380hvP+vs4k1z/znd79tbXgTHHkiAaHPuJr2biC5EQ8MwVck+Cf5HRVnsCYAonmPt02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879818; c=relaxed/simple;
	bh=ggWmeHnyrvQuqQvGyWMWOlym1DXS5hCVdvJpfdraodk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBXxbNyaJr86tRhq/ZXLkKyJrR51fvJcbpVGq8Js7IZCFVoRiXiPGbs1zjTJJcqsZXOHxuZBII3bpZQMmz8SUl4wtZ1cs8Q/zK9adE4IlMYZzAcnG9QfNieGmReXF3IbdShiAcKhz7JYVBI9d/8w1wel5B/zs+RkyI0wYcutBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xzDhDO0z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L3wGeenFMy7/WOW4QFAgkiw9kjyavP6D58uibLg+zeQ=; b=xzDhDO0zy8jM8TbZ/zEH94TD45
	O2iu36ZSzdCma/wwtnxy6P0+0gktQUwCUkhd67e4NcERMUg1dxU96geVKOcCl4cEfgiyxrG5JHUFx
	ZA9TKMI/wlxXqd2FXq9ebpRVkMs+6mXiT4qtuf2T0LuqhDh8zMcWTExPzW66f/0s2HyE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7eiR-00FWcm-Rw; Thu, 16 May 2024 19:16:27 +0200
Date: Thu, 16 May 2024 19:16:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: arnd@arndb.de, davem@davemloft.net, edumazet@google.com,
	glaubitz@physik.fu-berlin.de, kuba@kernel.org,
	linux-kernel@vger.kernel.org, lkp@intel.com, netdev@vger.kernel.org,
	nico@fluxnic.net, pabeni@redhat.com
Subject: Re: [PATCH v2] net: smc91x: Fix pointer types
Message-ID: <0efd687d-3df5-49dd-b01c-d5bd977ae12e@lunn.ch>
References: <AEF82223-BB2B-4AF0-9732-0F2F605AAEC2@toblux.com>
 <20240516155610.191612-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516155610.191612-3-thorsten.blum@toblux.com>

On Thu, May 16, 2024 at 05:56:12PM +0200, Thorsten Blum wrote:
> Use void __iomem pointers as parameters for mcf_insw() and mcf_outsw()
> to align with the parameter types of readw() and writew().
> 
> Use lp->base instead of ioaddr when calling SMC_outsw(), SMC_outsb(),
> SMC_insw(), and SMC_insb() to retain its type across macro boundaries
> and to fix the following warnings reported by kernel test robot:
> 
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    got void [noderef] __iomem *
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405160853.3qyaSj8w-lkp@intel.com/
> Acked-by: Nicolas Pitre <nico@fluxnic.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

You could add a follow up patch which removes the 
void __iomem *__ioaddr = ioaddr; lines and uses lp->base.
The code will then be more uniform.

	Andrew

