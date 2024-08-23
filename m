Return-Path: <netdev+bounces-121484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE1895D5E5
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82991F2331E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6D191499;
	Fri, 23 Aug 2024 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ITpRKxEU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B277F11
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440419; cv=none; b=mzbAhbKe+8Eo4oIp9gi/E8lDkD/EApc2gNiXTQRX2yVrCPsGJBo43SHBIZSEeCzR0pca81Z82sK3bhOyDmsoSksWTB0pIwfyMWnn0cAiWDXndC5Lmma5v0P6wMWD1Hw2OcscriQXRy/z0v4xHXwJZ/7lZV0MRXqpqsuIr1s2p30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440419; c=relaxed/simple;
	bh=7aUFx8cxFOwF0WID6eSNxZMzobzkEuWFC5EGYifrKn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M13D1S841+s191uq6+8op2/pbHlbg/A7JGQdl2VpW/bcStL2lotACKXEH0A6Ifi+MybXmNtFi0J0pU+95o3odBn9Frwl1Lx4pxNG4DOIEHBi1YUsPMseRp7XBQT5cXj9hxl0Yff10dK8FTMGhxeQPfCB2dG8IcVVOuaZc/nd1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ITpRKxEU; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6c3f1939d12so18336357b3.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724440416; x=1725045216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aUFx8cxFOwF0WID6eSNxZMzobzkEuWFC5EGYifrKn8=;
        b=ITpRKxEUpv/7up7O0+nXBQpyzxOTY/4itFhTTZz5NFlZaPTUeSgEewGAFj3ySVKkZF
         S04YCnHhp8PJrPdbjSYeRTe0oq+Q91lTYfPPw75UgnmbE396pnqBmopBjuXWmz3ymFVi
         QlrDGAWwAqGZ8cP93i/Djev++iEQa5n29rUbDkdeWMGk4jtwrthKVOmq0/WeJphWDzLU
         xm49teUi4QJD4OWNRFX6SG2myBfbK96DZIJ3TmUEyqcKlpvxqROAEBL0+Hby5XKl6f0t
         XQDP+jpcrZ0frKr6eFY2PTWYfoxncG29Rl3kjM9OC0Q/go56K4F4uew1WBJdAaKRGhve
         xW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724440416; x=1725045216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aUFx8cxFOwF0WID6eSNxZMzobzkEuWFC5EGYifrKn8=;
        b=nHSu1m4HxVkl/zK2pYPYlShT7XYpmcaGGX13TGVBVf8hV2Xn+9C//n2cT+Ua98PMPL
         Ka94JTmBRJHC21ZpX3g0bGFkYooUomAkt2dLPUCCP274wF+1LnVQsu3Styh5QMaSR3eg
         xlctfujkpkIYRJrhuUZkCCxeHFiuEEWmge6BqU/kQJlcXUFbYWeZoZ/1Fephb0Km3uiW
         3kMai/b2ZoFkw8ga19v8EaiYnEC1/bd4LvfgQ+VIgqSILGCqydUgMS8ZLkMsHLYPZgPw
         0TgWz7b/gmPWJEbQ6d2h8BByjtIDh0mc0EL0Q5E538dPLhTu+IH6gdD7J58jj8WIjlfL
         2YfQ==
X-Gm-Message-State: AOJu0Yzi+8khFlYS1D9y3XdUoxMS8V9BUGbT7N0Om1j0E9086IzyAKtn
	x6vEPL2t+VQZ84gPJlnuPUhGiwcG7elzbDriJC6JvC0uF2rKDK3XRQqzqthNuub+I4Z9zynvb5M
	34wYL11RDzzCdw97pOgeNyio6vbmls5wKxpXQX+jSZDlnmWTYcIsXFw==
X-Google-Smtp-Source: AGHT+IFcMDW0basToGMWwrN6IlEZFwXsVJ7kJ4mtTeeL1VAh1oM7BhbMtKw6zEmyfR0/Tgad6SIdughuT745+IOGF4U=
X-Received: by 2002:a05:690c:f94:b0:6b7:a7b3:8d94 with SMTP id
 00721157ae682-6c6247f0eb9mr38028247b3.6.1724440416643; Fri, 23 Aug 2024
 12:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820225719.91410-1-fujita.tomonori@gmail.com>
 <20240820225719.91410-7-fujita.tomonori@gmail.com> <CALNs47uvG_yjzX7Ewszb6M__jMZFtPu1rtw8DqvL5CceqCw4Zg@mail.gmail.com>
 <20240823.133656.1425422314833390920.fujita.tomonori@gmail.com>
In-Reply-To: <20240823.133656.1425422314833390920.fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Fri, 23 Aug 2024 14:13:25 -0500
Message-ID: <CALNs47u6+EFYkvpyHZD5zLcjQeb2CuZNTOjPuZ4MKewoKZYPMg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 6/6] net: phy: add Applied Micro QT2025 PHY driver
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 8:37=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
> > At this point the vendor driver looks like it does some verification:
> > it attempts to read 3.d7fd until it returns something other than 0x10
> > or 0, or times out. Could that be done here?
>
> Yeah, we better to wait here until the hw becomes ready (since the
> 8051 has just started) and check if it works correctly. A new Rust
> abstraction for msleep() is necessary.
>
> Even without the logic, the driver starts to work eventually (if the
> hw isn't broken) so I didn't include it in the patchset. I'll work on
> the abstraction and update the driver after this is merged.

It sounds okay to me to not block on this as long as it isn't glitchy
- It should probably be a FIXME?

> > Consistency nit: this file uses a mix of upper and lowercase hex
> > (mostly uppercase here) - we should probably be consistent. A quick
> > regex search looks like lowercase hex is about twice as common in the
> > kernel as uppercase so I think this may as well be updated.
>
> Ah, I'll use lowercase for all the hex in the driver.
>
> It will be a new coding rule for rust code in kernel? If so, can a
> checker tool warn this?

I don't know of any rule for this, I just noticed that the patch had
both and it made me take a look at what is used elsewhere. rustfmt has
an option to just commonize it for you, `hex_literal_case` [1], but it
is unstable. That would probably be nice at some point.

> > Overall this looks pretty good to me, checking against both the
> > datasheet and the vendor driver we have. Mostly small suggestions
> > here, I'm happy to add a RB with my verification question addressed
> > and some rewording of the 0xd001 (phy revision) comment.
>
> Thanks a lot! I'll send v7 soon.

Thanks!

- Trevor

[1]: https://rust-lang.github.io/rustfmt/?version=3Dv1.6.0&search=3D#hex_li=
teral_case

