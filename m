Return-Path: <netdev+bounces-134501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80576999E28
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88930B214A9
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 07:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D9120A5C8;
	Fri, 11 Oct 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O7HB6qYd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14FF209689
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632591; cv=none; b=YOaYuzaNi7ECp5i9enz1i42Etwif4aJlkNwdf9g+c5BUCT/QgPLn3MgwzP1yc80P2xjIt1EB0WHwa/KLZqsT7pu5LiF8X+CDESQwP0K/AeWr5b9IQRkym/aUIEInvo5FqCnzBmgVeRrfHgarqMiI29xqGCRR9ExkAtjbVT4tEqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632591; c=relaxed/simple;
	bh=I72W5/47T3MPbwQO0JwIp3qY15d1Kv0wv4dzjHfGKyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m80IYIFUm8wfeCH7p17dVE5XM+vOdtwvgHHTL2JRxNKItqXjsulpxQIsExJSb9b92XIgWK28p3UWZCVpGPZpEQXsSXaijnv+QgqAZhWTotJu6om7MWmBHc6GuYwTzcJfqesreZC6lUQimaMPcHy3W/m5YPJPFJaXqunI1m2fYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O7HB6qYd; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso26811821fa.3
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728632587; x=1729237387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynf/vTcEr5Vk9oZMDpk7UymPcv7siRgtJH7xtCNjIoY=;
        b=O7HB6qYdlgaIxAuXRM2EfhzN8yE/QqOe63v+flHZ/x5EtMRu9B+yH55O8F7PpshqB4
         JuSxyldC+5jtHko1VxGLG9T1zJafQhtbWcMwYKDxnN4JhHYQhgJmQqN0mROBiZCBOOi0
         ZuJqaMdxHNmcp4cFY9C6a2wvJQ/AqxhLYLW1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632587; x=1729237387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynf/vTcEr5Vk9oZMDpk7UymPcv7siRgtJH7xtCNjIoY=;
        b=RWi0cdy6YblgHqSdC+DWJ+jR76TVPhLplJzWLw/TW3wbxebs/XZX+cUy78TG40vlou
         cRFLP3c0eO5qD/sErH3qJVJzJw1SVYPC+2YnerYuf+20FL75pX1JpsKaOnfwpR/Rnndg
         Tw48URgc5CyoKdZs3JjLnIZhr/z1zrCiSqCxkIqi0NYyEf/aolpgMqXHF7USZAg7jH1U
         apt9TXauZwaoWvgLN2asCNhaAHDqlWT75Qtfcc9kJaGV/aGEEBKxyX4Ru4uPoXgq/UOQ
         dFY3L/VUlZsdTt43axe+4bLRGhGF4YgTOfg9kEJuVrmyC7FZAMRI7HV4uLwXtrdrvoAI
         VSjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9FraEszkgdXRKQZEC8kXHqj2I7hspda+bZcg1hps3L1aksWGV8DUg/WY2hkO2sSAuBGLTLxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzflOHocGmbE+LK8VzmJlSnZcJLLwEAZZT6Xzn/f/1YN5EPHIfD
	j9i9IvkryvSUAR2X8aYGGI3wwyWnqBqOxjrRPWmyNLrdb7OfSOT1baiF8NdBltTMUUc5c/v7h24
	mNECUYoN32fbME04MZ68hcnr3NSjaga3qkEci
X-Google-Smtp-Source: AGHT+IHiw3cjPkFjmzJXLfZ0q2VjdBVBPiSkTKGMSKIMgEgi4ot2t2ZiOCLGz9/vhAgLZW/ukTZKqe+kvgFm+WuJgZQ=
X-Received: by 2002:a05:651c:210f:b0:2fa:c59d:1af7 with SMTP id
 38308e7fff4ca-2fb326feb98mr11085211fa.9.1728632586997; Fri, 11 Oct 2024
 00:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011064427.1565287-1-dualli@chromium.org> <20241011064427.1565287-2-dualli@chromium.org>
 <2024101149-steadfast-skater-c567@gregkh>
In-Reply-To: <2024101149-steadfast-skater-c567@gregkh>
From: Li Li <dualli@chromium.org>
Date: Fri, 11 Oct 2024 00:42:56 -0700
Message-ID: <CANBPYPgyfZ0Jv2GEDsssvNx8=pcmn9p+K76uRwBSXhiVHGNPDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] binder: report txn errors via generic netlink
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dualli@google.com, corbet@lwn.net, arve@android.com, tkjos@android.com, 
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org, 
	cmllamas@google.com, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:51=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Oct 10, 2024 at 11:44:27PM -0700, Li Li wrote:
> > From: Li Li <dualli@google.com>
> >
> > Frozen tasks can't process binder transactions, so sync binder
> > transactions will fail with BR_FROZEN_REPLY and async binder
> > transactions will be queued in the kernel async binder buffer.
> > As these queued async transactions accumulates over time, the async
> > buffer will eventually be running out, denying all new transactions
> > after that with BR_FAILED_REPLY.
> >
> > In addition to the above cases, different kinds of binder error codes
> > might be returned to the sender. However, the core Linux, or Android,
> > system administration process never knows what's actually happening.
> >
> > This patch introduces the Linux generic netlink messages into the binde=
r
> > driver so that the Linux/Android system administration process can
> > listen to important events and take corresponding actions, like stoppin=
g
> > a broken app from attacking the OS by sending huge amount of spamming
> > binder transactions.
> >
> > To prevent making the already bloated binder.c even bigger, a new sourc=
e
> > file binder_genl.c is created to host those generic netlink code.
> >
> > Signed-off-by: Li Li <dualli@google.com>
> > ---
> >  Documentation/admin-guide/binder_genl.rst |  69 ++++++
>
> You add a file but not to the documentation build?  Did you test-build
> the documentation to see where it shows up at?
>
My bad. I met this [1] error when building the doc and forgot to add
Documentation/admin-guide/index.rst. Will fix this in v3, along with
other fixes.

[1] https://lore.kernel.org/lkml/20241008095808.1ee10054@canb.auug.org.au/T=
/

