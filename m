Return-Path: <netdev+bounces-215999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55665B31517
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C97AA1582
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5208029E10F;
	Fri, 22 Aug 2025 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="D6zIOcWK"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3008C23A564;
	Fri, 22 Aug 2025 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857826; cv=none; b=m6XtFsS89mQc1cBSVCge3P9eLVgqTRKjmz+SV0t1hMabwyiBlZ3iUi0PIexd4O46k//PxoWKBLTCXBpJFE8SWkUjEAfznTZuY8mY1ITh96iswfUy/+o0I+nfjYGv9ZoxFFQbCCFzXzDptdvf4mi5hWZy5oezUECT8dpXdkH3RYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857826; c=relaxed/simple;
	bh=gMQLm4izBWJNKM2/xCxHuxNpuXZRAeAHDeP5MeF4wxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MZ5kwwtm0IdyK2S5zHsl8GA3inEScn4UszcIDs+Hbb4lz1m+KFEzgCMEARCMvbce08khoWc5hHY6pTixAU8dSeFm6eFawgABlJaFrMN3wfYbYiBEcIImPMNgnASUq7x9YDqaZ2Jqe1ThdBinSDCCepWq5vAKs4eNlO3K12ZFbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=D6zIOcWK; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=PK
	dTEHXlTCrSFOHLYyhag5amkwibf7FyuEGx4ErU5VM=; b=D6zIOcWKomfQVMytl7
	Lz8scq26Sh4DrQbhR6XmARtIiRvGwahWzrL2zV+pUG2taX16BDRKalMcilABkzvb
	gcmlywUEZG9kOw9MO4GTJSiaIT57xPAShcBpR3FeaQmmkfblQuk119TwVFvaSlt8
	1ycdM80DwrkdnYmYIWzYr3GIY=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDn5cKCQ6hokuXqDg--.63707S2;
	Fri, 22 Aug 2025 18:16:35 +0800 (CST)
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
Date: Fri, 22 Aug 2025 18:16:34 +0800
Message-Id: <20250822101634.129855-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn5cKCQ6hokuXqDg--.63707S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw1ftFWrWrykuFW8WrWDXFb_yoW5Cw1Dpa
	yjg347Cw1kAr429r47Zw4kXFWrXw4fJr43Jrs3GF1jyr9xWFyUXFW2vFyFqFWIgrs3trsF
	vF18X39xAr4Du37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UG_M-UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibh2xCmioQp0WNAAAs1

On Fri, 2025-08-22 at 14:37 +0800, Willem wrote:

> The hrtimer callback is called by __run_hrtimer, if we only use hrtimer_forward_now in the callback,
> it will not restart the time within the callback. The timer will be enqueued after the callback
> return. So when the timer is being enqueued, it is not protected by sk_receive_queue.lock.

I see.

> > Consider the following timing sequence:
> > timer   cpu0 (softirq context, hrtimer timeout)                cpu
> > 0       hrtimer_run_softirq
> > 1         __hrtimer_run_queues
> > 2           __run_hrtimer
> > 3             prb_retire_rx_blk_timer_expired
> > 4               spin_lock(&po->sk.sk_receive_queue.lock);
> > 5               _prb_refresh_rx_retire_blk_timer
> > 6                 hrtimer_forward_now
> > 7               spin_unlock(&po->sk.sk_receive_queue.lock)
> > 8             raw_spin_lock_irq(&cpu_base->lock);              tpacket_rcv
> > 9             enqueue_hrtimer                                    spin_lock(&sk->sk_receive_queue.lock);
> > 10                                                               packet_current_rx_frame
> > 11                                                                 __packet_lookup_frame_in_block
> > 12            finish enqueue_hrtimer                                 prb_open_block
> > 13                                                                     _prb_refresh_rx_retire_blk_timer
> > 14                                                                       hrtimer_is_queued(&pkc->retire_blk_timer) == true
> > 15                                                                       hrtimer_forward_now
> > 16                                                                         WARN_ON
> > 
> > On cpu0 in the timing sequence above, enqueue_hrtimer is not protected by sk_receive_queue.lock,
> > while the hrtimer_forward_now is not protected by raw_spin_lock_irq(&cpu_base->lock).
> > 
> > It will cause WARN_ON if we only use 'hrtimer_is_queued(&pkc->retire_blk_timer) == true' to check
> > whether to call hrtimer_forward_now.
> 
> One way around this may be to keep the is_timer_queued state inside
> tpacket_kbdq_core protected by a relevant lock, like the receive queue
> lock. Similar to pkc->delete_blk_timer.
> 
> Admittedly I have not given this much thought yet. Am traveling for a
> few days, have limited time.

Thank you for replying to me during your break. I later thought of a way to ensure that the enqueue of
the hrtimer can be set in an ordered manner without adding new locks or using local_irq_save. I will
reflect this in version 7.

Additionally, we still need the 'bool callback' parameter to determine whether we are inside the
hrtimer's callback, while 'bool start' parameter is unnecessary.


Why should we keep the callback parameter?

As mentioned earlier, the enqueue action occurs after exiting the hrtimer callback, and this enqueue
action is not performed in the af_packet code. This could lead to the timer's state being changed back
to enqueued at an uncertain time, which does not provide a timing guarantee for our logic in
_prb_refresh_rx_retire_blk_timer, where we check the status using hrtimer_is_queued.

As previously discussed, I said that we must accurately determine whether we are in the hrtimer callback
in _prb_refresh_rx_retire_blk_timer. Relying on either hrtimer_is_queued or hrtimer_callback_running
would not provide sufficient accuracy. However, adding a callback variable as a parameter would be a
reliable approach, requiring minimal code changes and making it easier for future readers to understand.
Therefore, I will also add this 'bool callback' parameter in version 7.


Thanks
Xin Zhao


