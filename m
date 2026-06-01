Return-Path: <netdev+bounces-293546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIsXF9gXHWrFVgkAu9opvQ
	(envelope-from <netdev+bounces-293546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:25:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9DD619A40
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5CDA3009CEE
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA76933F8B1;
	Mon,  1 Jun 2026 05:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRFx57/2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35833F5A5;
	Mon,  1 Jun 2026 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291500; cv=none; b=J+DGHcUEaHTmU7RYKytl2VT06G5t5G3a47sHduCOVDWX/HIFNRXUumOV15Y5rAz4AkFyWiWHGO1UiPNn1JZo22xAL4Vus/8k0Zka7I5bJGKikbkIBXipAfSyc5YkbdCII96b8skR555KlDG9qos9+wEM0r+YxwjMBtTeXWRN7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291500; c=relaxed/simple;
	bh=ryR1USqxZj75x5uYl7635eoJrAMhaCO5hEkGGfuxiUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVLhTpCXCajvbTVT9B4goqKJXjXiWApJ202s4qmoF/ehGw33jHZ8PT+6Uw2cQXYKPkwFT0SjzS3c3vchP+NH9r3Gh4bLLQ4WQaDw8s3BRHxE8hgJdQ3HRXKeprErsEm7ZkYNBEm1fnAj05FUNmGgKn99dhChHwJV3VMkTn7OowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRFx57/2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E82B1F00898;
	Mon,  1 Jun 2026 05:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780291498;
	bh=nHQ25U4bEkOBE82ITW6DfiX75k6gpoBg22fDsTWZBgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IRFx57/2F21pQU0yWj+xLRckoUuLFdPeof0MnIqX+hTkLtEgkPTZV6s1dB0s8c6bz
	 2Qh+MWDRIi79n55prEsX52+ZRtNAZuQHow0vmB9WpizTrU7a1oGIz/Ju2XBXr+AAhW
	 KBqUVp8wj9ovD6WvOp8lmGA3m9TJLHarPyTeVcA9JGwXKNRwa/6DU9Ot4GAGGXa77A
	 bW/rQOACX7i+1p0keulfud36AbtCcwzHZVwmjhwFCzzrji58grUBLBqEIrEslRI4TE
	 WBGHupVp8ydXoHgIKvfSu7eRV/6RWMi9VGut5aF3frOTs2sqkdqnCecQFBndLZEc+C
	 5B71UoCHofmIw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 15:22:11 +1000
Subject: [PATCH net-next 04/11] mptcp: introduce add_addr_v6_port_drop_ts
 sysctl knob
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-next-mptcp-add-addr6-port-ts-v1-4-4fc25dfef62e@kernel.org>
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
In-Reply-To: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5655; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ryR1USqxZj75x5uYl7635eoJrAMhaCO5hEkGGfuxiUw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHReS3b5XNU6mBMT2uZmcUhCkBDOIqQ42djrJ4
 RiNIqfDNyqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah0XkgAKCRD2t4JPQmmg
 c0kBD/9EaO9VOn7sWqjyRodm9CfFNlXRaQK9Kl4em3Tu7Lyku9xAYkT5KEswS6eO4YN6zEdmy1K
 JiDdLfCSrD3/JGCeSivVdOyBnqnk3w9gfqY3za0GAN5uSqArEiBoXiDgLnjfmNSl3n2HT7HiQw1
 EAP/pjXaW+TtE5M7MHMXn68v+JVwfRZ+eihhGcGXr9Lkdv/mlgL1dcG3RyreU++kzVkxlnPEQ7t
 9Qq8axTDqfWTdu18eWHDzDgsX5M6inFk1KjjZZTpDTDQ7QQE+n4yZILEIoXvt9swDNrJCDN2WdD
 JItQOBAj+1C35Ct5/Yg6m2TPAXHsKew3+COJUf7zJ2Irwoq9ozoZRNZok3DAHrUW8t09DWCLw/G
 myBwruYQvy8mb38IaH6u536ERSRxCVqZsc83vCuhJ1T/NM/QeTKOuiJM/xmJshilmdiQUu1A5Kg
 sQQ0TYjNjjKyQTre7RzPDGxTmKfgBseCrHheczfEF2V0M6jmgXrBdVAuveEt8fRH2FLUqbU2VXK
 eUHLemnw+ynDn9SuaugK5IPLA+nUtm7d730gmNRwQqjClMSR7YKQrVJrABzQQ17IIlvviuBiwix
 DGcRFq1AIeDcjKYOoFT9FPpHi2X9Bnq8gXSJuCXEazsyPeEfPkNm4wZPv7R9pLnuqqjVej5rhl0
 KUTqBpWCklJe9dQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293546-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EC9DD619A40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This sysctl is going to be used in the next commits to drop TCP
timestamps option, to be able to send an ADD_ADDR with a v6 IP address
and a port number. It is enabled by default.

This knob is explicitly disabled in the MPTCP Join selftest, with the
"signal addr list progresses after tx drop" subtest, to continue
verifying the previous behaviour where the ADD_ADDR is not sent due to a
lack of space.

While at it, move syn_retrans_before_tcp_fallback down from struct
mptcp_pernet, to avoid creating another 3 bytes hole.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
 Documentation/networking/mptcp-sysctl.rst       | 13 +++++++++++++
 net/mptcp/ctrl.c                                | 18 +++++++++++++++++-
 net/mptcp/protocol.h                            |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  1 +
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 1eb6af26b4a7..b9b5f58e0625 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -21,6 +21,19 @@ add_addr_timeout - INTEGER (seconds)
 
 	Default: 120
 
+add_addr_v6_port_drop_ts - BOOLEAN
+	Control whether preparing an ADD_ADDR with an IPv6 address and a port
+	should drop the TCP timestamps option to have enough option space to
+	send the signal.
+
+	If there is not enough option space, and the TCP timestamps option
+	cannot be dropped, the signal cannot be sent. Note that dropping the TCP
+	timestamps option for one packet of the connection could disrupt some
+	middleboxes: even if it should be unlikely, they could drop the packet
+	or block the connection. This is a per-namespace sysctl.
+
+	Default: 1 (enabled)
+
 allow_join_initial_addr_port - BOOLEAN
 	Allow peers to send join requests to the IP address and port number used
 	by the initial subflow if the value is 1. This controls a flag that is
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index d96130e49942..c94a192f4118 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -32,12 +32,13 @@ struct mptcp_pernet {
 	unsigned int close_timeout;
 	unsigned int stale_loss_cnt;
 	atomic_t active_disable_times;
-	u8 syn_retrans_before_tcp_fallback;
 	unsigned long active_disable_stamp;
+	u8 syn_retrans_before_tcp_fallback;
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
 	u8 pm_type;
+	u8 add_addr_v6_port_drop_ts;
 	char scheduler[MPTCP_SCHED_NAME_MAX];
 	char path_manager[MPTCP_PM_NAME_MAX];
 };
@@ -94,6 +95,11 @@ const char *mptcp_get_scheduler(const struct net *net)
 	return mptcp_get_pernet(net)->scheduler;
 }
 
+unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net)
+{
+	return mptcp_get_pernet(net)->add_addr_v6_port_drop_ts;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
@@ -108,6 +114,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
 	strscpy(pernet->scheduler, "default", sizeof(pernet->scheduler));
 	strscpy(pernet->path_manager, "kernel", sizeof(pernet->path_manager));
+	pernet->add_addr_v6_port_drop_ts = 1;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -362,6 +369,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0444,
 		.proc_handler = proc_available_path_managers,
 	},
+	{
+		.procname = "add_addr_v6_port_drop_ts",
+		.maxlen = sizeof(u8),
+		.mode = 0644,
+		.proc_handler = proc_dou8vec_minmax,
+		.extra1       = SYSCTL_ZERO,
+		.extra2       = SYSCTL_ONE
+	},
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -389,6 +404,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[10].data = &pernet->syn_retrans_before_tcp_fallback;
 	table[11].data = &pernet->path_manager;
 	/* table[12] is for available_path_managers which is read-only info */
+	table[13].data = &pernet->add_addr_v6_port_drop_ts;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e0ffebaa6795..f4276980d78a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -798,6 +798,7 @@ unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_path_manager(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
+unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net);
 
 void mptcp_active_disable(struct sock *sk);
 bool mptcp_active_should_disable(struct sock *ssk);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5d4d0f127f79..23b17957686a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3313,6 +3313,7 @@ add_addr_ports_tests()
 	if reset "signal addr list progresses after tx drop"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 1 0
+		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_v6_port_drop_ts=0 2>/dev/null || true
 		ip netns exec $ns1 sysctl -q net.ipv4.tcp_timestamps=1
 		ip netns exec $ns2 sysctl -q net.ipv4.tcp_timestamps=1
 

-- 
2.53.0


