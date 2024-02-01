Return-Path: <netdev+bounces-67834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7080A845162
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2643B28EF7B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 06:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7648612B;
	Thu,  1 Feb 2024 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKzv3dB7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212766DD0B
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769014; cv=none; b=lTlu2wdHNrBBPots64Q5l1Pa4OMpe85HoG3oMTZNjpRA8Cb+nKzwyuCe1T6v9ezBUfGoMIMM4vN0AO7ODNSpLVo5PqdZwQZIR3NIrbVd3/F9IyFvwxzE0PQ80eLlJcBzhqcqRLdI9fgMrKZQq2iGWcLTbyJPDeZkAcuK9slrOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769014; c=relaxed/simple;
	bh=G/Ux3LgDRNAQg7rjHZrbyybShnGgVnE/dh5wJIEOlQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TT7e3+44a4J23gLv4PiJNVrrBlzKFHLQFcHTJay60R9QpGZvK++dPYncpCZrxsIP9TIa627N7IgfU2Y7Lb3YxGt7E0SgHznYM4tjr+xZNMdhvVYVt/LqBRgysQOBifPNy/03gC4zZvDl7TfJ+Pm5jounvAbrUfvHp3KxuslaCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKzv3dB7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-295c67ab2ccso420684a91.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 22:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706769012; x=1707373812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1N5DayUxd7++DZoXwdreOmT1QtfwA5myExd/7/w8Yzc=;
        b=WKzv3dB7qiEH7oJdY/De2HO/eu5G4okv7HF0QvuYjLfT82Rkqu/FOnjavyaZIei1ah
         EbMufCe+P+y2aT4TmzKRNsIZmFFEEjzp+kL8fbeZ/N9CrhRWmg+NH0TF4nq5zJ3RZieJ
         o8vYP6C2IoQm8uzmACwGTlOqAcRbcSYkZg768YkZw9kHds9/i2/Y6jhl7hCwpQIgokl5
         FkbM/B5mO9i2Qle4MGok5zlqZH0LTVrROzw+AP2gpt7l1BTJ14zvpvnfOQ6E4SdMw77G
         cQFbYlYE0W9q/lXtxVWiX3rggUcwCQXKhRxN+AJdcctLCimo9sUTHx0OuJVMbDBQrRTx
         eCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706769012; x=1707373812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1N5DayUxd7++DZoXwdreOmT1QtfwA5myExd/7/w8Yzc=;
        b=Irp6wKGs0zzMpCg0f2IM0pQKv8X+f9y2ITvG63xVNtaMkSFmQ7NMobA4Y4/363H2AF
         4f9WRZqjbK6i4YynNR2Uw0kdDfwEx2I88wJO/CKFTmGdK8ZeYDBz1CY6TmuHMqcGvwzE
         v4p7YyxErLHKIqXPMTzmyAkohtM8W/MBKimw7pFcd8oma0rbQsvTY+pQxyt54HapsVvS
         kErkN0f0DxkWS6EUo2Vz+7VG1JMB/E0EHfQMCaTT59aSG/Teamxog4xjOlqllJYPbXoQ
         ujLQJ6zZ1BdIZhP3UiV1ahHn8p3xQSCIjes8hfGdzEzhtNSEGB1NmPNrfwoz/1xBbWX+
         LUwg==
X-Gm-Message-State: AOJu0YxT6nCmrrZkp+KjWZb0DYXpnojdbiU9+hdAjOW1e4ngh5FReMML
	19PdFxMF+eKqFytlSrLL30KGLUOe0zc0NkiutTmxHSzFtl+mNR/8be/jcF27E8GhFfaF
X-Google-Smtp-Source: AGHT+IGjbjoYBiUCUN4oMlEc1AcbX/l7Rysj7XXL2LxhB2L/N3FCqZall+WbA1adkhpnfa/difClPA==
X-Received: by 2002:a17:90a:bc82:b0:295:f059:5713 with SMTP id x2-20020a17090abc8200b00295f0595713mr3304993pjr.38.1706769011920;
        Wed, 31 Jan 2024 22:30:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVZETwiN+z2dGRmFb/f/IG67qAnO/poTwa3Dgl5ZnTfGCwGXval12+6F55mrbYFMSYOX0EwxAvEVxARW8DhoHImxr2g34fitM3t7cO7VwdG2vSO1hR3oGGxM37qqbPGWWWCPh8B9ZdCbEom+GUbIr9fiGd2ckbaRJX1qtK8cGUa5vZAdnR+nKrcKbHvQokB/t4If1/cuJXc5YILZYAoqTmnM65JtFJycnUpz8lPvBsgKHLQ0TaDPU20f1biXlbMmF1ZTA==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id pm12-20020a17090b3c4c00b0029618dbe87dsm515895pjb.3.2024.01.31.22.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:30:11 -0800 (PST)
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
Subject: [PATCHv2 net-next 3/4] selftests: bonding: reduce garp_test/arp_validate test time
Date: Thu,  1 Feb 2024 14:29:53 +0800
Message-ID: <20240201062954.421145-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201062954.421145-1-liuhangbin@gmail.com>
References: <20240201062954.421145-1-liuhangbin@gmail.com>
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


