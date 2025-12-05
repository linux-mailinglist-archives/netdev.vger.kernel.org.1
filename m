Return-Path: <netdev+bounces-243812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B14CA7D6A
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 14:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93C55301C4A0
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325D7331A5C;
	Fri,  5 Dec 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dlqjxq1o"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9037331A78;
	Fri,  5 Dec 2025 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764942761; cv=none; b=tj+xh9zZBG9Afwa1w12Um1AMwtkG05Z1LfRxliiCXCiNbVeNsKVi9VbteCNToYHcQjqTVouuX98JzP64KgHI8uPpYDGoLQIMlnAV4L0eDl/AxdJXWpudmdsdlRhrDTFL675uRtw1aXLOnIVB/dWNiOBWudJrvxRQHsSdG6lFCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764942761; c=relaxed/simple;
	bh=iZ+UHCI1S0q19BIbsV/450wftS7aT7Q9oKxHP8vIzfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa4zZjR5IDKcBX5c980VPMJqg/zHV3++VV+cIk9vixBNAsJak8hECkp8YthphwJunNAnMsfO86PTY4VtHDrmbEY/6d1qySBvn03rGFFOZ68QRsVKJ3i/wHiG7oZMCYa+nXZjyQT+rHhNNJlHNbRn6XHpKzAPV1CEC48PvaLiu5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dlqjxq1o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=45fevIuzzwdxiIaiuDVXIFaxf4ZsoS1h5rOMT7+v7qs=; b=dlqjxq1oVt9Er6eo9vth9vX0gR
	eztKjUHcbALGVrKoPeu0Vvd/09R/aNtIbQtbYNm9rPcjYBV68HyB0YxkIGbjpEoMqNbls4/tE3p8y
	ifODQ2BErblRzyYv9e/ZaWvhI6CnU/FWJBZWquJc0kvSq9VWaRwl2eUEBXudw8IYLYh0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vRWEG-00G5sa-09; Fri, 05 Dec 2025 14:52:12 +0100
Date: Fri, 5 Dec 2025 14:52:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Message-ID: <230147e8-e27b-48e1-9a62-7aa8abc3f492@lunn.ch>
References: <20251205-aspeed_mdio_add_dummy_read-v1-1-60145ae20ea7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205-aspeed_mdio_add_dummy_read-v1-1-60145ae20ea7@aspeedtech.com>

On Fri, Dec 05, 2025 at 09:37:22AM +0800, Jacky Chou wrote:
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
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

This seems like a bug fix. Please add a Fixes: tag, for base it on
net, not net-next.

> ---
>  drivers/net/mdio/mdio-aspeed.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
> index e55be6dc9ae7..00e61b922876 100644
> --- a/drivers/net/mdio/mdio-aspeed.c
> +++ b/drivers/net/mdio/mdio-aspeed.c
> @@ -62,6 +62,12 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st, u8 op, u8 phyad, u8 regad,
>  		| FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
>  
>  	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
> +	/* Workaround for read-after-write issue.

Blank line before the comment please.

    Andrew

---
pw-bot: cr



