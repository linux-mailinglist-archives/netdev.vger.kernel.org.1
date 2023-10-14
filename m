Return-Path: <netdev+bounces-41045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8485E7C9698
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 23:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D002811E3
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 21:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76F266AC;
	Sat, 14 Oct 2023 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yAEVrqcI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ADD262A3;
	Sat, 14 Oct 2023 21:55:53 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9A5C9;
	Sat, 14 Oct 2023 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ojjdNFWR96paowz1+U1nfC2WpfuymGA4Tbws0uysQW8=; b=yAEVrqcITpTCcXQumUGM3kd2T2
	fnWAtVS7EqLXYbQF7CbuMGLkBiCibvHKtG+AKgbY/udW7MOnW3xrb5CDsxJxdclfERjm7eZ/jd5or
	R4mRnqjkosB1IiAnIL+yu5dg6uCv5bL6OhOif3uhbLCgOiG3LyX/l83C4d6KltwH1PdE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrmbs-002CmB-EK; Sat, 14 Oct 2023 23:55:48 +0200
Date: Sat, 14 Oct 2023 23:55:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, boqun.feng@gmail.com,
	tmgross@umich.edu, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <72a268b1-aabc-4d98-aba4-4d92c3f3dd21@lunn.ch>
References: <1da8acc8-ca48-49ae-8293-5e2a7ed86653@proton.me>
 <20231013.185348.94552909652217598.fujita.tomonori@gmail.com>
 <7e0803b4-33da-45b0-8b6b-8baff98a9593@proton.me>
 <20231013.195347.1300413508876421033.fujita.tomonori@gmail.com>
 <de903407-eb53-4d42-af5c-c019ace1b701@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de903407-eb53-4d42-af5c-c019ace1b701@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > The PHY driver asks the state from the abstractions then the
> > abstractions ask the state from PHYLIB. So when the abstractions get a
> > bad value from PHYLIB, the abstractions must return something to the
> > PHY driver. As I wrote, the abstractions return a random value or an
> > error. In either way, probably the system cannot continue.
> 
> Sure then let the system BUG if it cannot continue. I think that
> allowing UB is worse than BUGing.

There is nothing a PHY driver can do which justifies calling BUG().

BUG() indicates the system is totally messed up, and running further
is going to result in more file system corruption, causing more data
loss, so we need to stop the machine immediately.

Anyway, we are talking about this bit of code in the C driver:

        /* Reset PHY, otherwise MII_LPA will provide outdated information.
         * This issue is reproducible only with some link partner PHYs
         */
        if (phydev->state == PHY_NOLINK) {
                phy_init_hw(phydev);
                _phy_start_aneg(phydev);
        }

and what we should do if phydev->state is not one of the values
defined in enum phy_state, but is actually 42. The system will
continue, but it could be that the hardware reports the wrong value
for LPA, the Link Partner Advertisement. That is not critical
information, the link is likely to work, but the debug tool ethtool(1)
will report the wrong value.

Can we turn this UB into DB? I guess you can make the abstraction
accept any value, validate it against the values in enum phy_state, do
a WARN_ON_ONCE() if its not valid so we get a stack trace, and pass
the value on. Life will likely continue, hopefully somebody will
report the stack trace, and we can try to figure out what went wrong.

  Andrew

