Return-Path: <netdev+bounces-291593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBoTBdxcFWp7UgcAu9opvQ
	(envelope-from <netdev+bounces-291593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:42:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C23C55D294F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66C5A300D788
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B5A3CF04E;
	Tue, 26 May 2026 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Tumgtoe4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f99.google.com (mail-wr1-f99.google.com [209.85.221.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB63CCA12
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784870; cv=none; b=e0dxfER6aOjRIyLOsqOkvj+UZ+QZUb/oXyeOo8hrznLgeUz1WZwLZc8OL+dJl5WHwU9BXYUngLqqdXUNJn/1Kr6voKQqjB6BnA6vNt1lkGtOZEKxh1DMEQE/RhHEaZLDgGZCwzbudt+bxde5EWaNb+a2zgPRvzmpWRKsg2xZqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784870; c=relaxed/simple;
	bh=KM0VbMqec8wRuf4GHSUncHf17yUJAf/1FnQ3++EcDJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xu7KOfJjuJ12ueQQ7i0GV8X6r7n0TtaVb7Mygt7cpo9cyRft0/g5SwzHuDeyK5dNvHaVTywhOu4/+UdI6cNt/mKt9wDr1LAvMvZ49TOgBjM/iMBZ0j5JQl2hhF60K/z830MdLxm/gNNSvafC1V3RlKrWmIY4J6pdTe3z+EgRHrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Tumgtoe4; arc=none smtp.client-ip=209.85.221.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f99.google.com with SMTP id ffacd0b85a97d-45ea19f412aso2892741f8f.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779784865; x=1780389665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PntmpFQ60OHxGG0FPMFqDHTwURgy/Ezf3Oo2r7FwdjU=;
        b=Tumgtoe4U9+WJWaPCd08eYenuybfmzBVnp9Qk91Ez4O2PRauh9AN4KLxPfK0BWTdXS
         txJWCr3o/pBJeMeJcGPfZUXQq4VNenbcfSMNLtILbSgsFRB1wlVMwKt/UhYcCq5jNN6I
         yJNSBXXco2GggFodhDJcIqcmXTmAJCOTKcNcxKI4zCeAhVIe8F+zpEckascbkow4ouOU
         DKb2PxOj8POwQE/S/3ipxJzQvhe2vO5CB7IbV//Vus974z4QDXcXx4VqZFz8NRSKCB6b
         t9phahxYfOtzPayxSPHb/V0E3pe34csrPK/XnyYgKRORIi1ipGuON54nbHyBwC3WeS9Z
         wk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779784865; x=1780389665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PntmpFQ60OHxGG0FPMFqDHTwURgy/Ezf3Oo2r7FwdjU=;
        b=evR3aDpkgM2hSaS1bx9fUjDoT4RP/XqRE/sJe1gNE9E+SYFhcfzORUnz9a8nZvaefF
         wZfs73wu+Y54MVYhfyOdsHR/8oCvKM1XaiUurinY/kKFfuykXTr/wOfbA8w7uCl6287F
         Qf0EV6ZMaFaMiiaY4Ik+sq9iXpwI+LHtcgiNWMbgDfdyF8Np299FnZw+PfvIVU8CNDyb
         8LzToSYsw9posuFanK6sqK4tft+yNss6rcQHA1KIMPOejUzlM/BiD+Gr9Hn8Agz+GKbN
         TePnMM3wek15EMyp5bI+ByhRhlmycSCx3U7osYmRNcC/IXFJuKEuRrah4ZmPgInN14zL
         Oq/g==
X-Gm-Message-State: AOJu0YyW6WbpPBvFbSEsBxMJxfNJWl9kcAjORp5Nbi2/Vrlj9hR9ScMk
	V99/jFmNzePlGmjY/EgYeGzMCzMM+szFhFq7DgBdvF/Q8RWwmMKFP8hP2hds/gUUhHrk/MC8xiv
	xMXaEx2sAV0xLYhw4zwHVqLETAMxkcAHxYP6j
X-Gm-Gg: Acq92OGdk6g1lZco2nen77y7ZwpZ/zYSdtcrFe1s7X0dp48JQcNBrIRP5YFVmy4cwKo
	jnxjwgsW9odc4ZOi162ovSEhlD7unoIZQJ0EdBoNPMg/sT7VXbpGeZ9YoFx4/JpSfG461XlazkZ
	+RYGu2MgcW0Y5HYtcc41u+FB13AJ0zruy6DrFFtxvK3UOMxHkNSS4yDrIJZA9QMEYfEKALXkOBv
	8lA91wfdlEL80PhZ07q+gyxEBepqrnQ/GxtQvm6Uc23dA9C+T6C05zfpjJ+1TRPslo6S4vufVS/
	HNJhDJFgHEYz3D/QedBT4Xox5Wgf48OXu63jgZ1qpym6bOgpKfBTBu/LuhF+n1AwxtAJXLaW2i1
	XOMRSj+PV1hDkBpwHZNvYLzslyYxUYeouLca+jhz0OHERdhtZxet73cqlnzKY/AY=
X-Received: by 2002:a5d:5d82:0:b0:454:a12c:6cdb with SMTP id ffacd0b85a97d-45eb36b0b6cmr29853434f8f.2.1779784865429;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-45eb6d6e57bsm501878f8f.23.2026.05.26.01.41.05;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 50F7B124B3;
	Tue, 26 May 2026 10:41:05 +0200 (CEST)
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
Subject: [PATCH net v7 6/6] selftests: bonding: add test for lacp_strict mode
Date: Tue, 26 May 2026 10:40:48 +0200
Message-Id: <20260526084048.1696544-7-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260526084048.1696544-1-louis.scalbert@6wind.com>
References: <20260526084048.1696544-1-louis.scalbert@6wind.com>
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
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-291593-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C23C55D294F
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


