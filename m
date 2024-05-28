Return-Path: <netdev+bounces-98522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7908D1A98
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDC91C22956
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA95B16D4D8;
	Tue, 28 May 2024 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="29Tuelrc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375AB13BAC4;
	Tue, 28 May 2024 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897863; cv=none; b=WlabJejDDlcVkROkdEK62vlTwM+E8p5lofbV+228ji5ltXF7sZgTF6XGna5zKVxdWtJpGKrjsmGBEKhgluKHJ70nPncgK7HfQCMPYTiOsAeYs35GmhmuZwPpdyYo3/QKV54u24EzhZwmvvxyRAqYVGfqlpSu8O2M10H1p/YvCGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897863; c=relaxed/simple;
	bh=u7mN/Z8mmXxjzvb1rnaJtWovjfyx3RfUtm/sBSv+TEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSmlAZ4QLKZg7JP9eWelzuqzbUdJDu+KZjSptTYdBlu/sWubR2yUZoPIPv1aU/0iZHsGTEq0DjQ0+br3+ZD4YIjRHmNq+ABHSGZ9ajuNdLzyuKVY4SPh/UFpCcrP4S1WE7+hjtJ4ej7dlIre6wb5o0wdhzSnGbum2qkTZtc6cmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=29Tuelrc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cgMnIYvxLbguq2TR4pjQwvelgSrvNm0jTjimH/62tvk=; b=29TuelrcodVZblvu/O4JbP7QXJ
	5rO/KStxOLbIZ1GooKNqDdVYftkYRgU7Dih+FS7yLcZ+VNVgKRIP9szg8nWGJqo+QT8KN3w+dxvNA
	uTfNQYDc3ZTHmKZUDHBnWaYdVphLwpoIwlJFZbyFEwZHpYW9zYxwfaqOr/M/w32qv3yw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBvYU-00G9HX-F4; Tue, 28 May 2024 14:03:50 +0200
Date: Tue, 28 May 2024 14:03:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>, Diogo Ivo <diogo.ivo@siemens.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v6 1/3] net: ti: icssg-prueth: Add helper
 functions to configure FDB
Message-ID: <d10793e9-75f0-418f-92d5-2109286b07e6@lunn.ch>
References: <20240528113734.379422-1-danishanwar@ti.com>
 <20240528113734.379422-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528113734.379422-2-danishanwar@ti.com>

On Tue, May 28, 2024 at 05:07:32PM +0530, MD Danish Anwar wrote:
> Introduce helper functions to configure firmware FDB tables, VLAN tables
> and Port VLAN ID settings to aid adding Switch mode support.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

