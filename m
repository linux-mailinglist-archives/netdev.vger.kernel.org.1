Return-Path: <netdev+bounces-167283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F43A399D2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D661890A02
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD46239594;
	Tue, 18 Feb 2025 11:00:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296223957E;
	Tue, 18 Feb 2025 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739876446; cv=none; b=FCxUMvhqBpJMm0xHCiUiMnZ2K+pC+B0eNzZVpu0LybAIcA2My6FTZkGYZ12lVZokKd9Kj6c+t2HIePBk+86PlG1aAWb4vz3H+OAzSIyCJYoT8dHi4v095pKfcCwZssyuc7OcSWg9JRhvWB12mBVLN/N+0cS5JLOaGaGWNmsW6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739876446; c=relaxed/simple;
	bh=AaXHOLfSiRko7E/buiBV0ldynweqc/O4MMXoh7oVF3U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sAbcvnA6KphV9v+MmiDat6Anl4rRQTj3oW+yK6l+r+uTQYmo91OwWoiJ9iASs3PZDJGtSgoJHZ2AeXhMhqCwdjl52epQ40X1tLDWShOsRNaKqZtMztHXNYQy1yrd+3qVTHkaOz8Tj02fkbNSjvfuIkQMiAZvQUkB+/HdJVYH/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YxxNX65cRzMrcK;
	Tue, 18 Feb 2025 18:59:08 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F7FB1A0188;
	Tue, 18 Feb 2025 19:00:38 +0800 (CST)
Received: from kwepemn100006.china.huawei.com (7.202.194.109) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Feb 2025 19:00:38 +0800
Received: from huawei.com (10.175.113.133) by kwepemn100006.china.huawei.com
 (7.202.194.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Feb
 2025 19:00:37 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <edumazet@google.com>, <ncardwell@google.com>, <kuniyu@amazon.com>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] tcp: Fix error ts_recent time during three-way handshake
Date: Tue, 18 Feb 2025 18:58:24 +0800
Message-ID: <20250218105824.34511-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100006.china.huawei.com (7.202.194.109)

If two ack packets from a connection enter tcp_check_req at the same time
through different cpu, it may happen that req->ts_recent is updated with
with a more recent time and the skb with an older time creates a new sock,
which will cause the tcp_validate_incoming check to fail.

cpu1                                cpu2
tcp_check_req
                                    tcp_check_req
req->ts_recent = tmp_opt.rcv_tsval = t1
                                    req->ts_recent = tmp_opt.rcv_tsval = t2

newsk->ts_recent = req->ts_recent = t2 // t1 < t2
tcp_child_process
tcp_rcv_state_process
tcp_validate_incoming
tcp_paws_check
if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <= paws_win) // failed

In tcp_check_req, restore ts_recent to this skb's to fix this bug.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 net/ipv4/tcp_minisocks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index b089b08e9617..0208455f9eb8 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -878,6 +878,10 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	sock_rps_save_rxhash(child, skb);
 	tcp_synack_rtt_meas(child, req);
 	*req_stolen = !own_req;
+	if (own_req && tcp_sk(child)->rx_opt.tstamp_ok &&
+	    unlikely(tcp_sk(child)->rx_opt.ts_recent != tmp_opt.rcv_tsval))
+		tcp_sk(child)->rx_opt.ts_recent = tmp_opt.rcv_tsval;
+
 	return inet_csk_complete_hashdance(sk, child, req, own_req);
 
 listen_overflow:
-- 
2.17.1


