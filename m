Return-Path: <netdev+bounces-44762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E450B7D992C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 15:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9D32823E7
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 13:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4817990;
	Fri, 27 Oct 2023 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LIhuElef"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0046E5CBC;
	Fri, 27 Oct 2023 13:00:20 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475EA129;
	Fri, 27 Oct 2023 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=34TFNELcRwb0DEJVWK6Vdvd41rU1dvOB0Wf82pfyYng=; b=LIhuElef+PFF7bZIJ0tGlYuono
	lXcK5vol/SD1w3bbteFTXN0h+02yCXpDD3tcYJbqpsML6Vkj2n7zhdjmdiEA2L++zp/Tt8nc9OLXZ
	seoq1Es/qf2W4+YbQby/j69NtyGd4TcC6SVkNr1KppItPzCTdhSJeuzMKn9j/XcmT4y8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwMRh-000L8r-Bm; Fri, 27 Oct 2023 15:00:13 +0200
Date: Fri, 27 Oct 2023 15:00:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
Message-ID: <669d8fba-f6bb-4dc8-a06b-752fb83902b4@lunn.ch>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>
 <ZTsbG7JMzBwcYzhy@Boquns-Mac-mini.home>
 <c40722eb-e78a-467d-8f91-ef9e8afe736d@lunn.ch>
 <ZTsqROr8s18aWwSY@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTsqROr8s18aWwSY@boqun-archlinux>

> Do the CI tests support Rust now? Does Tomo's patch pass CI? Looks like
> something we'd like to see (and help).

Its work in progress.

https://patchwork.kernel.org/project/netdevbpf/patch/20231026001050.1720612-6-fujita.tomonori@gmail.com/

These are the current tests we have. You can see it fails two tests. I
would say neither are blockers. netdev does try to stick to 80
character line length, so it would be nice to fix that. The checkpatch
warning about the Kconfig help can also be ignored.

There are currently a few builds performed for each patch, once with
gcc and once with clang/llvm. These use the allmodconfig kernel
configuration, since that generally builds the most code. However,
Rust is not enabled in the configuration. So i submitted a new test,
based on the clang build, which massages the kernel configuration to
actually enable Rust, and to ensure the dependencies are fulfilled to
allow the PHY driver to be enabled, and then enable it. We want the
build with a patch to have equal or less errors and warning from the
toolchain.

Its not clear how long it will take before this new test becomes
active. The build machine does not have a Rust toolchain yet, etc.  To
make up for that, i just build the series myself on my machine, and it
builds cleanly for me.

We are also open to add more tests. You will get more return on
investment if you extend the C=1 checks, since that is used in a lot
more places than networking. But we can add more tests to the
networking CI system, if you can tell us what to test, how to test it,
and how to evaluate the results.

> > likely will be merged. Real problems can be fixed up later, if need
> > be.
> 
> But this doesn't apply to pure API, right? So if some one post a pure
> Rust API with no user, but some tests, and the CI passes, the API won't
> get merged? Even though no review is fine and if API has problems, we
> can fix it later?

There is always a human involved. If a reviewer does not pick up the
missing user, the Maintainer should and reject the patch.

	Andrew

