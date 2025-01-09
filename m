Return-Path: <netdev+bounces-156687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65A1A0760C
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36A7166299
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25492217710;
	Thu,  9 Jan 2025 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="YQNBVHHR"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC4217707
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426844; cv=none; b=HUG+HmsCMWiYouEUiGcfTd3tm5yMAXyRtrq3GGK6pf+bhvXNuW9XSYH8H8JiekSzitYyWb0ETOLXqxUypertAKJKqEA7kjaoFR1YUdGC4+NZjZAwbGckXJQxBUtOq+exlkM1KmcaPpb3fm/q7W2s25FWGQVSuENID7e2OBNBaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426844; c=relaxed/simple;
	bh=SQuxm+ItjKfTHqDCnhmWPP3mexlv7P5RG77HW1/uIAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M/gWPXKD1PuN9jwPiOULcLzI5YqWoSwQgR1Qrt7+fqO0aW2fwQdUoohLDys9xhm/6NR0D6gRDmbThJ8X9xfBfOGJoP8FHAU8zcO1u0v9QdOjOThLLQIsShQ9ZAimyBcJ/pZbbUHFVRSbC8M83iuXqXvl5RezxBedtfWR7YxQPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=YQNBVHHR; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1736426838; bh=SQuxm+ItjKfTHqDCnhmWPP3mexlv7P5RG77HW1/uIAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YQNBVHHRUFbGfQ7S1lj/AaI1UHht3Yop0leBB6u0I4shd8583P21MwnUnaK/RcQVn
	 im1b8k+iLaZ4a6wI+S448xPTyPkgaP4Wq5hns8uqvpV6pVvhGasQhEQC7UczKJt0PA
	 qdl7aPqmFc1Kk/yXQQqUBIx16LMd2KG0KII6zTkFSsFgiqjDY8t2jVh1N4FSGLjwuG
	 6VHJ+OPmnfpZSJEp9+tQce1fjl52TRhoOctIXaL54+PRngLCWaYuWEq1Jt7+KcNnf0
	 lMTX08vw8hH3DdFtY4OU4yUuw5vT0lVTQOPzkJCDKo5Q1iLMU/sc6MwVnnLIbVxxE4
	 sCT+HzLk+MFpQ==
To: Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] sched: sch_cake: add bounds checks to host bulk
 flow fairness counts
In-Reply-To: <fb7a1324-41c6-4e10-a6a3-f16d96f44f65@redhat.com>
References: <20250107120105.70685-1-toke@redhat.com>
 <fb7a1324-41c6-4e10-a6a3-f16d96f44f65@redhat.com>
Date: Thu, 09 Jan 2025 13:47:17 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87plkwi27e.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> writes:

> On 1/7/25 1:01 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Even though we fixed a logic error in the commit cited below, syzbot
>> still managed to trigger an underflow of the per-host bulk flow
>> counters, leading to an out of bounds memory access.
>>=20
>> To avoid any such logic errors causing out of bounds memory accesses,
>> this commit factors out all accesses to the per-host bulk flow counters
>> to a series of helpers that perform bounds-checking before any
>> increments and decrements. This also has the benefit of improving
>> readability by moving the conditional checks for the flow mode into
>> these helpers, instead of having them spread out throughout the
>> code (which was the cause of the original logic error).
>>=20
>> v2:
>> - Remove now-unused srchost and dsthost local variables in cake_dequeue()
>
> Small nit: the changelog should come after the '---' separator. No need
> to repost just for this.

Oh, I was under the impression that we wanted them preserved in the git
log (and hence above the ---). Is that not the case (anymore?)?

>> Fixes: 546ea84d07e3 ("sched: sch_cake: fix bulk flow accounting logic fo=
r host fairness")
>> Reported-by: syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  net/sched/sch_cake.c | 140 +++++++++++++++++++++++--------------------
>>  1 file changed, 75 insertions(+), 65 deletions(-)
>>=20
>> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
>> index 8d8b2db4653c..2c2e2a67f3b2 100644
>> --- a/net/sched/sch_cake.c
>> +++ b/net/sched/sch_cake.c
>> @@ -627,6 +627,63 @@ static bool cake_ddst(int flow_mode)
>>  	return (flow_mode & CAKE_FLOW_DUAL_DST) =3D=3D CAKE_FLOW_DUAL_DST;
>>  }
>>=20=20
>> +static void cake_dec_srchost_bulk_flow_count(struct cake_tin_data *q,
>> +					     struct cake_flow *flow,
>> +					     int flow_mode)
>> +{
>> +	if (likely(cake_dsrc(flow_mode) &&
>> +		   q->hosts[flow->srchost].srchost_bulk_flow_count))
>> +		q->hosts[flow->srchost].srchost_bulk_flow_count--;
>> +}
>> +
>> +static void cake_inc_srchost_bulk_flow_count(struct cake_tin_data *q,
>> +					     struct cake_flow *flow,
>> +					     int flow_mode)
>> +{
>> +	if (likely(cake_dsrc(flow_mode) &&
>> +		   q->hosts[flow->srchost].srchost_bulk_flow_count < CAKE_QUEUES))
>> +		q->hosts[flow->srchost].srchost_bulk_flow_count++;
>> +}
>> +
>> +static void cake_dec_dsthost_bulk_flow_count(struct cake_tin_data *q,
>> +					     struct cake_flow *flow,
>> +					     int flow_mode)
>> +{
>> +	if (likely(cake_ddst(flow_mode) &&
>> +		   q->hosts[flow->dsthost].dsthost_bulk_flow_count))
>> +		q->hosts[flow->dsthost].dsthost_bulk_flow_count--;
>> +}
>> +
>> +static void cake_inc_dsthost_bulk_flow_count(struct cake_tin_data *q,
>> +					     struct cake_flow *flow,
>> +					     int flow_mode)
>> +{
>> +	if (likely(cake_ddst(flow_mode) &&
>> +		   q->hosts[flow->dsthost].dsthost_bulk_flow_count < CAKE_QUEUES))
>> +		q->hosts[flow->dsthost].dsthost_bulk_flow_count++;
>> +}
>> +
>> +static u16 cake_get_flow_quantum(struct cake_tin_data *q,
>> +				 struct cake_flow *flow,
>> +				 int flow_mode)
>> +{
>> +	u16 host_load =3D 1;
>> +
>> +	if (cake_dsrc(flow_mode))
>> +		host_load =3D max(host_load,
>> +				q->hosts[flow->srchost].srchost_bulk_flow_count);
>> +
>> +	if (cake_ddst(flow_mode))
>> +		host_load =3D max(host_load,
>> +				q->hosts[flow->dsthost].dsthost_bulk_flow_count);
>> +
>> +	/* The get_random_u16() is a way to apply dithering to avoid
>> +	 * accumulating roundoff errors
>> +	 */
>> +	return (q->flow_quantum * quantum_div[host_load] +
>> +		get_random_u16()) >> 16;
>
> dithering is now applied on both enqueue and dequeue, while prior to
> this patch it only happened on dequeue. Is that intentional? can't lead
> to (small) flow_deficit increase?

Yeah, that was deliberate. The flow quantum is only set on enqueue when
the flow is first initialised as a sparse flow, not for every packet.
The only user-visible effect I can see this having is that the maximum
packet size that can be sent while a flow stays sparse will now vary
with +/- one byte in some cases. I am pretty sure this won't have any
consequence in practice, and I don't think it's worth complicating the
code (with a 'dither' argument to cake_flow_get_quantum(), say) to
preserve the old behaviour.

I guess I should have mentioned in the commit message that this was
deliberate. Since it seems you'll be editing that anyway (cf the above),
how about adding a paragraph like:

 As part of this change, the flow quantum calculation is consolidated
 into a helper function, which means that the dithering applied to the
 host load scaling is now applied both in the DRR rotation and when a
 sparse flow's quantum is first initiated. The only user-visible effect
 of this is that the maximum packet size that can be sent while a flow
 stays sparse will now vary with +/- one byte in some cases. This should
 not make a noticeable difference in practice, and thus it's not worth
 complicating the code to preserve the old behaviour.

-Toke

