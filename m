Return-Path: <netdev+bounces-38608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7307BBA7F
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560591C209AC
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3137D1BDD8;
	Fri,  6 Oct 2023 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0CSixi2v"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798B214017;
	Fri,  6 Oct 2023 14:40:24 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0EED6;
	Fri,  6 Oct 2023 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gRtVvIUSp7ILS/ORdBKDzzDAHNjlm48hy0e/8Yai3zU=; b=0CSixi2vSlUYHc5irhvfUYpque
	M2WoOBURP3MhEG1mIAs5y5Ngvc9qUHgPvoY7rNZOug0AnPTGbaAdrXoojjzz9cGQkcA5IJdSw52bx
	DkTnoNo5Vr9/10K6LLOEHRQ5KyNvxdexduRu292ute7I7vb5BddPcyR1afMvQxyU3KrA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qom04-0001mE-I5; Fri, 06 Oct 2023 16:40:20 +0200
Date: Fri, 6 Oct 2023 16:40:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <d7cd4fe4-6c33-4acf-a7b6-0a7ea8806508@lunn.ch>
References: <2023100635-product-gills-3d7e@gregkh>
 <20231006.225325.1176505861124451190.fujita.tomonori@gmail.com>
 <2023100637-episode-espresso-7a5a@gregkh>
 <20231006.233054.318856023136859648.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006.233054.318856023136859648.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> config AX88796B_PHY
> 	tristate "Asix PHYs"
> 	help
> 	  Currently supports the Asix Electronics PHY found in the X-Surf 100
> 	  AX88796B package.
> 
> config AX88796B_RUST_PHY
> 	bool "Rust reference driver"
> 	depends on RUST && AX88796B_PHY
> 	default n
> 	help
> 	  Uses the Rust version driver for Asix PHYs.
> 
> 
> The problem is that there are NIC drivers that `select
> AX88796B_PHY`. the Kconfig language doesn't support something like
> `select AX88796B_PHY or AX88796B_RUST_PHY`, I guess.

So change AX88796B_PHY to mean any driver for that hardware. And then
move the C driver to AX88796B_C_PHY, and add AX88796B_RUST_PHY.

All the MAC drivers really cares about is that there is a PHY
driver. They don't care if it is written in C, Rust, or SNOBOL.

	Andrew

