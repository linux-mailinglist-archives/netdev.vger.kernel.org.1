Return-Path: <netdev+bounces-39069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E787BDC18
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F741C20A9F
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930FE20FE;
	Mon,  9 Oct 2023 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5KRGwMLa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699F199B7;
	Mon,  9 Oct 2023 12:33:12 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCC31BE3;
	Mon,  9 Oct 2023 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Yd7mHoNJ4kz2p4iN27vmSx0ftSZgGI9Oxq4feMbn1Xk=; b=5KRGwMLacCxqMcMIrXYkmrTdIH
	Ba85cAhXbL2hKUIsA+q/jWlyGctKfz571HJMCS1zXmPmPlyh4wz/JBh/xhzQqWSdZ8SQwIPMIuwQe
	Dmo3GTN36EcC6VLGOEfhqvrf5D+KW9eDdXIUnRG5mgWDxknK5xdDaJN27D8XNZwjrBQQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qppRE-000s8l-UV; Mon, 09 Oct 2023 14:32:44 +0200
Date: Mon, 9 Oct 2023 14:32:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiri Pirko <jiri@resnulli.us>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <bdfac30f-364f-4625-a808-fcffab2f75b4@lunn.ch>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-4-fujita.tomonori@gmail.com>
 <ZSOqWMqm/JQOieAd@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSOqWMqm/JQOieAd@nanopsycho>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Wait. So you just add rust driver as a duplicate of existing c driver?
> What's the point exactly to have 2 drivers for the same thing?

To tell the truth, i don't think the driver itself is very
important. The important thing has been the discussion along the way
to get to a driver.

For me as a Maintainer, the discussion about maintainability, how do
we make the build fail when C and Rust diverge is important.  So it
seems C enum are better than #defines for that. Maybe we will need to
replace some #define lists with enum in core code? But we also have a
lot of #defines which it would be good to be able to use.

It took a while to get the code to actually register the driver
instances. But this is something nearly every driver needs to do, so i
hope the ideas and maybe some of the actual code can be used in other
drivers.

It has become much clearer the Rust build system needs work. It is too
monolithic at the moment, and there are no good examples of kconfig
integration. 

Documentation is still an open question for me. I know Rust can
generate documentation from the code, but how do we integrate that
into the existing kernel documentation?

Within netdev, our own tooling is not ready for Rust. Our patchwork
instance did not recognise the patch was for netdev. That has been
fixed now. But i'm pretty sure the latest version of the code was not
built as part of our build testing. Jakub said the machine did not
have a Rust toolchain.  I also think because of the Rust build system
limitations, even if it did have the tools, i don't think with
allmodconfig it would try to built the rust code.

When i build it on my machine, i get a million warnings from i think
the linker. That is not going to be acceptable to Mainline, so we need
to investigate that.

I hope some sort of lessons learned, best practices and TODO list can
be distilled from the experience, to help guide the Rust Experiment.

	Andrew

