Return-Path: <netdev+bounces-289908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFPSKqmhDWq10QUAu9opvQ
	(envelope-from <netdev+bounces-289908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:57:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F378158D17C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3736232A2F87
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5E03E92AF;
	Wed, 20 May 2026 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="GLsp+B0f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE43A9639
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276347; cv=none; b=dTNlNZkWMVMYoNo2DIYH9TItgpVbNoENJ+x/slNhxkKIPEegOLrS2CdddGACaV3uL6P3rrEqEq4W2yMnlmkvkND8l3UW2f+KWqPkYA/5gPlPAekUwbGedQHFQ65z52NjPl8lTBtJIhRYA2mtPWD9oyGFurj8GLqSB+4zqalS/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276347; c=relaxed/simple;
	bh=XnibljOkJ+gA/Z8kg0cbeSqT1BsPLUjFC6BnELx/Hog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C5LgLvokjTM8n5NYIr18LG+8sVHbnxaCw0Lhk1UQJrty4G+X/NilckAvNjFyEEL/fblnI3UYbjTlA9O9HOu/oPm8aup2fxMHhssxP6ivvS8WT/gTAW0N/PFGlFw8tnAytE/AZ/RiAaFkqPKy3xPTfnSyu/sZ+I1AVQWSA7K2NXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=GLsp+B0f; arc=none smtp.client-ip=209.85.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-5a8ee4b703fso4588870e87.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779276342; x=1779881142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbPYOWikWqoc2xW+7bVcJ7b6D7Zqq65ZLobWBPrtpW8=;
        b=GLsp+B0fqjM2ZaYuOFjz/Wp6XRKOhex9EuQlVhyOpj2rlmJhxAhn663X494oP2RDio
         dZs5+1HC/tWCBrkgra//zHGubL4u+Fg9JB4cWjuaTCHA+FskawktEkztkWmMPJ8XC4bF
         qCRG4yddCvxjkbizhpj7vHx+x7KAzbvWJK6ZrX8Nm7Y3KB/H+gJL1Vg5+f+plKbcf/25
         yt6CSieJuU5TUyweb3fA4GflzIhOakl+Nyqvmv4kLaovqttFUNFIN+K9akU0PvPFAX9e
         fFPRVMWwlQOOQH9H8tu/Hs8lnSvfg8fiRVjNGZ3uZD1axzp0kU0C0hEg/5nR+qd5wsVw
         4MAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779276342; x=1779881142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RbPYOWikWqoc2xW+7bVcJ7b6D7Zqq65ZLobWBPrtpW8=;
        b=V6LUqaUgSoH4RZIGn69jpwFJrggpoLIrOCqly68Js7HC5KaGIwaBe4T1BAPuc2QyDz
         u15MOR9bf3sYEA6pivUv+MYlc448A97Pmy7yEj7KMk5zg5PSmXu6GVql0rvjHkOYLOzN
         LkhGtt3VwvwNxIhYL1n8TyLS0jDcd6w4QKNsBtA+lnxgUlurkuU9srTCh38HT98VbJcQ
         pL9XRRp+UWB6+i/H3RtOVxDusRbjnDpOsb9vLljUYdLrdp0u+ck2aHoGFp+0k7YfIkye
         GEvjhNby7QyiQSBgmXMBwZhFmqvSjEhynbdxK1g5huhJ8TI67OPqVcXKmhBPeHpoe4W6
         JhYQ==
X-Gm-Message-State: AOJu0YywAuU1NbZf+/BFfKQ5GjmmwAhPgMJQ+xDuIOFLdxyV0LUT0hEY
	EYZv6fkJ9WR5vZL3Mp6d+XsXEZtyV+zqXr2PCr4e8hfymqWpP0vereZMgcJSZ+LmvJeG8K2nDp2
	BBCmUfNdqajLzeASDRLIsmVF1nM99ikOjjjdH
X-Gm-Gg: Acq92OGk5clGnNebA72cSyucoWgof1jsgGfh9LdgLyfjWPp7rdS/G8Z9WyPdVSNAMlz
	PhTD8lxt11SLcNfYZeGgHTPuvQBcMfKkmO2NWogQnVGEYsS0ykziJUx3hpSi3NdwmO/Bq0AeLFU
	0BtctFwCngnZOuuYwtX3zIhbSFChFiib3FTnPFbg9fJ2YL4mRZlgYxnWaoS+xMbp6yad39njcLZ
	hHPtuNy1/Lf8+LUQbwZVxySqkAIY6c9QKEqyBmAcP01HDUu2gpT4q2sLY2l+hTrIR3QA0X1DNKr
	WHkMgm184Ns81itovgv1EV5jjtXGmDDJ0kKT52EQQ3HTQWj61+MN5B3N5/CDysnVHdV3O7qADEj
	5o3aNiK83dQ/aiLs2qbGeNbYyAkmzugzDQMnZLRxPPxcQnb7ejf2r
X-Received: by 2002:a05:6512:1590:b0:5a4:d34:5b38 with SMTP id 2adb3069b0e04-5aa0e6191abmr7040442e87.2.1779276341725;
        Wed, 20 May 2026 04:25:41 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 38308e7fff4ca-3958876bc6fsm9081091fa.17.2026.05.20.04.25.41;
        Wed, 20 May 2026 04:25:41 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 5B94611541;
	Wed, 20 May 2026 13:25:41 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	jonas.gorski@gmail.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v6 4/4] selftests: bonding: add test for lacp_strict mode
Date: Wed, 20 May 2026 13:25:39 +0200
Message-Id: <20260520112539.798275-5-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260520112539.798275-1-louis.scalbert@6wind.com>
References: <20260520112539.798275-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289908-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:email,6wind.com:mid,6wind.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bond_lacp_strict.sh:url]
X-Rspamd-Queue-Id: F378158D17C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a test for the bonding lacp_strict mode.

Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../drivers/net/bonding/bond_lacp_strict.sh   | 347 ++++++++++++++++++
 2 files changed, 348 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_strict.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 9af5f84edd37..91269e7ceb63 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -7,6 +7,7 @@ TEST_PROGS := \
 	bond-eth-type-change.sh \
 	bond-lladdr-target.sh \
 	bond_ipsec_offload.sh \
+	bond_lacp_strict.sh \
 	bond_lacp_prio.sh \
 	bond_macvlan_ipvlan.sh \
 	bond_options.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_strict.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_strict.sh
new file mode 100755
index 000000000000..f1a93a1d952f
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_strict.sh
@@ -0,0 +1,347 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Testing if bond lacp_strict works
+#
+#          Partner (p_ns)
+#  +--------------------------+
+#  |          bond0           |
+#  |            +             |
+#  |      eth0  |  eth1       |
+#  |        +---+---+         |
+#  |        |       |         |
+#  +--------------------------+
+#  |        | eth0  | eth1    |
+#  |        |       |         |
+#  |(br_ns) | br0   | br1     |
+#  |        |       |         |
+#  |        | eth2  | eth3    |
+#  +--------------------------+
+#  |        |       |         |
+#  |        +---+---+         |
+#  |      eth0  |  eth1       |
+#  |            +             |
+#  |          bond0           |
+#  +--------------------------+
+#         Dut (d_ns)
+
+lib_dir=$(dirname "$0")
+# shellcheck disable=SC1090
+source "$lib_dir"/../../../net/lib.sh
+
+COLLECTING_DISTRIBUTING_MASK=48
+COLLECTING_DISTRIBUTING=48
+FAILED=0
+
+setup_links()
+{
+	# shellcheck disable=SC2154
+	ip -n "${p_ns}" link add eth0 type veth peer name eth0 netns "${br_ns}"
+	ip -n "${p_ns}" link add eth1 type veth peer name eth1 netns "${br_ns}"
+	ip -n "${d_ns}" link add eth0 type veth peer name eth2 netns "${br_ns}"
+	ip -n "${d_ns}" link add eth1 type veth peer name eth3 netns "${br_ns}"
+
+	ip -n "${br_ns}" link add br0 type bridge
+	ip -n "${br_ns}" link add br1 type bridge
+
+	ip -n "${br_ns}" link set dev br0 type bridge stp_state 0
+	ip -n "${br_ns}" link set dev br1 type bridge stp_state 0
+
+	ip -n "${br_ns}" link set eth0 master br0
+	ip -n "${br_ns}" link set eth2 master br0
+	ip -n "${br_ns}" link set eth1 master br1
+	ip -n "${br_ns}" link set eth3 master br1
+
+	# Allow LACP trames forwarding on bridge ports
+	ip netns exec "${br_ns}" sh -c "echo 4 > /sys/class/net/br0/brif/eth0/group_fwd_mask"
+	ip netns exec "${br_ns}" sh -c "echo 4 > /sys/class/net/br1/brif/eth1/group_fwd_mask"
+	ip netns exec "${br_ns}" sh -c "echo 4 > /sys/class/net/br0/brif/eth2/group_fwd_mask"
+	ip netns exec "${br_ns}" sh -c "echo 4 > /sys/class/net/br1/brif/eth3/group_fwd_mask"
+
+	ip -n "${br_ns}" link set eth0 up
+	ip -n "${br_ns}" link set eth2 up
+	ip -n "${br_ns}" link set eth1 up
+	ip -n "${br_ns}" link set eth3 up
+
+	ip -n "${br_ns}" link set br0 up
+	ip -n "${br_ns}" link set br1 up
+
+	ip -n "${d_ns}" link add bond0 type bond mode 802.3ad miimon 100 \
+		lacp_rate fast min_links 1
+	ip -n "${p_ns}" link add bond0 type bond mode 802.3ad miimon 100 \
+		lacp_rate fast min_links 1
+
+	ip -n "${d_ns}" link set eth0 master bond0
+	ip -n "${d_ns}" link set eth1 master bond0
+	ip -n "${p_ns}" link set eth0 master bond0
+	ip -n "${p_ns}" link set eth1 master bond0
+
+	ip -n "${d_ns}" link set bond0 up
+	ip -n "${p_ns}" link set bond0 up
+}
+
+test_master_carrier() {
+	local expected=$1
+	local mode_name=$2
+	local carrier
+
+	carrier=$(ip netns exec "${d_ns}" cat /sys/class/net/bond0/carrier)
+	[ "$carrier" == "1" ] && carrier="up" || carrier="down"
+
+	[ "$carrier" == "$expected" ] && return
+
+	echo "FAIL: Expected carrier $expected in lacp_strict $mode_name mode, got $carrier"
+
+	RET=1
+
+}
+
+compare_state() {
+	local actual_state=$1
+	local expected_state=$2
+	local iface=$3
+	local last_attempt=$4
+
+    [ $((actual_state & COLLECTING_DISTRIBUTING_MASK)) -eq "$expected_state" ] \
+		&& return 0
+
+	[ "$last_attempt" -ne 1 ] && return 1
+
+	printf "FAIL: Expected LACP %s actor state to " "$iface"
+	if [ "$expected_state" -eq $COLLECTING_DISTRIBUTING ]; then
+		echo "be in Collecting/Distributing state"
+	else
+		echo "have neither Collecting nor Distributing set."
+	fi
+
+	return 1
+}
+
+_test_lacp_port_state() {
+	local interface=$1
+	local expected=$2
+	local last_attempt=$3
+	local eth0_actor_state eth1_actor_state
+	local ret=0
+
+	# shellcheck disable=SC2016
+	while IFS='=' read -r k v; do
+		printf -v "$k" '%s' "$v"
+	done < <(
+		ip netns exec "${d_ns}" awk '
+		/^Slave Interface: / { iface=$3 }
+		/details actor lacp pdu:/ { ctx="actor" }
+		/details partner lacp pdu:/ { ctx="partner" }
+		/^[[:space:]]+port state: / {
+			if (ctx == "actor") {
+				gsub(":", "", iface)
+				printf "%s_%s_state=%s\n", iface, ctx, $3
+			}
+		}
+		' /proc/net/bonding/bond0
+	)
+
+	if [ "$interface" == "eth0" ] || [ "$interface" == "both" ]; then
+		compare_state "$eth0_actor_state" "$expected" eth0 "$last_attempt" || ret=1
+	fi
+
+	if [ "$interface" == "eth1" ] || [ "$interface" == "both" ]; then
+		compare_state "$eth1_actor_state" "$expected" eth1 "$last_attempt" || ret=1
+	fi
+
+	return $ret
+}
+
+test_lacp_port_state() {
+	local interface=$1
+	local expected=$2
+	local retry=$3
+	local last_attempt=0
+	local attempt=1
+	local ret=1
+
+	while [ $attempt -le $((retry + 1)) ]; do
+		[ $attempt -eq $((retry + 1)) ] && last_attempt=1
+		_test_lacp_port_state "$interface" "$expected" "$last_attempt" && return
+		((attempt++))
+		sleep 1
+	done
+
+	RET=1
+}
+
+
+trap cleanup_all_ns EXIT
+setup_ns d_ns p_ns br_ns
+setup_links
+
+# Initial state
+RET=0
+mode=off
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 3
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 up"
+
+# partner eth0 down, eth1 up
+# (replicate eth0 state to dut eth0 by shutting a bridge port)
+RET=0
+ip -n "${p_ns}" link set eth0 down
+ip -n "${br_ns}" link set eth2 down
+test_lacp_port_state eth0 $FAILED 5
+test_lacp_port_state eth1 $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 down"
+
+# partner eth0 and eth1 down
+RET=0
+ip -n "${p_ns}" link set eth1 down
+ip -n "${br_ns}" link set eth3 down
+test_lacp_port_state both $FAILED 5
+test_master_carrier down $mode # down because of min_links
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 down"
+
+# partner eth0 up, eth1 down
+RET=0
+ip -n "${p_ns}" link set eth0 up
+ip -n "${br_ns}" link set eth2 up
+test_lacp_port_state eth0 $COLLECTING_DISTRIBUTING 60
+test_lacp_port_state eth1 $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 up, eth1 down"
+
+# partner eth0 and eth1 up
+RET=0
+ip -n "${p_ns}" link set eth1 up
+ip -n "${br_ns}" link set eth3 up
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 60
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 up"
+
+# partner eth0 stops LACP and eth1 up
+RET=0
+ip netns exec "${br_ns}" sh -c "echo 0 > /sys/class/net/br0/brif/eth0/group_fwd_mask"
+ip netns exec "${br_ns}" sh -c "echo 0 > /sys/class/net/br0/brif/eth2/group_fwd_mask"
+test_lacp_port_state eth0 $FAILED 5
+test_lacp_port_state eth1 $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 stopped sending LACP"
+
+# partner eth0 and eth1 stop LACP
+RET=0
+ip netns exec "${br_ns}" sh -c "echo 0 > /sys/class/net/br1/brif/eth1/group_fwd_mask"
+ip netns exec "${br_ns}" sh -c "echo 0 > /sys/class/net/br1/brif/eth3/group_fwd_mask"
+test_lacp_port_state both $FAILED 5
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 stopped sending LACP"
+
+# switch to lacp_strict on
+RET=0
+mode=on
+ip -n "${d_ns}" link set dev bond0 type bond lacp_strict $mode
+test_lacp_port_state both $FAILED 1
+test_master_carrier down $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 stopped sending LACP"
+
+# switch back to lacp_strict off mode
+RET=0
+mode=off
+ip -n "${d_ns}" link set dev bond0 type bond lacp_strict $mode
+test_lacp_port_state both $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 stopped sending LACP"
+
+# eth0 recovers LACP
+RET=0
+ip netns exec "${br_ns}" sh -c "echo 4 > /sys/class/net/br0/brif/eth0/group_fwd_mask"
+ip netns exec "${br_ns}" sh -c "echo 4 > /sys/class/net/br0/brif/eth2/group_fwd_mask"
+test_lacp_port_state eth0 $COLLECTING_DISTRIBUTING 60
+test_lacp_port_state eth1 $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 recovered and eth1 stopped sending LACP"
+
+# eth1 recovers LACP
+RET=0
+ip netns exec "${br_ns}" sh -c "echo 4 > /sys/class/net/br1/brif/eth1/group_fwd_mask"
+ip netns exec "${br_ns}" sh -c "echo 4 > /sys/class/net/br1/brif/eth3/group_fwd_mask"
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 60
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 recovered LACP"
+
+# switch to lacp_strict on
+RET=0
+mode=on
+ip -n "${d_ns}" link set dev bond0 type bond lacp_strict $mode
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 up"
+
+# partner eth0 down, eth1 up
+RET=0
+ip -n "${p_ns}" link set eth0 down
+ip -n "${br_ns}" link set eth2 down
+test_lacp_port_state eth0 $FAILED 5
+test_lacp_port_state eth1 $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 down"
+
+# partner eth0 and eth1 down
+RET=0
+ip -n "${p_ns}" link set eth1 down
+ip -n "${br_ns}" link set eth3 down
+test_lacp_port_state both $FAILED 5
+test_master_carrier down $mode # down because of min_links
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 down"
+
+# partner eth0 up, eth1 down
+RET=0
+ip -n "${p_ns}" link set eth0 up
+ip -n "${br_ns}" link set eth2 up
+test_lacp_port_state eth0 $COLLECTING_DISTRIBUTING 60
+test_lacp_port_state eth1 $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 up, eth1 down"
+
+# partner eth0 and eth1 up
+RET=0
+ip -n "${p_ns}" link set eth1 up
+ip -n "${br_ns}" link set eth3 up
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 60
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 up"
+
+# partner eth0 stops LACP and eth1 up
+RET=0
+ip netns exec "${br_ns}" sh -c "echo 0 > /sys/class/net/br0/brif/eth0/group_fwd_mask"
+ip netns exec "${br_ns}" sh -c "echo 0 > /sys/class/net/br0/brif/eth2/group_fwd_mask"
+test_lacp_port_state eth0 $FAILED 5
+test_lacp_port_state eth1 $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 stopped sending LACP"
+
+# partner eth0 and eth1 stop LACP
+RET=0
+ip netns exec "${br_ns}" sh -c "echo 0 > /sys/class/net/br1/brif/eth1/group_fwd_mask"
+ip netns exec "${br_ns}" sh -c "echo 0 > /sys/class/net/br1/brif/eth3/group_fwd_mask"
+test_lacp_port_state both $FAILED 5
+test_master_carrier down $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 stopped sending LACP"
+
+# eth0 recovers LACP
+RET=0
+ip netns exec "${br_ns}" sh -c "echo 4 > /sys/class/net/br0/brif/eth0/group_fwd_mask"
+ip netns exec "${br_ns}" sh -c "echo 4 > /sys/class/net/br0/brif/eth2/group_fwd_mask"
+test_lacp_port_state eth0 $COLLECTING_DISTRIBUTING 60
+test_lacp_port_state eth1 $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 recovered and eth1 stopped sending LACP"
+
+# eth1 recovers LACP
+# shellcheck disable=SC2034
+RET=0
+ip netns exec "${br_ns}" sh -c "echo 4 > /sys/class/net/br1/brif/eth1/group_fwd_mask"
+ip netns exec "${br_ns}" sh -c "echo 4 > /sys/class/net/br1/brif/eth3/group_fwd_mask"
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 60
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 recovered LACP"
+
+exit "${EXIT_STATUS}"
-- 
2.39.2


