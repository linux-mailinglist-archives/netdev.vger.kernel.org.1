Return-Path: <netdev+bounces-244385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5C3CB6068
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 14:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2014300D67B
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFBD3126C5;
	Thu, 11 Dec 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P04z5f9Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6DB313268;
	Thu, 11 Dec 2025 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765459804; cv=none; b=BksUMMEcQYhnpPcSZrA8Rgaj1rBXKE5cd8wLd7PoySl0bwOmFoO97HlsXqplMBFXDb+v4EbAx4GQ1Pkf69DSP5bIqfCGUMRS8md0/HrY7GbZ9fCMwyGjsGQj29PR6aBtG6iYn1yua30k0YqgptTDBW5/kdfmT0xJWWYQJHtEoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765459804; c=relaxed/simple;
	bh=lxQi+IzlhDXuZnNkRnSo3ZCQlKCArNUMb1pnUOHwlCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlDL1JpUNTssKMHAJ9aeCbpqLeMLynloRbFND0Oine5ITXcMznq1Ett4tC7E9L97kaNYR6peLtPxamDww5qFbC1SOieo1trw+lOFKVlrfryQeA9KLErO+l3bFUMLWnP0uQi7F1zaUqG1ehulvl5Z/nTbDGNChwODqyPuTJv0tbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P04z5f9Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PfFxejg/br2zDaiaEBdU9ZBdpu/3APgsmRYKWbR2RV4=; b=P04z5f9QZhAjh49Y13gbduOzqp
	vV0qjgaGNF2sYUMqiw8k9BpvW1l0DPcwMmbvMmXV31PKHlCovv5/Jms0qP4AD55otX18xsVdDdYeG
	jLjA5stL9swHDLi/q94ykBcZAtxj0s/q/UgX5pPCDfEP3rJvRHJgEmfh4htwQZCklaCc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vTgjQ-00Ge9n-Si; Thu, 11 Dec 2025 14:29:20 +0100
Date: Thu, 11 Dec 2025 14:29:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Potin Lai <potin.lai@quantatw.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH net v3] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Message-ID: <f53fcaf3-0154-4cc7-87be-ab815fa8b6f5@lunn.ch>
References: <20251211-aspeed_mdio_add_dummy_read-v3-1-382868869004@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211-aspeed_mdio_add_dummy_read-v3-1-382868869004@aspeedtech.com>

On Thu, Dec 11, 2025 at 02:24:58PM +0800, Jacky Chou wrote:
> The Aspeed MDIO controller may return incorrect data when a read operation
> follows immediately after a write. Due to a controller bug, the subsequent
> read can latch stale data, causing the polling logic to terminate earlier
> than expected.
> 
> To work around this hardware issue, insert a dummy read after each write
> operation. This ensures that the next actual read returns the correct
> data and prevents premature polling exit.
> 
> This workaround has been verified to stabilize MDIO transactions on
> affected Aspeed platforms.
> 
> Fixes: f160e99462c6 ("net: phy: Add mdio-aspeed")
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

