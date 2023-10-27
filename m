Return-Path: <netdev+bounces-44909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB847DA3D8
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA95C2824F7
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999EC4120C;
	Fri, 27 Oct 2023 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5ZTsYOh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ED5405FA;
	Fri, 27 Oct 2023 22:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292A4C433A9;
	Fri, 27 Oct 2023 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698447440;
	bh=bfJE6HiF3+FAp9zrybQcVB6vSbN1zDCfxLnLX/6Ihz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L5ZTsYOhNDvkfVtPMH7put5tndpNepNAXR3mWiDg/2Rjl/tVaLJLAizy4Iyfrq4xO
	 lQNQkpifmntKLhFY6Ce0p8DRbJHou3ztYYClhsepqn0LQHTcMvQ48pWq4Z5JBZW70i
	 O6anHgKiPZUmQchdty61jT/zcYNdSlPsWfmlZ7p+eQY36J/T3tHSMEuuLsNkZVokzC
	 EWV5PRCFOrFvtCr2+GMXSxkawPhfdicu1QaqBx3Vsj3BpcE7R3pKaRwSjUBbqOWOv5
	 y5Oq6XsriMQbt5Qa1zF1QbI0kzf7/dt6QPCVmhpoUv8fd15A0hbMWO6stqwCvngtUF
	 Oy85+qgFKr5RQ==
From: Mat Martineau <martineau@kernel.org>
Date: Fri, 27 Oct 2023 15:57:06 -0700
Subject: [PATCH net-next 05/15] selftests: mptcp: userspace pm create id 0
 subflow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-send-net-next-2023107-v1-5-03eff9452957@kernel.org>
References: <20231027-send-net-next-2023107-v1-0-03eff9452957@kernel.org>
In-Reply-To: <20231027-send-net-next-2023107-v1-0-03eff9452957@kernel.org>
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


