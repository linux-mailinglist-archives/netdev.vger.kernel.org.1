Return-Path: <netdev+bounces-41094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D627C99D3
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 17:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB97BB20B90
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806AE79F4;
	Sun, 15 Oct 2023 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gixs54a0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354D6749C;
	Sun, 15 Oct 2023 15:47:40 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915F4AB;
	Sun, 15 Oct 2023 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZstDpmxiWNvEKHZXZocDZQxQvgTHAaWx4KIzLBOqMwo=; b=Gixs54a0s+eZIhVBnh2oQL0uiK
	B1UDBQQk/9vTZ5BL+yGXKGDC8HsoGVhfoP+ADtK4l+cF2x5LOEzIAdQGrhGPAN8GFO8kjeOG/9FTr
	k6iktItKksIo73R/aM/1ORj05JtflcFHMZBCFKXdFAzhAPDZdnywQn6wjSwhXQgW3OAo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qs3L6-002FbS-1S; Sun, 15 Oct 2023 17:47:36 +0200
Date: Sun, 15 Oct 2023 17:47:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <a4ce76e4-a057-4f5a-aceb-73cf8185244f@lunn.ch>
References: <85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me>
 <4b7096cd-076d-42fd-b0cc-f842d3b64ee4@lunn.ch>
 <CANiq72m3xp6ErPwCOj6DrHpG_7OE9WUqVpsZcUDk4OSuH62mKg@mail.gmail.com>
 <20231015.081849.2094682155986954086.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015.081849.2094682155986954086.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Andrew, if you prefer, I'll move RUST_PHYLIB_ABSTRACTIONS to
> drivers/net/phy/Kconfig.
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index e55b71937f01..0d39b97a546c 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -66,6 +66,14 @@ config SFP
>  	depends on HWMON || HWMON=n
>  	select MDIO_I2C
>  
> +config RUST_PHYLIB_ABSTRACTIONS
> +        bool "PHYLIB abstractions support"
> +        depends on RUST
> +        depends on PHYLIB=y
> +        help
> +          Adds support needed for PHY drivers written in Rust. It provides
> +          a wrapper around the C phylib core.
> +

I'm nit picking, but i would actually put it between FIXED_PHY and
SFP. But otherwise, i'm happy with this. Putting it somewhere here is
the correct thing to do.

Thanks
	Andrew

