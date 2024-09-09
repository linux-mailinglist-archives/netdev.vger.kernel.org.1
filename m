Return-Path: <netdev+bounces-126684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C2497234F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9551C232B2
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E7A18A930;
	Mon,  9 Sep 2024 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCHsrOAQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8252188CAF;
	Mon,  9 Sep 2024 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912605; cv=none; b=FAAYLo+oyM9EiDh1AurwwCsmAPkhXhdUmlP6+lprQKOd4A5bLAthoAfPxKxHjAMEYZrUx3wHFckCo5OJat23FVMJ9PwU8fLLRbOAAcYUETM5LU+Kf4gUZDmBAVtEoFdWacNSRa0zvunwTnZyAGtiRb/CigbfGRpRMwo/P0g/zmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912605; c=relaxed/simple;
	bh=6o9q2S8lvt7BiiDTqPx4TT2haa0uyZ/sclRhMedKWKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pr+NbF0mvvEex5t6IqGtczEfAhd/DC97egD8nGde2Xs79F0B0vG43rEie4lp3uKTc58gvKCItQYY795nlwJuoY2K6+CX1DtdH9xnV4Wk5l62r/Tx1zIhy6T2LEt5+yseC2NDnufrTb8tEVd6LdBdIU7L11m0h7spOKab0I385p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCHsrOAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E05C4CECB;
	Mon,  9 Sep 2024 20:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725912605;
	bh=6o9q2S8lvt7BiiDTqPx4TT2haa0uyZ/sclRhMedKWKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PCHsrOAQ8XdxqX6di8qrxxyuEDvy+Gt3GwUOiiBvnYw15QY9YAlamUhbL7syjYLte
	 aw/oSsRQc8RicdqHQU6TzFBlxDDBRnfhNz34c2Tq2AsPNUnQzPAW8xpzB3g0/l7aQb
	 /+9q7Jvs7yVnoc9uR0inobGhb8VE23UKOga1tfJoZO8JR2TTk7ytEjiBvDrSia0GGW
	 9RYAnOhopHEhpphQeUy2pA8qt/PZrRIU3OMNhZOy8emwtsh/YUvFtCLJjczkaSK+Po
	 3wjd4X8apTIDeSCRRzhL9Tw0AAdBGs4eJ7eOHRclC5iSmiq9UpQGbELzm7DKUHl9Rj
	 HjJwJ0OGdN/hw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 09 Sep 2024 22:09:22 +0200
Subject: [PATCH net-next 2/3] mptcp: fallback to TCP after SYN+MPC drops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-net-next-mptcp-fallback-x-mpc-v1-2-da7ebb4cd2a3@kernel.org>
References: <20240909-net-next-mptcp-fallback-x-mpc-v1-0-da7ebb4cd2a3@kernel.org>
In-Reply-To: <20240909-net-next-mptcp-fallback-x-mpc-v1-0-da7ebb4cd2a3@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4457; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6o9q2S8lvt7BiiDTqPx4TT2haa0uyZ/sclRhMedKWKI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm31YQ/PTmA74ZvwTaOwa59ADy/P0K3f80rchdC
 WYGIXNIEzSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZt9WEAAKCRD2t4JPQmmg
 c9/OD/0T2f3ddQkZM5JHoAWGuqBTRysoJFjOpRuobNJu0KunBq1NmYcpog/bONV5d/XbK9TXrO0
 EoCDC+TAGRcEO4YaEg0E3Tya9w2mPlk2WrBWppdNjm7tLVueh4n+zlLTZ3GVvCKVZBc02pvhdVz
 9vfgvQPlP7jRWCMRLNlaGbHv97k1gcquS6H0KC5adGFr1WB74rOFvWwAjFzx8ovHAzw4TGBgFHS
 uZLpHZV4/wLseu0T/1b9J6BaSPxSZNwA8xc/UM2bArgSip/hSuFWivKFpe2vtiIgIfk3aiwiG5C
 6MexwTgmpq11lTMDhejaqGwixlen9obqjQo+w45CnvymO7GpuMVet4htlMVW5wum47ph6kXBEib
 HsooH+JSV1VBap0RU2L5HJX3RLr1rBkKEY3xf7l2P9S9EBRhoC//wP//jhrZF5j11nEVyxBJd0w
 gD6VSLeTJLqHHf8SpS6hLyCLvnxlrwPlu01e6pag1sApe7bzPMc9YmjRxk/ESXAnwzXAiPTkVpd
 61BQxiBddYGcb+kF4ajFNIb05osWlboc6FnYpfJLcZHwqTmArfZkkIlhiIHlh0eNtqHPv8tufiP
 n/vB6Vl+r/16D07KpV+BvWpexuX94YMcRPY1uS9+bSNRl9I3eFQg5rD/na9u/OzG1tucc0ylp+1
 XaHN9/ONKSp6jDA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some middleboxes might be nasty with MPTCP, and decide to drop packets
with MPTCP options, instead of just dropping the MPTCP options (or
letting them pass...).

In this case, it sounds better to fallback to "plain" TCP after 2
retransmissions, and try again.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/477
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/mptcp.h  |  4 ++++
 net/ipv4/tcp_timer.c |  1 +
 net/mptcp/ctrl.c     | 20 ++++++++++++++++++++
 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 5 files changed, 27 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 0bc4ab03f487..814b5f2e3ed5 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -223,6 +223,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 
 	return htonl(0u);
 }
+
+void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
 #else
 
 static inline void mptcp_init(void)
@@ -307,6 +309,8 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 }
 
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
+
+static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 86169127e4d1..79064580c8c0 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -282,6 +282,7 @@ static int tcp_write_timeout(struct sock *sk)
 		expired = retransmits_timed_out(sk, retry_until,
 						READ_ONCE(icsk->icsk_user_timeout));
 	tcp_fastopen_active_detect_blackhole(sk, expired);
+	mptcp_active_detect_blackhole(sk, expired);
 
 	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RTO_CB_FLAG))
 		tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RTO_CB,
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 99382c317ebb..0b23e3c5e8ff 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -12,6 +12,7 @@
 #include <net/netns/generic.h>
 
 #include "protocol.h"
+#include "mib.h"
 
 #define MPTCP_SYSCTL_PATH "net/mptcp"
 
@@ -277,6 +278,25 @@ static void mptcp_pernet_del_table(struct mptcp_pernet *pernet) {}
 
 #endif /* CONFIG_SYSCTL */
 
+/* Check the number of retransmissions, and fallback to TCP if needed */
+void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
+{
+	struct mptcp_subflow_context *subflow;
+	u32 timeouts;
+
+	if (!sk_is_mptcp(ssk))
+		return;
+
+	timeouts = inet_csk(ssk)->icsk_retransmits;
+	subflow = mptcp_subflow_ctx(ssk);
+
+	if (subflow->request_mptcp && ssk->sk_state == TCP_SYN_SENT &&
+	    (timeouts == 2 || (timeouts < 2 && expired))) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDROP);
+		mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
+	}
+}
+
 static int __net_init mptcp_net_init(struct net *net)
 {
 	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index ec0d461cb921..d70a3e2bfad6 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -15,6 +15,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPCapableACKRX", MPTCP_MIB_MPCAPABLEPASSIVEACK),
 	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
 	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBACK),
+	SNMP_MIB_ITEM("MPCapableSYNTXDrop", MPTCP_MIB_MPCAPABLEACTIVEDROP),
 	SNMP_MIB_ITEM("MPFallbackTokenInit", MPTCP_MIB_TOKENFALLBACKINIT),
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index d68136f93dac..062775700b63 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -10,6 +10,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPCAPABLEPASSIVEACK,	/* Received third ACK with MP_CAPABLE */
 	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way handshake */
 	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way handshake */
+	MPTCP_MIB_MPCAPABLEACTIVEDROP,	/* Client-side fallback due to a MPC drop */
 	MPTCP_MIB_TOKENFALLBACKINIT,	/* Could not init/allocate token */
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */

-- 
2.45.2


