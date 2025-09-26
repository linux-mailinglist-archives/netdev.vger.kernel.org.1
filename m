Return-Path: <netdev+bounces-226585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22897BA25B5
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 06:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC700385742
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ED71D6187;
	Fri, 26 Sep 2025 04:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQDOMMaN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3257718DF8D
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 04:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859381; cv=none; b=cmDRNz1elSbvnfHJDSc41rBSy4wyJZJ/yNxdWsdyYDAOKjgCK2G0JbRh2sh7zheS6xV4JwteVgAFfxQFedNJ8DOm5XmZ4QWJhmKDW3WpxeaUGFyJUqZ/09bNU7Smh+lyLxmTwOHrLKCeFptPBE9IElifghVJ5nvr0XwzOst2DLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859381; c=relaxed/simple;
	bh=+BjSD4n2cVq2pFB8mpK7sVp1EBc2XSr3oTlQo0E6yes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVCjkIeUgRKdW/BK8uOsLSTu7f4dbIw7/Xcyf3+LnMhPdEtlVIGUSMmTNGb1Mwu8nf/ge0aHuSGS1Y9UKrhLe53lhK1+tmSN3kol159QvRxg1L5NKJSaeFG2ENx/wF3FHXrMh8o87np/OYI92ILE9fIgxzBkcItviyta4Eq6vdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQDOMMaN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso2456658a12.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758859378; x=1759464178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTCUDZtLCId+TTYn2SSBMEZX1xtUVEdcX0YfJJ4Avjw=;
        b=SQDOMMaNB2K8c/KA0S3sexB2+N6io7by0h83jZHEWHQPMhlI5ZShp+fdi3bJBft1CN
         VPl2/hP/dMD9FEklOcmD0hc/IRi9GcOs6SKKxSD4ZM99Ydvg6UWQTb4nDkQAtPIc4eQL
         9f0cY8WzMxrBFGbMklJGx9Xq8fBXUHfBoYqpVz6g1r/DtDAKQ9VApmMYiM69ctqFha5j
         Ei5n57M+GurmSRiQBoK95iPuHES2cXtRXuHVhFPUkegQCLUs796fy2VbnxKoWjYkERG5
         jQi9CqOD9xWfs8ydYiwWvUv3qQIgNMPd4qd6WqXNbs7Fs/trOk+DNF8LfzQCaXoFThUN
         TODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758859378; x=1759464178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTCUDZtLCId+TTYn2SSBMEZX1xtUVEdcX0YfJJ4Avjw=;
        b=DhUe9F0GdqoA9Exja/+Mo6b36X+v+ykEBbVSXy4EcBoV1CNBkiMUji0kuG6k0F3lVo
         yHUEE5tNQcEcjplp4wWcKcrl2jJXuIdwGJRQi7ZbffyJT6KphIqp0MNfhowh2tVD+iwC
         YqbF1cpAi+P0CROCVMxalkXQMC8SkkH8TZd0S7bX7XJbCxAjIWRJYRExOQwA9Bm6ZPmC
         K0kLBaP7Dg9L/1BfYg8PMp9sUkknLnyBHXEcRgZYgAJvrcEMPFqRugsOVF5UQ58h5p4o
         9uyaRkw4p0TQxpPjwzrQN6iK+IdkP1A8JxQXog578UK06Wvyl/YWYS3Mf/AFdWBPNaol
         1LJw==
X-Forwarded-Encrypted: i=1; AJvYcCWOp+BjD5EsK9bgV7oUlTkib+6XNnYMilwZ64eYxIAzl8S9Q6iKg0UKUVgM3KUQUCVjbHjaKio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVmF03iEyVqDr+DymMSAopVxAxznNjONgRrZgUGDnpx88BB8v
	mLs2do3iE8MQa6VRbyEbwm8Xqi9/KnjhiZV0uNXHklYLZX3yihV+m1xHQOTQQDckb6KnpiCADE7
	kyL7sWuXOuxGXZ/PcnR1+XfzLQLLbAy5ZHrSvNMhO
X-Gm-Gg: ASbGncs5F0bjHxWAgvYVrl7NdwZ64KgvXKqd/8mElCHpjxq1KsDbJKPgsEUWsOHgF6d
	r/PfH5vXkhQKcZ2caQXXAVTisoAPXl+43rcGkvC5SfxaIhG/3IpVJqEWjxYsXJy+R2VytwL/AcI
	yG0pZRwFpjgbO23pYGGhMGFH2HZ3sDp4rc3jh4SxaTMv9UjPaevxeAaAbfwEHMbti3YPQtPXof0
	cLXtw7HfS9zXji5WipVkKRA1XhnBefgNy3alaDiOImFXmg=
X-Google-Smtp-Source: AGHT+IGzYNatQWB9vaoTJvVl+6ugXIaQiHU0Pj3mW9DlNJzFZlhvXShkZBeX9wWCYJbU93EgEPw/3sU24CM2G5JD3Vc=
X-Received: by 2002:a05:6402:268f:b0:634:a85c:8c9c with SMTP id
 4fb4d7f45d1cf-634a85c8e1dmr3418962a12.12.1758859378359; Thu, 25 Sep 2025
 21:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925021628.886203-1-xuanqiang.luo@linux.dev>
 <20250925021628.886203-2-xuanqiang.luo@linux.dev> <CAAVpQUDNiOyfUz5nwW+v7oZ-EvR0Pf82yD0S2Wsq+LEO2Y2hhA@mail.gmail.com>
 <5d7904e8-977e-499c-b877-901facac5dea@linux.dev>
In-Reply-To: <5d7904e8-977e-499c-b877-901facac5dea@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 25 Sep 2025 21:02:45 -0700
X-Gm-Features: AS18NWDYsn78Bu12GQIVmp_9veTEscznJ6kjuQeiT5VVyEn2z2oyKFLTttikLIo
Message-ID: <CAAVpQUAi2TLyODdvK=EAh0OyL_ZzLQWA_XrrQaspXTNdEmapWA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: edumazet@google.com, "Paul E. McKenney" <paulmck@kernel.org>, kerneljasonxing@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 8:23=E2=80=AFPM luoxuanqiang <xuanqiang.luo@linux.d=
ev> wrote:
[...]
> >> +{
> >> +       struct hlist_nulls_node *next =3D old->next;
> >> +
> >> +       WRITE_ONCE(new->next, next);
> >> +       WRITE_ONCE(new->pprev, old->pprev);
> >> +       rcu_assign_pointer(*(struct hlist_nulls_node __rcu **)new->ppr=
ev, new);
> > nit: define hlist_nulls_prev_rcu() like hlist_nulls_next_rcu().
>
> I'm wondering if defining a macro called hlist_nulls_prev_rcu() might
> be controversial, since it should actually be getting the prev->next
> rather than the prev itself.

See hlist_add_before_rcu() for an example:

    rcu_assign_pointer(hlist_pprev_rcu(n), n);

You can define hlist_nulls_pprev_rcu() and use it alike.

    rcu_assign_pointer(hlist_nulls_pprev_rcu(new), new);


[...]
> However, I noticed that in the definition of hlist_pprev_rcu(), it direct=
ly
> uses pprev:
>
> #define hlist_pprev_rcu(node)    (*((struct hlist_node __rcu **)((node)->=
pprev)))

Note it dereferences *((node)->pprev).  The macro is not to iterate the
lengthy cast.

