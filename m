Return-Path: <netdev+bounces-142633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 705FF9BFCD8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B9C28308A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154E3126C01;
	Thu,  7 Nov 2024 03:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sda5JzmJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F716426;
	Thu,  7 Nov 2024 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730948752; cv=none; b=NlXpmISUCPBXc+46Rf36tFbG/QNwJ1En8xKGJWdtKDjh5ABkIqpfFjTES1ETxJrNYto+pyqyNTHFoEccXxV1ULizJ/muja6Np3hz+X+XLg2MC7Xpg4hdKHkSfGH68l+NeGfjqm09jRk18w3qhYhFudwpYUQkGO5fmYXH4Ij956M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730948752; c=relaxed/simple;
	bh=OyUMfxzH/7xrgBjkTv81YqCVk1peQgGjZexhB3H4hMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+SdGez9BWJmY0ibU06ZDgT8aDMQFcY7KTyMm2Fa+/QFIms9eLQNXM4gILZzXmfiEK8j+yzQGz0eX2BH87bzC1vSd5FBset4G8i4awnxBwR4wVuKDCW4MDF0tkJTMFAUz13f2z1DW8RGR0a0rU+T5+2RZKjQUHGAMU+SD8+Z9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sda5JzmJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zuDVS7tTEPiB0mX4AR66/8AIdmOOIQoXj0nyArqjxtE=; b=sda5JzmJMjsaV2nYK5blvSAOkt
	bmuYbKex3IUR2icb6bY6oeISnUWbqbZW3w4YBUtgTIbE7Dahw26l26YRJa5O7K9T5q390WUl+09GM
	1ZRX3ViK/WhDi8eCvlLfwz/dZEM++v6hL36ajzv8eUODVUlPUGKxWeyQ4Zu0HFyL1DXg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8sq2-00CPks-PM; Thu, 07 Nov 2024 04:05:38 +0100
Date: Thu, 7 Nov 2024 04:05:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Yan <andyshrk@163.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.wu@rock-chips.com,
	Johan Jonker <jbx6244@gmail.com>,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2 2/2] net: arc: rockchip: fix emac mdio node support
Message-ID: <d28eee82-7fb4-4dda-9d23-53434c76de17@lunn.ch>
References: <20241104130147.440125-1-andyshrk@163.com>
 <20241104130147.440125-3-andyshrk@163.com>
 <20241106175002.645e2421@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106175002.645e2421@kernel.org>

On Wed, Nov 06, 2024 at 05:50:02PM -0800, Jakub Kicinski wrote:
> On Mon,  4 Nov 2024 21:01:39 +0800 Andy Yan wrote:
> > From: Johan Jonker <jbx6244@gmail.com>
> > 
> > The binding emac_rockchip.txt is converted to YAML.
> > Changed against the original binding is an added MDIO subnode.
> > This make the driver failed to find the PHY, and given the 'mdio
> > has invalid PHY address' it is probably looking in the wrong node.
> > Fix emac_mdio.c so that it can handle both old and new
> > device trees.
> 
> Andrew, looks good?

The MDIO patch looks correct. I cannot say anything about the DMA
mapping.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

