Return-Path: <netdev+bounces-201985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B89AEBD9A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 18:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA7A3AB04A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB7D1C6FFD;
	Fri, 27 Jun 2025 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KzuF/3X8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9E52E9EDF
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042177; cv=none; b=qeh7PtxOmxRVu/rh7NXRSQiW27mscTA9gfcZEs2VYMdBBulTug8xQsZbn74/DZfzyD5GM2FZbaYNGZeU7TeDN2QrmEEZJj+UtbwmF1in3oKjCz4OGl0j0TTe80gnhGp4xtNLLHrd8rSaIv3X3sIMgulrP9lx7ER2HAnAa+CIFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042177; c=relaxed/simple;
	bh=SelXsOpJPpBVq3Z1qhmJlyDtW/NcEicHSc7S8A8ke8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehlCj3FeJ9Mndc7ii8BKVZYWuqz00CRlnK9v1rvfN4lk4Prt2G+eF03/fwQDnlQ1fJf8lLmyZzHIuBcAP/mVnmFEkxr6kyS7+mQNx34HQiEMuK6iHvvZIVFdA47qHFFdmpoj0+N7j9yd/2DlWBwnO6L7zrte6dW3OagWAeXWDHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KzuF/3X8; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b31befde0a0so62415a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751042174; x=1751646974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9uFq+Culf2tZDEJLXMXIPEST1YhLiTj+7ujSQkyy7A=;
        b=KzuF/3X85KN3WtDUiwJnlyUy2eD6AAXW+z4WNJ7Xg14qzrz1Neyyat+hEzybodwNHZ
         XsXmvCng+rEShiwhpRwcvbIKRAy3SP0dXzaEgDd44v7hqHHTiirCIOffsrX13zS+tISm
         m0vOJrGr8hLBcZ/nqhCNNNrGd6f2z1XG9ovv/GnT/2cGCEiRej0bAd382igDWxLqtTLv
         AbythgQKzJBf6/AfuNE15LGhja/e75t2XkWobVR9lr7oNNpRfoRd+/dMoPN12ewpqHML
         RqQJ/VXwdqvkws8KKIoPbecrhqe2i28rK94dvt17pXzT51Qp1uehUWgupiNotc5KAXjc
         9XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751042174; x=1751646974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9uFq+Culf2tZDEJLXMXIPEST1YhLiTj+7ujSQkyy7A=;
        b=syQtQFkA462si/FHTL+SIGfdhtJYyo4vhGFfpdksmF98XAylSbmGLrQ5NYE8v6jOZ0
         Ct6hDYissMPWKTuvrl/3FTz2qf0fWoxesyEGKfi923Qro/ijTnGh4wsSgqeYXqSCZaEX
         sm+EhSWh6zDlEnZwTI+Vm+5cFqWB7RPUc4ZppElqNOOTW0D7VyzMcajIfq1VGT6IgGqb
         vYn0kSIM0yNp64OUEdIK2KqookHTeGki1XJL5LK3wKvxFcB+VYbIjYc9kfbkwTJ5k2jG
         oWc+zMo/TNLcxJFCEQsIYwVAAFZ+3QapBdTt/RuKNgGe2gbBHTOKlZxxZ0Ouz4wb4GLc
         tHBA==
X-Forwarded-Encrypted: i=1; AJvYcCUWNIhLQdXmUhUqIDDKIA84DCoM1j2dYBzIxkhj7tuhcsJLxTXSKxlXj5t5EakFLeN5KFAC4Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqUHgi0KgumWBIJnifTMBtH2z9ditYHFMgWF92QR//q84jhl4b
	9EL0SkUw4+f+16iLp0zfS/5g80PWHqELJ9FDY7NqCbxcnT8TMNraqW7sVuegBAufu+VfN/1R/Ry
	iULcgQNC36TfDPZ0LofmwVn42q6HKiJJj84hPNaxD
X-Gm-Gg: ASbGncs6uqXji33/LwQ7BvXSRK8cI16LPMvJqOxnnDtYB7kUIMylbi38K4r8f+MIrCE
	mR1f54SSmTEsF4Kwx2GUbplq5JuXQFcwF4UZC4Mu0UFvYguRqJaQiqfDvvoPPQiFUOvHGQ1Bv5d
	kGDdkKL+2nOJ54/v8zC9D37XR9sUINWCm/9vR8SUNNOQ==
X-Google-Smtp-Source: AGHT+IFNjKi8C6c7nnx7PGroQNsHo/c52j8M3ikpeGKa5ljuR5VMCkV9Zs+gh94Wq4j24mmnu4wfVgkVXh5eDzISiRU=
X-Received: by 2002:a17:90b:1dd1:b0:311:e4ff:1810 with SMTP id
 98e67ed59e1d1-318c8ec5353mr5151413a91.3.1751042173674; Fri, 27 Jun 2025
 09:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <6c33dd3e-373a-41b3-b67a-1b89ce1ab1b5@redhat.com>
 <CAAVpQUAT8gs10P9DbwfMNZu2xyzEChgMPMFzO9VKdDJT2oPcrw@mail.gmail.com> <b2484912-e36b-4f04-a6e3-c0b1f92ce1c8@redhat.com>
In-Reply-To: <b2484912-e36b-4f04-a6e3-c0b1f92ce1c8@redhat.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 09:36:01 -0700
X-Gm-Features: Ac12FXwVZeyKUHxt4rBH1mw6gms10jX3-_V3rrzzSWW4mCDIWowkNRn8DKfcIOw
Message-ID: <CAAVpQUCEU22kbELMYhWk=9SCMz3jbLhhp62fDQjEN7qXHoAqVQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 00/15] ipv6: Drop RTNL from mcast.c and anycast.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:32=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 6/27/25 2:49 AM, Kuniyuki Iwashima wrote:
> > On Thu, Jun 26, 2025 at 6:27=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 6/24/25 10:24 PM, Kuniyuki Iwashima wrote:
> >>> From: Kuniyuki Iwashima <kuniyu@google.com>
> >>>
> >>> This is a prep series for RCU conversion of RTM_NEWNEIGH, which needs
> >>> RTNL during neigh_table.{pconstructor,pdestructor}() touching IPv6
> >>> multicast code.
> >>>
> >>> Currently, IPv6 multicast code is protected by lock_sock() and
> >>> inet6_dev->mc_lock, and RTNL is not actually needed.
> >>>
> >>> In addition, anycast code is also in the same situation and does not
> >>> need RTNL at all.
> >>>
> >>> This series removes RTNL from net/ipv6/{mcast.c,anycast.c} and finall=
y
> >>> removes setsockopt_needs_rtnl() from do_ipv6_setsockopt().
> >>
> >> I went through the whole series I could not find any obvious bug.
> >>
> >> Still this is not trivial matter and I recently missed bugs in similar
> >> changes, so let me keep the series in PW for a little longer, just in
> >> case some other pair of eyes would go over it ;)
> >
> > Thank you Paolo!
> >
> >>
> >> BTW @Kuniyuki: do you have a somewhat public todo list that others cou=
ld
> >> peek at to join this effort?
> >
> > I  don't have a public one now, but I can create a public repo on GitHu=
b
> > and fill the Issues tab as the todo list.  Do you have any ideas ?
>
> Not really, that is way I asked ;) Hopefully someone ~here could help.

I'll create Issues as todo in this repo (now importing net-next)
https://github.com/q2ven/small_rtnl/


>
> Quickly skimming over the codebase I suspect/hope mroute{4,6} should be
> doable (to be converted to own lock instead of rtnl).

Looks doable to me too :)


>
> /P
>

