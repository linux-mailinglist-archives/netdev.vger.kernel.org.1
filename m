Return-Path: <netdev+bounces-56414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352C980EC9B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B621F213F0
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6EB60ED1;
	Tue, 12 Dec 2023 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNfdxRqx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30CF95;
	Tue, 12 Dec 2023 04:55:12 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d3c7ef7b31so54741537b3.3;
        Tue, 12 Dec 2023 04:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702385712; x=1702990512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwH0v1dmFbIofoPEMzbKt7PH0sNIOX6i59AMfWzszAM=;
        b=QNfdxRqxj944OPDoehcVw+j2A4C9XMg+P24i0UC0LLNK2d/YYIUyRh8InqXupmIS/Z
         26culEQEER0s339aB5KiLsFYC8S2WEB2lDzymdeUEeH9OQE0M77T7/IH8JyjkrCK4Zzb
         8pBEqdFRhxglO8OaDo2Zz/fC+oim/9u5dmiQTEDS2w5o1BFEVk1KSk/1YEHLYCbknkS0
         lwU4JeSWrYmonpE3GHVOyvJgaMC4lZTZyO5e87F+9JIWTJHqs1RBex8T3WtnSLuPiwMw
         Y/2Fcu+ZdZUQ6DJphsu6kud3haZ5r0XkdbdZrtz9NWVvkeXhQ6j3plp8Es+Yqzd2qVNQ
         jfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702385712; x=1702990512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwH0v1dmFbIofoPEMzbKt7PH0sNIOX6i59AMfWzszAM=;
        b=hFQ7DfmF8EJ4Utp3gFUtW31Ct/zTh8QSL2PHNO8+H75aC2PiWCNhRybxIi+qnN+rqK
         +1VMFpeZgyuJ+Lv/s8SmKFaHNn2siAFC4WBBMA5/xfPF1YyakG79jjC8NBzZwrKeuzXf
         nUtlb27nxstO2Z/JuSOLRM6AMsxgUAanPElHC+aPRpd2qfd93LmohBOTNjBlQ3pznaIx
         4g+3kKwmjD9kxJ6vwQSgutTvEpMwg1ZHWZqZ8IBGGiVusSGqXSj547jYMBBcOV9vIS5B
         iEBuD35/H5noBdbshh1BCPQkXgvAOTQGX4XUi/YstTxNCMQJdctE4g5+FIKmcCMgbXoe
         AgFQ==
X-Gm-Message-State: AOJu0YxLU2eOjb6z9DyI33EVYzm0Bjz3U/rGp3yYpw/qGSIlzWi/fQVf
	mV6iphGoDI1Tq8PD6IA/aGLrlv/98J3upVerXEM=
X-Google-Smtp-Source: AGHT+IEZGi1XU5hesgfZcTt3MyndEAv7ghTWWCk4kEY/ZnuncxmsuCAk9kYi98T7zGo17WihKVSacGeYvbTeuy8CKqM=
X-Received: by 2002:a81:4947:0:b0:5e2:2927:a09f with SMTP id
 w68-20020a814947000000b005e22927a09fmr344215ywa.12.1702385711925; Tue, 12 Dec
 2023 04:55:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXeuI3eulyIlrAvL@boqun-archlinux> <20231212.104650.32537188558147645.fujita.tomonori@gmail.com>
 <ZXfFzKYMxBt7OhrM@boqun-archlinux> <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com>
In-Reply-To: <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 12 Dec 2023 13:55:00 +0100
Message-ID: <CANiq72kh5K2O8bPyhfTJsxXfbG-2f35tPqKxm9Kg2JT6+4DMFw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, alice@ryhl.io, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, 
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 5:04=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> The C side people read the Rust code before changing the C code? Let's
> see.

In the beginning, it is true that developers may forget often. But it
is still the case that they need to be mindful of the Rust side, just
like when changing some C function you need to take care of changing
its callers. That is also why we want to have maintainers of each
subsystem onboard.

In some cases it may be useful to annotate/mark the C side with a
comment warning about it (or similar) if you think it is likely that a
change on the C side will go unnoticed.

Cheers,
Miguel

