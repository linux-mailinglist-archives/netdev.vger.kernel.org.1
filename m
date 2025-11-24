Return-Path: <netdev+bounces-241094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7298CC7EF2C
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 05:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC5C3A19D1
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 04:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC6E296BBA;
	Mon, 24 Nov 2025 04:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncS9EfQm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7E24F5E0
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763958846; cv=none; b=DffK8a8pDf7aIA9n30Kl9PQ1cj9uEO9zAvNUC3ihPiR2MwbNG8VBqSc0VxJUx5TYzc6uyis95MKlqdYuRZUNHe6LKJ23jV0qjeKT8nfDmsAfqDO+pBGXNqsaawZuDMFVGKLygvnEzMpk8LiDha1WYNBdD7jM8Hl7iCOa6vfTA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763958846; c=relaxed/simple;
	bh=gjny3v/eTWHbeutrMbxDNE40G5kG1Ylj5usbZJzU9HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWzyfi9q0ezGFeQ21adPn0blhxJCaZbexv9u6u33v4ycCc0d/L5lBYGI//H+zhJJbG7Mjc5DC98c0cjUYBByXxuJxex9w9enMu2ivJKpP3qPzgvLIyXyUZE59QotLcuCDYp8AUHfUpGrWyAXmYexVpKonxdo8HI3l0s40JRVAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncS9EfQm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343f35d0f99so3113508a91.0
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 20:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763958844; x=1764563644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUrXcfq9vgrgpVWA1902DBETXrF91GneB4Umctz9Jao=;
        b=ncS9EfQmiMFL266TefhElJaMkKhf5pc67o85sqgo6BMeEyfxxiazVjuVtgVO30wLwR
         s1z0mqDDeWfWAnUiAB5PXUiZLlKTEho7zVncEzunfU+ZSTP3j9tMyW2JiyJZcXF8ajiB
         o1Jj7YInBi27/SF/rhi7nutErWdbnbRVmUdPkCQYG+zIuOJc67gbSZMiLgAfiHIh5ASh
         APBPcu6EccZW6OLqa5ABa0zKK+fL1lNXhUPrNNlGMuVHGo9pJIdz4jiPku1Esw7JZwZm
         a0ZRMJOZYG3C5BMclJ7rrBER3uW0foEd4RWQPEKGosNSjo9U0zEuT8jxOB/XMpe7mhRa
         y5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763958844; x=1764563644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUrXcfq9vgrgpVWA1902DBETXrF91GneB4Umctz9Jao=;
        b=cnCLSFEjRTgEmq6vJv6hQT2WeZtV/N9QelG34AsQ0PaKUOPPEIWJiAraGpZI6Ts/Fx
         5wv9QOQwHncIVuDlfa2uck9AE7yI8mCTaTc7bdqw6jpjnfSjpkel9ieFKmLpfmUHdJbg
         oFhVVPNf9tKfkHw+4JOQQ4WiFKVEFbBz6mkd0DXHw9C1PQeyL8kS206/UGOj/cyd1CdP
         Q4JWqN5uRsqwXyqt+KaRLEy0I6Jas9klgX4DEBk56M1jS+Yzq5U2Jcam+iGNs+R68cyH
         30R8bWj94At5DgLKdZW1MoISy3Be6+KqdOoPlyTt2VfR9yHAD/TlhTpVERdGGKj8PE0E
         2o2w==
X-Gm-Message-State: AOJu0Yz/RRFSEoZIKMbUs0gCq9Idb6uVFM8Gi9AvCOV2NM/X4WZl7k/F
	WYd/b6lnTz7n4bAFnMSyTTbYqYepybXqQSsNFdgCtkFJyxgiXhntjceEddLypN51
X-Gm-Gg: ASbGncsDMa7eGm/ZcUcU6cVeXSCerXCA6T7Gpt0v8EMo9OXRCBb0dSl5PMuwKFKOc4n
	qPFzuZ5fZ6ZaaNoSndgFjYCMrUnwIYrnz93Ht4ppVSRarjlTqgKUOJjMTNuI7ej5TFI1bPNypl+
	kLE9W2mUUcZYKXdv728X+eW3FLYdWaYwR/O3q3kTZ9v7k1ZZO7UknKIl6ULv7/OI4si3hcZoVWN
	DW14+LO1EUX6jbriwkUWZQOXWTJWUEwItwIDOInZVBwlABY8rt7YSYMS6ccIucsPavbbNTwoJpf
	4ennvJXldVxv8ai/izmjPK0JWawycYW/12fe+W32VGUaaxW1KDqnzSepGK3laSxP5ped23QAigL
	xDP7OBOio17HI/bv4G5iql04D0zJQABldU6KVkA6/tbCPccJePLRAqjnu9IHIx3wJb+TosiozPn
	HWSK9XkYcxFPe83Sc=
X-Google-Smtp-Source: AGHT+IHzZbGSEFGQuemPw85evFvVCC+Eai0oeIOUa5YVq58nYvmhhMSbHtXIId00/UrGD+zfBkF1iQ==
X-Received: by 2002:a17:90b:3fc3:b0:343:d70e:bef0 with SMTP id 98e67ed59e1d1-34733f19bc5mr10892764a91.21.1763958843988;
        Sun, 23 Nov 2025 20:34:03 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af0fcc0csm10359878a91.0.2025.11.23.20.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 20:34:03 -0800 (PST)
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
Subject: [PATCH net 3/3] selftests: bonding: add mux and churn state testing
Date: Mon, 24 Nov 2025 04:33:10 +0000
Message-ID: <20251124043310.34073-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251124043310.34073-1-liuhangbin@gmail.com>
References: <20251124043310.34073-1-liuhangbin@gmail.com>
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


