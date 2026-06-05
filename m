Return-Path: <netdev+bounces-295740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qfXDLn2aImouawEAu9opvQ
	(envelope-from <netdev+bounces-295740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:44:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5165D646FB7
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:44:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=I4lt7lFH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295740-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295740-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FE67318B231
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB553F822C;
	Fri,  5 Jun 2026 09:22:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E13F8223;
	Fri,  5 Jun 2026 09:22:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651327; cv=none; b=FERkNWB81aEDdHJivmsYMPdAKLJeo0H8LkPeSyuAGirOC42VMMY+Ofd+7EPyhcy4o/2j84U4ZwUDhFRvR0unSZVYgRUwBC/fHOh3mx0yUSheMJe5GqXWRCYLrwtS6Bb7NlQYdQFP52tRYSpc2ixISnLdq0PyXNiVW7V5FVBKAW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651327; c=relaxed/simple;
	bh=O95PjL80jVbcASx8r6w/thnf3KEjeOrReKRvDYHFkeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a6qphZJasxq6EmZNkik1h+SPz27NThmMYKBgnyNDfijZqtdD8vb0LF5YeJBped2EX4pNVLFHP+ILF0Pir5nV1g+kmpFMKjrlKSQc3OMXoAb30YUTX+Bq/XR3H96M991kuti3f9nlUrjP0bONHlxo1m5uCj+vMupHZJ0w9P0KhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4lt7lFH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7C01F00899;
	Fri,  5 Jun 2026 09:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651326;
	bh=56T1/Wp9+oeRG24bDoeMn5nJmIkHH8ov/xNi4c4lv/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I4lt7lFH/mo+TLfMKuQDuZ24EN7q4Jmrwy4ooJGdNrZRHAKMpQUQZz2UCqmHOawcF
	 EyyK+ia0mS/WljV7yQHBoAz8F/XCGlgRQOrRzU5pTHUB/2DJlbM3yA6I0j+gPCdOOp
	 qReeltePq5dcEnATZbwuNjiZSukfU+/ZzLSSmCMF9OQFVs1LwHXm+psEzZC/JoBKDf
	 Q4ayTKRs4xFpnnfJlJG31y5h2DeLJxkz6Yh7a5XZ/K64/Uk0Et7gQNemfUOal0ohos
	 0BF+SDDQ6Ur+E9Pp3vbm0GfQYyurkK6IiwWYXR3mj4qQXWlDMw46hCTuHFICB+N6L2
	 IJIESxNE4PlfA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Jun 2026 19:21:46 +1000
Subject: [PATCH net-next v2 02/15] mptcp: pm: avoid computing rm_addr size
 twice
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-2-758e7ca73f4d@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3655; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=O95PjL80jVbcASx8r6w/thnf3KEjeOrReKRvDYHFkeE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUxMu/oekM65UNu2FVAWv/JkkqZBfMxOJGWd
 GLbZAXKGWSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMQAKCRD2t4JPQmmg
 c+cED/0db8RlEYLjabDm1w/t5kfbKOtYv7RZs4lsKuypCfOSiMU7OAXmjnW7qR8MxhDlUlNVMCG
 lYBt7BjySe9g9Bme+vRzEVSIsxWTGvYACYidE6YAwfW1aaQSgwryI2HPJKktmmUxkD3VwVwFQay
 ixMjH7+7z7s+M+jSYyfs+YDOlhq5FTcngocIp0QvYcwQcuy/3bLeOKZBqIUXDIUiFC/eE1sMDQi
 EFsTUTFVQMXUrKkQe2DnZn3mUEkPGGOCR+TRV8iOLCXNzLALPqRYjyw6GHEOQuDJVc1gi1vlMQF
 OtLI7Nu12Rp1/5U4rze14cfOy2c1uHEEs8sDXNk/okEEGZyLvX9WWVVpvaJO+/DRFvI59GVvMDq
 ITLwdLUkqcnT5iy5Tzm5hb8wUGEk7nUTjLVskBo/vdvp72966m2FGPLYusQNCwkMOKD0Xla+k46
 IlQIzLkOMifaHFI7HRYJ+KYHMGe0K+VYExayfWfCPV1S1cqtmys5OOU78C7ZeNhPGGl4P0GElbW
 metvgBLJpxxsZ6qLV8gSP1qOJp+TK3dpskwCb0PS/CyNSkNymtbl/cRyGUTZfQmeH+M9oXTh3OR
 LZflSX5WTGRp+E8FZpBrtIb6W6dTWQ7BqpHYY+VqlpEexaQq1zi4yBg1KDz2hmqjIOAMcxSH1LG
 0MRDqUy2GxULqWg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295740-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5165D646FB7

mptcp_rm_addr_len helper was called twice: in mptcp_pm_rm_addr_signal,
then just after in mptcp_established_options_rm_addr. Both to check the
remaining space.

The second call is not needed: if there is not enough space,
mptcp_pm_rm_addr_signal will return false, and the caller,
mptcp_established_options_rm_addr, will do the same without re-checking
the size again. Instead, mptcp_pm_rm_addr_signal can directly set the
size.

While at it, move mptcp_rm_addr_len to pm.c, as it is now only used
there, once.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 11 ++---------
 net/mptcp/pm.c       | 11 ++++++++++-
 net/mptcp/protocol.h | 10 +---------
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index fd972047fdf7..e44db4768f6c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -711,19 +711,12 @@ static bool mptcp_established_options_rm_addr(struct sock *sk, int *size,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_rm_list rm_list;
-	int i, len;
+	int i;
 
 	if (!mptcp_pm_should_rm_signal(msk) ||
-	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
+	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list, size)))
 		return false;
 
-	len = mptcp_rm_addr_len(&rm_list);
-	if (len < 0)
-		return false;
-	if (remaining < len)
-		return false;
-
-	*size = len;
 	opts->suboptions |= OPTION_MPTCP_RM_ADDR;
 	opts->rm_list = rm_list;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 470501470fe5..4bc380c6f0e1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -953,8 +953,16 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
 	return ret;
 }
 
+static int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
+{
+	if (rm_list->nr == 0 || rm_list->nr > MPTCP_RM_IDS_MAX)
+		return -EINVAL;
+
+	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
+}
+
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			     struct mptcp_rm_list *rm_list)
+			     struct mptcp_rm_list *rm_list, int *size)
 {
 	int ret = false, len;
 	u8 rm_addr;
@@ -974,6 +982,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 	if (remaining < len)
 		goto out_unlock;
 
+	*size = len;
 	*rm_list = msk->pm.rm_list_tx;
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	ret = true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b93b878478d2..75c5faaf4486 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1221,19 +1221,11 @@ static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
 	return len;
 }
 
-static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
-{
-	if (rm_list->nr == 0 || rm_list->nr > MPTCP_RM_IDS_MAX)
-		return -EINVAL;
-
-	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
-}
-
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
 			      unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			     struct mptcp_rm_list *rm_list);
+			     struct mptcp_rm_list *rm_list, int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 			     struct mptcp_pm_addr_entry *skc);

-- 
2.53.0


