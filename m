Return-Path: <netdev+bounces-275098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLD7NHHYz2mb1AYAu9opvQ
	(envelope-from <netdev+bounces-275098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:10:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B943959D2
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 692F4314A022
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5F3CE4AD;
	Fri,  3 Apr 2026 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BubxWlLq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E223CBE79
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228499; cv=none; b=AB4bEwJ18IjazGq77hNNDF3HQ6OFShJn+WtRDmgDH04Geofy0VWU6lKNsV4v92JownH0JJ2S8RLJEJrciyDdb4NgFuvkdsK5rWByax6KoacCW2JkU0RzbQk5VK+WPGlOTdbQmq0XjbcV6EGTjPTZTAmWF/FTvUQKS9SMDDlV/OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228499; c=relaxed/simple;
	bh=4LeT1cJ+asqbP8EaYg7MOJK/G//aZNU+VpLMKTbgT3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwrRe+FwZc/M5cw9H3aB+tNIR13+Jh3pYGfUosiAbiB8rd+89h/+8q9kT5oH8PdsQexUNPRFEcZSFf6kgjLp6MUBa/9uiQLjTEqhJ0KWQ/2BpsNzmuRzPbikwEpDmxWtl360TPLTkZ8+cim41vm7/t3EH+BsUA053IRp+3C/I54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BubxWlLq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82ce09b61beso921049b3a.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228497; x=1775833297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjltsPsyl0fA4bSmkbZpBvZZ8hQ+nYEUswOg9yantuE=;
        b=BubxWlLqoybWJMSpG7OovPTbP0xjrORg17brdwAOkgNeqsS5e0p1cHawflsxUxcVAt
         DjLWridLfo0gsKU8en6jwyQwp/glaju5aP5OkvcGXuR7zPKIfB4nXl9RyQu9ZguRpxp2
         9OWKtoia+2s4SSahWnqodulNSr/MrC30n1VRUtdQY96d3fB9TEhmHZ84Dtir+W9Hzp1I
         qFdpC1ssU6uRCPNHF3H6nSobta4lY18u8x8Jevp5CLeWKpKu6meg3Z+85Lrn8i/xS09e
         1gfsmm9sYW6pWSApq+t7Es7EqkPJE8AdR8BJBOGJIuORSNshSzGXmsbZ0GSD+3DQ4+Ca
         geAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228497; x=1775833297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VjltsPsyl0fA4bSmkbZpBvZZ8hQ+nYEUswOg9yantuE=;
        b=f/5CiFdTeP5dRLuF1a0W7LhTCskB4/SJj3AHRdVti46zH3Pa4RJk1hyF2/klx0rUQW
         OvQEZrUzun4tylGL+bUIa4/68yG5kqR3iwMSaOBICmvvUzZ3LGMgJo98kzYeYHFXu5/H
         2gKq+rvNUc5wN2CMyk7G46TtemtHL7RkUzeUZPfD2VWnYWpHZdmP2HmJLE5y0P/KYYIS
         FSumbn1727n01Ea4kaNPcc3zWdlaxL27S4ENggTqr1CxWFHK7rhYEXTckSLc0GnpbHwF
         2834cf1SguKCp2Vd0GBKkW/EG1Vae3HWPx4EXUITs8JQ0lkfq4v7YflGGvGCV7h+lIkg
         nSqg==
X-Forwarded-Encrypted: i=1; AJvYcCWbw81nbH+SQPWx1Aw4qpI3dt8FLOWs6BVsosgXIg5OTtNAu9TrMwKOF2U6dQ+8TfbF5IjmeOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpKRouwoIf4lTtEtQX6bSM+VXOkW7SwFMtb/FEj9YDrk7v6Jc
	T0UZsu2o2gV7ktG052OpNcm0lmHMRoqqH42pubfLZrC2043eDUz0cwQW
X-Gm-Gg: AeBDiev6TecgXzQC12rbmfghhUCJYaBFsVsJbMx2rz9r6mFlJhGfsROGLUpu7M1NA3+
	9Z/63j+JlcQcKqds46m0+vTC1n05lPkguQ5/kq/OSmP3NzUqNkdQ+itS0bjLDQV3eWlY5LXvON2
	25LUx8QC5TOaSeohlWPwua0/F9/AkfELF14FYdHtqeRKNiOdR3XGAoWMHnmQMFXyDDrHCtDt76j
	lxQwxq1c0Nw4YiqsRBvnkN9ynsPrtGhQrWrq6HermGnCfCStYzHr9S5jZtY445JbSxzPSe52swl
	ut1pSpNnodbqArZr5+DORWbSfZ211zPyMdPJIHpKeAbsIP+vahJo7OBDHEe7g9+AMDk2KE60qle
	eWdlJwZyN2g738q5sXGVx4kNji3ZbhLIYaC4TDV7Vi7UgiCptRP8WisZ/Fzt4I3WKh+g00i7fCj
	GT5BPrFNI9Ky+EBhkVZ0ddXeUHVCTyJpFPSLn9EcIg
X-Received: by 2002:a05:6a00:2d10:b0:82c:66f2:1226 with SMTP id d2e1a72fcca58-82d0db84a62mr3307715b3a.38.1775228496765;
        Fri, 03 Apr 2026 08:01:36 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca79basm7789483b3a.58.2026.04.03.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:01:34 -0700 (PDT)
From: Ujjal Roy <royujjal@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 5/5] selftests: net: bridge: add tests for MRC and QQIC validation
Date: Fri,  3 Apr 2026 15:00:50 +0000
Message-ID: <20260403150050.1235-6-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403150050.1235-1-royujjal@gmail.com>
References: <20260403150050.1235-1-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-275098-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53B943959D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update bridge selftests that configure Max Resp Time (MRT) and Querier
Query Interval (QQI) parameters and validate the resulting Query packet
fields for Max Resp Code (MRC) and Querier Query Interval Code (QQIC).

These tests cover the IGMPv3 and MLDv2 for below cases:
* MRC and QQIC in linear range.
* MRC and QQIC in non-linear range.

TEST: Vlan multicast snooping enable                                [ OK ]
TEST: Vlan mcast_query_interval global option default value         [ OK ]
Vlan 10 mcast_query_interval (QQIC) test cases:
TEST: Number of tagged IGMPv2 general query                         [ OK ]
TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
TEST: MLDv2 QQIC linear value 60                                    [ OK ]
TEST: IGMPv3 QQIC non linear value 160                              [ OK ]
TEST: MLDv2 QQIC non linear value 160                               [ OK ]
TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
Vlan 10 mcast_query_response_interval (MRC) test cases:
TEST: IGMPv3 MRC linear value 60                                    [ OK ]
TEST: IGMPv3 MRC non linear value 160                               [ OK ]
TEST: MLDv2 MRC linear value 30000                                  [ OK ]
TEST: MLDv2 MRC non linear value 60000                              [ OK ]

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 .../selftests/net/forwarding/.gitignore       |   2 +
 .../testing/selftests/net/forwarding/Makefile |  10 ++
 .../net/forwarding/bridge_vlan_mcast.sh       | 157 +++++++++++++++++-
 .../selftests/net/forwarding/mc_decode.c      |  73 ++++++++
 .../selftests/net/forwarding/mc_encode.c      |  78 +++++++++
 5 files changed, 315 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/net/forwarding/mc_decode.c
 create mode 100644 tools/testing/selftests/net/forwarding/mc_encode.c

diff --git a/tools/testing/selftests/net/forwarding/.gitignore b/tools/testing/selftests/net/forwarding/.gitignore
index 418ff96c52ef..aa0c7f1afb4b 100644
--- a/tools/testing/selftests/net/forwarding/.gitignore
+++ b/tools/testing/selftests/net/forwarding/.gitignore
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 forwarding.config
 ipmr
+mc_encode
+mc_decode
diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index bbaf4d937dd8..a26da846632d 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -1,5 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
+top_srcdir = ../../../../..
+
+CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
+CFLAGS += -I$(top_srcdir)/tools/include
+
+TEST_GEN_FILES := \
+	mc_encode \
+	mc_decode \
+# end of TEST_GEN_FILES
+
 TEST_PROGS := \
 	bridge_activity_notify.sh \
 	bridge_fdb_learning_limit.sh \
diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index 72dfbeaf56b9..89598712f869 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -5,6 +5,7 @@ ALL_TESTS="vlmc_control_test vlmc_querier_test vlmc_igmp_mld_version_test \
 	   vlmc_last_member_test vlmc_startup_query_test vlmc_membership_test \
 	   vlmc_querier_intvl_test vlmc_query_intvl_test vlmc_query_response_intvl_test \
 	   vlmc_router_port_test vlmc_filtering_test"
+TEST_NAME=""
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -96,6 +97,17 @@ cleanup()
 	vrf_cleanup
 }
 
+check_binary()
+{
+	local cmd=$1; shift
+	local args=$@
+
+	if [[ ! -x "$(command -v "$cmd")" ]]; then
+		log_test_skip "$args $cmd not found"
+		return $EXIT_STATUS
+	fi
+}
+
 vlmc_v2join_test()
 {
 	local expect=$1
@@ -162,14 +174,27 @@ vlmc_query_cnt_setup()
 {
 	local type=$1
 	local dev=$2
+	local intvl_match="$3"
 
 	if [[ $type == "igmp" ]]; then
+		# This matches: IP Protocol 2 (IGMP)
 		tc filter add dev $dev egress pref 10 prot 802.1Q \
 			flower vlan_id 10 vlan_ethtype ipv4 dst_ip 224.0.0.1 ip_proto 2 \
+			action continue
+		# AND Type 0x11 (Query) at offset 24 after IP
+		# IP (20 byte IP + 4 bytes Option)
+		tc filter add dev $dev egress pref 20 prot 802.1Q u32 \
+			match u8 0x11 0xff at 24 $intvl_match \
 			action pass
 	else
+		# This matches: ICMPv6
 		tc filter add dev $dev egress pref 10 prot 802.1Q \
 			flower vlan_id 10 vlan_ethtype ipv6 dst_ip ff02::1 ip_proto icmpv6 \
+			action continue
+		# AND Type 0x82 (Query) at offset 48 after IPv6
+		# IPv6 (40 bytes IPv6 + 2 bytes next HDR + 4 bytes Option + 2 byte pad)
+		tc filter add dev $dev egress pref 20 prot 802.1Q u32 \
+			match u8 0x82 0xff at 48 $intvl_match \
 			action pass
 	fi
 
@@ -181,9 +206,46 @@ vlmc_query_cnt_cleanup()
 	local dev=$1
 
 	ip link set dev br0 type bridge mcast_stats_enabled 0
+	tc filter del dev $dev egress pref 20
 	tc filter del dev $dev egress pref 10
 }
 
+vlmc_query_get_intvl_match()
+{
+	local type=$1
+	local version=$2
+	local interval=$3
+	local encode=""
+
+	if [ "$interval" = "" ]; then
+		return
+	fi
+
+	if [ "$TEST_NAME" = "vlmc_query_intvl_test" ]; then
+		# QQIC is 8-bit floating point encoding for IGMPv3 and MLDv2
+		encode="$(./mc_encode 8 $interval)"
+		if [ "${type}v${version}" = "igmpv3" ]; then
+			# IP 20 bytes + 4 bytes Option + IGMPv3[9]
+			echo "match u8 $encode 0xff at 33"
+		elif [ "${type}v${version}" = "mldv2" ]; then
+			# IPv6 40 + 2 next HDR + 4 Option + 2 pad + MLDv2[25]
+			echo "match u8 $encode 0xff at 73"
+		fi
+	elif [ "$TEST_NAME" = "vlmc_query_response_intvl_test" ]; then
+		if [ "${type}v${version}" = "igmpv3" ]; then
+			# MRC is 8-bit floating point encoding for MLDv2
+			encode="$(./mc_encode 8 $interval)"
+			# IP 20 bytes + 4 bytes Option + IGMPv3[1]
+			echo "match u8 $encode 0xff at 25"
+		elif [ "${type}v${version}" = "mldv2" ]; then
+			# MRC is 16-bit floating point encoding for MLDv2
+			encode="$(./mc_encode 16 $interval)"
+			# IPv6 40 + 2 next HDR + 4 Option + 2 pad + MLDv2[4]
+			echo "match u16 $encode 0xffff at 52"
+		fi
+	fi
+}
+
 vlmc_check_query()
 {
 	local type=$1
@@ -191,9 +253,12 @@ vlmc_check_query()
 	local dev=$3
 	local expect=$4
 	local time=$5
+	local interval=$6
+	local intvl_match=""
 	local ret=0
 
-	vlmc_query_cnt_setup $type $dev
+	intvl_match="$(vlmc_query_get_intvl_match $type $version $interval)"
+	vlmc_query_cnt_setup $type $dev "$intvl_match"
 
 	local pre_tx_xstats=$(vlmc_query_cnt_xstats $type $version $dev)
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_querier 1
@@ -201,7 +266,7 @@ vlmc_check_query()
 	if [[ $ret -eq 0 ]]; then
 		sleep $time
 
-		local tcstats=$(tc_rule_stats_get $dev 10 egress)
+		local tcstats=$(tc_rule_stats_get $dev 20 egress)
 		local post_tx_xstats=$(vlmc_query_cnt_xstats $type $version $dev)
 
 		if [[ $tcstats != $expect || \
@@ -428,6 +493,10 @@ vlmc_querier_intvl_test()
 
 vlmc_query_intvl_test()
 {
+	TEST_NAME="vlmc_query_intvl_test"
+
+	check_binary "./mc_encode" "$TEST_NAME: verify" || return 1
+
 	RET=0
 	local goutput=`bridge -j vlan global show`
 	echo -n $goutput |
@@ -440,6 +509,7 @@ vlmc_query_intvl_test()
 	check_err $? "Wrong default mcast_query_interval global vlan option value"
 	log_test "Vlan mcast_query_interval global option default value"
 
+	echo "Vlan 10 mcast_query_interval (QQIC) test cases:"
 	RET=0
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 0
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 200
@@ -447,14 +517,52 @@ vlmc_query_intvl_test()
 	# 1 is sent immediately, then 2 more in the next 5 seconds
 	vlmc_check_query igmp 2 $swp1 3 5
 	check_err $? "Wrong number of tagged IGMPv2 general queries sent"
-	log_test "Vlan 10 mcast_query_interval option changed to 200"
+	log_test "Number of tagged IGMPv2 general query"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 3
+	check_err $? "Could not set mcast_igmp_version in vlan 10"
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 2
+	check_err $? "Could not set mcast_mld_version in vlan 10"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 6000
+	check_err $? "Could not set mcast_query_interval in vlan 10"
+	# 1 is sent immediately, IGMPv3 QQIC should match with linear value 60s
+	vlmc_check_query igmp 3 $swp1 1 1 60
+	check_err $? "Wrong QQIC in sent tagged IGMPv3 general queries"
+	log_test "IGMPv3 QQIC linear value 60"
+	RET=0
+	# 1 is sent immediately, MLDv2 QQIC should match with linear value 60s
+	vlmc_check_query mld 2 $swp1 1 1 60
+	check_err $? "Wrong QQIC in sent tagged MLDv2 general queries"
+	log_test "MLDv2 QQIC linear value 60"
 
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 16000
+	check_err $? "Could not set mcast_query_interval in vlan 10"
+	# 1 is sent immediately, IGMPv3 QQIC should match with non linear value 160s
+	vlmc_check_query igmp 3 $swp1 1 1 160
+	check_err $? "Wrong QQIC in sent tagged IGMPv3 general queries"
+	log_test "IGMPv3 QQIC non linear value 160"
+	RET=0
+	# 1 is sent immediately, MLDv2 QQIC should match with non linear value 160s
+	vlmc_check_query mld 2 $swp1 1 1 160
+	check_err $? "Wrong QQIC in sent tagged MLDv2 general queries"
+	log_test "MLDv2 QQIC non linear value 160"
+
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 2
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 1
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 2
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 12500
 }
 
 vlmc_query_response_intvl_test()
 {
+	TEST_NAME="vlmc_query_response_intvl_test"
+
+	check_binary "./mc_encode" "$TEST_NAME: verify" || return 1
+
 	RET=0
 	local goutput=`bridge -j vlan global show`
 	echo -n $goutput |
@@ -468,10 +576,49 @@ vlmc_query_response_intvl_test()
 	log_test "Vlan mcast_query_response_interval global option default value"
 
 	RET=0
-	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 200
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 3
+	check_err $? "Could not set mcast_igmp_version in vlan 10"
+
+	echo "Vlan 10 mcast_query_response_interval (MRC) test cases:"
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 600
+	check_err $? "Could not set mcast_query_response_interval in vlan 10"
+	# 1 is sent immediately, IGMPv3 MRC should match with linear value 60 units of 1/10s
+	vlmc_check_query igmp 3 $swp1 1 1 60
+	check_err $? "Wrong MRC in sent tagged IGMPv3 general queries"
+	log_test "IGMPv3 MRC linear value 60"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 1600
+	check_err $? "Could not set mcast_query_response_interval in vlan 10"
+	# 1 is sent immediately, IGMPv3 MRC should match with non linear value 160 unit of 1/10s
+	vlmc_check_query igmp 3 $swp1 1 1 160
+	check_err $? "Wrong MRC in sent tagged IGMPv3 general queries"
+	log_test "IGMPv3 MRC non linear value 160"
+
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 2
+	check_err $? "Could not set mcast_mld_version in vlan 10"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 3000
+	check_err $? "Could not set mcast_query_response_interval in vlan 10"
+	# 1 is sent immediately, MLDv2 MRC should match with linear value 30000(ms)
+	vlmc_check_query mld 2 $swp1 1 1 30000
+	check_err $? "Wrong MRC in sent tagged MLDv2 general queries"
+	log_test "MLDv2 MRC linear value 30000"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 6000
 	check_err $? "Could not set mcast_query_response_interval in vlan 10"
-	log_test "Vlan 10 mcast_query_response_interval option changed to 200"
+	# 1 is sent immediately, MLDv2 MRC should match with non linear value 60000(ms)
+	vlmc_check_query mld 2 $swp1 1 1 60000
+	check_err $? "Wrong MRC in sent tagged MLDv2 general queries"
+	log_test "MLDv2 MRC non linear value 60000"
 
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 2
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 1
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 2
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 1000
 }
 
diff --git a/tools/testing/selftests/net/forwarding/mc_decode.c b/tools/testing/selftests/net/forwarding/mc_decode.c
new file mode 100644
index 000000000000..2c5e784226e4
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/mc_decode.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/bitops.h>
+
+/* 8-bit floating-point exponential field decode */
+#define FP_8BIT_EXP(value)		(((value) >> 4) & 0x07)
+#define FP_8BIT_MAN(value)		((value) & 0x0f)
+
+/* 16-bit floating-point exponential field decode */
+#define FP_16BIT_EXP(value)		(((value) >> 12) & 0x0007)
+#define FP_16BIT_MAN(value)		((value) & 0x0fff)
+
+/* 8-bit floating-point exponential field linear threshold */
+#define FP_8BIT_MIN_THRESHOLD		128
+/* 8-bit non linear max representable (mant = 0xF, exp = 7) -> 31744 */
+#define FP_8BIT_MAX_THRESHOLD		31744
+
+/* 16-bit floating-point exponential field linear threshold */
+#define FP_16BIT_MIN_THRESHOLD		32768UL
+/* 16-bit non linear max representable (mant = 0xFFF, exp = 7) -> 8387584 */
+#define FP_16BIT_MAX_THRESHOLD		8387584
+
+/* This decodes 8-bit floating-point exponential values */
+static inline uint32_t decode_8bit_field(const u8 code)
+{
+	if (code < FP_8BIT_MIN_THRESHOLD) {
+		return code;
+	} else {
+		uint32_t mc_man, mc_exp;
+
+		mc_exp = FP_8BIT_EXP(code);
+		mc_man = FP_8BIT_MAN(code);
+		return (mc_man | 0x10) << (mc_exp + 3);
+	}
+}
+
+/* This decodes 16-bit floating-point exponential values */
+static inline uint32_t decode_16bit_field(const uint16_t code)
+{
+	if (code < FP_16BIT_MIN_THRESHOLD) {
+		return code;
+	} else {
+		uint32_t mc_man, mc_exp;
+
+		mc_exp = FP_16BIT_EXP(code);
+		mc_man = FP_16BIT_MAN(code);
+
+		return (mc_man | 0x1000) << (mc_exp + 3);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	uint32_t bits = 8, code = 0, decode = 0;
+
+	if (argc != 3)
+		return 1;
+
+	if (bits != 8 && bits != 16)
+		return 1;
+
+	bits = atoi(argv[1]);
+	code = atoi(argv[2]);
+
+	if (bits == 8)
+		decode = decode_8bit_field(code);
+	else
+		decode = decode_16bit_field(code);
+	printf("%u\n", decode);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/net/forwarding/mc_encode.c b/tools/testing/selftests/net/forwarding/mc_encode.c
new file mode 100644
index 000000000000..24d9bd9299cc
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/mc_encode.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/bitops.h>
+
+/* 8-bit floating-point exponential field linear threshold */
+#define FP_8BIT_MIN_THRESHOLD		128
+/* 8-bit non linear max representable (mant = 0xF, exp = 7) -> 31744 */
+#define FP_8BIT_MAX_THRESHOLD		31744
+
+/* 16-bit floating-point exponential field linear threshold */
+#define FP_16BIT_MIN_THRESHOLD		32768UL
+/* 16-bit non linear max representable (mant = 0xFFF, exp = 7) -> 8387584 */
+#define FP_16BIT_MAX_THRESHOLD		8387584
+
+/* This encodes value to 8-bit floating-point exponential format */
+static inline uint8_t encode_8bit_field(unsigned int value)
+{
+	uint8_t mc_exp, mc_man;
+
+	/* Value < 128 is literal */
+	if (value < FP_8BIT_MIN_THRESHOLD)
+		return value;
+
+	/* Saturate at max representable (mant = 0xF, exp = 7) -> 31744 */
+	if (value >= FP_8BIT_MAX_THRESHOLD)
+		return 0xFF;
+
+	mc_exp  = fls(value) - 8;
+	mc_man = (value >> (mc_exp + 3)) & 0x0F;
+
+	return 0x80 | (mc_exp << 4) | mc_man;
+}
+
+/* This encodes value to 16-bit floating-point exponential format */
+static inline uint16_t encode_16bit_field(unsigned int value)
+{
+	uint16_t mc_man, mc_exp;
+
+	/* Value < 32768 is literal */
+	if (value < FP_16BIT_MIN_THRESHOLD)
+		return value;
+
+	/* Saturate at max representable (mant = 0xFFF, exp = 7) -> 8387584 */
+	if (value >= FP_16BIT_MAX_THRESHOLD)
+		return 0xFFFF;
+
+	mc_exp = fls(value) - 16;
+	mc_man = (value >> (mc_exp + 3)) & 0x0FFF;
+
+	return 0x8000 | (mc_exp << 12) | mc_man;
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned int bits = 8, value = 0;
+	uint8_t encoded8 = 0;
+	uint16_t encoded16 = 0;
+
+	if (argc != 3)
+		return 1;
+
+	bits = atoi(argv[1]);
+	value = atoi(argv[2]);
+
+	if (bits != 8 && bits != 16)
+		return 1;
+
+	if (bits == 8) {
+		encoded8 = encode_8bit_field(value);
+		printf("%hhu\n", encoded8);
+	} else {
+		encoded16 = encode_16bit_field(value);
+		printf("%hu\n", encoded16);
+	}
+
+	return 0;
+}
-- 
2.43.0


