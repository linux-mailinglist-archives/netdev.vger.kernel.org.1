Return-Path: <netdev+bounces-249726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B231FD1CBA9
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 07:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 265C5303788D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 06:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C2136E496;
	Wed, 14 Jan 2026 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmK5eLTd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A434CFAD
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373413; cv=none; b=jcYxk+XipwyMAMKrfFFpfxD0HHxYpuKS7xJtGKbj5kP6QGxWEPn8D96LlwUiJpJwXPINPzW5HD27TPh7uXW+kjFLGir/W1wGx10zKi8+poNz7KPv5MVnwETFkhFLhz7cI8xIGdKJRBjJ+wEPv6ZVFkSAg/adoZLtcceZ84VAD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373413; c=relaxed/simple;
	bh=gjny3v/eTWHbeutrMbxDNE40G5kG1Ylj5usbZJzU9HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmHHnCF8aRskyhIBcb/RH8oh50M0VAaIwb7kroRdTSSdbXxeIGJYfReDm3jbapdD4Ffmh3+g6ywjCGNPYOonyfzY8X3x/jk96wlxK1hcq+LtSGKswiIppVQT9yV+KFgYMRw5R9e8HgioKOL/LZPl+gjT3JUMcmSbppJiZCoEKdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmK5eLTd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29f30233d8aso54859105ad.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768373401; x=1768978201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUrXcfq9vgrgpVWA1902DBETXrF91GneB4Umctz9Jao=;
        b=PmK5eLTdY6j4wVv2M7NUvo1c/plrC9mkDenDmKV4dNK24GPj5OS/FIZIWUc5DzU0LB
         zItpJQe6x2aMeAcsY9qsvpXnAztoNh3+AWrRAeliOurbjKifSdKYkO4PtDReSJdL6nx4
         kHMV62Dt0VFG+KQ7Fnr5uXeJlzmCICuUCu6azAnIm7gixCcxxziNoeVM1YB2At4jXxO/
         kfpMzH2xcj6so0WBBNrz8fIOc5/IusrL0p9N6WNVZthiuTdtEcdjlbcLi9/3WR6stpZK
         qHTb4JWDH0FWuZ9M8G4gASXwr81hD1kqnM6po3w/tjRgu0zUn7kucTLbI95qrSGshGrM
         lRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768373401; x=1768978201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUrXcfq9vgrgpVWA1902DBETXrF91GneB4Umctz9Jao=;
        b=kprj6SzzOWiVKN/oy5COJBtxOUdo+TvqTY88QfepYV1SFk0fgp5dqyaPKoUhQP22kP
         cMX+RvRKpyFBm5koGQSyb9ucwonDTbRfvilrh0RKMZRd/KMCGS/0Z3gcg5YFEnIKnYlh
         O4IOw/TKAE2gTVjalWghM3aB42wa1F6f290Jt0YNYEyIBsE6mxUSQC3GSQiYwMr/lpy6
         aoGTAX6cgXjM6TvI6zhN0nqvkx/myrh1woNInQfsDnDclVTKYIPEXJKaUfnEwq51vTEf
         fjRFSm9I+3Fdfl3KPiukUPVRWYWtuW8jm2jcHh1s5aA3FC69haSrDCwHXLqSpXKh3wMM
         AsRQ==
X-Gm-Message-State: AOJu0YyC1teAuQuhz+8Ei6cIOVyPbZRgl+SjyPqdEEe8+D31y1HCx3yI
	V3pcjaGWs3e1XV8kAtSL+gENf4Itswdrc98O0f6YYCrD6MYOlrvVLYXlerCMfjlC
X-Gm-Gg: AY/fxX68LTbSdpSFtIOIWjDuP2B4Bg9EBkOxS1HjJspVV4+zHWSAKpys8/J7NusflFj
	/bsl4ZLgCTMuYInkzRF2mhcBrPPgkU/b/h/RYK1L7z9RnQjZWv1tX7JEYOnFXKISTO3lIhYa+LY
	rle117X9Nwux5LPNLRdr7QKZ2XVz7JcWF/TKU0Gzq5Dw/mj+37+qMNh23bCVHAVtYpljAuSbNnY
	OfIPoc4aAN6S6w3tbKg40eC1/FtE84DwURA6OgANStf5znWCugcj2uv7YnRnYnugrqrVE97STA4
	cKQelU4gdkaWNAkKB2BJPr1A3r+Nm9MeZsErFDW6nLy00B3OLW+iYBC+OzJoOBpIrhJe9foH3Ht
	QpZJjkG+oAiI+RAq3uN615pjdr691F6dQpZlWJsO3z6b3UcH+PwZYnTxxYMZEAsRU7vKOTHfXp5
	sMpXGtE9+WmUIdbJG3K78Imklpqw==
X-Received: by 2002:a17:902:f78b:b0:2a0:fe9f:1884 with SMTP id d9443c01a7336-2a599e585d5mr19091275ad.55.1768373400756;
        Tue, 13 Jan 2026 22:50:00 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492fsm96315525ad.98.2026.01.13.22.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 22:50:00 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 3/3] selftests: bonding: add mux and churn state testing
Date: Wed, 14 Jan 2026 06:49:21 +0000
Message-ID: <20260114064921.57686-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114064921.57686-1-liuhangbin@gmail.com>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the current LACP priority test to LACP ad_select testing, and
extend it to include validation of the actor state machine and churn
state logic. The updated tests verify that both the mux state machine and
the churn state machine behave correctly under aggregator selection and
failover scenarios.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/drivers/net/bonding/Makefile    |  2 +-
 ...nd_lacp_prio.sh => bond_lacp_ad_select.sh} | 73 +++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)
 rename tools/testing/selftests/drivers/net/bonding/{bond_lacp_prio.sh => bond_lacp_ad_select.sh} (64%)

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 6c5c60adb5e8..e7bddfbf0f7a 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -7,7 +7,7 @@ TEST_PROGS := \
 	bond-eth-type-change.sh \
 	bond-lladdr-target.sh \
 	bond_ipsec_offload.sh \
-	bond_lacp_prio.sh \
+	bond_lacp_ad_select.sh \
 	bond_macvlan_ipvlan.sh \
 	bond_options.sh \
 	bond_passive_lacp.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_ad_select.sh
similarity index 64%
rename from tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
rename to tools/testing/selftests/drivers/net/bonding/bond_lacp_ad_select.sh
index a483d505c6a8..9f0b3de4f55c 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_ad_select.sh
@@ -89,6 +89,65 @@ test_agg_reselect()
 		RET=1
 }
 
+is_distributing()
+{
+	ip -j -n "$c_ns" -d link show "$1" \
+		| jq -e '.[].linkinfo.info_slave_data.ad_actor_oper_port_state_str | index("distributing")' > /dev/null
+}
+
+get_churn_state()
+{
+	local slave=$1
+	# shellcheck disable=SC2016
+	ip netns exec "$c_ns" awk -v s="$slave" '
+	$0 ~ "Slave Interface: " s {found=1}
+	found && /Actor Churn State:/ { print $4; exit }
+	' /proc/net/bonding/bond0
+}
+
+check_slave_state()
+{
+	local state=$1
+	local slave_0=$2
+	local slave_1=$3
+	local churn_state
+	RET=0
+
+	s0_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show $slave_0" \
+		".[].linkinfo.info_slave_data.ad_aggregator_id")
+	s1_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show $slave_1" \
+		".[].linkinfo.info_slave_data.ad_aggregator_id")
+	if [ "${s0_agg_id}" -ne "${s1_agg_id}" ]; then
+		log_info "$state: $slave_0 $slave_1 agg ids are different"
+		RET=1
+	fi
+
+	for s in "$slave_0" "$slave_1"; do
+		churn_state=$(get_churn_state "$s")
+		if [ "$state" = "active" ]; then
+			if ! is_distributing "$s"; then
+				log_info "$state: $s is not in distributing state"
+				RET=1
+			fi
+			if [ "$churn_state" != "none" ]; then
+				log_info "$state: $s churn state $churn_state"
+				RET=1
+			fi
+		else
+			# Backup state, should be in churned and not distributing
+			if is_distributing "$s"; then
+				log_info "$state: $s is in distributing state"
+				RET=1
+			fi
+			if [ "$churn_state" != "churned" ]; then
+				log_info "$state: $s churn state $churn_state"
+				# shellcheck disable=SC2034
+				RET=1
+			fi
+		fi
+	done
+}
+
 trap cleanup_all_ns EXIT
 setup_ns c_ns s_ns b_ns
 setup_links
@@ -98,11 +157,25 @@ log_test "bond 802.3ad" "actor_port_prio setting"
 
 test_agg_reselect eth0
 log_test "bond 802.3ad" "actor_port_prio select"
+# sleep for a while to make sure the mux state machine has completed.
+sleep 10
+check_slave_state active eth0 eth1
+log_test "bond 802.3ad" "active state/churn checking"
+# wait for churn timer expired, need a bit longer as we restart eth1
+sleep 55
+check_slave_state backup eth2 eth3
+log_test "bond 802.3ad" "backup state/churn checking"
 
 # Change the actor port prio and re-test
 ip -n "${c_ns}" link set eth0 type bond_slave actor_port_prio 10
 ip -n "${c_ns}" link set eth2 type bond_slave actor_port_prio 1000
 test_agg_reselect eth2
 log_test "bond 802.3ad" "actor_port_prio switch"
+sleep 10
+check_slave_state active eth2 eth3
+log_test "bond 802.3ad" "active state/churn checking"
+sleep 55
+check_slave_state backup eth0 eth1
+log_test "bond 802.3ad" "backup state/churn checking"
 
 exit "${EXIT_STATUS}"
-- 
2.50.1


