Return-Path: <netdev+bounces-106242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8D991572B
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 21:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3A6280A60
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEFB19FA6F;
	Mon, 24 Jun 2024 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OqmovMIF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D4F13DDBD;
	Mon, 24 Jun 2024 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257501; cv=none; b=dBQXijrMKRQalZhFqu52UNMHWuR78UmzF+CypRgLyzmC/k6mkJ3Bk9MA1RTxSWv56QUIoo6pWD3YDBzhTeREBOCWdgy/CYWpOZUjXdB/ZgTRZk8Dp6DHhCu7TYfdyRv+jTC2ySO5GwN7Z11CA5orcpnkoAsc6kzvTjytRgd3pdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257501; c=relaxed/simple;
	bh=cXN+GuMgEVN9IcB4PxYeGhIe6K1JFjF9b2Z/ztihZu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQdBkHGeSFw94mbAc6IkmRGyR9pgj/X9y0x2a0eCwXRePJXUFPKNZfckcnNZ6XC06CA5Fevnjlee55ANBXSpE/U58ZigfI7++VQip09Oj4VKT/ePryaWRsPaVliZ+8M786StdqxXCLw4B6N9jZiGb7ET8PIsA3FtxM7bQn6+Jpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OqmovMIF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g/+v11P2r0m2kK4R9zWkvWcc24KCTNtHeFrpNJIg8kk=; b=OqmovMIFeWzFk5ZhlRK4Fx6eJb
	+a8uCF0nYnY/Gyy2HwJyCtl8XQETS/Gv3Q0xGGOxuglHZtdK1KqhPmtnzIamUIOabhHRMkMPwfedR
	pZJnE4OIhGW34+qYlJGF9BbDudLnyxZfpa+ZiiDkQhUYeimFZYzOpMowME2eiKVX9aCw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLpPM-000scx-OH; Mon, 24 Jun 2024 21:31:20 +0200
Date: Mon, 24 Jun 2024 21:31:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, sdf@google.com, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, vladimir.oltean@nxp.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
	richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 5/9] ethtool: Veto some operations during
 firmware flashing process
Message-ID: <ba8a1fac-ad41-4ac3-a3e3-8d177b78355f@lunn.ch>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-6-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624175201.130522-6-danieller@nvidia.com>

On Mon, Jun 24, 2024 at 08:51:55PM +0300, Danielle Ratson wrote:
> Some operations cannot be performed during the firmware flashing
> process.
> 
> For example:
> 
> - Port must be down during the whole flashing process to avoid packet loss
>   while committing reset for example.
> 
> - Writing to EEPROM interrupts the flashing process, so operations like
>   ethtool dump, module reset, get and set power mode should be vetoed.
> 
> - Split port firmware flashing should be vetoed.
> 
> In order to veto those scenarios, add a flag in 'struct net_device' that
> indicates when a firmware flash is taking place on the module and use it
> to prevent interruptions during the process.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

