Return-Path: <netdev+bounces-97821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B8B8CD5DC
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A4F1C2117C
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623431DDEE;
	Thu, 23 May 2024 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NdMTbwhM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07514BF8F;
	Thu, 23 May 2024 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474757; cv=none; b=JqMg1y02CPmXz05s7Y/EQZodgH8HLJzEx3Fn1x6/AXmsx8DKw5YbZtUkAfTAFeyVnFzzePgGgOJHUlrBZ/2ecByhP6Kze7qBMIzrJHZ+Rt2YOuJT+QxY11WIXBLIWd2+bL6RgzxhsOsCIHh5ZwwMUVkWcQJBYCUOtVyQl515jEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474757; c=relaxed/simple;
	bh=nOBwnAUrG3XTArYtlV00zl2oa7x6KdWXnkghya/eAH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug0LmgICpZR2AkObBjxBbx14N/13zeQUVD7NgOBvpj9/E1nGkDKxBhkneJy5DUjxHySERYqDKPl9vE3XZqKiCL+mvi+r0iUCt2UpboFuhb0ZqTc7tNVOy4kgUMB3QUYvzt8H2esYDX/peATvmfm+MhgPZ1gww6i/03pkalTOScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NdMTbwhM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OyLpAbqIcm49EN50aC4QtDsFYC5RZ7HoWFou/ezE01w=; b=NdMTbwhMtQM5CICpSwky5B6+xe
	Q6oL9/6VkX2WUudrsBMz1qzwMyI8G0btA9E6QpTOvf20Y/xhGRVOO6hJl9E1BU4Ey9nQZEel4e3lM
	l/d3Ov2KO/AWTORCqiWLeSmGqjvbuQLgTkQLtVXKIgNnuAVNJViOms12LLjNQO/uw4yY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sA9UY-00Ftog-T6; Thu, 23 May 2024 16:32:26 +0200
Date: Thu, 23 May 2024 16:32:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: micrel: Fix lan8841_config_intr after getting
 out of sleep mode
Message-ID: <f73778fe-ef01-44b4-9a8d-cd2a978c1a3d@lunn.ch>
References: <20240523074226.3540332-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523074226.3540332-1-horatiu.vultur@microchip.com>

On Thu, May 23, 2024 at 09:42:26AM +0200, Horatiu Vultur wrote:
> When the interrupt is enabled, the function lan8841_config_intr tries to
> clear any pending interrupts by reading the interrupt status, then
> checks the return value for errors and then continue to enable the
> interrupt. It has been seen that once the system gets out of sleep mode,
> the interrupt status has the value 0x400 meaning that the PHY detected
> that the link was in low power. That is correct value but the problem is
> that the check is wrong.  We try to check for errors but we return an
> error also in this case which is not an error. Therefore fix this by
> returning only when there is an error.

Is the second case also broken in the same way?

	} else {
		err = phy_write(phydev, LAN8814_INTC, 0);
		if (err)
			return err;

		err = phy_read(phydev, LAN8814_INTS);
	}

	return err;

e.g. there was an outstanding interrupt as interrupts are
disabled. This will cause the return value of the function to be not
0?

	Andrew

