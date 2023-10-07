Return-Path: <netdev+bounces-38799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF477BC8A5
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 17:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F3C1C20934
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A3E2E623;
	Sat,  7 Oct 2023 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SRt13PZy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC75DDC8;
	Sat,  7 Oct 2023 15:35:12 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499C6BF;
	Sat,  7 Oct 2023 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=DHa/FWV1S4maK1jlq54/gZd3w4VVg95kUVb3AtSLPUw=; b=SR
	t13PZyKrbVlzqjWr1JDyvox9C8vwiJ9SmUgZ2aWgbyeZWScARQ6Vfi0Fj/LuTZoXnw6HV2W925cag
	dliT6itRUyBjPSl/yAyv+HUhmb6aLPCZ3EoppFS4SEjELQW9HR0UH/tyDrXS0uO+tsZNkmdtkBdjI
	lkgJqqcHhEnPSH8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qp9Ke-000KGR-3r; Sat, 07 Oct 2023 17:35:08 +0200
Date: Sat, 7 Oct 2023 17:35:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Trevor Gross <tmgross@umich.edu>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <d824a34f-7290-477e-8198-c16164e34861@lunn.ch>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
 <20231006094911.3305152-4-fujita.tomonori@gmail.com>
 <CALNs47syMxiZBUwKLk3vKxzmCbX0FS5A37FjwUzZO9Fn-iPaoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALNs47syMxiZBUwKLk3vKxzmCbX0FS5A37FjwUzZO9Fn-iPaoA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 07, 2023 at 03:19:20AM -0400, Trevor Gross wrote:
> On Fri, Oct 6, 2023 at 5:49 AM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> 
> > diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
> > new file mode 100644
> > index 000000000000..d11c82a9e847
> > --- /dev/null
> > +++ b/drivers/net/phy/ax88796b_rust.rs
> 
> Maybe want to link to the C version, just for the crossref?
> 
> > +    fn read_status(dev: &mut phy::Device) -> Result<u16> {
> > +        dev.genphy_update_link()?;
> > +        if !dev.get_link() {
> > +            return Ok(0);
> > +        }
> 
> Looking at this usage, I think `get_link()` should be renamed to just
> `link()`. `get_link` makes me think that it is performing an action
> like calling `genphy_update_link`, just `link()` sounds more like a
> static accessor.

Naming is hard, and i had the exact opposite understanding.

The rust binding seems to impose getter/setters on members of
phydev. So my opinion was, using get_/set_ makes it clear this is just
a dumb getter/setter, and nothing more.

> Or maybe it's worth replacing `get_link` with a `get_updated_link`
> that calls `genphy_update_link` and then returns `link`, the user can
> store it if they need to reuse it. This seems somewhat less accident
> prone than someone calling `.link()`/`.get_link()` repeatedly and
> wondering why their phy isn't coming up.

You have to be very careful with reading the link state. It is latched
low. Meaning if the link is dropped and then comes back again, the
first read of the link will tell you it went away, and the second read
will give you current status. The core expects the driver to read the
link state only once, when asked what is the state of the link, so it
gets informed about this short link down events.

> In any case, please make the docs clear about what behavior is
> executed and what the preconditions are, it should be clear what's
> going to wait for the bus vs. simple field access.
> 
> > +        if ret as u32 & uapi::BMCR_SPEED100 != 0 {
> > +            dev.set_speed(100);
> > +        } else {
> > +            dev.set_speed(10);
> > +        }
> 
> Speed should probably actually be an enum since it has defined values.
> Something like
> 
>     #[non_exhaustive]
>     enum Speed {
>         Speed10M,
>         Speed100M,
>         Speed1000M,
>         // 2.5G, 5G, 10G, 25G?
>     }

This beings us back to how do you make use of C #defines. All the
values defined here are theoretically valid:

https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ethtool.h#L1887

#define SPEED_10		10
#define SPEED_100		100
#define SPEED_1000		1000
#define SPEED_2500		2500
#define SPEED_5000		5000
#define SPEED_10000		10000
#define SPEED_14000		14000
#define SPEED_20000		20000
#define SPEED_25000		25000
#define SPEED_40000		40000
#define SPEED_50000		50000
#define SPEED_56000		56000
#define SPEED_100000		100000
#define SPEED_200000		200000
#define SPEED_400000		400000
#define SPEED_800000		800000

and more speeds keep getting added.

Also, the kAPI actually would allow the value 42, not that any
hardware i know of actually supports that.

> > +    fn link_change_notify(dev: &mut phy::Device) {
> > +        // Reset PHY, otherwise MII_LPA will provide outdated information.
> > +        // This issue is reproducible only with some link partner PHYs.
> > +        if dev.state() == phy::DeviceState::NoLink {
> > +            let _ = dev.init_hw();
> > +            let _ = dev.start_aneg();
> > +        }
> > +    }
> > +}
> 
> Is it worth doing anything with these errors? I know that the C driver doesn't.

You could do a phydev_err(). But if these fail, the hardware is dead,
and there is not much you can do about that.

    Andrew

