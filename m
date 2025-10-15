Return-Path: <netdev+bounces-229728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D93BE0486
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2ADD4F39BA
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5062B302750;
	Wed, 15 Oct 2025 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulEKTBpr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E329B205
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554720; cv=none; b=mXkYWiCw/oypcXXWtAjoe5cXQ8EVsYtYJbIG++EfCgLRy5jr/jVekWbzezIFAg5w6/OerRLrB9f4ioxejGq00wf+Gu/rQgYJmedj0qpcMHKAP4J0tunHlMRUt16KjuEiKx8R1xze3B8r9yg3RYV0AYFEU5H268LQJpnltbFd/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554720; c=relaxed/simple;
	bh=b5wWPe5cNvLvLkG2x2JRUcg1UiLk0hyS1ikpUjlCASg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXGymhcANMwqDYEuIzVtVMlt+bxBU1z8xjBh/Zkyg1ikXuWeaxVVC6wxfVRUXnZ5ZJNGWat3zCSOChUZMGvpt3H1h0EKa0sbuv9Fp41tvnYEarE1B1nQ4rXY7LiE4Yv3GbqwWUU/AS7BQn6x+/gJ09O8EAqRpJvzxrw2Rgpg1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulEKTBpr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-634b774f135so11177747a12.2
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 11:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760554717; x=1761159517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5wWPe5cNvLvLkG2x2JRUcg1UiLk0hyS1ikpUjlCASg=;
        b=ulEKTBpr2jFRrBLqemU0YFnhmZy390pzlVUdxsLpch1l8OLHObO1FfBryXRaSAjTTw
         bM9cAkpLw+WDgfALPp3Cp05WdzELeNiOtQkSUExBFjDalfZaUj5Qvnl7CPNxSybcdfnL
         6SdkGFD28PKhCUnnNfRVK8W4J1pU4dAqlTau41dXmpWS1Fv1fkjf8DLYWPsk/RQkwZnC
         l7upTdA3ZPrcyIEDoHekn7ZfU6hnDhP92k7uVwHUHnuldw44cjHTi9ft8kywbqaa10KF
         fmSbnXS2buyYrmeYxn2pfTZYcccor+Vc3fR5qjIJhRsLz19BTHN2edkAiD2kckA2dtTa
         bcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760554717; x=1761159517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5wWPe5cNvLvLkG2x2JRUcg1UiLk0hyS1ikpUjlCASg=;
        b=G2C2rrKNnoQ2BGCzSOOohVJKZ8lmE71x9jR39lXrwt03u1alKtUXMeCLXdjiefmGYD
         10MiRhRs6AL+qWcooXz0mwV6bZtZ3iVPqh6alyQP+AFgbIKN8TFZTf2cRSudixqoH6mW
         tMgbjtwqgaESb+e5RGOBPH8vEJE3cg2PtnXR1ZeVCcR1wFdMLqSXWOsutXLy0faTCUfk
         4jqqFY1WVgeuso9v//oCZ/I3rGYtVCgZLIzaeIQvrBnfTstZ+8l5VMIrC9dFO1M7azcB
         jG5OcqfkHw86LZuyEoCSDniHlNKIiNSmUveHA/1skYZ3g0O7Y8QzQctY00I82HCbQy3L
         QAMw==
X-Forwarded-Encrypted: i=1; AJvYcCXKC5yR6loQ76iw2J2+pFYtHZxAwlAn/qpKaA05gWHTDCOC/SMAb5uOyRBTotXf663hZngp0zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiURD1i6b78i4iV1H4UNfzU8sD22WRZlovRBxfkpD5fKVe9bsM
	dPGmRyojBjqZUkuv3EygNTbJKfOYkVT1qW9jQ4CWYC7eutLV4DRuRJuRE2oEYdYo6E1khzd31da
	9rpxsGnH6v9hz2k58FEUuTIRciNxfP2kowOczZd4y
X-Gm-Gg: ASbGnctUb9UmCWEnoqQYpbRg7fs02GRKbNmlGu5cX4vGMI5Zt7N2SKfaqut6ZDj4xgn
	+rOzbax6NTDhKKutWxh3RSwBL3TGqJ9y3uhgJnP1ExJFxqcX+ndzvAg5ITNIf8QdhanReDkSOQJ
	tzWvws24vWyLqey0rMfgWBbHxPynC2O0CDHsli8oswRMEm0p37wNwRlyzar3Cj/Gy2OYjRXG9z6
	rDI5L+1Jc5bKJGL7pASYv90nU1tUNssrVOpfjaTdIyAv5TCfT+Cmlh6BULaiWlS6KKEu9bIOw==
X-Google-Smtp-Source: AGHT+IFXcR4/a/uWu2/COMG2rM2MXmYSeyVnHJVJ071uBYQhdmJ2s12d0Sglrmv8RLNynXPyIpu3cpFeni0ANJye8G0=
X-Received: by 2002:aa7:df92:0:b0:637:d2d6:dddd with SMTP id
 4fb4d7f45d1cf-639d5c6f393mr19995045a12.36.1760554716460; Wed, 15 Oct 2025
 11:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87qzvdqkyh.fsf@linux.dev> <13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
 <87o6qgnl9w.fsf@linux.dev> <tr7hsmxqqwpwconofyr2a6czorimltte5zp34sp6tasept3t4j@ij7acnr6dpjp>
 <87a5205544.fsf@linux.dev> <qdblzbalf3xqohvw2az3iogevzvgn3c3k64nsmyv2hsxyhw7r4@oo7yrgsume2h>
 <875xcn526v.fsf@linux.dev> <89618dcb-7fe3-4f15-931b-17929287c323@cdn77.com>
 <6ras4hgv32qkkbh6e6btnnwfh2xnpmoftanw4xlbfrekhskpkk@frz4uyuh64eq>
 <CAAVpQUDWKaB6jH3Ouyx35z5eUb9GKfgHS0H7ngcPEFeBdtPjRw@mail.gmail.com> <cfoc35cqn7sa63w6kufwvq7rs6s7xiivfbmr752h4rmur4demz@d7joq6oho6qc>
In-Reply-To: <cfoc35cqn7sa63w6kufwvq7rs6s7xiivfbmr752h4rmur4demz@d7joq6oho6qc>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 15 Oct 2025 11:58:23 -0700
X-Gm-Features: AS18NWCCDR5AqbojOF4FmdytvEGOhlifSaI5ISfKVV9sd4073qOpkYTl1jQCD34
Message-ID: <CAAVpQUCNV96vOReAeVHpwbUg9XJDLRTkHmcABh9dhm=f8p5O+g@mail.gmail.com>
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 11:39=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Wed, Oct 15, 2025 at 11:21:17AM -0700, Kuniyuki Iwashima wrote:
> > On Tue, Oct 14, 2025 at 1:33=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Mon, Oct 13, 2025 at 04:30:53PM +0200, Daniel Sedlak wrote:
> > > [...]
> > > > > > > > How about we track the actions taken by the callers of
> > > > > > > > mem_cgroup_sk_under_memory_pressure()? Basically if network=
 stack
> > > > > > > > reduces the buffer size or whatever the other actions it ma=
y take when
> > > > > > > > mem_cgroup_sk_under_memory_pressure() returns, tracking tho=
se actions
> > > > > > > > is what I think is needed here, at least for the debugging =
use-case.
> > > >
> > > > I am not against it, but I feel that conveying those tracked action=
s (or how
> > > > to represent them) to the user will be much harder. Are there alrea=
dy
> > > > existing APIs to push this information to the user?
> > > >
> > >
> > > I discussed with Wei Wang and she suggested we should start tracking =
the
> > > calls to tcp_adjust_rcv_ssthresh() first. So, something like the
> > > following. I would like feedback frm networking folks as well:
> >
> > I think we could simply put memcg_memory_event() in
> > mem_cgroup_sk_under_memory_pressure() when it returns
> > true.
> >
> > Other than tcp_adjust_rcv_ssthresh(), if tcp_under_memory_pressure()
> > returns true, it indicates something bad will happen, failure to expand
> > rcvbuf and sndbuf, need to prune out-of-order queue more aggressively,
> > FIN deferred to a retransmitted packet.
> >
> > Also, we could cover mptcp and sctp too.
> >
>
> I wanted to start simple and focus on one specific action but I am open
> to other actins as well. Do we want a generic network throttled metric
> or do we want different metric for different action? At the moment I
> think for memcg, a single metric would be sufficient and then we can
> have tracepoints for more fine grained debugging.

I agree that a single metric would be enough if it can signal
something bad is happening as a first step, then we can take
further action with tracepoint, bpftrace, whatever.

