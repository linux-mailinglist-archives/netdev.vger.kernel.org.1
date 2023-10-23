Return-Path: <netdev+bounces-43642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28167D412E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB9A1F21479
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDA91B27C;
	Mon, 23 Oct 2023 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHJ9eZlB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E410A3A;
	Mon, 23 Oct 2023 20:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6182C433A9;
	Mon, 23 Oct 2023 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698093934;
	bh=ysUP4nvCD160glmMwIKJetbxE7xcYUI9k6oScnJoQ1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lHJ9eZlBKWIvla4Px1gzPDWPouuF80eOqUP1OA3Sp781IXhnG0FbNdzZBCFaoj05M
	 O0nImTKtBb4dRtrVcq+uNLTjJK2tajE7QtvqeXzFHc1+3g+IkrlZ5IJV6mTAawzeP3
	 Xx+tf4ODIka5Xo9jbD+S8ayIAH9SGetJFn2rsebdVe9MZiDiTgg910hRVneUrra23g
	 4ZulH9MqOQva5hKBV5N4DgBgdTaKWd+fXm7Y274bNgK7ZPvqral1AsB7vlzGf6ffgF
	 FONhbGCXNGN8cfAgkOkhtOudhULW9vMwjKYeVipRnXqGC8m+8SJ7nBal7BIspqYbJa
	 k6tz1Ik5mYMug==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 23 Oct 2023 13:44:36 -0700
Subject: [PATCH net-next 3/9] mptcp: use plain bool instead of custom
 binary enum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-send-net-next-20231023-2-v1-3-9dc60939d371@kernel.org>
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.4

From: Paolo Abeni <pabeni@redhat.com>

The 'data_avail' subflow field is already used as plain boolean,
drop the custom binary enum type and switch to bool.

No functional changed intended.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.h |  7 +------
 net/mptcp/subflow.c  | 12 ++++++------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 02556921bc6c..4c9e7ade160d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -432,11 +432,6 @@ mptcp_subflow_rsk(const struct request_sock *rsk)
 	return (struct mptcp_subflow_request_sock *)rsk;
 }
 
-enum mptcp_data_avail {
-	MPTCP_SUBFLOW_NODATA,
-	MPTCP_SUBFLOW_DATA_AVAIL,
-};
-
 struct mptcp_delegated_action {
 	struct napi_struct napi;
 	struct list_head head;
@@ -492,7 +487,7 @@ struct mptcp_subflow_context {
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		__unused : 9;
-	enum mptcp_data_avail data_avail;
+	bool	data_avail;
 	bool	scheduled;
 	u32	remote_nonce;
 	u64	thmac;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9c1f8d1d63d2..dbc7a52b322f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1237,7 +1237,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	struct sk_buff *skb;
 
 	if (!skb_peek(&ssk->sk_receive_queue))
-		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+		WRITE_ONCE(subflow->data_avail, false);
 	if (subflow->data_avail)
 		return true;
 
@@ -1271,7 +1271,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			continue;
 		}
 
-		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
+		WRITE_ONCE(subflow->data_avail, true);
 		break;
 	}
 	return true;
@@ -1293,7 +1293,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 				goto reset;
 			}
 			mptcp_subflow_fail(msk, ssk);
-			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
+			WRITE_ONCE(subflow->data_avail, true);
 			return true;
 		}
 
@@ -1310,7 +1310,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 			tcp_send_active_reset(ssk, GFP_ATOMIC);
-			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+			WRITE_ONCE(subflow->data_avail, false);
 			return false;
 		}
 
@@ -1322,7 +1322,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
 	subflow->map_data_len = skb->len;
 	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
-	WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
+	WRITE_ONCE(subflow->data_avail, true);
 	return true;
 }
 
@@ -1334,7 +1334,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
 	if (subflow->map_valid &&
 	    mptcp_subflow_get_map_offset(subflow) >= subflow->map_data_len) {
 		subflow->map_valid = 0;
-		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+		WRITE_ONCE(subflow->data_avail, false);
 
 		pr_debug("Done with mapping: seq=%u data_len=%u",
 			 subflow->map_subflow_seq,

-- 
2.41.0


