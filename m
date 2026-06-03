Return-Path: <netdev+bounces-294802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IlEIMPdNIGrn0gAAu9opvQ
	(envelope-from <netdev+bounces-294802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:53:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE3639727
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:53:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=K5EhKwVS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294802-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294802-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE88830DFC09
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3B7396D2E;
	Wed,  3 Jun 2026 15:03:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EE7395AFD
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:03:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499017; cv=none; b=JdwyMJHFf46fNaXcpFPc1TL1wZEQFX3yQ2ELqVKHJiuhhHkoHK17GUpzlrKArYBRAgNEWCt6GzxeINDWv4YmQbWVYeiinysPFIPIZUi2D/7KKyxy2R5SvVjAcGPiTDJGvR7qnoEXgIupiljTc0kTN3/Ikz05pVsNs1IVwlR/aPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499017; c=relaxed/simple;
	bh=KM0VbMqec8wRuf4GHSUncHf17yUJAf/1FnQ3++EcDJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tavzB6MyCHuq9LTqjF2GwLwrWAKlLUS86F1k/03VCOwnyX73KiBMRn3ho1DxEDn53ZEE4E/J1mNyYF0lPeFuI33hatFd408Fm0LSmNCJQdv1vFfc+aTqXCp9UCj/x5A8QK5SugFJBPB+5TwUvk9CysaiRmp6RwCNUuQpz8F5+yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=K5EhKwVS; arc=none smtp.client-ip=209.85.167.97
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so3810166e87.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1780499013; x=1781103813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PntmpFQ60OHxGG0FPMFqDHTwURgy/Ezf3Oo2r7FwdjU=;
        b=K5EhKwVSBnEglN2JQSbuJh8+ed9GG5WbQgBZBQ45fwNTe4tUEzWohoz0s8puVTC852
         OEAYoPTiwIYswiqXXdoFrcWC6mhnNwF7DWj+YFsem0hAKywsH6BZh9ljA1EsC6sQvFf6
         +hStHpn4L/gng3mHp9EYRWqAWzA/ps7makhK6RWOaCuYU3ueTCWrVpgiIrsvs6TtCX9M
         0pDZTTJXWWgx12NRoZByJNV858NYknPTJxwWSnk6DGHS+C6J/5yBV7f7RbQMKgTMyagB
         4pdc//hY/HFQpnA4nKlnGQMMbZdGFoU/VHYIUPeWD8yLZkrcIMWIBnuFqzVtmVnA6cQn
         yCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499013; x=1781103813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PntmpFQ60OHxGG0FPMFqDHTwURgy/Ezf3Oo2r7FwdjU=;
        b=R566BUiPFv9fIgnJmmAltcAHMCLNjqH+ebIx93JvrANWbLl1yUTj1gf/vCaYDSHbFS
         pAE8GB0RRIQlDfqBeP2wheSqhzY3VuymBe08lp4iZOOnPGaw8q9ej60+llfvD7+pFZAY
         d18GMOSL2sXPZlq6M9RNzTV0CYBSUGpqgYkkgA47PZKs+wY1xO0qiRX8Li2y5yYuPlgG
         hSJIAEwo2xwQMUAAfOchbTaC/NbkjqRpWojRAr3f/6WjB1gm1TQ5b8ahtM+pch3j/2UC
         clbOoKsBz0LxU2D6tFjuqEgLvGTC5yZYFZl7xa+AlV0nEV9nbq7ukw4EJoBW4PjYinte
         xiGw==
X-Gm-Message-State: AOJu0YzrtzIta9rDKJJHRUX0lI8DuUXK6vsKYUGrX52DYwefywq2yquT
	veX21k2DjKndHoWteUzvyPDVCqO0Ygc+MOCBZ9RWlGv+OlykaekWbdLgD/REe6fUo8zxeuJoX9Y
	jQszFQcAMMBIlZXCQNyPWINdlAzfCj8Y2rap0
X-Gm-Gg: Acq92OFU7ZiVJOUaQdHzimQFNI0R2nVBIChKzue8SLLceAFIPdtlx7rhORABouchGGA
	fQpYzMS4ZsiI1wf8sEL6IzZNipzdHVVZ/RwrbKfJI6DS8lPoAoTInTIP+e4sP7WduPqOUMlBT4x
	R3qIl9ZPTSKy8TKmEVfPAKLporTQOgy5bW/exE6djBAnyTJNw9fxkMHIgKoqnbfb+SDpwsFP+SO
	MzGSBLaDVI4bBkji4GGW85jhaerVS2tOhlqQTs+fEflUn1/cPdtE5n3pM5cKavWpE8nylr0BrVV
	ziGAXEjzDbNFJ6/IsidJ0AfjWuJuaFWk78URsaaGU5ERIgS9x+QNcPyHNhMgq3iE3ffotBlkGnU
	kP7w4Cx0Lj1uHPhT8nPLAmCMCGTXhTo/r7PXEDmWI8Zp4uWv9Mzc/1BqGnAFPoTk=
X-Received: by 2002:a05:6512:128d:b0:5aa:6f93:de67 with SMTP id 2adb3069b0e04-5aa7c0384dbmr1339894e87.9.1780499013607;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5aa7b979e8fsm188777e87.52.2026.06.03.08.03.33;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 0C77114715;
	Wed,  3 Jun 2026 17:03:33 +0200 (CEST)
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
	horms@kernel.org,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v8 6/6] selftests: bonding: add test for lacp_strict mode
Date: Wed,  3 Jun 2026 17:03:31 +0200
Message-Id: <20260603150331.1919611-7-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260603150331.1919611-1-louis.scalbert@6wind.com>
References: <20260603150331.1919611-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294802-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:jv@jvosburgh.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:louis.scalbert@6wind.com,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:mid,6wind.com:dkim,6wind.com:from_mime,6wind.com:email,vger.kernel.org:from_smtp,bond_lacp_strict.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0EE3639727

Add a test for the bonding lacp_strict mode.

Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../drivers/net/bonding/bond_lacp_strict.sh   | 347 ++++++++++++++++++
 2 files changed, 348 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_strict.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 9af5f84edd37..be130bf585a4 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -8,6 +8,7 @@ TEST_PROGS := \
 	bond-lladdr-target.sh \
 	bond_ipsec_offload.sh \
 	bond_lacp_prio.sh \
+	bond_lacp_strict.sh \
 	bond_macvlan_ipvlan.sh \
 	bond_options.sh \
 	bond_passive_lacp.sh \
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


