Return-Path: <netdev+bounces-215702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29373B2FE6F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213D07AD77C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DF92D027F;
	Thu, 21 Aug 2025 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BvJg3Mwz"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B801228504C;
	Thu, 21 Aug 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790256; cv=none; b=JUngkbTfVZzUFePQv+hiWzPIpZgx07H+ZwdfbbqcoXXHPIl9GV7JHZAUghPbbZpYciPT/5cOXh64Si5J/C4+CrostqSKCli2LU2i30nqSZiQhNazNt1E0DiitUd38wPktuCcb8clu+fyI19TRaAc59AgFEuFhji3qBZ9mRaIKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790256; c=relaxed/simple;
	bh=05PHzoHMVwR6ddthq/BgLcxG9qF01Pf7UDeHo1O1HsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lUImCoNKNTzRbrCVkcWiO8d4AaIOjnM79bgZljw8E5uAtelSAZXcFaBHiBhV9RMTuPgArM5nfjr3s66Xstmju1CzHkdz3UQFIvy1s+wfuY83STDJoxe4POagXjIAgCE44IGHeaU9hm+Yazhky26galMuhcG+kghudyi+8fntK7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BvJg3Mwz; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eS
	5vhCsC0/h7I+A1AgF9DLrGouVZRFRwWpRzmCuEAZM=; b=BvJg3Mwzvev1uevJIG
	fZcL3FYF49GfklJdTe3j2dZmYTksTSvmC8vdAJlvyyfV2razhKOoKXdoqc4vM5wP
	yeRSBbzcly5SiE8bY40C7MktyKv8UWnnRNbUz7W5WStOKcta8irtUb/m2yDU76KV
	AzVA2+0dID8sfd9k+2GvAoSs0=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wB3dPKJO6do25ACDA--.6143S2;
	Thu, 21 Aug 2025 23:30:18 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] net: af_packet: Use hrtimer to do the retire operation
Date: Thu, 21 Aug 2025 23:30:17 +0800
Message-Id: <20250821153017.3607708-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3dPKJO6do25ACDA--.6143S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWfuF15ur18Wr45KF47twb_yoW8CFWfp3
	y2qry7J3W8Ja12qFZ7Xa1DJFy3Gan5Jr45Jr4fXF15AF9xWFy7JFW2vFWFqFWSgr4vkrsF
	vF1rJ39xA3WDurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UaLvNUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibhWwCminM+CFTAAAsU

On Thu, 2025-08-21 at 22:32 +0800, Willem wrote:

> Thanks for the analysis.
> 
> Using hrtimer_start from within the callback that returns
> HRTIMER_RESTART does not sound in line with the intention of the API
> to me.
> 
> I think we should just adjust and restart from within the callback and
> hrtimer_start from tpacket_rcv iff the timer is not yet queued.
> 
> Since all these modifications are made while the receive queue lock is
> held I don't immediately see why we would need additional mutual
> exclusion beyond that.


The hrtimer callback is called by __run_hrtimer, if we only use hrtimer_forward_now in the callback,
it will not restart the time within the callback. The timer will be enqueued after the callback
return. So when the timer is being enqueued, it is not protected by sk_receive_queue.lock.

Consider the following timing sequence:
timer   cpu0 (softirq context, hrtimer timeout)                cpu
0       hrtimer_run_softirq
1         __hrtimer_run_queues
2           __run_hrtimer
3             prb_retire_rx_blk_timer_expired
4               spin_lock(&po->sk.sk_receive_queue.lock);
5               _prb_refresh_rx_retire_blk_timer
6                 hrtimer_forward_now
7               spin_unlock(&po->sk.sk_receive_queue.lock)
8             raw_spin_lock_irq(&cpu_base->lock);              tpacket_rcv
9             enqueue_hrtimer                                    spin_lock(&sk->sk_receive_queue.lock);
10                                                               packet_current_rx_frame
11                                                                 __packet_lookup_frame_in_block
12            finish enqueue_hrtimer                                 prb_open_block
13                                                                     _prb_refresh_rx_retire_blk_timer
14                                                                       hrtimer_is_queued(&pkc->retire_blk_timer) == true
15                                                                       hrtimer_forward_now
16                                                                         WARN_ON

On cpu0 in the timing sequence above, enqueue_hrtimer is not protected by sk_receive_queue.lock,
while the hrtimer_forward_now is not protected by raw_spin_lock_irq(&cpu_base->lock).

It will cause WARN_ON if we only use 'hrtimer_is_queued(&pkc->retire_blk_timer) == true' to check
whether to call hrtimer_forward_now.


Thanks
Xin Zhao


