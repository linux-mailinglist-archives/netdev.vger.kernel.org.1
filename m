Return-Path: <netdev+bounces-220609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA52B475D8
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 19:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F87C35AA
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A664B2BD01E;
	Sat,  6 Sep 2025 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gUtA0tcB"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49A1F94A;
	Sat,  6 Sep 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757179848; cv=none; b=XWFdCqAX/TCZiFv5fkoX1lmmUrcaKrJ3GC9ZFfjWv5wox0ruy6fuQUtWTYYwGSBf9Tn97ME1kdRrEuSCyT7fdQk+4QL0aUHDo4gOUViyLwpoA0J1lNsXBdV+MpW4QJmxX7dICfs6ZfGJDSodZqxlFrJiO7BGpIsAq3uo9NCd4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757179848; c=relaxed/simple;
	bh=lY+DS6mHFzi2pKRJxntO5cz7uawoXIrIP5TwnkX3LBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QEzk8LQoNNlLB3Bps/t5XT2BI5+sNtS7DV+PuEVJwRgae+cXju/sq6urkU6/8dsaiaNtSW/V726rSStaTj3J0h/ZM6NePc6PvzZ07n1grZCL2m1DchZvf8ymjjTjaP7VqDFmSy0eXXK6ME1Ch0R4qJLPHaDFQXffM+XfFctkdDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gUtA0tcB; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=MJ
	u/9PoCR1OEbESlMnG9vVMb2l31pESeJiucrrwNtZ4=; b=gUtA0tcBY2Frv/yInx
	KFoEMVl+08PXomhK1DqEebYwFiCnVk7zblc/qNw7gX7m/yS//jqbX+/Kn9XV+dDB
	kwzfuKpc25+a2/+G+2rYieYbztSR6R2Lp93UeGJ2T7px0N3f7w3mx11wG3xmkagG
	GfHHoc50OuaBHWuedeB/4pJ74=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3f+Wbb7xoubfqGQ--.36512S2;
	Sun, 07 Sep 2025 01:30:04 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com,
	kerneljasonxing@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH net-next v11 0/2] net: af_packet: optimize retire operation
Date: Sun,  7 Sep 2025 01:29:59 +0800
Message-Id: <20250906173001.3656356-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f+Wbb7xoubfqGQ--.36512S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw43ZFyDKrWUJw4DAFWxCrg_yoWfXF4fpa
	yUu34xGw4DZ342gw4xZan7ZFyrZw43Jr1UGrs3J3yFyan8CFy8AFW2934SqFZ7ta95Kwn7
	Zr48XF13A3Z8AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi8hL5UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibgXACmi8bb4vIgAAsr

In a system with high real-time requirements, the timeout mechanism of
ordinary timers with jiffies granularity is insufficient to meet the
demands for real-time performance. Meanwhile, the optimization of CPU
usage with af_packet is quite significant. Use hrtimer instead of timer
to help compensate for the shortcomings in real-time performance.
In HZ=100 or HZ=250 system, the update of TP_STATUS_USER is not real-time
enough, with fluctuations reaching over 8ms (on a system with HZ=250).
This is unacceptable in some high real-time systems that require timely
processing of network packets. By replacing it with hrtimer, if a timeout
of 2ms is set, the update of TP_STATUS_USER can be stabilized to within
3 ms.

---
Changes in v11:
- Modify the commit message of PATCH 1/2 to explain the changes clearly
  as suggested by Jason Xing.
- structure tpacket_kbdq_core needs a new organization
  as suggested by Jason Xing.
- Change the comments of prb_retire_rx_blk_timer_expired and prb_open_block
  as suggested by Jason Xing.

Changes in v10:
- kactive_blk_num (K) is incremented on block close. last_kactive_blk_num (L)
  is set to match K on block open and each timer. So the only time that they
  differ is if a block is closed in tpacket_rcv and no new block could be
  opened. So the origin check L==K in timer callback only skip the case 'no
  new block to open'. If we remove L==K check, it will make prb_curr_blk_in_use
  check earlier, which will not cause any side effect
  as suggested by Willem de Bruijn.
- Submit a precursor patch that removes last_kactive_blk_num
  as suggested by Willem de Bruijn.
- Link to v10: https://lore.kernel.org/all/20250831100822.1238795-1-jackzxcui1989@163.com/

Changes in v9:
- Remove the function prb_setup_retire_blk_timer and move hrtimer setup and start
  logic into function init_prb_bdqc
  as suggested by Willem de Bruijn.
- Always update last_kactive_blk_num before hrtimer callback return as the origin
  logic does, as suggested by Willem de Bruijn.
  In tpacket_rcv, it may call prb_close_block but do not call prb_open_block in
  prb_dispatch_next_block, leading to inconsistency between last_kactive_blk_num
  and kactive_blk_num. In hrtimer callback, we should update last_kactive_blk_num
  in this case.
- Remove 'refresh_timer:' label which is not needed while I change goto logic to
  if-else implementation.
- Link to v9: https://lore.kernel.org/all/20250828155127.3076551-1-jackzxcui1989@163.com/

Changes in v8:
- Delete delete_blk_timer field, as suggested by Willem de Bruijn,
  hrtimer_cancel will check and wait until the timer callback return and ensure
  enter enter callback again;
- Simplify the logic related to setting timeout, as suggestd by Willem de Bruijn.
  Currently timer callback just restarts itself unconditionally, so delete the
 'out:' label, do not forward hrtimer in prb_open_block, call hrtimer_forward_now
  directly and always return HRTIMER_RESTART. The only special case is when
  prb_open_block is called from tpacket_rcv. That would set the timeout further
  into the future than the already queued timer. An earlier timeout is not
  problematic. No need to add complexity to avoid that.
- Link to v8: https://lore.kernel.org/all/20250827150131.2193485-1-jackzxcui1989@163.com/

Changes in v7:
- Only update the hrtimer expire time within the hrtimer callback.
  When the callback return, without sk_buff_head lock protection, __run_hrtimer will
  enqueue the timer if return HRTIMER_RESTART. Setting the hrtimer expires while
  enqueuing a timer may cause chaos in the hrtimer red-black tree.
  The setting expire time is monotonic, so if we do not update the expire time to the
  retire_blk_timer when it is not in callback, it will not cause problem if we skip
  the timeout event and update it when find out that expire_ktime is bigger than the
  expire time of retire_blk_timer.
- Use hrtimer_set_expires instead of hrtimer_forward_now.
  The end time for retiring each block is not fixed because when network packets are
  received quickly, blocks are retired rapidly, and the new block retire time needs
  to be recalculated. However, hrtimer_forward_now increments the previous timeout
  by an interval, which is not correct.
- The expire time is monotonic, so if we do not update the expire time to the
  retire_blk_timer when it is not in callback, it will not cause problem if we skip
  the timeout event and update it when find out that expire_ktime is bigger than the
  expire time of retire_blk_timer.
- Adding the 'bool callback' parameter back is intended to more accurately determine
  whether we are inside the hrtimer callback when executing
  _prb_refresh_rx_retire_blk_timer. This ensures that we only update the hrtimer's
  timeout value within the hrtimer callback.
- Link to v7: https://lore.kernel.org/all/20250822132051.266787-1-jackzxcui1989@163.com/

Changes in v6:
- Use hrtimer_is_queued instead to check whether it is within the callback function.
  So do not need to add 'bool callback' parameter to _prb_refresh_rx_retire_blk_timer
  as suggested by Willem de Bruijn;
- Do not need local_irq_save and local_irq_restore to protect the race of the timer
  callback running in softirq context or the open_block from tpacket_rcv in process
  context
  as suggested by Willem de Bruijn;
- Link to v6: https://lore.kernel.org/all/20250820092925.2115372-1-jackzxcui1989@163.com/

Changes in v5:
- Remove the unnecessary comments at the top of the _prb_refresh_rx_retire_blk_timer,
  branch is self-explanatory enough
  as suggested by Willem de Bruijn;
- Indentation of _prb_refresh_rx_retire_blk_timer, align with first argument on
  previous line
  as suggested by Willem de Bruijn;
- Do not call hrtimer_start within the hrtimer callback
  as suggested by Willem de Bruijn
  So add 'bool callback' parameter to _prb_refresh_rx_retire_blk_timer to indicate
  whether it is within the callback function. Use hrtimer_forward_now instead of
  hrtimer_start when it is in the callback function and is doing prb_open_block.
- Link to v5: https://lore.kernel.org/all/20250819091447.1199980-1-jackzxcui1989@163.com/

Changes in v4:
- Add 'bool start' to distinguish whether the call to _prb_refresh_rx_retire_blk_timer
  is for prb_open_block. When it is for prb_open_block, execute hrtimer_start to
  (re)start the hrtimer; otherwise, use hrtimer_forward_now to set the expiration
  time as it is more commonly used compared to hrtimer_set_expires.
  as suggested by Willem de Bruijn;
- Delete the comments to explain why hrtimer_set_expires(not hrtimer_forward_now)
  is used, as we do not use hrtimer_set_expires any more;
- Link to v4: https://lore.kernel.org/all/20250818050233.155344-1-jackzxcui1989@163.com/

Changes in v3:
- return HRTIMER_NORESTART when pkc->delete_blk_timer is true
  as suggested by Willem de Bruijn;
- Drop the retire_blk_tov field of tpacket_kbdq_core, add interval_ktime instead
  as suggested by Willem de Bruijn;
- Add comments to explain why hrtimer_set_expires(not hrtimer_forward_now) is used in
  _prb_refresh_rx_retire_blk_timer
  as suggested by Willem de Bruijn;
- Link to v3: https://lore.kernel.org/all/20250816170130.3969354-1-jackzxcui1989@163.com/

Changes in v2:
- Drop the tov_in_msecs field of tpacket_kbdq_core added by the patch
  as suggested by Willem de Bruijn;
- Link to v2: https://lore.kernel.org/all/20250815044141.1374446-1-jackzxcui1989@163.com/

Changes in v1:
- Do not add another config for the current changes
  as suggested by Eric Dumazet;
- Mention the beneficial cases 'HZ=100 or HZ=250' in the changelog
  as suggested by Eric Dumazet;
- Add some performance details to the changelog
  as suggested by Ferenc Fejes;
- Delete the 'pkc->tov_in_msecs == 0' bounds check which is not necessary
  as suggested by Willem de Bruijn;
- Use hrtimer_set_expires instead of hrtimer_start_range_ns when retire timer needs update
  as suggested by Willem de Bruijn. Start the hrtimer in prb_setup_retire_blk_timer;
- Just return HRTIMER_RESTART directly as all cases return the same value
  as suggested by Willem de Bruijn;
- Link to v1: https://lore.kernel.org/all/20250813165201.1492779-1-jackzxcui1989@163.com/
- Link to v0: https://lore.kernel.org/all/20250806055210.1530081-1-jackzxcui1989@163.com/

Xin Zhao (2):
  net: af_packet: remove last_kactive_blk_num field
  net: af_packet: Use hrtimer to do the retire operation

 net/packet/af_packet.c | 136 +++++++++++++----------------------------
 net/packet/diag.c      |   2 +-
 net/packet/internal.h  |  14 ++---
 3 files changed, 49 insertions(+), 103 deletions(-)

-- 
2.34.1


