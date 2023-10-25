Return-Path: <netdev+bounces-44314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC4F7D78AE
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97417281E2E
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24915381A0;
	Wed, 25 Oct 2023 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmbo5JNV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F097737CBC;
	Wed, 25 Oct 2023 23:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8BBC433CD;
	Wed, 25 Oct 2023 23:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698277032;
	bh=0Di+LDA6poLyY50CFcEryH1kp7/yqPYEEUiE9SfuaPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cmbo5JNVyaW/IMkAJa+6RusWM9N0ru0TCxXGI+DfwBfaUeDWIqPtCaQ+myJYogy00
	 trgxp8HObXoAnejNNNj8yJwkkfRhJHmicOTWKVw8zCE61wB9bLh3FRaDmhdqUd1Y5m
	 orjbra2cApx+QiL/QZ3sjZ+o9PB67t2vPklVDGUUVQHH03/fpPRKgNSe52yMFss6CU
	 N1TbX3RqI9GYFPdjo4zf1HQ6hV/CoyM52IkUxbt+uw9igQvOGofk+A84l1pbMLzsWy
	 ehHjHxBfzUnVpH8j91FTv7oIo9Q5nwPa7n5rvLrnnviLpxOYV8mnyCQnz+z/ut8QoG
	 YhoGM5VZvkZKw==
From: Mat Martineau <martineau@kernel.org>
Date: Wed, 25 Oct 2023 16:37:02 -0700
Subject: [PATCH net-next 01/10] selftests: mptcp: run userspace pm tests
 slower
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-send-net-next-20231025-v1-1-db8f25f798eb@kernel.org>
References: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
In-Reply-To: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

Some userspace pm tests failed are reported by CI:

112 userspace pm add & remove address
      syn                                 [ ok ]
      synack                              [ ok ]
      ack                                 [ ok ]
      add                                 [ ok ]
      echo                                [ ok ]
      mptcp_info subflows=1:1             [ ok ]
      subflows_total 2:2                  [ ok ]
      mptcp_info add_addr_signal=1:1      [ ok ]
      rm                                  [ ok ]
      rmsf                                [ ok ]
      Info: invert
      mptcp_info subflows=0:0             [ ok ]
      subflows_total 1:1                  [fail]
                         got subflows 0:0 expected 1:1
Server ns stats
TcpPassiveOpens                 2                  0.0
TcpInSegs                       118                0.0

This patch fixes them by changing 'speed' to 5 to run the tests much more
slowly.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Cc: stable@vger.kernel.org
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index dc895b7b94e1..edc569bab4b8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3417,7 +3417,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		speed=10 \
+		speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
@@ -3438,7 +3438,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		speed=10 \
+		speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2

-- 
2.41.0


