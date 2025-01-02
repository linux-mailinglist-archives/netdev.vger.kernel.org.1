Return-Path: <netdev+bounces-154684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE7D9FF71C
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B6A3A0428
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 08:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CED192B82;
	Thu,  2 Jan 2025 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDtAEUO+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A8A18C932
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735807844; cv=none; b=rs8XlbABnvDatOypnK8kTgHhCXrkGD4fICyzLJyjN42w0BqJu2q7uBGFzpF33xalk/cRY3X1cshr6Te8xCZJXpZ2zGFKIei0UV3gTAtH1bH9w0lzrkkEzAF28sipZAVwV42ryp1wo8iIXI6grvD7f4VK45Lor27494VMlAjDsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735807844; c=relaxed/simple;
	bh=PDkWUvP7kaJxnZPnQAgt5xBave6gK2+Ina1BdxnONaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS3uJc7z4LQ14aKA7yd2/XabNrDFmZHEVsL+Dq6QKo+c1u45GB5c2YDUCD3ahEKYs7ImoftjaXxM1tFBKLlUFF03WanLB9lVdM/cEjA/xoy9HcYx8jxeGyfGtOS0Y7Acf5C+oJ63GQPailvf9fCCtByZcjhizmjvs4z9kKDV7jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDtAEUO+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so13735372a91.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 00:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735807842; x=1736412642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVUP2XR0J+zdUj+0noNV4pVkEDlFvsaE8mHMt2HEe3s=;
        b=iDtAEUO+UKsnJugtluyAZH8el1Ya6NohM6Ime0uiyYCShuXpZLxD+UDYB8o3vQ6J+9
         UlB3qWAp87xeGstMECQlmjfaaZFF5po+qNKFwVABuzTkpcp0+CDi5mPV3bRVteO6fu83
         kVasVN5Ku45C3eoPKB4J/upBfLekTys/qDN2dELJUYPajgdIa3QerLuYae6bwcK5gXYL
         JyPltReg1KUnIuFSzTSJDJu8WQy5YU1n4DDx323b+ZMn3j0nM/tdR1qBbe/y9ZgogCfC
         zaoB0z07EyOMJxMluOvWsnc8PJabE43zByVBz46K1zBkaHWKLzBZ59GvPiBZ4F2r0ih8
         SddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735807842; x=1736412642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVUP2XR0J+zdUj+0noNV4pVkEDlFvsaE8mHMt2HEe3s=;
        b=lvzKcDlnGwaxQ2+may8LF2Xaco9DNhgoteqqoGxx0FgkekmYOkGJjvmsWAQGsDrE3G
         eydvhqmSSIIzJyWRA0tae+X/CxUreGIe77M9mJ3N65ZYI5GRoQQEIGgSjuTcTmeHpfKx
         HMia1LvFBdTc7lQJPJWHdZJQ/dixNuo2thvxC0zmeg4pHGMpua44NDFlWVvSslxiPgdf
         18c1bstxcUBqsmnH72SyKUMfaeu31QWGP777Q9YmZzys8XOiaGTKYf1iCv1h4oAewUAq
         hnVuill+jJLs2oqEbfIviK1wV4wIfd7IHlLKipAEK9EYkMgAVY1k4vkDTY6/Ys+ss+Mi
         vF8w==
X-Forwarded-Encrypted: i=1; AJvYcCWX219IcuU+BZkCzzBqF2p9PU4td0rJF5qQvRdkNGnNTUTEbhp9uwWsWLZBwZCg8uH+KK37BIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe5EgHB0F54ItEGoIb0d5zo608hb04ZHCJA97t4uJ4klqc3qr8
	HQOxFVoqiQ12TBOwbBhkuUu5EN17OoP8aZP2shv7hTvlEzOsLiZ4
X-Gm-Gg: ASbGnctqaO7QXZ7KzPBNtAyImu9ic3GQMvNQY+LKCh+tBf2+7kfIVo70aJmjJZDqvkO
	PieUk7UDv9vifM/wjSs4X71Qf0a+JHuazlYTtbSeFb69P6ZiTEjP1C38KAalBCVtwniyh6wfEnT
	d3GpwN2+Zwso91f3bXKHDD17nqYd+52bcy/Z1E15TBTwHdrbmzANUYiI0Dwa/SiXwqep7dmmsDf
	UTNqygVoy3dFpkq9YYs5aqy88BxkHcgIPxdYuVEhwWKDhZh+5uqSftl6s+HPA==
X-Google-Smtp-Source: AGHT+IEkEQS8qdTh3sSfZ9ZE6AdDj2sN3h9AkIAa1RZ1LtP6WrXXZTEIDI5ntirReODG/gULG89S3A==
X-Received: by 2002:a17:90b:3d44:b0:2ee:5a82:433a with SMTP id 98e67ed59e1d1-2f4536ee700mr64893299a91.17.1735807842112;
        Thu, 02 Jan 2025 00:50:42 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447882910sm25566127a91.32.2025.01.02.00.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 00:50:41 -0800 (PST)
Date: Thu, 2 Jan 2025 08:50:35 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Octavian Purdila <tavip@google.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] team: prevent adding a device which is already
 a team device lower
Message-ID: <Z3ZTWxLe5Js1B-zp@fedora>
References: <20241230205647.1338900-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230205647.1338900-1-tavip@google.com>

On Mon, Dec 30, 2024 at 12:56:47PM -0800, Octavian Purdila wrote:
> Prevent adding a device which is already a team device lower,
> e.g. adding veth0 if vlan1 was already added and veth0 is a lower of
> vlan1.
> 
> This is not useful in practice and can lead to recursive locking:
> 
> $ ip link add veth0 type veth peer name veth1
> $ ip link set veth0 up
> $ ip link set veth1 up
> $ ip link add link veth0 name veth0.1 type vlan protocol 802.1Q id 1
> $ ip link add team0 type team
> $ ip link set veth0.1 down
> $ ip link set veth0.1 master team0
> team0: Port device veth0.1 added
> $ ip link set veth0 down
> $ ip link set veth0 master team0
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.13.0-rc2-virtme-00441-ga14a429069bb #46 Not tainted
> --------------------------------------------
> ip/7684 is trying to acquire lock:
> ffff888016848e00 (team->team_lock_key){+.+.}-{4:4}, at: team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
> 
> but task is already holding lock:
> ffff888016848e00 (team->team_lock_key){+.+.}-{4:4}, at: team_add_slave (drivers/net/team/team_core.c:1147 drivers/net/team/team_core.c:1977)
> 
> other info that might help us debug this:
> Possible unsafe locking scenario:
> 
> CPU0
> ----
> lock(team->team_lock_key);
> lock(team->team_lock_key);
> 
> *** DEADLOCK ***
> 
> May be due to missing lock nesting notation
> 
> 2 locks held by ip/7684:
> 
> stack backtrace:
> CPU: 3 UID: 0 PID: 7684 Comm: ip Not tainted 6.13.0-rc2-virtme-00441-ga14a429069bb #46
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
> <TASK>
> dump_stack_lvl (lib/dump_stack.c:122)
> print_deadlock_bug.cold (kernel/locking/lockdep.c:3040)
> __lock_acquire (kernel/locking/lockdep.c:3893 kernel/locking/lockdep.c:5226)
> ? netlink_broadcast_filtered (net/netlink/af_netlink.c:1548)
> lock_acquire.part.0 (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851)
> ? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
> ? trace_lock_acquire (./include/trace/events/lock.h:24 (discriminator 2))
> ? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
> ? lock_acquire (kernel/locking/lockdep.c:5822)
> ? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
> __mutex_lock (kernel/locking/mutex.c:587 kernel/locking/mutex.c:735)
> ? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
> ? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
> ? fib_sync_up (net/ipv4/fib_semantics.c:2167)
> ? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
> team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
> notifier_call_chain (kernel/notifier.c:85)
> call_netdevice_notifiers_info (net/core/dev.c:1996)
> __dev_notify_flags (net/core/dev.c:8993)
> ? __dev_change_flags (net/core/dev.c:8975)
> dev_change_flags (net/core/dev.c:9027)
> vlan_device_event (net/8021q/vlan.c:85 net/8021q/vlan.c:470)
> ? br_device_event (net/bridge/br.c:143)
> notifier_call_chain (kernel/notifier.c:85)
> call_netdevice_notifiers_info (net/core/dev.c:1996)
> dev_open (net/core/dev.c:1519 net/core/dev.c:1505)
> team_add_slave (drivers/net/team/team_core.c:1219 drivers/net/team/team_core.c:1977)
> ? __pfx_team_add_slave (drivers/net/team/team_core.c:1972)
> do_set_master (net/core/rtnetlink.c:2917)
> do_setlink.isra.0 (net/core/rtnetlink.c:3117)
> 
> Reported-by: syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
> Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
>  drivers/net/team/team_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index c7690adec8db..dc7cbd6a9798 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1175,6 +1175,13 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>  		return -EBUSY;
>  	}
>  
> +	if (netdev_has_upper_dev(port_dev, dev)) {
> +		NL_SET_ERR_MSG(extack, "Device is already a lower device of the team interface");
> +		netdev_err(dev, "Device %s is already a lower device of the team interface\n",
> +			   portname);
> +		return -EBUSY;
> +	}
> +
>  	if (port_dev->features & NETIF_F_VLAN_CHALLENGED &&
>  	    vlan_uses_dev(dev)) {
>  		NL_SET_ERR_MSG(extack, "Device is VLAN challenged and team device has VLAN set up");
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

