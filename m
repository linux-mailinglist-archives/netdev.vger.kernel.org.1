Return-Path: <netdev+bounces-66692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7D38404CE
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 13:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED591C21642
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4F860242;
	Mon, 29 Jan 2024 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imJqK5xz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092476024C
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530665; cv=none; b=Mg3wUGJGh/Qvc/Pl0RyrmEnFaGmdFB5Nd73RJM/eYrpQ6DXynfmS2ImDRUyGoW3RqHtQEgxpf+rp86Y/o4bblsgxadLdPtGL22ouMhAL8i9VpTxtqI4CHKm68LeESM1SW0K+PVYFyL7m3XVGAaq4d+dmXI5PicaCDnZw7U4Hzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530665; c=relaxed/simple;
	bh=BgJ+8HBT7LwYI2XDw7xA39/HDHvxdtz08ARZT632shg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTvPf2jiaRlM9uUC9VbQaFO86dqP/zuBrEHqAU2stfON7R5HO5200FOemJHE9uP8wOjdjdkOMg7aFaL+WOV/4TLSQXyZYcgZEtAwAWDb9yidLe9I1jNvBtSX6gcqVhyvCbnM38LkaoekDrfTkeuaknVjWHyUm77bC8hD3S9ihwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imJqK5xz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55f03ede12cso916482a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 04:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706530662; x=1707135462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZI6+a5NAhIof7F5ZSACo9ePsKwyUeHGMIez92wN9fo=;
        b=imJqK5xzgCb52jqy7SwObx3qBdfrRFkeAg6CpfHZgPbOBQXmI9tUBjbjXTjch3SlmU
         6QoxhTZ33LPEiNAxdmQONFF0JBmxDfUid+8jmqvz/ZZxp2PCtswSOquVGqqCe6Qtl3UA
         YgdxKuk8u7xOFmBWsEyY7WiFD+hUTSk/xAMKZsEZyu+WMStRwTkyXwqlclqBctnBay9A
         XqYrn4AlFdN+cknfVxW4qnOLGLHx5g6mhuZiAcglcUMQpnvXEHJ5OPUHEAv72/yq0DjS
         IEIqSdzyFsN/2lmmvJDmGtpV6goKyp+3x9onvjdES8J1ibK6xZDk3eZ/rONjBG7aVGXd
         dcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706530662; x=1707135462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZI6+a5NAhIof7F5ZSACo9ePsKwyUeHGMIez92wN9fo=;
        b=NVSXd9hb/3cMhR+BnIgbtgStQwQBwuPoWD4O30fgmA1QduAKW/87+cCD/5IijUGDmC
         zGwcOo5jmmgwxTFIkPMqSfDyJfXre1BmwyGNtnWZd4PyN+X5wuTT4wuxtafLZc/TGR8M
         43RyV5DwYdeeA79TmMMCVJO8ULCoHlA6YoeuNiB8zH/lgbLtRAxqsQzFG9P1PPCi224L
         k2QGa0xNfSl05hqu8qg/8zI5juA9l+2QAZoNoVGMZeHS8G01eBDXp95eZk8/kMU+Z0r0
         bQoNNRJRcA4+yx58Q/iKje7sDz1vh6XdyclQDXkypur8bwqgh6oZ2CLdsFknq6Abc3+4
         25MQ==
X-Gm-Message-State: AOJu0YzEWZ9JMXbJvMbYNGPL1zK1cGrKk7MFCIp/xE98Kxpaec/3V2B6
	9OgwUhPla029UfVFF+LtNMh2FLGRXEhcn+IvSfJ5ab7PM21If4k3
X-Google-Smtp-Source: AGHT+IEE+bB24++cEck7bYhac9AM2FC6D71oZhDonjQdNeQBwSFg+TQkEbjnI2y05woCblOxWb85kg==
X-Received: by 2002:a17:906:298d:b0:a28:32ff:8709 with SMTP id x13-20020a170906298d00b00a2832ff8709mr4128549eje.15.1706530661877;
        Mon, 29 Jan 2024 04:17:41 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id fj18-20020a1709069c9200b00a3496fa1f7fsm3889805ejc.91.2024.01.29.04.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:17:41 -0800 (PST)
Date: Mon, 29 Jan 2024 14:17:39 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: jiri@resnulli.us, ivecera@redhat.com, roopa@nvidia.com,
	razor@blackwall.org, netdev@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: net: switchdev: Port-to-Bridge Synchronization
Message-ID: <20240129121739.3ppum5ewok6atckz@skbuf>
References: <87fryl6l2a.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fryl6l2a.fsf@waldekranz.com>

Hi Tobias,

On Fri, Jan 26, 2024 at 12:38:05AM +0100, Tobias Waldekranz wrote:
> Hello netdev,
> 
> Let me start by describing an issue that I have found in the
> bridge/switchdev replay logic, which will lead to a larger question
> about how switchdev ports are synchronized with a bridge. Anyway, on the
> bug!
> 
> The steps to reproduce the issue are very simple on my board, but I've
> never seen it before, so it could be that you need a pretty fast (by
> embedded standards) SMP CPU to trigger the race.
> 
> Hardware:
> - Marvell CN9130 SoC
> - Marvell 88E6393X Switch
> 
> Steps:
> 1. Create a bridge with multicast snooping enabled
> 2. Attach an switch port to the bridge
> 3. Remove the bridge
> 
> If (2) is done immediately after (1), then my switch's hardware MDB will
> be left with two orphan entries after removing the bridge (3).
> 
> On a system running net-next with the switchdev tracepoint series[1]
> applied, this is what it looks like (with comm, pid, timestamp
> etc. trimmed from the trace output to make the lines a bit narrower,
> with an event number added instead):
> 
> root@infix-06-0b-00:~$ echo 1 >/sys/kernel/debug/tracing/events/switchdev/enable
> root@infix-06-0b-00:~$ cat /sys/kernel/debug/tracing/trace_pipe | grep HOST_MDB &
> [1] 2602
> root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && ip link set dev x3 up master br0
> 01: switchdev_defer: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:ff:87:e4:3f
> 02: switchdev_defer: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:00:00:00:6a
> 03: switchdev_call_replay: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:00:00:00:6a -> 0
> 04: switchdev_call_replay: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:ff:87:e4:3f -> 0
> 05: switchdev_call_blocking: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:ff:87:e4:3f -> 0
> 06: switchdev_call_blocking: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:00:00:00:6a -> 0
> 07: switchdev_defer: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:00:00:00:fb
> 08: switchdev_call_blocking: dev x3 PORT_OBJ_ADD HOST_MDB(flags 0x4 orig br0) vid 0 addr 33:33:00:00:00:fb -> 0
> root@infix-06-0b-00:~$ ip link del dev br0
> 09: switchdev_call_replay: dev x3 PORT_OBJ_DEL HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:00:00:00:fb -> 0
> 10: switchdev_call_replay: dev x3 PORT_OBJ_DEL HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:00:00:00:6a -> 0
> 11: switchdev_call_replay: dev x3 PORT_OBJ_DEL HOST_MDB(flags 0x0 orig br0) vid 0 addr 33:33:ff:87:e4:3f -> 0
> root@infix-06-0b-00:~$ mvls atu
> ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
> DEV:0 Marvell 88E6393X
> 33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
> 33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
> ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
> root@infix-06-0b-00:~$
> 
> Event 01 and 02 are generated when the bridge is parsing an MLD report
> generated by the kernel to register membership in the interface's link
> local group address and the All-Snoopers group. As we are in softirq
> context, the events are placed in the deferred queue.
> 
> More or less concurrently, the port is joining the bridge, and the DSA
> layer is sending a SWITCHDEV_BRPORT_OFFLOADED to request a replay of all
> relevant events that happened before it joined. Since we now find the
> two host entries in the bridge's MDB, we replay the events (03 and 04).
> 
> Once the replay is done, at some later point in time, we start to
> process the deferred events and send 05 and 06 (originally 01 and 02) to
> the driver again.
> 
> At this point, the DSA layer will have a recorded refcount of 2 for both
> of the groups in question, whereas the bridge only holds a single
> reference count of each membership.
> 
> Therefore, when we tear down the bridge, the corresponding UNOFFLOADED
> event will trigger another replay cycle, which will send a single delete
> event for each group, leaving the DSA layer's refcount at 1. This is
> confirmed by the mvls output, showing the two groups are still loaded in
> the ATU.
> 
> The end (of the bug report)
> 
> How can we make sure that this does not happen?
> 
> Broadly, it seems to me like we need the bridge to signal the start and
> end of a replay sequence (via the deferred queue), which the drivers can
> then use to determine when it should start/stop accepting deferred
> messages. I think this also means that we have to guarantee that no
> new events of a particular class can be generated while we are scanning
> the database of those objects and generating replay events.
> 
> Some complicating factors:
> 
> - There is no single stream of events to synchronize with.
>   - Some calls are deferred for later dispatch
>   - Some are run synchronously in a blocking context
>   - Some are run synchronously in an atomic context
> 
> - The rhashtable which backs the FDB is designed to be lock-free, making
>   it hard to ensure atomicity between a replay cycle and new addresses
>   being learned in the hotpath
> 
> - If we take this approach, how can we make sure that most of the
>   driver-side implementation can be shared in switchdev.c, and doesn't
>   have to be reinvented by each driver?
> 
> I really hope that someone can tell my why this problem is much easier
> than this!
> 
> [1]: https://lore.kernel.org/netdev/20240123153707.550795-1-tobias@waldekranz.com/

Please expect a few weeks from my side until I could take a close look
at this. Otherwise, here are some superficial (and maybe impractical) ideas.

I agree that the replay procedures race with the data path. Let's try to
concentrate on one at a time, and then see how the others are different.

We seem to need to distinguish the events that happened before the
SWITCHDEV_BRPORT_OFFLOADED event from those that happened afterwards.
The SWITCHDEV_BRPORT_OFFLOADED event itself runs under rtnl_lock()
protection, and so does switchdev_deferred_process(). So, purely from a
switchdev driver API perspective, things are relatively coarse grained,
and the order of operations within the NETDEV_CHANGEUPPER handler is not
very important, because at the end of the day, only this is: before
NETDEV_CHANGEUPPER, the port is not ready to process deferred switchdev
events, and after NETDEV_CHANGEUPPER, it is.

The problem is figuring out, during this relatively large rtnl_lock()
section, where to delineate events that are 'before' vs 'after'. We must
only replay what's 'before'.

Multicast database entries seem to have br->multicast_lock for serializing
writers. Currently we are not acquiring that during replay.

I'm thinking we could do something like this in br_switchdev_mdb_replay().
We could block concurrent callers to br_switchdev_mdb_notify() by
acquiring br->multicast_lock, so that br->mdb_list stays constant for a
while.

Then, after constructing the local mdb_list, the problem is that it
still contains some SWITCHDEV_F_DEFER elements which are pending a call
switchdev_deferred_process(). But that can't run currently, so we can
iterate through switchdev's "deferred" list and remove them from the
replay list, if we figure out some sort of reliable switchdev object
comparison function. Then we can safely release br->multicast_lock.

The big problem I see is that FDB notifications don't work that way.
They are also deferred, but all the deferred processing is on the
switchdev driver side, not on the bridge side. One of the reasons is
that the deferred side should not need rtnl_lock() at all. I don't see
how this model would scale to FDB processing.

