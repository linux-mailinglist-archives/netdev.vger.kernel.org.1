Return-Path: <netdev+bounces-238691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 767ECC5DCD4
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76F804FA9E9
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A9227EC7C;
	Fri, 14 Nov 2025 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zhspdquy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BEA265630;
	Fri, 14 Nov 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763131876; cv=none; b=nHUgbxYwC7AHb4k3+r4mETi9vZC92iRI/GV61f5jBATjlHnnGxAuyv/kboWB47KKYakA9B681vrvEj7CI0LjX/0vmewpO6ts3k/IlGg8y7LuC8HVTIh4A3ImZeboO6G1QS9qz4ypufpllsqGrLlMUmIxQwyIYY3TSDlW9TK0MrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763131876; c=relaxed/simple;
	bh=uXUMrsSXarB2KE3DfZvc2dVvlsEVisGLl/QJ+QvdYzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krnKiDFh+Rydn4WxhRZ2VYSDEupJOwKAQzpxmtwDaOtIN/W6V1MrlmsQBAuf+Up8Z9ZTta2pQpHA5+aJRwvwT/tOSXOseehYRMbA06SlOf5qUK/MJTAo6oQUMZPqSZfY8TEDhCILte6ob0EZSv4CXBsCMRcZn4A6YBTur6iQ+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zhspdquy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7X7Y+6mc+I5WyWSGRbj7zlWRyPzScRW03y1O+FyoaE4=; b=zhspdquyWOOPedWfqGzC+WLAxo
	v/IycDE1SEZX3bs1xvgCnmAx8aigaMM649toK7YlHuuG59UQdsO+dV/fCSfYfkVNjLJ1PxFUPv3uU
	KpGYzzs4j992YpylQYFvPqpipJxpXovSwulw93UqoZl5jVczhkVZNqprgMtdjg5NPsMs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJv8g-00DzL7-7N; Fri, 14 Nov 2025 15:51:02 +0100
Date: Fri, 14 Nov 2025 15:51:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/4] net: dsa: microchip: common: Fix checks on
 irq_find_mapping()
Message-ID: <894fe822-ce81-444a-ac26-c4e4ce0e6914@lunn.ch>
References: <20251114-ksz-fix-v3-0-acbb3b9cc32f@bootlin.com>
 <20251114-ksz-fix-v3-1-acbb3b9cc32f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114-ksz-fix-v3-1-acbb3b9cc32f@bootlin.com>

On Fri, Nov 14, 2025 at 08:20:20AM +0100, Bastien Curutchet (Schneider Electric) wrote:
> irq_find_mapping() returns a positive IRQ number or 0 if no IRQ is found
> but it never returns a negative value. However, on each
> irq_find_mapping() call, we verify that the returned value isn't
> negative.
> 
> Fix the irq_find_mapping() checks to enter error paths when 0 is
> returned. Return -EINVAL in such cases.
> 
> Fixes: c9cd961c0d43 ("net: dsa: microchip: lan937x: add interrupt support for port phy link")
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

