Return-Path: <netdev+bounces-40940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2782A7C924D
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 04:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DFC282DCE
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BDB111B;
	Sat, 14 Oct 2023 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0de3ITaR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EEF7E;
	Sat, 14 Oct 2023 02:13:01 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C9EC0;
	Fri, 13 Oct 2023 19:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LaQGFBK62vna6IUYt5GEKCDuPSNgJGTva0S77gxRNxM=; b=0de3ITaRHFJWq8PfJ5JFsaFXPQ
	I3RiqLgkEZh3qw+an4wjAg3KTLYrKzpBLWktbUdXzZMEM1las4q72+DjsgGjCCc1gUt+kp2bixNGW
	uSeZAew8LHi85Qmm5U7qky7jlDi4GoEyx6WTT3FdswtDJU1AZtvbiOXaw0mLV/8k7bNY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrU9C-0029X9-0E; Sat, 14 Oct 2023 04:12:58 +0200
Date: Sat, 14 Oct 2023 04:12:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <4b7096cd-076d-42fd-b0cc-f842d3b64ee4@lunn.ch>
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
 <20231012125349.2702474-2-fujita.tomonori@gmail.com>
 <85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > +config RUST_PHYLIB_ABSTRACTIONS
> > +        bool "PHYLIB abstractions support"
> > +        depends on RUST
> > +        depends on PHYLIB=y
> > +        help
> > +          Adds support needed for PHY drivers written in Rust. It provides
> > +          a wrapper around the C phylib core.
> > +
> 
> I find it a bit weird that this is its own option under "General". I think
> it would be reasonable to put it under "Rust", since that would also scale
> better when other subsystems do this.

To some extent, this is just a temporary location. Once the
restrictions of the build systems are solved, i expect this will move
into drivers/net/phy/Kconfig, inside the 'if PHYLIB'. However, i
agree, this should be under the Rust menu.

> > +    }
> > +
> > +    /// Reads a given C22 PHY register.
> > +    pub fn read(&self, regnum: u16) -> Result<u16> {
> 
> No idea if this function should be `&mut self` or `&self`. Would
> it be ok for mutltiple threads to call this function concurrently?
> If yes, then leave it as `&self`, if no then change it to `&mut self`.

The MDIO layer before has a lock, so its will serialize parallel
reads/writes. With the current Rust integration, it should never be
possible for multiple threads to be active at once, but if it does
happen, its not a problem anyway.

 	Andrew

