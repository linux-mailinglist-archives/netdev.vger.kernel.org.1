Return-Path: <netdev+bounces-96098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393388C4520
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2541C22A0C
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBFEE56A;
	Mon, 13 May 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsfsN2KX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F217C95;
	Mon, 13 May 2024 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617905; cv=none; b=icPT7mrakqsgbhG1vmnC90Gl1tDMOBHwatbozFR5RkFLRgYYn51/qxp5htL7YRnhH/wZomIJ8P6ucjaRqJG8ogYsLAqDEuXqlTyTk/iJQxRa7uOMCtW2o31DpnK7sj/xP/jqSU9wrbXG4x5VZioc6G0Ara9/6NiTAEK7vOjUTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617905; c=relaxed/simple;
	bh=311dwzltPk5fOF2CTRb5l8iHO2TC3E82uom3/fmI05o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RvTHqZyvQnOp8NAwT5ec+251i2lTnuQZABRbQK7DG8KVdEZgjPMuFZEBEyl1VsUXDjQvRlcHy3MOu8mlNZZ0dCNf5/4B3Yd5H8gbgiMFS05iV//yEfCt7ZBU/ojAYih0w00OmYHrI6y5VNJDdlaCz3blY3BlOY8BmVaElM3plwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsfsN2KX; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e34e85ebf4so40005681fa.2;
        Mon, 13 May 2024 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715617902; x=1716222702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUFnT8yyTapCAsA+F1D1wSnTUO1k2FcynX/QhnqWbRY=;
        b=dsfsN2KXL8RyBqEnoHuPeysMS61hNnzQwzdHosR/Hp2Nbv35lkAzcuTpJtZZ5CJYV7
         lWp0Jmy78TkB8i2PJ7ysxi9yBmkqN1HazzPD1xBzYJAu001tPA54iygM+Eaqi9B4AXiS
         7V1Zrbrd2E3WxGerH22Y6m/mVcEPegcdjjkPxCCFMSogxgaStKd4W4QsXEpyElv+dddt
         wBOpn2mIZ3TEosmlQRRXEz9G8rFn23zxhevJ7JThp1SQwRYTMV8vo0DpxyJXbN9cHbUE
         hY1pULEHmNdHsghQ3OvJxpp1L2+qGQnq+5ltZRgRcgqukvp2rO361HS+ZQmnFxFhCyG2
         jPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715617902; x=1716222702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUFnT8yyTapCAsA+F1D1wSnTUO1k2FcynX/QhnqWbRY=;
        b=XheqE6OPCmGRO5wB9vF5r4lBjDmsRt6coQyBOCYqPUtIk63tAWEtWObfyDwPEmyTjL
         qnn/G9TI6NlWgPgVJU4yuBLrZemnd5zMmM1BfVCfMZQFalcDuTWGrW6omRZi6z3QxaHd
         HuhXhcMnVjTFkgi5L8F1DbhItOdj6/G3zou90ZVN67pEYY8qjxuYMii/Y8bPidXUXKun
         mBY62JCVNEmUYGsIFHByuwuxdGmj61TJ4P4vaXwpG1Dfl0RK93HmKEI0mZx4ncgEW17s
         e2OV3BaHkKhvvn9NqmpkogIDBhINO9Ggd2ynmWambIHHgHFW7O1xe9UxtJr6jaLo/y3V
         xk1w==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZxzK1Un78g9mKblDHbRwC9T9Oaa4+ER+x3ZDPt0MfPnBickeRGc6SUmLDTyb7BcvypPd7U983rFbC+pOu+Fscc8bovs1lDGGPdq2SyUDsJ4gAL0fkv+W2VrVSkz531LBIibsDOvUEjnmzZiDoUfkPmm63RAe28XkzHu4TTXVX3aGOOdSJEWrJX7eK3hWmb9oO4tqI1MJcBpGQreYQsgz0cvfI/73
X-Gm-Message-State: AOJu0YzxwPKn4nv6rpTyi5TAKYq8CvuJzai9mhi68TV74T5A93NYHOu3
	fH/G99wgTQPlfLHYDGYUxd74db8X6MBuRAZnOl6O0aB739pjQMY2zkw+qF7bNVW6uDFXBV6vO9L
	4GqMazEWDdcHrD4ncLU7OOmqKJ1s=
X-Google-Smtp-Source: AGHT+IEfQfbks6Pb9MhqjUGNG1bzcGu+P0BjYxxyNbUBodsFQi2U8Ir6ig2hVVlBqpKtOgABUOUtPTVs2/IAcJEAvxQ=
X-Received: by 2002:a2e:a7d6:0:b0:2db:a7c7:5d11 with SMTP id
 38308e7fff4ca-2e52039e290mr67635451fa.47.1715617901807; Mon, 13 May 2024
 09:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8PR02MB7237ECD397BDB7F529ADC7468BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202405122008.8A333C2@keescook>
In-Reply-To: <202405122008.8A333C2@keescook>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 May 2024 12:31:29 -0400
Message-ID: <CABBYNZJcg5SpO_pew6ZwN98n1sR7kNZs6VtkFToyOs9NM1bO8Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: Prefer struct_size over open coded arithmetic
To: Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@outlook.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Sun, May 12, 2024 at 11:08=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Sun, May 12, 2024 at 04:17:06PM +0200, Erick Archer wrote:
> > This is an effort to get rid of all multiplications from allocation
> > functions in order to prevent integer overflows [1][2].
> >
> > As the "dl" variable is a pointer to "struct hci_dev_list_req" and this
> > structure ends in a flexible array:
> >
> > struct hci_dev_list_req {
> >       [...]
> >       struct hci_dev_req dev_req[];   /* hci_dev_req structures */
> > };
> >
> > the preferred way in the kernel is to use the struct_size() helper to
> > do the arithmetic instead of the calculation "size + count * size" in
> > the kzalloc() and copy_to_user() functions.
> >
> > At the same time, prepare for the coming implementation by GCC and Clan=
g
> > of the __counted_by attribute. Flexible array members annotated with
> > __counted_by can have their accesses bounds-checked at run-time via
> > CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> > strcpy/memcpy-family functions).
> >
> > In this case, it is important to note that the logic needs a little
> > refactoring to ensure that the "dev_num" member is initialized before
> > the first access to the flex array. Specifically, add the assignment
> > before the list_for_each_entry() loop.
> >
> > Also remove the "size" variable as it is no longer needed and refactor
> > the list_for_each_entry() loop to use dr[n] instead of (dr + n).

Have the change above split on its own patch.

> > This way, the code is more readable, idiomatic and safer.
> >
> > This code was detected with the help of Coccinelle, and audited and
> > modified manually.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#op=
en-coded-arithmetic-in-allocator-arguments [1]
> > Link: https://github.com/KSPP/linux/issues/160 [2]
> >
> > Signed-off-by: Erick Archer <erick.archer@outlook.com>
>
> Looks right to me. Thanks!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook



--=20
Luiz Augusto von Dentz

