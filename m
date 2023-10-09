Return-Path: <netdev+bounces-39120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CEB7BE238
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0328428172C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0024734CC8;
	Mon,  9 Oct 2023 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OqQJmm69"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501F347D4;
	Mon,  9 Oct 2023 14:13:21 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251978E;
	Mon,  9 Oct 2023 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8KIoAiTLoy24O+461/DD6A8O2EnQ0bSl9jjT1Lzcc6Q=; b=OqQJmm69msFWkp2bBIvQflKVjV
	wD4n+UWZcBmWcfepJUZUI/16eJmW4kDOiQK53w6xOeVD6kC5iSYsqUvwtn3l8PYYqBqEUKxdqZsdo
	I9QlNy4ckA/TnICxR/9KEKB/ZcXQs2K8xUJZWmLT01/tsmAXlGk9Y3bE0cuLYUEeG1LA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qpr0X-000tqR-OY; Mon, 09 Oct 2023 16:13:17 +0200
Date: Mon, 9 Oct 2023 16:13:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <a0a24765-8981-497c-a499-4dcf71897fda@lunn.ch>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-2-fujita.tomonori@gmail.com>
 <1aea7ddb-73b7-8228-161e-e2e4ff5bc98d@proton.me>
 <4ced711a-009c-4e57-a758-1d13d97e18d2@lunn.ch>
 <f5878806-5ba2-d932-858d-dda3f55ceb67@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5878806-5ba2-d932-858d-dda3f55ceb67@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > Locking has been discussed a number of times already. What do you mean
> > by timing?
> 
> A few different things:
> - atomic/raw atomic context

PHY drivers need to access a slow MDIO bus, so you are always in
thread context which can sleep. Even the interrupt handler is in
thread context, and the device lock is held.

> >>> +macro_rules! module_phy_driver {
> >>> +    (@replace_expr $_t:tt $sub:expr) => {$sub};
> >>> +
> >>> +    (@count_devices $($x:expr),*) => {
> >>> +        0usize $(+ $crate::module_phy_driver!(@replace_expr $x 1usize))*
> >>> +    };
> >>> +
> >>> +    (@device_table [$($dev:expr),+]) => {
> >>> +        #[no_mangle]
> >>> +        static __mod_mdio__phydev_device_table: [
> >>
> >> Shouldn't this have a unique name? If we define two different
> >> phy drivers with this macro we would have a symbol collision?
> > 
> > I assume these are the equivalent of C static. It is not visible
> > outside the scope of this object file. The kernel has lots of tables
> > and they are mostly of very limited visibility scope, because only the
> > method registering/unregistering the table needs to see it.
> The `#[no_mangle]` attribute in Rust disables standard symbol name
> mangling, see [2]. So if this macro is invoked twice, it will result
> in a compile error.

Invoked twice in what context? Within one object file? That i would
say is O.K. In practice, you only every have one table per driver.

As i said, i expect these symbols are static, so not seen outside the
object file. So if it is involved twice by different PHY drivers, that
should not matter, they are not global symbols, so the linker will not
complain about them. Also, in the Linux world, symbols are not visible
outside of a kernel module unless there is an EXPORT_SYMBOL_GPL() on
the symbol. So even if two kernel drivers do have global scope tables
with the same name, they are still invisible to each other when built
into the kernel, or loaded at runtime.

       Andrew

