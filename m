Return-Path: <netdev+bounces-276594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLQ9CsBz1mkWFggAu9opvQ
	(envelope-from <netdev+bounces-276594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:26:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9CB3BE2BA
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1DFE3083543
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7D3D667C;
	Wed,  8 Apr 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="H748oafY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f226.google.com (mail-lj1-f226.google.com [209.85.208.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC535B632
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661840; cv=none; b=VDPmNsjcDJX+IwLZ3tEVi4KzxjExzAS4ZEGGHgxNJbf5qOulHxFunehcSLXnCx67bJ3vvlHh4suC2Xw0NIkR3WUSWJvgqRdRm+eH2zmpbTyNf1SgfdexS7ELioFpdsQDL918SB1grLg42Yf2LUR8Vco8rkpF09w9QbeI5MKlyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661840; c=relaxed/simple;
	bh=uVGoIlzFJy5JBQa6/+GwI5i+LjXHkEcgmnfPmPTmzLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o19FpA0Kse6gXIziCJVSssJT6TOSsENq0GAEdLJu3WSkojifOHGEgYQ7RkeP3z0LENUZ7IaQMuDVLJ2ltq/7lDhxEPN8fX0VSNV9C+EGTYwxXlKfJi2Fnge2b5sz3pL1MTwye8lUkhft82J9xp0r5P7AT+lxVQEdoK/04mZva0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=H748oafY; arc=none smtp.client-ip=209.85.208.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f226.google.com with SMTP id 38308e7fff4ca-38e0ef48ac0so122831fa.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1775661837; x=1776266637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CN/GTjLSzraxY8cJ12mi96G5hr8DHvRwtBAQqpyKJOk=;
        b=H748oafYlnz5HZ/XiLWYe7n8KfGuhL9pCSFf+ltTkW/b4RXSI/evcQhv1ryTZFL3fE
         k3CBBNOU2IR4uZZyTrRr4wMjdOxaUmKEFZS3R60GM42iHaqqUwPIZr0vlrzmDCAnDn1v
         p97lzdh0ulgqEd5mwfNT63oyhlkFRDyzFkuMUhZHn1JejTHT9dRBI4ALYk6w+DyWgpND
         j4yEcqDMuGC0SCa6lHp25j83mUUASJzyNxOsBKlySo6af9DaEDpG9Nc9yxRcRcnFHNZk
         q8u9OTpcXVfqfNmY+AE/cxzbEjT/m2NCimj+AA+0f/9gyQEg464DzkWjhK5psXhbVF3V
         MwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661837; x=1776266637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CN/GTjLSzraxY8cJ12mi96G5hr8DHvRwtBAQqpyKJOk=;
        b=Xl/72HE8kefnZR6t0jMRtZpb1HG8I1FarGtlQSkbM1LKeouaze2FCtT+BEZfxt8Syp
         xMF0GUX8FoHqFZv5BZuReuvFqbwcQfUWgxeuDcFnFoirxrQusFbBqlBxL26E0NEBBQJ0
         5wUVwJiezvSfMCqqEeTNp5SmQgeZ8FHA6XKzjIwYanq9NNNFXVR9y8s7mu/E6fa/lJuV
         F3/75W4mDkub7DH8izwBSYwK6vbvTaopZ0Ta+izz0gpZUhygB3p75/sGxCNhKstwbm9T
         CbRX/v1Fo1GysTQo/R6tz1ReZDkZf7tSH7kXtHXwmfaFFiL/90d7gNkVdb8Rk5u6oRRu
         fhsA==
X-Gm-Message-State: AOJu0YwkiZA//MidDvt3c2v3GoWC6dV4ljlm6p4JhOMp5/LW0tqbSPcI
	D8xb4q6n/4KIP5dJnl+Q7pwG0/mH6Vadbx+q9xHgopJ6RU0LMt+VEAUS/0DE5Zpr3d8BsAXuKpS
	5KvCmXVjnN1lSMsJLgxK6Rn5GMekPPxw/fkD9
X-Gm-Gg: AeBDieucpld5cdsTa8EE2btcOLxe3lTL/o2LZoshsOMTIEhPT6FNt1rP7PFowL3B/WZ
	uwc2yoeLLUzU7oyS2jEPFZSnydmtE2uDj+HjYu5qXvVChV/uo+vt5FgciQSu6nf61gEqouQuRZl
	U8UG7hSM08IOaM4QFA9otuyGqIdOQnUqJo6KNTaWTSHbt+pa7RMR/KNKOXNifjqu52DbimGKlF5
	qkumK9vPx0DaYB1O6JwSgsGwVd2XNmAKZCgVn1edjJK3ItNefQdNHLZhEw/Zj16ldjMEuxrFduG
	ibByDZ8UwLzdm71y3tON72BaCYMiCKmxLipJB3snA+0FjU7n12chs3430Msm1PHn3Mje0V/s1a6
	5sAst/4eudC4QXsquoNWFh0/+FWFfs4X48fmZB0sj2k+TQY8H4BXe
X-Received: by 2002:a05:651c:f09:b0:38e:2183:2282 with SMTP id 38308e7fff4ca-38e336c6bcfmr362581fa.23.1775661837328;
        Wed, 08 Apr 2026 08:23:57 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 38308e7fff4ca-38cd1e159c9sm17305551fa.0.2026.04.08.08.23.57;
        Wed, 08 Apr 2026 08:23:57 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id C746F27056;
	Wed,  8 Apr 2026 17:23:56 +0200 (CEST)
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
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v3 5/5] selftests: bonding: add test for fallback mode
Date: Wed,  8 Apr 2026 17:23:53 +0200
Message-Id: <20260408152353.276204-6-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260408152353.276204-1-louis.scalbert@6wind.com>
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276594-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid,bond_lacp_fallback.sh:url]
X-Rspamd-Queue-Id: 8A9CB3BE2BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a test for the bonding legacy and strict LACP fallback modes.

Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../drivers/net/bonding/bond_lacp_fallback.sh | 299 ++++++++++++++++++
 2 files changed, 300 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_fallback.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 6c5c60adb5e8..a117bf2e483b 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -7,6 +7,7 @@ TEST_PROGS := \
 	bond-eth-type-change.sh \
 	bond-lladdr-target.sh \
 	bond_ipsec_offload.sh \
+	bond_lacp_fallback.sh \
 	bond_lacp_prio.sh \
 	bond_macvlan_ipvlan.sh \
 	bond_options.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_fallback.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_fallback.sh
new file mode 100755
index 000000000000..a983a2c2ea17
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_fallback.sh
@@ -0,0 +1,299 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Testing if bond lacp_fallback works
+#
+#          Partner (p_ns)
+#  +-------------------------+
+#  |          bond0          |
+#  |            +            |
+#  |      eth0  |  eth1      |
+#  |        +---+---+        |
+#  |        |       |        |
+#  +-------------------------+
+#           |       |
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
+	ip -n "${d_ns}" link add eth0 type veth peer name eth0 netns "${p_ns}"
+	ip -n "${d_ns}" link add eth1 type veth peer name eth1 netns "${p_ns}"
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
+	echo "FAIL: Expected carrier $expected in $mode_name mode, got $carrier"
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
+setup_ns d_ns p_ns
+setup_links
+
+# Initial state
+RET=0
+mode=legacy
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 3
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 and eth1 up"
+
+# partner eth0 down, eth1 up
+RET=0
+ip -n "${p_ns}" link set eth0 down
+test_lacp_port_state eth0 $FAILED 5
+test_lacp_port_state eth1 $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 down"
+
+# partner eth0 and eth1 down
+RET=0
+ip -n "${p_ns}" link set eth1 down
+test_lacp_port_state both $FAILED 5
+test_master_carrier down $mode # down because of min_links
+log_test "bond LACP" "$mode fallback - eth0 and eth1 down"
+
+# partner eth0 up, eth1 down
+RET=0
+ip -n "${p_ns}" link set eth0 up
+test_lacp_port_state eth0 $COLLECTING_DISTRIBUTING 60
+test_lacp_port_state eth1 $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 up, eth1 down"
+
+# partner eth0 and eth1 up
+RET=0
+ip -n "${p_ns}" link set eth1 up
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 60
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 and eth1 up"
+
+# partner eth0 stops LACP and eth1 up
+RET=0
+ip netns exec "${p_ns}" tc qdisc add dev eth0 root netem loss 100%
+test_lacp_port_state eth0 $FAILED 5
+test_lacp_port_state eth1 $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 stopped sending LACP"
+
+# partner eth0 and eth1 stop LACP
+RET=0
+ip netns exec "${p_ns}" tc qdisc add dev eth1 root netem loss 100%
+test_lacp_port_state both $FAILED 5
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 and eth1 stopped sending LACP"
+
+# switch to lacp_fallback strict
+RET=0
+mode=strict
+ip -n "${d_ns}" link set dev bond0 type bond lacp_fallback $mode
+test_lacp_port_state both $FAILED 1
+test_master_carrier down $mode 5
+log_test "bond LACP" "$mode fallback - eth0 and eth1 stopped sending LACP"
+
+# switch back to lacp_fallback legacy mode
+RET=0
+mode=legacy
+ip -n "${d_ns}" link set dev bond0 type bond lacp_fallback $mode
+test_lacp_port_state both $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 and eth1 stopped sending LACP"
+
+# eth0 recovers LACP
+RET=0
+ip netns exec "${p_ns}" tc qdisc del dev eth0 root
+test_lacp_port_state eth0 $COLLECTING_DISTRIBUTING 60
+test_lacp_port_state eth1 $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 recovered and eth1 stopped sending LACP"
+
+# eth1 recovers LACP
+RET=0
+ip netns exec "${p_ns}" tc qdisc del dev eth1 root
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 60
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 and eth1 recovered LACP"
+
+# switch to lacp_fallback strict
+RET=0
+mode=strict
+ip -n "${d_ns}" link set dev bond0 type bond lacp_fallback $mode
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 and eth1 up"
+
+# partner eth0 down, eth1 up
+RET=0
+ip -n "${p_ns}" link set eth0 down
+test_lacp_port_state eth0 $FAILED 5
+test_lacp_port_state eth1 $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 down"
+
+# partner eth0 and eth1 down
+RET=0
+ip -n "${p_ns}" link set eth1 down
+test_lacp_port_state both $FAILED 5
+test_master_carrier down $mode # down because of min_links
+log_test "bond LACP" "$mode fallback - eth0 and eth1 down"
+
+# partner eth0 up, eth1 down
+RET=0
+ip -n "${p_ns}" link set eth0 up
+test_lacp_port_state eth0 $COLLECTING_DISTRIBUTING 60
+test_lacp_port_state eth1 $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 up, eth1 down"
+
+# partner eth0 and eth1 up
+RET=0
+ip -n "${p_ns}" link set eth1 up
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 60
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 and eth1 up"
+
+# partner eth0 stops LACP and eth1 up
+RET=0
+ip netns exec "${p_ns}" tc qdisc add dev eth0 root netem loss 100%
+test_lacp_port_state eth0 $FAILED 5
+test_lacp_port_state eth1 $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 stopped sending LACP"
+
+# partner eth0 and eth1 stop LACP
+RET=0
+ip netns exec "${p_ns}" tc qdisc add dev eth1 root netem loss 100%
+test_lacp_port_state both $FAILED 5
+test_master_carrier down $mode
+log_test "bond LACP" "$mode fallback - eth0 and eth1 stopped sending LACP"
+
+# eth0 recovers LACP
+RET=0
+ip netns exec "${p_ns}" tc qdisc del dev eth0 root
+test_lacp_port_state eth0 $COLLECTING_DISTRIBUTING 60
+test_lacp_port_state eth1 $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 recovered and eth1 stopped sending LACP"
+
+# eth1 recovers LACP
+# shellcheck disable=SC2034
+RET=0
+ip netns exec "${p_ns}" tc qdisc del dev eth1 root
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 60
+test_master_carrier up $mode
+log_test "bond LACP" "$mode fallback - eth0 and eth1 recovered LACP"
+
+exit "${EXIT_STATUS}"
-- 
2.39.2


