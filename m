Return-Path: <netdev+bounces-238752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D154AC5F0DC
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840383AE37B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 19:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18632D5C83;
	Fri, 14 Nov 2025 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOFttZZ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19E2737F6
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148926; cv=none; b=SpH4vQGyR6DM/pvvlUoN/Ag0Q2dRaw4yXTE861349W0eb5jtP8opRC7oWRlsGm38dAZYtsKm0xHaBTyyH+VXjXJXsng1nXlFb98DEb68NGU2ZMWCkzeeN5OEdJ5vT2+pQTOdNW0eC35812/iIVRp6Od86nQOPcFjaEom8OK8LBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148926; c=relaxed/simple;
	bh=9eMxeiX03Oi6/OSxJN/2eYcBBRh5oM+aDMKMEqPeLe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQeAmw3K3U3igfcATYIRL5jn8Npun+QaqiAZSFusiqO9NzbAFgBQuEajSvv37MSotfvQbJniNlcO9rlkw/tbovlEiWr4x1gSiVk6pmsrzqDjON3r9X7UTuX8U+BUl261JA1HPULu3OJlE1aaUqZUKFPI7fNKDsFpVmWB3mliduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOFttZZ6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e88cacc5d9so18799451cf.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763148924; x=1763753724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjap5B4hbhG6CrR9fhjTfkiLE2gk/0gKUlcAFKk/CqU=;
        b=JOFttZZ6BM/Y0mW3qxvHm5mxHXozcv3zXg2yWZSysE7Wx7C/pMRnT/XX2yDZH8WTM5
         J9CBVQyvLIrjPCDo7sS1lXezBwiYPOviPiL55nGw58ILWcPDZFbsadTiYPk5JhI8F+hn
         I8xIpia8WG1qz/wA+cHhMmUsKJpL69HixFwxOa0B5MLePh/gcvSdP65lhAntVlcwFgb9
         YS/Q5yUdsCRnuzIOkXyZFrUOyQSUmelKA+2G3PdNU0lMhifLr4LxqCrVRxeoUJ94MU0g
         2QCSksc9qddofXrlc/e5ErekTw6D5P7jP1DtU9oBxnr4uWLqCTt4QRqWd4mRqvzDmpAS
         KUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763148924; x=1763753724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fjap5B4hbhG6CrR9fhjTfkiLE2gk/0gKUlcAFKk/CqU=;
        b=SF0Ffvqz6Uc+dyI3YFDUDaZb1FRDTGdEvlt1Fe/6MOkHAfNJfzdTPz1kL0Z1JlDxHI
         9p1HyjkYZqbMraqNrzuXz4htmBaivwqdVJI0U5pC1j+0HUu8UUM93ymqFPRIbp9Fk91Q
         qZ4qijXhHvYkj4bGcFNRmZvwfP5ZybhGuj3haGlVRqhc5qfqLsFZ7ektC27NM+/F27PA
         Wsl+m5A6xIrbRO5zjm2lHpYvBlCA0D5WF/dVGF5fNCf+TkuvJdxIOZNUJdM/fXR1gZ3j
         jm3UYF53qA0KdLf6T8boHCep0qgGbNYJ/8iu8ABZEZo+MrvnMBCDsPEPb1gxsSOQ0yoG
         TEfA==
X-Forwarded-Encrypted: i=1; AJvYcCXDV4oOpGOBlYYCFcz5i87AKeNYRVTR9uf1o/dGvNh7Q4IMA6xVrKhdKPEA769tt04Tq8/radY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQMEQNrb07SzgcD4Jahi5fPhMOf+FMZQqKMYmbOD4MvPofzu/
	DrNo/v9KV4v9umkYtRP680687mVWDot7/irbSEiMw4y9MJbyvW1wkHiyuRXCCcnqATE2r96Ye2D
	HxyWbVDW9XqSxmqtDYrJA8ZozBmXz3G6Cxz1cFoYH
X-Gm-Gg: ASbGncvt1GoEbhWvgTeBFPUEbt4ujtQVNm6oIH22TRPqPFecswHU3/WwWS4Vc2dW8Sk
	GuIlZHHOeHyiEqxs1QXhLiwk+OFxYl333QGibDfPBFM0kRP/likL6Wy8N5TsiNjIDb8R5MY1LJA
	X3rbZ4lWpFTmUOcEIbAy+Nwvc5MXVibXlMJcGIrZciVOXVHZBd/brlACO6M2OmIq3jBhTkIc7L8
	RQSrQFETvIEFAp/oPkMWlsKDZnN8MkFMmNSBbchji1+yTvTfDpupP2CmFyWHrAiIHafGQ==
X-Google-Smtp-Source: AGHT+IGAAZnnt5Qff0ytEP9f66MMzNwLULnrZEsXVoJrCbFKbM5OeXGWwF8EewcHQDhFWjm5mu9aGZrQg/ZYaCOP5bM=
X-Received: by 2002:a05:622a:1455:b0:4ed:b06b:d6a5 with SMTP id
 d75a77b69052e-4edf20628e4mr66694291cf.4.1763148923754; Fri, 14 Nov 2025
 11:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114135141.3810964-1-edumazet@google.com> <CANn89iLp_7voEq8SryQXUFhDDTPaRosryNtHersRD6RM49Kh0g@mail.gmail.com>
 <20251114080305.6c275a7d@kernel.org> <CANn89iJr4R4dgFmqCPtSWqgvPiY5YB4svD_4D7tO1BoZr=Y1-Q@mail.gmail.com>
In-Reply-To: <CANn89iJr4R4dgFmqCPtSWqgvPiY5YB4svD_4D7tO1BoZr=Y1-Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Nov 2025 11:35:12 -0800
X-Gm-Features: AWmQ_bn8yMiWMn2GDIexAs1PAa8WGRXy7u-p0NuSrFYPUCWLjPvbS68CRwzGUDA
Message-ID: <CANn89iLJGwBunzho9+Q1aRDgA3ihw=OrEuT3cBDiZn2QmVNkWA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reduce tcp_comp_sack_slack_ns default value to
 10 usec
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 8:17=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Nov 14, 2025 at 8:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Fri, 14 Nov 2025 06:08:58 -0800 Eric Dumazet wrote:
> > > On Fri, Nov 14, 2025 at 5:51=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > net.ipv4.tcp_comp_sack_slack_ns current default value is too high.
> > > >
> > > > When a flow has many drops (1 % or more), and small RTT, adding 100=
 usec
> > > > before sending SACK stalls the sender relying on getting SACK
> > > > fast enough to keep the pipe busy.
> > > >
> > > > Decrease the default to 10 usec.
> > > >
> > > > This is orthogonal to Congestion Control heuristics to determine
> > > > if drops are caused by congestion or not.
> > > >
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > >
> > > This was meant for net-next, but applying this to net tree should be
> > > fine as well.
> > >
> > > No need for backports though.
> >
> > Sorry to piggy back on a random post but looks like the changes from
> > a ~week ago made ncdevmem flaky:
> >
> > https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-fbnic-qemu=
&test=3Ddevmem-py
> >
> > Specifically it says:
> >
> > using ifindex=3D3
> > using queues 2..3
> > got tx dmabuf id=3D5
> > Connect to 2001:db8:1::2 37943 (via enp1s0)
> > sendmsg_ret=3D6
> > ncdevmem: did not receive tx completion
> >
> > This is what was in the branch that made the test fail:
> >
> > [+] tcp: add net.ipv4.tcp_comp_sack_rtt_percent
> > [+] net: increase skb_defer_max default to 128
> > [+] net: fix napi_consume_skb() with alien skbs
> > [+] net: allow skb_release_head_state() to be called multiple times
> >
> > https://netdev.bots.linux.dev/static/nipa/branch_deltas/net-next-hw-202=
5-11-08--00-00.html
> >
> > I'm guessing we need to take care of the uarg if we defer freeing
> > of Tx skbs..
>
> Makes sense, or expedite/force the IPI if these skbs are 'deferred'
>
> I did not complete the series to call skb_data_unref() from
> skb_attempt_defer_free().
> I hope to finish this soon.
>

In the meantime we could add this  fix:

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f34372666e67cee5329d3ba1d3c86f8622facac3..12d65357fc7f83cfa9f8714227c=
7b69035441644
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1480,6 +1480,9 @@ void napi_consume_skb(struct sk_buff *skb, int budget=
)
        DEBUG_NET_WARN_ON_ONCE(!in_softirq());

        if (skb->alloc_cpu !=3D smp_processor_id() && !skb_shared(skb)) {
+               if (skb_zcopy(skb))
+                       return consume_skb(skb);
+
                skb_release_head_state(skb);
                return skb_attempt_defer_free(skb);
        }

