Return-Path: <netdev+bounces-199630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7314AE100B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 01:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7679B1BC3B64
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 23:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E6028DB5C;
	Thu, 19 Jun 2025 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4Y0oaeo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB5E30E826;
	Thu, 19 Jun 2025 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375493; cv=none; b=fVnuuYlFkpucctV7o+iWSnYdUJ7DMKO8djS+mAMeSnlkZmgPIUokxNOMgmbqxwPqOlUU9ZW4ZA5LS78Y9tGCYnaEjpSu57zfTbVhAqMDchFTNdsAJE0rNxt2q5kTUSdhVL0OrTOmVctQS+oklIqjmd4F1rjh2xWeEleXjUcbeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375493; c=relaxed/simple;
	bh=WSkZDcYdQ71AgEyPhWUL2CdMzVGkRzsDFG6pJJ9m7KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0c/B839/1oo8c9/eckTpilQ252uXHgsqwInbRNnk7iYPp5WR2UcQYDCk/afjwaprRiJMRrT9VX9mNdwsPhA8DoE9PBwb0DyYVX1cCvjemm1GL9GTFXGShQDdPsX+hF/xzR2twDW5OQTKsnDr6mPXO6NbXdVtbNhtZ15iLwC+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4Y0oaeo; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32b7fd20f99so13087511fa.0;
        Thu, 19 Jun 2025 16:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750375490; x=1750980290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSkZDcYdQ71AgEyPhWUL2CdMzVGkRzsDFG6pJJ9m7KU=;
        b=S4Y0oaeoR7ykzTsvl6S0j6TiPDpPiGt3uRbMFyY2dSMSUU4h0iIncYwVBTCQwUnXYv
         Aw+TSp3PTKbQULyaBT4RxY/ut8a1f1VcdTiuiwV3TcgT6MPE9HeXAtFreEoZQ2jLdQIW
         QrpNwyC7NqH79Cklf6RqQTeK00DQDFmE20fOiqqIGe2DxMSaGWNpHaTMUbtF0JzK8jHq
         6k5pR6RrPPEbhtgeBGPew5C7w1doWntCoYYtkwYyZlRsWaihsV08VHSH57RUkt/wuHHj
         T1Uisty1zpwH1pz8LaLbVje8hf9qwkbGkxKz90bmbo1Zi02SB31mHuoXrEVxHmr6Tp3A
         IKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750375490; x=1750980290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSkZDcYdQ71AgEyPhWUL2CdMzVGkRzsDFG6pJJ9m7KU=;
        b=Mra+Er0xcx8sEh6IywHollQaH92H87+sOigMc2txGfSFNLK+zeSh6JlhxMxIcOvL14
         /JSicmlJZe8BUMeDe0LlAUi4durzcsM9O3rqpzoYnSoLfpHC0y+XV5MGr3U9adRcrrft
         fui7jhwuDxIoWpEBy6qq50UVEESJMp+4BbxsjcRjmeQP1Qb3L1HhjgOxWE0iRfRXTjej
         37ZwyYThX1pRPM9H1jaTMWF/Z+CpL6JnEcE0ofFVAHRAqJexs75z6Cu68UV/W52iZDhq
         QXThP/LsphS+MzQ/ZaDtSacAjJjH77/1SPPWJgbjV9j3YqK6FVxHIYW/coLhCTvT0st1
         lwdA==
X-Forwarded-Encrypted: i=1; AJvYcCURjmT1USw4MsB53qixGBa1nJmwEWAvB3B1WpEKkUx7RAmQk9XLMnLG0EN9YMB2VQ+6Mz3vXXGlPZRkgKElqCI=@vger.kernel.org, AJvYcCX9ku8bFf8T7Xps3Z4wI41/CT/xfv/OeVeKpStJZZz0eQPlA7MFxkpLOGrcpu2qGWvnmmWvuHN0@vger.kernel.org, AJvYcCXXk4TPbRRZFkCHarwmwJSdRzVt34Bo2H8xOTufUGq6rCsuCiTVWYCibGSPszyXuhf6yHARGAxpMcixiBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0+2feK9woEB5pAzPgAlGc3tORDqPcA6KFNsDXPALXVJbeLvg
	JjcSVHk/awp8ctc+9JR1M3/V7jJ6QlSqte4YqfYdE/iZwzDz0R0pRNWXNj99BW7m+10aSpC3F/d
	pCDSEMDIVJPFsXdEbGItWuiW07C6oOZ0=
X-Gm-Gg: ASbGnctyD98TiNoS6EK8b4D8vNAP1+13jYSoUuud2579ySDk7AV8ugZtFHyjWKZRJSV
	kD3ZTrGMlxtrp0muzhOTIAO0Th8qwHpzoTz8ulKxuXBQPI8+tDcIu8S4hshFCxjYQy5vb/B6j8W
	IuNe3M+T6VeKz2gIJpvqGoqRnPoPfuHxt+h9qHiBRrK6xtxrhUkXOsE4yBM8rxzQglQ7gGkOqLZ
	JhT
X-Google-Smtp-Source: AGHT+IEI3Qcu9TZFnSMnblF2FNssNDdu/cOBp2C241F1RixgB3NEkmLB/6LjF4MFzu6x8V21HblsJ4Zska5TTyG+eYI=
X-Received: by 2002:a05:651c:2205:b0:329:1550:1446 with SMTP id
 38308e7fff4ca-32b9ae2ff81mr528531fa.0.1750375490094; Thu, 19 Jun 2025
 16:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612.094805.256395171864740471.fujita.tomonori@gmail.com>
 <CAJ-ks9nXwBMNcZLK1uJB=qJk8KsOF7q8nYZC6qANboxmT8qFFA@mail.gmail.com>
 <CAJ-ks9mazp=gSqDEzUuh0eTvj6pBET-z2zz7XQzmu9at=4V03A@mail.gmail.com> <20250620.075443.1954975894369072064.fujita.tomonori@gmail.com>
In-Reply-To: <20250620.075443.1954975894369072064.fujita.tomonori@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 19 Jun 2025 19:24:14 -0400
X-Gm-Features: AX0GCFuDXISYPO9gpBGBu-zV3upwFiW0N2Hohkq2DlvwSSipXAI_SsBeURhkbnI
Message-ID: <CAJ-ks9n-iQAiwN3CVnJP164kPEgwq5nj-E5S7BnZrYdBWoo16g@mail.gmail.com>
Subject: Re: [PATCH] rust: cast to the proper type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	dakr@kernel.org, davem@davemloft.net, andrew@lunn.ch, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 6:55=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Thu, 19 Jun 2025 11:29:56 -0400
> Tamir Duberstein <tamird@gmail.com> wrote:
>
> >> > >> > Fixes: f20fd5449ada ("rust: core abstractions for network PHY d=
rivers")
> >> > >>
> >> > >> Does this need to be backported? If not, I wouldn't include a Fix=
es tag.
> >> > >
> >> > > I'm fine with omitting it. I wanted to leave a breadcrumb to the
> >> > > commit that introduced the current code.
> >> >
> >> > I also don't think this tag is necessary because this is not a bug
> >> > fix. And since this tag points to the file's initial commit, I don't
> >> > think it's particularly useful.
> >>
> >> Would you be OK stripping the tag on apply, or would you like me to se=
nd v2?
> >
> > Hi Tomo, gentle ping here. Does this look reasonable to you, with the
> > Fixes tag stripped on apply?
>
> Yeah, if you drop the Fixes tag, it's fine by me.

Thanks. Would you mind adding your Acked-by?

