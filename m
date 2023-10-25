Return-Path: <netdev+bounces-44315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B87F7D78B0
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2DBB21262
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65641381B1;
	Wed, 25 Oct 2023 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc2Y6oJJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A86381A8;
	Wed, 25 Oct 2023 23:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CF9C43395;
	Wed, 25 Oct 2023 23:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698277032;
	bh=oWhq8MDM3cTZAxpiFQKriinw5wYjuNCtFlUpEjC9Uyo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sc2Y6oJJ0/ZX36ftASStFjvoiI+/oBiksikRUXfbpAXyiCPtlvUs204jbwGpob+1P
	 ntnbDWykcMzJfw4yQLDegNeLy2qghX7aCQpaqXYmci9trW5SGZ24eOVuryZCafk9R4
	 GuMCOV5qeWw6HvF+X76cyfFhvgk9Iu8DHdxsDTQ7em0pfKkkz+ToRl2BjKk/Vi62KR
	 yj56DYryYbOw3/6ewgz88ZzNtfcLpTI0qBD4jckGXfeDlqiOdIQ/PZZtrPkmjYuu9K
	 hxWSpLf616g/K/QsAP/RUxWZQqE2xD9itTMBi7L4L3OlEOH3A+wVo3KSjR5Kbe5Lda
	 Cq6IHaPiWqxKg==
From: Mat Martineau <martineau@kernel.org>
Date: Wed, 25 Oct 2023 16:37:03 -0700
Subject: [PATCH net-next 02/10] selftests: mptcp: fix wait_rm_addr/sf
 parameters
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-send-net-next-20231025-v1-2-db8f25f798eb@kernel.org>
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

The second input parameter of 'wait_rm_addr/sf $1 1' is misused. If it's
1, wait_rm_addr/sf will never break, and will loop ten times, then
'wait_rm_addr/sf' equals to 'sleep 1'. This delay time is too long,
which can sometimes make the tests fail.

A better way to use wait_rm_addr/sf is to use rm_addr/sf_count to obtain
the current value, and then pass into wait_rm_addr/sf.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Cc: stable@vger.kernel.org
Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index edc569bab4b8..5917a74b749d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3289,6 +3289,7 @@ userspace_pm_rm_sf_addr_ns1()
 	local addr=$1
 	local id=$2
 	local tk sp da dp
+	local cnt_addr cnt_sf
 
 	tk=$(grep "type:1," "$evts_ns1" |
 	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
@@ -3298,11 +3299,13 @@ userspace_pm_rm_sf_addr_ns1()
 	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
 	dp=$(grep "type:10" "$evts_ns1" |
 	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt_addr=$(rm_addr_count ${ns1})
+	cnt_sf=$(rm_sf_count ${ns1})
 	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
 	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
 				lport $sp rip $da rport $dp token $tk
-	wait_rm_addr $ns1 1
-	wait_rm_sf $ns1 1
+	wait_rm_addr $ns1 "${cnt_addr}"
+	wait_rm_sf $ns1 "${cnt_sf}"
 }
 
 userspace_pm_add_sf()
@@ -3324,17 +3327,20 @@ userspace_pm_rm_sf_addr_ns2()
 	local addr=$1
 	local id=$2
 	local tk da dp sp
+	local cnt_addr cnt_sf
 
 	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
 	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
 	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
 	sp=$(grep "type:10" "$evts_ns2" |
 	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt_addr=$(rm_addr_count ${ns2})
+	cnt_sf=$(rm_sf_count ${ns2})
 	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
 	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
 				rip $da rport $dp token $tk
-	wait_rm_addr $ns2 1
-	wait_rm_sf $ns2 1
+	wait_rm_addr $ns2 "${cnt_addr}"
+	wait_rm_sf $ns2 "${cnt_sf}"
 }
 
 userspace_tests()

-- 
2.41.0


