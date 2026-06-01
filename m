Return-Path: <netdev+bounces-293543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN5/AL0XHWrXVgkAu9opvQ
	(envelope-from <netdev+bounces-293543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:25:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60231619A24
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 287093011C5D
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0008C33E37C;
	Mon,  1 Jun 2026 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAkxVBdj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6BD1F0991;
	Mon,  1 Jun 2026 05:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291486; cv=none; b=ftgkWzot0LeJzqTngSnQAEoMwWv1puXN0r5oYoD7FClTPclYLv1Y4JvkUJDpSdnPkcxPi+z8uXaZO4Sv8/3wsrGV9X1ZwfQJlS8NPY7Lo8d3FZwXES8Ni6Od9ZBMFgUT5qRwpKsBSn7m3b/nQ2TCSj8YTwrZaybrO/d4dtVXh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291486; c=relaxed/simple;
	bh=DVKo6aBdbItRPfpuQup2wXixMM212Fgtki+5oDYQbh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZKZBH7lf60cZrYY4xOxV6hrrRtW9veMuTIymv3PJ2QGk0Fni98rBbKhS/YQyDh5MOGeu/RxWzl8T3JXrA2pAj4+ymNddgIrgUNgUucWwqko8GkZWv2Lf/ELkvN2mFRimGFtzpEK41s34esLXVj8hOwb/CNkPvrV7Cnt+tFCHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAkxVBdj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94131F00898;
	Mon,  1 Jun 2026 05:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780291485;
	bh=aWxpkgPNYGcFJelKqUo8kme4oy6mBCedTbE5s99QQ4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WAkxVBdjBNKlMCccUs0PfMZw+hAdRJKI3WjsqX5YQvN/CvBO66IQkUprDPQhtR//J
	 OVHZvnNdNQTlhqOWLK8ymojMLWfrdEI02ON++9ihDE2liVhuDSTUJIc62xCvOiptpt
	 rv3oC8V4f2emYNDakso9JyAArGREgjnPJPwGAyg77UIbLJFK/y2/x0dDy3fM5IX0Ea
	 fQa8XE6zW3UfydwqMdHB0oj0JaHBZ0mobtGHrxBcJLCCaZ/8zj5qCggsAhBZSZYy+X
	 BHviAHZ1mSztH5VgfqUeSWUiNgRlUoClKW53fEfRA2x1DdHF+5waWOlf/MynHjeyh9
	 /XICQKma2YnUw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 15:22:08 +1000
Subject: [PATCH net-next 01/11] mptcp: options: suboptions sizes can be
 negative
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-next-mptcp-add-addr6-port-ts-v1-1-4fc25dfef62e@kernel.org>
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
In-Reply-To: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4734; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DVKo6aBdbItRPfpuQup2wXixMM212Fgtki+5oDYQbh8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHReSaiIuKZHj98/8cYwW8TIgZsi1d0tCpi0sD
 gbmu7yypUaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah0XkgAKCRD2t4JPQmmg
 c7xuD/9if2Bwnn+UnU8ztjiv/8kyjLYqzy4n5B9Lwv4JdAvW3mDeWmGQtQWlxqq6E/Q6obKP2H+
 u3peF8872rL2AZXuuiwKhKR67Z5GJ8o3A81QBRdfO6ecyIiQDY9z0Ru77PF5ZJ1vaB5Ld4L70ZR
 p7EpZzf5j535zsiM7qCHBCQjJe/rvORMO3kgqHzX0VJa2dcxsrvht4xQAm8EDp/K+n2nS+ITUGC
 MLnfxnjY6Czll115rw4jid4ETh64wl4464lPXhzwtkmxY9WQ8CC2K5reX2tTQ+FFyfwcyf4Gw2N
 cwatbEV/0bbg5h3+xgOBCySJx5m5+QhRCfK0KIImQd9gpRj+h3nvJJMMyFd9a0iYKkaqxUb6S/a
 gpaXARov4iuCfibQMagqF6gf0uCS/GERtwOLtuguEblvzGNwv/d3+ZUYf3qNtFHXAxPDFcbvjVo
 I9NLynIKeH13YKb4oc6RYdJLhQu5C9Z+SFgQSxiqdvkFvent+gTIZ7iIahjrzcagYky72VTfEo3
 nYLBT34chYSsBmIr4yc2khhvfUfLT0ZsAG8xiCSC6DZvxjZ4o6Eptr9weMAHHR/CrsAqhBGYV86
 AekWZa6ZxB3XdduXeH1iK0Ar8JPVU2e5Fk4FBhMbJiTgyfQqq9mgkcZ2HoeU35TLAbUrH8IMTzU
 IfuMSBbcHzuZpjQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293543-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 60231619A24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use a signed int for the returned size, because when other options are
dropped, the size can be negative, e.g. to send an echo ADD_ADDR with a
v4 address, and no port.

The behaviour is not changed, because it was working as expected with an
overflow. But it is clearer like this, and it will help later on.

Even if, for the moment, only the ADD_ADDR size can be negative in some
cases, a signed int is now used for all mptcp_established_options_*()
helpers, not to mismatch the type, and as a question of uniformity.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983c..1db418a9d4a6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -447,8 +447,7 @@ static void clear_3rdack_retransmission(struct sock *sk)
 }
 
 static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
-					 bool snd_data_fin_enable,
-					 unsigned int *size,
+					 bool snd_data_fin_enable, int *size,
 					 struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -560,8 +559,7 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 }
 
 static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
-					  bool snd_data_fin_enable,
-					  unsigned int *size,
+					  bool snd_data_fin_enable, int *size,
 					  struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -651,8 +649,8 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 	return get_unaligned_be64(&hmac[SHA256_DIGEST_SIZE - sizeof(u64)]);
 }
 
-static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *skb,
-					       unsigned int *size,
+static bool mptcp_established_options_add_addr(struct sock *sk,
+					       struct sk_buff *skb, int *size,
 					       unsigned int remaining,
 					       struct mptcp_out_options *opts)
 {
@@ -715,8 +713,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	return true;
 }
 
-static bool mptcp_established_options_rm_addr(struct sock *sk,
-					      unsigned int *size,
+static bool mptcp_established_options_rm_addr(struct sock *sk, int *size,
 					      unsigned int remaining,
 					      struct mptcp_out_options *opts)
 {
@@ -745,8 +742,7 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
 	return true;
 }
 
-static bool mptcp_established_options_mp_prio(struct sock *sk,
-					      unsigned int *size,
+static bool mptcp_established_options_mp_prio(struct sock *sk, int *size,
 					      unsigned int remaining,
 					      struct mptcp_out_options *opts)
 {
@@ -772,7 +768,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 }
 
 static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
-						   unsigned int *size,
+						   int *size,
 						   unsigned int remaining,
 						   struct mptcp_out_options *opts)
 {
@@ -790,8 +786,7 @@ static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_bu
 	return true;
 }
 
-static bool mptcp_established_options_fastclose(struct sock *sk,
-						unsigned int *size,
+static bool mptcp_established_options_fastclose(struct sock *sk, int *size,
 						unsigned int remaining,
 						struct mptcp_out_options *opts)
 {
@@ -813,8 +808,7 @@ static bool mptcp_established_options_fastclose(struct sock *sk,
 	return true;
 }
 
-static bool mptcp_established_options_mp_fail(struct sock *sk,
-					      unsigned int *size,
+static bool mptcp_established_options_mp_fail(struct sock *sk, int *size,
 					      unsigned int remaining,
 					      struct mptcp_out_options *opts)
 {
@@ -842,9 +836,9 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	unsigned int opt_size = 0;
 	bool snd_data_fin;
 	bool ret = false;
+	int opt_size = 0;
 
 	opts->suboptions = 0;
 
@@ -872,7 +866,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, opts))
 		ret = true;
 	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, opts)) {
-		unsigned int mp_fail_size;
+		int mp_fail_size;
 
 		ret = true;
 		if (mptcp_established_options_mp_fail(sk, &mp_fail_size,

-- 
2.53.0


