Return-Path: <netdev+bounces-150462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D61D9EA4E5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C472870AE
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB51D1AB6F1;
	Tue, 10 Dec 2024 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZGA3hbEX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4819E980;
	Tue, 10 Dec 2024 02:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796711; cv=none; b=TtKGGLZg4zUwGpmLhM/pdu6DMhygH9RaGz2BK/Ynxr6csX8vJpQv5pGSN79zmZ44x+KDR88DmNZobiWbve3bv/+H8FqG/DQ/E0+f95bqycpA4Z4EIzkKDEFLGsDAi+pEUHgTJWChcil7/TypiEl5PdDd9RCQNp3ymLh/0X7W0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796711; c=relaxed/simple;
	bh=13rHJVXpALOGFBDEI7S5OS2hoqqTLj+lJWxYH9MJ55A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl2U8MnSUwzS0EskGu2DlpGgfeBpJkc6iU5E77Z8j6DmGV9yW4Gh+32b5sIZRzK3mA44MN8hnRsFNPnx4Fp5SWgyryh58pbvd6EixKTGgkzf0f+ILU/DUTjtILUxCPC317aRsufChm/Ao86vGpINsMsgpsZSeyZhaDSgBuk0q0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZGA3hbEX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7upNp26UfpPKX+m7Fo4Wt6tEHT1drJ+oJG7N8NvqYNw=; b=ZGA3hbEXG1DfOkvJsMZ+EBUbhw
	OrYIvQV6kys0W2qZ+dIkTc8BgJAUl227ReU0517+wwroIoFueYtVNDvQ14opRQ594Q1aQWhqQYphn
	qM6Xz/LLlDiTtVc9Mq0QeGh/Vr1ob9VGUCbO0tWNeuWq+s8h/PxvcZetu098cWQv3M2k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpiy-00Fk94-6H; Tue, 10 Dec 2024 03:11:44 +0100
Date: Tue, 10 Dec 2024 03:11:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 09/11] net: usb: lan78xx: Improve error
 handling in lan78xx_phy_wait_not_busy
Message-ID: <880eb763-74b0-4e89-a367-42d7804b526c@lunn.ch>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
 <20241209130751.703182-10-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209130751.703182-10-o.rempel@pengutronix.de>

On Mon, Dec 09, 2024 at 02:07:49PM +0100, Oleksij Rempel wrote:
> Update `lan78xx_phy_wait_not_busy` to forward errors from
> `lan78xx_read_reg` instead of overwriting them with `-EIO`. Replace
> `-EIO` with `-ETIMEDOUT` for timeout cases, providing more specific and
> appropriate error codes.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/usb/lan78xx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index fdeb95db529b..9852526be002 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -961,14 +961,14 @@ static int lan78xx_phy_wait_not_busy(struct lan78xx_net *dev)
>  
>  	do {
>  		ret = lan78xx_read_reg(dev, MII_ACC, &val);
> -		if (unlikely(ret < 0))
> -			return -EIO;
> +		if (ret < 0)
> +			return ret;
>  
>  		if (!(val & MII_ACC_MII_BUSY_))
>  			return 0;
>  	} while (!time_after(jiffies, start_time + HZ));
>  
> -	return -EIO;
> +	return -ETIMEDOUT;

It would be better to replace this with an iopoll.h helper.

However, the change you made is O.K.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

