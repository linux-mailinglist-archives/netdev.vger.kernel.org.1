Return-Path: <netdev+bounces-69095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D29A84990B
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4457B284D93
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 11:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECB9182D4;
	Mon,  5 Feb 2024 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0ykTXQG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175DD199D9
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133305; cv=none; b=UIFxfYleFGt94a406fKyQqxZLZKziI+uqD+FFTDx/zms09wXa9Ia1K1BIEtxKr6HYttseVLkU5sOlo5LlQ+RicRM2JGb+NkTN6FYFbTJgG4VsIzKvEYBQOb/qqeEMpb1NAZUGiiXOa01XWuNn2X09cNWVe7Hf6zv4u2ZUGVUoIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133305; c=relaxed/simple;
	bh=0BvHj8YUx8Q8Mi86gp2nO09A7PYzIxUar6bZ+pAe+tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/Sdkj3bNOh8HAQDLdFQRIfB9clOr8SwJXD8j5jqudY57yA5w/hiNVbh4Qe6d8KK3YUFisf668v7mY9YcH/aH6ouZpZqQF9OQN/mw4e1Meq49HerrViSV5oKnxSd0MmZfmgI5BkuvSyThpypTHnsZUl0ZAKo+KO+6xw+iksMcmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0ykTXQG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b13332ca7so2691890f8f.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 03:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707133301; x=1707738101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2NcjInO6CiSLYlF9JWwNu1WoSKPHx1fyhS9S8pVayk=;
        b=H0ykTXQGOkNoTUmOhFpC43vxdYbSzOeCcg5jI/P6C1HAcO0gxzCKuH1rx4KelKpxUy
         PibWj4/jDu9WCPnmYKmmrWwh2dBMWA8MOxT67ck5STPe5WnobUPgAH1/9wQfJieKRxOv
         B8ZZHSziHfDaozhUVNqLJrG5NaN6ST+Ka46dMYtf8rL+RflBmV0CRke7AvVQD4LGHGig
         tHGXNTT+meZSQBmqza/MIy+N741oz5P2s35+jhJSGTDRlmnf5vOfKBQxfELowMlCuVEj
         8iKzj18QUOtTegmtHxRbVBiLraSx6kAwK5rqZm9nRe8kl//yip2IBeUoWFVGZG5p/qiC
         4TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707133301; x=1707738101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2NcjInO6CiSLYlF9JWwNu1WoSKPHx1fyhS9S8pVayk=;
        b=Tb5rhDoMiL5EzES2GDiSoo62hudLQOdIM7pfUb/BayebcJa4Ev/v607cDnRqhyY25Q
         63X7S8lJMYcIcrZE9NbKSIT40gH2k0Oyr67hykvrghf6J5mhMkFgddjffAnPPTuE1+Ag
         3GRgkWVAvTOxHZIfvSPegkxMnBEXxyURWFu4hT7zcAhLCypEve1qqzf2Yu6RO5RnOhgT
         8ffpqCowyidX6JQ3AGt0YgqZyulCqhvEbuIcnq8f7YGLph6YZhv/xhxdRnIyNGEigwpv
         /Vs2XCL0mD+GivGFD5WpDXMxOpRl60Z7nxFbwv9G+R6VxDietX3zESUbQwqljJts19aF
         fN3Q==
X-Gm-Message-State: AOJu0YyA2JLRjaeO38+jBvo/Qh06bGLF9g9LQRjTaoBha+BBFCSGxUGp
	adxSWUR0q7o57M4NKvHjBTmTOk/iBTmGzgV1Oie/ls3KjyIuqHMn
X-Google-Smtp-Source: AGHT+IE3+PNWVFcqtxE4SQcGD7q3IvlybjIvIgFDOboMn7j+1HcsAFIUBEc0SUkUQECU9PhlRNwODw==
X-Received: by 2002:a5d:5f4b:0:b0:33a:eb5c:aa25 with SMTP id cm11-20020a5d5f4b000000b0033aeb5caa25mr4301889wrb.23.1707133301076;
        Mon, 05 Feb 2024 03:41:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWlN+MmZhTGpZ+O4h8Uvu/qEz3CfF//zsyQXfAnrYsCLKWlDHSpmWSFoMT5j1JBIPdLqrJ6/NYOtIiNO7//gH7K6sV/sWf8iQkAw4TkvYHNQpCTahYCT/3QEwn+dEDs1+erOtuHa548DRlhU4l5sBSyF+0qvfAMpiI1xVGuRqfbIqe3ZV4X4YuB9cTZo6GwNlKNntQQt8sKQ7qLN7hm9DD3bQdPkx+W0UYm0Lh3rAc3wAC/Zg7wkVeDURGzGx/qnEGO/ZGE/wzKtNKEC883jvdh
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id x5-20020adfdd85000000b0033afe6968bfsm7891052wrl.64.2024.02.05.03.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 03:41:40 -0800 (PST)
Date: Mon, 5 Feb 2024 13:41:38 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, atenart@kernel.org,
	roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
	netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH v3 net] net: bridge: switchdev: Skip MDB replays of
 pending events
Message-ID: <20240205114138.uiwioqstybmzq77b@skbuf>
References: <20240201161045.1956074-1-tobias@waldekranz.com>
 <20240201161045.1956074-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201161045.1956074-1-tobias@waldekranz.com>
 <20240201161045.1956074-1-tobias@waldekranz.com>

On Thu, Feb 01, 2024 at 05:10:45PM +0100, Tobias Waldekranz wrote:
> Before this change, generation of the list of events MDB to replay

s/events MDB/MDB events/

> would race against the IGMP/MLD snooping logic, which could concurrently

logic. This could (...)

> enqueue events to the switchdev deferred queue, leading to duplicate
> events being sent to drivers. As a consequence of this, drivers which
> reference count memberships (at least DSA), would be left with orphan
> groups in their hardware database when the bridge was destroyed.

Still missing the user impact description, aka "when would this be
noticed by, and actively bother an user?". Something that would justify
handling this via net.git rather than net-next.git.

> 
> Avoid this by grabbing the write-side lock of the MDB while generating
> the replay list, making sure that no deferred version of a replay
> event is already enqueued to the switchdev deferred queue, before
> adding it to the replay list.

The description of the solution is actually not very satisfactory to me.
I would have liked to see a more thorough analysis.

The race has 2 components, one comes from the fact that during replay,
we iterate using RCU, which does not halt concurrent updates, and the
other comes from the fact that the MDB addition procedure is non-atomic.
Elements are first added to the br->mdb_list, but are notified to
switchdev in a deferred context.

Grabbing the bridge multicast spinlock only solves the first problem: it
stops new enqueues of deferred events. We also need special handling of
the pending deferred events. The idea there is that we cannot cancel
them, since that would lead to complications for other potential
listeners on the switchdev chain. And we cannot flush them either, since
that wouldn't actually help: flushing needs sleepable context, which is
incompatible with holding br->multicast_lock, and without
br->multicast_lock held, we haven't actually solved anything, since new
deferred events can still be enqueued at any time.

So the only simple solution is to let the pending deferred events
execute (eventually), but during event replay on joining port, exclude
replaying those multicast elements which are in the bridge's multicast
list, but were not yet added through switchdev. Eventually they will be.

(side note: the handling code for excluding replays on pending event
deletion seems to not actually help, because)

Event replays on a switchdev port leaving the bridge are also
problematic, but in a different way. The deletion procedure is also
non-atomic, they are first removed from br->mdb_list then the switchdev
notification is deferred. So, the replay procedure cannot enter a
condition where it replays the deletion twice. But, there is no
switchdev_deferred_process() call when the switchdev port unoffloads an
intermediary LAG bridge port, and this can lead to the situation where
neither the replay, nor the deferred switchdev object, trickle down to a
call in the switchdev driver. So for event deletion, we need to force a
synchronous call to switchdev_deferred_process().

See how the analysis in the commit message changes the patch?

> 
> An easy way to reproduce this issue, on an mv88e6xxx system, was to

s/was/is/

> create a snooping bridge, and immediately add a port to it:
> 
>     root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && \
>     > ip link set dev x3 up master br0
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

These 2 paragraphs, plus the mvls output, should be placed before the
"Avoid this" paragraph.

> 
> Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-joined mdb entries")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

