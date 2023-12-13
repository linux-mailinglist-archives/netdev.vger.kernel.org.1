Return-Path: <netdev+bounces-56830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A876810F62
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21084B20BEC
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B261223745;
	Wed, 13 Dec 2023 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa0VNslk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699A23740
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 11:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAE9C433CC;
	Wed, 13 Dec 2023 11:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702465656;
	bh=T2+UW0wgOJD87vUUjL4c6NPMZ4qFsnH4UJdV5sl8DqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xa0VNslkNhmR80Aij3XQF2RBSUcV1gOOD61N9nIpQTmB3ma72+qB6pi5ulJ3zmqtq
	 OtPM5IVnPnWDUJMtyo/BIyLUunnullqfXLInohBQL7BT+engf2dP0W7bMEtU+WCOMC
	 5YfoyH2eyqUeEFfzEkB68VcAzQmkgyQc2k2OEft5htfDtnc8yZFUkh96kA8JFjAACL
	 h9DwvR3BRBodbgtx1JyTUVucrUgouh31fSZvgUeYBhwNey1dkQWe+pylowJ7JWucTa
	 kWna6ZQmgQwlsEPPwMomOUD+qK117tYU6jsQn3gokCmYq0KWUWc+GdjN0Ol/ggVYB8
	 2yKaEXQ1Phouw==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	vladimir.oltean@nxp.com
Cc: s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rogerq@kernel.org
Subject: [PATCH v8 net-next 02/11] selftests: forwarding: ethtool_mm: fall back to aggregate if device does not report pMAC stats
Date: Wed, 13 Dec 2023 13:07:12 +0200
Message-Id: <20231213110721.69154-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213110721.69154-1-rogerq@kernel.org>
References: <20231213110721.69154-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Some devices do not support individual 'pmac' and 'emac' stats.
For such devices, resort to 'aggregate' stats.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 tools/testing/selftests/net/forwarding/ethtool_mm.sh | 11 +++++++++++
 tools/testing/selftests/net/forwarding/lib.sh        |  9 +++++++++
 2 files changed, 20 insertions(+)

Changelog:

v8: initial commit

diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
index 6212913f4ad1..50d5bfb17ef1 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
@@ -25,6 +25,10 @@ traffic_test()
 	local after=
 	local delta=
 
+	if [ ${has_pmac_stats[$if]} = false ]; then
+		src="aggregate"
+	fi
+
 	before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOK" $src)
 
 	$MZ $if -q -c $num_pkts -p 64 -b bcast -t ip -R $PREEMPTIBLE_PRIO
@@ -317,6 +321,13 @@ for netif in ${NETIFS[@]}; do
 		echo "SKIP: $netif does not support MAC Merge"
 		exit $ksft_skip
 	fi
+
+	if check_ethtool_pmac_std_stats_support $netif eth-mac; then
+		has_pmac_stats[$netif]=true
+	else
+		has_pmac_stats[$netif]=false
+		echo "$netif does not report pMAC statistics, falling back to aggregate"
+	fi
 done
 
 trap cleanup EXIT
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8f6ca458af9a..763c262a3453 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -146,6 +146,15 @@ check_ethtool_mm_support()
 	fi
 }
 
+check_ethtool_pmac_std_stats_support()
+{
+	local dev=$1; shift
+	local grp=$1; shift
+
+	[ 0 -ne $(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null \
+		| jq '.[]."$grp" | length') ]
+}
+
 check_locked_port_support()
 {
 	if ! bridge -d link show | grep -q " locked"; then
-- 
2.34.1


