Return-Path: <netdev+bounces-243415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51741C9F6C5
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 16:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C1553005EB8
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9131A7E3;
	Wed,  3 Dec 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="u6RIUMv2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCEF3195FB
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774350; cv=none; b=hKCOH2M1Y+uMZsyckGglPmci3+ymb1Vcnw/2bWLbTT14y4SYZ/Bd3yFEGU+3REQ3v+e8NmXRWOQpv9Epv/QyWyM1/tbygtb/+enOrjnOYJfBSNdGU2iiUH+Z14ECGzFZShY25vy4NKJ2SsGvlEvNG2P2Ucbmwm3RsHPhOhYPAsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774350; c=relaxed/simple;
	bh=L0cb+9i5v+3GiAZ5BQARuLKEP9otp6BXByk8By2HQR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uwxc5nHGMajyuO+sRgIpyb8Sh45tXPz+mkB9vmhhEfwwBwRieH3WL3w8DDGw6XoftfGwdZppEqTZ0piIOAgzSiF+euWZwDQCG+VJcYhVbZ/MSGpJVbvYPvh5PZSpZ0FgV99Mxqkmjmhv0HVrx/U6bv8ShNAggMTAxVPp6ke+UW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=u6RIUMv2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so42456915e9.1
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 07:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764774347; x=1765379147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6iWmKC0lOsZfWlN/58nC5AzxgSiimJUPQw+Dk8XwBM=;
        b=u6RIUMv24C8rDWl7E2uXPs4b92o+FmHT52rwoqRoxe051FNi3AF7ssI7SpVzu/s5lV
         3TardUCtPsSqb1LK4uBZZc2ICPGZoAulbrowa7XnVVaH+DP7l85fphgSOmgAM8QEVfRo
         Q534LW8JYbzBVrwadSgFqkBWovrGNseOeRTiUOheorlBuG9Lgzfc71e2HAgd/mlohZWN
         PHbD7/P4afl2UFfNGnwHoY77eo9potSvseSBf4n+QsuJJnJ42L3AL1npglnwU2Hx45jT
         52M8qUWMd5jrm5DcF0XDyD6vQVo7I1+Q8TUSNeGET/iH0xSaqENRgUqeAk7bdcc2TELc
         gIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764774347; x=1765379147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E6iWmKC0lOsZfWlN/58nC5AzxgSiimJUPQw+Dk8XwBM=;
        b=pQPMO9IdozIVMI1PMun5cXiDG2IaUTwYxD35/xxtr6xjz2Q4cFOhzPfvptAtmgfMwP
         CS9xccNxKgvElF3AbLtlISJR2QWk4DjRxO/PqSTviChkAnV6XvhJLQwN7jrfcrnLtGEj
         N03M3hboDPU4Ed5mbQ42emBBbqU9rC+mPU1Zv3jgFEjLSKhwyJXTCMJJ392EJYRAf9L0
         IfQeW6vZVYjtPdxsFq6gIkegldl0VDCpsCDuvn83BpokTMcdjpS8XdgKDEw7FCXF5RDI
         qn9cy3Ud8rR4q0gUs9QtGATOdmWDrGMlTnmDT7r2/YE4jN3hau9ykwOwO3ZTd8fTWJFV
         BzwQ==
X-Gm-Message-State: AOJu0YyzecijIa8P/ufvQvCvMWJGEd91jdtIq/rQEXp78+k9nWh8tlO9
	pkdGKVox7LIpb+OjVz53h+DKPGL73hQJxUjDQ+ruroqrKOYfdlxn461DDGCb00scWdM=
X-Gm-Gg: ASbGncuF/DetpGduLpzgraqL5Siid6KK70P3VAcBnH6ryB71w9KsO24q5k97j3JD932
	BGnrruRq6H7nb/OZtK/biiwHAu29GLQGJu+8i7VmczzFYR83hX+UHyOhYxc1H2xH4c60+2Bf9OI
	wvdHh+nYPxo+zpHxC9RX6Y6iBcsvlFz924SJftWHDzofsNuZFTAF1FdHSA7aJppIvn8wto3mSXo
	5Zy9gTd2+Yw8LQfVUjmVPF8l/mL/xX3OaEq4DVk+n6G4F1b1sHDTOMD2tkVT5gFDMRDN5NMipAF
	rXfqdFnjHOLisdV4aO8jV4A6VjpcBwdzRyKwNxT6OCtO7ZduQh+Msu6L78dBtleeEyzTJFmoLs8
	/lUHUP5tnfiiRdSZNpZIv3zsemFQDR4gtIL8ZBNpJ+v4URzOayj3mq8eoOr+1SK4KiqiCppBbUI
	KgfQGOS8l32kJVTVyAZdBxdTRskndtufYvLHQtNeqa39qbIaQuBCOqjizDw4Rh+xg=
X-Google-Smtp-Source: AGHT+IEOChvHNGmw33LwSomY/L4iFYoCzGmM1ANZWCum+qJdThlErEVOylia1WyTzZx3VATgl1y2QA==
X-Received: by 2002:a05:600c:45ca:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-4792af5e38emr28816635e9.32.1764774346516;
        Wed, 03 Dec 2025 07:05:46 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a79ed9asm51727095e9.6.2025.12.03.07.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 07:05:45 -0800 (PST)
Date: Wed, 3 Dec 2025 07:05:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, William Liu
 <will@willsroot.io>, Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch net v5 3/9] net_sched: Implement the right netem
 duplication behavior
Message-ID: <20251203070540.6ea53471@phoenix.local>
In-Reply-To: <20251126195244.88124-4-xiyou.wangcong@gmail.com>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
	<20251126195244.88124-4-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Nov 2025 11:52:38 -0800
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> In the old behavior, duplicated packets were sent back to the root qdisc,
> which could create dangerous infinite loops in hierarchical setups -
> imagine a scenario where each level of a multi-stage netem hierarchy kept
> feeding duplicates back to the top, potentially causing system instability
> or resource exhaustion.
>=20
> The new behavior elegantly solves this by enqueueing duplicates to the sa=
me
> qdisc that created them, ensuring that packet duplication occurs exactly
> once per netem stage in a controlled, predictable manner. This change
> enables users to safely construct complex network emulation scenarios usi=
ng
> netem hierarchies (like the 4x multiplication demonstrated in testing)
> without worrying about runaway packet generation, while still preserving
> the intended duplication effects.
>=20
> Another advantage of this approach is that it eliminates the enqueue reen=
trant
> behaviour which triggered many vulnerabilities. See the last patch in this
> patchset which updates the test cases for such vulnerabilities.
>=20
> Now users can confidently chain multiple netem qdiscs together to achieve
> sophisticated network impairment combinations, knowing that each stage wi=
ll
> apply its effects exactly once to the packet flow, making network testing
> scenarios more reliable and results more deterministic.
>=20
> I tested netem packet duplication in two configurations:
> 1. Nest netem-to-netem hierarchy using parent/child attachment
> 2. Single netem using prio qdisc with netem leaf
>=20
> Setup commands and results:
>=20
> Single netem hierarchy (prio + netem):
>   tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0
>   tc filter add dev lo parent 1:0 protocol ip matchall classid 1:1
>   tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%
>=20
> Result: 2x packet multiplication (1=E2=86=922 packets)
>   2 echo requests + 4 echo replies =3D 6 total packets
>=20
> Expected behavior: Only one netem stage exists in this hierarchy, so
> 1 ping becomes 2 packets (100% duplication). The 2 echo requests generate
> 2 echo replies, which also get duplicated to 4 replies, yielding the
> predictable total of 6 packets (2 requests + 4 replies).
>=20
> Nest netem hierarchy (netem + netem):
>   tc qdisc add dev lo root handle 1: netem limit 1000 duplicate 100%
>   tc qdisc add dev lo parent 1: handle 2: netem limit 1000 duplicate 100%
>=20
> Result: 4x packet multiplication (1=E2=86=922=E2=86=924 packets)
>   4 echo requests + 16 echo replies =3D 20 total packets
>=20
> Expected behavior: Root netem duplicates 1 ping to 2 packets, child netem
> receives 2 packets and duplicates each to create 4 total packets. Since
> ping operates bidirectionally, 4 echo requests generate 4 echo replies,
> which also get duplicated through the same hierarchy (4=E2=86=928=E2=86=
=9216), resulting
> in the predictable total of 20 packets (4 requests + 16 replies).
>=20
> The new netem duplication behavior does not break the documented
> semantics of "creates a copy of the packet before queuing." The man page
> description remains true since duplication occurs before the queuing
> process, creating both original and duplicate packets that are then
> enqueued. The documentation does not specify which qdisc should receive
> the duplicates, only that copying happens before queuing. The implementat=
ion
> choice to enqueue duplicates to the same qdisc (rather than root) is an
> internal detail that maintains the documented behavior while preventing
> infinite loops in hierarchical configurations.
>=20
> Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> Reported-by: William Liu <will@willsroot.io>
> Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  net/sched/sch_netem.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>=20
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..191f64bd68ff 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -165,6 +165,7 @@ struct netem_sched_data {
>   */
>  struct netem_skb_cb {
>  	u64	        time_to_send;
> +	u8		duplicate : 1;
>  };
> =20
>  static inline struct netem_skb_cb *netem_skb_cb(struct sk_buff *skb)
> @@ -460,8 +461,16 @@ static int netem_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>  	skb->prev =3D NULL;
> =20
>  	/* Random duplication */
> -	if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng=
))
> -		++count;
> +	if (q->duplicate) {
> +		bool dup =3D true;
> +
> +		if (netem_skb_cb(skb)->duplicate) {
> +			netem_skb_cb(skb)->duplicate =3D 0;
> +			dup =3D false;
> +		}
> +		if (dup && q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng))
> +			++count;
> +	}
> =20
>  	/* Drop packet? */
>  	if (loss_event(q)) {
> @@ -532,17 +541,12 @@ static int netem_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
>  	}
> =20
>  	/*
> -	 * If doing duplication then re-insert at top of the
> -	 * qdisc tree, since parent queuer expects that only one
> -	 * skb will be queued.
> +	 * If doing duplication then re-insert at the same qdisc,
> +	 * as going back to the root would induce loops.
>  	 */
>  	if (skb2) {
> -		struct Qdisc *rootq =3D qdisc_root_bh(sch);
> -		u32 dupsave =3D q->duplicate; /* prevent duplicating a dup... */
> -
> -		q->duplicate =3D 0;
> -		rootq->enqueue(skb2, rootq, to_free);
> -		q->duplicate =3D dupsave;
> +		netem_skb_cb(skb2)->duplicate =3D 1;
> +		qdisc_enqueue(skb2, sch, to_free);
>  		skb2 =3D NULL;
>  	}
> =20

I wonder if a lot of the issues would go away if netem used a workqueue
to do the duplication. It would avoid nested calls etc.

