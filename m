Return-Path: <netdev+bounces-301754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KGY3Gv8fPGrnkAgAu9opvQ
	(envelope-from <netdev+bounces-301754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:20:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C156C0B52
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:20:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WtLhPchU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301754-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301754-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F15CE3027A5F
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118632E72F;
	Wed, 24 Jun 2026 18:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB732B112
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 18:20:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325229; cv=none; b=E87wMTzF97JX0rcQ6i4YxMuj9MMg18Rc4h5d8IjaMlofPrjhdEP8JzulWNrgf7dgITMDd+BuQJay1gwd4BtlfhUpJ4yvNCK9CBMIa0w+EKxbb6Yct/G4SUyJNN7+PumMkq2E4rkdmkrpMwnr5J9Df4Ei+DZgdF6pQhKWYSKR23s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325229; c=relaxed/simple;
	bh=JLj6+8emOGuQT7VUNYFRQ1Q2Yj0hzaajhlUtg6OfIbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XV5xNFv2TBf6NRFecdI3SiOuL6GD2EqHu5IjXE5zLRTPAJp2l95FClPxcxDjHfDxYt/yv1MHKtvXScez0ht+Evjcb6rUBKPZjU8MvEMvCXw393rQ3mhAScdHgcGTpITOBZUz0Zkvk8CpzNz6j0pmk+Zo8ZO6uFW+G/tiBHXon0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtLhPchU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615A01F00A3D;
	Wed, 24 Jun 2026 18:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782325228;
	bh=rcdgQDLCZEenTfwCqMh5P+z7A8VUOpE6TEWJqqUaC4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WtLhPchU46Ddv8O7aE6TfCBNX0UCDNcCXvT6p3du1qGNpygJDCPaf+tNCXON6DReR
	 dPN+IvxtFGXc/sL0hxHVhy+WHnJybX5WVsjXy/iUWghpDj1AdnY0ehqDL6q4hiZGMp
	 fXEVDunujMuDcTMUEioWdWYdkWqQTK/afEJFICFL/1zfefJE7ZkMozkqXf842hcmrj
	 OVIOEofUzab8Kr73oQXD2C/QWjuraHS5G4f9gXQV6EfAdnaeRyLXCP8LMCN4dSH0Oh
	 IVAufy/SNiXPjuHzRWYetgOftrP0vNHm66XDj+AVCHmryi8gZ7mtOW0FV13YZ4N0Gu
	 y4lNjbD3Y0OOg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jv@jvosburgh.net,
	sdf@fomichev.me,
	dongchenchen2@huawei.com,
	idosch@nvidia.com,
	n05ec@lzu.edu.cn,
	yuantan098@gmail.com,
	kuniyu@google.com,
	nb@tipi-net.de,
	aleksandr.loktionov@intel.com,
	dtatulea@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 4/4] selftests: bonding: add a test for VLAN propagation over a bonded real device
Date: Wed, 24 Jun 2026 11:20:18 -0700
Message-ID: <20260624182018.2445732-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624182018.2445732-1-kuba@kernel.org>
References: <20260624182018.2445732-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301754-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:jv@jvosburgh.net,m:sdf@fomichev.me,m:dongchenchen2@huawei.com,m:idosch@nvidia.com,m:n05ec@lzu.edu.cn,m:yuantan098@gmail.com,m:kuniyu@google.com,m:nb@tipi-net.de,m:aleksandr.loktionov@intel.com,m:dtatulea@nvidia.com,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,jvosburgh.net,fomichev.me,huawei.com,nvidia.com,lzu.edu.cn,gmail.com,tipi-net.de,intel.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,bond_vlan_real_dev.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16C156C0B52

Add a regression test for the VLAN notifier handling that the netdev_work
deferral fixed.

A VLAN's real device propagates its UP/DOWN, MTU and feature changes onto
the VLANs stacked on top of it. This used to be done synchronously from the
real device's notifier and deadlocked when the real device was brought up
while enslaved to a bond (instance lock held across NETDEV_UP) and the VLAN
on top was itself a bond member: the synchronous propagation re-entered the
stack and took the same instance lock again.

The test covers both halves:
 - that the deferred UP/DOWN, MTU and feature propagation actually lands on
   the VLAN (link state and MTU use an ops-locked dummy, i.e. the deferral
   path; features use veth, which exports vlan_features to inherit), and
 - that the deadlock-prone topology - a VLAN on a dummy, with the VLAN and
   the dummy each enslaved to a different bond - can be built without
   hanging.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../drivers/net/bonding/bond_vlan_real_dev.sh | 180 ++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_vlan_real_dev.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index be130bf585a4..6364ca02642d 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -13,6 +13,7 @@ TEST_PROGS := \
 	bond_options.sh \
 	bond_passive_lacp.sh \
 	bond_stacked_header_parse.sh \
+	bond_vlan_real_dev.sh \
 	dev_addr_lists.sh \
 	mode-1-recovery-updelay.sh \
 	mode-2-recovery-updelay.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_vlan_real_dev.sh b/tools/testing/selftests/drivers/net/bonding/bond_vlan_real_dev.sh
new file mode 100755
index 000000000000..542d9ffc4819
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_vlan_real_dev.sh
@@ -0,0 +1,180 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test propagation of a real device's state to the VLANs stacked on top of it
+# when the real device is (or becomes) a bond member.
+#
+# The kernel mirrors a real device's UP/DOWN, MTU and feature changes onto its
+# VLANs.  This is done asynchronously (netdev_work): doing it synchronously from
+# the real device's notifier could deadlock.  If the real device is brought up
+# while enslaved to a bond - so its instance lock is held across NETDEV_UP - and
+# a VLAN on top of it is itself a bond member, the synchronous propagation
+# re-entered the stack and tried to take the same instance lock again.
+#
+# Cover both halves:
+#  - the deferred UP/DOWN, MTU and feature propagation actually lands on the
+#    VLAN (link state and MTU use an ops-locked dummy, i.e. the deferral path),
+#  - the deadlock-prone topology - a VLAN on a dummy, with the VLAN and the
+#    dummy each enslaved to a different bond - can be built without hanging.
+
+ALL_TESTS="
+	vlan_link_state
+	vlan_mtu
+	vlan_features
+	vlan_real_dev_enslave
+"
+
+REQUIRE_MZ=no
+NUM_NETIFS=0
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
+
+# Return 0 if $dev in netns $ns has flag $flag set (e.g. UP) in its <...> flags.
+link_has_flag()
+{
+	local ns=$1 dev=$2 flag=$3
+
+	ip -n "$ns" link show dev "$dev" 2>/dev/null | grep -q "[<,]${flag}[,>]"
+}
+
+link_lacks_flag()
+{
+	! link_has_flag "$@"
+}
+
+link_mtu_is()
+{
+	local ns=$1 dev=$2 want=$3 cur
+
+	cur=$(ip -n "$ns" link show dev "$dev" 2>/dev/null | \
+		sed -n 's/.* mtu \([0-9]\+\).*/\1/p')
+	[ "$cur" = "$want" ]
+}
+
+vlan_feature_is()
+{
+	local ns=$1 dev=$2 feature=$3 value=$4
+
+	ip netns exec "$ns" ethtool -k "$dev" 2>/dev/null | \
+		grep -q "^$feature: $value"
+}
+
+link_has_master()
+{
+	local ns=$1 dev=$2 master=$3
+
+	ip -n "$ns" -o link show dev "$dev" 2>/dev/null | grep -q "master $master"
+}
+
+vlan_link_state()
+{
+	RET=0
+
+	ip -n "$NS" link add ls_dummy type dummy
+	ip -n "$NS" link add link ls_dummy name ls_vlan type vlan id 100
+
+	# Bringing the real device up must propagate UP to the VLAN.
+	ip -n "$NS" link set ls_dummy up
+	busywait "$BUSYWAIT_TIMEOUT" link_has_flag "$NS" ls_vlan UP
+	check_err $? "VLAN did not go UP after the real device went UP"
+
+	# ... and likewise for DOWN.
+	ip -n "$NS" link set ls_dummy down
+	busywait "$BUSYWAIT_TIMEOUT" link_lacks_flag "$NS" ls_vlan UP
+	check_err $? "VLAN did not go DOWN after the real device went DOWN"
+
+	ip -n "$NS" link del ls_vlan
+	ip -n "$NS" link del ls_dummy
+
+	log_test "VLAN link state follows the real device"
+}
+
+vlan_mtu()
+{
+	RET=0
+
+	# The VLAN inherits the real device's MTU (2000) at creation time.
+	ip -n "$NS" link add mtu_dummy mtu 2000 type dummy
+	ip -n "$NS" link add link mtu_dummy name mtu_vlan type vlan id 100
+
+	# Shrinking the real device's MTU must clamp the VLAN's MTU.
+	ip -n "$NS" link set mtu_dummy mtu 1500
+	busywait "$BUSYWAIT_TIMEOUT" link_mtu_is "$NS" mtu_vlan 1500
+	check_err $? "VLAN MTU not clamped after the real device's MTU shrank"
+
+	ip -n "$NS" link del mtu_vlan
+	ip -n "$NS" link del mtu_dummy
+
+	log_test "VLAN MTU clamped to the real device"
+}
+
+vlan_features()
+{
+	RET=0
+
+	# Use veth as the real device: unlike dummy it exports vlan_features, so
+	# the VLAN actually inherits a toggleable offload to assert on.
+	ip -n "$NS" link add ft_veth type veth peer name ft_veth_pr
+	ip -n "$NS" link add link ft_veth name ft_vlan type vlan id 100
+
+	vlan_feature_is "$NS" ft_vlan scatter-gather on
+	check_err $? "VLAN did not inherit scatter-gather from the real device"
+
+	# Toggling the offload on the real device must propagate to the VLAN.
+	ip netns exec "$NS" ethtool -K ft_veth sg off
+	busywait "$BUSYWAIT_TIMEOUT" \
+		vlan_feature_is "$NS" ft_vlan scatter-gather off
+	check_err $? "VLAN scatter-gather still on after disabling it on real dev"
+
+	ip netns exec "$NS" ethtool -K ft_veth sg on
+	busywait "$BUSYWAIT_TIMEOUT" \
+		vlan_feature_is "$NS" ft_vlan scatter-gather on
+	check_err $? "VLAN scatter-gather still off after enabling it on real dev"
+
+	ip -n "$NS" link del ft_vlan
+	ip -n "$NS" link del ft_veth
+
+	log_test "VLAN features follow the real device"
+}
+
+vlan_real_dev_enslave()
+{
+	RET=0
+
+	# dummy <- VLAN -> bond0, then enslave the dummy itself to bond1.  The
+	# last step brings the dummy up under bond1's instance lock, which used
+	# to deadlock while synchronously propagating UP to the (bond-enslaved)
+	# VLAN on top.
+	ip -n "$NS" link add dl_dummy type dummy
+	ip -n "$NS" link set dl_dummy up
+	ip -n "$NS" link add link dl_dummy name dl_vlan type vlan id 100
+
+	ip -n "$NS" link add dl_bond0 type bond mode active-backup
+	ip -n "$NS" link set dl_vlan down
+	ip -n "$NS" link set dl_vlan master dl_bond0
+	check_err $? "could not enslave the VLAN to bond0"
+
+	ip -n "$NS" link add dl_bond1 type bond mode active-backup
+	ip -n "$NS" link set dl_dummy down
+	ip -n "$NS" link set dl_dummy master dl_bond1
+	check_err $? "could not enslave the real device to bond1"
+
+	# If we got here the kernel did not deadlock; make sure it is still
+	# responsive and the enslave really took effect.
+	link_has_master "$NS" dl_dummy dl_bond1
+	check_err $? "real device not enslaved to bond1"
+
+	ip -n "$NS" link del dl_bond1
+	ip -n "$NS" link del dl_bond0
+	ip -n "$NS" link del dl_vlan
+	ip -n "$NS" link del dl_dummy
+
+	log_test "VLAN real device enslaved to a second bond"
+}
+
+setup_ns NS
+trap 'cleanup_ns $NS' EXIT
+
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.54.0


