Return-Path: <netdev+bounces-43641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD8C7D412C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476752815BE
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FC5F9C6;
	Mon, 23 Oct 2023 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQW4jUKa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1C8481;
	Mon, 23 Oct 2023 20:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B27C43395;
	Mon, 23 Oct 2023 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698093933;
	bh=GZ2U3nahnSpjVZfHanU6T5qe2gYwnIdXa4rzFxk9ipg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sQW4jUKaqI9xAi29mP87H8Rqh6kB3ho89hXKFOSzGn6Gs6LRqFPTXnp0AYjR3WpIC
	 83z7QdKD6ZGhVU4Bl1OU8DLooMn/166nbkzER9mIorska+9tDypyxLkNJBDnodXXbC
	 Nant98w/XD9z4RKSJvp4HNTsCFZNfh0tf1TUMiGKxHWHqtb3Zf3k3cvSsu5BBf9lYG
	 EhUB/J1lISk6A1d9QhgWD1T2DoUn9OqG4ptY3Wd/PjCYPoYi92gfMYN7fR9SZMoKw1
	 /U+Gbm7p7WaPdEWsdMLGHJ1fgi5/iYnFSQ+L+mH0rxh9R876DIJzMicPG12T/TqjjT
	 pQNBcyjHIgm0Q==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 23 Oct 2023 13:44:35 -0700
Subject: [PATCH net-next 2/9] mptcp: properly account fastopen data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-send-net-next-20231023-2-v1-2-9dc60939d371@kernel.org>
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.4

From: Paolo Abeni <pabeni@redhat.com>

Currently the socket level counter aggregating the received data
does not take in account the data received via fastopen.

Address the issue updating the counter as required.

Fixes: 38967f424b5b ("mptcp: track some aggregate data counters")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/fastopen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index bceaab8dd8e4..74698582a285 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -52,6 +52,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	mptcp_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	mptcp_sk(sk)->bytes_received += skb->len;
 
 	sk->sk_data_ready(sk);
 

-- 
2.41.0


