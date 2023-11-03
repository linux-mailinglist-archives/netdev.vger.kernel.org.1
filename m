Return-Path: <netdev+bounces-45926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AE87E0715
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EC9281DA3
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804941C6AE;
	Fri,  3 Nov 2023 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Evq6DIQO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850E1D6A1
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 16:57:31 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317211BD
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 09:57:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32fbe003761so291380f8f.2
        for <netdev@vger.kernel.org>; Fri, 03 Nov 2023 09:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699030648; x=1699635448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lIsbDHPwaa1oft7g9fsOhHYzHACUbAbiF4uUBUfwbY=;
        b=Evq6DIQOxByYYO7QSeQTHoS2dTq9/w30oya392LbIXOsFK0eq705Jn5vlK1hLfoMs5
         CLU+mfUe6kT+aex+6nBXfVWVC7XbUFhyJkNleGfEAetrfcBkwnP7TZfyI6lWMrEXUyXA
         AT4w2uwPdUK/1dHuK0FpQeo6Ux0t3O0KXmfWFXdX1GTrmWcYgP+Yhlbct8e+C/NCkZkp
         iC6rMbEkPis4KEhwr9+rz8qCVO4OPIfXtXzOGthVDD+O7g02bPrGJbD9h0xDh1qfKSXX
         7CTTMyTGViepzjAmWe3ulyUxQAOxzq4KF7BPIXhW/XrEeJglH5qpjKAwUPUuLeSxFj9b
         297Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699030648; x=1699635448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lIsbDHPwaa1oft7g9fsOhHYzHACUbAbiF4uUBUfwbY=;
        b=p8uCT+JOam551gnVi/oMdO32lee/5MHdccE8OLpqErhZHUq6uJcydi/z+8IO0BviDr
         Qjb8fW19QvgOxCWLMM2Z64gvoiq2H9At9gOi0SCSo3S6xQKSOTdKadHXnFekeSNq343L
         o2nT6+AOn3nPor8iAtnoF6hmNOI+xueTbbWo64pGp158fdmfPfIf0NAbL96a5jy9cf+z
         puKZqTAXgc+tWOCkNstgA91TracXsvMQJGekaZKurCGMY73SjHvGKt75S0hLOd1q/6x9
         c69OycaY4phmVmWkcWQQX6VXUNhNpPxqIfjlG3JbOh537B2mVrMWYiyaneW7wNVrvLIo
         bp2w==
X-Gm-Message-State: AOJu0YwoObounLdbBoMSYu9d1ZyxvLtixNCLENMAIxWTABl4IdjrakUF
	VE/klV03SbEFmca92o2WViMeZX3u/9nxxAfaoEUB5A==
X-Google-Smtp-Source: AGHT+IHsyB2RMiwtGQtmp5D41evpEcLf0w+GRDtt6AMs5gXHG7mDc80QXHpPVY9wrU1VMaW7Ifo9PRPl2ELGlTdes+M=
X-Received: by 2002:a05:6000:12c5:b0:32d:9755:44f1 with SMTP id
 l5-20020a05600012c500b0032d975544f1mr17649157wrx.32.1699030648342; Fri, 03
 Nov 2023 09:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
 <ZUStrQCqBjBBB6dc@infradead.org>
In-Reply-To: <ZUStrQCqBjBBB6dc@infradead.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 3 Nov 2023 09:57:17 -0700
Message-ID: <CAKwvOd=voKM+kPWa=toFfWDvq2gOw7Q0yyjq7ragxmPS7U5HBQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
To: Christoph Hellwig <hch@infradead.org>
Cc: Nathan Chancellor <nathan@kernel.org>, edumazet@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, trix@redhat.com, 
	0x7f454c46@gmail.com, fruggeri@arista.com, noureddine@arista.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 1:22=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Tue, Oct 31, 2023 at 01:23:35PM -0700, Nathan Chancellor wrote:
> > Clang warns (or errors with CONFIG_WERROR=3Dy) when CONFIG_TCP_AO is se=
t:
> >
> >   net/ipv4/tcp_output.c:663:2: error: label at end of compound statemen=
t is a C23 extension [-Werror,-Wc23-extensions]
> >     663 |         }
> >         |         ^
> >   1 error generated.
> >
> > On earlier releases (such as clang-11, the current minimum supported
> > version for building the kernel) that do not support C23, this was a
> > hard error unconditionally:
> >
> >   net/ipv4/tcp_output.c:663:2: error: expected statement
> >           }
> >           ^
> >   1 error generated.
> >
> > Add a semicolon after the label to create an empty statement, which
> > resolves the warning or error for all compilers.
>
> Can you please just split the A0 handlig into a separate helper, which
> shuld make the whole thing a lot cleaner?

Just a note; mainline is currently red over this for us since
1e03d32bea8e spent all of ~3 days in linux-next before getting merged
into mainline.

Whatever the fix is, it would be great to get it into mainline ASAP.

--=20
Thanks,
~Nick Desaulniers

