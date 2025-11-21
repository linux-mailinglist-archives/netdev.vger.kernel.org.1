Return-Path: <netdev+bounces-240831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03376C7AFAD
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F8F3A2D00
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D5934F27E;
	Fri, 21 Nov 2025 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjE5iKip"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4635292C;
	Fri, 21 Nov 2025 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744569; cv=none; b=PVUNCMGn+7pcNmK5l6ZV8zo3g1E9v4r561xIUf052kCmtMRKiEj8zqRuDWz9KfAsxJaX/4pSAfIo+M8B1kj0PyLSvSi+Nd9dswLh9xUulKAHIy87L6K9WZi5THelKruutQ57ShM49W1MM1j1zgquw7Qq476X61lwQXstN0/hwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744569; c=relaxed/simple;
	bh=c1FiB03N4TjtbuLBNxU7XN7WYPiLFo1I2pUiGPKArCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PFNFxpSsokelUKGkxpp3Jq7BgO4+g+jpz3O59aNJhTDQwQla0qm/RVeZoJs1ruQeJkOhTxwbk7WF+6b53FLuP2Nt8qfkc3BEDfv0dlBaLeMbCOMe2ue4BGOYn07GvrG0ORRG75Uq4M743fp9KuH52XeQw44jKdV2/+l9KMKS4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjE5iKip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D19C19423;
	Fri, 21 Nov 2025 17:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744568;
	bh=c1FiB03N4TjtbuLBNxU7XN7WYPiLFo1I2pUiGPKArCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pjE5iKip0xlBCQI3455FWo+6Y6iVwxeVwVT6Ca6K5BejKYbzWUyM8iEH49iaROXzo
	 2sCYXuiVtSvXyLegLfMsIE0yxRwkHmNdHKwdUqG0cJMWXsHR8eI4a9i/K60s0jqix1
	 ym/LOgZNNZoFxdfotVyphkPqFj1Taoo/x8bn9XB2LlPqAo7cTJq4q99hBWRQREODs2
	 y4G3AcFPxOo114IL37YVfNQeSnCdCBWJZc/9CmvS7+M7pxOobodLHGibJ3diSQzUlo
	 NaprwnlyO0zKJHjIC+mEb2SSYU5afHw7Go7Q7QEGBtOhQgE9iveyk1R/0vSYrdNt0z
	 pgY2wkA2WmYxg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:05 +0100
Subject: [PATCH net-next 06/14] mptcp: cleanup fallback dummy mapping
 generation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-6-1f34b6c1e0b1@kernel.org>
References: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
In-Reply-To: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+D4DMCB5Vu2ppaXiUX6i79cxbGMbyyjuyyjizxfl+Qg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZouzrFzNGueWuFOe/dVJMcHiV43rvNJvKX/RFI3tE
 1jWvm1nRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQSpRgZftwqEenO52Dl315x
 89vO3Ry77j3lnKQjPU9ml6Gxq31EDyNDz7repCT2KxeOH/zj27tdyHadc/DqncvNg1MtG+2eeZj
 wAAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

MPTCP currently access ack_seq outside the msk socket log scope to
generate the dummy mapping for fallback socket. Soon we are going
to introduce backlog usage and even for fallback socket the ack_seq
value will be significantly off outside of the msk socket lock scope.

Avoid relying on ack_seq for dummy mapping generation, using instead
the subflow sequence number. Note that in case of disconnect() and
(re)connect() we must ensure that any previous state is re-set.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 +++
 net/mptcp/subflow.c  | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 67732d3c502c..df4be41ed3fe 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3274,6 +3274,9 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
 
+	/* for fallback's sake */
+	WRITE_ONCE(msk->ack_seq, 0);
+
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
 	return 0;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1f7311afd48d..86ce58ae533d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -491,6 +491,9 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
 	subflow->iasn++;
 
+	/* for fallback's sake */
+	subflow->map_seq = subflow->iasn;
+
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
@@ -1435,9 +1438,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
-	subflow->map_seq = READ_ONCE(msk->ack_seq);
 	subflow->map_data_len = skb->len;
 	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
+					      subflow->iasn +
+					      TCP_SKB_CB(skb)->seq -
+					      subflow->ssn_offset - 1);
 	WRITE_ONCE(subflow->data_avail, true);
 	return true;
 }

-- 
2.51.0


