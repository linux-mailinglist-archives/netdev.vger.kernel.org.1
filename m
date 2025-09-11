Return-Path: <netdev+bounces-222237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB48B53A72
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75DC27AC46F
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 17:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902BD248F48;
	Thu, 11 Sep 2025 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0plqE/jc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3942BAF4
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612103; cv=none; b=SQZlWrWCLRyk+28O6h85uJ1m/FVmUacDTFGKQYGpQ5mQL65g/2ApP08102tTF+Z9dpyP5R4IlxaPpKd8FD46qwRvefT9o7WotLNagC37QA1LiOEdLZQZKVZb1ytcHVZ3AsFdF9nM5vygG6ajn/hmnMd3GhDSuQGhCkBolZRLsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612103; c=relaxed/simple;
	bh=gLQWEnux8CDG1lZOgdG+XZZVtA2tiW0rOd121QfLiaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKc7ietc6Y+Gfz2DWhVcjssPAKVNc/NpABzWWd258N8makBOyCLAdAsjord6D3vbiwkKNgqvu/0CZ2jnKBbvnG3GKBKcbPZEhDlNrfKB650/dOTjs8PXfAL65Ul+Kgfe45PMftlzcnhkElwCkxaNSVcRgicmUeEGtRYKZvgau9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0plqE/jc; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b61161c30fso7828851cf.3
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757612101; x=1758216901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jnyr2RhM43Fghm/gxi8ZuECY2EbB59k1umJB5AwPiiE=;
        b=0plqE/jcDjemBrsDSYj1n3QVlbE6vY61RJU/gkWzMWjCeNqDrHQVszi+pJDp/TqOhI
         7CslAcg/SX40yBTF40qe6kwBPryvWN0dp0bFtdgFjfS8AXkNfV0S55OniGO1sd9hcpS+
         ndFj2AmCyYm5wzX/0zMvsCWBx6xBI2AMbe0a6Hz92AYVkk+kNhqUuj319ZGMlG9ZNTS7
         QElANva0xBVtap5zyw0z0nSgHkeZJOa2fdacsPNg/atSYrdy8zhOqVOK4zc9Gsm9jF2T
         B7vkcOTax8xUp89+mj1l/gDxh7zvIfXfvzcs37eMexHVhiuu4KHkodpLaWvp+N+bXRdF
         HrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757612101; x=1758216901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jnyr2RhM43Fghm/gxi8ZuECY2EbB59k1umJB5AwPiiE=;
        b=HmLWKbdUIUYUltvIvsHLn2fPgRRqSt2hyD4ZNNDX3TSSUdvbq/zaiAQ9oeNS9AiiII
         G0xLXZMQlffshE4LMUUae46Pg2mrUNf1fyTSb9i0XHh/xui+csUk1NksrFSAyd7OfMcX
         yfnFWVnZdN/J97VumkgGGcU4HGi6vCsJbdnCswh4aeRy4lX1aKY0JBsDh8UaWsBdXUNE
         HA6np/p0WxInNZL4Bb82Fvx1bcpGbY1fOoQewBK+q1LtBY47Y7XF3aa9uWPnPjIkVj9v
         XQCc4ZWPcUvcH/wbXql6BDpZPq8fW45R6QvLyivAWphNYl2QlN2RNsQacE1WIwtKz4kK
         wcvA==
X-Forwarded-Encrypted: i=1; AJvYcCW/lcYSJlYGKJksxrQi3+m9rVu73yxEINr4ZO+ZF6X/9D6YsSklpqJaUEu3G6MHKa0j0ys2noY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMGZ5B7ZXF+TbhlyyPi8+NaHuX37zvhnvhq6P3N+tpiC4EWoi
	edN8Q1zBU7SmuD4oW6iMJo+OLE1ivk0Mu76PMWF/1+qgR5dJvlneY79QpMe4KvHLn7HkFv3poLu
	e0ahstF9yGk2nT/0kBEdPy6lO7B+Dj1ipQOEjLkHQ
X-Gm-Gg: ASbGncs+15BFhIfHMbr+ln8TnKp/4tR5fI2UG1AeHZ31zP2u9uKwwKNUIBzCHo+ETYL
	gRt9kAVT6KNprzkpdp2BJSpkPYZW0uWPo2ic+8hPZoTIUTEMVHtFezykbgpwzCWa4Ta0++th30R
	CwDLHbi+4lYXXoAuXKAaF2pwOkKzRnk0AcA9uAGalKqBApR0/EaYlghqHaBnOgceuYtYfXfXi0t
	3FkjgD8m5t0p0c=
X-Google-Smtp-Source: AGHT+IHKroAVdIFkiQcHsbqR8SujA0I6SPrMLTEkHu2xiEnLvKyCJHkM2zmjE1MZ1aLaJgDMIFyavpeHm/PQHuYaepE=
X-Received: by 2002:a05:622a:5c87:b0:4b5:f045:90e1 with SMTP id
 d75a77b69052e-4b77d0aac13mr719231cf.63.1757612100275; Thu, 11 Sep 2025
 10:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com> <20250911030620.1284754-7-kuniyu@google.com>
 <CANn89iJnOZ-bYc9bAPSphiCX4vwy4af2r_QvF1ukVXF7DyA4Kw@mail.gmail.com>
 <CAAVpQUA3cnUz5=2AYQ_6Od_jmHUjS0Cd20NhdzfDxB1GptfsQg@mail.gmail.com>
 <CANn89i+dyhqbd0wDS+-hRDWXExBvic4ETm1uaM2y1G9H4s69Tg@mail.gmail.com> <CAAVpQUDgfLp3Ca8M0Z-Q1Jf00ufDsJJQCcSASTGBJkKTOGMO9A@mail.gmail.com>
In-Reply-To: <CAAVpQUDgfLp3Ca8M0Z-Q1Jf00ufDsJJQCcSASTGBJkKTOGMO9A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 10:34:49 -0700
X-Gm-Features: Ac12FXyBq1qQXBO8_P-6B55Kso0F0X0voFr94THCwmoysY0DivyfV0dqNGAN7vE
Message-ID: <CANn89i+hNzxZMgHXHsqZs7XaMcxQKyXK-aM43uqrS5Yj-iZNKQ@mail.gmail.com>
Subject: Re: [PATCH v1 net 6/8] tcp: Use sk_dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:24=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Thu, Sep 11, 2025 at 10:07=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Thu, Sep 11, 2025 at 9:53=E2=80=AFAM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> >
> > >
> > > Sorry, I missed this one.  I'll drop this patch and send the
> > > series to net-next.
> > >
> >
> > No problem.
> >
> > Main reason for us to use net-next is that adding lockdep can bring new=
 issues,
> > thus we have more time to polish patches before hitting more users.
> >
> > We also can iterate faster, not having to wait one week for net fan in.
>
> Thank you for explaining the reason.  That makes sense.
>
> Then should we keep or drop Fixes: tag ?  At least it will not land
> on the mainline and thus stable until the next merge window.

Fixes: tags are fine.

I usually do not add them for all patches, because I know that
everything will be
backported anyway because of dependencies.

