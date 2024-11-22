Return-Path: <netdev+bounces-146832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407D9D6223
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 17:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F112EB23E94
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3AD1E0E0B;
	Fri, 22 Nov 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcNQ0yCC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650581E0E01
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292475; cv=none; b=BoaNRhMKGF2oBvHjcIOgYfFQEv8Cm3gXqKJd35GqZr+Fe6IokeLNFGaViqYCp6o5UCtG1cB5pdDJJwO+muLklZh6HZTGY1iVna0XsEO/bcPdFofSwX8EsXM+ax7/bpZZZijqDZewemJ9kdNEfPjvxg2ocu2dNLqt2O0TDuSUanU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292475; c=relaxed/simple;
	bh=BNv/eXQcx2/yj/70xcMCY+mKAe3JO0bfp83+4DdiEio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ce0MQkseT3f7Azy3LniSaK7QrGn9jaGx0SEJdHq77K283rxBEo8LIKIpAgIXC+DBhE0xNwnmXk/1aeXaP7YWkBJ+q1KDepngJrs1KAa5GtH0/AXdLo53E3teFtnL9FBOtJYhMrs/a3BnXx8Iq6TN+KjcTJu82zMh2vIQgxFJasw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcNQ0yCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A726AC4CECE;
	Fri, 22 Nov 2024 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732292475;
	bh=BNv/eXQcx2/yj/70xcMCY+mKAe3JO0bfp83+4DdiEio=;
	h=From:To:Cc:Subject:Date:From;
	b=bcNQ0yCCt9OxXK2qp3JfCTsdiR27DzveBQ2SZErQw5JlgVesl3zf2zPZRJdT5U7+q
	 pg7PB1vFHJtCX1XLUm80K0/FXhxeiK7MWRmrgD6S31DEITqqIvfeCi/L05Ke7hApHH
	 WeSJwyS/dSyFx40Jo6ga10TTmbbChu8nfSZO+EpuDdIST//sy7lHhDC7Ctpy598l4p
	 e+0OvHuroHxMVwqYopmKuF7FJBvwMHqyqrN/+RLXgr3aUqZ3ofuCWOTHwhDmmtdt7K
	 US1lHqkLX8tccB3tqIG+lcvOY2Fdltszb1lTfB+ChCVJ94AUG15fndR36hnTox4BnZ
	 3izjdxePNGjLg==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net] net_sched: sch_fq: don't follow the fast path if Tx is behind now
Date: Fri, 22 Nov 2024 08:21:08 -0800
Message-ID: <20241122162108.2697803-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent kernels cause a lot of TCP retransmissions

[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  2.24 GBytes  19.2 Gbits/sec  2767    442 KBytes
[  5]   1.00-2.00   sec  2.23 GBytes  19.1 Gbits/sec  2312    350 KBytes
                                                      ^^^^

Replacing the qdisc with pfifo makes them go away. It appears that
a flow may get throttled with a very near unthrottle time.
Later we may get busy processing Rx and the unthrottling time will
pass, but we won't service Tx since the core is busy with Rx.
If Rx sees an ACK and we try to push more data for the throttled flow
we may fastpath the skb, not realizing that there are already "ready
to send" packets for this flow sitting in the qdisc.
At least this is my theory on what happens.

Don't trust the fastpath if we are "behind" according to the projected
unthrottle time for some flow waiting in the Qdisc.

Qdisc config:

qdisc fq 8001: dev eth0 parent 1234:1 limit 10000p flow_limit 100p \
  buckets 32768 orphan_mask 1023 bands 3 \
  priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1 \
  weights 589824 196608 65536 quantum 3028b initial_quantum 15140b \
  low_rate_threshold 550Kbit \
  refill_delay 40ms timer_slack 10us horizon 10s horizon_drop

For iperf this change seems to do fine, the reordering is gone.
The fastpath still gets used most of the time:

  gc 0 highprio 0 fastpath 142614 throttled 418309 latency 19.1us
 xx_behind 2731

where "xx_behind" counts how many times we hit the new return false.

Fixes: 076433bd78d7 ("net_sched: sch_fq: add fast path for mostly idle qdisc")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
---
 net/sched/sch_fq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 19a49af5a9e5..3d932b262159 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -331,6 +331,12 @@ static bool fq_fastpath_check(const struct Qdisc *sch, struct sk_buff *skb,
 		 */
 		if (q->internal.qlen >= 8)
 			return false;
+
+		/* Ordering invariants fall apart if some throttled flows
+		 * are ready but we haven't serviced them, yet.
+		 */
+		if (q->throttled_flows && q->time_next_delayed_flow <= now)
+			return false;
 	}
 
 	sk = skb->sk;
-- 
2.47.0


