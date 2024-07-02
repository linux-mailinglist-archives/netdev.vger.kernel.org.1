Return-Path: <netdev+bounces-108609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 403A892489E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 21:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95401B24C76
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1491BC070;
	Tue,  2 Jul 2024 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpuBgQ3n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9408D129E93
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949890; cv=none; b=llmiB7rDUeWAFGHBcW6GNjMDiwFPGJEjGimj6cnCh51BXwUDbHLx+Drjop0s4sz3YAxnRHzpAejk2Jl0NXAa4dDIJKOU6an3KQmVVg0bwKdTO5zCuWlY1MAxGqYcswBkJ0I7rwLMd+/C+RrNlc17LrTBHhfALJYTvQ9PA0c5WZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949890; c=relaxed/simple;
	bh=aOfz34dFgXFB97J8VQtrDq5krfzNUqkhKMr1LwjjCTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Inf4KiQUGT13EnH6ado5rpadGbkTBeNVrmtiFdOHrBrGcDAKQhKMiOujRbuIN4ze+qp9LhmNKoMttbZmDcvKzficdsRa0LN8/2v4JBlfnjIyhDFIJ3NUbipAqCOSpxtJjTGBUDP+TXG4E6o4gFhOLlwM/Vjz5/H7zk1nmnawsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpuBgQ3n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719949887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5j3y7FvrG6C36L1Kpv/b7gP+G9+i+JtkI7sbx0d3Sg=;
	b=LpuBgQ3n+tTfw4UR1qdJxfibLXQxsXEHet5zdaGzlplsrLl0b3ZU8otL9hCXrKNPTW/1SD
	qRj3pkCgijCGUiDai+PBbRKzXvwVz0PfKS/8Faykwlxe41XuWsDbl1EgJDuZIGd0HtUnkr
	PDwAnCcsxMDXsgAv4zZpiMNf9rNF4Eo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-2mkRi8aQOE-rkjhKROBGRw-1; Tue, 02 Jul 2024 15:51:26 -0400
X-MC-Unique: 2mkRi8aQOE-rkjhKROBGRw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4467828ff99so4061871cf.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 12:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719949886; x=1720554686;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5j3y7FvrG6C36L1Kpv/b7gP+G9+i+JtkI7sbx0d3Sg=;
        b=odo9uCh8j0oPFJ+oKOiiK0zztwfMSfxglOlfjUj3y6oB4I4m2JHAzSjvig7pLMbi5p
         RApkcStHfMpI9i715nLkdS9eP5WNgnZsxnMw0LkYtwcEZBlkWvnrMeP2cN2HTTEmOcu9
         OJp64n9l1mkO9bmzMtbZKKwv+JzIlgtLQpAm2YngaJ1ooUauo/fXU+NxKy8QeKesi8e5
         3r46gtB2xpMU+BKPZBK19M1cUlwcfBisd5pSbOLhhi3oEUAVORh7Wt6xmFHYhYFnvF+o
         KisvMsQFNs1PVLpWiOffjJPpXeTzmr+tGxf1s/ZIauLwl1NVyGcqcRmPRenMmaN7uPko
         oC0g==
X-Gm-Message-State: AOJu0YydcS+Z3ACGEdvz++xVs3cBFwvP1joJe3p3jNKoPwjRPKo+JxUb
	4vlFpy/d1B6xv7W+7q1FtAjNsN8Dpuk54C5UKrcaf9EBAAvguPnV3VIvQA4B5TYpX9X1fIXzyWN
	Sh1NghVwUami7TUl12KhOgOHGvhDDYWR6fwd+WvWJMvFhxFMzjwq4HQHVbHcon85sa977etUoaV
	CKPBOhoTfwoTBBw/PYJt1tlGqDvr2AvUbTGsyV54o=
X-Received: by 2002:a05:622a:8f:b0:441:37b:cd7a with SMTP id d75a77b69052e-44662dd3cd6mr118220331cf.3.1719949885695;
        Tue, 02 Jul 2024 12:51:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4hwlfNq6sXpzAbT5fqmms6oe2dKH6S1qkYi50FXUYeZysniKc4LLxqOfEXvxIsoEhkY2OjVhiWZYujzFb6vk=
X-Received: by 2002:a05:622a:8f:b0:441:37b:cd7a with SMTP id
 d75a77b69052e-44662dd3cd6mr118220141cf.3.1719949885299; Tue, 02 Jul 2024
 12:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719518113.git.pabeni@redhat.com> <75cb77aa91040829e55c5cae73e79349f3988e06.1719518113.git.pabeni@redhat.com>
 <20240628191230.138c66d7@kernel.org> <4df85437379ae1d7f449fe2c362af8145b1512a5.camel@redhat.com>
 <20240701195418.5b465d9c@kernel.org> <e683f849274f95ce99607e79cba21111997454f9.camel@redhat.com>
 <20240702080452.06e363ae@kernel.org> <CAF6piCLnrDWo70ZgXLtdmRkr+w5TMtuXPMW9=JKSSN2fvw1HMA@mail.gmail.com>
In-Reply-To: <CAF6piCLnrDWo70ZgXLtdmRkr+w5TMtuXPMW9=JKSSN2fvw1HMA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 2 Jul 2024 21:51:13 +0200
Message-ID: <CAF6piCLD2ryqYX1xjifKjVF1KZLe4dUUDTk3ffZhGqS4jOFshg@mail.gmail.com>
Subject: Fwd: [PATCH net-next 1/5] netlink: spec: add shaper YAML spec
To: Network Development <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Madhu Chittim <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oops, I unintentionally dropped most recipients, re-adding them, sorry
for the duplicate.

On Tue, Jul 2, 2024 at 5:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
> On Tue, 02 Jul 2024 16:21:38 +0200 Paolo Abeni wrote:
> > > I see, I had a look at patch 2 now.
> > > But that's really "Andrew's use-case" it doesn't cover deletion, righ=
t?
> > > Sorry that I don't have a perfect suggestion either but it seems like
> > > a half-measure. It's a partial support for transactions. If we want
> > > transactions we should group ops like nftables. Have normal ops (add,
> > > delete, modify) and control ops (start, commit) which clone the entir=
e
> > > tree, then ops change it, and commit presents new tree to the device.
> >
> > Yes, it does not cover deletion _and_ update/add/move within the same
> > atomic operation.
> >
> > Still any configuration could be reached from default/initial state
> > with set(<possibly many shapers>). Additionally, given any arbitrary
> > configuration, the default/initial state could be restored with a
> > single delete(<possibly many handlers>).
>
> From:
>
> q0 -. RR \
> q1 /      > SP
> q2 -. RR /
> q3 /

Call this C1

> To:
>
> q0 ------\
> q1 -------> SP
> q2 -. RR /
> q3 /

Call this C2

> You have to both delete an RR node, and set SP params on Q0 and Q1.

default -> C1:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
   --do set --json '{ "ifindex":2, "shapers": [ \
                         { "parent": { "scope": "netdev"}, "handle": {
"scope": "detached", "id": 1 }, "priority": 1 },
                         { "parent": { "scope": "netdev"}, "handle": {
"scope": "detached", "id": 2 }, "priority": 2 },
                         { "parent": { "scope": "detached", "id":1},
"handle": { "scope": "queue", "id": 1 }, "weight": 1 },
                         { "parent": { "scope": "detached", "id":1},
"handle": { "scope": "queue", "id": 2 }, "weight": 2 },
                         { "parent": { "scope": "detached" "id":2},
"handle": { "scope": "queue", "id": 3 }, "weight": 1 },
                         { "parent": { "scope": "detached" "id":2},
"handle": { "scope": "queue", "id": 4 }, "weight": 2 }]}
C1 -> C2:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
   --do delete --json '{ "ifindex":2, "handles": [ \
                         { "scope": "queue", "id": 1 },
                         { "scope": "queue", "id": 2 },
                         { "scope": "queue", "id": 3 },
                         { "scope": "queue", "id": 4 },
                         {  "scope": "detached", "id": 1 },
                         {  "scope": "detached", "id": 2 }]}

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
   --do set --json '{ "ifindex":2, "shapers": [ \
                         { "parent": { "scope": "netdev"}, "handle": {
"scope": "detached", "id": 1 }, "priority": 1 },
                         { "parent": { "scope": "netdev"}, "handle": {
"scope": "queue", "id": 1 }, "priority": 2 },
                         { "parent": { "scope": "netdev"}, "handle": {
"scope": "queue", "id": 2 }, "priorirty": 3 },
                         { "parent": { "scope": "detached" "id":1},
"handle": { "scope": "queue", "id": 3 }, "weight": 1 },
                         { "parent": { "scope": "detached" "id":1},
"handle": { "scope": "queue", "id": 4 }, "weight": 2 },

The goal is to allow the system to reach the final configuration, even
with the assumption the H/W does not support any configuration except
the starting one and the final one.
But the infra requires that the system _must_ support at least a 3rd
configuration, the default one.

> > The above covers any possible limitation enforced by the H/W, not just
> > the DSA use-case.
> >
> > Do you have a strong feeling for atomic transactions from any arbitrary
> > state towards any other? If so, I=E2=80=99d like to understand why?
>
> I don't believe this is covers all cases.

Given any pair of configurations C1, C2 we can reach C2 via C1 ->
default, default -> C2. respecting any H/W constraint.

> > Dealing with transactions allowing arbitrary any state <> any state
> > atomic changes will involve some complex logic that seems better
> > assigned to user-space.
>
> Complex logic in which part of the code?

IIRC in a past iteration you pointed out that the complexity of
computing the delta between 2 arbitrary configurations is
significantly higher than going through the empty/default
configuration.

In any case I think that the larger complexity to implement a full
transactional model. nft had proven that to be very hard and bug
prone. I really would avoid that option, if possible.

Thanks,

Paolo


