Return-Path: <netdev+bounces-288180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOT4LNKhBmoMlgIAu9opvQ
	(envelope-from <netdev+bounces-288180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 06:32:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3023D5493E2
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 06:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5623F3095558
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2663E3D412C;
	Fri, 15 May 2026 04:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUjzUqi0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023DC34166B;
	Fri, 15 May 2026 04:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778819305; cv=none; b=T7m+C8MRVmXYO125IG63JVpXE+xXcOTDy664fssry9T2n7pzJsphAlMurlAJk19GTkCQjQu5B2hiMOdD390C2t0p4dOaeSiCj3hPzRDd7TT4pHr+LxDHotTuKfgtH0WDzGqA7bpGO0PuQKS8VnR6HHmWMy0rz5GQ17L14S8ATvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778819305; c=relaxed/simple;
	bh=HAqn1a+1m/18t3HW1mWpO6nHBtvV4r5btqoAhjlEJO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mTTWUn4eQz/psIsnBjL7mkaPIFNayzWu+jhsVn4FoQ2Wjg2FAgK8eXE8C7ZuZUsfyNIOb9xjM0vJ1oqEFeisTvvGJ+8pvu9O7N0/sbY+B34spTFxlXl1aP7fsnpLqd8h5XZTtoKnxSKjVSdJoh7j420/IrDaKrLHn89Oab6yXRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUjzUqi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB96BC2BCC7;
	Fri, 15 May 2026 04:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778819304;
	bh=HAqn1a+1m/18t3HW1mWpO6nHBtvV4r5btqoAhjlEJO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OUjzUqi0na5M6Fgu6iSj0tg4XAi4UmNw7zbRuPajov2PubJ6cMaFOMjfPJ2zXJjQ0
	 jp6pDX4oLRV/TuL7EN8IG2QcdadGHN+t363itYBH2kZ0daovBhdpeHq2pcxeZ5MOi9
	 njn297WjiGSPVLXDjMNgqgPNMKC+QQHrdlAs7MMEI/Dbie00wrpovCBcmFQmR/7SAJ
	 rYRH8qB5GsMXO3fl6LuqbzRXfnFVuJUBzm/j6SxdKUoQSYjiuSVedz4XblVmQKy8l0
	 6raC0cGpy+DjrJr8CEyvN5ZwMNhV1786S5QjSbhQM1GS1VFHXiWCFowRkNDyJmd8Qe
	 OAWVGlZ6DZ8og==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 May 2026 06:27:34 +0200
Subject: [PATCH net v2 3/6] selftests: mptcp: join: cover ADD_ADDR tx drop
 and list progress
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-3-701e96419f2f@kernel.org>
References: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
In-Reply-To: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 linux-kselftest@vger.kernel.org, Eric Dumazet <edumaze@google.com>, 
 Li Xiasong <lixiasong1@huawei.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2117; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/orNxmenZ9vHQomKpdCaVKJWq+BaFJUdd4uWduQYZew=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqBqDLmosos3y82QGnkZPi7G3GBpsbpSdwwxZsy
 IU5M3KvIK6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagagywAKCRD2t4JPQmmg
 cwkED/9gRC753yOCpep3/iO8STH1AONnovxrca0oEsOdwITY0Vli96RMis2WM7E/AmBV1TIW/NM
 MHKGBrOBSsYi6NKwz6B7zYYYmn7DpUNm/lPwX5yBveMkha/Ou3UWeO11LRuUtv3xqz6Ac7FZyNI
 qnbY9BNfyh68Bc1k54ZUuDk+gvlpo4w4Nj+sd6NX0fccPUolPoXImRWzEvr+BXnPvDi1q0slocK
 7OuRKvYFL88uumT6hnpcpOthJKsGGygh0MujGB9pjG4RxcbBkRaKYLFhvKOwM1DxY9j+EcFYjda
 4mJt7YxsZ451bYHIQYI3TuUAtaBgW89JoXN8nJKSOxIxHwB5Ze3glxraYsNl6WKzdmSef+LIadH
 VLFD4c4IH4Xvi55/pP0AFzXCR03ytc2sFSXkAMUpZcJ+KCfi1YQfTZzGaN9lz4TKFvcN8Qo98eS
 23AWCee4DCRAHpwTcn/LEDXiczJZTBCTD1rBpxXlfPnXUBfhBxDhhX+VQJWwSKH2PXhIoqVLdJe
 VLHCgiveCjZgLlnocUdqCoiTaF8Dr46OOclu8hb6twmzNivOi3l5CTUog5DWBFLS8ywTwAdmS6i
 6TygLMyUI+2LaDNX/4zosvzzSFwO87CcTZbzuzZo9gCypfo1kIWepwmkC9UavXHvnMtnG9uqRTn
 Rkc+h7z3JdEm6Jg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 3023D5493E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288180-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Action: no action

From: Li Xiasong <lixiasong1@huawei.com>

Extend add_addr_ports_tests with IPv6 signaling cases that exercise
ADD_ADDR tx-space shortage when tcp_timestamps are enabled.

Add one case to verify PM still progresses to later signal endpoints
after the first one is dropped.

This covers both failure accounting and the non-blocking behavior of
the announce list after a tx-space drop on pure ACK.

Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index beec41f6662a..5acd12021e6e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1828,6 +1828,22 @@ chk_add_tx_nr()
 	fi
 }
 
+chk_add_drop_tx_nr()
+{
+	local drop_tx_nr=$1
+	local count
+
+	print_check "add addr tx drop"
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTxDrop")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$drop_tx_nr" ]; then
+		fail_test "got $count ADD_ADDR drop[s] TX, expected $drop_tx_nr"
+	else
+		print_ok
+	fi
+}
+
 chk_rm_nr()
 {
 	local rm_addr_nr=$1
@@ -3278,6 +3294,21 @@ add_addr_ports_tests()
 
 		chk_mpc_endp_attempt ${retl} 1
 	fi
+
+	# first signal address drops, second one still progresses
+	if reset "signal addr list progresses after tx drop"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 0
+		ip netns exec $ns1 sysctl -q net.ipv4.tcp_timestamps=1
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_timestamps=1
+
+		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal port 10100
+		pm_nl_add_endpoint $ns1 dead:beef:3::1 flags signal
+		run_tests $ns1 $ns2 dead:beef:1::1
+		chk_add_drop_tx_nr 1
+		chk_add_tx_nr 1 1
+		chk_add_nr 1 1 0
+	fi
 }
 
 bind_tests()

-- 
2.53.0


