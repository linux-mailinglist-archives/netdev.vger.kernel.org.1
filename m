Return-Path: <netdev+bounces-295744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vF8YKNmaImpDawEAu9opvQ
	(envelope-from <netdev+bounces-295744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:46:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 004FB646FF1
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:46:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=djvla8S6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295744-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295744-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3882031A4928
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017364BC017;
	Fri,  5 Jun 2026 09:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2B141363F;
	Fri,  5 Jun 2026 09:22:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651342; cv=none; b=kg6HpcViRZCvu00vkAowgHM+9oFvhrjbxUE8XSdPm75SNu+AudbUTzqq3rw4w494NOFBMuLRAooNjLaiXYVVWoaps2Nm65Qc1go2hkqAC/RR3EEafVrkwiD+HqUJ0Mi6zN+VvH2pJg5WuVkuosExVXTGrn5j9fpA/4erezOh8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651342; c=relaxed/simple;
	bh=pYUkzT9WMoF0Fxo9V06BkLXOTqCR+8gXIQfe1jfof90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OSnDXP7LZ2u3oJC7yhdIhp5zt/HcRzdkJXETahkQFFzk+Dl1bMF9kJiAVMDdVwb+4a/XS4oTogCLpaZnQf36J1sz3o1GoE6f0IbwDcCCBg0ThPMBWtIsJ+gSkn0qZ44FDZl/8IAx8uWv8h9+e1ahuSuQcbz13LPGFCT/dHD4Zes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djvla8S6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6292A1F00898;
	Fri,  5 Jun 2026 09:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651341;
	bh=T7CznXCwJN4JIsW2d+nYSO1H9p8u1K/xatXIxIbVb98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=djvla8S6/eV3a6h6ONEQInQKybgpZP2HW5imvPmHA3XLeVa8/XnMIKxsuNFDmqPrE
	 CazA45w0jM5o3/lDldOTXei6z9yXwzUd8ndHKimthl0XddaBysLuOnwEiSW07M1CyM
	 o+t6+hqdLnvhT3biXpCRJtgbFW2qs7Cx97+PCNHibtEAOJ3g8wLTkQsyjeewLJOUXF
	 6xOnByK6qkso5R4rMEx/E+IPmC8ssTjl1NhsnznbourSU2ymyLeuEutjiIhTBH7FEx
	 9imT1tJSQl1GyQTGerjo6dQLByGXt5egEUcGCaQlO+ZjLa/Xt8dvWd+u2xzon0bs6m
	 oacxZkPGrnHpQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Jun 2026 19:21:50 +1000
Subject: [PATCH net-next v2 06/15] mptcp: pm: drop TCP TS with ADD_ADDRv6 +
 port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-6-758e7ca73f4d@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4760; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pYUkzT9WMoF0Fxo9V06BkLXOTqCR+8gXIQfe1jfof90=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUxH9DPglVd4x+1BOnTqXfRFGs2DP4F7ArGM
 LhBdllG4bCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMQAKCRD2t4JPQmmg
 c1oUD/9hulPw0qSggU+pngwpONfohasbEBgvOPYjwe+GHLVr+hFd3GrGqF/t/vsIIQ2/kfO0wxC
 j4H7Ewh05v1Ps8SaoY4NtkdBa/f3qtWMRIkHcIri7SIK8GX7OAraLHtsle83la6o5ysKJPFfwxB
 HCviTWXl7uMj4timKUOMlA1YasBAMsz+puSAxwfXqu0x0FO8J9GeWipwY9cKXIDR6zNbwFmabxD
 YSe1/l3GPT1J+uzSaGBD9BHiIUPWVTtTEGjEiFGMUNrMRqMjMPl4HLVtKM8V20ffvZfbo3oZAHQ
 uJf0AUcqpeq6IqkcqqwIxejDJXutnMvpkdKGd1MMJtWBJe5Ol5Ww/8d9DhADSqPRNwHP9FA8jr9
 OKePE+yYXc7RiolxpNDV9OD5KNAJwD6+QNvE+hjQeKWZgGsR2BgIOcQdbHC32UUoVRm6hS9m8xf
 7AjyAuSYmTPpQuV9gpLYaEybN1We9h/3CfmkncPfwxesYrVCKXGWSiLBzEUQP+DNLrx7RLGnTL9
 cb4bjf5TD0pSSu9Sg0fXE2S8oC4tP8JnSwLVjhWh+CzFYh5QzoJflhAZNXI01glHZJ4jgUpJiUj
 dkHDJxTmxq/TfgMYQalqKTW88vieEQod3R1qMXCRPBwtzpOAlsnRY51ssqKPZrjIIkVMl8e/VZ9
 djePge0eLx0izag==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295744-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 004FB646FF1

With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
taking 30 bytes, the 40-byte limit for the TCP options is reached. In
this case, it is then not possible to send the signal.

To be able to send this ADD_ADDR, the TCP timestamps option can now be
dropped. This is done, when needed by setting the *drop_ts parameter
from mptcp_established_options. This feature is controlled by a new
net.mptcp.add_addr_v6_port_drop_ts sysctl knob, enabled by default.

It is important to keep in mind that dropping the TCP timestamps option
for one packet of the connection could eventually disrupt some
middleboxes: even if it should be unlikely, they could drop the packet
or even block the connection. That's why this new feature can be
controlled by a sysctl knob.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/448
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  |  9 +++++++--
 net/mptcp/pm.c       | 13 ++++++++++++-
 net/mptcp/protocol.h |  3 ++-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 95f16f9f0ce2..8d0680a588dd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -659,11 +659,13 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 static bool mptcp_established_options_add_addr(struct sock *sk,
 					       struct sk_buff *skb, int *size,
 					       unsigned int remaining,
+					       bool has_ts,
 					       struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_addr_info addr;
+	bool drop_ts = has_ts;
 	bool echo;
 
 	/* add addr will strip the existing options, be sure to avoid breaking
@@ -672,11 +674,13 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
 	    !skb || !skb_is_tcp_pure_ack(skb) ||
-	    !mptcp_pm_add_addr_signal(msk, size, remaining, &addr, &echo))
+	    !mptcp_pm_add_addr_signal(msk, size, remaining, &addr, &echo,
+				      &drop_ts))
 		return false;
 
 	pr_debug("drop other suboptions\n");
 	opts->suboptions = OPTION_MPTCP_ADD_ADDR;
+	opts->drop_ts = drop_ts;
 	opts->addr = addr;
 	if (!echo) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDRTX);
@@ -859,7 +863,8 @@ int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	total_size += opt_size;
 	remaining -= opt_size;
-	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining, opts)) {
+	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining,
+					       has_ts, opts)) {
 		total_size += opt_size;
 		remaining -= opt_size;
 		ret = true;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 59dc598d343d..ac7de4141738 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -903,7 +903,8 @@ static int mptcp_add_addr_len(int family, bool echo, bool port)
 }
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, int *size, int remaining,
-			      struct mptcp_addr_info *addr, bool *echo)
+			      struct mptcp_addr_info *addr, bool *echo,
+			      bool *drop_ts)
 {
 	bool skip_add_addr = false;
 	bool ret = false;
@@ -941,6 +942,13 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, int *size, int remaining,
 	if (len > remaining) {
 		struct net *net = sock_net((struct sock *)msk);
 
+		if (*drop_ts && mptcp_add_addr_v6_port_drop_ts(net)) {
+			/* OK without TCP Timestamps? */
+			len -= TCPOLEN_TSTAMP_ALIGNED;
+			if (len <= remaining)
+				goto enough_space;
+		}
+
 		if (*echo) {
 			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
 		} else {
@@ -950,6 +958,9 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, int *size, int remaining,
 		goto drop_signal_mark;
 	}
 
+	*drop_ts = false;
+
+enough_space:
 	ret = true;
 	*size = len;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b43dae72e7de..e69fcb4d48af 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1208,7 +1208,8 @@ static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
 }
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, int *size, int remaining,
-			      struct mptcp_addr_info *addr, bool *echo);
+			      struct mptcp_addr_info *addr, bool *echo,
+			      bool *drop_ts);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list, int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);

-- 
2.53.0


