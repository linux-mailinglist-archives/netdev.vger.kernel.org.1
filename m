Return-Path: <netdev+bounces-66040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B86B83D0CC
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 00:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDAA1C23AAF
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 23:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76865125B7;
	Thu, 25 Jan 2024 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="amo4z3W1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA82F18E00
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 23:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706225892; cv=none; b=ElGhjAMX2jPftTRl3XRiHq9kn1j3Z6VCg4Lf02bE7FuUqh4xgs5r+IE9eTwJ301qTGEKh1KLuxSHM8DdQmbRFWVEB3gqT/ua/7sbZMlNjiNMLAam/C9KM7JMG8yNW8inZ5qsWEgAswg7s5VRlEoqo9qDk1U1UyF3ISXAgM4d9Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706225892; c=relaxed/simple;
	bh=rQxsIPw4ltyNyopc66d4dKSxBhDm6RQUyfXO/Es/Zu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZSmnFanmXrx69JVKFxSjNXDRK7+ddd/m1FEOcc5+91dV2fG0auiuhkov7OXKXYlPMK6zRpHgR4FxXYW2aae+7Pw7muN5deTv7P9eXglZYJnIMmAYGFbRGpvvclj3mi5hw9xcr0ZbWw514Vk4XlCuodCqmr8FLSE4FuqOUT2V340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=amo4z3W1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5100cb64e7dso3962866e87.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 15:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706225888; x=1706830688; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dwubq2bYae3KBFecFHPHMYc1hmT+c4+sZe86rg5b7U4=;
        b=amo4z3W1T+fKuZPylGgD9xwZyla6YFnXBC+BmxCKLLKdfU3qP4K19Ev3czwHlEJ4eg
         UFVKXwKu6qR6o0JdjBQJq2GRZ3LV3nm9/4FrsRURcgERzeR+8vkyQaLrYbwy7/CDL3a4
         Xp+p9WhQ9GCY5IS/FmK9Fdo7b+6GYPoDQh0NN+0/dDv4Uvsu/5rIpdbP2I/FbkwhHdOn
         eofOdOjuGyl5O9mA8s4kcWhfetB8BM2ORkb7pvC7M67AP4oxpK+7tRAq2g5qXsOIykPt
         7oOP2B21vPtBQkGA8YyIO2DlralFa5rq+Dobyc2ch6pozYNUAqXEm5BZ6J+xHfVWBGsI
         42ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706225888; x=1706830688;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dwubq2bYae3KBFecFHPHMYc1hmT+c4+sZe86rg5b7U4=;
        b=tCybmXx0f/b4VHin1H8ojgBqz5dtq4vCGXvGvJ1Ycg0JSOhaBrCQ30Uhln1hLDsaa4
         hYFjqw+cJV3cbe/SXy7RYDEi7zIoeE8RUHEKIEg/dnatnK/2RKUcmkDTPaJGaqe/NUax
         7O9jusYeEFaPhitIOWTzl9J8AUjVWyry5cdneU9mvNhXHeC4eTKE2p7TY0OAshiG2MKi
         U2fUg3KSsvFkQpDZySk4SuenhX8oaKavm5Yn7zVLGo8ssE0mAQJVu6QI/joGrj8vMDwn
         gYmjBR43qs4LBh/wxOGGVaiDcUOcLY58DfSWRkhxge8SxQfxwRzlJPwKhyvv0UHrzlNO
         9TIg==
X-Gm-Message-State: AOJu0YzrTgiSpXJTcNnTrXXOaH5JnbM+FcNJYIu4MXh9IGa6E34jLlJg
	RYkua1yEnGwMr0xYq17KtreuBThtxuLfLXdAGw/k4JhVBI4lDxsxURA2SUlHwaU=
X-Google-Smtp-Source: AGHT+IHvQiqN05UMfEGVZMojCnj+FENSv7WHyLXhRXyUIhaU0wEIYILnj/2jROtpiZTVn9a6PL5nBg==
X-Received: by 2002:a19:384c:0:b0:510:df8:72cf with SMTP id d12-20020a19384c000000b005100df872cfmr155947lfj.175.1706225887182;
        Thu, 25 Jan 2024 15:38:07 -0800 (PST)
Received: from wkz-x13 (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id v17-20020ac258f1000000b0050e7dcc05a5sm8277lfo.102.2024.01.25.15.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 15:38:06 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: jiri@resnulli.us, ivecera@redhat.com, roopa@nvidia.com,
 razor@blackwall.org, olteanv@gmail.com
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev
Subject: net: switchdev: Port-to-Bridge Synchronization
Date: Fri, 26 Jan 2024 00:38:05 +0100
Message-ID: <87fryl6l2a.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello netdev,

Let me start by describing an issue that I have found in the
bridge/switchdev replay logic, which will lead to a larger question
about how switchdev ports are synchronized with a bridge. Anyway, on the
bug!

The steps to reproduce the issue are very simple on my board, but I've
never seen it before, so it could be that you need a pretty fast (by
embedded standards) SMP CPU to trigger the race.

Hardware:
- Marvell CN9130 SoC
- Marvell 88E6393X Switch

Steps:
1. Create a bridge with multicast snooping enabled
2. Attach an switch port to the bridge
3. Remove the bridge

If (2) is done immediately after (1), then my switch's hardware MDB will
be left with two orphan entries after removing the bridge (3).

On a system running net-next with the switchdev tracepoint series[1]
applied, this is what it looks like (with comm, pid, timestamp
etc. trimmed from the trace output to make the lines a bit narrower,
with an event number added instead):

root@infix-06-0b-00:~$ echo 1 >/sys/kernel/debug/tracing/events/switchdev/enable
root@infix-06-0b-00:~$ cat /sys/kernel/debug/tracing/trace_pipe | grep HOST_MDB &
[1] 2602
root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && ip link set dev x3 up master br0
01: switchdev_defer: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:ff:87:e4:3f
02: switchdev_defer: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:00:00:00:6a
03: switchdev_call_replay: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:00:00:00:6a -> 0
04: switchdev_call_replay: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:ff:87:e4:3f -> 0
05: switchdev_call_blocking: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:ff:87:e4:3f -> 0
06: switchdev_call_blocking: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:00:00:00:6a -> 0
07: switchdev_defer: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:00:00:00:fb
08: switchdev_call_blocking: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:00:00:00:fb -> 0
root@infix-06-0b-00:~$ ip link del dev br0
09: switchdev_call_replay: dev x3 PORT_OBJ_DEL HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:00:00:00:fb -> 0
10: switchdev_call_replay: dev x3 PORT_OBJ_DEL HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:00:00:00:6a -> 0
11: switchdev_call_replay: dev x3 PORT_OBJ_DEL HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:ff:87:e4:3f -> 0
root@infix-06-0b-00:~$ mvls atu
ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
DEV:0 Marvell 88E6393X
33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
root@infix-06-0b-00:~$

Event 01 and 02 are generated when the bridge is parsing an MLD report
generated by the kernel to register membership in the interface's link
local group address and the All-Snoopers group. As we are in softirq
context, the events are placed in the deferred queue.

More or less concurrently, the port is joining the bridge, and the DSA
layer is sending a SWITCHDEV_BRPORT_OFFLOADED to request a replay of all
relevant events that happened before it joined. Since we now find the
two host entries in the bridge's MDB, we replay the events (03 and 04).

Once the replay is done, at some later point in time, we start to
process the deferred events and send 05 and 06 (originally 01 and 02) to
the driver again.

At this point, the DSA layer will have a recorded refcount of 2 for both
of the groups in question, whereas the bridge only holds a single
reference count of each membership.

Therefore, when we tear down the bridge, the corresponding UNOFFLOADED
event will trigger another replay cycle, which will send a single delete
event for each group, leaving the DSA layer's refcount at 1. This is
confirmed by the mvls output, showing the two groups are still loaded in
the ATU.

The end (of the bug report)

How can we make sure that this does not happen?

Broadly, it seems to me like we need the bridge to signal the start and
end of a replay sequence (via the deferred queue), which the drivers can
then use to determine when it should start/stop accepting deferred
messages. I think this also means that we have to guarantee that no
new events of a particular class can be generated while we are scanning
the database of those objects and generating replay events.

Some complicating factors:

- There is no single stream of events to synchronize with.
  - Some calls are deferred for later dispatch
  - Some are run synchronously in a blocking context
  - Some are run synchronously in an atomic context

- The rhashtable which backs the FDB is designed to be lock-free, making
  it hard to ensure atomicity between a replay cycle and new addresses
  being learned in the hotpath

- If we take this approach, how can we make sure that most of the
  driver-side implementation can be shared in switchdev.c, and doesn't
  have to be reinvented by each driver?

I really hope that someone can tell my why this problem is much easier
than this!

[1]: https://lore.kernel.org/netdev/20240123153707.550795-1-tobias@waldekranz.com/

