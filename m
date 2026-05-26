Return-Path: <netdev+bounces-291548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHYeDHZAFWrJTwcAu9opvQ
	(envelope-from <netdev+bounces-291548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:40:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2805D13C8
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D22E73019129
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 06:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AE43B47F7;
	Tue, 26 May 2026 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="byeEHSRI"
X-Original-To: netdev@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCCF3C197F
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779777651; cv=none; b=fDwdnVO/xsQ1P1mS5l5Lmi/RGHgpdTr9JQfyy0II8neOw5DURD599IVz9S0PWAaV1qXPbuV1NdPLNeXBHW5eHBh+Ncnb/PVaWs05POGP3ZwUJKT5pv/nNruDeb8E39YOrFHZUBe2lzRzEB9p7eiqvvBd1oCu18DBDtp+GQQz/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779777651; c=relaxed/simple;
	bh=6++EXalkr1z+1YxLK5Lqh9d9XYSOkDSGBELY93mK0ug=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fjGg1WfC8iVduVpaK2nowj9jI7V5ROb5nR9FlLfONuYTQ+tyr20dxfP3WD0Cgc5cYIR5iT75VUeNqM5QYut75xrxQb8Y6zYX1zHwt5BaKmSoxyOeVxcUf9lhif+LcD8eK3jWPIUDcmEJ2IWtlp6pwuLtN8pcQcJbd4SNbeiQT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=byeEHSRI; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 64Q6b5MH064945;
	Tue, 26 May 2026 14:37:05 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4gPjcW1jZzz2LmTMS;
	Tue, 26 May 2026 14:33:15 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 26 May 2026 14:37:02 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <edumazet@google.com>, <kuniyu@google.com>, <pabeni@redhat.com>,
        <willemb@google.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <horms@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <vincent.guittot@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ke.wang@unisoc.com>, <guohua.yan@unisoc.com>, <Wade.Shu@unisoc.com>,
        <xuewen.yan94@gmail.com>, <di.shen@unisoc.com>
Subject: [RFC PATCH] net/core: use wake_up_interruptible_poll() in sock_def_readable()
Date: Tue, 26 May 2026 14:36:50 +0800
Message-ID: <20260526063650.952-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 64Q6b5MH064945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1779777434;
	bh=djV8qmH+Giaw08bWUC0A/JKUSvRmpthyO/rKydTHshU=;
	h=From:To:CC:Subject:Date;
	b=byeEHSRISqyprBlQThzD8C5+xuk4M2PZ80/SNyPl6v+gbETvoaW4Zotkap/6xib9G
	 QKJIWfR5xwCfsCy1ZcHGpVRr2Pya5dAS6+kN49kgjUJ/ZLRJRGI9ddU6LuJ9zH1p1C
	 +pD8+ELuPMTI6YDbPJ702zcuww99uLNsVLCEegwdiZ8fcbK5S5EmdyjR1haYOg+Nnu
	 jzG5MrsQQP8btShUAtDoL6m6rkOLNFuxrDMoczRXdwUocsC5Vd8wjbWpaowR0w44O4
	 RuByg8RZz6ynyvSVtKtP8bRS3pDpCdKt1N0uuWv2WpCVSVgAHksCxayNTLQffbv4lh
	 /+YdaketGgtBw==
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[unisoc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[unisoc.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,linaro.org,vger.kernel.org,unisoc.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291548-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuewen.yan@unisoc.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[unisoc.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unisoc.com:email,unisoc.com:mid,unisoc.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9C2805D13C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sock_def_readable() currently uses wake_up_interruptible_sync_poll() to
wake up tasks waiting for readable data on a socket. The _sync variant
sets the WF_SYNC flag, which tells the scheduler that the waker will
schedule away soon, so the wakee should stay on the same CPU to avoid
needless cache bouncing.

However, we found that the following stack:
 -vfs_write
 -sock_write_iter
 -unix_stream_sendmsg
 -sock_def_readable
 -__wake_up_sync_key

In this process-context scenario, the waker does NOT go to sleep
after the wakeup. With WF_SYNC, the scheduler is misled into placing
the wakee on the waker's CPU (via wake_affine_idle()'s sync path when
nr_running == 1), causing both the sender and receiver to contend for
the same CPU. This may hurt throughput for IPC workloads on multi-core
systems where the sender and receiver could otherwise run in parallel
on different CPUs.

Switch to wake_up_interruptible_poll() which does not set WF_SYNC.
This allows the scheduler to freely migrate the wakee to an idle CPU,
enabling true parallelism between the sending and receiving processes.

Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
Note:
The possible cost is that for softirq callers (TCP/UDP receive path), the wakee
may be migrated away from the current CPU where the received data is
cache-hot. However, this is mitigated by:
  - The scheduler's existing wake_affine logic which already considers
    cache affinity regardless of WF_SYNC.

We are not very familiar with the networking code here,
so we would greatly appreciate any suggestions or advice from the community.

Thanks！
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index b37b664b6eb9..42ab9373194f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3611,7 +3611,7 @@ void sock_def_readable(struct sock *sk)
 	rcu_read_lock();
 	wq = rcu_dereference(sk->sk_wq);
 	if (skwq_has_sleeper(wq))
-		wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN | EPOLLPRI |
+		wake_up_interruptible_poll(&wq->wait, EPOLLIN | EPOLLPRI |
 						EPOLLRDNORM | EPOLLRDBAND);
 	sk_wake_async_rcu(sk, SOCK_WAKE_WAITD, POLL_IN);
 	rcu_read_unlock();
-- 
2.25.1


