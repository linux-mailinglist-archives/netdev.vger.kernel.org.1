Return-Path: <netdev+bounces-51898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E6A7FCAB1
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D281C20AC4
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA05C3EB;
	Tue, 28 Nov 2023 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGdacJKG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2E5C3E2;
	Tue, 28 Nov 2023 23:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820E1C433A9;
	Tue, 28 Nov 2023 23:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701213564;
	bh=zxT3RNDdW5GuJXQIPAODhdpGcGCZGpkvH1XA9cpAibU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pGdacJKGXWwa0xOdPHXwtoCd3eXLjKCxeHtpCxN1jiDgThRa/iBdvNQSWbK3M4noC
	 dTI/mFeqc1Lzj8SLpSjHYyFrR7fOKPmVU2nSzjRI9fpKgGb0FCPf76tgAmeVMCT0At
	 SGNnXKoVl0pEObL4PwPgHvHds7HTmDNaauogb3aRVnWlI6Sth/gOYcmsn5YTwbH61f
	 qJ6k3QIXf3NTv3ET/zXp7CAmQzO+XnurhjvETdoRajo8AvmAh5+8LwOBqI7dgLOxfs
	 fsj6XsU5GJFbAVvZd/aBuZAXoF86KpXQYMbxOaNp6wFSci6B2Le9dwbemUBuZb9T4O
	 YZdtaFUjK+ArQ==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 28 Nov 2023 15:18:52 -0800
Subject: [PATCH net-next v4 08/15] selftests: mptcp: userspace pm send
 RM_ADDR for ID 0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-send-net-next-2023107-v4-8-8d6b94150f6b@kernel.org>
References: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
In-Reply-To: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

This patch adds a selftest for userspace PM to remove id 0 address.

Use userspace_pm_add_addr() helper to add an id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 812a5ee54158..a98a72e55d2c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3538,6 +3538,32 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm send RM_ADDR for ID 0
+	if reset_with_events "userspace pm send RM_ADDR for ID 0" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_rm_addr $ns1 0
+		# we don't look at the counter linked to the subflows that
+		# have been removed but to the one linked to the RM_ADDR
+		chk_rm_nr 1 0 invert
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


