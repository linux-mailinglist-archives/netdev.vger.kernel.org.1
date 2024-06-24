Return-Path: <netdev+bounces-106238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0CC9156EF
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 21:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2281C230F9
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B5519DF80;
	Mon, 24 Jun 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AcvmvniS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD4107A0;
	Mon, 24 Jun 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719256160; cv=none; b=jFzgbwmSCBtimDoXEfcirjfCQWFP0dktRbMmIdpnCHPYEjDGur+1MbmDg/EjZOn1sMToYXtYiLZXQ+XSmq+QUAMvz3ANJr711++bUF7n5+OXSQdqb+dp3H6zyCVrxLyaUiE2F7RzqwoD8o8FZHDppf7LX2SM7YWh/0jc+DhSkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719256160; c=relaxed/simple;
	bh=RHmeLpdkT3bCwHx017JxwaBkmSWFMJo/nKxozA4MNic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAAiZImgO6jh3OevzqNBAiTGuPcJzkBdwLeQW8DwYoYT9AzbH4AfdxUjJ/uyl9FP9bR19fcdU9MglnHcs+K4RmoEro66omfxLLDeE9owLcv/X84o+vUcpsrUW8i68PqnCyjvomQ6yhRiAv4vegrUFDM/CHYlinfWZu/K79PYtNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AcvmvniS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Lkmr7/aSeqTjcSX6Kf2zcrLRYl7jDTF7KgIGMoYK4gI=; b=AcvmvniSFj0aOeDhtVQTTlyN2D
	l6usijwm+2M89Dh4RBRxoiT9bx2+bAF/iywcDBcAXtQUeeUniFNx/k4w8lFxsZW/wZMlLiPED28P4
	QQ+ybr9kGC6F1lfNAFP8OV66IPU7IgTI4wHQc7x/mENAi4ZJefU/TrYHrjCCsnExjCpg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLp3n-000sUy-Ky; Mon, 24 Jun 2024 21:09:03 +0200
Date: Mon, 24 Jun 2024 21:09:03 +0200
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
Subject: Re: [PATCH net-next v7 2/9] mlxsw: Implement ethtool operation to
 write to a transceiver module EEPROM
Message-ID: <89c631e7-8664-4377-b38c-d371409b71b4@lunn.ch>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-3-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624175201.130522-3-danieller@nvidia.com>

On Mon, Jun 24, 2024 at 08:51:52PM +0300, Danielle Ratson wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Implement the ethtool_ops::set_module_eeprom_by_page operation to allow
> ethtool to write to a transceiver module EEPROM, in a similar fashion to
> the ethtool_ops::get_module_eeprom_by_page operation.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

