Return-Path: <netdev+bounces-51895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD417FCAAE
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3931C20CBF
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4561E5C3C4;
	Tue, 28 Nov 2023 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWUVx0OU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE55C08D;
	Tue, 28 Nov 2023 23:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59A4C433CC;
	Tue, 28 Nov 2023 23:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701213563;
	bh=zQBP+gO/zNtR8Z2rDy2qVbB1lybcc8PLIpGPvXHYkIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gWUVx0OUjlSZHkHWD7ZiYSUZG8QTha2jMO6hkvi9TIXOpE4tQBDaL3xoGJBaJkkzl
	 GiawVWF43rpjVlLVVd1OInOKn7Ks5AVnUIiZkW3ws5P4s5Nz90TtKQrAudb1uRuTPo
	 hxHXXZ96iAw+xcBCdvAzGDiUtnuX2wVWXJ4H8Mo0HWu3ZTSuiRbTWGNO8FHwtu7+un
	 GkT/CZ11wjSZvZ5SXnOyN2g+Br84AE8HQdTipVgt25pGdV3APrabw99bf3kkBdQji6
	 mqfTPEdB8iPkjuAl0kPmCWdY5a2jqUkBt35XGINJkrwv92q1aw8aPhAOfmXuRgGDvl
	 s5cUvN5OG3R3Q==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 28 Nov 2023 15:18:49 -0800
Subject: [PATCH net-next v4 05/15] selftests: mptcp: userspace pm create id
 0 subflow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-send-net-next-2023107-v4-5-8d6b94150f6b@kernel.org>
References: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
In-Reply-To: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
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
index 6d84c7f5296a..4357a46ca3f3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3495,6 +3495,25 @@ userspace_tests()
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
2.43.0


