Return-Path: <netdev+bounces-47820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2D87EB714
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950741F25965
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012A52FC47;
	Tue, 14 Nov 2023 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfQOYebO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9552FC36;
	Tue, 14 Nov 2023 19:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E360FC433CC;
	Tue, 14 Nov 2023 19:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699991905;
	bh=bfJE6HiF3+FAp9zrybQcVB6vSbN1zDCfxLnLX/6Ihz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sfQOYebOEn5u3mMwWTsIUUQMH2QGRJA+zNLxaCd6mOS09ZPuHjI8GD6j4tvGOMhJB
	 KjUgQsW9u+29EPAXgHbkWRF9K3/b6ZdDDdE6clvlkEd0w2J0bzyLMo0SA3v7XLFIdT
	 lbj8UjQJvHfE5UkFkDur6/UYKmB8k/DCNbG54uSGBBlErnqVXRrje8YuKp2MwlNqI5
	 r3FYNS2+FyEpGgwwPhb3CwgFpf76aiE2+D2/VMdruFZP5KhDBU6a1ZO00UaKA7J80a
	 Ulf9r/EL82vGsdibmh8Sy7n6HplUTO9M1jN4CtR7zFZuyCABUgcmY3sv91D5fShG2T
	 JoUr/UNiNRA/w==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 14 Nov 2023 11:56:47 -0800
Subject: [PATCH net-next v2 05/15] selftests: mptcp: userspace pm create id
 0 subflow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-send-net-next-2023107-v2-5-b650a477362c@kernel.org>
References: <20231114-send-net-next-2023107-v2-0-b650a477362c@kernel.org>
In-Reply-To: <20231114-send-net-next-2023107-v2-0-b650a477362c@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

This patch adds a selftest to create id 0 subflow. Pass id 0 to the
helper userspace_pm_add_sf() to create id 0 subflow. chk_mptcp_info
shows one subflow but chk_subflows_total shows two subflows in each
namespace.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 494aee8574fb..6c2c47ce11ad 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3494,6 +3494,25 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm create id 0 subflow
+	if reset_with_events "userspace pm create id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 0
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()

-- 
2.41.0


