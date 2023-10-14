Return-Path: <netdev+bounces-41049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3938A7C9711
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 00:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B1D1C20940
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 22:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0928A6FCB;
	Sat, 14 Oct 2023 22:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EIR38c/0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A0926E03;
	Sat, 14 Oct 2023 22:33:55 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8DBC9;
	Sat, 14 Oct 2023 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FUesLxGaf581hyCU/oO5QVl54ygJcVL/TqZOPhOw+Kg=; b=EIR38c/09tTGi8EthdTUuS5UCn
	c/Iebo2wPpj3rX9SL3SoShu/VP5g2049zySax5NrDTVXM97aKXLCfthwnUDvx7Iq6+gQKFS09G4Ti
	8c335jLbU3zHltciMjszv6y+phPpLhB8HD3UI/YuDZl67J1JbeCAcKeYOFsMSNwjrydg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrnCZ-002CyO-7T; Sun, 15 Oct 2023 00:33:43 +0200
Date: Sun, 15 Oct 2023 00:33:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, boqun.feng@gmail.com,
	tmgross@umich.edu, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <033ba6cb-4132-4249-a867-3764fc65556e@lunn.ch>
References: <1da8acc8-ca48-49ae-8293-5e2a7ed86653@proton.me>
 <20231013.185348.94552909652217598.fujita.tomonori@gmail.com>
 <7e0803b4-33da-45b0-8b6b-8baff98a9593@proton.me>
 <20231013.195347.1300413508876421033.fujita.tomonori@gmail.com>
 <de903407-eb53-4d42-af5c-c019ace1b701@proton.me>
 <72a268b1-aabc-4d98-aba4-4d92c3f3dd21@lunn.ch>
 <c807ef34-3926-4284-ab18-b516c8af57c7@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c807ef34-3926-4284-ab18-b516c8af57c7@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 10:18:58PM +0000, Benno Lossin wrote:
> On 14.10.23 23:55, Andrew Lunn wrote:
> >>> The PHY driver asks the state from the abstractions then the
> >>> abstractions ask the state from PHYLIB. So when the abstractions get a
> >>> bad value from PHYLIB, the abstractions must return something to the
> >>> PHY driver. As I wrote, the abstractions return a random value or an
> >>> error. In either way, probably the system cannot continue.
> >>
> >> Sure then let the system BUG if it cannot continue. I think that
> >> allowing UB is worse than BUGing.
> > 
> > There is nothing a PHY driver can do which justifies calling BUG().
> 
> I was mostly replying to Tomonori's comment "In either way, probably
> the system cannot continue.". I think that defaulting the value to
> `PHY_ERROR` when it is out of range to be a lot better way of handling
> this.

You could actually call phy_error(phydev); That will set the state to
PHY_ERROR and transition the state machine to put the link down.

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy.c#L1213

Its not documented for this use case, its more intended for the
hardware has a problem, and stopped talking to us. But if phylib
itself is messed up, it would seem like a reasonable way to try to
recover. It will dump the stack as well.

	 Andrew

