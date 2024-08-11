Return-Path: <netdev+bounces-117490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE1194E1D5
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 17:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2891C2092B
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10314A60A;
	Sun, 11 Aug 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gK0b4DL9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427313634C;
	Sun, 11 Aug 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723390382; cv=none; b=i+fcOa1GMd/to9ZrgK3hW63PQLYR6On00YbXeuRJ24IHEQVf8degzf0XTzW6wWqt3XCBkWIIaupBuEw33OfJBr0NIaiUz2H4GdQwCoOs2YuNW8TZbDVIF5BAP+019vgfCvFNbZs0OkqQjG1lNeH9i7l3F/jLrsbGfV+GRgMd4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723390382; c=relaxed/simple;
	bh=BgiK4WA8k9hiOIJW6ruJgN3LAj18BVIM9m5SDBB48TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKegx6mtqXhBj4awX7EnHaR2GUz3PsevtfyKNz1zTzlZQc7YcYGv9uab+FzOrs5VLG2l5+0rP3YmBxdb2KkBwY5QarUhzjlxfQbcS4oGGnnsgKTQQxbFjr9T1+czN1I9wmVTamg/r/bcdmD2JZJRfkvvLHNlhzO0su3wML32oxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gK0b4DL9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LjDQFa72z/JTv9jgo1xnkqFqOnuZge/K6x8cYBbqkPA=; b=gK0b4DL9nsCCd+Po83/o2VulCD
	0amGwyEWmnA6Q9BqvbmUINJSWGmP7GAAulJG+lyDSxn3aL7kuCyJPn9VyiA4z67a8TJ4hrErOWEdn
	2hKJ8sFEyKSSsXaCJhiIAbr4zPES9PH86jCQXyKEEvlJt83B2qZb3blSHku7wSyATirY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdAYt-004VME-J2; Sun, 11 Aug 2024 17:32:51 +0200
Date: Sun, 11 Aug 2024 17:32:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: phy: dp83tg720: Add cable testing
 support
Message-ID: <0aaf3031-f63f-4ba1-a017-ee2c7e673abc@lunn.ch>
References: <20240811052005.1013512-1-o.rempel@pengutronix.de>
 <20240811052005.1013512-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811052005.1013512-3-o.rempel@pengutronix.de>

On Sun, Aug 11, 2024 at 07:20:05AM +0200, Oleksij Rempel wrote:
> Introduce cable testing support for the DP83TG720 PHY. This implementation
> is based on the "DP83TG720S-Q1: Configuring for Open Alliance Specification
> Compliance (Rev. B)" application note.
> 
> The feature has been tested with cables of various lengths:
> - No cable: 1m till open reported.
> - 5 meter cable: reported properly.
> - 20 meter cable: reported as 19m.
> - 40 meter cable: reported as cable ok.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

