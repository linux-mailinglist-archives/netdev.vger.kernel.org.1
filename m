Return-Path: <netdev+bounces-69138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41925849B50
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 14:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDBB2832B0
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910EA1CD03;
	Mon,  5 Feb 2024 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqGdViYn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B11CD15
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138071; cv=none; b=XycIybHMkY10DymcH1gNNQTIVEq9vkb2YBOVTFS548QijOCyp5yVCQ1+UgNEGtQgb/ZiSYmFEkJPYZak4n9R+4MqUjGBVuUfq5J9jUZi5tYT89BSOg00kTbsOd6f6oukXpqn9F0RT2yWhscPktoMlUoEkPFuAXp7tjwh6ScwaeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138071; c=relaxed/simple;
	bh=G/Ux3LgDRNAQg7rjHZrbyybShnGgVnE/dh5wJIEOlQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXpWc2IKX18reiRtJccmbLtJJn5trnBZ0ybKavCM1v7ZDdm7DTS0RM7kMM2udD6Df8x7bcUouYmh9LiAfYRG2peZiG5zjPYAV8Sj/Y0Y/q+H2NNU0h2mXEa64r9BW6tH/wJ3qCHqV1rMCf4MCcmZQ4FLHEfyBE5ubY6ARhrwYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqGdViYn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d51ba18e1bso39633945ad.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 05:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707138069; x=1707742869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1N5DayUxd7++DZoXwdreOmT1QtfwA5myExd/7/w8Yzc=;
        b=fqGdViYn4gu6mJFLfc+mvujwloV9bYQK58hLMbMgTVK0wH6SDOaORPAJ7kwMPUtqpI
         Cye1YgOlgw2Zlzdg4zEEmmcyDcoHj4hUPGZuHk2/PqpWcYnxvjTTKPMiIzQO6G5piUce
         d2dBnRLTtSPtn/WIB7eyVRbzWnmsI5tR6LvcQ6LoKNt4KYJth4wrIPsOf2ikFb5N0JTa
         YcoeC/OIrgxlSgy5XjWLz5r3FQIg0T6wSvWRdS15yTFoPMQQCv0DujNF3+60ZrqwPq33
         X8tAprmTZDQ48QLZoOBCtq3kfC7b+h5WA9SfkF82+EMy9LT4orlRDnFMbT9MEnZ+e4sv
         lESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138069; x=1707742869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1N5DayUxd7++DZoXwdreOmT1QtfwA5myExd/7/w8Yzc=;
        b=R3JnyvJH3VYK6lRh5fp7wDgQvQCihYBZ7xfepH40wGruSfIGYA8g2I9rr2blITPA3X
         n+q497xMW64RChd7Japic6JNTC7/tqjpsjok4HXUvJQPgowmlz3y9J3MlbwvvFGYlIrx
         9I3iTnSQWzHVirTJq3hKbUhVUkN1rdA8LSJOwTecuezxmv6xEOzpGQvzBQ75bB3OQkgv
         SXJI77Cxxt7xvGeLAcFPVGr2zPBM2nuchf1cOJ3SpDeQRt+9HorQwQ/7jrIPgGORPUO6
         D/RX5eHYRC3L1FPpsePQe6N8vrOmfYEJlxPPbLXkrJEgBqWXfSIXNKFRF+DHGQKgvsV+
         VOHg==
X-Gm-Message-State: AOJu0YzlCfR1aanr12FKhbRkHsh/Bf2McLwIU6eK6uuZmkkwhQ4OjiUt
	HsNEbcklGR0Nlnf+6g5DveJzJOWMGbyPz2FYTl7VBj+D0MT3c/6gUKm6HLiK49LDXg==
X-Google-Smtp-Source: AGHT+IE+VyLmNIQmO75C0Vf0ErzK27+tJ51eOYgQDihw7LgT3nucdEv11kv0je2hrSEBIgEUfTrtkA==
X-Received: by 2002:a17:903:2281:b0:1d9:b9da:ea8f with SMTP id b1-20020a170903228100b001d9b9daea8fmr3050899plh.2.1707138068528;
        Mon, 05 Feb 2024 05:01:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXlAr6uDNkxCyR7d0qr3wyNhNJ05FPxGfHT671eQJOiKztF6LMzKu4QfKpaHDjkYBeBW1wKktgkBrDFn/Yn4tzwAY5NmbGs+ptDKATSIIT0lMV/Zk9FqPhNhwU55Azk87FI3sdDE0dP/XPa4K+UEzl54aQ03WzrB17Pr27yQ9JPW2u3I5EXVObX0GcThXpzZ1tBozJNaL/EmVPa05nwDKPRf7Kfw8LKBMEdWD4Ufdy//08jxHa2KsxkDUBYOuDjVU9BIA==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b001d9351f63d4sm6252159plh.68.2024.02.05.05.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:01:08 -0800 (PST)
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
Subject: [PATCHv5 net-next 3/4] selftests: bonding: reduce garp_test/arp_validate test time
Date: Mon,  5 Feb 2024 21:00:47 +0800
Message-ID: <20240205130048.282087-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205130048.282087-1-liuhangbin@gmail.com>
References: <20240205130048.282087-1-liuhangbin@gmail.com>
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


