Return-Path: <netdev+bounces-51894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F937FCAAD
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F13B215D3
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F95915C;
	Tue, 28 Nov 2023 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnzU9NMM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ACF58AC2;
	Tue, 28 Nov 2023 23:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E9FC433CA;
	Tue, 28 Nov 2023 23:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701213563;
	bh=Jv4RGt/HbPFT2xzKIHcm3F2VRGKa/g8ZrBp8a7B7iWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KnzU9NMMk5lKFkbFb50YHt49OVFagqcvme3jNMOwamanhtSsTZ/ek+/hEqUzkqwdv
	 aVDjCf+H/bWIN3ud35qGgZGrg6iVF3kygNfMhPBKni484cCThAPsK/NhzLPFEMpajL
	 DyP+wB3hcI9S8mo+iRTpbq0AyFbck80enT2uFyL/EQyO1FNY016IRx0oWZ+sORxpqp
	 7qw1Zi6kUVdnKI7BpS5iRkBzKCzvBnxUuhSP0rEd+dv5fGRKvVhyAFSb4iRqAPCQ7u
	 xx6elbSp+ww13GVtxRfC56zov+Cblwp8TS29PA4KJD2v29kuDSSYmoeNjraLIrmnCG
	 SQpBnIRi+XqXw==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 28 Nov 2023 15:18:47 -0800
Subject: [PATCH net-next v4 03/15] selftests: mptcp: add chk_subflows_total
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-send-net-next-2023107-v4-3-8d6b94150f6b@kernel.org>
References: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
In-Reply-To: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

This patch adds a new helper chk_subflows_total(), in it use the newly
added counter mptcpi_subflows_total to get the "correct" amount of
subflows, including the initial one.

To be compatible with old 'ss' or kernel versions not supporting this
counter, get the total subflows by listing TCP connections that are
MPTCP subflows:

    ss -ti state state established state syn-sent state syn-recv |
        grep -c tcp-ulp-mptcp.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 42 ++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d24b0e5e73ef..566fa0f6506f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1867,7 +1867,7 @@ chk_mptcp_info()
 	local cnt2
 	local dump_stats
 
-	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
+	print_check "mptcp_info ${info1:0:15}=$exp1:$exp2"
 
 	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
 	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
@@ -1888,6 +1888,42 @@ chk_mptcp_info()
 	fi
 }
 
+# $1: subflows in ns1 ; $2: subflows in ns2
+# number of all subflows, including the initial subflow.
+chk_subflows_total()
+{
+	local cnt1
+	local cnt2
+	local info="subflows_total"
+	local dump_stats
+
+	# if subflows_total counter is supported, use it:
+	if [ -n "$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value $info $info)" ]; then
+		chk_mptcp_info $info $1 $info $2
+		return
+	fi
+
+	print_check "$info $1:$2"
+
+	# if not, count the TCP connections that are in fact MPTCP subflows
+	cnt1=$(ss -N $ns1 -ti state established state syn-sent state syn-recv |
+	       grep -c tcp-ulp-mptcp)
+	cnt2=$(ss -N $ns2 -ti state established state syn-sent state syn-recv |
+	       grep -c tcp-ulp-mptcp)
+
+	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
+		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
+		dump_stats=1
+	else
+		print_ok
+	fi
+
+	if [ "$dump_stats" = 1 ]; then
+		ss -N $ns1 -ti
+		ss -N $ns2 -ti
+	fi
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -3431,10 +3467,12 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3451,9 +3489,11 @@ userspace_tests()
 		userspace_pm_add_sf 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
 		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi

-- 
2.43.0


