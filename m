Return-Path: <netdev+bounces-69525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE40D84B88B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588F028567D
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327C6133982;
	Tue,  6 Feb 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="wWg1Dh2L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A37813343E
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231271; cv=none; b=lSPJCT+JMNRuHZpe7Oa99tHdw578FOy/ySmkHYWy8FlPoRnfFzVrCcGaJdIr9hCkdffvI8K1G1HAIA9irBW+fc41WMpcN8QbjCaTi1TfRJH5nEEIQIGEGZj0WA04dnSmCKslY33pLhDpoCRxBNP0b2+T1g4T2GWfFsv1cQw1fjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231271; c=relaxed/simple;
	bh=05983awbGxgu4HX4N2M39+3YyNIIo4wP+EHA6DT/fZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HMmjKfUvw2CpCa3upBYOQxdOf1C6Oy0qnhYZ597YpV1epcoMtvpO++UimKvvIw9ayPy27K0k2RS+vPDAb5il1dPYOBMT7j+ytWi4JR2hW16WMZeiyi0cxxioFkD9fxPTF6jlS6UfwG9X2D2zxUTPtDAtvpZijtKLRAV4WHTQ70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=wWg1Dh2L; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511570b2f49so630409e87.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1707231267; x=1707836067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geXQy+0rFPdSuh4AkgqOK8TrEEUYOcWUey5o06JbSS4=;
        b=wWg1Dh2Lf1zAbZfADdWBFnMvbkEDkqxOenfM8ui7X6SK8ZpMxh4qTHmfUFwfAD1wlT
         YGS9OICW8t9Z6cAPcZJRvcodJAse9i6jhsZhwErYlI4ir0bRLdXmYQjGZyKzynrxS2wX
         8gAv099KgV4GP/RigsvDdZZ2yf0NX028IzB8/81imiA8Rk3JcboLk4+XFaJl5Fh4ifZ4
         cc0Ng3xR8x/NSMD/oZF1qSkCaUca+wW+T1O85G06uhnib77hsmX7+IBrWUM5fN8rwDXp
         zBRe5XMB+zTrXnKDCv+GAb+Ns13kqDmYrOz762MczGtaS/ExBmq0WvifQsRsVBH2bdxl
         zveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231267; x=1707836067;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geXQy+0rFPdSuh4AkgqOK8TrEEUYOcWUey5o06JbSS4=;
        b=nKygtV5L/FN6eF0Trk4BG/ZkAwPz7Y8eeXK5cAPDLbbCUCyPNYdkp1BnuoeKLvM93D
         CPARkZbrdiChHAnltpPSJwYWHek0FrVtTiS0fNowmr88jfBvboXYenwvQy8N85GY4ykV
         p3szkaMD095DYknhVkfLH56aMJBU1VjGhg9845s97g0fNUWPbiRB0WgpYVnElUHcO2Ru
         yffyliMiQktYjp/3pqdsNT+5+5BLXlzSF+PxwC4HljABD6Utiva6uDA+7qSg9dd0S7hb
         oUj/CBbdjlEZ4Nti7+NaL6/8eJTEtXlmYq+DKFtFXwlVvb5TE6jaPxeO+vnIVPiUiims
         mZMw==
X-Gm-Message-State: AOJu0Yx6r8SuBAiafeyKd/zqWTjNMfff1NAIPcWyYqm0bh8tIaaO/DvV
	xKMNDKC+49f8+brgNmgCeBsW0VTKMM6yTJagxKOgDYl2KP9ps8tM0vx3BIY2eWI=
X-Google-Smtp-Source: AGHT+IGy0BQleYH9gctl0B2NYcmAChfxIEEGWIZ2BzfPjsf18xRCPVpRRW67I6j6HjufIpVfWL0NFw==
X-Received: by 2002:a19:4f50:0:b0:511:61e8:f900 with SMTP id a16-20020a194f50000000b0051161e8f900mr192793lfk.28.1707231266819;
        Tue, 06 Feb 2024 06:54:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUw4lO6tYRg0EqImZH4yBC4ue61HdBIXCA9c8bpM8d3IjUM8zfIfNeJEKrbCzU6tUu3g4bK1Sbg+GxDa1Ive/nDhZgMdNfgVzP3XkZcMHwitlJDgbPmh0fJzHZyMFG9dKeRoUVpFnWK38h2ob7UvSjx5GfrkL0FdPXxhcL2P2jheuzqzrFmtcO6cMgFStdet98f4sQi6DKJIUtFpOFXElkW21BhBjix++onzCyB8cxZSQlhGEzGfnC21CQF4/QrP8tEdkde0ydeesDJsD2DUife
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id x27-20020a056512047b00b005114cb65174sm259643lfd.250.2024.02.06.06.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:54:26 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, atenart@kernel.org,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH v3 net] net: bridge: switchdev: Skip MDB replays of
 pending events
In-Reply-To: <20240205114138.uiwioqstybmzq77b@skbuf>
References: <20240201161045.1956074-1-tobias@waldekranz.com>
 <20240201161045.1956074-1-tobias@waldekranz.com>
 <20240205114138.uiwioqstybmzq77b@skbuf>
Date: Tue, 06 Feb 2024 15:54:25 +0100
Message-ID: <87v871skwu.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On m=C3=A5n, feb 05, 2024 at 13:41, Vladimir Oltean <olteanv@gmail.com> wro=
te:
> On Thu, Feb 01, 2024 at 05:10:45PM +0100, Tobias Waldekranz wrote:
>> Before this change, generation of the list of events MDB to replay
>
> s/events MDB/MDB events/
>
>> would race against the IGMP/MLD snooping logic, which could concurrently
>
> logic. This could (...)
>
>> enqueue events to the switchdev deferred queue, leading to duplicate
>> events being sent to drivers. As a consequence of this, drivers which
>> reference count memberships (at least DSA), would be left with orphan
>> groups in their hardware database when the bridge was destroyed.
>
> Still missing the user impact description, aka "when would this be
> noticed by, and actively bother an user?". Something that would justify
> handling this via net.git rather than net-next.git.

Other than moving up the example to this point, what do you feel is
missing? Or are you saying that you don't think this belongs on net.git?

>>=20
>> Avoid this by grabbing the write-side lock of the MDB while generating
>> the replay list, making sure that no deferred version of a replay
>> event is already enqueued to the switchdev deferred queue, before
>> adding it to the replay list.
>
> The description of the solution is actually not very satisfactory to me.
> I would have liked to see a more thorough analysis.

Sorry to disappoint.

> The race has 2 components, one comes from the fact that during replay,
> we iterate using RCU, which does not halt concurrent updates, and the
> other comes from the fact that the MDB addition procedure is non-atomic.
> Elements are first added to the br->mdb_list, but are notified to
> switchdev in a deferred context.
>
> Grabbing the bridge multicast spinlock only solves the first problem: it
> stops new enqueues of deferred events. We also need special handling of
> the pending deferred events. The idea there is that we cannot cancel
> them, since that would lead to complications for other potential
> listeners on the switchdev chain. And we cannot flush them either, since
> that wouldn't actually help: flushing needs sleepable context, which is
> incompatible with holding br->multicast_lock, and without
> br->multicast_lock held, we haven't actually solved anything, since new
> deferred events can still be enqueued at any time.
>
> So the only simple solution is to let the pending deferred events
> execute (eventually), but during event replay on joining port, exclude
> replaying those multicast elements which are in the bridge's multicast
> list, but were not yet added through switchdev. Eventually they will be.

In my opinion, your three paragraphs above say pretty much the same
thing as my single paragraph. But sure, I will try to provide more
details in v4.

> (side note: the handling code for excluding replays on pending event
> deletion seems to not actually help, because)
>
> Event replays on a switchdev port leaving the bridge are also
> problematic, but in a different way. The deletion procedure is also
> non-atomic, they are first removed from br->mdb_list then the switchdev
> notification is deferred. So, the replay procedure cannot enter a
> condition where it replays the deletion twice. But, there is no
> switchdev_deferred_process() call when the switchdev port unoffloads an
> intermediary LAG bridge port, and this can lead to the situation where
> neither the replay, nor the deferred switchdev object, trickle down to a
> call in the switchdev driver. So for event deletion, we need to force a
> synchronous call to switchdev_deferred_process().

Good catch!

What does this mean for v4? Is this still one logical change that
ensures that MDB events are always delivered exactly once, or a series
where one patch fixes the duplicates and one ensures that no events are
missed?

> See how the analysis in the commit message changes the patch?

Suddenly the novice was enlightened.

>>=20
>> An easy way to reproduce this issue, on an mv88e6xxx system, was to
>
> s/was/is/
>
>> create a snooping bridge, and immediately add a port to it:
>>=20
>>     root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snoo=
ping 1 && \
>>     > ip link set dev x3 up master br0
>>     root@infix-06-0b-00:~$ ip link del dev br0
>>     root@infix-06-0b-00:~$ mvls atu
>>     ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8 =
 9  a
>>     DEV:0 Marvell 88E6393X
>>     33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  . =
 .  .
>>     33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  . =
 .  .
>>     ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8 =
 9  a
>>     root@infix-06-0b-00:~$
>>=20
>> The two IPv6 groups remain in the hardware database because the
>> port (x3) is notified of the host's membership twice: once via the
>> original event and once via a replay. Since only a single delete
>> notification is sent, the count remains at 1 when the bridge is
>> destroyed.
>
> These 2 paragraphs, plus the mvls output, should be placed before the
> "Avoid this" paragraph.
>
>>=20
>> Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-jo=
ined mdb entries")
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---

