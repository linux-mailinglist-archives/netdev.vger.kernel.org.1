Return-Path: <netdev+bounces-114867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E091944779
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D688A1F26659
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BB816F91D;
	Thu,  1 Aug 2024 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWBefl6u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838E163A9B
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503255; cv=none; b=iV2S9lf2qF26cmzBm0MpJGRdWQnpzoTuwhycjmcWz7lpgT3bYLUk3sED5gb5pPvD4Z/SGHtOTvNFhqPlt0zJooY5AlmwiuKv/CNC24SKw9llKAnaFLP4L8pkyXYad/qvONYWwC498oGSvmKPrOAJkO9ccufvgVWMflC8IkIFBMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503255; c=relaxed/simple;
	bh=PbzCpt9LVzUIp3dPDBp7/+rl+oeX8NSlECmbYAM+Qhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMPmVG3cRRYVtr96iaDa3kp2AMLLe4Izt9xAVVQN2/RYUf5EomeMA7+nlDmryPzHOlWABMIR3R5UOsy0sc8sJ9AvjYQD0X9X5FawY0vvO93N59O8OhlmdiaXUjKNM0Y7K48+cTkW3g8VPqGFgIqIKVHmM5PXodJZibTQqUVtl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JWBefl6u; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-369c609d0c7so4591780f8f.3
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 02:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722503252; x=1723108052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cITLfcdMgmNjjc18PVtnS6F53c3+dbjdEEoiQ1eEiJg=;
        b=JWBefl6uBqLwUyJBQGidImSUgSEOhZyVyT49iU+kMF9lvBcVoaZhbWf1KGpzkr7Rhe
         JvSu8dd7u7k4o2Oqtj8wd9X8iUgBvDuhoPTCxHsYBIowceEFWSNaYqYshNs/AppB67JE
         3WRtOzFRU8tri3IaFSoFlT5YtCVOVtWUmuO/LrWPRgJ0u9M0S2GHVgeQDbDq9Lg1E+X1
         dX+S6ld3Of0YtWVTeORJ+hacBB10+16ZQOZ8Fkx5FQCWej6RiQ48ejrtcQHoyn3hCfMj
         MtxrY/fbWCYncFvnotFfjr7co+bJMdkyDIHB9GYL1LFZY9bZ8A2TzvWFzt+jVWhRQwFa
         cHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722503252; x=1723108052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cITLfcdMgmNjjc18PVtnS6F53c3+dbjdEEoiQ1eEiJg=;
        b=U/np3WPyfsr6DcSDP1+JbrGjipkfB0ilW0yCKnPy/goWzIAtjQnY+xHKNW2LB4D4Ut
         cg16V3qIt6JNo5LuOJqoj2L6Qwu/+TKLmF+9BxlTOyBIjR8ysi98s+eiV6ljozRigZae
         bBAr9/XPvPO4vfpK5u8vTFx1Fz14w3fVVx+bC9ZoR+XBVqn24A98MIv2KljtBZ85XZ8L
         GH2kpJt2mnSokyGZFbgIROmO70yRDOTjT8wFQWeZMe8e2QrASiCMbEUyCRUHa61TOM9s
         YEvrjY3Z+noZiY9BzWPoK0qExYg8WLOWK0AvuTRKCCn9KpoRGFH+CpDvA9cxO6KntL9N
         IlrA==
X-Forwarded-Encrypted: i=1; AJvYcCW3F3BI+RNjNrPc/XeJu21VpCvBjLjIuR3gP6nEbBIjrroZA4ZulakKLQ7F6wrVDLCSMUK3rhr3j9HePs7eX5vDM3pi/urO
X-Gm-Message-State: AOJu0YxuH9psjCShZOOFztP9zFrtUGt2n0heatxO5cvRmfXbQaVjg3nt
	Q9n9OpuETlrviCgcwlG/kKPWPQPeQ2w3m6pvYq+pYuLgE7WwiHLPAsuvzjsdx7Wunco2TGDIzxe
	5dSzk4IhDoqX3kiulViufUOp7mEZKlIWUVMZC
X-Google-Smtp-Source: AGHT+IFg0425wG8tg10zQOge2v6HXsK5b2h/IkKi5JoSLLLUh0Z+xRclV2mJj2hnWLYleP7WVQpzPa0zG2iQlcNPif8=
X-Received: by 2002:adf:eb10:0:b0:362:4f55:6c43 with SMTP id
 ffacd0b85a97d-36baa9f713bmr1730350f8f.0.1722503251987; Thu, 01 Aug 2024
 02:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731042136.201327-3-fujita.tomonori@gmail.com>
 <5525a61c-01b7-4032-97ee-4997b19979ad@lunn.ch> <CAH5fLggyhvEhQL_VWdd38QyFuegPY5mXY_J-jZrh9w8=WPb2Vg@mail.gmail.com>
 <20240801.091708.676650759968461334.fujita.tomonori@gmail.com>
In-Reply-To: <20240801.091708.676650759968461334.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 11:07:18 +0200
Message-ID: <CAH5fLgj05_rZ=MnRhqUMnthLKioiXJ9xvMAtHyc3-MzNcfbkBg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/6] rust: net::phy support probe callback
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:17=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Thanks for the review!
>
> On Wed, 31 Jul 2024 14:32:18 +0200
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> >> > +    /// # Safety
> >> > +    ///
> >> > +    /// `phydev` must be passed by the corresponding callback in `p=
hy_driver`.
> >> > +    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_=
device) -> core::ffi::c_int {
> >> > +        from_result(|| {
> >> > +            // SAFETY: This callback is called only in contexts
> >> > +            // where we can exclusively access to `phy_device`, so =
the accessors on
> >> > +            // `Device` are okay to call.
> >>
> >> This one is slightly different to other callbacks. probe is called
> >> without the mutex. Instead, probe is called before the device is
> >> published. So the comment is correct, but given how important Rust
> >> people take these SAFETY comments, maybe it should indicate it is
> >> different to others?
> >
> > Interesting. Given that we don't hold the mutex, does that mean that
> > some of the methods on Device are not safe to call in this context? Or
> > is there something else that makes it okay to call them despite not
> > holding the mutex?
>
> Before the callback, the device object was initialized properly by
> PHYLIB and no concurrent access so all the methods can be called
> safely (no kernel panic), I think.
>
> If the safety comment needs to updated, how about the following?
>
> SAFETY: This callback is called only in contexts where we can
> exclusively access to `phy_device` because it's not published yet, so
> the accessors on `Device` are okay to call.

Yes, that sounds good to me. With the updated safety comment, feel
free to include my Reviewed-by in your next version.

Alice

