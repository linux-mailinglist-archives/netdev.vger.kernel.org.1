Return-Path: <netdev+bounces-198195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F343ADB904
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99904188F3BE
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831821C7017;
	Mon, 16 Jun 2025 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXRLsHil"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D462A2BF002;
	Mon, 16 Jun 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750099551; cv=none; b=GVXrGKsmGu5BkDP93bm2n7y2rqiyJoAWACMCUiRCSK480eHKRCKbZWV4PRGpL0qDjCpCw2KhmqaTIXnEUBqxhDahKgDG164pj8BMJ7IaXsVV3DqHbLpmRuhC2XZZ+9HOqR/8Jds1BPeFrXANULnM7ZuXtbm8FWG1kXDgTHWTM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750099551; c=relaxed/simple;
	bh=PWRrU/nhnbEEQXIRehwd7hiAmqBZh6xONYgy6dPRc1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cveMhSnh+yWqImXg1E67i47U0RrfkxwZEUj9kAVeQy2W+4G562oNzSdPXyoiLLUPObBGtUWI5NNV1tzRLGrS6S8bLqrdi4B8PDMcW+FzGIhVzI4pjWfDHQmgTslsA71+EGPH6AxkUunnolFVXw+Ok5Oz1pspoi3E5H5lUpEriyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXRLsHil; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b271f3ae786so3572228a12.3;
        Mon, 16 Jun 2025 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750099549; x=1750704349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAJTMnfiTyiugQjSMN1EodzwtQFO0srT3qnAsiFzsR8=;
        b=XXRLsHil4BDanh4XFFR1Zn5Vu0epz+2iHlHgCuTt878wendU6BO1YGPzd/Rv1/qOID
         +Y6d7L1FP0Iz/6ejNcY1lqxdof0Drl49TrDkxSdzhF/3Fi0Xnz3v0ffOdx3Fy0Upie06
         tX5DOc0IMIk0R2Jhud4W7/1xbEDWAChG0LbhooxgZDfn6YeHnoOKlbALgL9upiFGk2e1
         mcMZWDEmMEWhKvD22/DH+ED3iab9oDklq4URfdWFah/yCkBnxF8BbN01D2wBg3qj8Eio
         VXSf0VGhsFWqf3Oa7DNlj66ANbhsJBiNJgKmt+1CnrfiR47Vh+GxcBlgzTmSMJF3PQqs
         CWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750099549; x=1750704349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAJTMnfiTyiugQjSMN1EodzwtQFO0srT3qnAsiFzsR8=;
        b=Z/QRKaD/UeldelhBRuwuaA5E3Cj+V92TIB4Kmb1/NsVwiCcf0rVR/fOlGY7bJmSW3E
         5yuBbwy8gddexx8iBkOXIpirA0LLw7txGISgLXZeRPg8cqgGX7kNGJeKKpAto4fuGXmE
         ZLw0WKblezrM1OE8kObvetEuu6tH772T2QsA0FsItd+zwRUONI0/8wD+Pa3VU/y0n0iI
         Mfua5mSOCvi+6XmCOteGkBxKnsRAjvYw/qST9d8LmC3bgLF0ayIYfyPhxlEfjyXKU+xV
         5ixKRh5UqYj1MfUmm3TfCeqg9u5b2Ei3kR1eLOfWi+WtMiGMGNY17k6HYJ0vK8Y9Se6V
         fi4w==
X-Forwarded-Encrypted: i=1; AJvYcCUgOUyUu1BaN7tc+Led3f8fJ3/hDzX5uIvQqPBAeU8pEuDf9AuDRku5zy6yM3lDcsDHTMJZOoEwlOVbHpI=@vger.kernel.org, AJvYcCXsP+GQiq20PgKwrgfEbBDJQaDWsNfphGwrwlLovDkUGZ++DZq1zgDXIG9qTXhzBsUtZQfqScbO@vger.kernel.org
X-Gm-Message-State: AOJu0YyeWbkHUz7olMMc7VuG2YyasL4H7A0MOAeClBUXvATir9FRnkKn
	Sh2yvGxnqbggAxwZEYG5uPjwHoWfJ+P094qCmzIXvfZUrooggqFWfAY=
X-Gm-Gg: ASbGncu2VWYoHP4PxLvnvcvJoLUIwyYALnDKJcN7T/uHORmkj0uoJn6plKnwpXr6d+i
	z5CPnlvjcNM7MlmjKO4/W5A3jRYgWePY3rJU7blQGsp4yR2tfQ466AkBi9vf2TZWdrxOZDL/Dp+
	cufLj5Pgco/VVvyH1BsXcw9zmAuMhGHeLZlHRUvNuqOVVRG7IoaEq8Y0AbDRt4M/i1LpyOb6+lt
	u75+YrsZ0AsCTEiRIrmCQdA3fH86M3oF0xn0UkA+GKTbvSGrwRglY1SplxMv/+vIXgQaDEiiJxY
	AmAEzVrOqpAxhe5RcG5uU3/9B7Kcv6NhlxTKFzE=
X-Google-Smtp-Source: AGHT+IErj5Rqevhxmsu520CVdeIcerjzJXoZ8EiLsvY0G7oMf0R99YLanVTeuqukt2pfWlUPsV/8hA==
X-Received: by 2002:a05:6a20:7343:b0:21c:faa4:9ab8 with SMTP id adf61e73a8af0-21fbd4c7e63mr14577962637.10.1750099549050;
        Mon, 16 Jun 2025 11:45:49 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1689af8sm6163881a12.59.2025.06.16.11.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 11:45:48 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: stfomichev@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jv@jvosburgh.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	liuhangbin@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com,
	kuniyu@google.com
Subject: Re: [PATCH net] bonding: switch bond_miimon_inspect to rtnl lock
Date: Mon, 16 Jun 2025 11:44:21 -0700
Message-ID: <20250616184541.978458-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616172213.475764-1-stfomichev@gmail.com>
References: <20250616172213.475764-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Mon, 16 Jun 2025 10:22:13 -0700
> Syzkaller reports the following issue:
> 
>  RTNL: assertion failed at ./include/net/netdev_lock.h (72)
>  WARNING: CPU: 0 PID: 1141 at ./include/net/netdev_lock.h:72 netdev_ops_assert_locked include/net/netdev_lock.h:72 [inline]
>  WARNING: CPU: 0 PID: 1141 at ./include/net/netdev_lock.h:72 __linkwatch_sync_dev+0x1ed/0x230 net/core/link_watch.c:279
> 
>  ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:63
>  bond_check_dev_link+0x3f9/0x710 drivers/net/bonding/bond_main.c:863
>  bond_miimon_inspect drivers/net/bonding/bond_main.c:2745 [inline]
>  bond_mii_monitor+0x3c0/0x2dc0 drivers/net/bonding/bond_main.c:2967
>  process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
>  process_scheduled_works kernel/workqueue.c:3321 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
>  kthread+0x3c5/0x780 kernel/kthread.c:464
>  ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> As discussed in [0], the report is a bit bogus, but it exposes
> the fact that bond_miimon_inspect might sleep while its being
> called under RCU read lock. Convert bond_miimon_inspect callers
> (bond_mii_monitor) to rtnl lock.
> 
> Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
> Link: http://lore.kernel.org/netdev/aEt6LvBMwUMxmUyx@mini-arch [0]
> Fixes: f7a11cba0ed7 ("bonding: hold ops lock around get_link")
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 34 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index c4d53e8e7c15..ab40f0828680 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2720,7 +2720,6 @@ static int bond_slave_info_query(struct net_device *bond_dev, struct ifslave *in
>  
>  /*-------------------------------- Monitoring -------------------------------*/
>  
> -/* called with rcu_read_lock() */
>  static int bond_miimon_inspect(struct bonding *bond)
>  {
>  	bool ignore_updelay = false;
> @@ -2729,17 +2728,17 @@ static int bond_miimon_inspect(struct bonding *bond)
>  	struct slave *slave;
>  
>  	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP) {
> -		ignore_updelay = !rcu_dereference(bond->curr_active_slave);
> +		ignore_updelay = !rtnl_dereference(bond->curr_active_slave);
>  	} else {
>  		struct bond_up_slave *usable_slaves;
>  
> -		usable_slaves = rcu_dereference(bond->usable_slaves);
> +		usable_slaves = rtnl_dereference(bond->usable_slaves);
>  
>  		if (usable_slaves && usable_slaves->count == 0)
>  			ignore_updelay = true;
>  	}
>  
> -	bond_for_each_slave_rcu(bond, slave, iter) {
> +	bond_for_each_slave(bond, slave, iter) {
>  		bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
>  
>  		link_state = bond_check_dev_link(bond, slave->dev, 0);
> @@ -2962,35 +2961,28 @@ static void bond_mii_monitor(struct work_struct *work)
>  	if (!bond_has_slaves(bond))
>  		goto re_arm;
>  
> -	rcu_read_lock();
> +	/* Race avoidance with bond_close cancel of workqueue */
> +	if (!rtnl_trylock()) {
> +		delay = 1;
> +		should_notify_peers = false;

nit: we can remove this line.

Also, now call_netdevice_notifiers() can be moved up before rearm:.


> +		goto re_arm;
> +	}
> +
>  	should_notify_peers = bond_should_notify_peers(bond);
>  	commit = !!bond_miimon_inspect(bond);
>  	if (bond->send_peer_notif) {

nit: we don't need {} here.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> -		rcu_read_unlock();
> -		if (rtnl_trylock()) {
> -			bond->send_peer_notif--;
> -			rtnl_unlock();
> -		}
> -	} else {
> -		rcu_read_unlock();
> +		bond->send_peer_notif--;
>  	}



