Return-Path: <netdev+bounces-170377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0962A4862C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D951757D0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2DC1CB9EA;
	Thu, 27 Feb 2025 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nVRA2TBB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9FA1B85DF;
	Thu, 27 Feb 2025 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675524; cv=none; b=aZyX+KFZMh4JzN6XZGgj0jm2mp/lOL3pbTOdycwm8aZszKETrxrMyG1siyqpo6U9+ClZIqcc/5uucZ6dbh6X9cGyh4kzefxRBUhy/94eR9YB4Y2VPv/VSkhtcUshzvDOz7OTWFW0GbjEcotOkSTf1OgAEFeUl9VEm6QsPyXCwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675524; c=relaxed/simple;
	bh=BF0yF8kFMQXT0QxSykYVbynRi7cG6B6AsU7ek43xufU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGGu8efP4HZNLodPRzdecmhWesDTIXUSJUMBIzdQVQCFcp2N0XSyP7LRJK4j9vVO7PPZLxQqo84JHWfqYrmLFvySbwzifhokIIMrI2ShcuQbrFLOC9lxKCumyDSfkkgmxWR6dm2D4Tk7F4mhHNlAdawFAKNNOqUHz8JI175ckxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nVRA2TBB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wyz3yYlSl94ESvxCALw65Qc4qM/IQVRncH1zZdG56AA=; b=nVRA2TBBg8uXm6MrZxO+ZUYaNJ
	E3/vakk4ABu7gPOd09S6CkvK4zFaLECUL1nwOSK5Pwr2f6KqAEW51ueNEOANVLCzSTzme/6X4E1Je
	WbsXf+UbRy2jbF3E5vfs3hVUOs6700oozuLGxCzk6cxLD/5nn45sl9LHjJkKy7FcJsLs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnhDZ-000ezS-IN; Thu, 27 Feb 2025 17:58:37 +0100
Date: Thu, 27 Feb 2025 17:58:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrei Botila <andrei.botila@oss.nxp.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 0/3] net: phy: nxp-c45-tja11xx: add support for TJA1121
 and errata
Message-ID: <c0537f48-ed07-4afd-acf8-4d858ffa72e9@lunn.ch>
References: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>
 <6c37165e-4b8a-41fd-b9c1-9e2b8d39162f@lunn.ch>
 <7f737895-339e-4a0a-abb4-cec8a61ba3b8@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f737895-339e-4a0a-abb4-cec8a61ba3b8@oss.nxp.com>

On Thu, Feb 27, 2025 at 06:33:31PM +0200, Andrei Botila wrote:
> On 2/27/2025 6:11 PM, Andrew Lunn wrote:
> > On Thu, Feb 27, 2025 at 06:00:53PM +0200, Andrei Botila wrote:
> > > This patch series adds support for TJA1121 and two errata for latest
> > > silicon version of TJA1120 and TJA1121.
> > 
> > Should the errata fixes be back ported to stable for the TJA1120? If
> > so, you need to base them on net, and include a Fixes: tag. Adding the
> > new device is however net-next material.
> 
> The errata fixes don't have to be ported to stable.

An explanation why would be nice.

	Andrew

