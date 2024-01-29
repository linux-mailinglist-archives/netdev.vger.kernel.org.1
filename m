Return-Path: <netdev+bounces-66552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7983483FB27
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 01:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE365B20BA9
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 00:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86EE19C;
	Mon, 29 Jan 2024 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4QrfRt0h"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8DA396
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 00:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706487135; cv=none; b=sqTv3EUQ8V9Dm6QdKJxcHBLwBndHbc2NzRWuLOtC46QIOg20U8Gm18Y5RDKRmDKiJ8N4U2o7Li9pCRmnvmqPc5I1VmNGjYMgzDayCj2QQcKD0LDkCWzu3j5yWUXHU3hHz3zwmLPBu9imDJr/nyJvTbF9SppacaLwUF94xBfphjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706487135; c=relaxed/simple;
	bh=eF/1+i3z3BkWagJbY4XVkTHaqgVjXTePujiaSdWC09A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jg5LLGvDkMRPlLcllD8uJ80XwVj1foYodJcbrNQcVXlILW1gZcuIxI3nuJUlvXjukh2wDkHdMI2J0ax7ey+Xq6jUZ470HZnKNtvoqhA9kqGN/OdcFJGcmi7WCx5Fw5XiV3MsSBQjwl/OPA7A3ZwKbmHegJvJKSLBtOU9fBMxSnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4QrfRt0h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ieG6s4MTrlugvbTH6C4wBVU2c6BAA1II0bhMC/aCQZ4=; b=4QrfRt0hWbHcSmSAMgjVpvKnz3
	JTyoSA4K6kR+SwGPDZ1WixlA5/HJvkB/VxGbhMlvTT/E+fFT8PWsyvvujnaBpQSDy8ehUR9M2Cmgo
	kHi8Dcy6t+pUe1n0eixqXqYO1e5f5Q9kknyNy0hB3ux4ysvJXdpAR1vMkveJxyI6wmoE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUFFu-006KqE-Ty; Mon, 29 Jan 2024 01:12:06 +0100
Date: Mon, 29 Jan 2024 01:12:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 5/6] ethtool: add linkmode bitmap support to
 struct ethtool_keee
Message-ID: <52717a24-b6d4-471e-98db-db63bc975b56@lunn.ch>
References: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>
 <9995ba73-2a37-45e6-ae3d-2c43cf1ba909@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9995ba73-2a37-45e6-ae3d-2c43cf1ba909@gmail.com>

On Sat, Jan 27, 2024 at 02:29:33PM +0100, Heiner Kallweit wrote:
> Add linkmode bitmap members to struct ethtool_keee, but keep the legacy
> u32 bitmaps for compatibility with existing drivers.
> Use linkmode "supported" not being empty as indicator that a user wants
> to use the linkmode bitmap members instead of the legacy bitmaps.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

