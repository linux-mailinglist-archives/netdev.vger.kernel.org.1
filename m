Return-Path: <netdev+bounces-233439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD07C1348A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44AF83B8C4C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15955220687;
	Tue, 28 Oct 2025 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWCiDV1t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C531EA65
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636477; cv=none; b=uoq3H3Fw/Mll66CyGX9pqv/NRgpIryHSMf0UA2sWSK3T5fFHJ9Vfyq58v9618ZQG+tFzxogVzDg5bZF2r3GXCzkEkhoMIajWC9c7ZST2euQf+3Q/viydsE/3cCWDu2+IfGAvXrp4Q+XvCBeOiKaYoCho6Chmk9SraB4OY7LZubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636477; c=relaxed/simple;
	bh=aaPc61tzyIIBCIRNQPCJZUdwHasH4IbzE328AM8VJLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TK6tNVvtNqortTVr/mvpy4oaIbkWxACGfJaQmFMIV4UEkTNuPNeAV/uN2xihuaVo8/MGS2Ia288R3Os+hm2oX3T8rGR/Sel8QOwE5hkI4WwZOPXfleBxxwsgBFIg83avjeq7RlgU/ebR2yGu62Cs/bhfPlYpiQCDlDJ+6H0HUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWCiDV1t; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so7343a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761636473; x=1762241273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhPFISuL8AMrLvK3sBAcAM7ACqODvhBbZ7iWqWP5FPI=;
        b=SWCiDV1t+37eW1J/bfZ8iCu/0pQR6O9B15++ADDDZsW9PGCjEkoc9iv/gcZcFcD7h4
         2gv/CuJe1J+FLREAHrVfT60isf4rTFxhoeloR0EeimGjmVzgF9nBrwfEPFKbUGWIpbf4
         lPapVjzPl4Ey844JXeZvzS+m7n/dlSitZufRNxOPPx7+plUm4fgAk5gpS8Tnb9J4mBPa
         HKIXrF6VYWslANJPzJ5zPiPeIJG4VWOGHeu1BAh7YvR31IqELpM7mSy3vIExwx7MUVXB
         xCE9Hx3Dey9+ewcf8EXHFBb3llM+g8XUmL/ddnkeJYFSzcCa+beTA2gBAtUwZ6qYgrxW
         nJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761636473; x=1762241273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhPFISuL8AMrLvK3sBAcAM7ACqODvhBbZ7iWqWP5FPI=;
        b=swQFCR3XclFe1Zk9RhStWV57N6DgnXTCgp4QaVElG9GN02DCIB+c5uBdavVidF6Jp9
         BzE68n5MaND0wQnhMdiieiahHep7sCYd1yfMFEnGtmmQqBOJazjf+LW4jFAng6usT5oc
         KzRKoK6CllrjxD/GVLhOJLECvdYJTuVEsJvxdL6RBl8ulzXokaQt6KsKQy8KhkQ4hW/A
         AwoyDGnNBKEhgCIvlzSjdwmWnZRFa7NNrEBx3kr6wGQJ58T/TqZRCiU2dkEEjOLervXM
         rmRWJpCflV8a7yTowlKK7EZr6uQi6PcaCD1gTIEnBp4D+++4KRzZqVKLwajs73larrD+
         xkNQ==
X-Gm-Message-State: AOJu0YyHev9DdjQ6PJMdgqICPf+2qmnlB6/YKjeFJwYexqeN64jMM1zv
	t6h631pS8vjYnv8lf96IRspa67N/fw/r7p1frXFZbmLq+LSE+5LInAII1I1pJY7tI3nX91IHE0J
	/G8doSAasjTAvKbDxGzsRVKL/AmHpXlq2oqdxqsRM
X-Gm-Gg: ASbGnctjXZQ/3LYSvr/P+NWQMTQGZh+W4xsTq6xh3SwklwIjvUhEO+DIuJ77k5ZTQgm
	Zx9TrbqFmczT4JRwT9VHmiPKMjWWbn+xTiADqEZbQzXOnE87HcSbIoYzoR5em5H2ZywZdUh1aUC
	LpM+BZ+PTt/TMhAnypIhYykP3X7OAuttkUakKdYx3Dwoj3HImsUj9CZ6B2ggQLVeij96knkSV1u
	Fv8Rxb4pN+oE6uznpwR+yUUdkC6J2qY7yvjeeBYZnlRM8wYS3VVxILYuA43buCkOweF6ug8Gwxu
	zRJyRmKepL/g4cLPA9WXUsLG
X-Google-Smtp-Source: AGHT+IFK4N3fvfWzAVYr39MHxBdsLLgIJLTz7XaWLZz9berkIoej9F7YBrThpPepdt4dTgrjYknL7kYAnFYuzX6H8nI=
X-Received: by 2002:a50:9fc5:0:b0:63e:6ea3:1675 with SMTP id
 4fb4d7f45d1cf-63fdc443884mr49651a12.1.1761636473419; Tue, 28 Oct 2025
 00:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028060714.2970818-1-shivajikant@google.com> <CANn89iL5nN6ZX+gJpEBXRiSdadaHvSPPDQ3QnUArBi1fnB0ddg@mail.gmail.com>
In-Reply-To: <CANn89iL5nN6ZX+gJpEBXRiSdadaHvSPPDQ3QnUArBi1fnB0ddg@mail.gmail.com>
From: Shivaji Kant <shivajikant@google.com>
Date: Tue, 28 Oct 2025 12:57:42 +0530
X-Gm-Features: AWmQ_bkqPt14edLLleEZkUN9j51sgOfbQctD8w9pDbXTzNjDy4-JzUWkA8Ky3C8
Message-ID: <CAMEhMpkdS61-bMbKEZSfu4Vo3JnpA-rxK7NDB3k+unw7wUQmCg@mail.gmail.com>
Subject: Re: [PATCH] net: devmem: Remove dst (ENODEV) check in net_devmem_get_binding
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Pavel Begunkov <asml.silence@gmail.com>, Pranjal Shrivastava <praan@google.com>, 
	Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Eric for pointing it out.
The description of the patch needs to be updated.
Will send a v2 with updated description in 24 hrs.


On Tue, Oct 28, 2025 at 12:33=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Oct 27, 2025 at 11:07=E2=80=AFPM Shivaji Kant <shivajikant@google=
.com> wrote:
> >
> > The Devmem TX binding lookup function, performs a strict
> > check against the socket's destination cache (`dst`) to
> > ensure the bound `dmabuf_id` corresponds to the correct
> > network device (`dst->dev->ifindex =3D=3D binding->dev->ifindex`).
> >
> > However, this check incorrectly fails and returns `-ENODEV`
> > if the socket's route cache entry (`dst`) is merely missing
> > or expired (`dst =3D=3D NULL`). This scenario is observed during
> > network events, such as when flow steering rules are deleted,
> > leading to a temporary route cache invalidation.
> >
> > The parent caller, `tcp_sendmsg_locked()`, is already
> > responsible for acquiring or validating the route (`dst_entry`).
> > If `dst` is `NULL`, `tcp_sendmsg_locked()` will correctly
> > derive the route before transmission.
> >
> > This patch removes the `dst` validation from
> > `net_devmem_get_binding()`. The function now only validates
> > the existence of the binding and its TX vector, relying on the
> > calling context for device/route correctness. This allows
> > temporary route cache misses to be handled gracefully by the
> > TCP/IP stack without ENODEV error on the Devmem TX path.
> >
> > Reported-by: Eric Dumazet <edumazet@google.com>
> > Reported-by: Vedant Mathur <vedantmathur@google.com>
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > Signed-off-by: Shivaji Kant <shivajikant@google.com>
> > ---
> >  net/core/devmem.c | 27 ++++++++++++++++++++++++---
> >  1 file changed, 24 insertions(+), 3 deletions(-)
> >
>
> Patch looks good, but the title should be improved a bit.
>
> "Remove dst (ENODEV) check in net_devmem_get_binding"
>
> It is not about removing the check, more about refreshing the dst if nece=
ssary ?
>
> Please wait ~24 hours before sending an updated version, to  give time
> for other reviewers to chime in.
>
> Thanks !

