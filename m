Return-Path: <netdev+bounces-45004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056757DA79A
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 16:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FA41C209B0
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAE9156E3;
	Sat, 28 Oct 2023 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zr9AIjHC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73B3C22;
	Sat, 28 Oct 2023 14:53:35 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330C1CC;
	Sat, 28 Oct 2023 07:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YIMUzifN1hynypsjjhSY94GLELLMcdiZhuub/m0zOps=; b=zr9AIjHCHUBaDfaOeFgWW/a20M
	+FzQyJBp9VbyuxBQ8EQlLnKihbgX3svtctOgitM3HinfFC9hw/Z+GjfX//uu55D58Fj5zA8UWEKpT
	AluKpe4tySMkyLXFgy1bCywqn+XkUflyymAo+Mk1yknbP/9yjPqMqknv34qa8B9MAK4g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwkgs-000PIv-HL; Sat, 28 Oct 2023 16:53:30 +0200
Date: Sat, 28 Oct 2023 16:53:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: benno.lossin@proton.me, boqun.feng@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <f0bf3628-c4ef-4f80-8c1a-edaf01d77457@lunn.ch>
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <ZTwWse0COE3w6_US@boqun-archlinux>
 <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
 <20231028.182723.123878459003900402.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028.182723.123878459003900402.fujita.tomonori@gmail.com>

> > We need to be careful here, since doing this creates a reference
> > `&bindings::phy_device` which asserts that it is immutable. That is not
> > the case, since the C side might change it at any point (this is the
> > reason we wrap things in `Opaque`, since that allows mutatation even
> > through sharde references).
> 
> You meant that the C code might modify it independently anytime, not
> the C code called the Rust abstractions might modify it, right?

The whole locking model is base around that not happening. Things
should only change with the lock held. I you make a call into the C
side, then yes, it can and will change it. So you should not cache a
value over a C call.
 
 	Andrew

