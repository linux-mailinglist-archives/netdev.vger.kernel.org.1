Return-Path: <netdev+bounces-37674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49537B694D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 0E1031C20803
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB6208BF;
	Tue,  3 Oct 2023 12:45:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73AAD53B;
	Tue,  3 Oct 2023 12:45:35 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1BB91;
	Tue,  3 Oct 2023 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OIEfIe4xKf94fD8/eEoIaOW0lqTEeFm26HPhDIowQDI=; b=XBvMf/ApA8A7i0LHzma7OvVRn7
	DRAg1AO3zKfDPdP+vHM6AXz5E9ZjZxKsdVPsKPHeFWei15Go94lfU/A7Ml2QY0xa5cEBogfqocDKg
	e154AP93rU8S9KdIzfdnJeJe/NRLaOAv8WH4YiTDXitc1lxTH/PPM+89Eelaq1lYnl14=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qnemI-0087Ha-6v; Tue, 03 Oct 2023 14:45:30 +0200
Date: Tue, 3 Oct 2023 14:45:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gregkh@linuxfoundation.org, miguel.ojeda.sandonis@gmail.com,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v1 1/3] rust: core abstractions for network PHY drivers
Message-ID: <212ffb46-ddec-4f84-a121-42ad70019363@lunn.ch>
References: <9efcbc51-f91d-4468-b7f3-9ded93786edb@lunn.ch>
 <20231003.124311.1007471622916115559.fujita.tomonori@gmail.com>
 <2023100317-glory-unbounded-af5c@gregkh>
 <20231003.154052.1399377054104937782.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003.154052.1399377054104937782.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> >> The following works. If you set the phylib as a module, the rust
> >> option isn't available.
> > 
> > That does not seem wise.  Why not make the binding a module as well?
> 
> Agreed, as I wrote in the previous mail. But Rust bindings doesn't
> support such now. I suppose that Miguel has worked on a new build
> system for Rust. He might have plans.

It would be nice to get the basic Kconfig symbols in place to support
this, for when the build does support bindings in modules. And you
should be able to use the same symbols now, just with slightly
different semantics.

The binding should have its own Kconfig Symbol, something like
RUST_PHYLIB_BINDING, with a depends on RUST and a depends on
PHYLIB. At the moment that should just cause the binding to be
compile/not compiled as part of the core rust support. The dependency
on PHYLIB will also ensure it is built in the correct way.

In the future, it can be used to build the binding as a standalone
module, built in, or not at all.

The PHY driver would then have a depends on RUST_PHYLIB_BINDING.

    Andrew

