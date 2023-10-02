Return-Path: <netdev+bounces-37450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBD37B5638
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 13DD1281D69
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0571C6AD;
	Mon,  2 Oct 2023 15:24:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBD1C2B0;
	Mon,  2 Oct 2023 15:24:21 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2105CA6;
	Mon,  2 Oct 2023 08:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nInV8NVdLeqVRHhAYLgKZnoZRLS4iv699Xy6XyUVeM4=; b=YESF0YYop1JVlyIfBv2P4dl/Hd
	SlmMyGQuj6uh7lS/wkdx3/7tCstFcSUTwFhJp3tsAzznkQ7StcASRRyxKABp90IX57cE90M0/m5s3
	KlQtwDmXVRs0t9TuHWT+nOF1kDVX+O4SI+gfpq1fAxKwulhHDE1yWi4mEXtrEB0pKSqM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qnKmP-00821U-Jw; Mon, 02 Oct 2023 17:24:17 +0200
Date: Mon, 2 Oct 2023 17:24:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v1 1/3] rust: core abstractions for network PHY drivers
Message-ID: <c0c00289-3bb3-4091-be78-8616e2ba90ee@lunn.ch>
References: <20231002085302.2274260-1-fujita.tomonori@gmail.com>
 <20231002085302.2274260-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002085302.2274260-2-fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +    /// Gets the id of the PHY.
> +    pub fn id(&mut self) -> u32 {
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        unsafe { (*phydev).phy_id }
> +    }

I somewhat agree with GregKH here. It will be easier to review and
maintain if the naming of well known things stay the same in the C and
Rust world. So phy_id. However....

> +    /// Gets the state of the PHY.
> +    pub fn state(&mut self) -> DeviceState {
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        let state = unsafe { (*phydev).state };
> +        match state {
> +            bindings::phy_state::PHY_DOWN => DeviceState::Down,
> +            bindings::phy_state::PHY_READY => DeviceState::Ready,
> +            bindings::phy_state::PHY_HALTED => DeviceState::Halted,
> +            bindings::phy_state::PHY_ERROR => DeviceState::Error,
> +            bindings::phy_state::PHY_UP => DeviceState::Up,
> +            bindings::phy_state::PHY_RUNNING => DeviceState::Running,
> +            bindings::phy_state::PHY_NOLINK => DeviceState::NoLink,
> +            bindings::phy_state::PHY_CABLETEST => DeviceState::CableTest,
> +        }
> +    }
> +
> +    /// Returns true if the link is up.
> +    pub fn get_link(&mut self) -> bool {
> +        const LINK_IS_UP: u32 = 1;
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        unsafe { (*phydev).link() == LINK_IS_UP }
> +    }

Naming is hard.

This one is trickier and shows a difference between C and Rust. C just
does phydev->link and treats it as a boolean, setter/getters are not
needed. But Rust does seem to need setter/getters, and it is a lot
less clear what link() does. get_link() is a bit more
obvious. has_link() would also work. But as GregKH said, get_foo() and
put_foo() are often used to represent getting a reference on an object
and releasing it. I am however of the opinion that many driver writers
don't understand locking, so it is best to hide all the locking in the
core. I would not actually expect to see a PHY driver need to take a
reference on anything.

Since we forced into a world of getter/setter, the previous one
probably should be get_phy_id() and we want consistent set_ and get_
prefixes for plain accesses to members without further interpretation.

> +
> +    /// Returns true if auto-negotiation is enabled.
> +    pub fn is_autoneg_enabled(&mut self) -> bool {
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        unsafe { (*phydev).autoneg() == bindings::AUTONEG_ENABLE }
> +    }

Should this maybe be get_autoneg_enabled()? I don't know.

       Andrew

