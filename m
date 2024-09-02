Return-Path: <netdev+bounces-124317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B74968F29
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 23:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0D7B2221A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 21:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F48D18732B;
	Mon,  2 Sep 2024 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HaqRPuaZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7D1A4E8D;
	Mon,  2 Sep 2024 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725312871; cv=none; b=oIOL6OiRCZUEyCXISDDz9Npnu+NAwU1jS6tKvc4G92B+xpP0Hj02oT16cBdkXAD8u2qajHHKiAivNFln12o+pGQgyKUSOsinavbN6HxXBrx7UK1SyLVGrXE6dt0w3HJWi6t2JO1mzvnQC4e1+tXBrIbDkiGZOsYm1o+KlnkVTZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725312871; c=relaxed/simple;
	bh=eEHfWHSPYrEoeY6E0LRdQeuvc1bWFRUzdpGYyP8InE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ErOwSVSvxa4oazQOoXxN/Jts2oiaqFq/BUNgjWO7xVdX3jaRPwaD/GaZ0YURG3aEL6JwoMtHjctWHQ39Bz94DFQX/cHa9zyde+2dBfLnooDAH42mMlJ1PHEmnTt1pf+UPwlU9Yq3mqB2kW/CZyjFiJPi1irQAfHW07svCF/fCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HaqRPuaZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725312869; x=1756848869;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=eEHfWHSPYrEoeY6E0LRdQeuvc1bWFRUzdpGYyP8InE0=;
  b=HaqRPuaZDMYSMrvSIABg9sWcn9SmLKedV5lAsKpWzFc7u2NNvoXldSqe
   Z+po1xUBXErb7cS+lDUBAUOrT11j8DLglvVLubhmcaiobCzUZVKpPW7sy
   J5q+YOg665FjEEAFvBg7tFwwrtT3dFv4sDTM7uGORYyklg9TovCI01Ta+
   6rb8b6fDGxSKCQS5t7IDzaD5HgdODW5LemBp3rEyzXq9ezxgt0DYOA/gs
   KJ38ux01oN5NJNXQdfT/9fN0frxTzpfUhfg5EuWhgHt/ve+GkcjTNCep8
   Xi4jYMLKsfBS67LyS5ZkKZg1gJf8ThaxPsJnnh2mLxhIQuFJ2NdH2Jdri
   A==;
X-CSE-ConnectionGUID: iGtetNmLT7SG9Sgl031aaA==
X-CSE-MsgGUID: qgMs+sAySq2eMDCOIdlaTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="24076880"
X-IronPort-AV: E=Sophos;i="6.10,196,1719903600"; 
   d="scan'208";a="24076880"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 14:34:27 -0700
X-CSE-ConnectionGUID: G/U6S52GRn+suBIeozyttw==
X-CSE-MsgGUID: FB0tdK3bRn2DV0Z7XZhyGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,196,1719903600"; 
   d="scan'208";a="64672546"
Received: from jairdeje-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.221.34])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 14:34:24 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Florian Kauer <florian.kauer@linutronix.de>, luyun <luyun@kylinos.cn>,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CPU stuck due to the taprio hrtimer
In-Reply-To: <fcd41a5f-66b5-4ebe-9535-b75e14867444@linutronix.de>
References: <20240627055338.2186255-1-luyun@kylinos.cn>
 <87sewy55gp.fsf@intel.com>
 <2df10720-1790-48bd-a50c-4816260543b0@kylinos.cn>
 <fcd41a5f-66b5-4ebe-9535-b75e14867444@linutronix.de>
Date: Mon, 02 Sep 2024 18:34:21 -0300
Message-ID: <87jzftpwo2.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Florian Kauer <florian.kauer@linutronix.de> writes:

> On 9/2/24 11:12, luyun wrote:
>>=20
>> =E5=9C=A8 2024/6/28 07:30, Vinicius Costa Gomes =E5=86=99=E9=81=93:
>>> Yun Lu <luyun@kylinos.cn> writes:
>>>
>>>> Hello,
>>>>
>>>> When I run a taprio test program on the latest kernel(v6.10-rc4), CPU =
stuck
>>>> is detected immediately, and the stack shows that CPU is stuck on tapr=
io
>>>> hrtimer.
>>>>
>>>> The reproducer program link:
>>>> https://github.com/xyyluyun/taprio_test/blob/main/taprio_test.c
>>>> gcc taprio_test.c -static -o taprio_test
>>>>
>>>> In this program, start the taprio hrtimer which clockid is set to REAL=
TIME, and
>>>> then adjust the system time by a significant value backwards. Thus, CP=
U will enter
>>>> an infinite loop in the__hrtimer_run_queues function, getting stuck an=
d unable to
>>>> exit or respond to any interrupts.
>>>>
>>>> I have tried to avoid this problem by apllying the following patch, an=
d it does work.
>>>> But I am not sure if this can be the final solution?
>>>>
>>>> Thanks.
>>>>
>>>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>>>> ---
>>>> =C2=A0 net/sched/sch_taprio.c | 24 ++++++++++++++++++++++++
>>>> =C2=A0 1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>>>> index a0d54b422186..2ff8d34bdbac 100644
>>>> --- a/net/sched/sch_taprio.c
>>>> +++ b/net/sched/sch_taprio.c
>>>> @@ -104,6 +104,7 @@ struct taprio_sched {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 max_sdu[TC_MAX_QUEUE]; /* save info=
 from the user */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 fp[TC_QOPT_MAX_QUEUE]; /* only for =
dump and offloading */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 txtime_delay;
>>>> +=C2=A0=C2=A0=C2=A0 ktime_t offset;
>>>> =C2=A0 };
>>>> =C2=A0 =C2=A0 struct __tc_taprio_qopt_offload {
>>>> @@ -170,6 +171,19 @@ static ktime_t sched_base_time(const struct sched=
_gate_list *sched)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ns_to_ktime(sched->base_time);
>>>> =C2=A0 }
>>>> =C2=A0 +static ktime_t taprio_get_offset(const struct taprio_sched *q)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 enum tk_offsets tk_offset =3D READ_ONCE(q->tk_offs=
et);
>>>> +=C2=A0=C2=A0=C2=A0 ktime_t time =3D ktime_get();
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 switch (tk_offset) {
>>>> +=C2=A0=C2=A0=C2=A0 case TK_OFFS_MAX:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> +=C2=A0=C2=A0=C2=A0 default:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ktime_sub_ns(ktime_=
mono_to_any(time, tk_offset), time);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +}
>>>> +
>>>> =C2=A0 static ktime_t taprio_mono_to_any(const struct taprio_sched *q,=
 ktime_t mono)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* This pairs with WRITE_ONCE() in tapr=
io_parse_clockid() */
>>>> @@ -918,6 +932,7 @@ static enum hrtimer_restart advance_sched(struct h=
rtimer *timer)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int num_tc =3D netdev_get_num_tc(dev);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sched_entry *entry, *next;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct Qdisc *sch =3D q->root;
>>>> +=C2=A0=C2=A0=C2=A0 ktime_t now_offset =3D taprio_get_offset(q);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ktime_t end_time;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int tc;
>>>> =C2=A0 @@ -957,6 +972,14 @@ static enum hrtimer_restart advance_sched(=
struct hrtimer *timer)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_time =3D ktime_add_ns(entry->end_ti=
me, next->interval);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_time =3D min_t(ktime_t, end_time, o=
per->cycle_end_time);
>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (q->offset !=3D now_offset) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ktime_t diff =3D ktime_sub=
_ns(now_offset, q->offset);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_time =3D ktime_add_ns(=
end_time, diff);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oper->cycle_end_time =3D k=
time_add_ns(oper->cycle_end_time, diff);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q->offset =3D now_offset;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>> I think what we should do here is a bit different. Let me try to explain
>>> what I have in mind with some context.
>>>
>>> A bit of context: The idea of taprio is to enforce "TSN" traffic
>>> schedules, these schedules require time synchronization, for example via
>>> PTP, and in those cases, time jumps are not expected or a sign that
>>> something is wrong.
>>>
>>> In my mind, a time jump, specially a big one, kind of invalidates the
>>> schedule, as the schedule is based on an absolute time value (the
>>> base_time), and when time jumps that reference in time is lost.
>>>
>>> BUT making the user's system unresponsive is a bug, a big one, as if
>>> this happens in the real world, the user will be unable to investigate
>>> what made the system have so big a time correction.
>>>
>>> So my idea is to warn the user that the time jumped, say that the user
>>> needs to reconfigure the schedule, as it is now invalid, and disable the
>>> schedule.
>>>
>>> Does this make sense?
>>>
>>> Ah, and thanks for the report.
>>=20
>> Hello Vinicius,
>>=20
>> May I ask is there a fix patch for this issue?
>>=20
>> I test it on the latest kernel version,=C2=A0 and it still seems to caus=
e CPU stuck.
>>=20
>> As you mentioned, a better way would be to warn the user that the curren=
t time has jumped and cancel the hrtimer,
>>=20
>> but I'm not sure how to warn the user, or just through printk?
>>=20
>> Thanks and best regards.
>
> I am not sure if it is really the best solution to force the user to reco=
nfigure the schedule
> "just" because the clock jumped. Yes, time jumps are a big problem for TA=
PRIO, but stopping might
> make it worse.
>
> Vinicius wrote that the base_time can no longer reference to the correct =
point in time,
> so the schedule MUST be invalid after the time jump. It is true that the =
base_time does not longer
> refer to the same point in time it referred to before the jump from the v=
iew of the local system (!).
> But the base_time usually refers to the EXTERNAL time domain (i.e. the ti=
me the system SHOULD have
> and not the one the system currently has) and is often configured by an e=
xternal entity.
>
> So it is quite likely that the schedule was incorrectly phase-shifted BEF=
ORE the time jump and after
> the time jump the base_time refers to the CORRECT point in time viewed fr=
om the external time domain.
>
> If you now stop the schedule (and I assume you mean by this to let every =
queue transmit at any time
> as before the schedule was configured) and the user has to reconfigure th=
e schedule again,
> it is quite likely that by this you actually increase the interference wi=
th the network and in
> particular confuse the time synchronization via PTP, so once the schedule=
 is set up again,
> you might get a time jump AGAIN.
>
> So yes, a warning to the user is definitely appropriate in the case of a =
time jump, but apart
> from that I would prefer the system to adapt itself instead of resigning.
>

The "warn the user, disable the schedule" is more or less clear in my
mind how to implement. But while I was writing this, I was taking
another look at the standard, and I think this approach is wrong.

I think what we should do is something like this:

1. Jump into the past:
   1.a. before base-time: Keep all queues open until base-time;
   1.b. after base-time: "rewind" the schedule to the new current time;
2. Jump into the future: "fast forward" the schedule to the new current
   time;

But I think that for this to fit more neatly, we would need to change
how advance_sched() works, right now, it doesn't look at the current
time (it considers that the schedule will always advance one-by-one),
instead what I am thinking is to consider that every time
advance_sched() runs is a pontential "time jump".=20

Ideas? Too complicated for an uncommon case? (is it really uncommon?)

> Yun Lu, does this only happen for time jumps into the past or also for la=
rge jumps into the future?
> And does this also happen for small time "jumps"?

AFAIU this bug will only happen with large jumps into the past. For
small jumps into the past, it will spin uselessly for a bit. For jumps
into the future, the schedule will be stuck in a particular gate entry
until the future becomes now.

>
> Thanks,
> Florian
>
>>=20
>>=20
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (tc =3D 0; tc < num_tc; tc++) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (next->gate_=
duration[tc] =3D=3D oper->cycle_time)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 next->gate_close_time[tc] =3D KTIME_MAX;
>>>> @@ -1210,6 +1233,7 @@ static int taprio_get_start_time(struct Qdisc *s=
ch,
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base =3D sched_base_time(sched);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 now =3D taprio_get_time(q);
>>>> +=C2=A0=C2=A0=C2=A0 q->offset =3D taprio_get_offset(q);
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ktime_after(base, now)) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *start =3D base;
>>>> --=C2=A0
>>>> 2.34.1
>>>>
>>>
>>> Cheers,
>>=20
>


Cheers,
--=20
Vinicius

