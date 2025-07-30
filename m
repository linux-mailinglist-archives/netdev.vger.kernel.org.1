Return-Path: <netdev+bounces-211058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172D0B165EC
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 20:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B4258121E
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 18:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06A22E266A;
	Wed, 30 Jul 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="s6OB6v3I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727522E090B
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898395; cv=none; b=eLCzmKkUMT9EHHlVThlIf0SIPpvce9f/OGT7OvymKodiloF8KYIvJOytcnH5fyL8AoKlCeEBLlJrNeIC5azFIozjjjCjYwYXY04AbNiC9dJVI7uqNvWhDeW4AV0SwOMnD8wnxixZl0eQt8I7k0D3iF1V7cbs4DTfP58Ke3pYuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898395; c=relaxed/simple;
	bh=I0ZwDMJqH1cGH965TzuA0norHFP9EqhparS1jc5d+d8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ksu7nAXDXOKtA9S22pVkWRY+5lipkdA8CrkwKn7qXXEMYslwap/3d4yloDQ6RbpbIyz34kIF8YCrE+LdWSjarmvER7Ga5hey9zZQjt+PcrZSoF0XVkvjM++mQ7nL7g4M0mTFAz51Mxr/AnDNUuaQRQmGZzSGBiL4lduNctcZhUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=s6OB6v3I; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1753898385; x=1754157585;
	bh=I0ZwDMJqH1cGH965TzuA0norHFP9EqhparS1jc5d+d8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=s6OB6v3II/9QPlbMlgLSeP8y5sdgyDq/Em9s5WvXPVWa8AR8S9tl0XwaH4DyEEahI
	 wI7BhxJG6IMsYUTxYIEed6brmiY/GLSMy+G6EuLW97iI+df9I/Og9kPBBMGaUG1OhQ
	 HjP6rfE8gWRW0OSAi/kHEAjk9ohTejYtz9Il62pLXMKX16C0eLbq2Y7HdshPavlZsW
	 Do/heCkUIBtg5HuIT6Hd+zzy5wmOAt08qFT/trNohnd8zd8eSS06uvl8XLPD6xp1zF
	 eOTOYNRw2/CMlnVjEgscoFBVeIWAKUF1L4sUIt7NC9T1cvJYvv81kIRAH1JApQoGC+
	 HkLcNcS9OqaVg==
Date: Wed, 30 Jul 2025 17:59:38 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io, victor@mojatatu.com
Subject: Re: [PATCH net v4 2/2] selftests/tc-testing: Check backlog stats in gso_skb case
Message-ID: <TEN7juelysWV9lXIS7_4UsroEIbaZrmF-WdmPLPxsm6UBYNcd_kUFDQ59nOufuRqVltQs8v9Dadv4zugCJrcFnBVMZbJXx2bAvXBiP-eNSU=@willsroot.io>
In-Reply-To: <aIpcTv4ayyP+ya25@pop-os.localdomain>
References: <20250727235602.216450-1-will@willsroot.io> <20250727235642.216527-1-will@willsroot.io> <aIpcTv4ayyP+ya25@pop-os.localdomain>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: e9ab501f6eee4590f116ba029664cfe67aa5f799
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, July 30th, 2025 at 5:54 PM, Cong Wang <xiyou.wangcong@gmail.c=
om> wrote:

>=20
>=20
> On Sun, Jul 27, 2025 at 11:57:10PM +0000, William Liu wrote:
>=20
> > + "setup": [
> > + "$IP link set dev $DUMMY up || true",
> > + "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
> > + "$TC qdisc add dev $DUMMY root handle 1: tbf rate 8bit burst 100b lat=
ency 100ms",
> > + "$TC qdisc replace dev $DUMMY handle 2: parent 1:1 hhf limit 1000",
> > + [
> > + "ping -I $DUMMY -c2 10.10.11.11",
> > + 1
> > + ],
>=20
>=20
> Sorry, I still have troubles understanding the magic "1" here, and I
> don't find any other selftest using it. So why do we need it here?
>=20
> You said it is in the original reproducer, but the original reproducer
> is not part of tc-testing. This does not explain to me.
>=20
> Thanks.

Oh, that was the magic number you were referring to? That is the expected r=
eturn code for ping in that case, and must be specified if a command in the=
 setup returns non-zero.=20

This behavior is documented in the tc-testing READMEs, under creating-testc=
ases/AddingTestCases.txt (section SETUP/TEARDOWN errors).

