Return-Path: <netdev+bounces-55857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEEF80C8DC
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1816FB21543
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAA33985C;
	Mon, 11 Dec 2023 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWiuzW40"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A4638F9F
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 12:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40C8C433CB;
	Mon, 11 Dec 2023 12:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702296112;
	bh=p1Q6P5r70dYqRfq8o6P8nCDiH/7PU7JjoL/Pl4PGmWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XWiuzW404u7M/37jN16AEv/U4iiAp4bUdLiv0GfiMyXSWU8PSfXYfdiubZ6AfHz/X
	 CcsilK8PSLDr77UNYGaVa4vQU+kV3s6CT11+bRPJbihVzIZxeg5n8Ny3KPgLtgLSec
	 NoElBgBkC9yvz2ujJmadDRop+RrENuAio6phZXqv6Tv86CRrSXGCTinZKO9CVypPwh
	 QV5mznlpAMzcaQ1RD6ZtrkoyiKx8ktp6ZuRj8DhtzqEQ8PwEb9oBHgnnir8B6jnVf1
	 wjzuQ0vL//AEgnMbTHWo/q16mlP+wwkRus2PZwaL9gQjS4zajNVwj1/jrg0bLpaBB/
	 cJBPl+wybpN0Q==
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
	rogerq@kernel.org
Subject: [PATCH 2/2] selftests: forwarding: ethtool_mm: support devices that don't support pmac stats
Date: Mon, 11 Dec 2023 14:01:38 +0200
Message-Id: <20231211120138.5461-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211120138.5461-1-rogerq@kernel.org>
References: <20231211120138.5461-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices do not support individual 'pmac' and 'emac' stats.
For such devices, resort to 'aggregate' stats.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 tools/testing/selftests/net/forwarding/ethtool_mm.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
index 6212913f4ad1..e3f2e62029ca 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
@@ -26,6 +26,13 @@ traffic_test()
 	local delta=
 
 	before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOK" $src)
+	# some devices don't support individual pmac/emac stats,
+	# use aggregate stats for them.
+        if [ "$before" == null ]; then
+                src="aggregate"
+                before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOO
+K" $src)
+        fi
 
 	$MZ $if -q -c $num_pkts -p 64 -b bcast -t ip -R $PREEMPTIBLE_PRIO
 
-- 
2.34.1


