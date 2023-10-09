Return-Path: <netdev+bounces-39113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2A07BE204
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC41281637
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5149347C1;
	Mon,  9 Oct 2023 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB4f/eDr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A21774D;
	Mon,  9 Oct 2023 14:02:10 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B28194;
	Mon,  9 Oct 2023 07:02:05 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d81adf0d57fso4687672276.1;
        Mon, 09 Oct 2023 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696860125; x=1697464925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODmNyRo8+oG5icZxXD93phoKDG2p5L4f28LbUvKlvb0=;
        b=VB4f/eDrPD6NHwpWW4m2FDuvEfQGwgx76pPvFOnIA7gzAXx6yVyCXlg/dlzHzEOy03
         C+TxkQXIUVBQDlPwLS2nINA49vmjD1iVyYVlz2q9beufBIBKqLfBSk83SCsSNTPG5O0k
         ZNF8FL/H2lJRVq0JMYyl3DlJwJhUa1EPD72Dv9nxz8sZG/cO88u5Ir1gHnMH0hwEDKVp
         YFuP51g+F3CbFtxjEi7KoNRbXIcOXE9dN929vR2K07+4NaTwAkZoG2t3MVCUPxPBFk13
         PppsJWdXEC6CbMjJmh8tfarOkfImKVuHqcbAMxzOsAnjuykUp1juVwlLabu2vF4FkVMr
         V3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696860125; x=1697464925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODmNyRo8+oG5icZxXD93phoKDG2p5L4f28LbUvKlvb0=;
        b=ovouGJczQ2f1zhGja6A3fbhxZtgQXl51d++tsyChOiKl1ZxbohBkj6SJW6t1lrKMw3
         Oedr9nbgFk1gt/WEkCTR2Q3JhOMmPcwPoH/8O5TY5ViPQekpxkoxid/T3qLy3pok2xvu
         gxDNM8Lxv+Xn+Sdy1/9gnIvXLX2uaG77P4UOSve5tQjZ/VBGZun/Ft9qgCH72KJo+ke0
         5pdOGTpFXy86P4egJ3nJUFY77sHsh0eqos7+HI8wyF1zt2GkZkDR1VpjNqROjlwWd3Hb
         Lnk4kU+3GNN2K8fJFru3wDsTEH9Ax8g6k6Hg3Gdzhc2xbri7vkjj1wEY0sVbfR9sGkVI
         RJWQ==
X-Gm-Message-State: AOJu0YwQvzl7Rhygmn4KS2WJ6QjBqtzzYRUTpMfJkaBRRA+chLf9WZ+V
	PYZkNuOafkqnesc+QVDLD5fz8AsppnE+hje6h8A=
X-Google-Smtp-Source: AGHT+IFiiNp7/GotBS4687oWE8SHh6UXX7pD9hqfjn/k4Pyvg5VaHII6szNZIAFIW99nKomf9ym0jsaF4ASnKtZln44=
X-Received: by 2002:a05:6902:568:b0:d81:ce82:3567 with SMTP id
 a8-20020a056902056800b00d81ce823567mr14367078ybt.62.1696860124745; Mon, 09
 Oct 2023 07:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-4-fujita.tomonori@gmail.com> <ZSOqWMqm/JQOieAd@nanopsycho>
 <bdfac30f-364f-4625-a808-fcffab2f75b4@lunn.ch>
In-Reply-To: <bdfac30f-364f-4625-a808-fcffab2f75b4@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 16:01:53 +0200
Message-ID: <CANiq72k4F4EY-cLYMsRFsAnjd9=xyMN_4eHS9T7G1s=eW7kHjw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jiri Pirko <jiri@resnulli.us>, FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, greg@kroah.com, tmgross@umich.edu, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 2:32=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> It has become much clearer the Rust build system needs work. It is too
> monolithic at the moment, and there are no good examples of kconfig
> integration.

I am not sure what you mean. As I said elsewhere, this is well-known,
was done on purpose, and we have discussed it publicly for a long
time.

The Rust experiment does not require the new build system -- the goal
is that developers and maintainers can work on abstractions and
drivers and see whether the whole approach is possible or not.

Being able to compile the abstractions themselves as a module is, of
course, a requirement for leaving the experimentation phase.

> Documentation is still an open question for me. I know Rust can
> generate documentation from the code, but how do we integrate that
> into the existing kernel documentation?

I replied to that in the other thread [1]. The integration that we
really need is getting at least linking in the C to Rust direction;
but I suspect what you are asking for is to replace `rustdoc` or
similar from what you are saying. I don't think that would be a good
idea unless someone can get something substantially better than what
`rustdoc` produces.

[1] https://lore.kernel.org/rust-for-linux/CANiq72n3kHrJKXApx2eZ6MFisdoh=3D=
=3D4KQi2qHYkxmDi=3DTYaHew@mail.gmail.com/

> When i build it on my machine, i get a million warnings from i think
> the linker. That is not going to be acceptable to Mainline, so we need
> to investigate that.

Yes, that is (sadly) expected, and I was at a cross-roads between
restricting it in the config or not, as I mentioned in the other
thread [2]. Given your message, let's take it as an opportunity to
change it now.

[2] https://lore.kernel.org/rust-for-linux/CANiq72m849ebmsVbfrPF3=3DUrjT=3D=
vawEyZ1=3DnSj6XHqAOEEieMQ@mail.gmail.com/

> I hope some sort of lessons learned, best practices and TODO list can
> be distilled from the experience, to help guide the Rust Experiment.

I appreciate that you are taking the time to have a look at the Rust
support, but please note that most things you are mentioning are not
really "lessons learned" -- they were things that were already known
and/or worked on.

On top of that, please note that we are not the ones that decided that
this driver / patch series was ready. In fact, we recommended
iterating it more before submitting it to the Rust for Linux mailing
list, and even less to the networking one. Mostly because there is
still not a driver merged, and things like this can create confusion
as you have seen (and there are others, way more complex, in the
works, but they have had more internal iterations with other Rust
subsystem people, which we appreciated).

Finally, yes, many things are not ready. That is expected, and the
Rust support is still experimental. We are still in the process of
merging things that we were working on in the past years (on the side
of the abstractions) and, on the infrastructure side, there is also a
lot of work to be done.

We never claimed this is ready for production and that we cover every
feature that C has. This includes other kernel subsystems, but also
tooling and external projects: there are things to do in `pahole`
(thanks Arnaldo for working on that), perhaps in `objtool` too (thanks
Josh for being open to work on that), in the Documentation (thanks
Jonathan and Carlos), in Coccinelle (Coccinelle for Rust has just been
publicly published, thanks Julia and Tathagata), in KernelCI (thanks
Guillaume et al. for getting the Rust builds working again last week),
in `rustc_codegen_gcc` (thanks Antoni for having made it work without
source-level patches in the kernel last month), GCC Rust (getting
closer), LKP/Intel 0-day, in the Rust compiler itself (e.g. recent
mitigations), in `bindgen` (e.g. the `enum` thing, the lack of
non-trivial constants support, the always-`u32`-incorrect C type for
`#define`s)...

What I mean to say with all this (and sorry to those I didn't list --
it was just a sample) is: yes, we are getting there, but it will still
take a while. We cannot really do everything at once, and there are
lots of things going on.

I would encourage others to join the weekly meetings to get up to
speed with the status and help getting everything ready. For
"external" projects, I track things in the lists linked at the top of
https://github.com/Rust-for-Linux/linux/issues/2.

Cheers,
Miguel

