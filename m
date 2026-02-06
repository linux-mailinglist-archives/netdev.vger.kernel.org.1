Return-Path: <netdev+bounces-257418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NXTCq1ZhWnNAQQAu9opvQ
	(envelope-from <netdev+bounces-257418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:02:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFFFF97F5
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9201130360A6
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F7229E113;
	Fri,  6 Feb 2026 03:01:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115EB29DB6C;
	Fri,  6 Feb 2026 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346900; cv=none; b=hLxSWA/2FxYaFpSw8qELfyBpo001TZ8hOZHetRVmsa7Y39gyTeKpXfEgJtcIhoMdv4c05pwwO3X6QzC9ukPx1y8SeIUqOGej/dNvKEyobKJhqfLIrvxW11cmD0BJqCXx33fw50dQzp8I86hqzIBpchCFFqmBqMofO4HroWseqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346900; c=relaxed/simple;
	bh=zNi6WJCvBCxooc/KHwwvYN+hskmIareGhxJgtaVUXks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iM5TmiajpP2jP5KkJHpbEdx1+spEi2egPe+o9gkpmhHai69TfMLDbvnn4Dtsjbnc90saQXkKzkX49MTuttZ1fkIjtX7yl7xG3u6D4mCB8GFQmLEAB6K5Gxvhu3UmhirU1hZ4e/WXtjfA5Ssx1X1yRHE7h0IH4/sWyLojNjGd5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7BCC254CD2B;
	Fri,  6 Feb 2026 04:01:37 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v2 02/14] net: bridge: mcast: track active state, adding tests
Date: Fri,  6 Feb 2026 03:52:08 +0100
Message-ID: <20260206030123.5430-3-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206030123.5430-1-linus.luessing@c0d3.blue>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257418-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[c0d3.blue];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,c0d3.blue];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,c0d3.blue:mid,c0d3.blue:email]
X-Rspamd-Queue-Id: ADFFFF97F5
X-Rspamd-Action: no action

Before making any significant changes to the internals of the Linux
bridge add some tests regarding the multicast activity. This is
also to verify that we have the semantics of the new
*_MCAST_ACTIVE_{V4,V6} netlink attributes as expected.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 .../net/forwarding/bridge_mdb_active.sh       | 682 ++++++++++++++++++
 1 file changed, 682 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_mdb_active.sh

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_active.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_active.sh
new file mode 100755
index 000000000000..5b6e14d88bc2
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb_active.sh
@@ -0,0 +1,682 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +-------+      +---------+
+# | brq0  |      | br0     |
+# | + $h1 |      | + $swp1 |
+# +----|--+      +----|----+
+#      |              |
+#      \--------------/
+#
+#
+# This script checks if we have the expected mcast_active_v{4,6} state
+# on br0 in a variety of scenarios. This state determines if ultimately
+# multicast snooping is applied to multicast data packets
+# (multicast snooping active) or if they are (by default) flooded instead
+# (multicast snooping inactive).
+#
+# Notably, multicast snooping can be enabled but still be inactive if not all
+# requirements to safely apply multicast snooping to multicast data packets
+# are met.
+#
+# Depending on the test case an IGMP/MLD querier might be on brq0, on br0
+# or neither.
+
+
+ALL_TESTS="
+	test_inactive
+	test_active_other_querier
+	test_active_own_querier
+	test_inactive_brdown
+	test_inactive_nov6
+	test_inactive_snooping_off
+	test_inactive_querier_off
+	test_inactive_other_querier_norespdelay
+	test_inactive_own_querier_norespdelay
+	test_inactive
+	test_vlan_inactive
+	test_vlan_active_other_querier
+	test_vlan_active_own_querier
+	test_vlan_inactive_brdown
+	test_vlan_inactive_nov6
+	test_vlan_inactive_snooping_off
+	test_vlan_inactive_vlans_snooping_off
+	test_vlan_inactive_vlan_snooping_off
+	test_vlan_inactive_other_querier_norespdelay
+	test_vlan_inactive_own_querier_norespdelay
+"
+
+NUM_NETIFS=1
+MCAST_MAX_RESP_IVAL_SEC=1
+MCAST_VLAN_ID=42
+source lib.sh
+
+switch_create()
+{
+	ip link add dev br0 type bridge\
+		vlan_filtering 0 \
+		mcast_query_response_interval $((${MCAST_MAX_RESP_IVAL_SEC}*100))\
+		mcast_snooping 0 \
+		mcast_vlan_snooping 0
+	ip link add dev brq0 type bridge\
+		vlan_filtering 0 \
+		mcast_query_response_interval $((${MCAST_MAX_RESP_IVAL_SEC}*100))\
+		mcast_snooping 0 \
+		mcast_vlan_snooping 0
+
+	echo 1 > /proc/sys/net/ipv6/conf/br0/disable_ipv6
+	echo 1 > /proc/sys/net/ipv6/conf/brq0/disable_ipv6
+
+	ip link set dev $swp1 master br0
+	ip link set dev $h1 master brq0
+
+	ip link set dev $h1 up
+	ip link set dev $swp1 up
+}
+
+switch_destroy()
+{
+	ip link set dev $swp1 down
+	ip link set dev $h1 down
+
+	ip link del dev brq0
+	ip link del dev br0
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	switch_create
+}
+
+cleanup()
+{
+	pre_cleanup
+	switch_destroy
+}
+
+mcast_active_check()
+{
+	local af="$1"
+	local state="$2"
+
+	ip -d -j link show dev br0\
+		| jq -e ".[] | select(.linkinfo.info_data.mcast_active_$af == $state)"\
+		&> /dev/null
+
+	check_err $? "Mcast active check failed"
+}
+
+mcast_vlan_active_check()
+{
+	local af="$1"
+	local state="$2"
+	local vid="${MCAST_VLAN_ID}"
+	local ret
+
+	bridge -j vlan global show dev br0\
+		| jq -e ".[].vlans.[] | select(.vlan == $vid and .mcast_active_$af == 1)"\
+		&> /dev/null
+	ret="$?"
+
+	if [ $ret -eq 0 -a $state -eq 0 ] || [ $ret -ne 0 -a $state -eq 1 ]; then
+		check_err 1 "Mcast VLAN active check failed"
+	fi
+}
+
+mcast_assert_active_v4()
+{
+	mcast_active_check "v4" "1"
+}
+
+mcast_assert_active_v6()
+{
+	mcast_active_check "v6" "1"
+}
+
+mcast_assert_inactive_v4()
+{
+	mcast_active_check "v4" "0"
+}
+
+mcast_assert_inactive_v6()
+{
+	mcast_active_check "v6" "0"
+}
+
+mcast_vlan_assert_active_v4()
+{
+	mcast_vlan_active_check "v4" "1"
+}
+
+mcast_vlan_assert_active_v6()
+{
+	mcast_vlan_active_check "v6" "1"
+}
+
+mcast_vlan_assert_inactive_v4()
+{
+	mcast_vlan_active_check "v4" "0"
+}
+
+mcast_vlan_assert_inactive_v6()
+{
+	mcast_vlan_active_check "v6" "0"
+}
+
+
+test_inactive_nolog()
+{
+	ip link set dev br0 down
+	ip link set dev brq0 down
+	ip link set dev br0 type bridge mcast_snooping 0
+	ip link set dev brq0 type bridge mcast_snooping 0
+	ip link set dev br0 type bridge mcast_querier 0
+	ip link set dev brq0 type bridge mcast_querier 0
+	ip link set dev br0 type bridge mcast_vlan_snooping 0
+	ip link set dev br0 type bridge vlan_filtering 0
+
+	echo 1 > /proc/sys/net/ipv6/conf/br0/disable_ipv6
+	echo 1 > /proc/sys/net/ipv6/conf/brq0/disable_ipv6
+
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+}
+
+test_inactive()
+{
+	RET=0
+
+	test_inactive_nolog
+	log_test "Mcast inactive test"
+}
+
+wait_lladdr_dad() {
+	local check_tentative
+
+	check_tentative="map(select(.scope == \"link\" and ((.tentative == true) | not))) | .[]"
+
+	ip -6 -j a s dev "$1"\
+		| jq -e ".[].addr_info | ${check_tentative}" &> /dev/null
+}
+
+test_active_setup_bridge()
+{
+	[ -n "$1" ] && echo 0 > /proc/sys/net/ipv6/conf/br0/disable_ipv6
+	[ -n "$2" ] && echo 0 > /proc/sys/net/ipv6/conf/brq0/disable_ipv6
+
+	[ -n "$3" ] && ip link set dev br0 up
+	[ -n "$4" ] && ip link set dev brq0 up
+	[ -n "$5" ] && slowwait 3 wait_lladdr_dad br0
+	[ -n "$6" ] && slowwait 3 wait_lladdr_dad brq0
+}
+
+test_active_setup_config()
+{
+	[ -n "$1" ] && ip link set dev br0 type bridge mcast_snooping 1
+	[ -n "$2" ] && ip link set dev brq0 type bridge mcast_snooping 1
+	[ -n "$3" ] && ip link set dev br0 type bridge mcast_querier 1
+	[ -n "$4" ] && ip link set dev brq0 type bridge mcast_querier 1
+}
+
+test_active_setup_wait()
+{
+	sleep $((${MCAST_MAX_RESP_IVAL_SEC} * 2))
+}
+
+test_active_setup_reset_own_querier()
+{
+	ip link set dev br0 type bridge mcast_querier 0
+	ip link set dev br0 type bridge mcast_querier 1
+
+	test_active_setup_wait
+}
+
+test_vlan_active_setup_config()
+{
+	[ -n "$1" ] && ip link set dev br0 type bridge vlan_filtering 1
+	[ -n "$2" ] && ip link set dev brq0 type bridge vlan_filtering 1
+	[ -n "$3" ] && ip link set dev br0 type bridge mcast_vlan_snooping 1
+	[ -n "$4" ] && ip link set dev brq0 type bridge mcast_vlan_snooping 1
+}
+
+test_vlan_active_setup_add_vlan()
+{
+	bridge vlan add vid ${MCAST_VLAN_ID} dev $swp1
+	bridge vlan add vid ${MCAST_VLAN_ID} dev $h1
+	bridge vlan global set vid ${MCAST_VLAN_ID} dev br0\
+		mcast_query_response_interval $((${MCAST_MAX_RESP_IVAL_SEC}*100))
+	bridge vlan global set vid ${MCAST_VLAN_ID} dev brq0\
+		mcast_query_response_interval $((${MCAST_MAX_RESP_IVAL_SEC}*100))
+	bridge vlan global set vid ${MCAST_VLAN_ID} dev br0 mcast_snooping 0
+	bridge vlan global set vid ${MCAST_VLAN_ID} dev brq0 mcast_snooping 0
+	bridge vlan global set vid ${MCAST_VLAN_ID} dev br0 mcast_querier 0
+	bridge vlan global set vid ${MCAST_VLAN_ID} dev brq0 mcast_querier 0
+}
+
+test_vlan_active_setup_config_vlan()
+{
+	[ -n "$1" ] && bridge vlan global set vid ${MCAST_VLAN_ID} dev br0 mcast_snooping 1
+	[ -n "$2" ] && bridge vlan global set vid ${MCAST_VLAN_ID} dev brq0 mcast_snooping 1
+	[ -n "$3" ] && bridge vlan global set vid ${MCAST_VLAN_ID} dev br0 mcast_querier 1
+	[ -n "$4" ] && bridge vlan global set vid ${MCAST_VLAN_ID} dev brq0 mcast_querier 1
+}
+
+test_vlan_teardown()
+{
+	bridge vlan del vid ${MCAST_VLAN_ID} dev $swp1
+	bridge vlan del vid ${MCAST_VLAN_ID} dev $h1
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+	mcast_vlan_assert_inactive_v4
+	mcast_vlan_assert_inactive_v6
+}
+
+test_vlan_active_setup_reset_own_querier()
+{
+	bridge vlan global set vid ${MCAST_VLAN_ID} dev br0 mcast_querier 0
+	bridge vlan global set vid ${MCAST_VLAN_ID} dev br0 mcast_querier 1
+
+	test_active_setup_wait
+}
+
+test_active_other_querier_nolog()
+{
+	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
+	test_active_setup_config "1" "2" ""  "4"
+	test_active_setup_wait
+
+	mcast_assert_active_v4
+	mcast_assert_active_v6
+}
+
+test_active_other_querier()
+{
+	RET=0
+
+	test_active_other_querier_nolog
+	test_inactive_nolog
+	log_test "Mcast active with other querier test"
+}
+
+test_active_own_querier_nolog()
+{
+	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
+	test_active_setup_config "1" "2" "3" ""
+	test_active_setup_wait
+
+	mcast_assert_active_v4
+	mcast_assert_active_v6
+}
+
+test_active_own_querier()
+{
+	RET=0
+
+	test_active_own_querier_nolog
+	test_inactive_nolog
+	log_test "Mcast active with own querier test"
+}
+
+test_active_final()
+{
+	mcast_assert_active_v4
+	mcast_assert_active_v6
+
+	test_inactive_nolog
+}
+
+test_inactive_brdown()
+{
+	RET=0
+
+	test_active_setup_bridge "1" "2" ""  "4" ""  "6"
+	test_active_setup_config "1" "2" "3" ""
+	test_active_setup_wait
+
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+
+	test_active_setup_bridge ""  ""  "3" ""  ""  ""
+	mcast_assert_active_v4
+	mcast_assert_inactive_v6
+
+	test_active_setup_bridge ""  ""  ""  ""  "5" ""
+	test_active_setup_reset_own_querier
+	test_active_final
+
+	log_test "Mcast inactive, bridge down test"
+}
+
+test_inactive_nov6()
+{
+	RET=0
+
+	test_active_setup_bridge ""  "2" "3" "4" "5" "6"
+	test_active_setup_config "1" "2" "3" ""
+	test_active_setup_wait
+
+	mcast_assert_active_v4
+	mcast_assert_inactive_v6
+
+	test_active_setup_bridge "1" ""  ""  ""  "5" ""
+	test_active_setup_reset_own_querier
+	test_active_final
+
+	log_test "Mcast inactive, own querier, no IPv6 address test"
+}
+
+test_inactive_snooping_off()
+{
+	RET=0
+
+	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
+	test_active_setup_config ""  "2" "3" ""
+	test_active_setup_wait
+
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+
+	test_active_setup_config "1" ""  ""  ""
+	test_active_setup_reset_own_querier
+	test_active_final
+
+	log_test "Mcast inactive, snooping disabled test"
+}
+
+test_inactive_querier_off()
+{
+	RET=0
+
+	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
+	test_active_setup_config "1" "2" ""  ""
+	test_active_setup_wait
+
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+
+	test_active_setup_config ""  ""  "3" ""
+	test_active_setup_wait
+	test_active_final
+
+	log_test "Mcast inactive, no querier test"
+}
+
+test_inactive_other_querier_norespdelay()
+{
+	RET=0
+
+	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
+	test_active_setup_config "1" "2" "3" ""
+	#test_active_setup_wait
+
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+
+	test_active_setup_wait
+	test_active_final
+
+	log_test "Mcast inactive, other querier, no response delay test"
+}
+
+test_inactive_own_querier_norespdelay()
+{
+	RET=0
+
+	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
+	test_active_setup_config "1" "2" ""  "4"
+	#test_active_setup_wait
+
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+
+	test_active_setup_wait
+	test_active_final
+
+	log_test "Mcast inactive, own querier, no response delay test"
+}
+
+test_vlan_inactive()
+{
+	RET=0
+
+	test_inactive_nolog
+	mcast_vlan_assert_inactive_v4
+	mcast_vlan_assert_inactive_v6
+
+	ip link set dev br0 type bridge vlan_filtering 1
+	ip link set dev br0 type bridge mcast_vlan_snooping 1
+	mcast_vlan_assert_inactive_v4
+	mcast_vlan_assert_inactive_v6
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+
+	ip link set dev br0 type bridge mcast_vlan_snooping 0
+	ip link set dev br0 type bridge vlan_filtering 0
+	test_active_own_querier_nolog
+	ip link set dev br0 type bridge vlan_filtering 1
+	mcast_assert_active_v4
+	mcast_assert_active_v6
+
+	ip link set dev br0 type bridge mcast_vlan_snooping 1
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+
+	test_inactive_nolog
+	log_test "Mcast VLAN inactive test"
+}
+
+test_vlan_active_final()
+{
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+	mcast_vlan_assert_active_v4
+	mcast_vlan_assert_active_v6
+
+	test_vlan_teardown
+	test_inactive_nolog
+}
+
+test_vlan_active_other_querier()
+{
+	RET=0
+
+	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
+	test_active_setup_config "1" "2" ""  ""
+	test_vlan_active_setup_config "1" "2" "3" "4"
+	test_vlan_active_setup_add_vlan
+	test_vlan_active_setup_config_vlan "1" "2" ""  "4"
+	test_active_setup_wait
+	test_vlan_active_final
+
+	log_test "Mcast VLAN active, other querier test"
+}
+
+test_vlan_active_own_querier()
+{
+	RET=0
+
+	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
+	test_active_setup_config "1" "2" ""  ""
+	test_vlan_active_setup_config "1" "2" "3" "4"
+	test_vlan_active_setup_add_vlan
+	test_vlan_active_setup_config_vlan "1" "2" "3" ""
+	test_active_setup_wait
+	test_vlan_active_final
+
+	log_test "Mcast VLAN active, own querier test"
+}
+
+test_vlan_inactive_brdown()
+{
+	RET=0
+
+	test_active_setup_bridge "1" "2" ""  "4" ""  "6"
+	test_active_setup_config "1" "2" ""  ""
+	test_vlan_active_setup_config "1" "2" "3" "4"
+	test_vlan_active_setup_add_vlan
+	test_vlan_active_setup_config_vlan "1" "2" "3" ""
+	test_active_setup_wait
+
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+	mcast_vlan_assert_inactive_v4
+	mcast_vlan_assert_inactive_v6
+
+	test_active_setup_bridge ""  ""  "3" ""  ""  ""
+	mcast_vlan_assert_active_v4
+	mcast_assert_inactive_v6
+
+	test_active_setup_bridge ""  ""  ""  ""  "5" ""
+	test_vlan_active_setup_reset_own_querier
+	test_vlan_active_final
+
+	log_test "Mcast VLAN inactive, bridge down test"
+}
+
+test_vlan_inactive_nov6()
+{
+	RET=0
+
+	test_active_setup_bridge ""  "2" "3" "4" "5" "6"
+	test_active_setup_config "1" "2" ""  ""
+	test_vlan_active_setup_config "1" "2" "3" "4"
+	test_vlan_active_setup_add_vlan
+	test_vlan_active_setup_config_vlan "1" "2" "3" ""
+	test_active_setup_wait
+
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+	mcast_vlan_assert_active_v4
+	mcast_vlan_assert_inactive_v6
+
+	test_active_setup_bridge "1" ""  ""  ""  "5" ""
+	test_vlan_active_setup_reset_own_querier
+	test_vlan_active_final
+
+	log_test "Mcast VLAN inactive, own querier, no IPv6 address test"
+}
+
+test_vlan_inactive_snooping_off()
+{
+	RET=0
+
+	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
+	test_active_setup_config ""  "2" ""  ""
+	test_vlan_active_setup_config "1" "2" "3" "4"
+	test_vlan_active_setup_add_vlan
+	test_vlan_active_setup_config_vlan "1" "2" "3" ""
+	test_active_setup_wait
+
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+	mcast_vlan_assert_inactive_v4
+	mcast_vlan_assert_inactive_v6
+
+	test_active_setup_config "1" ""  ""  ""
+	test_vlan_active_setup_reset_own_querier
+	test_vlan_active_final
+
+	log_test "Mcast VLAN inactive, snooping disabled test"
+}
+
+test_vlan_inactive_vlans_snooping_off()
+{
+	RET=0
+
+	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
+	test_active_setup_config "1" "2" ""  ""
+	test_vlan_active_setup_config "1" "2" ""  "4"
+	test_vlan_active_setup_add_vlan
+	test_vlan_active_setup_config_vlan "1" "2" "3" ""
+	test_active_setup_wait
+
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+	mcast_vlan_assert_inactive_v4
+	mcast_vlan_assert_inactive_v6
+
+	test_vlan_active_setup_config ""  ""  "3" ""
+	test_vlan_active_setup_reset_own_querier
+	test_vlan_active_final
+
+	log_test "Mcast VLAN inactive, snooping for VLANs disabled test"
+}
+
+test_vlan_inactive_vlan_snooping_off()
+{
+	RET=0
+
+	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
+	test_active_setup_config "1" "2" ""  ""
+	test_vlan_active_setup_config "1" "2" "3" "4"
+	test_vlan_active_setup_add_vlan
+	test_vlan_active_setup_config_vlan ""  "2" "3" ""
+	test_active_setup_wait
+
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+	mcast_vlan_assert_inactive_v4
+	mcast_vlan_assert_inactive_v6
+
+	test_vlan_active_setup_config_vlan "1" ""  ""  ""
+	test_vlan_active_setup_reset_own_querier
+	test_vlan_active_final
+
+	log_test "Mcast VLAN inactive, snooping for this VLAN disabled test"
+}
+
+test_vlan_inactive_other_querier_norespdelay()
+{
+	RET=0
+
+	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
+	test_active_setup_config "1" "2" ""  ""
+	test_vlan_active_setup_config "1" "2" "3" "4"
+	test_vlan_active_setup_add_vlan
+	test_vlan_active_setup_config_vlan "1" "2" ""  "4"
+	#test_active_setup_wait
+
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+	mcast_vlan_assert_inactive_v4
+	mcast_vlan_assert_inactive_v6
+
+	test_active_setup_wait
+	test_vlan_active_final
+
+	log_test "Mcast VLAN inactive, other querier, no response delay test"
+}
+
+test_vlan_inactive_own_querier_norespdelay()
+{
+	RET=0
+
+	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
+	test_active_setup_config "1" "2" ""  ""
+	test_vlan_active_setup_config "1" "2" "3" "4"
+	test_vlan_active_setup_add_vlan
+	test_vlan_active_setup_config_vlan "1" "2" "3" ""
+	#test_active_setup_wait
+
+	mcast_assert_inactive_v4
+	mcast_assert_inactive_v6
+	mcast_vlan_assert_inactive_v4
+	mcast_vlan_assert_inactive_v6
+
+	test_active_setup_wait
+	test_vlan_active_final
+
+	log_test "Mcast VLAN inactive, own querier, no response delay test"
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.51.0


