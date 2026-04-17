Return-Path: <netdev+bounces-279323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKIoDn8+4mmB3wAAu9opvQ
	(envelope-from <netdev+bounces-279323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:06:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B09D441BDD8
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58147304C12E
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000F63A2566;
	Fri, 17 Apr 2026 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="VelhJvRX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f100.google.com (mail-ej1-f100.google.com [209.85.218.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D236683B
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434710; cv=none; b=MCljQFnHxmG7c5pL1+YRPCcWP0zAQAeUvhVJyeFKKtq6tmeyGX/X+/0x3j8x83oF9MDvT1N//QQPgWMxJEyeKr0zGem4u6HZT3N5ZZr38FBIBCpVDKVLJWYTIZVsioRxIaVh4GtM3ClXY3q2XyaX+4QELXdNNF6FHVZ8+Q6ArN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434710; c=relaxed/simple;
	bh=u0hdZo/JNllKbNJeHUJYY9k/w3OjhCC1u1t+kNWPwUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hcMm6joVugZiLyfnPyg71iGCsHhdYy3Pwpcmxnz/gJoqiBt79s8cUIyY7JaMHkFYpYdU7m2+vR+eT0Jiww948HiQOGLhjgngCphZ+VLxFexU0frMmm6ZU6Iq1bzHdXievxIbrOshoMHlnHQyTKXaixcA4FvZS4AtSH1MD5XG0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=VelhJvRX; arc=none smtp.client-ip=209.85.218.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f100.google.com with SMTP id a640c23a62f3a-b9382e59c0eso137671666b.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1776434707; x=1777039507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEkSol1jsTK0IMukIV998I+ReEWdKugpT/y2KDP2ZZo=;
        b=VelhJvRXX6JHyhxq/3su2LZaKOUWcZISFa+N0wZ7EDJPGTI7ZEpyu1F9VhojjC7WGZ
         ua0piP/ozN4vhxGLd7+8gFqzpFiSXndkRODIh5KfJOMjSAIaJh45QMowaubo42em0ufc
         TEtD5/u3k7FDWJa8eBgjTKX6AK6142ByZvZps8p4/LQAFQ/4wqoYrLA6WfIydS3AMRFH
         SCxSEhl5m52AJcUlt/ypOGt37TYnM+mIhh0AdEwegoAHJwPHI8kB5ilmL0cXZxy2CdKP
         fqRHF/UD4P82+XqpJsT2+SD6yTVyQMwMYjov1E6hTzk+g1SvsRpGa6jxgNhAQf5dDwTc
         aBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776434707; x=1777039507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BEkSol1jsTK0IMukIV998I+ReEWdKugpT/y2KDP2ZZo=;
        b=fUDO7Oub/SIAtEjz4U8tnOcfKx2Uk5TxtKgY966VQncdgse4wiXtfe+bGDEgYY5oz9
         NVuhVp21fd63ySxW/JQrEm1mm3nsKDjsfc6mgnzi4kNZDv4CJqqvc5fXy5PtvL9FJtoz
         5MlI+QtX6VSW6K6OfNZ3B7JhiIi7StfMytS+vcluwZ8JWIYP17p1mTByY9kTPBLzVR46
         J3WmfwNkM+8o2NPG3M55eajfWpIdPrHy7KznVuyUHCbWxKpyGEwatrp+FB9MP+GGCCPq
         y5bOLnorYzAjTC06s2C3YtRD0BL0UJDvhjGnyTVbW4cpas5+R1xvBJhFU6L8eJ4D3eJo
         l3Sw==
X-Gm-Message-State: AOJu0YwnkilZm3uyaPvDQZ+nArnXtJKXMvbHJ41nA78ggO2sZ2Zng65R
	7ytsBcd8KOr8PV7BQL0REwxn6Aw/UC6kmbe3UgbKTEWzAPyspk7qoh4M0b7MTFdrKgiedfRJHqP
	ITk0kFBdAQg7oYPDuvbd+uKFW/jeD6HxqdDA8
X-Gm-Gg: AeBDiet89GeC7egWHHIODKixTOv9msf801Mi+i2o778Hkeh+Cor2ReUZH05HE0Wnpy5
	ZlB9TxOm9h+iuSjdZSSFBbBdx3IKLCYkBxjNXdYpnF1mR6u1FMQ5qmynmqT7jXznvJD/ZnNfBbf
	9XpGmCDL36mzuSYv6m28wMR16TP19PYk4zxwe6sQ0pIabiveL7oE0qb2IfGQmXh98j8yR/vWxMe
	BIuR/BdgU/J3dWvRqgc/4q0ap2XXg8APG+M6ywcb+JDI+XDsyy/Uf9ZUBmL36M35LG/nPL83bln
	o/tM1CemrbqfEbduXIvRdaFp0SEOQMo1VHM5hOe9C6rhpvTd8TVqmi14aGnhTHAv4H1P/oc/sQm
	yh41auu2OZssIOwKSFsLu5EqR5iU56HphWEmqjZgmiVoVPhOJ5AYk2noROKwZMn4=
X-Received: by 2002:a17:907:70b:b0:ba4:b8d6:c336 with SMTP id a640c23a62f3a-ba4b8d6d9c2mr89712766b.43.1776434707425;
        Fri, 17 Apr 2026 07:05:07 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-ba451307544sm13406466b.26.2026.04.17.07.05.07;
        Fri, 17 Apr 2026 07:05:07 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 3C3D913651;
	Fri, 17 Apr 2026 16:05:07 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v4 4/4] selftests: bonding: add test for lacp_strict mode
Date: Fri, 17 Apr 2026 16:05:05 +0200
Message-Id: <20260417140505.3860237-5-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260417140505.3860237-1-louis.scalbert@6wind.com>
References: <20260417140505.3860237-1-louis.scalbert@6wind.com>
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
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279323-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.977];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:email,6wind.com:dkim,6wind.com:mid,bond_lacp_strict.sh:url]
X-Rspamd-Queue-Id: B09D441BDD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a test for the bonding lacp_strict mode.

Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../drivers/net/bonding/bond_lacp_strict.sh   | 299 ++++++++++++++++++
 2 files changed, 300 insertions(+)
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
index 000000000000..163016eeaea2
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_strict.sh
@@ -0,0 +1,299 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Testing if bond lacp_strict works
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
+setup_ns d_ns p_ns
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
+RET=0
+ip -n "${p_ns}" link set eth0 down
+test_lacp_port_state eth0 $FAILED 5
+test_lacp_port_state eth1 $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 down"
+
+# partner eth0 and eth1 down
+RET=0
+ip -n "${p_ns}" link set eth1 down
+test_lacp_port_state both $FAILED 5
+test_master_carrier down $mode # down because of min_links
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 down"
+
+# partner eth0 up, eth1 down
+RET=0
+ip -n "${p_ns}" link set eth0 up
+test_lacp_port_state eth0 $COLLECTING_DISTRIBUTING 60
+test_lacp_port_state eth1 $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 up, eth1 down"
+
+# partner eth0 and eth1 up
+RET=0
+ip -n "${p_ns}" link set eth1 up
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 60
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 up"
+
+# partner eth0 stops LACP and eth1 up
+RET=0
+ip netns exec "${p_ns}" tc qdisc add dev eth0 root netem loss 100%
+test_lacp_port_state eth0 $FAILED 5
+test_lacp_port_state eth1 $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 stopped sending LACP"
+
+# partner eth0 and eth1 stop LACP
+RET=0
+ip netns exec "${p_ns}" tc qdisc add dev eth1 root netem loss 100%
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
+ip netns exec "${p_ns}" tc qdisc del dev eth0 root
+test_lacp_port_state eth0 $COLLECTING_DISTRIBUTING 60
+test_lacp_port_state eth1 $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 recovered and eth1 stopped sending LACP"
+
+# eth1 recovers LACP
+RET=0
+ip netns exec "${p_ns}" tc qdisc del dev eth1 root
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
+test_lacp_port_state eth0 $FAILED 5
+test_lacp_port_state eth1 $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 down"
+
+# partner eth0 and eth1 down
+RET=0
+ip -n "${p_ns}" link set eth1 down
+test_lacp_port_state both $FAILED 5
+test_master_carrier down $mode # down because of min_links
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 down"
+
+# partner eth0 up, eth1 down
+RET=0
+ip -n "${p_ns}" link set eth0 up
+test_lacp_port_state eth0 $COLLECTING_DISTRIBUTING 60
+test_lacp_port_state eth1 $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 up, eth1 down"
+
+# partner eth0 and eth1 up
+RET=0
+ip -n "${p_ns}" link set eth1 up
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 60
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 up"
+
+# partner eth0 stops LACP and eth1 up
+RET=0
+ip netns exec "${p_ns}" tc qdisc add dev eth0 root netem loss 100%
+test_lacp_port_state eth0 $FAILED 5
+test_lacp_port_state eth1 $COLLECTING_DISTRIBUTING 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 stopped sending LACP"
+
+# partner eth0 and eth1 stop LACP
+RET=0
+ip netns exec "${p_ns}" tc qdisc add dev eth1 root netem loss 100%
+test_lacp_port_state both $FAILED 5
+test_master_carrier down $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 stopped sending LACP"
+
+# eth0 recovers LACP
+RET=0
+ip netns exec "${p_ns}" tc qdisc del dev eth0 root
+test_lacp_port_state eth0 $COLLECTING_DISTRIBUTING 60
+test_lacp_port_state eth1 $FAILED 1
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 recovered and eth1 stopped sending LACP"
+
+# eth1 recovers LACP
+# shellcheck disable=SC2034
+RET=0
+ip netns exec "${p_ns}" tc qdisc del dev eth1 root
+test_lacp_port_state both $COLLECTING_DISTRIBUTING 60
+test_master_carrier up $mode
+log_test "bond LACP" "lacp_strict $mode - eth0 and eth1 recovered LACP"
+
+exit "${EXIT_STATUS}"
-- 
2.39.2


