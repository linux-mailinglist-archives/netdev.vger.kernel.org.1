Return-Path: <netdev+bounces-71749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA3B854EF6
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 17:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D0B28BACF
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE82604BB;
	Wed, 14 Feb 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMGZNjv7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AC4604BA
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929165; cv=none; b=l5vAGbOkCUbqIHZluO661Q7k+3EvKcDug+Geypr73bgexaG43pKnuO+nEnKHF2kHRmmao+pcQA/ye1WPR407YqeLrcfWCAPUoTscZMl7AdESgONGgcGpoHSJA+4vDrGSenfmA/cRreF7ZyrA8XnbClnuyM+Qk2WEDDo1AXH6k8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929165; c=relaxed/simple;
	bh=2q7cLSi0Gd2ENmAbGtzWnZ+mBZp/E6h2LXwHHZHsHkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTO+YS5vsCGtmgEzx/kvMRvElNXJgb1I7u9heb1SlybuTDhblpe8oCzAJHyfDjv0R5Q0kMxMTlWRhMsmsdYRmHf8iknY9QPBQQWG7S6QSpZH1xX3aTgvHyYF6bBB12untAYrlEyOdbGkLQUz5UzxayAQ5Xf1YDRqT4Jh3kYL5bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMGZNjv7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-561f8b8c058so1969449a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 08:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707929162; x=1708533962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxQN/1zQrCH98IYYOLyInk5Os7l9aGTXjyFr1WcC+WE=;
        b=OMGZNjv7t+3cDTG0i1Jc0j/PS+bStTg3/tuzCtHsnUCmYB8DLcEY9Hxk/JZXKtTLhO
         g6dU0Fk/F4Y9yeWf5ahTpc1+J0mmJktW+9mr9cZR0jnfvKcxhNKXkfx431Cpw722XaY9
         Kq5BHB6frX8i+5Xu3yONln9ygcplK1PZ75dHRUDRMTHOhfGLd7X8VgcHs7Lv3/RytyNS
         NyxzhvDjRHdUkGgLZfSJ6cuhqi4pqm+NPyLdk7J7A86wDTVL9Kb7zbCdncMzeKSVyt5p
         4j0SbmIQW080jcgvd89oFqWWVsGaDvKNQjAQipFkgVCtijAUImwjzYezLBjXg6ia4fsv
         b+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707929162; x=1708533962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxQN/1zQrCH98IYYOLyInk5Os7l9aGTXjyFr1WcC+WE=;
        b=Y9pdKdJzjtaSL7X2+ryQXuUW/Mssa2jUplRbEo5Qv8MJ+RTjMO2JmybagUPh/pY2YR
         mGhGXw49Mhj6fkfoEUJrm7huka38mgb0t4/WYHPx5+4gyHDfU/xMfvEFlmDTUA0Q8Bwv
         S7WZcfwNMj/kA0kW1Q2t6gNZOe1c4Cl59ZmbchGRlsVChS9c7HHW9PUc2SlsXC03YJce
         a2tm2avfXy57ih6csRd5viniSLJsYIS+Wm2unm+JqMYSElG7m6CmIanjSgGKkJsmk4YV
         VsIakoebYUP5MIZ1INxMf9PJ/nZ3HsV4hoZV7GG1RzwR7D+6nMP6w5gkJhGcvPjza7hB
         3FEg==
X-Forwarded-Encrypted: i=1; AJvYcCWmNYj4jnrRizNSLIaOZSQh00Am5d5YLhi3Q175kB9WA2BeulQ6KuI6hEJjlp6ES1SuGRDJBJybElX96f5RDShTClwvQoIY
X-Gm-Message-State: AOJu0YxvwtYb6cgf/D9Ip420gl2hWZy45L2d2tzSAQWEyyg9YsfvuTE9
	ieWtPCy3Rspd7sDekkLKqqwM/AzTo9Kv/q7vzq1KhFkjDVsuxoAX
X-Google-Smtp-Source: AGHT+IFnTjS9mtXyhY8TtcRIoPIE0u5cL8S0F7na2Q1yrKH4or2igg07i+Y27IJ/PEHjgcoK/wmKig==
X-Received: by 2002:aa7:d418:0:b0:563:85aa:c769 with SMTP id z24-20020aa7d418000000b0056385aac769mr1590877edq.20.1707929162077;
        Wed, 14 Feb 2024 08:46:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1qlMKYaJKp14wDb4UKwsfNyNPOTyFwImnmc8r2N/uYl5FpDDsRKpokud/1Tv8CnBl3Xl29hGOElLIAeu6aGkHU+lfeqZfLVWsOJeQ9w2RJaigPIrhQ5OxzkJ3UAaT/OhgF+8AHiJChqCq1s1Yb4Z0uOFoRCeiB6IlGRyhJllU67vOiI4Qejd6JI4lEF4+D9f1vJ77hfEmaeX3JKIVI2vo2s0YaQdokgxUFuIC7YqDqS0h9vTwu7l2LfyqOwr3nNu+aPLf7BugnwFGaddiBL3T
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id dh12-20020a0564021d2c00b005638c060464sm384553edb.25.2024.02.14.08.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:46:01 -0800 (PST)
Date: Wed, 14 Feb 2024 18:45:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, atenart@kernel.org,
	roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
	netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH v4 net 1/2] net: bridge: switchdev: Skip MDB replays of
 deferred events on offload
Message-ID: <20240214164559.njyaoscx2e22esep@skbuf>
References: <20240212191844.1055186-1-tobias@waldekranz.com>
 <20240212191844.1055186-1-tobias@waldekranz.com>
 <20240212191844.1055186-2-tobias@waldekranz.com>
 <20240212191844.1055186-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212191844.1055186-2-tobias@waldekranz.com>
 <20240212191844.1055186-2-tobias@waldekranz.com>

On Mon, Feb 12, 2024 at 08:18:43PM +0100, Tobias Waldekranz wrote:
> Before this change, generation of the list of MDB events to replay
> would race against the creation of new group memberships, either from
> the IGMP/MLD snooping logic or from user configuration.
> 
> While new memberships are immediately visible to walkers of
> br->mdb_list, the notification of their existence to switchdev event
> subscribers is deferred until a later point in time. So if a replay
> list was generated during a time that overlapped with such a window,
> it would also contain a replay of the not-yet-delivered event.
> 
> The driver would thus receive two copies of what the bridge internally
> considered to be one single event. On destruction of the bridge, only
> a single membership deletion event was therefore sent. As a
> consequence of this, drivers which reference count memberships (at
> least DSA), would be left with orphan groups in their hardware
> database when the bridge was destroyed.
> 
> This is only an issue when replaying additions. While deletion events
> may still be pending on the deferred queue, they will already have
> been removed from br->mdb_list, so no duplicates can be generated in
> that scenario.
> 
> To a user this meant that old group memberships, from a bridge in
> which a port was previously attached, could be reanimated (in
> hardware) when the port joined a new bridge, without the new bridge's
> knowledge.
> 
> For example, on an mv88e6xxx system, create a snooping bridge and
> immediately add a port to it:
> 
>     root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && \
>     > ip link set dev x3 up master br0
> 
> And then destroy the bridge:
> 
>     root@infix-06-0b-00:~$ ip link del dev br0
>     root@infix-06-0b-00:~$ mvls atu
>     ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
>     DEV:0 Marvell 88E6393X
>     33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>     33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>     ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
>     root@infix-06-0b-00:~$
> 
> The two IPv6 groups remain in the hardware database because the
> port (x3) is notified of the host's membership twice: once via the
> original event and once via a replay. Since only a single delete
> notification is sent, the count remains at 1 when the bridge is
> destroyed.
> 
> Then add the same port (or another port belonging to the same hardware
> domain) to a new bridge, this time with snooping disabled:
> 
>     root@infix-06-0b-00:~$ ip link add dev br1 up type bridge mcast_snooping 0 && \
>     > ip link set dev x3 up master br1
> 
> All multicast, including the two IPv6 groups from br0, should now be
> flooded, according to the policy of br1. But instead the old
> memberships are still active in the hardware database, causing the
> switch to only forward traffic to those groups towards the CPU (port
> 0).
> 
> Eliminate the race in two steps:
> 
> 1. Grab the write-side lock of the MDB while generating the replay
>    list.
> 
> This prevents new memberships from showing up while we are generating
> the replay list. But it leaves the scenario in which a deferred event
> was already generated, but not delivered, before we grabbed the
> lock. Therefore:
> 
> 2. Make sure that no deferred version of a replay event is already
>    enqueued to the switchdev deferred queue, before adding it to the
>    replay list, when replaying additions.
> 
> Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-joined mdb entries")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Excellent from my side, thank you!

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

> @@ -307,6 +336,50 @@ int switchdev_port_obj_del(struct net_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
>  
> +/**
> + *	switchdev_port_obj_act_is_deferred - Is object action pending?
> + *
> + *	@dev: port device
> + *	@nt: type of action; add or delete
> + *	@obj: object to test
> + *
> + *	Returns true if a deferred item is exists, which is equivalent
> + *	to the action @nt of an object @obj.

nitpick: replace "is exists" with something else like "is pending" or
"exists".

Also "action of an object" or "on an object"?

> + *
> + *	rtnl_lock must be held.
> + */

