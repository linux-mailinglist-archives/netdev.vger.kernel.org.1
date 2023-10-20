Return-Path: <netdev+bounces-43099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606C37D1688
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F36D1C20A38
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1574B22333;
	Fri, 20 Oct 2023 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o9XlXrrg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A741802E;
	Fri, 20 Oct 2023 19:50:39 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C04D57;
	Fri, 20 Oct 2023 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WGQNwyoQWo+MRR4XU1PpD0x0wGN+nDRTV2R1AIAROkE=; b=o9XlXrrgvDkaQB8dOSgWRKnbje
	nEPc++gmlnk3C19A4gCMY5ttwsdiZLtN7NKuyjwBcxcvogbGeOvSAgoSa2rVMQirMBnGGm5h581zz
	NDiM3dN1HtFXLp+jWrfzNmS4FNrMWmTFzVuGCGVYiH5abRxWYLD7dBScaMvT1q3f9A+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qtvVx-002oW3-V3; Fri, 20 Oct 2023 21:50:33 +0200
Date: Fri, 20 Oct 2023 21:50:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <b58e0874-b0d4-4218-a457-4e2e753e0b17@lunn.ch>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
 <20231017113014.3492773-2-fujita.tomonori@gmail.com>
 <de9d1b30-ab19-44f9-99a3-073c6d2b36e1@lunn.ch>
 <20231019.094147.1808345526469629486.fujita.tomonori@gmail.com>
 <64748f96-ac67-492b-89c7-aea859f1d419@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64748f96-ac67-492b-89c7-aea859f1d419@proton.me>

> I will try to explain things a bit more.
> 
> So this case is a bit difficult to figure out, because what is
> going on is not really a pattern that is used in Rust.

It is however a reasonably common pattern in the kernel. It stems from
driver writers often don't understand locking. So the core does the
locking, leaving the driver writers to just handle the problems of the
hardware.

Rust maybe makes locking more of a visible issue, but if driver
writers don't understand locking, the language itself does not make
much difference.

> We already have exclusive access to the `phy_device`, so in Rust
> you would not need to lock anything to also have exclusive access to the
> embedded `mii_bus`.

I would actually say its not the PHY drivers problem at all. The
mii_bus is a property of the MDIO layers, and it is the MDIO layers
problem to impose whatever locking it needs for its properties.

Also, mii_bus is not embedded. Its a pointer to an mii_bus. The phy
lock protects the pointer. But its the MDIO layer which needs to
protect what the pointer points to.

	Andrew

