Return-Path: <netdev+bounces-68280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2668465F1
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 03:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510EA1F24BCD
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 02:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB9AAD57;
	Fri,  2 Feb 2024 02:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUMuC/2P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A0C8DB
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 02:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841496; cv=none; b=bknJIub9F8bYtjoUWV0FHLYaZ6QNrU60Bgp8FNPf2qOmXi2SISS3XVSv+3ihldVk15YSsXhAv0wCCDfPi7y70lGTZhrdz1doXPWnKkPYZXLDtX1qtHw6r1vFGYzsfxfnMsYAcr+izXGsfTOxvaWBQIHUUljjLAfqRy8t8/yrTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841496; c=relaxed/simple;
	bh=G/Ux3LgDRNAQg7rjHZrbyybShnGgVnE/dh5wJIEOlQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlRkw8KkvUGAP+ZPoTHh8QGp/97fnK0cGnHV+LTLKiyuuWIBdnIHlXFRNkidxDBOmADm667LfSexfCDB74NvT7HR9eZrWt6UJW8UtbrAIuyKJ/djhalBQsjQVGYD7Le/Xr2jaMD7yJ9Jy/kwbDJq0rY8I+ciHHlQ1Yb9wb5ZlMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUMuC/2P; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d70b0e521eso11825135ad.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 18:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706841494; x=1707446294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1N5DayUxd7++DZoXwdreOmT1QtfwA5myExd/7/w8Yzc=;
        b=JUMuC/2PZ5yf0w21dfTtvPJuThbkjARmcF4XCJbDFqG5GUfXxrM17tNJe6HiH1amkY
         eqXxfzqWzXcmKy4VR3DjZAgzSqdb+kn8XIIcW+u6sM6zcJEtSlfufEDIZTh8Fkp8py97
         9IugEJ7Zh3chR2qeZl6IZi1XzQW2GCr1MRpmjewlsT5mc1kU94DEXe3afuyRfBMS0si4
         7O5KIoDGpnEoTHD9+2UPPgcjU844sy2lP8ie5RhPxgCqAI+ukP/AXcq3KCmXPGGZ0QcN
         qPMCYNjDjiRZI5VO5YOCOIAXCRwe4z30a0qaPfujSp8N6eu3oG9UwS7rn/O6q/mW83ar
         Lnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706841494; x=1707446294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1N5DayUxd7++DZoXwdreOmT1QtfwA5myExd/7/w8Yzc=;
        b=uewYcFSe0xpKEE+Ovg/M0bF8HLHzgXD5FY6GpjtWGUXYe+bIESaxkNsD7FF7Ee0CPb
         dEYNtbdgrT7JOxVD2HG9ctwbrglED4M0FoSZc67AluvrKkIIo6nB+dpkfdUqxyx0w9RE
         7HM/Vp5GBYE7N1KstQZcadvVWMO5/bLKDCOTUETg3tnVomjdexvceWtHWOYHs2kbddsg
         9pbWJb0/Pq+kO/wx220r+xEAi5ofwGf54MZLYjBj01ThYg0k9vxeM8y7FWWOyOdyWe1i
         6OvTzPjSpvTsWu4df1JehqQQUG4jHcT+tVFuDWI/pGM3oVjV+YI8YKnHA8WAyKWQePKr
         DpeQ==
X-Gm-Message-State: AOJu0Yy+yokXzrWTMtiouu2jlB2K7PzK1AqHuX9vzl/6zDa7MHhhCrMe
	4McbAuWzBn2gcd08Pds1CN3C7Ul5UStQc3ct8TCn+l1s7DC3nZ2oskEmtUI3L8nmGHiK
X-Google-Smtp-Source: AGHT+IHYxYeHkGbsaMmubGxfoBe7dFJ8wpd6/3BK8jrWNYu1pUquYS0ENT1Cz2FhgFlJTMmFv6qXhg==
X-Received: by 2002:a17:902:c64a:b0:1d7:719a:41a0 with SMTP id s10-20020a170902c64a00b001d7719a41a0mr851872pls.56.1706841493953;
        Thu, 01 Feb 2024 18:38:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYJj1iI533R35PO7eC2QImFQfDviFDOy4e6BCTrj8Io3S+s2Ow8EJHAWxp7i2n29ELbxQoDij6OIR5V76xX91CrMdSLqv6d8oPFt9XPOC6yWE9S/fXrGJo1/aP+EQ3G1geru48A7c1GsJx6wWTM3npxWNEOATmJD7DirTWP8xKmwMmjtTtaMTUw5C9lDm4eSuL+3C9WTE8A4xN2uoeQA8uZ5n+GFQmSQk9anIfxPRZO24w1byQb6OiYRrGm7ocG8zYUw==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ji19-20020a170903325300b001d944b3c5f1sm493256plb.178.2024.02.01.18.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 18:38:13 -0800 (PST)
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
Subject: [PATCHv3 net-next 3/4] selftests: bonding: reduce garp_test/arp_validate test time
Date: Fri,  2 Feb 2024 10:37:53 +0800
Message-ID: <20240202023754.932930-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202023754.932930-1-liuhangbin@gmail.com>
References: <20240202023754.932930-1-liuhangbin@gmail.com>
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


