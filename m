Return-Path: <netdev+bounces-173709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12124A5B197
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 01:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AEB188596A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 00:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622F91367;
	Tue, 11 Mar 2025 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1blr+xo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD0360
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651872; cv=none; b=UjUg1NT7F77zQhAffipq6uOXmOcmKRE4MbeqZe0pZGg/900BD1yZ/OnaszTMjKZVKFxP9EubIpwS7zeH9bvDXxm3QkLitaS8xsm59rQ0r0br3dxNsH9RjGtsvKW1lUFXhdMO3u41jZ8/0YEwCZ6KRu9xpdLFir6eUxpolCTugi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651872; c=relaxed/simple;
	bh=tzUPOTXJVGIqNBs4ia+98gXJk+eyexsO5HP8Ihqkirs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8Vz8vkc3hYNwvpb+uDdW9rSCtHOuqaRkMRWeyrgU7Tf/ekesqctrYokUs8qJIcDBWBXjf85kQNiC0ALh0Twz4TqUips2DVV8qbSAfQwAtN5pDE/TmNyxihHbRqwv8JbOAhY7zW2N2bK0WcRWLS254eEQ23GjnHzVFu/oQCm1qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1blr+xo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf825f46bso1068615e9.3
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 17:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741651869; x=1742256669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8vTAu2ZrXjYY5UOjPWFtno+1TQDLwD4B6iJCMlsyFqY=;
        b=T1blr+xoy/D8hEUyD83fbYsaPxbIwz2I4hS8Gpds8uUp7sAxL5hYbdTb6+kc0u1J1O
         dzE7aS0WDd0czBl/ebBRA0ACL4/X+Kfa1N+YmlWodsuNO/oYtZs4CJF31FYPhtVeS7nO
         nj3JgsTbA+r+YRUVjXVE9eDdkbYto6mzXDZ0FMZkUzqDTyuJB88iCux/9EwwcjdUQHyQ
         5PlNQNOi/gMTiN1k8fSSbo4fTb3K/rdMJu5f6K4mfKFHkS9haEKJ59hY3FUzmQuOYj0T
         PCYW3A4vGVLsxZiJ8PMC0jzexCIvhOvXKMNRBHafbTUqOod/UQaSWLdRIPjCT52gPt4s
         MFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741651869; x=1742256669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vTAu2ZrXjYY5UOjPWFtno+1TQDLwD4B6iJCMlsyFqY=;
        b=L0Era8Y7sr45GPeTQ/RexygD2Jzw5J1u4UkIQrPJ81jZ/jbYA0ekgb75jPoiedfbK7
         uPruQf/fMbgAroluzdLtywM4n/2XdeK116WE7ig7XXvdfldX64ORIfwPOCM8FNBGij+6
         gBr6mK5GUkwYwKwjxpUCFxWFra4GRLeMTK7BPYC5W+gFCyIv2MCulbhFYmvQGH7iKZPL
         oTrtL4vARL7BkHvOTipCKgCRhDK06zuGe5TSSVfkA7fRqFzDvY+Uv2eog1Fzh1+v3PNh
         MQXPBxbQxHbp500MKxcT0uSeSWZBkUXzjah5bIZGMiTEBgl0pIdXKuUq18NOoCgonXvg
         n3sQ==
X-Gm-Message-State: AOJu0Yylhj72tRA5vUCOK0gXOIX48tiXqWKHbeLonuInjikP6KDD1+5K
	lgIyU7LSEnP/8o7zW0v2FZO/IWn6/9ILDvq36Qp3MmhuxW9rAgtv
X-Gm-Gg: ASbGncuGP5lhrHcutAx1drUWFrMDeKZ3BgR6BPQYOZCZa8W/4m28FMbWecSDpdjB9VJ
	oVU0EZOZEfUvqJgCfrA8Ngj4QE9VDY/kNhbjUl2Hfi440B5ig6FD6LUaOiah8L9eBESIQlTOyef
	6GgOaE1+f5QWxSSHcEtmQXLJGNz2zlKnQcpSzoc/h6onbRiHqDAFzfOTk5uN2gx7T3iZ6169zqe
	aJm6PbrPaw2pRDLFSGsFbrZ4IXlPj44vQ3TRT9Rtrp9GmItPYbDZC7GPrf75VI+tYsLRHkL2QrD
	hRPA/9kZgwsGMZE5YwVl54whJVf9Z5Yknhqs9W6MgYA=
X-Google-Smtp-Source: AGHT+IHA5Ml2DHT5LOBX5yRoB0ovInHUzYZyq+8yiTUbg7tKpQo7bezfxyLtaFcP0srVrzAlb3LUUg==
X-Received: by 2002:a05:600c:5107:b0:43b:c0fa:f9e5 with SMTP id 5b1f17b1804b1-43d01c1246fmr8319305e9.4.1741651868473;
        Mon, 10 Mar 2025 17:11:08 -0700 (PDT)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01d81csm16609476f8f.58.2025.03.10.17.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 17:11:06 -0700 (PDT)
Date: Tue, 11 Mar 2025 02:11:03 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Amit Cohen <amcohen@nvidia.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com,
	jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, tobias@waldekranz.com
Subject: Re: [PATCH net] net: switchdev: Convert blocking notification chain
 to a raw one
Message-ID: <20250311001103.wkbk6y3b736kcf2k@skbuf>
References: <20250305121509.631207-1-amcohen@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305121509.631207-1-amcohen@nvidia.com>

Hi Amit,

On Wed, Mar 05, 2025 at 02:15:09PM +0200, Amit Cohen wrote:
> A blocking notification chain uses a read-write semaphore to protect the
> integrity of the chain. The semaphore is acquired for writing when
> adding / removing notifiers to / from the chain and acquired for reading
> when traversing the chain and informing notifiers about an event.
> 
> In case of the blocking switchdev notification chain, recursive
> notifications are possible which leads to the semaphore being acquired
> twice for reading and to lockdep warnings being generated [1].
> 
> Specifically, this can happen when the bridge driver processes a
> SWITCHDEV_BRPORT_UNOFFLOADED event which causes it to emit notifications
> about deferred events when calling switchdev_deferred_process().
> 
> Fix this by converting the notification chain to a raw notification
> chain in a similar fashion to the netdev notification chain. Protect
> the chain using the RTNL mutex by acquiring it when modifying the chain.
> Events are always informed under the RTNL mutex, but add an assertion in
> call_switchdev_blocking_notifiers() to make sure this is not violated in
> the future.
> 
> Maintain the "blocking" prefix as events are always emitted from process
> context and listeners are allowed to block.
> 
> [1]:
> WARNING: possible recursive locking detected
> 6.14.0-rc4-custom-g079270089484 #1 Not tainted
> --------------------------------------------
> ip/52731 is trying to acquire lock:
> ffffffff850918d8 ((switchdev_blocking_notif_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0
> 
> but task is already holding lock:
> ffffffff850918d8 ((switchdev_blocking_notif_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0
> 
> other info that might help us debug this:
> Possible unsafe locking scenario:
> CPU0
> ----
> lock((switchdev_blocking_notif_chain).rwsem);
> lock((switchdev_blocking_notif_chain).rwsem);
> 
> *** DEADLOCK ***
> May be due to missing lock nesting notation
> 3 locks held by ip/52731:
>  #0: ffffffff84f795b0 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x727/0x1dc0
>  #1: ffffffff8731f628 (&net->rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x790/0x1dc0
>  #2: ffffffff850918d8 ((switchdev_blocking_notif_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0
> 
> stack backtrace:
> ...
> ? __pfx_down_read+0x10/0x10
> ? __pfx_mark_lock+0x10/0x10
> ? __pfx_switchdev_port_attr_set_deferred+0x10/0x10
> blocking_notifier_call_chain+0x58/0xa0
> switchdev_port_attr_notify.constprop.0+0xb3/0x1b0
> ? __pfx_switchdev_port_attr_notify.constprop.0+0x10/0x10
> ? mark_held_locks+0x94/0xe0
> ? switchdev_deferred_process+0x11a/0x340
> switchdev_port_attr_set_deferred+0x27/0xd0
> switchdev_deferred_process+0x164/0x340
> br_switchdev_port_unoffload+0xc8/0x100 [bridge]
> br_switchdev_blocking_event+0x29f/0x580 [bridge]
> notifier_call_chain+0xa2/0x440
> blocking_notifier_call_chain+0x6e/0xa0
> switchdev_bridge_port_unoffload+0xde/0x1a0
> ...
> 
> Fixes: f7a70d650b0b6 ("net: bridge: switchdev: Ensure deferred event delivery on unoffload")
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>

