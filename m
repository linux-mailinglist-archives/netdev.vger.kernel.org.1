Return-Path: <netdev+bounces-246378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 282BCCEA518
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 18:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 690763018D74
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 17:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80962E093C;
	Tue, 30 Dec 2025 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="JhaGWKWH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04731C84DC
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115739; cv=none; b=qbsSzuECQxFij3+1mW/nlb57x50BvP82/KsBwGPFH7sUkewGdY1VOzAGYTO6/inTM8KZysnDBSHsd2VGwT6DMbJln9wGcglIZ5ROypIryTuMFpcr+F8sXowzMGTtOTkWqbEY3ait3gF+zUcD33gWi79UBUXB7x5DwkMy1ArNsnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115739; c=relaxed/simple;
	bh=jDNej8PITjPl6LvaxqTAjlCeYAT+B+gBZaZGURHfifU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sobd4jVjNDUyZf9XuwHj3/KVVPQkg24/6xicfl0QgXwWAFrPWpHlKvESDXvknn1RwT/8g8PkVn8QUr/PBxgKt7bjJXt+UgYNH+liQpeKt9F8sRzm5m++jWEA30ncgsPksb4NgXWoh1VYFdr2QmOBrUF7ccUdL1N77LxgPcFviLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=JhaGWKWH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso104455975e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 09:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767115736; x=1767720536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1rc8p8CdrxpLalH2n598p9LkJrtlp4CjFbGvP/j8ME=;
        b=JhaGWKWHojaCIn1CMSzkVF0bn5/q2ntBj258n9N1bVABde1pPTQugZZM4ER5fCvXDW
         XIY1QmyPoKqJhUfnAoLoZQqnO1bpG1FVbB8i7hQWL1DnwbUTz/DmqbshxscC5LTNPbHF
         hZiyp0T6+0O4heebBdlbBTTHAg6bz80rGoKJzlBZiVxBW/YQjl1TIHW45QRVy0iu3ZFP
         LhIf06LCLCsfw/85yPSdA165zVkBzaeGKp1lJCZ5/ez6U6mX6xedY8uFBbPHR11672Nz
         lGI09STuPm3UwNxci3GaODSNR3bMuPd1cdKzuiBe4XEJGTQKEeBKGvdIoxDbcj3+Eq1m
         shqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767115736; x=1767720536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A1rc8p8CdrxpLalH2n598p9LkJrtlp4CjFbGvP/j8ME=;
        b=eWpRjxkJyjY73a0YQhU3nP16fJ1RMtFx3Oy1qjFjvsHqBvJu7GlXsfZn/C3GKtYvFa
         JA7y+gRqCxvLL4X/t2tuuK6wPFxSzX2ycddHGqmxy2S1LhipBcOvvanzDgLWQ+vFFpj9
         0TQfrxNC7cmJStOCLiQy0eajGyhJx3ZnsiRzoObY9Sk+qYO7R6WScQK0lzgu+KGgPE1z
         dXlI6YBcF9mhEVdlAJwcM3QXflT8dzossjXb1Kj9Kf1yd/QtxjBziSCqFbCpN/4r0erq
         c4nbEtpnMH6crzVwKwyYzF3ei3lX2gj+ICgMq/DyeTM2lBGCmochqvqolfNF3Ky9/0Hp
         3jhg==
X-Gm-Message-State: AOJu0YzcMiFfxKzelIXQD2RYKZklGJ6qHZX8LiGHSbZWxkCRSgJKUwfB
	vHdVPV1nTJI1GMlXfpP9kh4xCFyMvhftHLMdq0yae0DjleoipTQ0RAjHfYiwaINx2h4=
X-Gm-Gg: AY/fxX5fd3/cU+nz2soTuE2qNv6jxwwNt+UZr3gzOf+I0YIMBXLbecLAH7FL7NA6lhf
	O/0XmoD1nS8Bv5skQBkJG2/D8dUJe3kzocH1Q2V7Uz7PceABow5e6rx0v6htSMEVo5K4ZA/ZYZc
	73tfMMy3e/kxZCQB5QSJ956NMqVOBNtw50vBJkBHJTpwdBxecTHkxLkT211I+sMRqBV9NXKeULz
	gxZl2nr6srR9hyx4OVSgjJV/AiTlH28ZTu6TBug7k2UaGXmhml8KvWJL7tSJtewLdecojyXQjyB
	ArHsccWaACogWM+Bg860lsDklD0olihzh5l8JxM/8m8Ju0jIGioNe+Y1OKF0SAmTdF7RzC1qvRf
	VNZTHXrFvZcWUEJcMgMqBuQLwjsXKHpA72UGTukz6NPhK+qffNwevNGTBA1HZL5aq/oeINtVWrH
	VHGX3AMZ+GSL7tb7YSuLFJGxwza2eWGldOwJimmJwSxT1R2ABzP3Ks
X-Google-Smtp-Source: AGHT+IGKNPo/giBMA36eouJIWwu25G3P5lRdcvlsf+BZdzMqqs4i8Vg30H8dLKxUsjQRnU3xkikEuw==
X-Received: by 2002:a05:600c:3111:b0:477:b642:9dc6 with SMTP id 5b1f17b1804b1-47d195aa79cmr383559275e9.34.1767115735954;
        Tue, 30 Dec 2025 09:28:55 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d1936d220sm661222585e9.8.2025.12.30.09.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 09:28:55 -0800 (PST)
Date: Tue, 30 Dec 2025 09:28:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, William Liu <will@willsroot.io>, Savino Dicanosa
 <savy@syst3mfailure.io>
Subject: Re: [Patch net v6 4/8] net_sched: Implement the right netem
 duplication behavior
Message-ID: <20251230092850.43251a09@phoenix.local>
In-Reply-To: <20251227194135.1111972-5-xiyou.wangcong@gmail.com>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
	<20251227194135.1111972-5-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Dec 2025 11:41:31 -0800
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

It is worth testing for the case where netem is used as a leaf qdisc.
I worry that this could cause the parent qdisc to get accounting wrong.
I.e if HTB calls netem and netem queues 2 packets, the qlen in HTB
would be incorrect.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

