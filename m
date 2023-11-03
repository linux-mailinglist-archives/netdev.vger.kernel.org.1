Return-Path: <netdev+bounces-45923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B087E0703
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC63A1C20FFA
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABC61D55E;
	Fri,  3 Nov 2023 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6Ysm8k5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB31D550;
	Fri,  3 Nov 2023 16:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D36C433C8;
	Fri,  3 Nov 2023 16:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699030370;
	bh=K+AWM+g16f6TCciCdpbXKjq6QoLeLnYSS3177Re7WV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6Ysm8k5ChAO4XemOmOjhx9P0UbJw0BMp0ENkfORfw5NRHEekqQaJd7TFZoo6in+x
	 wZfcV8AXyYRDO09LmHJ1wT3uD+TZqOcq1Cft9zsdPRczvnLbTgdLo5seaCo2+rigEB
	 A+GSiqQS72v8NqsI9xYC6knPh/f69Wv5OGfcCqlNvzh38myv1Jy7RdUgyFjEslGuWp
	 25aVjx+5ESBWJ50qXJJ8NMDOWxQHH87ajElQz4o/UOcXW94/uP5EbatmzsfCpDL5d/
	 6HJyC0PhsBW5sEbRuueMbs9O9FFLs5x8fH2IDgex7HgVepCW8rCsGW58IjvM0O51cG
	 4KUcmoLelgtyQ==
Date: Fri, 3 Nov 2023 16:52:44 +0000
From: Simon Horman <horms@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>,
	Edward Hill <ecgh@chromium.org>,
	Laura Nao <laura.nao@collabora.com>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	Grant Grundler <grundler@chromium.org>,
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 8/8] r8152: Block future register access if register
 access fails
Message-ID: <20231103165244.GB714036@kernel.org>
References: <20231020210751.3415723-1-dianders@chromium.org>
 <20231020140655.v5.8.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
 <20231025162824.GK57304@kernel.org>
 <CAD=FV=XVJVkyA09Ca_YGa5xRS4jGra4cw-6ArgwCekMzn7uWcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XVJVkyA09Ca_YGa5xRS4jGra4cw-6ArgwCekMzn7uWcA@mail.gmail.com>

On Wed, Oct 25, 2023 at 01:24:55PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Oct 25, 2023 at 9:28 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Fri, Oct 20, 2023 at 02:06:59PM -0700, Douglas Anderson wrote:
> >
> > ...
> >
> > > @@ -9603,25 +9713,14 @@ static bool rtl8152_supports_lenovo_macpassthru(struct usb_device *udev)
> > >       return 0;
> > >  }
> > >
> > > -static int rtl8152_probe(struct usb_interface *intf,
> > > -                      const struct usb_device_id *id)
> > > +static int rtl8152_probe_once(struct usb_interface *intf,
> > > +                           const struct usb_device_id *id, u8 version)
> > >  {
> > >       struct usb_device *udev = interface_to_usbdev(intf);
> > >       struct r8152 *tp;
> > >       struct net_device *netdev;
> > > -     u8 version;
> > >       int ret;
> > >
> > > -     if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
> > > -             return -ENODEV;
> > > -
> > > -     if (!rtl_check_vendor_ok(intf))
> > > -             return -ENODEV;
> > > -
> > > -     version = rtl8152_get_version(intf);
> > > -     if (version == RTL_VER_UNKNOWN)
> > > -             return -ENODEV;
> > > -
> > >       usb_reset_device(udev);
> > >       netdev = alloc_etherdev(sizeof(struct r8152));
> > >       if (!netdev) {
> > > @@ -9784,10 +9883,20 @@ static int rtl8152_probe(struct usb_interface *intf,
> > >       else
> > >               device_set_wakeup_enable(&udev->dev, false);
> > >
> > > +     /* If we saw a control transfer error while probing then we may
> > > +      * want to try probe() again. Consider this an error.
> > > +      */
> > > +     if (test_bit(PROBE_SHOULD_RETRY, &tp->flags))
> > > +             goto out2;
> >
> > Sorry for being a bit slow here, but if this is an error condition,
> > sould ret be set to an error value?
> >
> > As flagged by Smatch.
> 
> Thanks for the note. I think we're OK, though. If you look at the
> "out:" label, which is right after "out1" it tests for the same bit.
> That will set "ret = -EAGAIN" for us.

Thanks, and sorry for being even slower than the previous time.
I see your point regarding "out:" and agree that the code is correct.

> I'll admit it probably violates the principle of least astonishment,
> but there's a method to my madness. Specifically:
> 
> a) We need a test here to make sure we don't return "success" if the
> bit is set. The driver doesn't error check for success when it
> modifies HW registers so it might _thnk_ it was successful but still
> have this bit set. ...so we need this check right before we return
> "success".
> 
> b) We also need to test for this bit if we're in the error handling
> code. Even though the driver doesn't check for success in lots of
> places, there still could be some places that notice an error. It may
> return any kind of error here, so we need to override it to -EAGAIN.
> 
> ...so I just set "ret = -EAGAIN" in one place.
> 
> Does that make sense? If you want to submit a patch adjusting the
> comment to make this more obvious, I'm happy to review it.

Thanks it does make sense.
And I don't think any further action is required.

