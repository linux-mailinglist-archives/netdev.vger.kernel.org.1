Return-Path: <netdev+bounces-216786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48319B35232
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 05:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B8F1A8495E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C922594B7;
	Tue, 26 Aug 2025 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FvpEa0SX"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFDB111BF;
	Tue, 26 Aug 2025 03:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756178364; cv=none; b=FJB96T5616dHu7bdY6gSpQ8l2KCYB8KTwa3K2boNKEMmUu8vViqzQuQmRmrArNCd5NSy5Yr3xSoolBS3X5oNebYGi9DYYqN7tJSMh2pQJBIqYJuxrpfuoTKpfJr7u5lEHifPgmvQoLvhlDOYZZKSmChLyY07CsaGSDyN4YG9hRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756178364; c=relaxed/simple;
	bh=wi8sbdKRlrXo0kWBOE2JRx8vCNBDwrKiFlY3fNVuc3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jIMwPtYRRiDf+/02zjn3s5FBuNpTSkWYLYb5xb7IHkyk1Gl8BXNgmyaeTjyIov4JUPo8pBPLFSDSwtLt2dTgUWVFiBlyPnXYFxtI4lFS6Uz9Mi2SPTLl30uXRSDl2zpMtWS9AQa4qxfDBn1Plt+ay6y3i4HtpJg2SrCFKcjE3F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FvpEa0SX; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8U
	KRPKWH6JXfLDs9LyaWay1d2b/APYWFOa54QlGQgsU=; b=FvpEa0SX45Kdz2xu7W
	6JFmFOSi27E1gUhtUyZ4XnpJiptQ8/SwL1gBvS9hSL8zKTR6yYn/fpxVhr/ahD0A
	12sPrA890JOhaZ3LioUNw5nJZcE/+46A9z23ShPnlsbJJs1CeYI+FwryD8cdoNhK
	B22oBGjXA2im/gsYQiO/UMWK0=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAn7zcAJK1oxxy_Dw--.24255S2;
	Tue, 26 Aug 2025 11:03:30 +0800 (CST)
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
Subject: Re: [PATCH net-next v7] net: af_packet: Use hrtimer to do the retire operation
Date: Tue, 26 Aug 2025 11:03:28 +0800
Message-Id: <20250826030328.878001-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn7zcAJK1oxxy_Dw--.24255S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF1fuF47XryDWFyDGw17Wrg_yoWrGw4kpa
	yaq347Jr1kZrWIvF1xZa1kXFy5J393AF47Gr1fGF1FywnrCFyxtFWjqFWFgFW7C395twsF
	vw48XrnxAwnYk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UqZXrUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibgO1CmitIq0lPwAAsC

On Tue, 2025-08-25 at 0:20 +0800, Willem wrote:

> > We cannot use hrtimer_set_expires/hrtimer_forward_now when a hrtimer is
> > already enqueued.  
> > The WARN_ON(timer->state & HRTIMER_STATE_ENQUEUED) in hrtimer_forward
> > already clearly indicates this point. The reason for not adding this
> > WARN_ON in hrtimer_set_expires is that hrtimer_set_expires is an inline
> > function, wory about increase code size.
> > The implementation of perf_mux_hrtimer_restart actually checks whether
> > the hrtimer is active when restarting the hrtimer.
> 
> Perhaps we need to simplify and stop trying to adjust the timer from
> tpacket_rcv once scheduled. Let the callback handle that.
> 

Okay, I would also like to modify the timeout only within the callback,
so I think PATCH v7 might be a better solution. Additionally, in terms of
performance, it should be more efficient than frequently calling
hrtimer_cancel/hrtimer_start functions to change the timeout outside the
callback.

Why do I add the pkc->expire_ktime in PATCH v7?

For example 8ms retire timeout.
T means the time callback/tpacket_rcv call _prb_refresh_rx_retire_blk_timer.
T1 means time T plus 1ms, T2 means time T plus 2ms...

timeline: past -----------> -----------> -----------> future
callback:      T	           T8
tpacket_rcv:                 T7

Considering the situation in the above diagram, at time T7, the tpacket_rcv
function processes the network and finds that a new block needs to be opened,
which requires setting a timeout of T7 + 8ms which is T15ms. However, we
cannot directly set the timeout within tpacket_rcv, so we use a variable
expire_ktime to record this value. At time T8, in the hrtimer callback, we
check that expire_ktime which is T15 is greater than the current timeout of
the hrtimer, which is T8. Therefore, we simply return from the hrtimer
callback at T8, the next execution time of the hrtimer callback will be T15.
This achieves the same effect as executing hrtimer_start in tpacket_rcv
using a "one shot" approach.


> > Do you agree with adding a callback variable to distinguish between
> > scheduled from tpacket_rcv and scheduled from the callback? I really
> > couldn't think of a better solution.
> 
> Yes, no objections to that if necessary.

So it seems that the logic of 'adding a callback variable to distinguish' in 
PATCH v7 is OK?


> > So, a possible solution may be?
> > 1. Continue to keep the callback parameter to strictly ensure whether it
> > is within the callback.
> > 2. Use hrtimer_set_expires within the callback to update the timeout (the
> > hrtimer module will enqueue the hrtimer when callback return)
> > 3. If it is not in callback, call hrtimer_cancel + hrtimer_start to restart
> > the timer.
>
> Instead, I would use an in_scheduled param, as in my previous reply and
> simply skip trying to schedule if already scheduled.

I understand that the additional in_scheduled variable is meant to prevent
multiple calls to hrtimer_start. However, based on the current logic
implementation, the only scenario that would cancel the hrtimer is after calling
prb_shutdown_retire_blk_timer. Therefore, once we have called hrtimer_start in
prb_setup_retire_blk_timer, we don't need to worry about the hrtimer stopping,
and we don't need to execute hrtimer_start again or check if the hrtimer is in
an active state. We can simply update the timeout in the callback.
Additionally, we don't need to worry about the situation where packet_set_ring
is entered twice, leading to multiple calls to hrtimer_start, because there is
a check for pg_vec before executing init_prb_bdqc in packet_set_ring. If pg_vec
is non-zero, it will go to the out label.

So is PATCH v7 good to go? Besides I think that ktime_after should be used
instead of ktime_compare, I haven't noticed any other areas in PATCH v7 that
need modification. What do you think?


Thanks
Xin Zhao


