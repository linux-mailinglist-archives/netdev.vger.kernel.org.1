Return-Path: <netdev+bounces-106237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC419156DC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 21:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF90B2162C
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8958F13D88B;
	Mon, 24 Jun 2024 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JqanSzro"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B81BC20;
	Mon, 24 Jun 2024 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255706; cv=none; b=LGpyLNcB+G0RGZZI35dUT9gcudGTXAmNt53O2Vy0MChDzuRw20npYKSMpliE7mcEFzCEO1HCbfNTBSXq+ATcMX6M7L1ynT5A7S2BlIVLM6ku1WftC95uvjk+3iEfikQ0QbKyznw2OVYu+UN/zuecJFcn+hNWKeRC5VUiFXnVq9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255706; c=relaxed/simple;
	bh=IQWtDWCMaWqSjO7r4S7l2Lxf5FceukKg3kRt8F3Gaqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKuquJL85Wgu0AAA2dvkqqKE3gtKzoUkm7hcxS4EzLSvXW+oFb0cAaItxhDYx9kdMSvLPpTWBYLZmTDllPTWRaK/eOsb4GDkJOVGyRiNZ9LYwupoYUanyPWwxOEWAYMZqZixXFDRLSwMaPLE+FD6dNPMvM2zd4ut6c0n/Ybv8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JqanSzro; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=257OuToRflip8sKgZdrDGkBmy/UzRxRjyf8IKZ4NPpY=; b=JqanSzroY5U2O60UJGP2lNUmoV
	BmQL2u7nVuOFaFZB15iy0xPoRrV4+TgEEe/mckaq0N2xI/q72+XC+rv5aI/bh7opTAo8/q+ATz6rI
	uFIKbQXlq+LxDM7CwPyZTGMKwoI1HF2vZVtBSi+B9ksGGazoMx9QI7TTls4y96dqJLOk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLowM-000sTO-Qn; Mon, 24 Jun 2024 21:01:22 +0200
Date: Mon, 24 Jun 2024 21:01:22 +0200
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
Subject: Re: [PATCH net-next v7 1/9] ethtool: Add ethtool operation to write
 to a transceiver module EEPROM
Message-ID: <d02e3393-bd0f-419c-83be-f98a4e794b59@lunn.ch>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-2-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624175201.130522-2-danieller@nvidia.com>

On Mon, Jun 24, 2024 at 08:51:51PM +0300, Danielle Ratson wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Ethtool can already retrieve information from a transceiver module
> EEPROM by invoking the ethtool_ops::get_module_eeprom_by_page operation.
> Add a corresponding operation that allows ethtool to write to a
> transceiver module EEPROM.
> 
> The new write operation is purely an in-kernel API and is not exposed to
> user space.
> 
> The purpose of this operation is not to enable arbitrary read / write
> access, but to allow the kernel to write to specific addresses as part
> of transceiver module firmware flashing. In the future, more
> functionality can be implemented on top of these read / write
> operations.
> 
> Adjust the comments of the 'ethtool_module_eeprom' structure as it is
> no longer used only for read access.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

