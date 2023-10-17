Return-Path: <netdev+bounces-41915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 287AF7CC352
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1550AB2106B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBB83D39A;
	Tue, 17 Oct 2023 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5M/3Xm5p"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11DF42BF6;
	Tue, 17 Oct 2023 12:38:38 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FC6F9;
	Tue, 17 Oct 2023 05:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DRUCa97weLstpEgGrG2ii/9I2YFUmwQzzThrFcklsaM=; b=5M/3Xm5pC1JQ5CSrwJDcm5z+sX
	3BkHOcZ5gViu+XD17sJ9fLUI3fxR1crny7bkCopISjQUhvNi1qNu2R9WAGAABdiJ/EpGwWYMTpAsK
	c3XHY9Zy/YA7M4BNLhprg/oi/ughaNy6wjG4iBJjPO9URiG4b4ZGX4S+JHeiRB/MwFE0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qsjLD-002Tgv-SA; Tue, 17 Oct 2023 14:38:31 +0200
Date: Tue, 17 Oct 2023 14:38:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <1454c3e6-82d1-4f60-b07d-bc3b47b23662@lunn.ch>
References: <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me>
 <20231015.011502.276144165010584249.fujita.tomonori@gmail.com>
 <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me>
 <20231015.073929.156461103776360133.fujita.tomonori@gmail.com>
 <98471d44-c267-4c80-ba54-82ab2563e465@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98471d44-c267-4c80-ba54-82ab2563e465@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > Because set_speed() updates the member in phy_device and read()
> > updates the object that phy_device points to?
> 
> `set_speed` is entirely implemented on the Rust side and is not protected
> by a lock.

With the current driver, all entry points into the driver are called
from the phylib core, and the core guarantees that the lock is
taken. So it should not matter if its entirely implemented in the Rust
side, somewhere up the call stack, the lock was taken.

> >> What about these functions?
> >> - resolve_aneg_linkmode
> >> - genphy_soft_reset
> >> - init_hw
> >> - start_aneg
> >> - genphy_read_status
> >> - genphy_update_link
> >> - genphy_read_lpa
> >> - genphy_read_abilities
> > 
> > As Andrew replied, all the functions update some member in phy_device.
> 
> Do all of these functions lock the `bus->mdio_lock`?

When accessing the hardware, yes.

The basic architecture is that at the bottom we have an MDIO bus, and
on top of that bus, we have a number of devices. The MDIO core will
serialise access to the bus, so only one device on the bus can be
accessed at once. The phylib core will serialise access to the PHY,
but when there are multiple PHYs, the phylib core will allow parallel
access to different PHYs.

In summary, the core of each layer protects the drivers using that
layer from multiple parallel accesses from above.

       Andrew

