Return-Path: <netdev+bounces-234694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0338CC2614D
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F981B25CEC
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1EF2EE611;
	Fri, 31 Oct 2025 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bjFKHRNP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAF2EDD72;
	Fri, 31 Oct 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926959; cv=none; b=qUgaF6ynB8LRl9bFwwQ6H4qAPX3HW6Z7oH90MOf15iAW1wGQ8ZMdI2gRwQvuR6r2D4RLb9KkGkbGTsEebm0bFV0niEQL7bNwGPhNKdQDUd43CCL6LMolBfxhgRO7N5TNQ7BlaDEJ9WQpzDTqbB9XXKPoAj/au0gD1G64cZegclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926959; c=relaxed/simple;
	bh=SkEqgeXQRfPj9rRBUex4GVfMd4XLfZB5s4m1YOpuAT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFm3yS3J0wTHMWfSAKTW6MlBYZrqcOmV1w0YCAF6I95bJFNnQyXArbvQpJ+wkCmwnxYwzDV8P4h7/RsyjpAAfo+6VrfYe32D9jUScgZ8D7BufqGaK1ugtYeKVJHf9PwrkuhglcmnJTfYwDCOnq7FXMZvI/7TzGhuSDUefO7yGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bjFKHRNP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OhpINTEOlhI6e8I32EuidRR/I2gb7I6ZOwEY3Oe23XM=; b=bjFKHRNPE4456OufUO0Yt4bxDC
	xFZ/viUCQmwKQv3B99Sic6sUuriqRaFNvXGJLpSsJ7gTJ6W/TPxY9NhDXcn5+e2fH8N0bCInOVH8u
	7pqCOCPfuQ8EXTe5aaH+KKUXUErkyL/7cAiQj2/EqPCgPFAoju57tPKcHBWpqGoWeYu0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vErgP-00Cc1l-Id; Fri, 31 Oct 2025 17:08:57 +0100
Date: Fri, 31 Oct 2025 17:08:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: altera-tse: Set platform drvdata
 before registering netdev
Message-ID: <0aa45c73-6896-4788-a3ec-1ab696e32ea5@lunn.ch>
References: <20251030102418.114518-1-maxime.chevallier@bootlin.com>
 <20251030102418.114518-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030102418.114518-2-maxime.chevallier@bootlin.com>

On Thu, Oct 30, 2025 at 11:24:14AM +0100, Maxime Chevallier wrote:
> We don't have to wait until netdev is registered before setting it as the
> pdev's drvdata. Move it at netdev alloc time.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

