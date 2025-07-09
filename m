Return-Path: <netdev+bounces-205433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A27AFEA82
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319EE7B33EB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0574B2DFA39;
	Wed,  9 Jul 2025 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nNEayvjk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF62D8796;
	Wed,  9 Jul 2025 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068508; cv=none; b=lyX6Ep2+a7T0C1SO3YS/K8rUju0FLlgwk11DA+yXmZHqx5ZRkyIFe6wjGupGyXbMleLSPHKv6RLU29zUYT/9Rvzp489FUrImOC5S6Egy4fPTsD4EJ+0jUlREtXHMUErLzcc45BwCShWPWoEhifNPcOiuO7FvBVDM88rC7Yi0ZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068508; c=relaxed/simple;
	bh=cUrb/5tT90HZgh3rQw56uSBbFePvBfpGChmchBy2EjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu91EtAO3XXzdEl0YQBqKcddX7R27Azaxxi9fjn00pwSK7cxQVIvLA/1+mAJRDXAb2dMnfDvtj3u8JvmqQ8fFRrRwGFEmX+y58SxS3/4nFa2ex1W9oT61rfi4TBh9h8HX07F3Tfv5FXuQ5u1txRBsXQ1Mx/hI4fN2lPZk8Dxoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nNEayvjk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/BVJFrikPGcxN1jcoZfth0eb+cm23YLbPpSBghN9ybI=; b=nN
	EayvjkdK6jHsGqyp6Vn19qW8nAe+fZX7TM42NZnB9xek9pPUO+rEY23y4oE3Gt4aoslFKXktCxsLg
	CcinENKGTmvST71qVxOXdRKuvo89p0O+SqAViW+j5wX6HFHcAMB7JloF9CPmuckPg179aP1sQjt0x
	BtUhU24JP6WtcdM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZV3R-000wkI-Ef; Wed, 09 Jul 2025 15:41:45 +0200
Date: Wed, 9 Jul 2025 15:41:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 3/3] net: mdio: reset PHY before attempting to access
 registers in fwnode_mdiobus_register_phy
Message-ID: <0d0d7e6f-3376-4939-a3f7-8cf5f52e4749@lunn.ch>
References: <20250709133222.48802-1-buday.csaba@prolan.hu>
 <20250709133222.48802-4-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709133222.48802-4-buday.csaba@prolan.hu>

On Wed, Jul 09, 2025 at 03:32:22PM +0200, Buday Csaba wrote:
> Some PHYs (e.g. LAN8710A) require a reset after power-on,even for
> MDIO register access.
> The current implementation of fwnode_mdiobus_register_phy() and
> get_phy_device() attempt to read the id registers without ensuring
> that the PHY had a reset before, which can fail on these devices.
> 
> This patch addresses that shortcoming, by always resetting the PHY
> (when such property is given in the device tree). To keep the code
> impact minimal, a change was also needed in phy_device_remove() to
> prevent asserting the reset on device removal.
> 
> According to the documentation of phy_device_remove(), it should
> reverse the effect of phy_device_register(). Since the reset GPIO
> is in undefined state before that, it should be acceptable to leave
> it unchanged during removal.
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> Cc: Csókás Bence <csokas.bence@prolan.hu>

This appears to be a respost of the previous patch.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html says:

don’t repost your patches within one 24h period

    Andrew

---
pw-bot: cr

