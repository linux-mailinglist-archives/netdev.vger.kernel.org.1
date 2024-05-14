Return-Path: <netdev+bounces-96357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C168C566D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AB41F22C5F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94F26D1D7;
	Tue, 14 May 2024 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QnwoHlLj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C46CDC0;
	Tue, 14 May 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691386; cv=none; b=mfJ5+c93rFJP8beumyuHqigbHGlFEI9ixpc6QOZTdKBosdClLSczpWMOc1JKcWZVc0n3OEa9dyHHKcAKCNZcoAj74rcJu8/b6n7Kre++ZdwYogZXXnrusoGFacIYLivagCRLfKZt9kPwFn0m/ggyuCLa8a+3lCQvnYLJCEB7rew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691386; c=relaxed/simple;
	bh=HAxSR/4xgfFZEgqmz4A4R4Xt2tlSyYyyjFhU6JoKErk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv6ccwTrMzXH3hqxXS40P1/oz3xPFbndFSBINAOIqroXHQTcX5dFbZ2YhOXZr2Z/fLXdiQHhLjgXVtbSNotF/y4159vXWHZddysTR7dh6V/JrUfBf4V52RFIWhxIBXoBzVi3R/L/0EV4ASMwiYPUMGZlxZTHP0fnghcoOe2Snpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QnwoHlLj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iuh+sM1RhuG5a5VhdEyIfFjcwRIdbj2qhxsxFsT5mnU=; b=QnwoHlLj8uidUvP3RLH4tvSOUW
	0HV7dpGgas2oQ3GEZ4ZEyWHTLTM/xcIQVzIw1NwygLTcNj/Fh8vOPgnKIsRMd1FLfAh1f29cBPgF+
	S1IhLvFKgzXqKwnJpli6ZD7hzrWT3ZlIvb/sOugP8cO+MHSlh/t05UDC6OXGB3XARVxA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6rhY-00FO7z-Ex; Tue, 14 May 2024 14:56:16 +0200
Date: Tue, 14 May 2024 14:56:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	MD Danish Anwar <danishanwar@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: Re: [PATCH 2/2] net: phy: dp83869: Fix RGMII-SGMII and 1000BASE-X
Message-ID: <38bc6947-391b-478d-ab71-6cc8d9428275@lunn.ch>
References: <20240514122728.1490156-1-thomas.gessler@brueckmann-gmbh.de>
 <20240514122728.1490156-2-thomas.gessler@brueckmann-gmbh.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514122728.1490156-2-thomas.gessler@brueckmann-gmbh.de>

On Tue, May 14, 2024 at 02:27:28PM +0200, Thomas Gessler wrote:
> The PHY supports multiple modes of which not all are properly
> implemented by the driver. In the case of the RGMII-to-SGMII and
> 1000BASE-X modes, this was primarily due to the use of non-standard
> registers for auto-negotiation settings and link status. This patch adds
> device-specific get_features(), config_aneg(), aneg_done(), and
> read_status() functions for these modes. They are based on the genphy_*
> versions with the correct registers and fall back to the genphy_*
> versions for other modes.
> 
> The RGMII-to-SGMII mode is special, because the chip does not really act
> as a PHY in this mode but rather as a bridge.

It is known as a media converter. You see them used between an RGMII
port and an SFP cage. Is that your use case?

It requires a connected
> SGMII PHY and gets the negotiated speed and duplex from it through SGMII
> auto-negotiation. To use the DP83869 as a virtual PHY, we assume that
> the connected SGMII PHY supports 10/100/1000M half/full duplex and
> therefore support and always advertise those settings.

Not all copper SFP modules support auto-neg. This is all really messy
because there is no standardisation. Also 1000BaseT_Half is often not
supported.

	Andrew

