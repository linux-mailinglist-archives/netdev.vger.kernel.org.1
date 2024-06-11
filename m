Return-Path: <netdev+bounces-102637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DA7904096
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CAF1C21EC6
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24845383B2;
	Tue, 11 Jun 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p8+9jCWL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0E1EB31;
	Tue, 11 Jun 2024 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121323; cv=none; b=p4fZBQhu4AGG4AsNjnU65gkskb9+ngRhftsfmhXuqbfW+//vIbG59mJfQc2KhO2/3lJckYUjvkvI0CspzoTBhF6DjLZIAvX8mXnqtAqkzgkny544OL7iY+5/S8BQIslyp/V9+VQ3mnndiPcKxVZDW+bmPp1Lsyk0e7yx3Dojfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121323; c=relaxed/simple;
	bh=xDDj3IA8z91sfAPS3SuuNuK4ZRTdYmydM2gvEY9GTh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0uxQvV875djFqu9tDP4B36zvJBaDEdgfOELPczP32CkOLbg/KIJxzBHa1fl9wCNcblJyPXF/uz7S7LP7aou17NTtGjOVq4fzA5X54U5iY+VOmlPZcLIO5r13xyHMs0YSYYSq4p1Pl0wvjZR74f2E8ZEREKZj4HhAHKPcz+gQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p8+9jCWL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gTBCsfT/FoEZjfkp+/88uvPEW9jcevZaStmZIljnz28=; b=p8+9jCWLUAlDHl8wNaDONdQrIm
	q6q8bfJKklSncqLW2rB9ZyY1x+WqjIyWjNu0aQh4GhJgCWe2EhoD1tHb+qBjad44aYQ958Jh4fPAp
	cBLKyhlz6aAomd82N9LxZrtuHNDeLYVJHtWeurVziwr+bVgZrxa8R0UI9Pjh3lzA1hV4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sH3q4-00HOxJ-6R; Tue, 11 Jun 2024 17:55:12 +0200
Date: Tue, 11 Jun 2024 17:55:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Michal Simek <michal.simek@amd.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2] net: xilinx: axienet: Use NL_SET_ERR_MSG
 instead of netdev_err
Message-ID: <49b57b18-c7ba-4059-ab1d-b337017ea8e4@lunn.ch>
References: <20240611154116.2643662-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611154116.2643662-1-sean.anderson@linux.dev>

On Tue, Jun 11, 2024 at 11:41:16AM -0400, Sean Anderson wrote:
> This error message can be triggered by userspace. Use NL_SET_ERR_MSG so
> the message is returned to the user and to avoid polluting the kernel
> logs. Additionally, change the return value from EFAULT to EBUSY to
> better reflect the error (which has nothing to do with addressing).
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

