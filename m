Return-Path: <netdev+bounces-150572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D71899EAB7D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A01169904
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AD7231C84;
	Tue, 10 Dec 2024 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9njf9N6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924F3594F
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821864; cv=none; b=YgpR5bIV7/QTlCmacYniVhj2ZDvfG7Adib7YD2uf2AR4LdSkh3ATrPntgiFrqJioGZf31ZC3mGVqax9c2QyRIWyG51slIY7DJPLHZgOLK2pGiXPjaMJU9XojyAKynaR0Y+s1U9Wg8izlBtH+ieG/TOXTy2pT1/rin9/0wT91eNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821864; c=relaxed/simple;
	bh=FYZIxQmGdoU5CuxW7RTygdZwcilWga9GvXgO/U4UFRg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fXBCXpFrh4//6Q8tnJhdi8ffAIyxirUCAFQ3sOWk+9OmHXr6Svhc+6UOoc+Syc/CRjaknMaGxYVlZByoyuvGB9Qu9ht+Q9aTt6MKulfz7AumqAwa8oI8sPmq1JuEmm9j75Dqzh2HkItTZz4SgOitn4TACJv+jIblO3LQeb+FK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9njf9N6; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30219437e63so21669201fa.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 01:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733821861; x=1734426661; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r0qQ2ezkJ7/oGwgp8X3sR05EJzkEKlPE/XPTMcBSgI=;
        b=V9njf9N697gmzGauCHenv1JnxzdsDUMkMAD300t5kmMDN030p099OEMvpVBoFeRPu5
         SIICHTYitph5nKQIOCT9ppitTgmHN2h2Lu7ptN3O4VodVzUj4JZsFLcD5cMBmEkRCa79
         sgbK0vunlo7ZZi7um1qUzTGPiG3O69e+y6Q56dwit4QMvzi8LL9yj568niTjjiQcGZ9M
         9HnxXdRQC1BlupyzaUtWMFSFgR1VroggcioXJYy9tn4g9QG8IkP2LEU/kr5Ps3rfU47k
         740aj3Es01dtUiuZKk8ardK5Bjy2rehXuB4jPwNnE8TPRT2j8Fql/KQlugODEBQv0Xt1
         yabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733821861; x=1734426661;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5r0qQ2ezkJ7/oGwgp8X3sR05EJzkEKlPE/XPTMcBSgI=;
        b=Psajt2WzbuUHcU52vWabDBsNRTgGhZAvWMvAii6pXl7vm/0LJ29vbsqSLWLXRA6jU9
         u3YNI1V3lZkN2TkgZWd2cRlTb6Dt1PHhC+eLBckozMHoydljPBkkXptSyh4Q+bqAOfSD
         2sZFwCxjkRUYGh7X2P7PXQIZmkTEv0AW7RezTJtgSORvovSLRQo5v/k66yhEi7a1G/TZ
         9WbvE75hI4VQZjwq69IgFlfmuqtVv3nIDTPK4WtoFiEQKmsfW3qOXYwoft6IVlgxc/Fx
         DYMhV9lxJWNXET0CxazU25WFXi21FAbjSsVob2quVVrU9DrVSuCbrQg/GMkLQfH1eNVI
         i/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXYYn2H+R4MsmpuYQlzx4snHdhld93oJ4zJTFqOvpccwPkmVhCTFfpWm1/YKO/oiU5pKNH2Hfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUbmYwtyTT1Yr5iUZNlrnlPmpuwZzqbx7W4ELZFr/glSS4mpis
	UsZLhXBFph51dafKNUV65/+AITMVvP26OD6685k1JPJ5nwUfI88t
X-Gm-Gg: ASbGncs4bzwrFWco7B/MLZqVhPoySmxxpdVeVaD3L4ncmRQI06eypakgjEtp5ayJk6y
	lhC+0Eo1EylcX4YXvrRRL4j1VrFFbLE6mqODax+DuXL9+YD1JYcuxRTLjf9D+VwGHhGaKUn56Zp
	qIREMPld4Nqdcw0MuLIo1INIAIxoca1bJSAtaNWb+9mbuUuxLKwyF9xQUVG9YlIMH6S1faPi0LK
	Zw5j8Fnp69BvARqKQUvEviN6esH79J2mLRvbZJPfSigb+E/kKVEzgQHYLlcEHkS8/yVTxPHjdHx
	nPAFr4uGQaDWpJN7dBqxMjcc5MpfyNka
X-Google-Smtp-Source: AGHT+IHKuLaZ67ed/t7U1qFVOtaSXGbhD9n6clTTeNbse3gM19AKEUQxc+NyN16SXnoXpPV07iTXyQ==
X-Received: by 2002:a05:651c:1141:b0:302:1cdd:73b9 with SMTP id 38308e7fff4ca-30232853420mr7201611fa.11.1733821860753;
        Tue, 10 Dec 2024 01:11:00 -0800 (PST)
Received: from smtpclient.apple (188-67-132-152.bb.dnainternet.fi. [188.67.132.152])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-300431a561csm9788831fa.116.2024.12.10.01.10.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:10:59 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [Cake] [PATCH net-next] net_sched: sch_cake: Add drop reasons
From: Jonathan Morton <chromatix99@gmail.com>
In-Reply-To: <87a5d46i9c.fsf@toke.dk>
Date: Tue, 10 Dec 2024 11:10:57 +0200
Cc: Dave Taht <dave.taht@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org,
 Jamal Hadi Salim <jhs@mojatatu.com>,
 cake@lists.bufferbloat.net,
 Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 Cong Wang <xiyou.wangcong@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C2055FB9-8EA4-486D-9654-84ED422A4A0C@gmail.com>
References: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com>
 <20241209155157.6a817bc5@kernel.org>
 <CAA93jw4chUsQ40LQStvJBeOEENydbv58gOWz8y7fFPJkATa9tA@mail.gmail.com>
 <87a5d46i9c.fsf@toke.dk>
To: =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)

> On 10 Dec, 2024, at 10:42 am, Toke H=C3=B8iland-J=C3=B8rgensen via =
Cake <cake@lists.bufferbloat.net> wrote:
>=20
>>> On Mon, 09 Dec 2024 13:02:18 +0100 Toke H=C3=B8iland-J=C3=B8rgensen =
wrote:
>>>> Add three qdisc-specific drop reasons for sch_cake:
>>>>=20
>>>> 1) SKB_DROP_REASON_CAKE_CONGESTED
>>>>    Whenever a packet is dropped by the CAKE AQM algorithm because
>>>>    congestion is detected.
>>>>=20
>>>> 2) SKB_DROP_REASON_CAKE_FLOOD
>>>>    Whenever a packet is dropped by the flood protection part of the
>>>>    CAKE AQM algorithm (BLUE).
>>>>=20
>>>> 3) SKB_DROP_REASON_CAKE_OVERLIMIT
>>>>    Whenever the total queue limit for a CAKE instance is exceeded =
and a
>>>>    packet is dropped to make room.
>>>=20
>>> Eric's patch was adding fairly FQ-specific reasons, other than flood
>>> this seems like generic AQM stuff, no? =46rom a very quick look the
>>> congestion looks like fairly standard AQM, overlimit is also typical
>>> for qdics?
>>=20
>> While I initially agreed with making this generic, preserving the =
qdisc from
>> where the drop came lets you safely inspect the cb block (timestamp, =
etc),
>> format of which varies by qdisc. You also get insight as to which
>> qdisc was dropping.
>>=20
>> Downside is we'll end up with SKB_DROP_REASON_XXX_OVERLIMIT for
>> each of the qdiscs. Etc.
>=20
> Yeah, I agree that a generic "dropped by AQM" reason will be too =
generic
> without knowing which qdisc dropped it. I guess any calls directly to
> kfree_skb_reason() from the qdisc will provide the calling function, =
but
> for qdisc_drop_reason() the drop will be deferred to =
__dev_queue_xmit(),
> so no way of knowing where the drop came from, AFAICT?

Would it make sense to be able to extract a "generic" code by applying a =
bitmask?  Leave code space for "qdisc specific" reasons within that =
mask.  Then people who don't care about qdisc internals can still =
reliably interpret the codes, even for future qdiscs.

 - Jonathan Morton=

