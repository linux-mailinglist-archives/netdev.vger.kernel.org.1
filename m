Return-Path: <netdev+bounces-13500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C173873BDE6
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C58C1C212E9
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E6C1095C;
	Fri, 23 Jun 2023 17:34:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF2101CF;
	Fri, 23 Jun 2023 17:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F76C433CC;
	Fri, 23 Jun 2023 17:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687541658;
	bh=W2fdyA4RdEQXA1/jIZkMTm630uJU1gM3Og9vKfmlgTQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dBkTamGaSlnNEjG7HR21+++a+BLvPPp9Cyov7fMAO0BhTDfXMq3yOFuMo0T9rBTka
	 Jtgp3zJsObCct0CNQTIv6Gt56/fKmDweD4QgpbF2SpfndvMx3ziBvQmn+HCDgtWvww
	 E1cjocPmfOJfZppFt31uPOhBG2sFnTPT9lzxTScdNpqJ90CAyZ6dohPf+38kgmVINn
	 X9z6AUfBK/fbK3CR+CGjBAVqVRKspX+R8p0M3g0qRp9ZQGVCwAk6tVkJOl/qhk21w7
	 g6RjDUv32DbwVgdh4f8zZW/Ervz2bYEYjDLv9oZ2G2Nc5Sba2Zf9vZcXlJ3M6/8TZZ
	 hSv7Gqx37jkFQ==
From: Mat Martineau <martineau@kernel.org>
Date: Fri, 23 Jun 2023 10:34:12 -0700
Subject: [PATCH net-next 6/8] selftests: mptcp: drop sflags parameter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230623-send-net-next-20230623-v1-6-a883213c8ba9@kernel.org>
References: <20230623-send-net-next-20230623-v1-0-a883213c8ba9@kernel.org>
In-Reply-To: <20230623-send-net-next-20230623-v1-0-a883213c8ba9@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.2

From: Geliang Tang <geliang.tang@suse.com>

run_tests() accepts too many optional parameters. Before this modification,
it was required to set all of then when only the last one had to be
changed. That's not clear to see all these 0 and it makes the maintenance
harder:

      run_tests $ns1 $ns2 10.0.1.1 1 2 3 slow

Instead, the parameter can be set as an env var with a limited scope:

      foo=1 bar=2 next=3 \
            run_tests $ns1 $ns2 10.0.1.1 slow

This patch switches to key/value "sflags=*" instead of positional parameter
sflags of do_transfer() and run_tests().

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 39 ++++++++++++++-----------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 93f941fd51f2..5cb66f85c88f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -53,6 +53,7 @@ export FAILING_LINKS=""
 export test_linkfail=0
 export addr_nr_ns1=0
 export addr_nr_ns2=0
+export sflags=""
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -829,7 +830,6 @@ do_transfer()
 	local srv_proto="$4"
 	local connect_addr="$5"
 	local speed="$6"
-	local sflags="${7}"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
@@ -1147,7 +1147,6 @@ run_tests()
 	local connector_ns="$2"
 	local connect_addr="$3"
 	local speed="${4:-fast}"
-	local sflags="${5:-""}"
 
 	local size
 
@@ -1191,8 +1190,7 @@ run_tests()
 		make_file "$sinfail" "server" $size
 	fi
 
-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${speed} ${sflags}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${speed}
 }
 
 dump_stats()
@@ -2687,7 +2685,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 slow nobackup
+		sflags=nobackup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2698,7 +2697,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2710,7 +2710,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2736,7 +2737,8 @@ backup_tests()
 	if reset "mpc switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2745,7 +2747,8 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -3120,8 +3123,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow fullmesh
+		addr_nr_ns2=1 sflags=fullmesh \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3132,8 +3135,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=fullmesh_1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow nofullmesh
+		addr_nr_ns2=fullmesh_1 sflags=nofullmesh \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3144,8 +3147,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=1 run_tests \
-			$ns1 $ns2 10.0.1.1 slow backup,fullmesh
+		addr_nr_ns2=1 sflags=backup,fullmesh \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3157,7 +3160,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 slow nobackup,nofullmesh
+		sflags=nobackup,nofullmesh \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3332,7 +3336,8 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi

-- 
2.41.0


