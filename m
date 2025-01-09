Return-Path: <netdev+bounces-156802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B588FA07DAD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB029168606
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B56221D80;
	Thu,  9 Jan 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="w1CovmHm"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8B21B192
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440519; cv=none; b=mV/cxvtCn6IoGHqNDxb1B7TiWSqZeV9DOUKyhIo0vSoYVdoGhTmLifERg/SOWtpeZHlHOfVpNOMcLZgqRylilRK6st3jn28xbYx0K/YPNIdPjMhMoHlxsV1OgBlDMEQyrml73eEBISMqPg1XC3cUyP0bWERmLIf+Sr+IK+4c62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440519; c=relaxed/simple;
	bh=ANbjk8gqhN0il2QO5ixDt4BuDf3BmOKAImjLOA2m5+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zi1FbP4Od9b2CVQwvx+EhMKkx4UGYZDiRM1SV//8q0D3ZhwMikqPjDvvgHlYU3yEPbvh/jklb6JvXXb5HMdr/GHSYM0xLABpda3zGWxsGT8KR0fDxBYPm/4rF0WJWbDXng73uhJiZk+bvZCvllAuQIzh+hhCpPwnv1jx3roLhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=w1CovmHm; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1736440514; bh=ANbjk8gqhN0il2QO5ixDt4BuDf3BmOKAImjLOA2m5+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=w1CovmHm+9bvL/zZ07yGdFcwZ1dyVGwl3B+98WXgP83QWcN3SEE49S8bOurAIKqRR
	 9B7U69aDFWjVFFnvQPWrgKsT3SDVpJupIFrIqipzixAdTvg0dDpPgBeI340aKJaMKc
	 cOu0VSt0A8TID14Gp+iUwr8rOVgKIt9pPNlXF/mYVPGXNyeZGStJz8YNxhSmuE7wZd
	 md2R3qJDq9cXB+UmaihGe+ApZpiM5CYk9GIrwoNfJKGAfB+sBk2khEjhUSMIn23bnK
	 VeptjQMywy4XRTGPp/J4GNPWsdUWYeYSsJBP/nzPPTGCZiM/gn1QSVPvj1UfboChdN
	 jfOIxInzjanbg==
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, cake@lists.bufferbloat.net, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] sched: sch_cake: add bounds checks to host bulk
 flow fairness counts
In-Reply-To: <20250109081811.01b7bad1@kernel.org>
References: <20250107120105.70685-1-toke@redhat.com>
 <fb7a1324-41c6-4e10-a6a3-f16d96f44f65@redhat.com> <87plkwi27e.fsf@toke.dk>
 <11915c70-ec5e-4d94-b890-f07f41094e2c@redhat.com> <87ikqohswh.fsf@toke.dk>
 <20250109081811.01b7bad1@kernel.org>
Date: Thu, 09 Jan 2025 17:35:14 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87frlshrnh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 09 Jan 2025 17:08:14 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> I guess I should have mentioned in the commit message that this was
>> >> deliberate. Since it seems you'll be editing that anyway (cf the abov=
e),
>> >> how about adding a paragraph like:
>> >>=20
>> >>  As part of this change, the flow quantum calculation is consolidated
>> >>  into a helper function, which means that the dithering applied to the
>> >>  host load scaling is now applied both in the DRR rotation and when a
>> >>  sparse flow's quantum is first initiated. The only user-visible effe=
ct
>> >>  of this is that the maximum packet size that can be sent while a flow
>> >>  stays sparse will now vary with +/- one byte in some cases. This sho=
uld
>> >>  not make a noticeable difference in practice, and thus it's not worth
>> >>  complicating the code to preserve the old behaviour.=20=20
>> >
>> > It's in Jakub's hands now, possibly he could prefer a repost to reduce
>> > the maintainer's overhead.=20=20
>>=20
>> Alright, sure, I'll respin :)
>
> Hold on, I'll do it :)

Crossed streams, but thanks! :)

-Toke

