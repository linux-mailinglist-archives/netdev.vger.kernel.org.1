Return-Path: <netdev+bounces-192659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160A6AC0BA1
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E79A1B65AE1
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41D928A41F;
	Thu, 22 May 2025 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cKRC3kO3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A32381BA;
	Thu, 22 May 2025 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917224; cv=none; b=ZQJv3rD0PK22yq1bNlw8xdlpjeo4G/1jUJtTECXbjHFmktL85J/7rkRoVaA0ckjDQpJ3GK9dZDelz4roD2P8u5uwoHROyOn6FSu9wExX8r0VqzXeg51toqtqxPQAATetZS/3CqV7dI9BWWeFSu7W4Th4u2KwMgNH2jdbgPhu83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917224; c=relaxed/simple;
	bh=uP61MchQPewY0Ob/xBfWVgKe5JiKOcl72p3w7LJxVss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghEtXVxA6XvpU+HR476fpuHc66Fz4EoZeK5mMe30LeLzWoNpDa0pTFZHf+Vi6+RoF8299AZD2uO+JP5QQ9fGtba5wzJ3NtrSMIHTxMdv8FUgv2z4mKzC/IalLnFDyZZ1FtjkbBkmzSgDoNC/NQKosCX8jN9+PfUNjk2+6fiqDC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cKRC3kO3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QRm0+jOKmPeRh8S3vbmBsdZ3er87cYnpMRW/rqcs0pU=; b=cKRC3kO32MHq23ZPOKvEXwFAdy
	EkGIQlvit4BnfwInI4cbw5e/giWtfQLNvpQdjSCebnzbrmxreBEm6X6RfvxrD/ntJHSqMZI9oQrnF
	KVtZXg+45wDAaqgReogAtn0MKXEhOfyw7B5FiYIxYymSTcu76eTgJ5D2mlqKUjVfDc7k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uI576-00DUdV-AG; Thu, 22 May 2025 14:33:32 +0200
Date: Thu, 22 May 2025 14:33:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	f.fainelli@gmail.com, xiaolei.wang@windriver.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net] net: phy: clear phydev->devlink when the link is
 deleted
Message-ID: <f19659d4-444c-4f44-9bff-4c83a8c5a7e9@lunn.ch>
References: <20250522064253.3653521-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522064253.3653521-1-wei.fang@nxp.com>

On Thu, May 22, 2025 at 02:42:53PM +0800, Wei Fang wrote:
> The phydev->devlink is not cleared when the link is deleted, so calling
> phy_detach() again will cause a crash.

I would say crashing is correct. You have done something you should
not do, and the crash helped you find it. phy_attach() and
phy_detach() should always be in pairs.

    Andrew

---
pw-bot: cr

