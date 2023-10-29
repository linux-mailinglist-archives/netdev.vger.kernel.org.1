Return-Path: <netdev+bounces-45083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AE67DAD84
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 18:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C182814C4
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 17:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3501CDDD4;
	Sun, 29 Oct 2023 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DlClk5VK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0DD298;
	Sun, 29 Oct 2023 17:32:40 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5531AC;
	Sun, 29 Oct 2023 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tagNYyBtJKInOM5nLRNvIMhlgvMRiYzGxLG6r8+3Kdk=; b=DlClk5VK+gI62iAEyoe/cQI1hr
	cxQmmPZkM/iyZGrlYJSHxZ9drysd2ggjML7NSN30aBCsNXCEFtU25OHQyzRl4PFJbG1jdqYxMjR9Y
	y8WWFzlA/I5rGQvGg3NBUEKohQJfKqDSD9jzDfur2C5PcbeQ1gCuEvkHzZvhVo+75xok=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qx9eM-000SCY-NE; Sun, 29 Oct 2023 18:32:34 +0100
Date: Sun, 29 Oct 2023 18:32:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: benno.lossin@proton.me, boqun.feng@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <03089090-6822-439b-a725-bd907b6d69ce@lunn.ch>
References: <45b9c77c-e19c-4c06-a2ea-0cf7e4f17422@proton.me>
 <b045970a-9d0f-48a1-9a06-a8057d97f371@lunn.ch>
 <0e858596-51b7-458c-a4eb-fa1e192e1ab3@proton.me>
 <20231029.132112.1989077223203124314.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029.132112.1989077223203124314.fujita.tomonori@gmail.com>

> The current code is fine from Rust perspective because the current
> code copies phy_driver on stack and makes a reference to the copy, if
> I undertand correctly.
> 
> It's not nice to create an 500-bytes object on stack. It turned out
> that it's not so simple to avoid it.

Does it also copy the stack version over the 'real' version before
exiting? If not, it is broken, since modifying state in phy_device is
often why the driver is called. But copying the stack version is also
broken, since another thread taking the phydev->lock is going to get
lost from the linked list of waiters.

Taking a copy of the C structure does seem very odd, to me as a C
programmer.

     Andrew

