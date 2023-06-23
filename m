Return-Path: <netdev+bounces-13497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360CF73BDE1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675151C212E5
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA74C1078C;
	Fri, 23 Jun 2023 17:34:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC048100D4;
	Fri, 23 Jun 2023 17:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0BCC433C8;
	Fri, 23 Jun 2023 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687541657;
	bh=BAIs6j5r86K2HJ6Lclyqn1QeJZbAsufaqkracjeUiMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uxjnSZu1xlseAQpFuj+BECeDrG/IhoUY+EmsHCDrQEUe3uBzIGv9CQirDggGDsO8L
	 H5jWnJf/LXNRQOqP5Kuc/wBywCHkLaFSZdjdkERp26eRWQ+hCyU8YDr+bKM9GajHtB
	 bYLsg4ZWnlmqaxAC3JxR2UE1bBq+aOTdS/RCN0NPZ3BfW2RYCFpUaLnlri3S6KxU+m
	 Mp+LakdRr6QfP/mn8wXWwMwArrd/O6rGn32hsqGkGcmzp2Q9wVk12JwiSzvIeqGiIj
	 chehLbH/raZPJyQL3yHv9EERy/KVORrF5gcDyLL1QKx5q0tgpTHvn5yAz6IMoSQx3B
	 kpH6Mr1g8DdCg==
From: Mat Martineau <martineau@kernel.org>
Date: Fri, 23 Jun 2023 10:34:09 -0700
Subject: [PATCH net-next 3/8] selftests: mptcp: set FAILING_LINKS in
 run_tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230623-send-net-next-20230623-v1-3-a883213c8ba9@kernel.org>
References: <20230623-send-net-next-20230623-v1-0-a883213c8ba9@kernel.org>
In-Reply-To: <20230623-send-net-next-20230623-v1-0-a883213c8ba9@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.2

From: Geliang Tang <geliang.tang@suse.com>

Set FAILING_LINKS as an env var with a limited scope only when calling
run_tests().

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 95a56384294f..000c561bf622 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2177,9 +2177,9 @@ link_failure_tests()
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 2
-		FAILING_LINKS="1"
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 1
+		FAILING_LINKS="1" \
+			run_tests $ns1 $ns2 10.0.1.1 1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_link_usage $ns2 ns2eth3 $cinsent 0
@@ -2193,8 +2193,8 @@ link_failure_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		FAILING_LINKS="1 2"
-		run_tests $ns1 $ns2 10.0.1.1 1
+		FAILING_LINKS="1 2" \
+			run_tests $ns1 $ns2 10.0.1.1 1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 2 4 2
@@ -2209,8 +2209,8 @@ link_failure_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		FAILING_LINKS="1 2"
-		run_tests $ns1 $ns2 10.0.1.1 2
+		FAILING_LINKS="1 2" \
+			run_tests $ns1 $ns2 10.0.1.1 2
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 1 -1 2

-- 
2.41.0


