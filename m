Return-Path: <netdev+bounces-38794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E88A7BC86D
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 16:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10F1281DF3
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162BF28E0E;
	Sat,  7 Oct 2023 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4259V6/x"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CACE1D6AF;
	Sat,  7 Oct 2023 14:48:01 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4026FB9;
	Sat,  7 Oct 2023 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mhXFaHuS2j0fqNHfQmC4j72FTsL7wOUo9d74uHVqouw=; b=4259V6/xAJMaC4niT4y7Fo4AJu
	vguxFVOMngyaZUGQFyxY59mxNJpWNHd2KdXsPI5Gv56uLgT8H9ALUJYu1MpB7vEEzveFhdJ/Siv0h
	o8Z9UtNPLWJlnS1A0Qc7gQLozr8u5go1drI+6reaG6ue/huEDLq2B989eY6eE/pTVIrQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qp8ax-000JjX-8j; Sat, 07 Oct 2023 16:47:55 +0200
Date: Sat, 7 Oct 2023 16:47:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Trevor Gross <tmgross@umich.edu>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
Message-ID: <96800001-5d19-4b48-b43e-0cfbeccb48c1@lunn.ch>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
 <20231006094911.3305152-2-fujita.tomonori@gmail.com>
 <CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > +    /// Sets the speed of the PHY.
> > +    pub fn set_speed(&mut self, speed: u32) {
> > +        let phydev = self.0.get();
> > +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> > +        unsafe { (*phydev).speed = speed as i32 };
> > +    }
> 
> Since we're taking user input, it probably doesn't hurt to do some
> sort of sanity check rather than casting. Maybe warn once then return
> the biggest nowrapping value

After reading the thread, we first have a terminology problem. In the
kernel world, 'user input' generally means from user space. And user
space should never be trusted, but user space should also not be
allowed to bring the system to its knees. Return -EINVAL to userspace
is the correct thing to do and keep going. Don't do a kernel splat
because the user passed 42 as a speed, not 10.

However, what Trevor was meaning is that whoever called set_speed()
passed an invalid value. But what are valid values?

We have this file which devices the KAPI
https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ethtool.h#L1883

says:

/* The forced speed, in units of 1Mb. All values 0 to INT_MAX are legal.

and we also have

#define SPEED_UNKNOWN		-1

and there is a handy little helper:

static inline int ethtool_validate_speed(__u32 speed)
{
	return speed <= INT_MAX || speed == (__u32)SPEED_UNKNOWN;
}

so if you want to validate speed, call this helper.

However, this is a kernel driver, and we generally trust kernel
drivers. There is not much we can do except trust them. And passing an
invalid speed here is very unlikely to cause the kernel to explode
sometime later.

   Andrew

