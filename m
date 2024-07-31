Return-Path: <netdev+bounces-114562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C388E942E73
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B331F27409
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D031AED46;
	Wed, 31 Jul 2024 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GaoMDsv4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B11AE868
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429154; cv=none; b=dxu+853A0yL1flB4JAtU3d1Y2/zyijquWROS50bWXTFlcsd5MXv5JsP6g3NEnA8aJwsCmKTLGJZNPH36cDtM7Qiyp+pOGL3rfIMdYh1RltwNsVpf5ot1cU10V9eYo8XM6XmSDzhhIv96y6KQqyclgdFGP8oL2DDZDfOwRVjatDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429154; c=relaxed/simple;
	bh=MwaNTINU5yNJHsK2cvcCHlH+LXU0hr3BxeGPsxPkIUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSCc9jr+50CACnzi6lhdTg/gpSr573LG5eV6TG1l30Fu3VbyDk87y+huO69zJaA7PR+KAEhaAgwXIF5lf99T4YSDCF32gi3o3gUCKeguerwCcV6V7eYKCrrWj8153jIEtXlabAg5v3nH5B5C16E1hd8XkX1sw5D/J5MsTfK/Y8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GaoMDsv4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f149845d81so20032211fa.0
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722429151; x=1723033951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJ52IHoyhMVMwGPGB7z4wpPXfYtiJoUyPXm23E4PR/Y=;
        b=GaoMDsv4n597nZMOHMgKm2lFxKeu7Cx55dF/VsiUSX0JZ7b9dPxxayEkq/yGWKkSs9
         xrW6ZWuSaIfbID8VL61qOAnOX/qjAPeEqjU/k6gFtJAMPxm0AyWEkciv9mjGGQ4t8w5m
         QCvcZBnhXtWrx0Vvsqg8i/+ceb3opZ383A7PZUnJHkdTD8YAvQj6FDeeMqDibKEM4fl1
         5Z93lRQvROs/uZRUc8P/V0M5qyEAkCNGsiwrimoa6mxESLzRyNq9CcWJsd9t8rWPHmhU
         fs/GdbCpDubmmTJKKmSNZDdL/CDaq/XBdyYonwMi+dE6dWb5fFSFWUMUrbnsS6rzHOOY
         oxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722429151; x=1723033951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJ52IHoyhMVMwGPGB7z4wpPXfYtiJoUyPXm23E4PR/Y=;
        b=LKDv/A5g3IjkDfnTz2jYOxflSFNNw1L/vpP8gTcaiiKlj2Mz7aByGG3K44C2nLzFxf
         1q5XD08HTJBXFdssyldRVJaC8+QMhGmtrIegDBEClrCNm0eiDn2gXdmGZaJWkN3mdudI
         Azyi/nYL3jEpRaD06Q5r3kAJGtG5Au/2B512Rgz63SFV6zb8bOPj/IPfy/f37Bma1KQh
         /C4T1cr/QQ8hwQFQzh6Ob4q7DaaptWNQVKWFlAj7/SW6sjAvCjG0tO/B5uS7ChwH3fBz
         gmphKUwWMiYUJecyIyZpjKHxJw83yC/LXvg3JItZWCNHSVvhxX21F1U4VUmPhFAIqn9b
         NbAw==
X-Forwarded-Encrypted: i=1; AJvYcCWzXmzGW5if9vuydR5+Z1GXjEZLWt9SnI63mrEcw4+ifSMCRCPw2MtjHwXxOnyuqDtm/PlFKGiVKQM2xLoVdgu+myWWHJ/e
X-Gm-Message-State: AOJu0YyWy56LoswM/6IxzIEGg3u+VqRi4AKnCmQ8l2g4x4kSzO0m6ZQg
	ViAcNdbLaMzL4s/vIrIVlCm8CUpgO69mRXn80t+MTxJaP7qSizjG3dRF6kYlXGZqPn078+2KQXq
	Oi0J3xr56ZHkzFQ3RVuF6paq6GMfW0gPlJ0u0
X-Google-Smtp-Source: AGHT+IFtG8Fpk/KvUPSdBmnaItGH5Rs2aE8gAAgzPSnfE88Taj+503TkDbrBojim9AWUwIzOd5exXLv8Se5cqymtwu4=
X-Received: by 2002:a2e:2281:0:b0:2ec:617b:4757 with SMTP id
 38308e7fff4ca-2f12ee074c2mr94644591fa.13.1722429150885; Wed, 31 Jul 2024
 05:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731042136.201327-1-fujita.tomonori@gmail.com>
 <20240731042136.201327-3-fujita.tomonori@gmail.com> <5525a61c-01b7-4032-97ee-4997b19979ad@lunn.ch>
In-Reply-To: <5525a61c-01b7-4032-97ee-4997b19979ad@lunn.ch>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 31 Jul 2024 14:32:18 +0200
Message-ID: <CAH5fLggyhvEhQL_VWdd38QyFuegPY5mXY_J-jZrh9w8=WPb2Vg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/6] rust: net::phy support probe callback
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:24=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Jul 31, 2024 at 01:21:32PM +0900, FUJITA Tomonori wrote:
> > Support phy_driver probe callback, used to set up device-specific
> > structures.
> >
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > ---
> >  rust/kernel/net/phy.rs | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> > index fd40b703d224..99a142348a34 100644
> > --- a/rust/kernel/net/phy.rs
> > +++ b/rust/kernel/net/phy.rs
> > @@ -338,6 +338,20 @@ impl<T: Driver> Adapter<T> {
> >          })
> >      }
> >
> > +    /// # Safety
> > +    ///
> > +    /// `phydev` must be passed by the corresponding callback in `phy_=
driver`.
> > +    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_dev=
ice) -> core::ffi::c_int {
> > +        from_result(|| {
> > +            // SAFETY: This callback is called only in contexts
> > +            // where we can exclusively access to `phy_device`, so the=
 accessors on
> > +            // `Device` are okay to call.
>
> This one is slightly different to other callbacks. probe is called
> without the mutex. Instead, probe is called before the device is
> published. So the comment is correct, but given how important Rust
> people take these SAFETY comments, maybe it should indicate it is
> different to others?

Interesting. Given that we don't hold the mutex, does that mean that
some of the methods on Device are not safe to call in this context? Or
is there something else that makes it okay to call them despite not
holding the mutex?

Alice

