Return-Path: <netdev+bounces-88161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1E18A61AF
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 05:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4B61C209A8
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 03:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272DB17984;
	Tue, 16 Apr 2024 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Mxb7aFqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B8B12E4A
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237937; cv=none; b=A2LPgv0YWhofBfzT1wBUV9IlYVyX7J4FwogdCL4iIuV/DKzakBOZTVOL5hy8C6u6LFM++7NMIHYrn+NWT6EclwAPlrEnPm0JpscozUzARxpxvwyfuzDtoYbu6c6Yhl89I7Ug+oJjK9194Ou3cxLBMxX4xJYiuSNA5BHXZ+IEWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237937; c=relaxed/simple;
	bh=5u4IqC43ipuEAkRDPZ3NfLs9iokoA9eSZLj0W4K46TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hgfc4NaFE6Io434V5+ueQ0ljj6Trz5EzaBIE8vxvL7NX4zlk5zVykypu4g76ydCb6G2QmOYfyh5dkvHu9qi//7dHk2eY6ASuERw00BSkKYYu5GqS4mszyJzd7HylneLJBcoLH0BafY7N8WyurYax5/DZj86N93kgtv0V88MT4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Mxb7aFqO; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61ab6faf179so25519007b3.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 20:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1713237934; x=1713842734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zkw2Yl+TD51SHy98hT0iftYNGABYn450n8OBsTQ7BwM=;
        b=Mxb7aFqO8AKszE+R90/4IPgzsqP441iXHA3l8QyanBTq5MNNo4b5lVWQvAGtHm1vaE
         M+yZpaDvPBHAg6yUY9IuyjJgVwqliW8yOg3zMybkXWx1Dw0tR9TpPisnpLmNt8YjDeI+
         bjQVv1PeJCWjCG55VOQ6yZO68uOUpu4b85l9Pi/ObKMmEMFlmJEs3eANOjIq+P19n6Wc
         VdKBYV8lGoEJdi4XQU80r/xGazX+MXDlwUdTq0Iu69OV4PVwvQ7yBugN+dPhOmhI/5pL
         hI5ZnYI8ls5sZyYWCqjf3qshoiPuyxFc8wTtPZ/Awp9258kjINc2qlASlk2nPm5bI01P
         Zrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713237934; x=1713842734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zkw2Yl+TD51SHy98hT0iftYNGABYn450n8OBsTQ7BwM=;
        b=BoWuks6nmlx97PUPsMoKCvclPxSqb+xfhvHuGsaTd3q4hSOKUq8hWxxtJhBGqDlNeW
         VHMF74bx3JX7Od4uqOfQI7rlYgAUoAmvTgkdNDwpBV4ys9SFoQ/CLH1CxNhiIRgObCxR
         pSrAA7dRmp9Qw0Rx2zVigA3UBLB2pZmVAbwlIM/vLhOQK57vG9GcJo+EEIZljM6cgVuW
         rflC8uBkrj5SJ7TImH20pg4+DTSBOYRu+rXuxnB2QFAC1MZPoa3ayxWWTQ2q6YV4gZf5
         H3Gz7colu0N3sh8augwZJFr8vWb4BaRDE+dhyxWX8jtGrKiwdxeskMKWPKG1WSBQTtJz
         /lUQ==
X-Gm-Message-State: AOJu0YwzU2pOFQN2v280re2UUDzaOesU/QUV/j8twe7AABqIja5Qr2jF
	E46yL4jIDMDZSUt8toCFcHsWWLDqfWOqSd/P48Uhsk3hXY06OZuH7Kz4KCT69XQi2mGP4ezmpv1
	GUMryFvYjPRgeS6gOpaLZkwAhjE9+IJfaD54v1pylp3Uob8tO
X-Google-Smtp-Source: AGHT+IFrJmLvi4vRnX1dZLLLS6KxyIa1VK1FW7aBEzzN9FjDmlgBrihG8RGfeBlVCkeDRH95ozQmE17XCXQJkP5TV6M=
X-Received: by 2002:a25:7455:0:b0:dcc:97e4:bc61 with SMTP id
 p82-20020a257455000000b00dcc97e4bc61mr11960479ybc.57.1713237933834; Mon, 15
 Apr 2024 20:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415104701.4772-1-fujita.tomonori@gmail.com> <20240415104701.4772-3-fujita.tomonori@gmail.com>
In-Reply-To: <20240415104701.4772-3-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 15 Apr 2024 23:25:22 -0400
Message-ID: <CALNs47t0FDS59xckUV0QkozbX-RAs8U3woN_sBc0TVm8d=dKNA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/4] rust: net::phy support C45 helpers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:47=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
> +    /// Reads a given C45 PHY register.
> +    /// This function reads a hardware register and updates the stats so=
 takes `&mut self`.
> +    pub fn c45_read(&mut self, devad: u8, regnum: u16) -> Result<u16> {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So it's just an FFI call.

Depending on the response to Andrew's notes, these SAFETY comments
will probably need to be updated to say why we know C45 is supported.

> +        let ret =3D unsafe {
> +            bindings::mdiobus_c45_read(
> +                (*phydev).mdio.bus,
> +                (*phydev).mdio.addr,
> +                devad as i32,

This could probably also be from/.into()

> +                regnum.into(),
> +            )
> +        };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u16)
> +        }

Could this be simplified with to_result?

> +    }
> +
> +    /// Writes a given C45 PHY register.
> +    pub fn c45_write(&mut self, devad: u8, regnum: u16, val: u16) -> Res=
ult {
> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So it's just an FFI call.
> +        to_result(unsafe {
> +            bindings::mdiobus_c45_write(
> +                (*phydev).mdio.bus,
> +                (*phydev).mdio.addr,
> +                devad as i32,

Same as above

> +                regnum.into(),
> +                val,
> +            )
> +        })
> +    }
> +

