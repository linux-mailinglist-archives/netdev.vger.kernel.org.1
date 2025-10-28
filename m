Return-Path: <netdev+bounces-233500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F29CC147BF
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7306B343A5C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20D53191C6;
	Tue, 28 Oct 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjx/73B/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57436314A7E;
	Tue, 28 Oct 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652696; cv=none; b=FjZNV9mBuyBJTRtJGiUQxaT2fImVfkfAJBJcAsVR8i0lKfjYAm78PnIAb+sykoJzB3gRBZhYFKDrqUc4wuYGX+uRnCoSdFGMtcE+vLWwuf1Py8f83o0ayv2GBo2qmCrO/rcorZ3iiTxIQCcaNfFHCmWxfWACuZIOIgUHwPWvAWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652696; c=relaxed/simple;
	bh=Bo6hSc3JJXASPAkps9ya5E8A9BBCOb0A7yQWK1KqnTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eBQuptEVmXW4r1ng9Bfn1VzzUNMp4yvIQjsHL+9uhywbZwesELNKMQpOT7adr7LwlDVvDXblyPPKyovxzPK6fma/ypKJE1bqzrTqbZc6bI/vHszRRl4S/1GaWqS7oZotWC0vDt+/19nRDguTbI3wvtKnqDA9I4OfADhBTSjBBm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjx/73B/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7901C116B1;
	Tue, 28 Oct 2025 11:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761652696;
	bh=Bo6hSc3JJXASPAkps9ya5E8A9BBCOb0A7yQWK1KqnTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cjx/73B/qjq1GxLHC1GFw8brSHOGozMVoJGs54Cp6NbaVzUVg0AZWOfgQc093p0he
	 AEsFDH9ZM59cv/bVaSnnOxN/AM0bWtKQzXUr1KXZnsj0v+ORX64O4KYLyvXmu57rLE
	 wN2fB4plg6xPfByvQ8ZZf6j1mj4LR0OjTFaAjdEKfOh8eVGo8W2T6tIKVmBde+DQpK
	 aak0bxnKIF57ZcfTgMZedUtvqlSMNttsCdlmSsuEVNb4KIZtIae8e8r0Lcr/ucFvKc
	 NfODrKLkbiygadVHw0UAyr+yYh6zzihMWyHsT6hkJMVI78yEGzpqWR2x06o/irz62u
	 xqRA0NMvyuu8w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 Oct 2025 12:57:59 +0100
Subject: [PATCH net v3 1/4] mptcp: fix subflow rcvbuf adjust
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-net-tcp-recv-autotune-v3-1-74b43ba4c84c@kernel.org>
References: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org>
In-Reply-To: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RfFDmayrd1G2Z2Wi+ylIVloQeITK72fIlA8bFaeMXNo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIZ1p/dpThb+8uHtW6fgkvzdaPFtb5cubnE9eKt1L+Nf
 xI3Cyurd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExEPpnhn/b8b2VLlfhzbz0P
 +bjh7KF1zrt70yO5H6zR6ZoUZhogNo2Roen9qVd7Y+Vu9Gy5cOZD6Y+ry+/KTzz26KpWg+jPR+c
 5gpkB
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The mptcp PM can add subflow to the conn_list before tcp_init_transfer().
Calling tcp_rcvbuf_grow() on such subflow is not correct as later
init will overwrite the update.

Fix the issue calling tcp_rcvbuf_grow() only after init buffer
initialization.

Fixes: e118cdc34dd1 ("mptcp: rcvbuf auto-tuning improvement")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0292162a14ee..a8a3bdf95543 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2051,6 +2051,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
 	msk->rcvq_space.space = msk->rcvq_space.copied;
 	if (mptcp_rcvbuf_grow(sk)) {
+		int copied = msk->rcvq_space.copied;
 
 		/* Make subflows follow along.  If we do not do this, we
 		 * get drops at subflow level if skbs can't be moved to
@@ -2063,8 +2064,11 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
 			ssk = mptcp_subflow_tcp_sock(subflow);
 			slow = lock_sock_fast(ssk);
-			tcp_sk(ssk)->rcvq_space.space = msk->rcvq_space.copied;
-			tcp_rcvbuf_grow(ssk);
+			/* subflows can be added before tcp_init_transfer() */
+			if (tcp_sk(ssk)->rcvq_space.space) {
+				tcp_sk(ssk)->rcvq_space.space = copied;
+				tcp_rcvbuf_grow(ssk);
+			}
 			unlock_sock_fast(ssk, slow);
 		}
 	}

-- 
2.51.0


