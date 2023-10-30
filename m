Return-Path: <netdev+bounces-45226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1F57DB97E
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 13:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD87528156C
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AC014F9A;
	Mon, 30 Oct 2023 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8p6hP3K"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CC2156E3;
	Mon, 30 Oct 2023 12:07:20 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F22C9;
	Mon, 30 Oct 2023 05:07:19 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7ac4c3666so39137627b3.3;
        Mon, 30 Oct 2023 05:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698667638; x=1699272438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Geny68wyKIYRNw/ofoi1ZcAYsWz5RTKIJcZMA1cucDQ=;
        b=A8p6hP3KKB74V+rPGCJXZ89ApW3DgFNmkHHqGY4Fegj+HgP5PGMs/RtBI0Xb/C+Ow9
         4wMR7UUwi9dCzYbUH7QjEuD9jsKll/cVHIUAukmdH1hoFVuqdtp55qh/MGv2i+UD9z1h
         QrOKn/6VuQeHk10zExD7vE1KYNH1GTuyi3rduYKlzW2pAbr9kJSL8SsG3WWivpuy8ccD
         mXwk2yuqKeWE5ys/3DlVtgZcIMsZRe3AqI4LZjSGHY8h0e5pBQe0T/euqw+PK2RiddmS
         bMXa6fSI5uaBML0MTd/JexCK3Zf+yNeAYYZBpOOIcYVPV7OpoHYuaoTRGYXOUlzAW/gj
         2tbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698667638; x=1699272438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Geny68wyKIYRNw/ofoi1ZcAYsWz5RTKIJcZMA1cucDQ=;
        b=m9ycWUz1fL5mrxxSNJUIom51uGXlQnlO9L74IS6dIxIOBA8xwYbnPXFtqpwbkzrcNT
         YixYzi7u4R0osCnBfOt51ql4UhKLX+RntYyBkGF6pmbm1+BLWSHgYBIhh8WzI7UWLcXs
         GYUEsAUGQVFMtQk8m+2XRn2bKtZzOvshdegRVrT7/rkE+kyrzl+upIw2rt9vDgDo+1J7
         7RTKTbtKVRIPNio6Ne591BuW6D8N1SHTAI3uwtJSGrhKaYtXLXhQXEjlHH/kJqAHXed4
         EdiD5L0u3yFtOfTWfE0X/uqVgQ3zl1Y0D3R2pLBPxUQdQKObaoGcHeVBLiEUvYHWSZ1P
         DvpA==
X-Gm-Message-State: AOJu0YwETt7jCUbX9XM3sAxuOTJoYk9HuEhg42KzfaXV65WS4kl3gwEH
	/FPlZim86CZ6V6Xn33mMO7oeuDsemXJMiBzp6I5qtmUB
X-Google-Smtp-Source: AGHT+IExgxxm9QoVjWZCTqd/Up4WNX8sDzKrDbmHi4Hs5+a+2KCuqiNsIcVzYFaJC0sf5Guh3hP6AICxryVI/snpe9A=
X-Received: by 2002:a81:d00d:0:b0:592:ffc:c787 with SMTP id
 v13-20020a81d00d000000b005920ffcc787mr8974441ywi.30.1698667638583; Mon, 30
 Oct 2023 05:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <45b9c77c-e19c-4c06-a2ea-0cf7e4f17422@proton.me>
 <b045970a-9d0f-48a1-9a06-a8057d97f371@lunn.ch> <0e858596-51b7-458c-a4eb-fa1e192e1ab3@proton.me>
 <20231029.132112.1989077223203124314.fujita.tomonori@gmail.com>
 <ZT6M6WPrCaLb-0QO@Boquns-Mac-mini.home> <ZT6fzfV9GUQOZnlx@boqun-archlinux> <c8d6d56f-bd8f-4d2c-a95a-4ed11bf952b8@lunn.ch>
In-Reply-To: <c8d6d56f-bd8f-4d2c-a95a-4ed11bf952b8@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 30 Oct 2023 13:07:07 +0100
Message-ID: <CANiq72=_6HsRbMGgWcyKqX-W=xpmw0njGoVRvRRe-c23o7sJyA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	benno.lossin@proton.me, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 8:39=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> We have probably missed the merge window for v6.7. So there is around

Definitely missed. We aim to send our PRs in advance of the merge
window, e.g. this cycle it has already been sent.

But even if it wasn't, for `rust-next`, feature patches should be sent
early in the cycle anyway.

> 9 weeks to the next merge window. If a working bindgen is likely to be
> available by then, we should not bother with a workaround, just wait.

In general, it is better to avoid workarounds if something is going to
be implemented properly. However, `bindgen` is a third-party project
which we do not control.

In the case of the exhaustiveness check, they looked interested in the
feature, which is why I wanted to avoid the workaround if possible.

In this instance though, we don't even know yet what they think about
the feature we requested. We will give them some time to see what they
think, and then decide based on that.

Cheers,
Miguel

