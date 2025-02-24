Return-Path: <netdev+bounces-168917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D0BA4180C
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086E818918C1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230B219F11F;
	Mon, 24 Feb 2025 09:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC30EEB5;
	Mon, 24 Feb 2025 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387797; cv=none; b=en7iHcYvk/r2nkLDzJ14vS5xMYu7ntlkmejwRkn2imOVAcJHbbsxiPxXCQE9N2IHuMW4e52+jc44GARvK7HIhMJz1SF/AcnusmSHT+BqSHE2fLPIsKXgNv1eyqXT74wb3FCL5CRVj6cDsy9F+Zx5pBZQ7/wborRNVQbiHk+ZTI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387797; c=relaxed/simple;
	bh=vJ2USaPUJjTmBBCLDYOLZUd493kJxSxBFveztP1SVow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rSD+8juJsPYDAbD+KgPjLGoU/vXFeeDD2o0A69RcNgB+kAwq55xZXm+miEHAkEzXwvn3OK3LebPwyCRy3Z6U8xtT/Wzx08PXI93PsqNk63cOzMCa7qzRQ6UuXsCPAALoXborDo0mLlaLExV9o5CBheUbi9YoCtBJjgw4WojSOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z1ZS13530zCs7m;
	Mon, 24 Feb 2025 16:59:45 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 31BA1140134;
	Mon, 24 Feb 2025 17:03:11 +0800 (CST)
Received: from kwepemn100006.china.huawei.com (7.202.194.109) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Feb 2025 17:03:10 +0800
Received: from huawei.com (10.175.113.133) by kwepemn100006.china.huawei.com
 (7.202.194.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 24 Feb
 2025 17:03:09 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <kerneljasonxing@gmail.com>, <edumazet@google.com>,
	<ncardwell@google.com>, <kuniyu@amazon.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <zhangchangzhong@huawei.com>, <liujian56@huawei.com>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 net] tcp: Defer ts_recent changes until req is owned
Date: Mon, 24 Feb 2025 17:00:47 +0800
Message-ID: <20250224090047.50748-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemn100006.china.huawei.com (7.202.194.109)

Recently a bug was discovered where the server had entered TCP_ESTABLISHED
state, but the upper layers were not notified.

The same 5-tuple packet may be processed by different CPUSs, so two
CPUs may receive different ack packets at the same time when the
state is TCP_NEW_SYN_RECV.

In that case, req->ts_recent in tcp_check_req may be changed concurrently,
which will probably cause the newsk's ts_recent to be incorrectly large.
So that tcp_validate_incoming will fail. At this point, newsk will not be
able to enter the TCP_ESTABLISHED.

cpu1                                    cpu2
tcp_check_req
                                        tcp_check_req
 req->ts_recent = rcv_tsval = t1
                                         req->ts_recent = rcv_tsval = t2

 syn_recv_sock
  tcp_sk(child)->rx_opt.ts_recent = req->ts_recent = t2 // t1 < t2
tcp_child_process
 tcp_rcv_state_process
  tcp_validate_incoming
   tcp_paws_check
    if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <= paws_win)
        // t2 - t1 > paws_win, failed
                                        tcp_v4_do_rcv
                                         tcp_rcv_state_process
                                         // TCP_ESTABLISHED

The cpu2's skb or a newly received skb will call tcp_v4_do_rcv to get
the newsk into the TCP_ESTABLISHED state, but at this point it is no
longer possible to notify the upper layer application. A notification
mechanism could be added here, but the fix is more complex, so the
current fix is used.

In tcp_check_req, req->ts_recent is used to assign a value to
tcp_sk(child)->rx_opt.ts_recent, so removing the change in req->ts_recent
and changing tcp_sk(child)->rx_opt.ts_recent directly after owning the
req fixes this bug.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
---
v2->v3: changed code format and commit msg.
 net/ipv4/tcp_minisocks.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index b089b08e9617..dfdb7a4608a8 100644
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
@@ -869,6 +863,10 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	if (!child)
 		goto listen_overflow;
 
+	if (own_req && tmp_opt.saw_tstamp &&
+	    !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
+		tcp_sk(child)->rx_opt.ts_recent = tmp_opt.rcv_tsval;
+
 	if (own_req && rsk_drop_req(req)) {
 		reqsk_queue_removed(&inet_csk(req->rsk_listener)->icsk_accept_queue, req);
 		inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
-- 
2.17.1


