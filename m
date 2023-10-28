Return-Path: <netdev+bounces-45023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3F07DA8E3
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 21:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A59AAB20ED5
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 19:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B33F171D1;
	Sat, 28 Oct 2023 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Jky3vDiG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55ABA35;
	Sat, 28 Oct 2023 19:23:31 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430BFB8;
	Sat, 28 Oct 2023 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ySUjrU3l0uJ4L78Um5Ov8ltiXTdaj9snIF46wEQ5pcQ=; b=Jky3vDiGRy8D2WfjQ8GLNfXi5c
	X0Dwz/tnFT3OoIHviDfSRkzYEw8xl3feQ6EQ+XV0FbYK6LBuMakd/R2gRqxRisSIjWK0CiSxsF3Wi
	nOKq0m2M0SiWrGyw3zpUbKLNfC0PdVRm3waZ22VoJMmsz91/SN6hfaeJ7FWM39cfYkhQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwou5-000Q03-2N; Sat, 28 Oct 2023 21:23:25 +0200
Date: Sat, 28 Oct 2023 21:23:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <10415b9d-5051-47b1-8dee-9decc0d1539a@lunn.ch>
References: <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
 <20231028.182723.123878459003900402.fujita.tomonori@gmail.com>
 <f0bf3628-c4ef-4f80-8c1a-edaf01d77457@lunn.ch>
 <20231029.010905.2203628525080155252.fujita.tomonori@gmail.com>
 <91cba75f-0997-43e8-93d0-b795b3783eff@proton.me>
 <ZT1bt8FknDEeUotm@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT1bt8FknDEeUotm@Boquns-Mac-mini.home>

> Now let's look back into struct phy_device, it does have a few locks
> in it, and at least even with phydev->lock held, the content of
> phydev->lock itself can be changed (e.g tick locks), hence it breaks the
> requirement of the existence of a `&bindings::phy_device`.

tick locks appear to be a Rust thing, so are unlikely to appear in a C
structure. However, kernel C mutex does have a linked list of other
threads waiting for the mutex. So phydev->lock can change at any time,
even when held.

	Andrew

