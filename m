Return-Path: <netdev+bounces-38633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E9F7BBC39
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96C71C209C7
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 15:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14276286AB;
	Fri,  6 Oct 2023 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KMtBk0of"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81284286A7;
	Fri,  6 Oct 2023 15:57:46 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE92CAD;
	Fri,  6 Oct 2023 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8o9Gi4Xf/ay6M3IvfmXZegqImEiZVvhH9cvjBMkAtZE=; b=KMtBk0ofhDufiVEzfg80MDeAqY
	IrOM1npHLRLDABLBW6OaUz2avHEHYd+CZ5F9NLJfRTJKBtJowo/iVJtAJXm04IkKtAOXA7dRt6rNI
	H4xwqPHU9Z00TQ898mlCAE6j72UuElH/PDzmRhNatSrS7r4e7YoLQ0jWTsZ2EZTW8JaQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qonCv-0002pE-6v; Fri, 06 Oct 2023 17:57:41 +0200
Date: Fri, 6 Oct 2023 17:57:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <3db1ad51-a2a0-4648-8bc5-7ed089a4e5dd@lunn.ch>
References: <2023100635-product-gills-3d7e@gregkh>
 <20231006.225325.1176505861124451190.fujita.tomonori@gmail.com>
 <19161969-1033-4fd5-9a24-ec21d66c6735@lunn.ch>
 <20231007.002609.681250079112313735.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007.002609.681250079112313735.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Now I'm thinking that this is the best option. Kconfig would be the following:
> 
> config AX88796B_PHY
>         tristate "Asix PHYs"
>         help
>          Currently supports the Asix Electronics PHY found in the X-Surf 100
>          AX88796B package.
> 
> choice
>         prompt "Implementation options"
>         depends on AX88796B_PHY
>         help
>          There are two implementations for a driver for Asix PHYs; C and Rust.
>          If not sure, choose C.
> 
> config AX88796B_C_PHY
>         bool "The C version driver for Asix PHYs"
> 
> config AX88796B_RUST_PHY
>         bool "The Rust version driver for Asix PHYs"
>         depends on RUST
> 
> endchoice
> 
> 
> No hack in Makefile:
> 
> obj-$(CONFIG_AX88796B_C_PHY)    += ax88796b.o
> obj-$(CONFIG_AX88796B_RUST_PHY) += ax88796b_rust.o

This looks reasonable. Lets use this. But i still think we need some
sort of RUST_PHYLIB_BINDING.

     Andrew

