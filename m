Return-Path: <netdev+bounces-108924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C18E9263E7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DA51C20F48
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CB1175555;
	Wed,  3 Jul 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXNSvUAt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85BF1DA319
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018426; cv=none; b=RR8J8QQ0G6k87vMC62ph5lxsrDXuHLuCItzwkmAYcKoZSVNtLXxC8mKsGKIUrmVBPeBb7SSpSkLq2e6uxs7E3qTc85VAqSowPK5XRREd6aZ/1OWt12CcfnzeVYiT4gXvE66uOYx0vWe8vCB5iJjqK3xZeRE1TYxOFkkiO7IQ+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018426; c=relaxed/simple;
	bh=mQoJUGSPu+xmR8tdVdqt/HpHLdAjOM4/KiUurS7dpdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDhk4CfhDh5nPjTv70KOI/niNm5D9SohhLoifZIx2kzHC9KC3zkzJKvrmz7VevdIeNlQRVow6gaTigdc13aqLSc5ECreVlhm2tVXAFvKwgs8RUG6MgWx1f9DPUtihDlovZOGHf8fEKWUWR1rR3DFJYcfHUTogaie6P0POnOPtMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXNSvUAt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720018423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L5hYtay6mUIz+0yb6315/NS4nBSKTq0BuEt9Qc8LHhg=;
	b=RXNSvUAtiaiceq+5cfb5yROaNtaYRIEelmwkjCN+OOlTAQ3Kg/eMAPruYxVed1knQXkrzm
	pUSZomH5JUdCEAJlNVt8zoA981djyGJRWaB83eMa35SPwNKoy/hnGw0KS0V1PtMuHXj1UY
	ThylrRrztJiSRwFmCPKn2ohhObeWJ9o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20--NqKGjCzNcSNWJlu66pNWg-1; Wed, 03 Jul 2024 10:53:42 -0400
X-MC-Unique: -NqKGjCzNcSNWJlu66pNWg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3678fcc4d7fso217042f8f.0
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 07:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720018421; x=1720623221;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5hYtay6mUIz+0yb6315/NS4nBSKTq0BuEt9Qc8LHhg=;
        b=vD/hE7Aq6KsuRC1R2qFZMbCtvBftPT0Vw/jDLa5yL6L9+sHQD14NVyWcTZfmOigyR1
         t4lG+Ib26aHkB8ppPyUOAynAy4+0z/D3AYw2aIvKORRwYnE3vjGxTUVWcvmlzDef2uGb
         Z0PTcFjftH2JDWdvGXt892HXBczVg97zk6gZ76Of9GTLOTG9O8U4qTNSKERf1Joy+5jb
         L+ANwL4aXwJ1ev9NLPK6UgCwWJOVPj6k1p1tvrs7wI6Np1qKYBJFxA7fPAzyS1WLldvl
         699ZZmfVweP1vln03Nrzn+fizuegN/E4aZ2NjCYMqAWLaxR2002xgE8uA38MtGDCEugp
         RcMA==
X-Gm-Message-State: AOJu0Yxoq2ynEMQFxvkaMFWkN/Vry17Oo4X+x64Cwteyun+656V9YO5g
	rpWQU5yTsJgkfY7q4uY9s+KpWA6vdLH7tQg41ij0L7XpOlZEVIejPhF3yC6pkIrp/orN0rMj1KP
	Nz5exYqtnTKk2rP2eVbyW43kHQrbU2Diw/qRsuK6iVQXzfWeIKGAprw==
X-Received: by 2002:a5d:6d81:0:b0:366:ea51:be79 with SMTP id ffacd0b85a97d-3677572e888mr8281003f8f.6.1720018420957;
        Wed, 03 Jul 2024 07:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESZvQvoCWvpFqWlC77SgKWYvZEC42vt+QT6vk4hVFvQevAGHk+v7Vmz3lKOAtjfoGrXeDjGg==
X-Received: by 2002:a5d:6d81:0:b0:366:ea51:be79 with SMTP id ffacd0b85a97d-3677572e888mr8280979f8f.6.1720018420467;
        Wed, 03 Jul 2024 07:53:40 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172b:1510::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678f41116bsm3121567f8f.116.2024.07.03.07.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 07:53:39 -0700 (PDT)
Message-ID: <2e4bf0dcffe51a7bc4d427e33f132a99ceac8d8a.camel@redhat.com>
Subject: Re: [PATCH net-next 1/5] netlink: spec: add shaper YAML spec
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
  Simon Horman <horms@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 03 Jul 2024 16:53:38 +0200
In-Reply-To: <20240702140830.2890f77b@kernel.org>
References: <cover.1719518113.git.pabeni@redhat.com>
	 <75cb77aa91040829e55c5cae73e79349f3988e06.1719518113.git.pabeni@redhat.com>
	 <20240628191230.138c66d7@kernel.org>
	 <4df85437379ae1d7f449fe2c362af8145b1512a5.camel@redhat.com>
	 <20240701195418.5b465d9c@kernel.org>
	 <e683f849274f95ce99607e79cba21111997454f9.camel@redhat.com>
	 <20240702080452.06e363ae@kernel.org>
	 <CAF6piCLnrDWo70ZgXLtdmRkr+w5TMtuXPMW9=JKSSN2fvw1HMA@mail.gmail.com>
	 <20240702140830.2890f77b@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 14:08 -0700, Jakub Kicinski wrote:
> Not sure if dropping CCs was on purpose ?

Nope, just PEBKAC here. Re-adding them and include your reply verbatim,
to avoid losing track on the ML

> On Tue, 2 Jul 2024 21:49:09 +0200 Paolo Abeni wrote:
> > On Tue, Jul 2, 2024 at 5:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > > On Tue, 02 Jul 2024 16:21:38 +0200 Paolo Abeni wrote: =20
> > > > Yes, it does not cover deletion _and_ update/add/move within the sa=
me
> > > > atomic operation.
> > > >=20
> > > > Still any configuration could be reached from default/initial state
> > > > with set(<possibly many shapers>). Additionally, given any arbitrar=
y
> > > > configuration, the default/initial state could be restored with a
> > > > single delete(<possibly many handlers>). =20
> > >=20
> > > From:
> > >=20
> > > q0 -. RR \
> > > q1 /      > SP
> > > q2 -. RR /
> > > q3 / =20
> >=20
> > Call this C1
> >=20
> > > To:
> > >=20
> > > q0 ------\
> > > q1 -------> SP
> > > q2 -. RR /
> > > q3 / =20
> >=20
> > Call this C2
> >=20
> > > You have to both delete an RR node, and set SP params on Q0 and Q1. =
=20
> >=20
> > default -> C1:
> >=20
> > ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
> >    --do set --json '{ "ifindex":2, "shapers": [ \
> >                          { "parent": { "scope": "netdev"}, "handle": {
> > "scope": "detached", "id": 1 }, "priority": 1 },
> >                          { "parent": { "scope": "netdev"}, "handle": {
> > "scope": "detached", "id": 2 }, "priority": 2 },
> >                          { "parent": { "scope": "detached", "id":1},
> > "handle": { "scope": "queue", "id": 1 }, "weight": 1 },
> >                          { "parent": { "scope": "detached", "id":1},
> > "handle": { "scope": "queue", "id": 2 }, "weight": 2 },
> >                          { "parent": { "scope": "detached" "id":2},
> > "handle": { "scope": "queue", "id": 3 }, "weight": 1 },
> >                          { "parent": { "scope": "detached" "id":2},
> > "handle": { "scope": "queue", "id": 4 }, "weight": 2 }]}
> > C1 -> C2:
> >=20
> > ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
> >    --do delete --json '{ "ifindex":2, "handles": [ \
> >                          { "scope": "queue", "id": 1 },
> >                          { "scope": "queue", "id": 2 },
> >                          { "scope": "queue", "id": 3 },
> >                          { "scope": "queue", "id": 4 },
> >                          {  "scope": "detached", "id": 1 },
> >                          {  "scope": "detached", "id": 2 }]}
> >=20
> > ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
> >    --do set --json '{ "ifindex":2, "shapers": [ \
> >                          { "parent": { "scope": "netdev"}, "handle": {
> > "scope": "detached", "id": 1 }, "priority": 1 },
> >                          { "parent": { "scope": "netdev"}, "handle": {
> > "scope": "queue", "id": 1 }, "priority": 2 },
> >                          { "parent": { "scope": "netdev"}, "handle": {
> > "scope": "queue", "id": 2 }, "priorirty": 3 },
> >                          { "parent": { "scope": "detached" "id":1},
> > "handle": { "scope": "queue", "id": 3 }, "weight": 1 },
> >                          { "parent": { "scope": "detached" "id":1},
> > "handle": { "scope": "queue", "id": 4 }, "weight": 2 },
> >=20
> > The goal is to allow the system to reach the final configuration, even
> > with the assumption the H/W does not support any configuration except
> > the starting one and the final one.
> > But the infra requires that the system _must_ support at least a 3rd
> > configuration, the default one.
>=20
> This assumes there is a single daemon responsible for control of all of
> the shaping, which I think the endless BPF multi-program back and forth
> proves to be incorrect.
>=20
> We'd also lose stats each time, and make reconfiguration disruptive to
> running workloads.

Note there is no stats support for the shapers, nor is planned, nor the
H/W I know of have any support for it.

The destructive operations will be needed only when the configuration
change is inherently destructive. Nothing prevents the user-space to
push a direct configuration change when possible - which should be the
most frequent case, in practice.

Regarding the entity responsible for control, I had in mind a single
one, yes. I read the above as you are looking forward to e.g. different
applications configuring their own shaping accessing directly the NL
interface, am I correct? Why can=E2=80=99t such applications talk to that
daemon, instead?=20

Anyway different applications must touch disjoint resources (e.g.
disjoint queues sets) right? In such a case even multiple destructive
configuration changes (on disjoint resources set) will not be
problematic.

Still if we want to allow somewhat consistent, concurrent, destructive
configuration changes on shared resource (why? It sounds a bit of
overdesign at this point), we could extend the set() operation to
additional support shapers deletion, e.g. adding an additional =E2=80=98del=
ete=E2=80=99
flag attribute to the =E2=80=98handle=E2=80=99 sub-set.

> > > > The above covers any possible limitation enforced by the H/W, not j=
ust
> > > > the DSA use-case.
> > > >=20
> > > > Do you have a strong feeling for atomic transactions from any arbit=
rary
> > > > state towards any other? If so, I=E2=80=99d like to understand why?=
 =20
> > >=20
> > > I don't believe this is covers all cases. =20
> >=20
> > Given any pair of configurations C1, C2 we can reach C2 via C1 ->
> > default, default -> C2. respecting any H/W constraint.
> >=20
> > > > Dealing with transactions allowing arbitrary any state <> any state
> > > > atomic changes will involve some complex logic that seems better
> > > > assigned to user-space. =20
> > >=20
> > > Complex logic in which part of the code? =20
> >=20
> > IIRC in a past iteration you pointed out that the complexity of
> > computing the delta between 2 arbitrary configurations is
> > significantly higher than going through the empty/default
> > configuration.
>=20
> For a fixed-layout scheduler where HW blocks have a fixed mapping=20
> with user's hierarchy - it's easier to program the shapers from=20
> the hierarchy directly. Since node maps to the same set of registers
> reprogramming will be writing to a register a value it already has
> - a noop. That's different than doing a full reset and reprogram=20
> each time, as two separate calls from user space.
>=20
> For Intel's cases OTOH, when each command is a separate FW call
> we can't actually enforce the atomic transitions, right?
> Your code seems to handle returns smaller the number of commands,
> from which I infer that we may execute half of the modification?

Yes, the code and the NL API allows the NIC to do the update
incrementally, and AFAICS Intel ICE has no support for complex
transactions.
Somewhat enforcing atomic transitions will be quite complex at best and
is not need to accomplish the stated goal - allow reconfiguration even
when the H/W does not support intermediate states.

Do we need to enforce atomicity? Why? NFT has proven that a
transational model implementation is hard, and should be avoided if
possible.=20

> IOW for Andrew's HW - he'd probably prefer to look at the resulting
> tree, no matter what previous state we were in. For Intel we _can't_
> support atomic commands, if they span multiple cycles of FW exchanges?

My understanding is that we can=E2=80=99t have atomic updates on Intel, fro=
m
firmare perspective. As said, I don=E2=80=99t think it=E2=80=99s necessary =
to support
them.

WRT the DSA H/W, do you mean the core should always set() the whole
known tree to the driver, regardless of the specific changes asked by
the user-space? If so, what about letting the driver expose some
capability (or private flag) asking the core for such behavior? So that
the driver will do the largish set() only with the H/W requiring that.

Anyway I'm not sure the mentioned DSA H/W would benefit from always
receiving the whole configuration. e.g. changing the weight for a
single queue shaper would not need the whole data-set.

> > In any case I think that the larger complexity to implement a full
> > transactional model. nft had proven that to be very hard and bug
> > prone. I really would avoid that option, if possible.
>=20
> Maybe instead of discussing the user space API it'd be more beneficial
> to figure out a solid way of translating the existing APIs into the new
> model?

Could you please rephrase? I think all the arguments discussed here are
related to the model - at some point that impact the user space API,
too.

Thanks,

Paolo


