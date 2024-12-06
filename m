Return-Path: <netdev+bounces-149852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E072F9E7B83
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 23:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12732828A3
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 22:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9C7215057;
	Fri,  6 Dec 2024 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ucs7Dmiu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD19214802
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523191; cv=none; b=GBaxkIEdlUZGtFxezVs3rqFBFi+0JdT7u+8QHRs9bs+VQvLQUjO+6eH2w3fwK3o+bZgD9wsBcwb0fYxtghqTZIVchFixZkcHfXiUObXmLe8Qyx3NLqmGzzUdpw/Yy83u3dLRx6ovopIbn31sKAot9x/0PHM+NbLa8cOz50vuI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523191; c=relaxed/simple;
	bh=tKoKpqFqMsaTyalh17cUupQqtDJ85oUoAYZrQ6vulEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5Q4lYT03Fh6zSBXY83qv5EQ7zEqsRHioVLyD3XYGYOnfrc6AWvKUI/8Il/AEgNBFuG/+DujKPXraS6Iq+/8fokpk3iklOcRjIwQ8HtackAmTwkM3NEPq2ZfGxxEQ06o++KykPNY+0vk8ywBsQCJX7t0w+/DlTsFUSZA1GuCr3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ucs7Dmiu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so26248905e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 14:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733523187; x=1734127987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GkaAUC4YurkH0P3A1uBBUmUf2ttFOaLH/NU+6/Qr6is=;
        b=Ucs7Dmiup8L05E6cxjnH3omgWpKSQ00eAmxP7J33GuzZEpTq7toysgdkk/+QvXRTQa
         eg7ezheVwLEwx2oo/xj6Fz61D34/vlkVxJPa566M0F3vTO44x0Fh3/P+7fWRspYtZ2z0
         xxkiXB0PseI4xR2u2Dtq5uh6aknC19XwU5VTa6v4YzmTx8qE6Ga2sQMi1UYI2k1p9Nyh
         X9MsXK9dHbK7o9tfBqxQ8TxRVE2ut6i9YeSLu8VUlVwhqP7FtPeSa9qXaRGQBnuSYp+l
         2BI3AQKEeO1OP5xmYgkeuxfgb65aQy4SDHIaR4RS+kKf31jEyvzSFKnpeX/SOUcg+I2k
         kTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733523187; x=1734127987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkaAUC4YurkH0P3A1uBBUmUf2ttFOaLH/NU+6/Qr6is=;
        b=UaiJGylLHDueH2elgy/hSyP2WoZr1aEUXW4e7PCJTuiUTeVOsPUNCZ4rAPw+HgbOea
         9b+yhlG7Sy8KWDa03pKubmpAaRS/KGGJ+k+bZaLzUKaVqKOLm4aFy90bTSw0qvQAbO0d
         xdwDDKEKbtPediTpyXu793eWJUU7yLjCuutJfmA209sz4WB0BCnWG8v7xr5ucCO54D/X
         8lacudSTHvXV7+AokFO9yIPBxQL2TbQwnbQ7UuN7DQBbel72j+07Cdldyx2ZX4wuBoTQ
         wcIDJOmLaxi8AxMuWLE/JUEJ+uQh8/84IRQ65kZy8+7Zo+Wa+1KhObw56oetaA3AM6jj
         tu6Q==
X-Gm-Message-State: AOJu0YzH7fAqz2zP6X2jYb28g9It/AT6v9MnXrxAA9jXJWxoyX2EAzFS
	4yFyij/EPy10Vu4lzJ5Ml/ElFFeYifiY8tX8J2hMhgq/oEc1NQra8Cbh4PFM8yg0kYuXGXrtjwX
	/cc3bfaHfyWSWmZwxYo1/Os5QD/Q=
X-Gm-Gg: ASbGncv6cj3RA3j4NJR1OHfx27vZDGjFWm+Sl56aR1+3uTxaALywQp3vTv/MSNag6XI
	ncemeDFmqeoZRdXkmzSe5en6c7chUTGFu
X-Google-Smtp-Source: AGHT+IGg6zB/q6LoB1qDsMb1psAUNJl0ejwRh84tUBK9vljANM8j1Zir7HlHwaqTQPNx0585nLIkVzfeakcWWlAYiCU=
X-Received: by 2002:a05:600c:45c6:b0:430:54a4:5ad7 with SMTP id
 5b1f17b1804b1-434ddead902mr34414235e9.1.1733523187253; Fri, 06 Dec 2024
 14:13:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127221129.46155-1-jesse.vangavere@scioteq.com>
 <20241130140659.4518f4a3@kernel.org> <CAMdwsN99s2C=qvxEO=hmpRfvjRH6E7tww0Mfp-Q044ufi8Rn-w@mail.gmail.com>
In-Reply-To: <CAMdwsN99s2C=qvxEO=hmpRfvjRH6E7tww0Mfp-Q044ufi8Rn-w@mail.gmail.com>
From: Jesse Van Gavere <jesseevg@gmail.com>
Date: Fri, 6 Dec 2024 23:12:56 +0100
Message-ID: <CAMdwsN8iXqhBW4y7WOBT1WAdhfoKhmndmODzVihkvfmmzuOj6w@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: KSZ9896 register regmap alignment to
 32 bit boundaries
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, 
	UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com, 
	Jesse Van Gavere <jesse.vangavere@scioteq.com>, Tristram.Ha@microchip.com
Content-Type: text/plain; charset="UTF-8"

Hi,

A quick ping on this, how do I best proceed here?
Do I keep the original commit and take in account the feedback for the
commit message or should I e.g. like Tristram recommended just modify
it to 2 regmap reg ranges for these PHY registers?
In that case I might just as well modify this commit to make this
modification for all the existing regmap reg range arrays defined.
(There's probably also something to say about enforcing these ranges
across more chips but that's a bit outside the scope of what I'm
trying to do here)

Best regards,
Jesse

Op di 3 dec 2024 om 06:29 schreef Jesse Van Gavere <jesseevg@gmail.com>:
>
> Hello Jakub, all,
>
> Op za 30 nov 2024 om 23:07 schreef Jakub Kicinski <kuba@kernel.org>:
> >
> > On Wed, 27 Nov 2024 23:11:29 +0100 Jesse Van Gavere wrote:
> > > Commit (SHA1: 8d7ae22ae9f8c8a4407f8e993df64440bdbd0cee) fixed this issue
> > > for the KSZ9477 by adjusting the regmap ranges.
> >
> > The correct format for referring to other commits in Linux kernel is:
> >  %h (\"%s\")
> > IOW:
> >
> >  Commit 8d7ae22ae9f8 ("net: dsa: microchip: KSZ9477 register regmap
> >  alignment to 32 bit boundaries") fixed this issue...
> >
> > > The same issue presents itself on the KSZ9896 regs and is fixed with
> > > the same regmap range modification.
> >
> > Could you explain the impact? What will not work / break without this
> > change? Please add a Fixes tag indicating where buggy code was added
> > to make sure backporters know how far to backport.
> Will do, still learning the ropes of contributing, thanks for the feedback!
> > --
> > pw-bot: cr
>
> What do you think I preferably do to account for Tristram's feedback
> in my next patch?
> Should I incorporate it as-is, keep my patch with requested changes,
> or perhaps even "fix" it with below suggestion across all registers
> sets?
> > The port address range 0x#100-0x#13F just maps to the PHY registers 0-31,
> > so it can be simply one single regmap_reg_range(0x1100, 0x113f) instead
> > of many.  I suggest using regmap_reg_range(0x1100, 0x111f) and
> > regmap_reg_range(0x1120, 0x113f) to remind people the high range address
> > needs special handling.
>
> > I also do not know why those _register_set are not enforced across all
> > KSZ9897 related switches.
>
> Best regards,
> Jesse

