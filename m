Return-Path: <netdev+bounces-43645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C84A7D4130
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD9F1C20B5A
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A19224C1;
	Mon, 23 Oct 2023 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuZf/ooW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BA71D699;
	Mon, 23 Oct 2023 20:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E656C433C8;
	Mon, 23 Oct 2023 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698093934;
	bh=8wxbLJ82zryvI+nAd9SdZ5WA2SwnODFY54TmSNRVFHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MuZf/ooWATbZqGzxeqHWTqnZGEh5pVW2FMB4GGNcZCWP9hyrg5Ee4gw5OrMUnAd8d
	 VCB9qZuS33YFxgSaxCRGeG+RnE7zj8ysuDRmSV1v4/NY7cQGFMUHh8vkR4IJzC67Ns
	 pYgdCduvSRZk4zvB/KGkwWQPExOT5TPQzao2tkz3U0d30Qp+0lZLj0RFP+XhBlUffR
	 b/bbUK2nbQYv1TosseAMJwdRfDT3Fm5Ab7UEy+RxHNFht4kPMAE3G39sgQlvte5dkr
	 oTSfW65swyjV4VnrGxx27d4k28uz/YWUEMeIzrdPIIqFFXy598wQ6gOcVaRF9Z64QZ
	 TkIOsOxZPJG0g==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 23 Oct 2023 13:44:39 -0700
Subject: [PATCH net-next 6/9] mptcp: use copy_from_iter helpers on transmit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-send-net-next-20231023-2-v1-6-9dc60939d371@kernel.org>
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.4

From: Paolo Abeni <pabeni@redhat.com>

The perf traces show an high cost for the MPTCP transmit path memcpy.

It turn out that the helper currently in use carries quite a bit
of unneeded overhead, e.g. to map/unmap the memory pages.

Moving to the 'copy_from_iter' variant removes such overhead and
additionally gains the no-cache support.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7036e30c449f..5489f024dd7e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1760,6 +1760,18 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 	return ret;
 }
 
+static int do_copy_data_nocache(struct sock *sk, int copy,
+				struct iov_iter *from, char *to)
+{
+	if (sk->sk_route_caps & NETIF_F_NOCACHE_COPY) {
+		if (!copy_from_iter_full_nocache(to, copy, from))
+			return -EFAULT;
+	} else if (!copy_from_iter_full(to, copy, from)) {
+		return -EFAULT;
+	}
+	return 0;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1833,11 +1845,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (!sk_wmem_schedule(sk, total_ts))
 			goto wait_for_memory;
 
-		if (copy_page_from_iter(dfrag->page, offset, psize,
-					&msg->msg_iter) != psize) {
-			ret = -EFAULT;
+		ret = do_copy_data_nocache(sk, psize, &msg->msg_iter,
+					   page_address(dfrag->page) + offset);
+		if (ret)
 			goto do_error;
-		}
 
 		/* data successfully copied into the write queue */
 		sk_forward_alloc_add(sk, -total_ts);

-- 
2.41.0


