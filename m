Return-Path: <netdev+bounces-216381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BF2B335B7
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 07:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6A61B2033F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 05:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE66123CEF9;
	Mon, 25 Aug 2025 05:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Zvhm+YTR"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EB272627;
	Mon, 25 Aug 2025 05:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756098426; cv=none; b=iBY5XGU99JX0iBuKD/RXlEmCDdJxW7u0NMhZO5XSbQWxq9Hv/7McqVRaRiLcen4+7WIeUGzMuyT/kfFfr1KvaqmwVs6FDBcfsg2X0AeuyimHU2rivkaC3Gha9lUA6ZyKyDMVL+TRKjJDRhifwJlxZgxNPATte0LcuSOO7hNX9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756098426; c=relaxed/simple;
	bh=CKnI+uQNf+KVjexwVCKM5ZrCgqpglIoTmizpooUa76M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kpJT68mUN1BqPKZU89kJeDFAgrbbrPqp0JoIdKKK8znXrk7CB2rVUQ96VvNl1zkArs9e58FCkl5AoZ6KsxdRoBDWDkhI57Y8NMMeNDoR63BM60kawcxovKwxSVRYpZQtPoxA7WPXTIQs+sBvr6Mm1VBjVtzYhXNuA2WNxQEUh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Zvhm+YTR; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zp
	cWxOtKXy5d6EuCfY1TPJPyTbuk1GdgU+bYTYEPKBk=; b=Zvhm+YTRatEfBpgQ7J
	gPTHVmRgTy5lMMs47GwIFj7R8gE7m6jDaDDgJOoANXZgsUN8nP9v/QsWzv2Qe2tH
	U2RtQcY3TNRwvRRGl0XP56sD4hHTu+nLmH9Lt/GrOSomufnHzIERbB+cHIoJvRyv
	5p4X3ts03rg/5lxT+xugfYW3M=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBXHkJU76toR3+ODw--.7007S2;
	Mon, 25 Aug 2025 13:06:28 +0800 (CST)
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
Date: Mon, 25 Aug 2025 13:06:28 +0800
Message-Id: <20250825050628.124977-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXHkJU76toR3+ODw--.7007S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryUuw13Kr43tw48Zr17Awb_yoWrGF1kpa
	y2qry7Ar1kZr42va1xZF4kJFy5JwsxAr47Jr1fGr1jkFnrGF1UtFWjqFySqFW7Gr4rt3Z2
	yr48Xr13ArnYk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHbyZUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiowCzCmirRh303wABso

On Mon, 2025-08-25 at 2:08 +0800, Willem wrote:

> This is getting more complex than needed.
> 
> Essentially the lifecycle is that packet_set_ring calls hrtimer_setup
> and hrtimer_del_sync.
> 
> Inbetween, while the ring is configured, the timer is either
> 
> - scheduled from tpacket_rcv and !is_scheduled
>     -> call hrtimer_start
> - scheduled from tpacket_rcv and is_scheduled
>     -> call hrtimer_set_expires

We cannot use hrtimer_set_expires/hrtimer_forward_now when a hrtimer is
already enqueued.  
The WARN_ON(timer->state & HRTIMER_STATE_ENQUEUED) in hrtimer_forward
already clearly indicates this point. The reason for not adding this
WARN_ON in hrtimer_set_expires is that hrtimer_set_expires is an inline
function, wory about increase code size.
The implementation of perf_mux_hrtimer_restart actually checks whether
the hrtimer is active when restarting the hrtimer.

static int perf_mux_hrtimer_restart(struct perf_cpu_pmu_context *cpc)
{
	struct hrtimer *timer = &cpc->hrtimer;
	unsigned long flags;

	raw_spin_lock_irqsave(&cpc->hrtimer_lock, flags);
	if (!cpc->hrtimer_active) {
		cpc->hrtimer_active = 1;
		hrtimer_forward_now(timer, cpc->hrtimer_interval);
		hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED_HARD);
	}
	raw_spin_unlock_irqrestore(&cpc->hrtimer_lock, flags);

	return 0;
}

Therefore, according to the overall design of the hrtimer, once the
hrtimer is active, it is not allowed to set the timeout outside of the
hrtimer callback nor is it allowed to restart the hrtimer.

So two ways to update the hrtimer timeout:
1. update expire time in the callback
2. Call the hrtimer_cancel and then call hrtimer_start
According to your suggestion, we don't call hrtimer_start inside the
callback, would you accept calling hrtimer_cancel first and then calling
hrtimer_start in the callback? However, this approach also requires
attention, as hrtimer_cancel will block until the callback is running,
so it is essential to ensure that it is not called within the hrtimer
callback; otherwise, it could lead to a deadlock.


> - rescheduled from the timer callback
>     -> call hrtimer_set_expires and return HRTIMER_RESTART
> 
> The only complication is that the is_scheduled check can race with the
> HRTIMER_RESTART restart, as that happens outside the sk_receive_queue
> critical section.
> 
> One option that I suggested before is to convert pkc->delete_blk_timer
> to pkc->blk_timer_scheduled to record whether the timer is scheduled
> without relying on hrtimer_is_queued. Set it on first open_block and
> clear it from the callback when returning HR_NORESTART.

Do you agree with adding a callback variable to distinguish between
scheduled from tpacket_rcv and scheduled from the callback? I really
couldn't think of a better solution.


So, a possible solution may be?
1. Continue to keep the callback parameter to strictly ensure whether it
is within the callback.
2. Use hrtimer_set_expires within the callback to update the timeout (the
hrtimer module will enqueue the hrtimer when callback return)
3. If it is not in callback, call hrtimer_cancel + hrtimer_start to restart
the timer.
4. To avoid the potential issue of the enqueue in step 2 and the
hrtimer_start in step 3 happening simultaneously, which could lead to
hrtimer_start being triggered twice in a very short period, the logic should
be:
if (hrtimer_cancel(...))
    hrtimer_start(...);
Additionally, the hrtimer_cancel check will also avoid hrtimer callback
triggered once more when just called prb_del_retire_blk_timer by packet_set_ring.
The hrtimer should be in an active state beginning from when
prb_setup_retire_blk_timer is called to the time when prb_del_retire_blk_timer
is called.


Thanks
Xin Zhao


