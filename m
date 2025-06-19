Return-Path: <netdev+bounces-199540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 743B0AE0A8C
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE624188B100
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F47232386;
	Thu, 19 Jun 2025 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX2lXSM7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EFC1F0992;
	Thu, 19 Jun 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347036; cv=none; b=f9aCYvV+3+rD19uKL/dUi5COdw+2pdE3rfBaJbJohJo8ci4Ri5nszMcwR9wPdqmDPY4stOBTiL0eWPDFa1NbqoR88YHUv5zpOJE3ION6U8/WadALsahfz4nmeAKJLf4R7xfX58Tdd0YUjoD6lqBlS3aojb/eJRd4oibTIEymhuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347036; c=relaxed/simple;
	bh=0fh6espjLEjaSRFixnAFyJrhMUxNyl6iTTMErQ9uzuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibsKTEkkyZWEIMEi9xeYO2ybj2UtKWRHsVEDRbECE/Om3+duTXUGEGpsAhOFK8MYa52F/LKM3XaxUJ2D+MdMDD7URcobv8WSt2dXyst6F8dJZt9cV76pRuvxoGDUtOVdSWJHVKkr0WUvCzgs89xSPdg+5ZZ0GRm1u4/t+vI8RKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cX2lXSM7; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32934448e8bso7274931fa.3;
        Thu, 19 Jun 2025 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750347032; x=1750951832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fh6espjLEjaSRFixnAFyJrhMUxNyl6iTTMErQ9uzuM=;
        b=cX2lXSM7aTwSMfMs3W95qDh92hHXDtbZFr3VBD8dKj1LOCPv8Yz52xME0l+6lks53E
         fDf2Bp2z2VUK3h8RKalSPve7zPBK34axqws6Orc8pPDgCTF7j6CNgwlFIoaPiCnfVPlR
         U90qWM7lfG9w77imxzmc4Z40TyTbuP6gH33s83slIrtXh1djokNxOG0SxGs9s8MveVG9
         u3TpY7wRJHh9mJW+bxki07KdEg17WJMFmV7gryEwmTvw8VOCzcsG5Bn1iBKauRYhte3g
         1oCeDrS5gTw95vUNAr2rGSQLLEWI01DmMLxfUkBRQehcfrLsfRWrIsB6YyZ6BwNTwHUs
         fUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750347032; x=1750951832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fh6espjLEjaSRFixnAFyJrhMUxNyl6iTTMErQ9uzuM=;
        b=EVLoXqEhVKjNUZ8mIWpttyUfUgLmkVvVBYS8/tA4fJmQoMIWkiYsITtdqZywDZJn8G
         JhXoNVy7YuLO3dE9MuuF4CCUF4MX462ngzICDTN+jCD+Ex+UtqZPmxbdKE5K90ZEJZBX
         HtRII9k1nvU+shdvQ/X9w16jS177GSaNNIMVADo47Qq1wH7CIDieMLEb0knMixwZUG3d
         yiwTkU9Z/pasjxxkKdNV7VfgLfLFx5qydHj0OF5c5b0IQ9r++VvjpGE5oWa6+6OnhAwg
         8gHH73qMK5Dz8Jjh4pm9roRVO8vfTzJJ0ePsT1uimyTJ7ykw8LvsCVk7Yx2JKK5HF3IG
         PRxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI2eMw1+kDwIBtRdv8aNkRPODiWJO/oTd5puVkOPpqPjb7gs5QqTna7M/tlVKHLFVt4PpRhUy3imYbc//HkQA=@vger.kernel.org, AJvYcCX7f8IoXhXytrtF4Ro3g+gBkAiRPmAGMfvsqk4KteEI5Mt7T22ivhXVCTQgU+FX6AXmGb0DkjScQdruppo=@vger.kernel.org, AJvYcCXbFM2yUnyuhj+GYTZsV5GoU2wFkNj+pIe3ZS5FYnhN5GHQ8ghwDVx0GVDFxbe88kqLV0/AwWJC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7QDT3z1IKECvBaQMpQfOX7HV78ke3H+UL5TBhV7CECS8YccVd
	5ewNOUZic5SCg3f+LJ5Zj9wCbFOseNBSdc3tfpcGPXrAI01Wf5lgDyA1r1dhabKuaLa/rmDRe7I
	BaVsNyhxVxalAtQOGaoriI1F6JDC2EzQ=
X-Gm-Gg: ASbGncsdFyKSe0+/GWF1USEqQI1GMGX4Zud9Frzrt0Re7qkvxTODH/yk4R2VRrOhR2f
	kqR6wDk9Hi/Vn4MobVPhHzChMs6Cly5KUCV1pgq5Q8OVL2spHBU55wfft/5SSI7Dn1dwzf1zfj0
	nVm3Iqx9pBgmauQyXQxx5jzMYauHFCXSz8ZBdUAqplJbAZcPqnfNPb4qEtL4ap/HzWpP0PFikLW
	lM39g==
X-Google-Smtp-Source: AGHT+IEXr6azp2lqbz2V07vRRqpBRe93raFjyVRuV54TirHOCDGMlRMEsS69LHfBi6gvsXCGK2cP39x7vOem4Owyg5s=
X-Received: by 2002:a2e:bc09:0:b0:32a:714c:12d1 with SMTP id
 38308e7fff4ca-32b4a0c589emr78876511fa.1.1750347032146; Thu, 19 Jun 2025
 08:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-correct-type-cast-v1-1-06c1cf970727@gmail.com>
 <CAH5fLghomO3znaj14ZSR9FeJSTAtJhLjR=fNdmSQ0MJdO+NfjQ@mail.gmail.com>
 <CAJ-ks9m837aTYsS9Qd8bC0_abE_GT9TZUDZbbPnpyOtgrF9Ehw@mail.gmail.com>
 <20250612.094805.256395171864740471.fujita.tomonori@gmail.com> <CAJ-ks9nXwBMNcZLK1uJB=qJk8KsOF7q8nYZC6qANboxmT8qFFA@mail.gmail.com>
In-Reply-To: <CAJ-ks9nXwBMNcZLK1uJB=qJk8KsOF7q8nYZC6qANboxmT8qFFA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 19 Jun 2025 11:29:56 -0400
X-Gm-Features: AX0GCFsBqf-jctJWEanUNO6z5_EE5XXc7yZHCIBnhnkF2fuMrthooPQ_awMNjdg
Message-ID: <CAJ-ks9mazp=gSqDEzUuh0eTvj6pBET-z2zz7XQzmu9at=4V03A@mail.gmail.com>
Subject: Re: [PATCH] rust: cast to the proper type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	dakr@kernel.org, davem@davemloft.net, andrew@lunn.ch, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 8:54=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Wed, Jun 11, 2025 at 8:48=E2=80=AFPM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> >
> > On Wed, 11 Jun 2025 09:30:46 -0400
> > Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > > On Wed, Jun 11, 2025 at 7:42=E2=80=AFAM Alice Ryhl <aliceryhl@google.=
com> wrote:
> > >>
> > >> On Wed, Jun 11, 2025 at 12:28=E2=80=AFPM Tamir Duberstein <tamird@gm=
ail.com> wrote:
> > >> >
> > >> > Use the ffi type rather than the resolved underlying type.
> > >> >
> > >> > Fixes: f20fd5449ada ("rust: core abstractions for network PHY driv=
ers")
> > >>
> > >> Does this need to be backported? If not, I wouldn't include a Fixes =
tag.
> > >
> > > I'm fine with omitting it. I wanted to leave a breadcrumb to the
> > > commit that introduced the current code.
> >
> > I also don't think this tag is necessary because this is not a bug
> > fix. And since this tag points to the file's initial commit, I don't
> > think it's particularly useful.
>
> Would you be OK stripping the tag on apply, or would you like me to send =
v2?

Hi Tomo, gentle ping here. Does this look reasonable to you, with the
Fixes tag stripped on apply?

