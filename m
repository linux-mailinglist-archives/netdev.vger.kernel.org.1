Return-Path: <netdev+bounces-40226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9D67C642D
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 06:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DCC28254A
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 04:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647662B77F;
	Thu, 12 Oct 2023 04:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Qz3pmMhl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8D2B770
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 04:43:13 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274B3B7
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 21:43:12 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7c95b8d14so7429127b3.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 21:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1697085791; x=1697690591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hui30h64vLshR10fww6M29GXyrgaysgxLGB2PvuibEc=;
        b=Qz3pmMhlHKgUD156RMyk2aEFe8r0kxtFf0hGGWLXxwXyBtre7Wx845Jf9A6IKTV3Rb
         TEbXdmh0Gd4SuHHDqHJ8Mlv5TvlnxSlvDD2WjPW6X5B8tkwxK3jbUPWhbZ7PNa541Lt8
         z927giZLe891jupYOYsNJW1SqedjjNn7hJlZoy06p5MLERdEIDaTrrgdA5hFOG076PpB
         PHlbayiI4NanVrLjrfuE+Z74u9Q7hHO6QvOO8ibi991KtZ0p+r55NiqwN+qqKrXnERY3
         /pisb2LVjmhyn12AMip8YcWB3oTE/GBlND+CkZ9qGRVV0nkbn7663pueSPuyHArOujjc
         jzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697085791; x=1697690591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hui30h64vLshR10fww6M29GXyrgaysgxLGB2PvuibEc=;
        b=sHx1dw1sFCRprzXLjj8+LFGqPwMmC1w6KeCHnTIE9jPcpT4dpAx8hAiT5/anBNCCEF
         xUZUUH0V9fBXKTXnlKLRmCSjO1nGtIyf2ydVHyU4iKLDDtxWX8qZ8P1COifG8fs0XUFg
         u9gpruCQnTH6rRcVCr6yp2L87wS+WPjOoYQrAHdqZ2akrMrqmmgFlBB2Nk2+trySXsSf
         agp4PtTfaApNzd1KOGp409Zw5Pazc0YAzVTLEE8qk0UzO1KOpxDh2+rf1ovZloBKjJOd
         ZnYmomThI5rD9w5202UNzVJlGowej884KLx7sx18BuTDCTjLS0epuYNurL7J4BehpGRZ
         k6sg==
X-Gm-Message-State: AOJu0YzpsK3bU/JseG2DgKScW6ZhJ2NsyLNCsBltQF8utBmJFkIdEktL
	KAQC5OGCSJTfs9CQVNYWDfyMgmyNth9EPFE3E/zKcQ==
X-Google-Smtp-Source: AGHT+IG0MTgX8ps5XL9XkfzqsRAHc1xu4VNxAQgOTDwDMNCuPWR6u6zZnrnTJJBx4iMuGOvm7byosGXzHPNC/Ji5d1Y=
X-Received: by 2002:a81:71c2:0:b0:56d:43cb:da98 with SMTP id
 m185-20020a8171c2000000b0056d43cbda98mr24486370ywc.29.1697085791362; Wed, 11
 Oct 2023 21:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-2-fujita.tomonori@gmail.com> <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
 <20231012.125937.1346884503622296050.fujita.tomonori@gmail.com>
In-Reply-To: <20231012.125937.1346884503622296050.fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 12 Oct 2023 00:43:00 -0400
Message-ID: <CALNs47sAZNk4XRn4WMAbJeiYZwrzceqPJHZ7vi8SZYgVB_XSLA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, greg@kroah.com, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 11:59=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> >> +#![feature(const_maybe_uninit_zeroed)]
> >
> > The patch message should justify this addition and warn about it.
>
> I added the following to the commit log.
>
> This patch enables unstable const_maybe_uninit_zeroed feature for
> kernel crate to enable unsafe code to handle a constant value with
> uninitialized data. With the feature, the abstractions can initialize
> a phy_driver structure with zero easily; instead of initializing all
> the members by hand.

Maybe also link something about its stability confidence?
https://github.com/rust-lang/rust/pull/116218#issuecomment-1738534665

> >> +    /// Executes software reset the PHY via BMCR_RESET bit.
> >
> > Markdown missing (multiple instances).
>
> Can you elaborate?

BMCR_RESET -> `BMCR_RESET` I believe

> > +/// Represents the kernel's `struct mdio_device_id`.
> > +pub struct DeviceId {
> > +    /// Corresponds to `phy_id` in `struct mdio_device_id`.
> > +    pub id: u32,
> > +    mask: DeviceMask,
> > +}
>
> It would be nice to explain why the field is `pub`.

On this subject, I think it would be good to add

    impl DeviceId {
        #[doc(hidden)] // <- macro use only
        pub const fn as_mdio_device_id(&self) ->
bindings::mdio_device_id { /* ... */ }
    }

That makes more sense when creating the table, and `id` no longer has
to be public.

> > This patch could be split a bit too, but that is up to the maintainers.
>
> Yeah.

Maybe it would make sense to put the macro in its own commit when you
send the next version? That gets some attention on its own.

