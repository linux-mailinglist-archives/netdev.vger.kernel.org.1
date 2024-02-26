Return-Path: <netdev+bounces-75020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02525867BD0
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF4B1F2A9E9
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7398712D740;
	Mon, 26 Feb 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEiTnkVf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954C12C803
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964674; cv=none; b=NIXhbt+4blPid+wbkkCsikScU8CVCofKVy79gCadU7TUtIhFef1TOA+nrcPZN9SMrL/0TpADC+/YCNYMeGvq4ge5sEA+n5+8klqQxwajFX+uqIltvFAg1uunMG+pvmyrHg3kPxP6JvHy7KfIsXw6Z0h0ncEXt3F6APslsBOcqRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964674; c=relaxed/simple;
	bh=87/3HQ2nXNOR8v198nPxfdavzNcBdWKhfFhhpkuAC0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osHDH48M/7lYULCMocJfdls23Alq6zi2ZAuMjggbq5WQ9PE6I2GNA5Osq4+zPFssHgxn5wT6RRGmrQdC7hZUv/jPJVoOfxnrLbjFbjrEPq3JKxNxLkWFCZlJJfqqcG5vpMRw4Hic9E0QIXEOd3o0ikLP7fx32ZVfEAdxlWkthRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEiTnkVf; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56619428c41so6543a12.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 08:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708964671; x=1709569471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqr/fjPVAmWXbrUzan4Cqqe9iQZo4lb55vnOkr6z4tg=;
        b=aEiTnkVfNCyZ5ZraOCQUC7XkhYkmgk5fcsqcwg15oxzxr6+EeB1PjMYtcMuCVDeAv6
         Ue67TX4DHwqsTYw4VNbpesmnqqm1lrRcdEtizT71+MFL0pfoFKzk7dYr9nKmlActIlTd
         WEr8aWqX7Q7uevU2en2VZY6sOlCWvpLqW2ZiCu7Nmth1597pli8fADsfF9AtxmFjI3s8
         ArctKlaxy6T54whXcd1H1UVqaG04Y/nC95LbusTRvHmdk2L21JxV4Lyt7z88D7Husq3z
         O6+PLihtH0g6j3Yrj1u1OlysvwE2H1YfMNo0iHSB0N2M81D4svLWdA5gqCBhPnqp7Ku5
         7KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708964671; x=1709569471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqr/fjPVAmWXbrUzan4Cqqe9iQZo4lb55vnOkr6z4tg=;
        b=dHgjB3FJ/ZtNjhcmmXiADFFEmfcHsm50+i1ipeHEwnZKFpbJrrh6YxMfPw3MntVn9K
         UJ5lqyZay40jXiVrIeRDV2nSHuAnurSD0GzjM3+tWLI/g0Q3+6eqS0vHhPlx2XOaUCKL
         R9Y9rKHUEuDbdPXjwfKtMb6Ij6fH+TQYSsKu2M9hAYgfKkA+T5kcuoNobN2yWvSMhX0T
         W6L1WlAcr3sCfku3nHLyedlDvdp1vNiqqeMW9CQBCplUMg3Q2D8tUwmtC43PGokoJ7Wx
         ffoD0vVxNmDZKvtMQjQQUFulhvWkG6jNeFn2E0SKJ+HCkxaj87G2e9XQbOr0rmkZ6d68
         roOA==
X-Forwarded-Encrypted: i=1; AJvYcCXFcrOkzLwJ/ovPrdV7BdOiqK8NGzwR5t5pEstV36/97Ou97ZvkjB+EL4iPIgES2vp/ZKswU3WPSFkCu9BHFHKaNqKlOg32
X-Gm-Message-State: AOJu0YzGHpTZ7I3PXp8G4uAfn0jpHNTuXkUCPWKCE8s76nJlYSq1BKjS
	ThHC7xYJbt0Pdu+HIbctvogh4GD2nMi0t+k7A8omvvHMYmnOlFl5KhObxweXXeJfHaPKy1oDZRk
	TArfr5wS92oI25BRmjT0UGMzEZaP09jJJtoTW
X-Google-Smtp-Source: AGHT+IH8NDYG1n5G1TrzHjH2rL0+zr1j17UkmcIJ0XN8JXyl6efZFGGAgHdHxgBUTiXr3vupd0Y2tQSRaI4hmfO5QU8=
X-Received: by 2002:a50:9f28:0:b0:562:9d2:8857 with SMTP id
 b37-20020a509f28000000b0056209d28857mr336964edf.6.1708964670588; Mon, 26 Feb
 2024 08:24:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226155055.1141336-1-edumazet@google.com> <20240226155055.1141336-3-edumazet@google.com>
 <Zdy3tnU-QZUda0HI@nanopsycho> <CANn89iKM1yJ-uUtZ+uRkVdir8vbck8593RAxZt7fzNvFHU5W_Q@mail.gmail.com>
 <Zdy54LUdeUGH2OuB@nanopsycho>
In-Reply-To: <Zdy54LUdeUGH2OuB@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Feb 2024 17:24:19 +0100
Message-ID: <CANn89iLXrjT=JpAJNuvtqTxPC+jKto8+j62KOd5nPk25QqoOAg@mail.gmail.com>
Subject: Re: [PATCH net-next 02/13] ipv6: annotate data-races around cnf.disable_ipv6
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:18=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Mon, Feb 26, 2024 at 05:14:36PM CET, edumazet@google.com wrote:
> >On Mon, Feb 26, 2024 at 5:09=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Mon, Feb 26, 2024 at 04:50:44PM CET, edumazet@google.com wrote:
> >> >disable_ipv6 is read locklessly, add appropriate READ_ONCE()
> >> >and WRITE_ONCE() annotations.
> >> >
> >> >Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> >---
> >> > net/ipv6/addrconf.c   | 12 ++++++------
> >> > net/ipv6/ip6_input.c  |  4 ++--
> >> > net/ipv6/ip6_output.c |  2 +-
> >> > 3 files changed, 9 insertions(+), 9 deletions(-)
> >> >
> >> >diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> >> >index a280614b37652deee0d1f3c70ba1b41b01cc7d91..0d7746b113cc65303b5c2=
ec223b3331c3598ded6 100644
> >> >--- a/net/ipv6/addrconf.c
> >> >+++ b/net/ipv6/addrconf.c
> >> >@@ -4214,7 +4214,7 @@ static void addrconf_dad_work(struct work_struc=
t *w)
> >> >                       if (!ipv6_generate_eui64(addr.s6_addr + 8, ide=
v->dev) &&
> >> >                           ipv6_addr_equal(&ifp->addr, &addr)) {
> >> >                               /* DAD failed for link-local based on =
MAC */
> >> >-                              idev->cnf.disable_ipv6 =3D 1;
> >> >+                              WRITE_ONCE(idev->cnf.disable_ipv6, 1);
> >> >
> >> >                               pr_info("%s: IPv6 being disabled!\n",
> >> >                                       ifp->idev->dev->name);
> >> >@@ -6388,7 +6388,8 @@ static void addrconf_disable_change(struct net =
*net, __s32 newf)
> >> >               idev =3D __in6_dev_get(dev);
> >> >               if (idev) {
> >> >                       int changed =3D (!idev->cnf.disable_ipv6) ^ (!=
newf);
> >> >-                      idev->cnf.disable_ipv6 =3D newf;
> >> >+
> >> >+                      WRITE_ONCE(idev->cnf.disable_ipv6, newf);
> >> >                       if (changed)
> >> >                               dev_disable_change(idev);
> >> >               }
> >> >@@ -6397,15 +6398,14 @@ static void addrconf_disable_change(struct ne=
t *net, __s32 newf)
> >> >
> >> > static int addrconf_disable_ipv6(struct ctl_table *table, int *p, in=
t newf)
> >> > {
> >> >-      struct net *net;
> >> >+      struct net *net =3D (struct net *)table->extra2;
> >>
> >> How is this related to the rest of the patch and why is it okay to
> >> access table->extra2 without holding rtnl mutex?
> >
> >table->extra2 is immutable, it can be fetched before grabbing RTNL.
> >Everything that can be done before acquiring RTNL is a win under RTNL pr=
essure.
> >
> >I had a followup minor patch, but the patch series was already too big.
>
> I see, so this hunk should be part of that patch, not this one, I
> believe.
>

If I send a V2, I will add the followup patch instead.

IMO this is a minor point.

Thank you.

