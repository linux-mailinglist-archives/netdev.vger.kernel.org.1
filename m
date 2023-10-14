Return-Path: <netdev+bounces-41032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3147C95DF
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 20:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201A21C20956
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 18:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D07D224DD;
	Sat, 14 Oct 2023 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbnI42wB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA71803B;
	Sat, 14 Oct 2023 18:18:59 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE5EBF;
	Sat, 14 Oct 2023 11:18:57 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7e5dc8573so38842637b3.0;
        Sat, 14 Oct 2023 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697307537; x=1697912337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr/i22JS+1cutyfhoerat9B9vOPYBkQ4u8mTCH/KaAI=;
        b=BbnI42wB/KnBbPUic9R3mPsYWH8tLTgqFxyByvDeJy9DM2320o4uNy0VpSu3/GEPNn
         drdmWPtCUQDVemtbVr/JJCaS4vHAIJcPOifhEb6OmJLZbdpKXkpVmaDUmzY55rCPl/nb
         BzvNrF25Krr8rSZVonMbD7MUS3u4sq55IuDQPi0r5pmt+4T/JId9FKEMulsseuKIjV6G
         MeXdHOzvhBbKt8C9xn74JT3lBrTAPOc83dLBUWuLlE/YuWuiJlbokmW5iNYx+HnMWGFt
         /WkNX0ue73xEO3z0TRxzK5h+XgeazNoxjkTNugbIrbV+ue9JhX7Pr01YTVE6skE6isY/
         4HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697307537; x=1697912337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wr/i22JS+1cutyfhoerat9B9vOPYBkQ4u8mTCH/KaAI=;
        b=HEl/Z09YTS419xOMcPcy6gyattu6R7BU3EkBXu79/NwzfNWGkS2eaYubXlzu49LLyC
         4fBxNp6KO2hNwzLcxn2oUGdgK3LHP3n0V4eSH/v2SQQfpQhzE/tuhm3ZpMQnz5WrC3Iw
         X7N+wAHfRrj0kKhvpS9ihcXH647m6MB4/1zu4krlZZ/qYysuikK/1nn8FBzIpGtYrbDF
         bm+t2SidOaoNzkeGhVDNDSy5lfDLqP7KCHp22wdjySRVMNglFo6rz2BUkZ9Kzu+jhoR0
         meuHCUOBA8yrRE5oswqKBma8RoqjjGQGvE07aOZeJT/8SlBYbuyNZUj1J1DpdME5BMRl
         UaBQ==
X-Gm-Message-State: AOJu0YzcNfL/aEEC4klGtOsOEQhKOsIOwEw+Z3UojAvvFGpLRYf4jJ4r
	S86yxyBwa7dwhMCky5fkZBJjmF4kvvrdaz551uA=
X-Google-Smtp-Source: AGHT+IEJHtlh06wj/yDP6wQ/ay+4nDqiQ0DyxTgTcExu9EfxhnQU/QuM6WyYndpfgQ4LENPoZSkIOtlTL+fIIPJv9Lw=
X-Received: by 2002:a81:4402:0:b0:5a7:b1d9:70cb with SMTP id
 r2-20020a814402000000b005a7b1d970cbmr16061421ywa.2.1697307536972; Sat, 14 Oct
 2023 11:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALNs47u9ACA3MO2soPueeGZe=yZkieKb6rDr-G1fGQePjJ5npg@mail.gmail.com>
 <CANiq72kS=--E_v9no=pFtxArxtxWNrAbgcAa4LUz28CYozbVWg@mail.gmail.com>
 <0948fa3f-2421-47ad-89fc-8b0992d9f021@lunn.ch> <20231014.141508.709941476709455265.fujita.tomonori@gmail.com>
In-Reply-To: <20231014.141508.709941476709455265.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 14 Oct 2023 20:18:45 +0200
Message-ID: <CANiq72nzJGnbr2a8SvtGA9az_JY2ydapZ=avYV2bEA17k19ihw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] MAINTAINERS: add Rust PHY abstractions to
 the ETHERNET PHY LIBRARY
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, tmgross@umich.edu, boqun.feng@gmail.com, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, wedsonaf@gmail.com, 
	benno.lossin@proton.me, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 7:15=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Looks good?

Looks good to me!

> get_maintainer.pl gives additional information. hopefully, we can move
> phy.rs to drivers/net/phy soon.

That should be fine for a while, and actually it is probably what we
want initially, i.e. that the Rust subsystem people is contacted.

Later on, when the driver is moved to the right folder, we can also
drop the rust-for-linux@ list too, and we will not be contacted
anymore :)

Cheers,
Miguel

