Return-Path: <netdev+bounces-44912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D6E7DA3DB
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09759B2145A
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DFB41235;
	Fri, 27 Oct 2023 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOLtZ7re"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9D41230;
	Fri, 27 Oct 2023 22:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28A0C433BD;
	Fri, 27 Oct 2023 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698447440;
	bh=T1r+5rFukXYSQtyoFZ71FJEbFqecAb3fG9hUGf4rVBo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cOLtZ7rejb9IyljGvRLftJPWkIsuhJfWiok6R9xPoxGh3/vm9HZ+qOKIEgSYsVFMo
	 mEXK3cPHx60itU+WfWITAjnxeUCQt9Z9BWkNcoiFbpCKud/1swqZDrJS+KiBHfwgiY
	 d+qU9iG8CCVlm42RJcoX9ofCs8P57B2UmS14ZcIEdNRoFpHKBlI+Gs6pGicirlKOtS
	 ewE8D3wAcwwOzjIxLOVhNRNsk/dzgAHEcu6Rmjp32YWTWtEM76apK0EjgxGrktNc9L
	 /0g4CxBkpNeCVHTbd8QMYHa58uSm4exjhe//PQC6gerLm4ZjJ9z4I9pLZMXRgNOB45
	 XCzaTWmc9fPIQ==
From: Mat Martineau <martineau@kernel.org>
Date: Fri, 27 Oct 2023 15:57:08 -0700
Subject: [PATCH net-next 07/15] selftests: mptcp: userspace pm remove
 initial subflow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-send-net-next-2023107-v1-7-03eff9452957@kernel.org>
References: <20231027-send-net-next-2023107-v1-0-03eff9452957@kernel.org>
In-Reply-To: <20231027-send-net-next-2023107-v1-0-03eff9452957@kernel.org>
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
index 6c2c47ce11ad..68fb7aa12fef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3513,6 +3513,30 @@ userspace_tests()
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
2.41.0


