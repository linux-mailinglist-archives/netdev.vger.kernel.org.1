Return-Path: <netdev+bounces-47822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 996677EB717
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39879B20B51
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420532FC5A;
	Tue, 14 Nov 2023 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beGXNqHF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9D2FC50;
	Tue, 14 Nov 2023 19:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7144C433B9;
	Tue, 14 Nov 2023 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699991905;
	bh=sdH8xmk4MXjKYREeXMVQSHlX4S7XdC6spelvmax2HHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=beGXNqHFSeSafmzk25u70N9+hVb3b57qzYWEvDPYd/a6w/fGkX3R4xvQyh6wGZxMO
	 EwWvOlf2qHFxvMmGZVGb+lEb1yEYg1YWdWv0GlruJasp+iWyiFOAUFniVHZYEIKAmu
	 xssbHgF7YC3v9I8z8JaovXBNvWeXMjZqJeBad3tcWMoCJad5X82w7SAf/PbXY5BJi/
	 SzByUhGPasxNgsyaCFkz5ziYrY5NymVo9dLFjSBy2pU9hYB0TlJIDoxFJGj9/7A8oA
	 JeDNZzuYRgUuQbAzKuVtknDNpS46jo6s8mFg23Ozglksvl+xK+JiMLEN93UZqdf5+8
	 idrklOS2RfHzg==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 14 Nov 2023 11:56:50 -0800
Subject: [PATCH net-next v2 08/15] selftests: mptcp: userspace pm send
 RM_ADDR for ID 0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-send-net-next-2023107-v2-8-b650a477362c@kernel.org>
References: <20231114-send-net-next-2023107-v2-0-b650a477362c@kernel.org>
In-Reply-To: <20231114-send-net-next-2023107-v2-0-b650a477362c@kernel.org>
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
index 68fb7aa12fef..a2b58cf71bef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3537,6 +3537,32 @@ userspace_tests()
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
2.41.0


