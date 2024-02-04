Return-Path: <netdev+bounces-68900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8601A848C47
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 09:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30951F243E8
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 08:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF971428E;
	Sun,  4 Feb 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn10GycV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051716423
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707036713; cv=none; b=aU75mKLp/soYIcoN2NVIAexT4fIJbTOchJbtGPibAOavs8H7dP2taTP6JOwJaUuFSO/71606/TAKOIPu998ZpwoYJ1RFCLPFTGLovzNjhmYvHylSrNKQNW9SyL7KMKRs36cPFD/LbuQmdWu6DCjTsjz0Gb1t284GNlWkxAjfEWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707036713; c=relaxed/simple;
	bh=G/Ux3LgDRNAQg7rjHZrbyybShnGgVnE/dh5wJIEOlQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1mnlTFLRbCM3TqtKaAXVVn1/mVUIiwdw0C21Cl+amkhSBtIvPeyE3uc+lqZO2BD5J+E1oAIFU+l5v4ttL+5Ash7iWUuUiDKNWO8O74lzs812g82t9/TaszjWqpVcWaNX+/8plzK0phdSoAvMF76DXkc5ohPyzawpKuO56s98BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn10GycV; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8b276979aso2660929a12.2
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 00:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707036710; x=1707641510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1N5DayUxd7++DZoXwdreOmT1QtfwA5myExd/7/w8Yzc=;
        b=Nn10GycVfvEFfWXONyRdvh2J2BGsle2ZnM2NbUagR4qTgFYiLxyDRFlgJp3X/yYgPi
         gBZpPZKQEO6WQdm7lnZXAJ/NfEs/oV8+RfarLYIzT2ymV73s1olKh/0AhLiMK4rc3r59
         9/5L6fcyLtSaHPohG3jqb3d+y1aTp4cc8h670NHVB/fk7gQgnAs79hUige1rdmzQrsYk
         wUnjDqiUx3LyCLVHfd3aYog84Y+pIb0KrZMd2PJKsXlqQe21i8D3SnoP4tnfrLgIPc9D
         4T4GrRKdZQrCZaI6zVjyrf2AGI4YkDOfXAGrQ5WFsHozNTzVCqVqR2I0RD1GGEXiKHFz
         +5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707036710; x=1707641510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1N5DayUxd7++DZoXwdreOmT1QtfwA5myExd/7/w8Yzc=;
        b=V9vserSbbzs/aFPz1YSKZh+oBtn31S8FWV8TuqNbL0qZpFGg21HrqKbwkB1GAtNO1I
         lyYotLtWcbA/hnPAW8Mn5j/YNeyBD8ZyTpfr9/xt3AZ38We3jVGga0S3pcYul0LB5rhN
         uy01qvuF/zC1Jf2Pq4u316Ch7g3UTcJG1xfR1MCvVPZQRBZzo+1zV43HN9S8IAJL5eXX
         aq/4CFx9GchI20xiPqF/h3uWK63b1lMdIYEoZC9rnqCjN/vMDWz6nEJOgH7AojGiHeaA
         RYgi4mLghS8Ic6CVY8mS82MaQEGPnS8Kfs/kuX8ke7pvseNZegqbqjfwrD6hjsLmC0it
         fqRA==
X-Gm-Message-State: AOJu0Yw/2C1FDCl9fCYY2pvyfrm6ketHoBzhfSdUKhkipl0JJ1ELxwZH
	cZOURnYiI32AbSRytXwH+kbflxAMCA3wM0b83numnYWwW503KS997b8Au+yzjTVxrA==
X-Google-Smtp-Source: AGHT+IGRc3ckvtDkjv5AHx76IcEaX1ITPJ6j9xvZ/q5KTGY+O8VWlp8hKFk45bzWoe1QhArOpOxVrw==
X-Received: by 2002:aa7:8592:0:b0:6e0:329b:9d4d with SMTP id w18-20020aa78592000000b006e0329b9d4dmr1487521pfn.26.1707036710333;
        Sun, 04 Feb 2024 00:51:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU2Hr/I1h+wwhDj/ZemqQtBzVBq1NeyPcM1+XR4t21mugMcjOVhicoKYCfi238jHlVeX8Gtvsd9ht34eOjbmRjjGH52+959DDPimkIRswOUYm/a2tlboYuIDiLA4CJhcE/L2hlEYS/EYHh7aymyK1NE8egBT519GgpwzA+nx4vRYR6cmbJuvC86iL4lcPZMpePN5tiJNrhqFf9TOsNwbZP3i4/8gVcRpw+WZ+AEEgGLE6X5mR2d8WXiCusbK8kxM0CLCg==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ka39-20020a056a0093a700b006d9b2694b0csm4398228pfb.200.2024.02.04.00.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 00:51:49 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 3/4] selftests: bonding: reduce garp_test/arp_validate test time
Date: Sun,  4 Feb 2024 16:51:27 +0800
Message-ID: <20240204085128.1512341-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204085128.1512341-1-liuhangbin@gmail.com>
References: <20240204085128.1512341-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of grat_arp is testing commit 9949e2efb54e ("bonding: fix
send_peer_notif overflow"). As the send_peer_notif was defined to u8,
to overflow it, we need to

send_peer_notif = num_peer_notif * peer_notif_delay = num_grat_arp * peer_notify_delay / miimon > 255
  (kernel)           (kernel parameter)                   (user parameter)

e.g. 30 (num_grat_arp) * 1000 (peer_notify_delay) / 100 (miimon) > 255.

Which need 30s to complete sending garp messages. To save the testing time,
the only way is reduce the miimon number. Something like
30 (num_grat_arp) * 100 (peer_notify_delay) / 10 (miimon) > 255.

To save more time, the 50 num_grat_arp testing could be removed.

The arp_validate_test also need to check the mii_status, which sleep
too long. Use slowwait to save some time.

For other connection checkings, make sure active slave changed first.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../drivers/net/bonding/bond_options.sh       | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index d508486cc0bd..6fd0cff3e1e9 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -45,15 +45,23 @@ skip_ns()
 }
 
 active_slave=""
+active_slave_changed()
+{
+	local old_active_slave=$1
+	local new_active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" \
+				".[].linkinfo.info_data.active_slave")
+	test "$old_active_slave" != "$new_active_slave"
+}
+
 check_active_slave()
 {
 	local target_active_slave=$1
+	slowwait 2 active_slave_changed $active_slave
 	active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
 	test "$active_slave" = "$target_active_slave"
 	check_err $? "Current active slave is $active_slave but not $target_active_slave"
 }
 
-
 # Test bonding prio option
 prio_test()
 {
@@ -84,13 +92,13 @@ prio_test()
 
 	# active slave should be the higher prio slave
 	ip -n ${s_ns} link set $active_slave down
-	bond_check_connection "fail over"
 	check_active_slave eth2
+	bond_check_connection "fail over"
 
 	# when only 1 slave is up
 	ip -n ${s_ns} link set $active_slave down
-	bond_check_connection "only 1 slave up"
 	check_active_slave eth0
+	bond_check_connection "only 1 slave up"
 
 	# when a higher prio slave change to up
 	ip -n ${s_ns} link set eth2 up
@@ -140,8 +148,8 @@ prio_test()
 		check_active_slave "eth1"
 
 		ip -n ${s_ns} link set $active_slave down
-		bond_check_connection "change slave prio"
 		check_active_slave "eth0"
+		bond_check_connection "change slave prio"
 	fi
 }
 
@@ -199,6 +207,15 @@ prio()
 	prio_ns "active-backup"
 }
 
+wait_mii_up()
+{
+	for i in $(seq 0 2); do
+		mii_status=$(cmd_jq "ip -n ${s_ns} -j -d link show eth$i" ".[].linkinfo.info_slave_data.mii_status")
+		[ ${mii_status} != "UP" ] && return 1
+	done
+	return 0
+}
+
 arp_validate_test()
 {
 	local param="$1"
@@ -211,7 +228,7 @@ arp_validate_test()
 	[ $RET -ne 0 ] && log_test "arp_validate" "$retmsg"
 
 	# wait for a while to make sure the mii status stable
-	sleep 5
+	slowwait 5 wait_mii_up
 	for i in $(seq 0 2); do
 		mii_status=$(cmd_jq "ip -n ${s_ns} -j -d link show eth$i" ".[].linkinfo.info_slave_data.mii_status")
 		if [ ${mii_status} != "UP" ]; then
@@ -276,10 +293,13 @@ garp_test()
 	active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
 	ip -n ${s_ns} link set ${active_slave} down
 
-	exp_num=$(echo "${param}" | cut -f6 -d ' ')
-	sleep $((exp_num + 2))
+	# wait for active link change
+	slowwait 2 active_slave_changed $active_slave
 
+	exp_num=$(echo "${param}" | cut -f6 -d ' ')
 	active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
+	slowwait_for_counter $((exp_num + 5)) $exp_num \
+		tc_rule_handle_stats_get "dev s${active_slave#eth} ingress" 101 ".packets" "-n ${g_ns}"
 
 	# check result
 	real_num=$(tc_rule_handle_stats_get "dev s${active_slave#eth} ingress" 101 ".packets" "-n ${g_ns}")
@@ -296,8 +316,8 @@ garp_test()
 num_grat_arp()
 {
 	local val
-	for val in 10 20 30 50; do
-		garp_test "mode active-backup miimon 100 num_grat_arp $val peer_notify_delay 1000"
+	for val in 10 20 30; do
+		garp_test "mode active-backup miimon 10 num_grat_arp $val peer_notify_delay 100"
 		log_test "num_grat_arp" "active-backup miimon num_grat_arp $val"
 	done
 }
-- 
2.43.0


