Return-Path: <netdev+bounces-71839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 794D48554CC
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D9EB27B19
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A98713EFEF;
	Wed, 14 Feb 2024 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="HbIgEG/w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23413DBA4
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946103; cv=none; b=qQ4Iyw5uaSKIGu7V7YGbPAxBgVW40OgNvCDMDWYYywMKATYsFUVr8jLv8cNhwgdGFZM0qnQj1kO7YDrpZEFfu2MtTB0vjAomgqO2GjvsAg+jxQY3UphQ1h5WDgzJsCQx4j2xlArF26NYzxYmZthx2BygYo5s4qhOG7vkZQ563tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946103; c=relaxed/simple;
	bh=W3hqiAmXPnZQ9NX6VJmLTTloH7XzACotEv1s2QgZq7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Si84r8K6lIyNgOgPv6m7wB5wNVvM1qt+uDVmtgS04la27TyplZ5JLtSeZ3jE1cEGq7XwYe2L8nUXOjoOgmmUQyHvsTEF1eybAVlkrcR75GXWRqyAZDzrxzbXr8caKmlpZGYRfgTXStVHfJR2U67Zb/x6IRoXlcaqYOdKOhoiyvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=HbIgEG/w; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d1080cb9easo2207671fa.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 13:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1707946099; x=1708550899; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GzA5avL8gv7Eamf8Qn+I9wrsDb8fJb56ZlvYAuz9Cko=;
        b=HbIgEG/wUv7rIrqmGSmr/ZvKmpfjxymnYzihtT5tgDi5ZtTyEIAxocuzfTfw/wxXzJ
         3e6dmhtcqur/O6Co/ZWX6JaUh68QilwofHMd8Tj+qAUdUQ18lomLuvRJ9fx3k+kyBAvU
         64hAiR4r1Ny9cHb1ZLKKy+xrm+w0qV+pl53J2Qm9/0YBM9e1Y6b7XIPMYoR07QVILuBI
         E5w5AamRpm/mWuTzPik0fzbMpjokfMmAz6Dnc2VTjjki13cf5aWsl3+yjIjCWlJYtXhS
         WK6Q7Be+IhDFL/ZqaZCyTPIjTEeAlyf6bTWv/clhL+pJ8JCwyMH9XL+HM08fS4Yi6nSX
         rMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946099; x=1708550899;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzA5avL8gv7Eamf8Qn+I9wrsDb8fJb56ZlvYAuz9Cko=;
        b=ca03O7+cHhgd7URuPPlUpuBw8gjUUDMCkIlg0W45kDmkN/6B4UBWTaJI8Q9Mrd27ny
         ERvJpzuvZId36AfwAi28ObC8Cg2vaAQpHNrZeYKw+jmHqiOU2Ux31tjc4QPrZ4guo1DR
         MF42fNHlTWXCJfz8CQ2pWYHQvmfyBu9YWb1hPIfM4VLkKwmxwW0oKouPDy8Hw61w+YdY
         Gtn3FjU1kR9c1O4A/k8t097aeJBEgNkISgjOU1y9zBAvYKsKMFqBgQb8tuZCNsxz0njL
         fbtAf2i24LEz2nuo36nJgl73PjIBzUInjVX4jwDI4eIkQv5jKOq++kAD5L4O2Ra8U3mj
         4Ekg==
X-Forwarded-Encrypted: i=1; AJvYcCXjtmNZzgTCbjgfHJi293ZzNpzfsyznWN+RjNQo2fmOuOl3U9t06rrLXH4+bvbkqTx77rcqGrlOuogYTeYbfVFOfbIqQKGh
X-Gm-Message-State: AOJu0YzrtisJxQ3NvFBIS2C2gVN1+cw+GZNPRJz1Qqkb4z5c3jTUNhJZ
	TJOo7q8cvaj07ZXljL+zEY9dCh1mWcblgYPf/Aw+tB6SnOqgJHkSoC3D8u5Mpms=
X-Google-Smtp-Source: AGHT+IErole3KRd6VHExjNL3Uxn8WlQEsTkH4AIcFevBIACqE0kq5opOU5SaBX4qw+AlVUwPHJKaMQ==
X-Received: by 2002:a2e:870c:0:b0:2d0:c37b:edc1 with SMTP id m12-20020a2e870c000000b002d0c37bedc1mr2784578lji.36.1707946098700;
        Wed, 14 Feb 2024 13:28:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAY+FzQOGbWaobJ7Bp4RmLp2GyQzc9/XotQBrHN0Gvqs1NKhjWMKATqwVNB5PJ8uYJVjXSQCDy+ZV8Yb5Cq+a3K/E6ak07HGqewFWmcEG/o5uxUSE2IshX+hKHcUTfWgeHaxuERytyRoLj8ksK83JKDFJebZdTQpKx7p1VsCary0BzeVMCy5GaZVgXCBQE/ghpBCWvDiuMFGNI79N+2YV92etuThM6QCLnQVhskUW6PqQC6iIpgiJ38HETTQLysECAaugTpxxt4AI2DoH/iYYr
Received: from wkz-x13 (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id j15-20020a2e6e0f000000b002d0c639e0cesm983131ljc.6.2024.02.14.13.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:28:17 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, atenart@kernel.org,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH v4 net 1/2] net: bridge: switchdev: Skip MDB replays of
 deferred events on offload
In-Reply-To: <20240214164559.njyaoscx2e22esep@skbuf>
References: <20240212191844.1055186-1-tobias@waldekranz.com>
 <20240212191844.1055186-1-tobias@waldekranz.com>
 <20240212191844.1055186-2-tobias@waldekranz.com>
 <20240212191844.1055186-2-tobias@waldekranz.com>
 <20240214164559.njyaoscx2e22esep@skbuf>
Date: Wed, 14 Feb 2024 22:28:16 +0100
Message-ID: <87plwysplb.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ons, feb 14, 2024 at 18:45, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Mon, Feb 12, 2024 at 08:18:43PM +0100, Tobias Waldekranz wrote:
>> Before this change, generation of the list of MDB events to replay
>> would race against the creation of new group memberships, either from
>> the IGMP/MLD snooping logic or from user configuration.
>> 
>> While new memberships are immediately visible to walkers of
>> br->mdb_list, the notification of their existence to switchdev event
>> subscribers is deferred until a later point in time. So if a replay
>> list was generated during a time that overlapped with such a window,
>> it would also contain a replay of the not-yet-delivered event.
>> 
>> The driver would thus receive two copies of what the bridge internally
>> considered to be one single event. On destruction of the bridge, only
>> a single membership deletion event was therefore sent. As a
>> consequence of this, drivers which reference count memberships (at
>> least DSA), would be left with orphan groups in their hardware
>> database when the bridge was destroyed.
>> 
>> This is only an issue when replaying additions. While deletion events
>> may still be pending on the deferred queue, they will already have
>> been removed from br->mdb_list, so no duplicates can be generated in
>> that scenario.
>> 
>> To a user this meant that old group memberships, from a bridge in
>> which a port was previously attached, could be reanimated (in
>> hardware) when the port joined a new bridge, without the new bridge's
>> knowledge.
>> 
>> For example, on an mv88e6xxx system, create a snooping bridge and
>> immediately add a port to it:
>> 
>>     root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && \
>>     > ip link set dev x3 up master br0
>> 
>> And then destroy the bridge:
>> 
>>     root@infix-06-0b-00:~$ ip link del dev br0
>>     root@infix-06-0b-00:~$ mvls atu
>>     ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
>>     DEV:0 Marvell 88E6393X
>>     33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>>     33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>>     ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
>>     root@infix-06-0b-00:~$
>> 
>> The two IPv6 groups remain in the hardware database because the
>> port (x3) is notified of the host's membership twice: once via the
>> original event and once via a replay. Since only a single delete
>> notification is sent, the count remains at 1 when the bridge is
>> destroyed.
>> 
>> Then add the same port (or another port belonging to the same hardware
>> domain) to a new bridge, this time with snooping disabled:
>> 
>>     root@infix-06-0b-00:~$ ip link add dev br1 up type bridge mcast_snooping 0 && \
>>     > ip link set dev x3 up master br1
>> 
>> All multicast, including the two IPv6 groups from br0, should now be
>> flooded, according to the policy of br1. But instead the old
>> memberships are still active in the hardware database, causing the
>> switch to only forward traffic to those groups towards the CPU (port
>> 0).
>> 
>> Eliminate the race in two steps:
>> 
>> 1. Grab the write-side lock of the MDB while generating the replay
>>    list.
>> 
>> This prevents new memberships from showing up while we are generating
>> the replay list. But it leaves the scenario in which a deferred event
>> was already generated, but not delivered, before we grabbed the
>> lock. Therefore:
>> 
>> 2. Make sure that no deferred version of a replay event is already
>>    enqueued to the switchdev deferred queue, before adding it to the
>>    replay list, when replaying additions.
>> 
>> Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-joined mdb entries")
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>
> Excellent from my side, thank you!

Thanks!

> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
>
>> @@ -307,6 +336,50 @@ int switchdev_port_obj_del(struct net_device *dev,
>>  }
>>  EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
>>  
>> +/**
>> + *	switchdev_port_obj_act_is_deferred - Is object action pending?
>> + *
>> + *	@dev: port device
>> + *	@nt: type of action; add or delete
>> + *	@obj: object to test
>> + *
>> + *	Returns true if a deferred item is exists, which is equivalent
>> + *	to the action @nt of an object @obj.
>
> nitpick: replace "is exists" with something else like "is pending" or
> "exists".
>
> Also "action of an object" or "on an object"?

Yes, these are annoying. I might as well send a v5.

pw-bot: changes-requested

>> + *
>> + *	rtnl_lock must be held.
>> + */

