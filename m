Return-Path: <netdev+bounces-295743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8CNSFMmaImpAawEAu9opvQ
	(envelope-from <netdev+bounces-295743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:45:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE89646FE1
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:45:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Pw3FTNQS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295743-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295743-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3139A31A0EAC
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC9E413621;
	Fri,  5 Jun 2026 09:22:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5364C346E4E;
	Fri,  5 Jun 2026 09:22:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651339; cv=none; b=sCRsyUmGzMIe9F07oAhGVA+8ZBaQn2jrAFHo3AA3Z1xTeef1+UAuyeljXhx5ZOMftBEIwgu65iPra4CZggaPDt9WBzTUiQx/GCQ2eRs9DQsqP1juXW1eJ82dqOQrUPXSxeSLtkvhwiBrWDVhbUtM7iPBo8VmDNauddJcWiMzb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651339; c=relaxed/simple;
	bh=fOK/2EU3xGYR7Qct0sK97GVCqqm3QJlOv3wmiRk1M0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l2qqclm6TAidHSmGlK/U/faOqH4MZJnonRsCNzRAbavz2BOKXssGduGpBdpc3/a9SI9s7u7J9uDq960LvfcSfQCeFtKCeUZWOMt/1k1lnhJwUKBIL/Zaw96JeMF6wzzfau+pM+7UpEPkC7hW44EsVc0K2cJGZxUaxkuhNSJnrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw3FTNQS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2C31F00893;
	Fri,  5 Jun 2026 09:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651337;
	bh=vjABy2vl/03GhfnN5O43LspkuM5aUUA2EeS9WCr0mMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Pw3FTNQS/O1JDe4aYHkQ4AufJ98af88RL0z/m1nf453R2TerDWa3r9ozKQgo9BeDE
	 LE+Zqo6r7pDgIG/PO6epAh3G4VibAiKkctZwj4+pCXIPoW0g01XEmLOANrFZJNWB8Y
	 Ih0QsP9Td5xj8vkI6Ragncs21jAIApyB/uuj7KMVSQnwjPrm2jpWkFCtazXBIkCmzA
	 7tKxvJSGdX6Ep7ESfJlX4YnlWilPM3J/AKVXdF23sEVecBCSaB5gdsMcJKhoVe2iK3
	 wsM9MEh197DqG+nsyJAiTApk9MDtcO9cy/xeu0N2/aZzRpxlJYjAUNiEoLZTsKYCub
	 AA2V7VBUI4qnw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Jun 2026 19:21:49 +1000
Subject: [PATCH net-next v2 05/15] tcp: allow mptcp to drop TS for some
 packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6075; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fOK/2EU3xGYR7Qct0sK97GVCqqm3QJlOv3wmiRk1M0E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUxUPqVcurrl1wz5a20yVgRBjZ7azfVyqaFR
 bcULrKwIwWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMQAKCRD2t4JPQmmg
 cy2zEAC9b/TnIqlBybcrXyWk3ww0vInnmagzviag6YXRmWmVVCF3dnfzDL4pr+nvnAkl2qqfJOM
 5enaTLZ/kRGORaEZbN+2w+fsG8Vvm1hLJe6aslIQxWN5grG3+QmAhqWHavXgPQgi87gqY/jaH08
 +HHEHo1smUYBXyEakKlzCjqSAZx8hCiTE85D/vb9GJXm9pvcVFpZf4DxbRVYzsnn9iqjIr6Cp8U
 426NkCfg/O+icCid+lg7psYdyI4xJvIqpN+J3oEbGp9KwDMZVESfz740kXTG5rUvqcOKoPCSaAM
 77d6NuqVvqRFjA2M2B2yRMtH0kKFrTUH+BNYUKlIjFQlRfHl495Em+CoSvZS/RCLWVBryblbGa/
 v9X1xSRnN1wwaGkOENKL85IH+w8FOb+uZwNCNfkg1PRPzNYULhMF5dUmGa1LW2VW45bQn0MPo7o
 qgryTHinNgR8QCe8DhWdHrOphsDxkJdZxDNV4zATV6bABndo6GgGQfDOEONIy9uN2S0Z/NMPJCy
 dNXEOgq96h8nyXF72tuyyZsFih6VgPaGe8fkS943/04uTy4Te0QqZ5bclBHxxTYTyYprzS8yt8w
 Rm24UmGIaFrwxloFDbCSd2rE7WnPRn18JAi0ZIvxpRmTZFA1LjbIxsiC7QPhTWHCYa1I8U/lTIB
 B/mpMFXOalax/5Q==
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-295743-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABE89646FE1

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

In this implementation, an unused bit is used in mptcp_out_options
structure to avoid passing an address to a local variable. Reading and
setting it needs CONFIG_MPTCP, so the whole block now has this #if
condition: mptcp_established_options() is then no longer used without
CONFIG_MPTCP.

About alternatives, instead of passing a new boolean (has_ts), another
option would be to pass the whole option structure (opts), but
'struct tcp_out_options' is currently defined in tcp_output.c, and it
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
- v2: Avoid passing local variables' addresses to
  mptcp_established_options not to force the compiler to use a stack
  canary in this hot function, even for non-MPTCP flows. (Eric Dumazet)
To: Neal Cardwell <ncardwell@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/mptcp.h   | 13 +++----------
 net/ipv4/tcp_output.c | 10 +++++++++-
 net/mptcp/options.c   |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 24d1016a4664..71b9fc5a5796 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -72,7 +72,8 @@ struct mptcp_out_options {
 	u8 reset_reason:4,
 	   reset_transient:1,
 	   csum_reqd:1,
-	   allow_join_id0:1;
+	   allow_join_id0:1,
+	   drop_ts:1;
 	union {
 		struct {
 			u64 sndr_key;
@@ -153,7 +154,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 			  struct mptcp_out_options *opts);
 int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
-			      unsigned int remaining,
+			      unsigned int remaining, bool has_ts,
 			      struct mptcp_out_options *opts);
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
 
@@ -269,14 +270,6 @@ static inline bool mptcp_synack_options(const struct request_sock *req,
 	return false;
 }
 
-static inline int mptcp_established_options(struct sock *sk,
-					    struct sk_buff *skb,
-					    unsigned int remaining,
-					    struct mptcp_out_options *opts)
-{
-	return -1;
-}
-
 static inline bool mptcp_incoming_options(struct sock *sk,
 					  struct sk_buff *skb)
 {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d3b8e61d3c5e..26dd751ec72a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1175,6 +1175,7 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		size += TCPOLEN_TSTAMP_ALIGNED;
 	}
 
+#if IS_ENABLED(CONFIG_MPTCP)
 	/* MPTCP options have precedence over SACK for the limited TCP
 	 * option space because a MPTCP connection would be forced to
 	 * fall back to regular TCP if a required multipath option is
@@ -1183,15 +1184,22 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	 */
 	if (sk_is_mptcp(sk)) {
 		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
+		bool has_ts = opts->options & OPTION_TS;
 		int opt_size;
 
-		opt_size = mptcp_established_options(sk, skb, remaining,
+		opts->mptcp.drop_ts = 0;
+
+		opt_size = mptcp_established_options(sk, skb, remaining, has_ts,
 						     &opts->mptcp);
 		if (opt_size >= 0) {
 			opts->options |= OPTION_MPTCP;
 			size += opt_size;
+
+			if (opts->mptcp.drop_ts)
+				opts->options &= ~OPTION_TS;
 		}
 	}
+#endif
 
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2e4b6aafbad5..95f16f9f0ce2 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -804,7 +804,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk, int *size,
 }
 
 int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
-			      unsigned int remaining,
+			      unsigned int remaining, bool has_ts,
 			      struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);

-- 
2.53.0


