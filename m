Return-Path: <netdev+bounces-283415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBbeFH/69WkHRAIAu9opvQ
	(envelope-from <netdev+bounces-283415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 15:22:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C39794B2238
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 15:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4BB1303EFE3
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8B257435;
	Sat,  2 May 2026 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPAAqsyb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8D257851
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777727999; cv=none; b=pYmwMQIl+gVm3DBd14d6vi8rCeoBehFjOaZiEDZjXPOq56LmcipSCyIkJ0x152sooqh1+hRiFQa8UO6BAP6IAS0z92ETOBC7fcz2Rum7NkWj/sN4XZ9WvXnD0k7ZSf9j/FU/Y4F3VV+zOtDjBXO7P3V22GQ5PqcrsQvKl3JQxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777727999; c=relaxed/simple;
	bh=lxcyWp12IdlZXXKd8Ugl4on7xBBXleJuqVt+0M1OoPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZ/7VSGk8ITtjr1HuVcVTzOWVFmWJyL2a2VIHVIFVb6pWzYrXaecK/CHIJTLOvbf9PwfnGJVnfqdEPsUkjwFWjwbKv6IKw8IsvBWaS23YpwzaFTX1xpx1TKg/Ig37ywN0lpR5F81Wy69ThDYK/OcbEU1M/UAZbO4JWUFcxLBBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPAAqsyb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f8893bff3so1289652b3a.2
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777727996; x=1778332796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gfGrYQ7AWXi3RXTSR0Z1BGRv06bnLTOB4wH+tsRKV8=;
        b=dPAAqsybsiX8QZ3ITlSHXnOzi+2xC6mnt78AYeFl2Xlm/wdBl/72cXJ/9lh3+2yAR/
         i3RRjFXi0C/fnxPnn/RYSX5K2jV7BkEQe07rpqLBSF40sL1eoEaXcInIoLeHu4jTfz5w
         UW3yYRA2h+JwMU4xos1t2N0wNJOfbbSO637Ffe3q+iRa94bzmEEQ0yXqEJlBEFaWHVdS
         gTCEM5IboBAYZZHVRmCbNTPkcNtCpf6KLfWqzgSKunNrtlXg+OHvc93oUplo9HIjsJ7v
         V9K9POv5sI8xX8QSVpryzZk+5WaTO+kM/a2qT1z6MIVPKdLAsqY8TZOjB1UILoajNK2/
         rg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777727996; x=1778332796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gfGrYQ7AWXi3RXTSR0Z1BGRv06bnLTOB4wH+tsRKV8=;
        b=Gs0sbc0HyPTG1pJmNz+SRsQWGtTYqEBKEgL9JXVZg8ZBNt8FVCybuBtsfNoZpE+Ata
         E1TvMdECKhRvQcweqwMBdzdVvVQ5mD2G+FcMifTCQ3cpE1vjZz7NPB9qmnpbhzglQ7C6
         WipRGjY5ar6tgmiHpKis6NJaWMQ0C1RmHY+FuCy1IYrSyRVWkU7w2ISxRF4GL6VelfPt
         pASfORPC/Oiv9s2GFwemMLqjy3e8iXS9Z5VJT6j/Gw8IKXCZbtUtPnnzCIovNyQBoq4C
         /0a2YiBN5HGHOBRZxksjKNosLNkTamxUEpKsD+NyAJWyANo/oxZN4VhXNBjAGLmJITiB
         +R2w==
X-Forwarded-Encrypted: i=1; AFNElJ9Bbk3hIelxF81Ei6M9iSHiy6StIRaX7rktXWURQ+bF+2XY2HX0rHexz43zdYGYKbdPXKymGkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEy/3OuBsHtUG/D/c194xVXZE6YA7MQQlIbSt3FxQ6rEdMvMaO
	7hUy1RtpU1vrKe4g7qAylu28N/woVyERvWidqJUHPhoGTc0GIZ2/9PQb
X-Gm-Gg: AeBDiesDOl1wOzj5YmQ8B+YrDcJXYud1ApjTtmOlM+9fr2vTsutyWNEjwcR6JQidRBU
	wKrtK/Dg3mtRy1Li1i+OrsHSwy0bxq0Jc/8RJPSn1m4wubR3/dz8zH34hhf8NmvKan9YXvfdhCO
	Al9kKS22gOHO+/TP66zygyQF/tejw8DljQMawIx9+pl+6X68jxDb0zkeAwTjpxf2ByPryKfnT4N
	yGJC4staIlFcyHwK6yqx8M0UCpCY7/H88H3/LbRE5UO8G8aOWGjX0GIjzladtU7LkrNuCGsgj2d
	NeAoOYeEhlSYk+ggHPOfPwMEimw8SKn5ISEuuHK3OurH38rmhEww3mW6jyosZpBog+jLiuxymI8
	oc2QBsu6yuua0T+DqKg3uZIgfv/cbnLq5nqp2h+/+T1z/0gRcr6XtovUOnDLGS38Ovid7ZvtzWA
	DIbaz/ZZ697g9fICtKO/qK/EWbRmqPCjxXa36KvGDZRK/ptgpCUff+2IN27402
X-Received: by 2002:a05:6a00:aa8c:b0:82c:6bcc:f3fa with SMTP id d2e1a72fcca58-8352d2b58c1mr2888895b3a.35.1777727996093;
        Sat, 02 May 2026 06:19:56 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0176sm5553791b3a.39.2026.05.02.06.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 06:19:55 -0700 (PDT)
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
Subject: [PATCH net-next v6 5/5] selftests: net: bridge: add MRC and QQIC field encoding tests
Date: Sat,  2 May 2026 13:19:06 +0000
Message-ID: <20260502131907.987-6-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260502131907.987-1-royujjal@gmail.com>
References: <20260502131907.987-1-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C39794B2238
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-283415-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,blackwall.org:email,bridge_vlan_mcast.sh:url,nvidia.com:email]

Enhance vlmc_query_intvl_test and vlmc_query_response_intvl_test in
bridge_vlan_mcast.sh to validate IGMPv3/MLDv2 protocol compliance for
MRC and QQIC field encoding across both linear and exponential ranges.

TEST: Vlan multicast snooping enable                                [ OK ]
TEST: Vlan mcast_query_interval global option default value         [ OK ]
TEST: Number of tagged IGMPv2 general query                         [ OK ]
TEST: IGMPv3 QQIC linear value 60(s)                                [ OK ]
TEST: MLDv2 QQIC linear value 60(s)                                 [ OK ]
TEST: IGMPv3 QQIC non linear value 160(s)                           [ OK ]
TEST: MLDv2 QQIC non linear value 160(s)                            [ OK ]
TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
TEST: IGMPv3 MRC linear value of 60(x0.1s)                          [ OK ]
TEST: MLDv2 MRC linear value of 24000(ms)                           [ OK ]
TEST: IGMPv3 MRC non linear value of 240(x0.1s)                     [ OK ]
TEST: MLDv2 MRC non linear value of 48000(ms)                       [ OK ]

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 .../net/forwarding/bridge_vlan_mcast.sh       | 140 +++++++++++++++++-
 1 file changed, 132 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index e8031f68200a..07a377652a59 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -162,14 +162,27 @@ vlmc_query_cnt_setup()
 {
 	local type=$1
 	local dev=$2
+	local match=($3)
 
 	if [[ $type == "igmp" ]]; then
-		tc filter add dev $dev egress pref 10 prot 802.1Q \
+		# This matches: IP Protocol 2 (IGMP)
+		tc filter add dev "$dev" egress pref 10 prot 802.1Q \
 			flower vlan_id 10 vlan_ethtype ipv4 dst_ip 224.0.0.1 ip_proto 2 \
+			action goto chain 1
+		# AND Type 0x11 (Query) at offset 0 of IGMP header
+		# 20 bytes IPv4 header + 4 bytes Router Alert option + IGMP[offset 0]
+		tc filter add dev "$dev" egress pref 20 chain 1 prot 802.1Q u32 \
+			match u8 0x11 0xff at 24 "${match[@]}" \
 			action pass
 	else
-		tc filter add dev $dev egress pref 10 prot 802.1Q \
+		# This matches: ICMPv6
+		tc filter add dev "$dev" egress pref 10 prot 802.1Q \
 			flower vlan_id 10 vlan_ethtype ipv6 dst_ip ff02::1 ip_proto icmpv6 \
+			action goto chain 1
+		# AND Type 0x82 (Query) at offset 0 of MLD header
+		# 40 bytes IPv6 header + 8 bytes Hop-by-hop option + MLD[offset 0]
+		tc filter add dev "$dev" egress pref 20 chain 1 prot 802.1Q u32 \
+			match u8 0x82 0xff at 48 "${match[@]}" \
 			action pass
 	fi
 
@@ -181,7 +194,39 @@ vlmc_query_cnt_cleanup()
 	local dev=$1
 
 	ip link set dev br0 type bridge mcast_stats_enabled 0
-	tc filter del dev $dev egress pref 10
+	tc filter del dev "$dev" egress pref 20 chain 1
+	tc filter del dev "$dev" egress pref 10
+}
+
+vlmc_query_get_intvl_match()
+{
+	local type=$1
+	local version=$2
+	local test=$3
+	local enc_val=$4
+
+	if [ "$test" = "qqic" ]; then
+		# QQIC is 8-bit floating point encoding for IGMPv3 and MLDv2
+		if [ "${type}v${version}" = "igmpv3" ]; then
+			# QQIC is at offset 9 of IGMP header
+			# 20 bytes IPv4 header + 4 bytes Router Alert option + IGMP[offset 9]
+			echo "match u8 $enc_val 0xff at 33"
+		elif [ "${type}v${version}" = "mldv2" ]; then
+			# QQIC is at offset 25 of MLD header
+			# 40 bytes IPv6 header + 8 bytes Hop-by-hop option + MLD[offset 25]
+			echo "match u8 $enc_val 0xff at 73"
+		fi
+	elif [ "$test" = "mrc" ]; then
+		if [ "${type}v${version}" = "igmpv3" ]; then
+			# MRC is 8-bit floating point encoding at offset 1 of IGMP header
+			# 20 bytes IPv4 header + 4 bytes Router Alert option + IGMP[offset 1]
+			echo "match u8 $enc_val 0xff at 25"
+		elif [ "${type}v${version}" = "mldv2" ]; then
+			# MRC is 16-bit floating point encoding at offset 4 of MLD header
+			# 40 bytes IPv6 header + 8 bytes Hop-by-hop option + MLD[offset 4]
+			echo "match u16 $enc_val 0xffff at 52"
+		fi
+	fi
 }
 
 vlmc_check_query()
@@ -191,9 +236,13 @@ vlmc_check_query()
 	local dev=$3
 	local expect=$4
 	local time=$5
+	local test=$6
+	local enc_val=$7
+	local intvl_match=""
 	local ret=0
 
-	vlmc_query_cnt_setup $type $dev
+	intvl_match="$(vlmc_query_get_intvl_match "$type" "$version" "$test" "$enc_val")"
+	vlmc_query_cnt_setup "$type" "$dev" "$intvl_match"
 
 	local pre_tx_xstats=$(vlmc_query_cnt_xstats $type $version $dev)
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_querier 1
@@ -201,7 +250,7 @@ vlmc_check_query()
 	if [[ $ret -eq 0 ]]; then
 		sleep $time
 
-		local tcstats=$(tc_rule_stats_get $dev 10 egress)
+		local tcstats=$(tc_rule_stats_get "$dev" 20 egress)
 		local post_tx_xstats=$(vlmc_query_cnt_xstats $type $version $dev)
 
 		if [[ $tcstats != $expect || \
@@ -448,8 +497,46 @@ vlmc_query_intvl_test()
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
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 6000
+	check_err $? "Could not set mcast_query_interval in vlan 10"
+	# 1 is sent immediately, IGMPv3 QQIC should match with linear value 60 (0x3c)
+	# which is 8-bit encoded value of 60 [units of seconds]
+	vlmc_check_query igmp 3 $swp1 1 1 qqic 0x3c
+	check_err $? "Wrong QQIC in generated IGMPv3 general queries"
+	log_test "IGMPv3 QQIC linear value 60(s)"
+
+	RET=0
+	# 1 is sent immediately, MLDv2 QQIC should match with linear value 60 (0x3c)
+	# which is 8-bit encoded value of 60 [units of seconds]
+	vlmc_check_query mld 2 $swp1 1 1 qqic 0x3c
+	check_err $? "Wrong QQIC in generated MLDv2 general queries"
+	log_test "MLDv2 QQIC linear value 60(s)"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 16000
+	check_err $? "Could not set mcast_query_interval in vlan 10"
+	# 1 is sent immediately, IGMPv3 QQIC should match with non linear value 132 (0x84)
+	# which is 8-bit encoded value of 160 [units of seconds]
+	vlmc_check_query igmp 3 $swp1 1 1 qqic 0x84
+	check_err $? "Wrong QQIC in generated IGMPv3 general queries"
+	log_test "IGMPv3 QQIC non linear value 160(s)"
 
+	RET=0
+	# 1 is sent immediately, MLDv2 QQIC should match with non linear value 132 (0x84)
+	# which is 8-bit encoded value of 160 [units of seconds]
+	vlmc_check_query mld 2 $swp1 1 1 qqic 0x84
+	check_err $? "Wrong QQIC in generated MLDv2 general queries"
+	log_test "MLDv2 QQIC non linear value 160(s)"
+
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 2
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 1
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 2
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 12500
 }
@@ -469,10 +556,47 @@ vlmc_query_response_intvl_test()
 	log_test "Vlan mcast_query_response_interval global option default value"
 
 	RET=0
-	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 200
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 3
+	check_err $? "Could not set mcast_igmp_version in vlan 10"
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 2
+	check_err $? "Could not set mcast_mld_version in vlan 10"
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 600
+	check_err $? "Could not set mcast_query_response_interval in vlan 10"
+	# 1 is sent immediately, IGMPv3 MRC should match with linear value 60 (0x3c)
+	# which is 8-bit encoded value of 60 [units of 0.1s = 6 seconds]
+	vlmc_check_query igmp 3 $swp1 1 1 mrc 0x3c
+	check_err $? "Wrong MRC in generated IGMPv3 general queries"
+	log_test "IGMPv3 MRC linear value of 60(x0.1s)"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 2400
+	check_err $? "Could not set mcast_query_response_interval in vlan 10"
+	# 1 is sent immediately, MLDv2 MRC should match with linear value 0x5dc0 (24000)
+	# which is 16-bit encoded value of 24000 [units of ms / 24 seconds]
+	vlmc_check_query mld 2 $swp1 1 1 mrc 0x5dc0
+	check_err $? "Wrong MRC in generated MLDv2 general queries"
+	log_test "MLDv2 MRC linear value of 24000(ms)"
+
+	RET=0
+	# 1 is sent immediately, IGMPv3 MRC should match with non linear value 142 (0x8e)
+	# which is 8-bit encoded value of 240 [units of 0.1s = 24 seconds]
+	vlmc_check_query igmp 3 $swp1 1 1 mrc 0x8e
+	check_err $? "Wrong MRC in generated IGMPv3 general queries"
+	log_test "IGMPv3 MRC non linear value of 240(x0.1s)"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 4800
 	check_err $? "Could not set mcast_query_response_interval in vlan 10"
-	log_test "Vlan 10 mcast_query_response_interval option changed to 200"
+	# 1 is sent immediately, MLDv2 MRC should match with non linear value 0x8770 (34672)
+	# which is 16-bit encoded value of 48000 [units of ms / 48 seconds]
+	vlmc_check_query mld 2 $swp1 1 1 mrc 0x8770
+	check_err $? "Wrong MRC in generated MLDv2 general queries"
+	log_test "MLDv2 MRC non linear value of 48000(ms)"
 
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 2
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 1
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 2
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 1000
 }
 
-- 
2.43.0


