Return-Path: <netdev+bounces-177721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED25A7161A
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F329188EAF3
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03031DD539;
	Wed, 26 Mar 2025 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btJ0W+LX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD419CC27
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990091; cv=none; b=NLzKQN99yBKaoW1khQfjiJVdLRTgivY6WAc+rGwMjxg6e63C74deTLAczYu8FJMGtDbSk3gkfVrHadsrQ6/D4QwcMTK2v3LuZZlEdnSGwowYl/mn5x1HDgRP76uYBQ3DFLdbb/fc6dioKHJMrfQhA1Ue3gnIr6oSXt7Kr+Ft1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990091; c=relaxed/simple;
	bh=xfQ9jbdqgxf7qr65J5kEi0PI/AZxHZVS97mLpH7yEVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hP61HzvHyPV1olNu3baRDouQQ7okjFqlHo4uUlLEQYfrNUk2c+5U0kP4YS5H59kYzaqG5fe7O+FY3Q5KU5HBARKLWuTn0K5Siw5MMDndSaCGFwcnO2Ye9WN8EkCiuR3u41hZ2HnhGYTzMFYX4Gyy+om+t1+cMcghyqd3qHyOc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btJ0W+LX; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d445a722b9so34065555ab.3
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742990089; x=1743594889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es2PquojnR7T1i7GIJITT9DPzEpKO95LAlJnYqciQ/M=;
        b=btJ0W+LXbWsOGug0Hw7TkvNMuhSzYPJ8sodY25U3ykC7id3stQaFlZUae3KEfZ0qSR
         D7yujWNmVvO8goqUKTgPPRchfaHrYPIqAC4HkuK1ssSITbmer3AUoITzcxevXRbrJe7z
         COK0WrwELsfSXcUvJM79rr5APZDiW4n12OzURyxm5isCOfRgq9sKkZ37lAT7btKdEZid
         wdi5Byx/xAIL8+1Guhn2X0NgtujZdz92Dl2wGv7NPhERsn/PqmWDhuoxktr/ZF/1mN+k
         ZKvvQ1LSUyDqWKyYPNxCbYChoglJeSvm9wsTy4RNrbvIvcFmmx8/NDb5eFs0fF6lgsZ5
         cH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742990089; x=1743594889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Es2PquojnR7T1i7GIJITT9DPzEpKO95LAlJnYqciQ/M=;
        b=D391R9t1WzK6bXFpap4URvVze8Wowl8zHcxl4JffHUqkAIExb6aiQr5+f/H1+HhiXm
         3ROJXYemi5+U517gk28E77xMcG49yEvGi25VMjP528jKruex/l1beVLxBEypgDLtBw7S
         DkN+w7oNyHt8gKZhAnzmazYEO3legaqYWChRF3anGq56+SImkO43QjGgL4m8ipdHn7Zu
         m8Btvp+mgFpvDrS4qWpVn6C9Gy5cZI5be85pWEn3WxjPS9KIV/A2vxULLeMu8p97IIep
         QaZNsYBH+LLpc0Pu1wLijw2sEmu+p1gc/z2N/r5/abdSurgpl6pNXwhBxz+x7eDogeb2
         kMBw==
X-Forwarded-Encrypted: i=1; AJvYcCXynk7GUMLPsOdlBtPVtmIKK33zC1lE2qFY5XXLsZX+mxllYoP2SF6MDmuT6xekoxWzI+QSrfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/pGPCrhOXzGJUNcp1nubfZZNkKbPUaQWfdI5pB2+28a6hSFV
	OZl0Sd7t98/3ZI1nX6HAp8nRa4Lh9ZRY0QBG5ZWu4fQgD4m2ldtJ1x9x5OEgHDHmelLKvK3Ink+
	Cay9K0Cwzeiv1N61AZ93At4lgy3M=
X-Gm-Gg: ASbGncu9bqCWO5TnKKsvBoEqVPtG+QHg8N/I3gyikS3Y6G92uKsT8GIMUuXvs0z77bh
	MTXQHZS2/ucccl7rBdxYN37reS38KZc5V2GWUW9s+a6CBVbvP+sooOkerQpvW+dyqJFn9jEHkr2
	YUNOiFzGm8WF39TTxKoKoMQ64sUQ==
X-Google-Smtp-Source: AGHT+IHwMTYs5cIbFAsJroGxe/58YbGbeElqLgdcxFvFuAMnECOiBserqwzIjsnR3Osrq1fOleruQvI8N4pMjVeLDbw=
X-Received: by 2002:a05:6e02:1fe2:b0:3d3:faad:7c6f with SMTP id
 e9e14a558f8ab-3d5960cd064mr174378575ab.5.1742990089179; Wed, 26 Mar 2025
 04:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317120314.41404-1-kerneljasonxing@gmail.com>
 <20250317120314.41404-3-kerneljasonxing@gmail.com> <CANn89iLTb_JgLAKk5omW82SH-h8qtZLs54nX5c9Y9GbKdmTFgg@mail.gmail.com>
In-Reply-To: <CANn89iLTb_JgLAKk5omW82SH-h8qtZLs54nX5c9Y9GbKdmTFgg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 26 Mar 2025 19:54:12 +0800
X-Gm-Features: AQ5f1JrmOUpfh-Go0iisQBF3j7quVim7sF0b7nXPSmr70hJ9LcU1PHi_6Kj6dgU
Message-ID: <CAL+tcoAGf7mgA1J6nTxPrtq+4X90c0ikYMZTaE4cWBmiuuAKuw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] tcp: support TCP_DELACK_MAX_US for
 set/getsockopt use
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@amazon.com, dsahern@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 7:13=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Mar 17, 2025 at 1:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Support adjusting/reading delayed ack max for socket level by using
> > set/getsockopt().
> >
> > This option aligns with TCP_BPF_DELACK_MAX usage. Considering that bpf
> > option was implemented before this patch, so we need to use a standalon=
e
> > new option for pure tcp set/getsockopt() use.
> >
> > Add WRITE_ONCE/READ_ONCE() to prevent data-race if setsockopt()
> > happens to write one value to icsk_delack_max while icsk_delack_max is
> > being read.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  include/uapi/linux/tcp.h |  1 +
> >  net/ipv4/tcp.c           | 13 ++++++++++++-
> >  net/ipv4/tcp_output.c    |  2 +-
> >  3 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> > index b2476cf7058e..2377e22f2c4b 100644
> > --- a/include/uapi/linux/tcp.h
> > +++ b/include/uapi/linux/tcp.h
> > @@ -138,6 +138,7 @@ enum {
> >  #define TCP_IS_MPTCP           43      /* Is MPTCP being used? */
> >  #define TCP_RTO_MAX_MS         44      /* max rto time in ms */
> >  #define TCP_RTO_MIN_US         45      /* min rto time in us */
> > +#define TCP_DELACK_MAX_US      46      /* max delayed ack time in us *=
/
> >
> >  #define TCP_REPAIR_ON          1
> >  #define TCP_REPAIR_OFF         0
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index b89c1b676b8e..578e79024955 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -3353,7 +3353,7 @@ int tcp_disconnect(struct sock *sk, int flags)
> >         icsk->icsk_probes_tstamp =3D 0;
> >         icsk->icsk_rto =3D TCP_TIMEOUT_INIT;
> >         WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);
> > -       icsk->icsk_delack_max =3D TCP_DELACK_MAX;
> > +       WRITE_ONCE(icsk->icsk_delack_max, TCP_DELACK_MAX);
>
> Same comment here as the first patch, I think we should not change
> csk->icsk_delack_max in tcp_disconnect(),
> otherwise a prior setsockopt() setting is erased.
>
> Probably not a big deal, and if it is, could be fixed in a followup patch=
.

Got it. Thanks.

Thanks,
Jason

>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

