Return-Path: <netdev+bounces-37550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C049F7B5EBB
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 03:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 010BB28114C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 01:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31123657;
	Tue,  3 Oct 2023 01:41:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AFA63D;
	Tue,  3 Oct 2023 01:40:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793EBAC;
	Mon,  2 Oct 2023 18:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rAOEKWjMMylJBQL0HHB1KeAgb3dtmOW8jmUvKI8UCvE=; b=j7W0gtxfTKJAHyyRYVocGKLRnN
	rO94PbmgsJDT2B1TiE5mcBD+XxsFdjyPJ/6T+3T+rvMeuuZ8QJ2dJ3zCfoFxLe3W/XXXBADfAWwY+
	BPqgNSkuMzlnia2uwSOj+cYkbDCMoEVDSROmq/w9lBbMVlJ/tMWh+YH6Pbcgmaj+8k4k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qnUP4-0084NM-GR; Tue, 03 Oct 2023 03:40:50 +0200
Date: Tue, 3 Oct 2023 03:40:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v1 1/3] rust: core abstractions for network PHY drivers
Message-ID: <9efcbc51-f91d-4468-b7f3-9ded93786edb@lunn.ch>
References: <20231002085302.2274260-1-fujita.tomonori@gmail.com>
 <20231002085302.2274260-2-fujita.tomonori@gmail.com>
 <ec65611a-d52a-459a-af60-6a0b441b0999@lunn.ch>
 <20231003.093338.913889246531201639.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003.093338.913889246531201639.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 09:33:38AM +0900, FUJITA Tomonori wrote:
> On Mon, 2 Oct 2023 16:52:45 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> >> +//! Networking.
> >> +
> >> +#[cfg(CONFIG_PHYLIB)]
> > 
> > I brought this up on the rust for linux list, but did not get a answer
> > which convinced me.
> 
> Sorry, I overlooked that discussion.
> 
> 
> > Have you tried building this with PHYLIB as a kernel module? 
> 
> I've just tried and failed to build due to linker errors.
> 
> 
> > My understanding is that at the moment, this binding code is always
> > built in. So you somehow need to force phylib core to also be builtin.
> 
> Right. It means if you add Rust bindings for a subsystem, the
> subsystem must be builtin, cannot be a module. I'm not sure if it's
> acceptable.
 
You just need Kconfig in the Rust code to indicate it depends on
PHYLIB. Kconfig should then remove the option to build the phylib core
as a module. And that is acceptable.  

> > Or you don't build the binding, and also don't allow a module to use
> > the binding.
> 
> I made PHY bindings available only if PHYLIB is builtin like the
> following. However, we want modularity for Rust support, fully or
> partially (e.g., per subsystem), I think.
> 
> Miguel, I suppose that you have worked on a new build system. It can
> handle this problem?
> 
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index e4d941f0ebe4..a4776fdd9b6c 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -110,6 +110,7 @@ config AX88796B_PHY
>  config AX88796B_RUST_PHY
>  	bool "Rust reference driver"
>  	depends on RUST && AX88796B_PHY
> +	depends on PHYLIB=y

No, this is wrong. Miguel has said that leaf devices can be
modules. This driver is a leaf, all it depends on is the Rust
binding. And the Rust binding is built in, or not build at all. So the
first depends on covers that.

What is missing is that the Rust binding depends on PHYLIB.

     Andrew

