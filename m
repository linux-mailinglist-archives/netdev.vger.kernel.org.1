Return-Path: <netdev+bounces-111991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 904389346C3
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 05:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01DE282588
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 03:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198763611E;
	Thu, 18 Jul 2024 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rMxsgPFq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587281B86CE;
	Thu, 18 Jul 2024 03:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721273629; cv=none; b=CF+bYwFbHaZk8REs1Y1POxKRzTITS20scbdflfUtLuqm9Zz0yL6BsHfUtCYoKqm5/X1vrgKAieLiA43cQye/tYWtD9q8YDd8UslPre1TevLrtcwLKnTGDJ+pNnp3YYw3bbXd1hl4/zjn3+3H2N6345gTjOpQLEtUKoeORJ++6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721273629; c=relaxed/simple;
	bh=lUccWAKrS0z2vZkPel2uSe2kUAeaIFsraO45VVpjJjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUmTY0IuqcyDijX4wuBPOtQkQ5mSw6KD0RGMGLjyTt4ubLByw3Ay5SjeCOrl/B4uXYwqWk0Zraky2P4xcvZcCKgYFgR0/oduNMTcsgSV2fPjieudgo0ogAujUL0dGElaPqGfOPytwWR0Rqjayc4lkv6bt+uIyThOSqQ9F6KlEvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rMxsgPFq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SbxIg29mlP0SoQkD+qF3vxVxlSVquA5slH6jrg92+GQ=; b=rMxsgPFq4XpChbK56selyqs5FG
	Ia0rp/40X0LzvQFDOF7Vw7SlQtzt++ayGcVppcR2Cz4djO1852UED7JEvWPMYhd0ZBJeZr5Dxq1IV
	BApMx0u5G0GzjGTUSz/c8gE78TISzhrZdTuKN2m2PviH6vB0Nyy7jEflnefVR+UbECbc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUHth-002koq-Ed; Thu, 18 Jul 2024 05:33:37 +0200
Date: Thu, 18 Jul 2024 05:33:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	horms@kernel.org, hkallweit1@gmail.com, richardcochran@gmail.com,
	rdunlap@infradead.org, linux@armlinux.org.uk,
	bryan.whitehead@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V2 2/4] net: lan743x: Create separate Link Speed
 Duplex state function
Message-ID: <57198c26-7585-4829-b267-059d0e7e548c@lunn.ch>
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
 <20240716113349.25527-3-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716113349.25527-3-Raju.Lakkaraju@microchip.com>

On Tue, Jul 16, 2024 at 05:03:47PM +0530, Raju Lakkaraju wrote:
> Create separate Link Speed Duplex (LSD) update state function from
> lan743x_sgmii_config () to use as subroutine.
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

