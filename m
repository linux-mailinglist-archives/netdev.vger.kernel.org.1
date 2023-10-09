Return-Path: <netdev+bounces-39085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1967E7BDE11
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7298281572
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B351199AA;
	Mon,  9 Oct 2023 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sn0Avsys"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10914F7A;
	Mon,  9 Oct 2023 13:15:32 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30275BA;
	Mon,  9 Oct 2023 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XVt6uVvtnVY6nQisAPqik2/Zz5Sn7PC4T29qAIARMD4=; b=sn0AvsyshTG5vd4LOJ8y44uIsQ
	qfg76pyAzBvUfMi5uYCbkf6lU12u7EkiTEgmw3ht2A9jpQkiYrxYTxRZ7tBIuW4xA2qBmqPd0znd8
	KWCXRhFk7iaIukOUXcd+pD8pRXArBu7pLg5tNLvWby6zoxetsXDR3pE2edzDljlFb08c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qpq6b-000ssn-19; Mon, 09 Oct 2023 15:15:29 +0200
Date: Mon, 9 Oct 2023 15:15:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <97058377-fd92-4315-9094-d1a4179d43fa@lunn.ch>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-4-fujita.tomonori@gmail.com>
 <3dafc9f4-f371-a3d8-1d11-1b452b1c227e@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dafc9f4-f371-a3d8-1d11-1b452b1c227e@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > +        if ret as u32 & uapi::BMCR_SPEED100 != 0 {
> > +            dev.set_speed(uapi::SPEED_100);
> > +        } else {
> > +            dev.set_speed(uapi::SPEED_10);
> > +        }
> 
> Maybe refactor to only have one `dev.set_speed` call?

This is a common pattern in the C code. This is basically a
re-implementation of

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy_device.c#L2432

because this PHY is broken. Being one of the maintainers of the PHY
subsystem, it helps me review this code if it happens to look like the
existing code it is adding a workaround to.

Is there a Rust reason to only have one call?

   Andrew

