Return-Path: <netdev+bounces-215987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC0B313F1
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964CE1D20B90
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1D2FB639;
	Fri, 22 Aug 2025 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z/YYL4dX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702D2F0C7C
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855463; cv=none; b=QzmA0Smz5vMLe4tAETQvEvU0vOG9zBOWYoygFlzt+JaQ2m1u2p54D+wc8ply8aNShZeqQzxzLCneWHFforD/hfXOlIEzpzt3zVyQEMVPe3Q2XFeVjluR7dp1OEJNikktFVR0JlNtsDfRfnSkN1WtXXAPz/JjlyNDUtSI8hW0CZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855463; c=relaxed/simple;
	bh=KGxVlyktlvMg2J3Z7DFu9zukuowEvZnlKoc7wpeFJRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Frth7PkTcbnuIgA+RhIgEnOmYkkSVrKxAuyZTVbSVVR+++1luYNNLms4XO5lxyzu+Vxwm2aeXD+9H91FM3sPUaujjByCpNUoA1vIpMfgsOIgZUmS8HUUVvumJFQ8ijkAUkEHjSXBA4DkHtmRP/rsB1RO9Tets1W522BHQ1HCo3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z/YYL4dX; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b109c6b9fcso20499861cf.3
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 02:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755855460; x=1756460260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/wAkSeCI/p5BRy3MuUgX12/OtD3Iw4XHsnLLdUUoSk=;
        b=z/YYL4dXbgcDD8ip5kDceSvuckS6z100K0HReJ5GmpXLGwnTx31/Y1HFEWU9p+6QAY
         sQpkxHLCwHr1dMtlePe1gSnXrS9vqEyd1NYjNdFNVTggVhoyPAQEA8EorNNUomTzQU86
         oxAQJMZI4jMNy9jtPy7d66J+Txmj2QWNBO86Ufvv65+gyOTPzYLJZJjiadXbc0rlY74R
         4X4V2fsImkq5Cw2L/zBaQddDy4YLxSkHqOqzlVkvaxKVIj2NnXQ9V7gu/pOtzPb4thOr
         bMzVfqUK217LNesPetxygHgHFunH3zu3BBy6Reu0PvSDzbVGYRnyPevKGZkmRk7n8T4W
         TC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855460; x=1756460260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/wAkSeCI/p5BRy3MuUgX12/OtD3Iw4XHsnLLdUUoSk=;
        b=w1Qwz/Kk4vKTklzCBzn2m1S3e8VgiqhG6ycrHJDtNAF9hW08Ry/kFiyXNG2Ms28cvI
         Koz4QMoQ8H8JsKJgdm34UGdcseSMBtiaAIxMuw8gxh9U8b5T7O7bau93cXcxD1PFFDMX
         EnRoq4iQi9JJQY7mQzFK4k2kelgzXXvHbpgwyGhHOEVvt+fISR7SY0mhpIMPBPMfJ8Wt
         e7JKJfnMAi2Lg+fnECliiOtUKxMtz5pPTv3qrZfK+dBkNa2S+GsZbkIT6WAbaU78UxwE
         Sfon56C1HsjatiWD096gj5FY5oRAiWURkj8YVkzJpBBw2Sj273wQT9UWcg4sFqcr/W0M
         TUBw==
X-Gm-Message-State: AOJu0YyoQQJ6Cf1CClNhJxwqfdAYsHCeftRxbliGOyrOTIx74Mmx3lBc
	9oPPIbZDwt4H1J2Kn3Jwrf4NkiW/tUVlXdI7P6UMdtlONgHxexQbCIPh+clq/eFS/DlWXzMt+fA
	ZMQrojmbOfFbgDxE9JQhso9CrqEWhOItHvDB63Ogp
X-Gm-Gg: ASbGnct9i8J+uilfGa1xGhSmeEEaCW5ZMSD1NnprRxNuKj6t2L3GEJlZP7qo2NNodU+
	u34VcevVR7Hv7JU/VtJInv+vWHqU8LFCxVNyzOyRZ4JeKnSyS6g3+Q8p/ScWyl275HPFb3g/u6s
	Qhesb9JlCY8wjNJkdHAZiwawXDgTgIeqvin+R595OiNy4q0QKPLaUMHwA+15h4rnSMLRFHWuaCB
	Zz9n79U3DdcgU8=
X-Google-Smtp-Source: AGHT+IGCJ82v4V9A6pgJMz352LL/ClfK8PaNlBmvVnfkOmiDocAdZv4anLPGxqxW4fN2Gqkb+zb4WTSiJIxlj91+3qA=
X-Received: by 2002:ac8:5e0f:0:b0:4b2:9d9c:22d5 with SMTP id
 d75a77b69052e-4b2aaa1a280mr23744591cf.6.1755855459705; Fri, 22 Aug 2025
 02:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKgnLcw6yzq78CIP@bzorp3> <CANn89iLy4znFBLK2bENWMfhPyjTc_gkLRswAf92uV7KY3bTdYg@mail.gmail.com>
 <aKg1Qgtw-QyE8bLx@bzorp3>
In-Reply-To: <aKg1Qgtw-QyE8bLx@bzorp3>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Aug 2025 02:37:28 -0700
X-Gm-Features: Ac12FXzkoTpl_TV3jzySZ_fT8mz-36-tbCfSCwa_lYkImkPo_yzbxROcGrHuCsc
Message-ID: <CANn89i+GMqF91FkjxfGp3KGJ-dC6-Snu3DoBdGuxZqrq=iOOcQ@mail.gmail.com>
Subject: Re: [RFC, RESEND] UDP receive path batching improvement
To: Balazs Scheidler <bazsi77@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 2:15=E2=80=AFAM Balazs Scheidler <bazsi77@gmail.com=
> wrote:
>
> On Fri, Aug 22, 2025 at 01:18:36AM -0700, Eric Dumazet wrote:
> > On Fri, Aug 22, 2025 at 1:15=E2=80=AFAM Balazs Scheidler <bazsi77@gmail=
.com> wrote:
> > > The condition above uses "sk->sk_rcvbuf >> 2" as a trigger when the u=
pdate is
> > > done to the counter.
> > >
> > > In our case (syslog receive path via udp), socket buffers are general=
ly
> > > tuned up (in the order of 32MB or even more, I have seen 256MB as wel=
l), as
> > > the senders can generate spikes in their traffic and a lot of senders=
 send
> > > to the same port. Due to latencies, sometimes these buffers take MBs =
of data
> > > before the user-space process even has a chance to consume them.
> > >
> >
> >
> > This seems very high usage for a single UDP socket.
> >
> > Have you tried SO_REUSEPORT to spread incoming packets to more sockets
> > (and possibly more threads) ?
>
> Yes.  I use SO_REUSEPORT (16 sockets), I even use eBPF to distribute the
> load over multiple sockets evenly, instead of the normal load balancing
> algorithm built into SO_REUSEPORT.
>

Great. But if you have many receive queues, are you sure this choice does n=
ot
add false sharing ?

> Sometimes the processing on the userspace side is heavy enough (think of
> parsing, heuristics, data normalization) and the load on the box heavy
> enough that I still see drops from time to time.
>
> If a client sends 100k messages in a tight loop for a while, that's going=
 to
> use a lot of buffer space.  What bothers me further is that it could be o=
k
> to lose a single packet, but any time we drop one packet, we will continu=
e
> to lose all of them, at least until we fetch 25% of SO_RCVBUF (or if the
> receive buffer is completely emptied).  This problem, combined with small
> packets (think of 100-150 byte payload) can easily cause excessive drops.=
 25%
> of the socket buffer is a huge offset.

sock_writeable() uses a 50% threshold.

>
> I am not sure how many packets warrants a sk_rmem_alloc update, but I'd
> assume that 1 update every 100 packets should still be OK.

Maybe, but some UDP packets have a truesize around 128 KB or even more.

Perhaps add a new UDP socket option to let the user decide on what
they feel is better for them ?

I suspect that the main issue is about having a single drop in the first pl=
ace,
because of false sharing on sk->sk_drops

Perhaps we should move sk_drops on a dedicated cache line,
and perhaps have two counters for NUMA servers.

