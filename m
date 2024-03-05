Return-Path: <netdev+bounces-77518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923F5872115
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F741C23A27
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 14:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5574186136;
	Tue,  5 Mar 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UIiwG8bQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE755676A;
	Tue,  5 Mar 2024 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647600; cv=none; b=BKxpq3H963dGSE0fGv91gRwdLmkZgTzvsk/pcAUKYCfQLqsrHZ1NcsafCe/oTlV8+YyBoakNFyuu8yRGIr3OoIJs97f06BjVo4Sdw3dr/uKFgMksTw4qq5TO8mHfEjo82Uw+r30PkNNFEwh+Ob7DynT2Jb9BqCiaqgmrmfZSFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647600; c=relaxed/simple;
	bh=7H/QMVJAMs22OFoLiLJxD3m6yFKSjngI5luiQ5wmtCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhHDJGwAfDNyHnMUj+wEAqob13/yvQry1nFFFU9Oa7yNGMRPfi2D3w+6jYVEcBKEtoIurdonDz7uoZpQKNKXRWg6xJk20MwVgPCHN8bvwFQGMqxjleLpzD7fURoIYLAMMveVBtf/cLUH5OVIbI4dGkHLWwV6dKkc9BQTQKaeAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UIiwG8bQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rIHY8lWDn0Y1OkbNPR2Sq/7/+Wp4F1th/YJzLxnMyDQ=; b=UIiwG8bQN97n2x0UfDhnK7iMq5
	Bcxy95SU1MKxOUnGPUMgHvAh6G3Yz3/WoJNUiS3BI1wNBaQ1ZJ/X9YjvPDqVJt4mwoT04wSYQoS/A
	Fb8YVaTt5ATbaGlvCLayl7hiHfxOOEb4Ib28nfZbbb5T7deDRZFdi9BhNS+JgK18P6yI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhVRN-009QiR-1F; Tue, 05 Mar 2024 15:06:45 +0100
Date: Tue, 5 Mar 2024 15:06:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <0184291e-a3c7-4e54-8c75-5b8654d582b4@lunn.ch>
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <e056b4ac-fffb-41d9-a357-898e35e6d451@lunn.ch>
 <aeb9f17c-ea94-4362-aeda-7d94c5845462@gmail.com>
 <Zebf5UvqWjVyunFU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zebf5UvqWjVyunFU@shell.armlinux.org.uk>

> The only way I can see around this problem would be to look up the
> PHY in order to get a pointer to the struct phy_device in the network
> device's probe function, and attach the PHY there _before_ you register
> the network device. You can then return EPROBE_DEFER and, because you
> are returning it in a .probe function, the probe will be retried once
> other probes in the system (such as your PHY driver) have finished.
> This also means that userspace doesn't see the appearance of the
> non-functional network device until it's ready, and thus can use
> normal hotplug mechanisms to notice the network device.

What i'm thinking is we add another op to phy_driver dedicated to
firmware download. We let probe run as is, so the PHY is registered
and available. But if the firmware op is set, we start a thread and
call the op in it. Once the op exits, we signal a completion event.
phy_attach_direct() would then wait on the completion.

This is however taking us further and further away from the standard
device model.

       Andrew


