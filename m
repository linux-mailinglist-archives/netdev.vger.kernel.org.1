Return-Path: <netdev+bounces-61700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0497F824A88
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 22:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9704F1F2496D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 21:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA0E2C84E;
	Thu,  4 Jan 2024 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OJsT9ASm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4B2C84B
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5edfcba97e3so10407027b3.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 13:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704405442; x=1705010242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOJx/D9I9BlgipBiGrZNajpa/ePe9te5wdZDi1lFh90=;
        b=OJsT9ASmpGirYEw4TGqMr+KVofWzbsOeL6SYKql9K46FsSa4+i/jyAP40vWeheVxdC
         dDfHHtZ30kE6QpxrGxV08BOrPcp2eurL++weU93Du9J/IE0EHD/eNyyQfQFff0+5DsQj
         3cvcPT9tAxpRUc76KM1jrdQ8XWazi5Lll2mvk23yHOEIc8yrNVI/NTHPfCiDigWqy43w
         f+Od6mVQDAGTWVySaUAxR7UV5g1yS4U7t9sS8X/FhpI7nJwYzi6VCFrmytp+nJ8iF61W
         GDddIpx7Q8AC/CW77JEBTcd1QIdlmixiyp3D+a2N7w7hnGCMYY3RjpbBfxsSTWpUa2f4
         LETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704405442; x=1705010242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOJx/D9I9BlgipBiGrZNajpa/ePe9te5wdZDi1lFh90=;
        b=vdYGkpjWOSpj7vwr208cvkqRQfjE7Gr7YjJlhEZku5JTJiocRxPJvL7H+qjjKTi9Wn
         xx1TBZM3JjGd/Lyi3J2AuJE+y5bcjOrZ/4wwOPMaICWY4REWXg/1AfLJOKfjk30qgGCY
         ZAqSzPFGdSyZI9PV0x6H2jsWsB/vkbtMRk5pTiWOr/ZRJvfgwP+SuzUYsgzyCkuJM1ZP
         hwVVGZmFU7CV62dEpNu2XmHslQkSLZUDIjm7IUeOA5TzzfhWIjZBteaLWTVB4BjlWl+g
         f2j2jVV9S+dn5m4nFI1BM/BRIUzMxqy4RxOowW0fmdl9bHn7tiKK72sBi3ucvNAS50Ff
         +6fQ==
X-Gm-Message-State: AOJu0Yy0ygOTWVYl99nPuU+ILVfUJMC3Mzv12sGpIDwrqeKz4puFheTm
	K81Lt5CoQLmwuanEsQHR+N5CR3Fw+9yO/S/LgJQGK6TyY0zRAkFxy37fyec=
X-Google-Smtp-Source: AGHT+IFMqTHSuBBDvogO6c+qL9/Xs36u3YbBdlpQcFxg3Wk04M3wPGZW4zqxbNLq2zbL016aJ0gEnXkJYDvDC/8Ee54=
X-Received: by 2002:a5b:f4b:0:b0:dbe:7c4c:3307 with SMTP id
 y11-20020a5b0f4b000000b00dbe7c4c3307mr1014785ybr.17.1704405442111; Thu, 04
 Jan 2024 13:57:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103163415.304358-1-mic@digikod.net> <d4a31d87-0fa3-4ae7-a1be-37d3ad060603@collabora.com>
In-Reply-To: <d4a31d87-0fa3-4ae7-a1be-37d3ad060603@collabora.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Jan 2024 16:57:11 -0500
Message-ID: <CAHC9VhSkg6=Y5OgUmdkBA2MBrkQT3idZ7NWG2msqdsFZL03TyA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: Fix error priority for bind with AF_UNSPEC on
 PF_INET6 socket
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Eric Paris <eparis@parisplace.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 6:40=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 1/3/24 9:34 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> > The IPv6 network stack first checks the sockaddr length (-EINVAL error)
> > before checking the family (-EAFNOSUPPORT error).
> >
> > This was discovered thanks to commit a549d055a22e ("selftests/landlock:
> > Add network tests").
> >
> > Cc: Eric Paris <eparis@parisplace.org>
> > Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > Closes: https://lore.kernel.org/r/0584f91c-537c-4188-9e4f-04f192565667@=
collabora.com
> > Fixes: 0f8db8cc73df ("selinux: add AF_UNSPEC and INADDR_ANY checks to s=
elinux_socket_bind()")
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Thank you Micka=C3=ABl for the patch. Tested patch on v6.7-rc8.
>
> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

This looks good to me, and since it is rather trivial I'm going to go
ahead and merge this into selinux/next so it should go up to Linus
during the upcoming merge window.

Thanks everyone!

--=20
paul-moore.com

