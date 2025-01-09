Return-Path: <netdev+bounces-156776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D26A07CF5
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F173A9845
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DD1221D8C;
	Thu,  9 Jan 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="gI8y8vlP"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E561221D8B
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438899; cv=none; b=bp5rtifD83XbmtWA+DRcV+IXH0fy1ES1Dl5uxZBX8KQ6JD1M+VFIoj5i/fuNeRDg4DO9QL+UroCUA/G6O3ckLkenO3pHTS0Zr+0lAdG/qB26NFuMyXY6+dtsnmB7g8/sjvVdWezgHux6lT76cgFZwlVDeJgzv6AydnyfBHB098c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438899; c=relaxed/simple;
	bh=GV3fhrLaqo26vcZSfffabpj3GEwR3i4jx02OWTzFB0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QaCRHMcSV9AR8Y/ZvJHGGVmR+9ayryl8yULo7jwZZg9dzA8qg1VvqPjvGzrBvxt0o+CfXpFE2C9kJ12tr4dgUoezDvGp9jtPA99l+v0IPPaeFlZfHRHOBAXCmTx38D+6KUuwJ4Gjvool9l1PGXF4EUBWWZuMACTomwLSOuh6kmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=gI8y8vlP; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1736438894; bh=GV3fhrLaqo26vcZSfffabpj3GEwR3i4jx02OWTzFB0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gI8y8vlPPUrZNDhkK8lb10VoRAugl4JA+M8L3jzo88YUWHjhrZRNksGBsbyjg/BLY
	 7WFm6g5rYD/5Goy0OmW3pRZEcqY6VqBgPRBQmxB2zyI9j5BT597KKPArGkvHX9Xsiy
	 PEtgZZSKk1Mdn3D/W1kOuj7mCsHqj5lPs4dQoU0rQZp92gM5gxkEdQh0sIk79uqV+h
	 tYjs9pA2saiI1nWPTfI3BLupK2oHA5XcAoiYgXgJVHDEDpJpmByJMyUYQjB0fi93K8
	 QW9ZGZmlCZYu0c+6t10+r8PZnzN883aIFDCU3BXEU6k8UWnbkaNeunnYpQFEvpq7WQ
	 afS7LALtUWN1g==
To: Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] sched: sch_cake: add bounds checks to host bulk
 flow fairness counts
In-Reply-To: <11915c70-ec5e-4d94-b890-f07f41094e2c@redhat.com>
References: <20250107120105.70685-1-toke@redhat.com>
 <fb7a1324-41c6-4e10-a6a3-f16d96f44f65@redhat.com> <87plkwi27e.fsf@toke.dk>
 <11915c70-ec5e-4d94-b890-f07f41094e2c@redhat.com>
Date: Thu, 09 Jan 2025 17:08:14 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ikqohswh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> writes:

> On 1/9/25 1:47 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Paolo Abeni <pabeni@redhat.com> writes:
>>> On 1/7/25 1:01 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Even though we fixed a logic error in the commit cited below, syzbot
>>>> still managed to trigger an underflow of the per-host bulk flow
>>>> counters, leading to an out of bounds memory access.
>>>>
>>>> To avoid any such logic errors causing out of bounds memory accesses,
>>>> this commit factors out all accesses to the per-host bulk flow counters
>>>> to a series of helpers that perform bounds-checking before any
>>>> increments and decrements. This also has the benefit of improving
>>>> readability by moving the conditional checks for the flow mode into
>>>> these helpers, instead of having them spread out throughout the
>>>> code (which was the cause of the original logic error).
>>>>
>>>> v2:
>>>> - Remove now-unused srchost and dsthost local variables in cake_dequeu=
e()
>>>
>>> Small nit: the changelog should come after the '---' separator. No need
>>> to repost just for this.
>>=20
>> Oh, I was under the impression that we wanted them preserved in the git
>> log (and hence above the ---). Is that not the case (anymore?)?
>
> It was some time ago. Is this way since a while:
>
> https://elixir.bootlin.com/linux/v6.13-rc3/source/Documentation/process/m=
aintainer-netdev.rst#L229

Huh, whaddyaknow. Thanks for the pointer.

> [...]
>>> dithering is now applied on both enqueue and dequeue, while prior to
>>> this patch it only happened on dequeue. Is that intentional? can't lead
>>> to (small) flow_deficit increase?
>>=20
>> Yeah, that was deliberate. The flow quantum is only set on enqueue when
>> the flow is first initialised as a sparse flow, not for every packet.
>> The only user-visible effect I can see this having is that the maximum
>> packet size that can be sent while a flow stays sparse will now vary
>> with +/- one byte in some cases. I am pretty sure this won't have any
>> consequence in practice, and I don't think it's worth complicating the
>> code (with a 'dither' argument to cake_flow_get_quantum(), say) to
>> preserve the old behaviour.
>
> Understood, and fine by me.
>
>> I guess I should have mentioned in the commit message that this was
>> deliberate. Since it seems you'll be editing that anyway (cf the above),
>> how about adding a paragraph like:
>>=20
>>  As part of this change, the flow quantum calculation is consolidated
>>  into a helper function, which means that the dithering applied to the
>>  host load scaling is now applied both in the DRR rotation and when a
>>  sparse flow's quantum is first initiated. The only user-visible effect
>>  of this is that the maximum packet size that can be sent while a flow
>>  stays sparse will now vary with +/- one byte in some cases. This should
>>  not make a noticeable difference in practice, and thus it's not worth
>>  complicating the code to preserve the old behaviour.
>
> It's in Jakub's hands now, possibly he could prefer a repost to reduce
> the maintainer's overhead.

Alright, sure, I'll respin :)

-Toke

