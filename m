Return-Path: <netdev+bounces-44898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749477DA391
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CDD282522
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9A83DFEB;
	Fri, 27 Oct 2023 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fd2bo0eP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D4405E8;
	Fri, 27 Oct 2023 22:36:40 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF1A1B6;
	Fri, 27 Oct 2023 15:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SLIUVCDynpjIMp+OaT7wI398MjmIftxEBP+4swMfLOM=; b=fd2bo0ePA45E9bCBygt8FfPMX+
	j8YsSoRPQth40HnUgmA/1iJZEyfL0aZQqrfqwRy0m9ikB2gFQYENKB73GGJzDS2q3ASWxGjfTBTmA
	BRc5E6iq4+VQ7XBxwEOlNNzq5HU9Wh5lrALdXbZ0qoPp84+kuWYpL57G5wYWx/FYxowI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwVRT-000NVh-6Y; Sat, 28 Oct 2023 00:36:35 +0200
Date: Sat, 28 Oct 2023 00:36:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <8fde6a54-8b15-4b0f-bf09-b54bd21eb9df@lunn.ch>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <ZTwWse0COE3w6_US@boqun-archlinux>
 <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
 <ZTw3_--yDkJ9ZwIP@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTw3_--yDkJ9ZwIP@boqun-archlinux>

> Hmm... but does it mean even `set_speed()` has the similar issue?
> 
> 	let phydev: *mut phy_device = self.0.get();
> 	unsafe { (*phydev).speed = ...; }
> 
> The `(*phydev)` creates a `&mut` IIUC. So we need the following maybe?
> 
> 	let phydev: *mut phy_device = self.0.get();
> 	unsafe { *addr_mut_of!((*phydev).speed) = ...; }
> 
> because at least from phylib core guarantee, we know no one accessing
> `speed` in the same time. However, yes, bit fields are tricky...

Speed is not a bitfield. Its a plain boring int. link is however a bit
field.

	Andrew

