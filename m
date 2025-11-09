Return-Path: <netdev+bounces-237070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31563C445D2
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 20:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2DE188A188
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 19:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9790521858D;
	Sun,  9 Nov 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="VBuJiuO3"
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF594C81
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762715966; cv=none; b=rPtNyohkR85+TohfKNdaPU6WUT25wdfKZn1lD4V7+9oLeyugfNIugOwC9CEN2X57jef+b+6vlChORvzIszcViSMI1QiKNDook6QJoUQSY0/4KXurLhpBoMYgwPF8Jkkh/dE9BbWuNP5qtqWov79BJxoVt8hJtcq8a+xLMgcn2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762715966; c=relaxed/simple;
	bh=/hJLMiUuL2LVCdhxZX8XJQoP1hWjfNQBp2VrOTJaFpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HP8Qz218vQYOwRPYW3wI3uhVrESN9RmGeFH3MhkCd4mwSt6LwcqaUos7egTRAIm4E7/2oJBvUZXAZN4WNQ7t9B4x0a0WfeW4U3Ha9ONX53ZtNeTG/wxxQ25KjSZCDzNG455YtzM6vrjdeiFFvR4/VEhfKxn///f+lk7acGBoJLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=VBuJiuO3; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=2900; s=dkim-tub; t=1762715963;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9t6okxIrip/xPFvPu9sHeKspgBirvv7MIuQRM54c7iE=;
  b=VBuJiuO3qNKTqwy99WlTgcnulaeXZ+Mev5ygvmzMWL1Q09Rl/6P2vYdu
   Q9UAUUG0pp9aBzPPUUpQMKQX8XFMSz1ntYVaf0BEMYOcIyTFazjJGY1mA
   /ZqPTWGPVD/5etJXJYUi5uFO0M2v1bFNvaI+LrSfDLQ0VR8AFJXmUoCLb
   s=;
X-CSE-ConnectionGUID: r3q0XGRiQo6p94eyeyKgZw==
X-CSE-MsgGUID: 7vOH0Ru1TE2OvNEQ6HLiDA==
X-IronPort-AV: E=Sophos;i="6.19,292,1754949600"; 
   d="scan'208";a="52105249"
Received: from bulkmail.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.143])
  by mailrelay.tu-berlin.de with ESMTP; 09 Nov 2025 20:18:10 +0100
Message-ID: <ef601e55-16a0-4d3e-bd0d-536ed9dd29cd@tu-berlin.de>
Date: Sun, 9 Nov 2025 20:18:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima
	<kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251013145416.829707-1-edumazet@google.com>
 <20251013145416.829707-6-edumazet@google.com> <877bw1ooa7.fsf@toke.dk>
 <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
 <CANn89iKY7uMX41aLZA6cFXbjR49Z+WCSd7DgZDkTqXxfeqnXmg@mail.gmail.com>
 <CANn89iLQ3G6ffTN+=98+DDRhOzw8TNDqFd_YmYn168Qxyi4ucA@mail.gmail.com>
 <CANn89iLqUtGkgXj0BgrXJD8ckqrHkMriapKpwHNcMP06V_fAGQ@mail.gmail.com>
 <871pm7np2w.fsf@toke.dk>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
In-Reply-To: <871pm7np2w.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 11/9/25 5:33 PM, Toke Høiland-Jørgensen wrote:
> Not sure why there's this difference between your setup or mine; some
> .config or hardware difference related to the use of atomics? Any other
> ideas?

Hi Eric, hi Toke,

I observed a similar behavior where CAKE's throughput collapses after the patch.

Test setup:
- 4 queues CAKE root qdisc
- 64-byte packets at ~21 Mpps
- Intel Xeon Gold 6209U + 25GbE Intel XXV710 NIC
- DuT forwards incoming traffic back to traffic generator through cake

Throughput over 10 seconds before/after patch:

Before patch:
0.475   mpps
0.481   mpps
0.477   mpps
0.478   mpps
0.478   mpps
0.477   mpps
0.479   mpps
0.481   mpps
0.481   mpps

After patch:
0.265  mpps
0.035  mpps
0.003  mpps
0.002  mpps
0.001  mpps
0.002  mpps
0.002  mpps
0.002  mpps
0.002  mpps

---


 From the qdisc I also see a large number of drops. Running:

     perf record -a -e skb:kfree_skb

shows `QDISC_OVERLIMIT` and `CAKE_FLOOD` as the drop reasons.

`tc` statistics before/after the patch:

Before patch:
- drops: 32
- packets: 4,786,109
- memory_used: 8,916,480
- requeues: 254

After patch:
- drops: 13,601,075
- packets: 322,540
- memory_used: 15,504,576
- requeues: 273

---

Call graph of `__dev_queue_xmit` after the patch (CPU time percentages):

53.37%  __dev_queue_xmit
   21.02%  __qdisc_run
     13.79%  sch_direct_xmit
       12.01%  _raw_spin_lock
         11.30%  do_raw_spin_lock
           11.06%  __pv_queued_spin_lock_slowpath
     0.73%  _raw_spin_unlock
       0.58%  lock_release
     0.69%  dev_hard_start_xmit
     6.91%  cake_dequeue
       1.82%  sk_skb_reason_drop
         1.10%  skb_release_data
         0.65%  kfree_skbmem
           0.61%  kmem_cache_free
       1.64%  get_random_u32
       0.97%  ktime_get
         0.86%  seqcount_lockdep_reader_access.constprop.0
       0.91%  cake_dequeue_one
   16.49%  _raw_spin_lock
     15.71%  do_raw_spin_lock
       15.54%  __pv_queued_spin_lock_slowpath
   10.00%  dev_qdisc_enqueue
     9.94%  cake_enqueue
       4.90%  cake_hash
       2.85%  __skb_flow_dissect
         1.08%  lock_acquire
         0.65%  lock_release
       1.17%  __siphash_unaligned
       2.20%  ktime_get
         1.94%  seqcount_lockdep_reader_access.constprop.0
       0.69%  cake_get_flow_quantum / get_random_u16
   1.99%  netdev_core_pick_tx
     1.79%  i40e_lan_select_queue
     1.62%  netdev_pick_tx
       0.78%  lock_acquire
       0.52%  lock_release
     0.82%  lock_acquire
   0.76%  kfree_skb_list_reason
     0.52%  skb_release_data
   1.02%  lock_acquire
     0.63%  lock_release

---

The `_raw_spin_lock` portion under `__qdisc_run -> sch_direct_xmit` is slightly higher after the patch compared to before (from 5.68% to 12.01%).
It feels like once sch_cake starts dropping packets it (due to overlimit and cobalt-drops) the throughput collapses. Could it be that the overlimit
is reached "faster" when there are more CPUs trying to enqueue packets, thus reaching cake's queue limit due to the "batch" enqueue behavior,
which then leads to cake starting to drop packets?


Jonas


