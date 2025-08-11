Return-Path: <netdev+bounces-212564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA4EB213B5
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C408E3A5A9F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DF82D4809;
	Mon, 11 Aug 2025 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="Rv38xt7F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31832C21FF
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934709; cv=none; b=BI+CNdgBITREm2Xtu2KICGR2xoaN76+1iDgwUm2IcmzVHbPDPWOtk6psuQd8/Nl3B2I7pzn/8DgIjpBnUg3jY2GQUQHmy3JxB5S5kM1juFVEssrgr0Luf2qft4NCuIs+Ye8u3XEErNTW2Lt0HJWt878eZFfbIDGjRvV1Bn8iAa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934709; c=relaxed/simple;
	bh=5OO/8NPYBy+U5v1clTfaibswb+7qly9G+F9e0ZZX4IE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLyQuOketiM+XChA5wFNkmKbH3iGbKfuMm4JvQAid7XRcPnr3lc6xOCWUJAw+DGvU5rr/xSqS/hlBjrhqgK8r0ADRCzUwy2Z9DXvrxpxQt7ZwNLUDANf3dDk4Zd36b/js9Xdnarm8UnOug0gxghKgdb08Y5NROISi9pg+XHD904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=Rv38xt7F; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1754934702; x=1755193902;
	bh=5OO/8NPYBy+U5v1clTfaibswb+7qly9G+F9e0ZZX4IE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Rv38xt7FHhcmna6gtZNAg4KWi+Od5nP/bBDebaInmZUGOSrbVByk6tUm5YZIhWNKc
	 k/lq130HH7a3yPTxflZ3cMXkmPy+mJQEYnZg3QIt7aJ6S093D/MHsebfJbay12T21F
	 trT1scwkr4efxcBveJbL19AqUowAasoBhFy9rrc5uuRC2/LdeFSnxMrRlXIZz35Rrd
	 4EmMXUuUkI+4ogtiFpWL6ruZyxTXSvKsAVxKAPxLuXrUC2FtTWZfaUotZNXO93wfqq
	 LVSfHknsvIoCp4ZqdPjIaUkAOoEPsdVybH0kwAPEXJst2z56I97gko1eeWJUmoAZwl
	 VrGmNgjZvNGPg==
Date: Mon, 11 Aug 2025 17:51:39 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io, victor@mojatatu.com
Subject: Re: [PATCH net v4 1/2] net/sched: Fix backlog accounting in qdisc_dequeue_internal
Message-ID: <Xd_A9IO0dh4NAVigE2yIDk9ZbCEz4XRcUO1PBNl2G6kEZF6TEAeXtDR85R_P-zIMdSL17cULM_GdmijrKs84RdMewdZswMDCBu5G7oBrajY=@willsroot.io>
In-Reply-To: <20250811102449.50e5f416@kernel.org>
References: <20250727235602.216450-1-will@willsroot.io> <20250808142746.6b76eae1@kernel.org> <n-GjVW0_1R1-ujkLgZIEgnaQKSsNtQ9-7UZiTmDCJsy1EutoUtiGOSahNSxpz2yANsp5olbxItT2X9apTC9btIRepMGAZZVBqWx6ueYE5O4=@willsroot.io> <20250811082958.489df3fa@kernel.org> <-8f3jdd-5pxHr0GW-uu8VtTzqDKDOyJohJ-soIwzRyqJUub186VYIxqNoGOTh8Oxtu1U0CEDl5h3N1c1D1jbn7nIlXUrNo55CHK5KcT23c4=@willsroot.io> <20250811102449.50e5f416@kernel.org>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 73fb0a6d0130d680b9e6b50a5cba3a980a319943
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, August 11th, 2025 at 5:24 PM, Jakub Kicinski <kuba@kernel.org> w=
rote:

>=20
>=20
> On Mon, 11 Aug 2025 16:52:51 +0000 William Liu wrote:
>=20
> > > > Can you elaborate on this?
> > > >=20
> > > > I just moved the reset of two cstats fields from the dequeue handle=
r
> > > > epilogue to the prologue. Those specific cstats fields are not used
> > > > elsewhere so they should be fine,
> > >=20
> > > That's the disconnect. AFAICT they are passed to codel_dequeue(),
> > > and will be used during normal dequeue, as part of normal active
> > > queue management under traffic..
> >=20
> > Yes, that is the only place those values are used. From my
> > understanding, codel_dequeue is only called in fq_codel_dequeue. So
> > moving the reset from the dequeue epilogue to the dequeue prologue
> > should be fine as the same behavior is kept - the same values should
> > always be used by codel_dequeue.
> >=20
> > Is there a case I am not seeing? If so, I can just add additional
> > fields to the fq_codel_sched_data, but wanted to avoid doing that for
> > this one edge case.
>=20
>=20
> This sort of separation of logic is very error prone in general.
> If you're asking for a specific bug that would exist with your
> patch - I believe that two subsequent fq_codel_change() calls,
> first one reducing the limit, the other one not reducing (and
> therefore never invoking dequeue) will adjust the backlog twice.
>=20

In that case, I think the code in the limit adjustment while loop never run=
, so the backlog reduction would only happen with arguments of 0. But yes, =
I agree that this approach is not ideal.

> As I commented in the previous message - wouldn't counting the
> packets we actually dequeue not solve this problem? smth like:
>=20
> pkts =3D 0;
> bytes =3D 0;
> while (sch->q.qlen > sch->limit ||
>=20
> q->memory_usage > q->memory_limit) {
>=20
> struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
>=20
> pkts++;
> bytes +=3D qdisc_pkt_len(skb);
> rtnl_kfree_skbs(skb, skb);
> }
> qdisc_tree_reduce_backlog(sch, pkts, bytes);
>=20
> ? "Conceptually" we are only responsible for adjusting the backlog
> for skbs we actually gave to kfree_skb().

I think the issue here is qdisc_dequeue_internal can call the actual dequeu=
e handler, and fq_codel_dequeue would have already made a qdisc_tree_reduce=
_backlog call [1] when cstats.drop_count is non-zero. Wouldn't we be double=
 counting packets and bytes for qdisc_tree_reduce_backlog after the limit a=
djustment loop with this approach?

[1] https://elixir.bootlin.com/linux/v6.16/source/net/sched/sch_fq_codel.c#=
L320

