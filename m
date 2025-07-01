Return-Path: <netdev+bounces-203026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F15AF031E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 20:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DBC3BCA04
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4073825B687;
	Tue,  1 Jul 2025 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="eVhEd7GK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFDF3596B
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751395617; cv=none; b=qSa7j9rgCbPl4nFAplu9rJq5UbFMVk+5o58Y+guyZbUlV9hDnDy/jY9RogD6XUGkFVtTESA78ZbUfJbWAQfTByln7n6MHE1zNrBfZsndA/nKlykk/v9qrj/KzmSh8aLg29OXkN+thjHJbhzqHsy3qYs2QwW1jHwUwVF/ogThXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751395617; c=relaxed/simple;
	bh=6dEzDrWxCiS29yD9qfBrd8uey/F+TyVCOmQGVmHV1sk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=monN8xpNT5bGwr4fAinZ04AAN8NMOdFtU96f02xfLoH/QVS26Qb2cRZ6hIiHosM10yHzr4Guo45RsW/TzeKAB2vgX7FR8kbJY9UixwV5KaJhtHRPmb+FEYcaHisVlmcTP/zpZVKuBKdIap/b+Prpb73Q/26cX/K7Y0ja4tbz2QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=eVhEd7GK; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1751395604; x=1751654804;
	bh=6dEzDrWxCiS29yD9qfBrd8uey/F+TyVCOmQGVmHV1sk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eVhEd7GKVg3b3c0p57HhGIgjZW645NkRElpbdMnQSmbUQbS04G7MCtdIA2lKiYPHM
	 3NJU3niB3j388eJ1HPCx/2/QGVhzGUVVC2zKIrIvUsicJDiNp8pfhLO6THT8zllLaL
	 FD0sdVQLZR9EMlwc2UVJU7KgFHquNpVa07W0cbaMv6Yjk1xlaTJEokDyk3i4JoXolY
	 Rb5AA+suOObbmgjkc/n+3HiDVhMze3mC3LPS9I9XZcw2sBPdQaVBx/DXWNv5JYmeBc
	 aw7VogDX2fdF0Z4HF80f+PoOKSuMjcSbVOoFwtrBPoldw//tJikBLhbhHxbsEJID9B
	 bX68NrlwOCTHw==
Date: Tue, 01 Jul 2025 18:46:38 +0000
To: Eric Dumazet <edumazet@google.com>
From: William Liu <will@willsroot.io>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, jhs@mojatatu.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, horms@kernel.org
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
Message-ID: <BsjpBIR8vpl-4AQId33pvJNPXsIqk6I32ejPJYaq0n0bqYuyjvURK7hlny4mawL5siHXHBUx9eSV44XrIMCRAMXcB6tuMJU3VH1vwVviEHA=@willsroot.io>
In-Reply-To: <CANn89iLp12_MzcniYqNU2zADVpG8Fs+ZiiMtpV3bCXW2z55DvA@mail.gmail.com>
References: <20250627061600.56522-1-will@willsroot.io> <aF80DNslZSX7XT3l@pop-os.localdomain> <20250628081510.6973c39f@hermes.local> <CANn89iLp12_MzcniYqNU2zADVpG8Fs+ZiiMtpV3bCXW2z55DvA@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 7ee10270b85e5feafb0bbe4ce5fa4b7b864ed7c0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, July 1st, 2025 at 6:11 PM, Eric Dumazet <edumazet@google.com> w=
rote:

>=20
>=20
> On Sat, Jun 28, 2025 at 8:15=E2=80=AFAM Stephen Hemminger
> stephen@networkplumber.org wrote:
>=20
> > Why a whole u32 for one flag?
> >=20
> > This increases qdisc_skb_cb from 28 bytes to 32 bytes.
> > So still ok, but there should be a build check that it is less than
> > space in skb->cb.
>=20
>=20
> I am pretty sure this will break some configs. This has been discussed
> in the past.
>=20
> I would guess drivers/net/amt.c would need some tweaks.
>=20
> commit bec161add35b478a7746bf58bcdea6faa19129ef
> Author: Taehee Yoo ap420073@gmail.com
>=20
> Date: Sun Jan 7 14:42:41 2024 +0000
>=20
> amt: do not use overwrapped cb area
>=20
> Also net/core/filter.c:9740 would complain.

In that case, maybe it is safer to just break a config very few (if any) pe=
ople use than risk spreading more breakage? I doubt people are stacking net=
ems together as they would pretty easily encounter the OOM loop issue - the=
 only legitimate use case is having multiple duplicating netems as children=
 in separate paths of the tree.=20

Of course, this can all be solved if people would be happy to add a bit to =
sk_buff. From some brief testing, this did not add a byte, and even if it d=
id, it shouldn't matter memory wise since we are backed by a slab allocator=
. And if we take that route, we might as well bring back the ttl fields Jam=
al was referring to in [1] and prevent potential future loop based DOS bugs=
.

I just hope this can be resolved soon, this bug report has been going on fo=
r quite a while (since May 6th).

Best,
Will


[1] https://lwn.net/Articles/719297/

