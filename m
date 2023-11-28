Return-Path: <netdev+bounces-51899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5BF7FCAB3
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 137D9B216E8
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC905C3F3;
	Tue, 28 Nov 2023 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqwDd1JW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02065C3E7;
	Tue, 28 Nov 2023 23:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439BFC433CA;
	Tue, 28 Nov 2023 23:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701213564;
	bh=/YPiWA8t6H6dYaB9WCKiEiEo8CU1u27ulgHO3vRs55M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RqwDd1JWQDmhT/cVbM57zISrpbCNeoJYfL6zGhUzbw0CPjPXcH16qjnAIiKCc9YR9
	 8C6i1crornacL7KGxtUwP4Kt2n22QbNVOVTH90HLb0jfr4fyN/YRLQUlDpT5Du3Tyz
	 5VFZK2mrZwWDpI15JK/m/N+QkdXWsX3lLs4h/seRXmWRmtgmLLhAMg5lBDnK5oESxW
	 15vs/hdFcHS6D4itGjLJUnyCK71LhuGDB5/zZpLDWadnV9eL5DtOS+VK5SnKaowXqW
	 /g1+m3o0PTOPhYj5KzOC85wqnzorCGRkwxexnyJN4RAdAQJSl+4FmzsSHGem9D9pAO
	 NjJO5qqzWaoig==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 28 Nov 2023 15:18:51 -0800
Subject: [PATCH net-next v4 07/15] selftests: mptcp: userspace pm remove
 initial subflow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-send-net-next-2023107-v4-7-8d6b94150f6b@kernel.org>
References: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
In-Reply-To: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

This patch adds a selftest for userspace PM to remove the initial
subflow.

Use userspace_pm_add_sf() to add a subflow, and pass initial IP address
to userspace_pm_rm_sf() to remove the initial subflow.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4357a46ca3f3..812a5ee54158 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3514,6 +3514,30 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove initial subflow
+	if reset_with_events "userspace pm remove initial subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		userspace_pm_rm_sf $ns2 10.0.1.2
+		# we don't look at the counter linked to the RM_ADDR but
+		# to the one linked to the subflows that have been removed
+		chk_rm_nr 0 1
+		chk_rst_nr 0 0 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()

-- 
2.43.0


