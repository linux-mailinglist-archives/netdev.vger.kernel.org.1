Return-Path: <netdev+bounces-168754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D88A40787
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 11:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF9A3BBC11
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B95206F19;
	Sat, 22 Feb 2025 10:41:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3BF2063E3;
	Sat, 22 Feb 2025 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740220914; cv=none; b=OGNPbzSqggmKA8ex/FpjztLIA9zuZTA0eLxB0meTarHoDN60CFYUPG5eGiCXZPUcBw0G30kiS6nFSU/znJN/lMXF77wecsd7LHUVml/MV4dLTsZc6s86OdMA3xdewJwhYEcJka7W2URUNpaGDu8DuOWcOac7L9O3LEn+I+gMv6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740220914; c=relaxed/simple;
	bh=5DYs1irPqt7cPrMB77J9YZFN/QuunE3iyUnI3OiY398=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1G6uL1idOS53b48XNEs39ry9oo6/F3T4l333mJgnTEWtj+OO5vTd7AguyisV0HXQEyOD/L4Lca5nWSWNq7DHGpoTVCACUPfkgR7ok64NPx8mJGYZkpR3zEvZUxJSp7VS5R54K3xz1kyDNZqHtN+7cyzFbnKLmG5jZIMk3mMzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z0NkQ5G0RzvWpW;
	Sat, 22 Feb 2025 18:38:06 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 63BF11800E5;
	Sat, 22 Feb 2025 18:41:49 +0800 (CST)
Received: from kwepemn100006.china.huawei.com (7.202.194.109) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 22 Feb 2025 18:41:49 +0800
Received: from huawei.com (10.175.113.133) by kwepemn100006.china.huawei.com
 (7.202.194.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 22 Feb
 2025 18:41:47 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <kerneljasonxing@gmail.com>, <edumazet@google.com>,
	<ncardwell@google.com>, <kuniyu@amazon.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <zhangchangzhong@huawei.com>, <liujian56@huawei.com>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] tcp: Defer ts_recent changes until req is owned
Date: Sat, 22 Feb 2025 18:39:28 +0800
Message-ID: <20250222103928.12104-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemn100006.china.huawei.com (7.202.194.109)

The same 5-tuple packet may be processed by different CPUSs, so two
CPUs may receive different ack packets at the same time when the
state is TCP_NEW_SYN_RECV.

In that case, req->ts_recent in tcp_check_req may be changed concurrently,
which will probably cause the newsk's ts_recent to be incorrectly large.
So that tcp_validate_incoming will fail.

cpu1                                    cpu2
tcp_check_req
                                        tcp_check_req
 req->ts_recent = rcv_tsval = t1
                                         req->ts_recent = rcv_tsval = t2

 syn_recv_sock
  newsk->ts_recent = req->ts_recent = t2 // t1 < t2
tcp_child_process
 tcp_rcv_state_process
  tcp_validate_incoming
   tcp_paws_check
    if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <= paws_win)
	// t2 - t1 > paws_win, failed

In tcp_check_req, Defer ts_recent changes to this skb's to fix this bug.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
v1->v2: Modified the fix logic based on Eric's suggestion. Also modified the msg
 net/ipv4/tcp_minisocks.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index b089b08e9617..53700206f498 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -815,12 +815,6 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 	/* In sequence, PAWS is OK. */
 
-	/* TODO: We probably should defer ts_recent change once
-	 * we take ownership of @req.
-	 */
-	if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
-		WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
-
 	if (TCP_SKB_CB(skb)->seq == tcp_rsk(req)->rcv_isn) {
 		/* Truncate SYN, it is out of window starting
 		   at tcp_rsk(req)->rcv_isn + 1. */
@@ -869,6 +863,9 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	if (!child)
 		goto listen_overflow;
 
+	if (own_req && tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
+		tcp_sk(child)->rx_opt.ts_recent = tmp_opt.rcv_tsval;
+
 	if (own_req && rsk_drop_req(req)) {
 		reqsk_queue_removed(&inet_csk(req->rsk_listener)->icsk_accept_queue, req);
 		inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
-- 
2.17.1


