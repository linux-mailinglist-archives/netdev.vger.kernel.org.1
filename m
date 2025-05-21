Return-Path: <netdev+bounces-192385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AABEABF9E7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78BB1782A6
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95A1220F57;
	Wed, 21 May 2025 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="gMPs+EAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B1D220F45
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841913; cv=none; b=HS3I9Hv8RRM2kLPFibY68LiNDB+TU984D9Vj4bc0xKqP58Bd9ptPQc+detwaAhxIHXNlLAJFbOW9p1ZGU3xp9tdqZxRjO/NgjX+R/c++srfnZGToQPyEH76rICQXpGg+5Z3k9Lr21Q+CCJtvV8ZZ79J6XyGMQLFDWdd/Nw8vQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841913; c=relaxed/simple;
	bh=GABW4EgmS2tVxZIXVlsuhQ0QvL/zEb/XTvwMt5CyKOQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwiJv3Ad5vjJSoqsQKXaTnTTxInYI2IR6MKgYZfkltUUn7ueDyyTFpwg5m0D4elKUeF1CD8isEHfNIu828pQKi12NPNoPVfCAO7CCF2CRYeTb0EzTbuUEoGYLjxnxck8bArBvBKNLz5lNQLwLvNKGvXUVUhv/e6SxSJilafptqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=gMPs+EAo; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1747841907; x=1748101107;
	bh=GABW4EgmS2tVxZIXVlsuhQ0QvL/zEb/XTvwMt5CyKOQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=gMPs+EAo8SGZWlmFeaOnAphLT7e5UA5DciK5Vq6mGSYqo1hsSIILYtROCnMZLFN/L
	 iGU1XySwfY4HD2BqfoIqycuy003JXUk14zUecbSzBXgq81rSEdf6eATmpz2WmiA8oL
	 jSnTN9lgKUm2DYmO0DysYdJ4wZ5j019/ssgFytHaKCreXsrzvJTG68LzBjlQHOqNHH
	 yJTNoSdZJiVNiMRLss1dOn6AHdv033xeg7aY4sETE3Ma2hWou+32vMs5GHbhGLxaed
	 kPfhGx09Q4MRa+Y8FsGRQQZ9oztqs/6ih2WMVtceX1yMSUWxTPZwqXRRjJzbxIsVxv
	 sHjkBftv0kMXA==
Date: Wed, 21 May 2025 15:38:21 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <ggSxq-NP-LDpev4N-rvkgs0Rrd0qOrbwtGRjcu4j4y3SuZth9k5RxTg2tFvhriQu4w_GxRPYjnkKN6VqFP6Q6FCyqWudz7_5iuOV06IEzgY=@willsroot.io>
In-Reply-To: <iEqzQsC-O2kAXqH1_58I59DIhBjRgebyGym2ZqyMEI3DaMtgsKSYR0KUsbxj5xqvfzf-4XzpM8dXvATHJhVVw3NedRdL3j1FJaqiXPlNWeE=@willsroot.io>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <CAM0EoMmKL68r_b1T4zHJTmdZPdCwS69F-Hh+0_ev+-5xPGy2=w@mail.gmail.com> <DglTO9NHmtFTRrCJf07R16_tYUUqoTV7M0hID_k-ryn5mAhe4ADq1mBpAuxNK24ZTnzIPaPq4x1woAtqZGXgAQS4k64C4SGRCfupe3H3dRs=@willsroot.io> <CAM0EoMmQau9+uXVm-vpuWqYjh=51a_CCS6orS6VrK6qBdddxrQ@mail.gmail.com> <iEqzQsC-O2kAXqH1_58I59DIhBjRgebyGym2ZqyMEI3DaMtgsKSYR0KUsbxj5xqvfzf-4XzpM8dXvATHJhVVw3NedRdL3j1FJaqiXPlNWeE=@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: aaa85548203f45bab96ec3ff05103144c2e1e0a8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, May 21st, 2025 at 2:03 PM, William Liu <will@willsroot.io> wr=
ote:

>=20
>=20
> On Wednesday, May 21st, 2025 at 11:06 AM, Jamal Hadi Salim jhs@mojatatu.c=
om wrote:
>=20
> > I am afraid using bits on the skb will not go well around here - and
> > zero chance if you are using those bits for a one-off like netem.
> > Take a look at net/sched/act_mirred.c for a more "acceptable"
> > solution, see use of mirred_nest_level.
>=20
>=20
> Ah ok, thank you for the suggestion. We will take a look at that then.
>=20
> > Not that it matters but I dont understand why you moved the skb2 check
> > around. Was that resolving anything meaningful?
> >=20
> > cheers,
> > jamal
>=20
>=20
> Yes - otherwise the limit value of the qdisc isn't properly respected and=
 can go over by one due to duplication. The limit check happens before both=
 the duplication and the skb enqueue, so after duplication, that limit chec=
k would be stale for the original enqueue.
>=20
> Best,
> Will

Hi Jamal,

If we do a per cpu global variable approach like in act_mirred.c to track n=
esting, then wouldn't this break in the case of having multiple normal qdis=
c setups run in parallel across multiple interfaces? We also considered add=
ing a nesting tracker within netem_sched_data itself (to increment and decr=
ement in the prologue and epilogue netem_enqueue), but that would break upo=
n having multiple netems with duplication enabled in the qdisc hierarchy. I=
f we aren't going to track it in sk_buff, I am not sure if this approach is=
 viable.

This brings us back to the approach where we don't allow duplication in net=
em if a parent qdisc is a netem with duplication enabled. However, one issu=
e we are worried about is in regards to qdisc_replace. This means this chec=
k would have to happen everytime we want to duplicate something in enqueue =
right? That isn't ideal either, but let me know if you know of a better pla=
ce to add the check.

Best,
Will
Savy

