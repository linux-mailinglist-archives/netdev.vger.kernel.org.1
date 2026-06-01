Return-Path: <netdev+bounces-293547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPcvCykYHWrFVgkAu9opvQ
	(envelope-from <netdev+bounces-293547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:27:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB157619A94
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0045E302D091
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC8C345722;
	Mon,  1 Jun 2026 05:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEuWvvkl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771D3403F8;
	Mon,  1 Jun 2026 05:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291504; cv=none; b=ihxCxUFp3fxkWDaO6iKqFhQc+OJGgDRmZa05gXlCIpDY5Jhk0rkPxxFvnYgF58scdbWP3+9dDhQjhgsD0oHKb2s9+CKam5eGdELotrPaeImbjZWG1pWDgu7B2nVjY4jAGDIODBUpHFHT55f3Lhd7od9FjQ0sMuRZLEPZkv1CEWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291504; c=relaxed/simple;
	bh=Pc7U/DrS+H1oMm8+T6ry05zL7FCElt/gz3FzFjS20/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHpWprfYvizg3ohYEf3iYOZM4FXx7G4Oh2wrkqDpD+Sn/o6ZMmhkWxfVcPp4O5U8d1DAnDs8kO0fy1gD31lV5O+44g+5p3G19uYuSMwdNbAcZEFn1PzqbZ0zpNBjr1a3HEohyNk8S/oeaJizocnWBTaG5rEZ7fsImhD5gklQrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEuWvvkl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1B21F00893;
	Mon,  1 Jun 2026 05:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780291503;
	bh=y0YPOu6IWFrAJspKZNnlb3YPVGoMrKNdEnLxs1rphOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EEuWvvklwxlnle2TkF3jzs3dECC9Gui2TdnggIIDA1jiwgNEW87uGLLdUrjeiRBxU
	 0vFhTMd9j5Grp38aNc0vYWDW7YSz70TWwXKIBMoeegXTqjAN22ihoie3lQy57NrCrX
	 OyQq8RzSUDcoD/UYC5tN5vcfwgkB+b5iVeBqao5yJtrYu+vdeZA5EA8RypaFkJE4yB
	 dYnK/0DguMOwy/UX8rOLXX5mfj58P61ye1P9YVQvrUSf0P46tzVu6xCPRgluKs12wB
	 tQYvQKFROlP4uBH0lwO5hxufoqysK3uzHjQ0dmPGZkbQkkyvY7Z+JoHorzq6kGwcet
	 on9eQsi4HE3kw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 15:22:12 +1000
Subject: [PATCH net-next 05/11] tcp: allow mptcp to drop TS for some
 packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-next-mptcp-add-addr6-port-ts-v1-5-4fc25dfef62e@kernel.org>
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
In-Reply-To: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5047; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Pc7U/DrS+H1oMm8+T6ry05zL7FCElt/gz3FzFjS20/s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHReS+JcaHkRmo8WCVXiW+LMXabNjuZtKTxlfo
 V/GZGqBm9GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah0XkgAKCRD2t4JPQmmg
 c1YmEACb+xdj60X01Eg8g48p/f+xW7NCdx9NmmsYMldb2GVsQTdMWgNd2gEwQcNZ9VWYmM+Fih5
 26gSyMTHV0i3CgW9lWyVDlWdmeMBxIM1zgIsZ9ivTZRqEAM7I48xaUwBZSxwApFTG3iB3YYFzxO
 Zug1dqcScEHbaCa0RyehXWn9TJSJUjxN1vn/9ooRzsX5cTkVcerx5OBbxC4GO89+1aLAaMMV4ZY
 rsSjnUWe7Ra0K/UgYXcq8iSDVFoFduRaEzcttBx1aDQKCgWuxJM0tJfQkXCub5ZXcH5vV2HBSbD
 fL+PhlSGZUVLbd1n110rw1vdxKdzt5MGwfUC4O+N1CzXNez4HYX77hoLQ1ndbCORhHCgBvRz95A
 X6pFZFqCF/9cfdhOQJK4aDjfSpgCaOmhDLGCSK8ZVxXjk9TESJR7otbI39rUteE/rPG1PbFM0te
 gONclh3twoXo6I1Uw5HqCvdLKyjkzRBN/sN5oSYJPGNlH8e00gfa7PURUx/89JJy3k+RJifo3R7
 izvp0cfxug9iCN/Fxfji7yx/JPKIRrn+Hn1hCrKAv7vVz3a1yvxQ42vgiLvNk3w9Y3TvebCqnym
 bzxRty9qvcG935h3KufFy9ozn0ZB4qXcb5iNV4bfc5OGcwqCAmld6AOPhfSpJVxPtA9Lx6Mzj6V
 l+93COUlJ7+/hGw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293547-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AB157619A94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
taking 30 bytes, the 40-byte limit for the TCP options is reached. In
this case, it is then not possible to send the address signal.

The idea is to let MPTCP dropping the TCP-timestamps option for some
specific packets, to be able to send some specific pure ACK carrying >28
bytes of MPTCP options, like with this specific ADD_ADDR. A new
parameter is passed from tcp_established_options to the MPTCP side to
indicate if the TCP TS option is used, and if it should be dropped. The
next commit implements the part on MPTCP side, but split into two
patches to help TCP maintainers to identify the modifications on TCP
side. This feature will be controlled by a new add_addr_v6_port_drop_ts
MPTCP sysctl knob.

It is important to keep in mind that dropping the TCP timestamps option
for one packet of the connection could eventually disrupt some
middleboxes: even if it should be unlikely, they could drop the packet
or even block the connection. That's why this new feature will be
controlled by a sysctl knob.

Note that it would be technically possible to squeeze both options into
the header if the ADD_ADDR is first written, and then the TCP timestamps
without the NOPs preceding it. But this means more modifications on TCP
side, plus some middleboxes could still be disrupted by that.

About the implementation, instead of passing a new boolean (drop_ts),
another option would be to pass the whole option structure (opts),
but 'struct tcp_out_options' is currently defined in tcp_output.c, and
would need to be exported. Plus that means the removal of the TCP TS
option would be done on the MPTCP side, and not here on the TCP side.
It feels clearer to remove other TCP options from the TCP side, than
hiding that from the MPTCP side.

Yet an other alternative would be to pass the size already taken by the
other TCP options, and have a way to drop them all when needed. But this
feels better to target only the timestamps option where dropping it
should be safe, even if it is currently the only option that would be
set before MPTCP, when MPTCP is used.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Neal Cardwell <ncardwell@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/mptcp.h   | 3 ++-
 net/ipv4/tcp_output.c | 6 +++++-
 net/mptcp/options.c   | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f7263fe2a2e4..000b6593bfa4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -151,7 +151,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 			  struct mptcp_out_options *opts);
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts);
+			       bool *drop_ts, struct mptcp_out_options *opts);
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
 
 void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
@@ -270,6 +270,7 @@ static inline bool mptcp_established_options(struct sock *sk,
 					     struct sk_buff *skb,
 					     unsigned int *size,
 					     unsigned int remaining,
+					     bool *drop_ts,
 					     struct mptcp_out_options *opts)
 {
 	return false;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ef0c10cd31c7..53ee4c8f5f8c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1181,12 +1181,16 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	 */
 	if (sk_is_mptcp(sk)) {
 		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
+		bool drop_ts = opts->options & OPTION_TS;
 		unsigned int opt_size = 0;
 
 		if (mptcp_established_options(sk, skb, &opt_size, remaining,
-					      &opts->mptcp)) {
+					      &drop_ts, &opts->mptcp)) {
 			opts->options |= OPTION_MPTCP;
 			size += opt_size;
+
+			if (drop_ts)
+				opts->options &= ~OPTION_TS;
 		}
 	}
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index be85607733f3..ccb5ac0aa729 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -815,7 +815,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk, int *size,
 
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts)
+			       bool *drop_ts, struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
@@ -824,6 +824,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	int opt_size = 0;
 
 	opts->suboptions = 0;
+	*drop_ts = false;
 
 	/* Force later mptcp_write_options(), but do not use any actual
 	 * option space.

-- 
2.53.0


