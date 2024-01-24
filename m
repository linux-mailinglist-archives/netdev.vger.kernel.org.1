Return-Path: <netdev+bounces-65408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 092EF83A61D
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D90F1C20EFB
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49E21863B;
	Wed, 24 Jan 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/d74D8B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568521862E
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090313; cv=none; b=S/QKZ0FA4VharBVgBVXmSP6X5QsuHCk4ww5mkoMJr/sj7HtBoVlqynVdtdCImKUJK/wAB3ozV5tbIO3M6iJpr0GF5stUb5YkPphF9/dFFp8Qim0FNQzeOKIcGPbFMOg+v7n4ku1/zSkZqJpNYxRJ1Cn3bIehZdnMKu99Ijse78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090313; c=relaxed/simple;
	bh=GAF6XFjCL4/C/TCxPrZxhQhZpfzEF0RDaOyiV9eYBuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTSqbAG/BQqrPgThGjRVHdfa3oPsnyXh0ndQyvFEuA+vCq5UKWV/NiyQSS0l0J+3QUSfvZW5qu+iswPcf205RbVuTLrKrpJCVGlzcGumygvvRvjSfAJvSUgwrwHZN2u8tHLxAtcgYaC0qqkBX4GeDb+GAdZ1nkQbG38BE4fdYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/d74D8B; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-599d1fd9cc1so45616eaf.3
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 01:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706090310; x=1706695110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExaomDlAHFtp1NR/c9It/L1kkAqAdZeGPv+RO/k/NPA=;
        b=Q/d74D8BWnYjWmwzso+U7SNcQBxbYvbj/umNXXJcbej+5QapbBks1eW8wmKvzNGW2k
         nU8g1djsbwCQu67ByE14r23M5+HBc6t7xdDZfOmydGOqZ+8+Yp1BX5OU+T4P84n1Lc7r
         JaqhjrHamP9NiJ4xl/hsLke5pdYnRdfZ6RevqgyvIHDLmY0yvv+Pq/I3OcPVmVH86uV0
         VQuPIVsvPHrWFWtjwzhoJWRd4YgZiZghTTzQcluFgcSGlpGEUvfb4jB+rH7TuPExUOTY
         9W2k4TKMBinuTbKHVPdHU7fS81oJVuEAUexQTgoIIK4SFDhXOgoqesYw9TxATN5tKVgv
         VuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706090310; x=1706695110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExaomDlAHFtp1NR/c9It/L1kkAqAdZeGPv+RO/k/NPA=;
        b=DC21aPMh8kZMwYuoKQRcMJNJIcOQXgdMmM27KpCbyrQ/4kC0YrQKyH7wacQT1rjJaf
         DxLpi+hylm/q9G25wq4ic+jYGCEojalRUfZ6i4LyP+2pr2LcyDcDIBbBKC9xOpOeNVoq
         VSF3joaRICLKgbN1BewPynEk9kci25Fph++MrNnb7w4oj3/R6yuMckMPDyMvURZDkRCN
         7ZLK3Vl7aFZ5JzWUUU48p5gi6EMy3ywP/HHm+xADB+eTDDFdJ3yVsq+hrQIjfUzHvBLK
         jz3BNp8v6DIVMfFwSKJauEMqrq/PKFMNOYuylOliQ6k4f53BGV2H/tc3nk6106oUH7vr
         dZXg==
X-Gm-Message-State: AOJu0YzS4qAtKkVk7oE41ohoqSVcXz+kf4lTvzgmHUvPnj7JKPjhozFq
	6o5w/YwpTWq4vbTxSuMHEzVIMtbQQkM4Sn5Ti9SRTd3dMg5ndrklszSmNgiE1DK/Zm+/
X-Google-Smtp-Source: AGHT+IGkJMRfQQ7T9ac2lR1yMuZ0YlgFyzGsY2K5yJyU6rF5C1dLdXkAfo568G/E22nd56N+fbapbA==
X-Received: by 2002:a05:6358:6a43:b0:176:8332:c661 with SMTP id c3-20020a0563586a4300b001768332c661mr2026527rwh.25.1706090310590;
        Wed, 24 Jan 2024 01:58:30 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id so12-20020a17090b1f8c00b0028dfdfc9a8esm13055367pjb.37.2024.01.24.01.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:58:30 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 3/4] selftests: bonding: reduce garp_test/arp_validate test time
Date: Wed, 24 Jan 2024 17:58:13 +0800
Message-ID: <20240124095814.1882509-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124095814.1882509-1-liuhangbin@gmail.com>
References: <20240124095814.1882509-1-liuhangbin@gmail.com>
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
30 (num_grat_arp) * 500 (peer_notify_delay) / 50 (miimon) > 255.

To save more time, the 50 num_grat_arp testing could be removed.

The arp_validate_test also need to check the mii_status, which sleep
too long. Use slowwait to save some time.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../drivers/net/bonding/bond_options.sh       | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index c54d1697f439..648006763b1b 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -199,6 +199,15 @@ prio()
 	done
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
@@ -211,7 +220,7 @@ arp_validate_test()
 	[ $RET -ne 0 ] && log_test "arp_validate" "$retmsg"
 
 	# wait for a while to make sure the mii status stable
-	sleep 5
+	slowwait 5 wait_mii_up
 	for i in $(seq 0 2); do
 		mii_status=$(cmd_jq "ip -n ${s_ns} -j -d link show eth$i" ".[].linkinfo.info_slave_data.mii_status")
 		if [ ${mii_status} != "UP" ]; then
@@ -276,10 +285,13 @@ garp_test()
 	active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
 	ip -n ${s_ns} link set ${active_slave} down
 
-	exp_num=$(echo "${param}" | cut -f6 -d ' ')
-	sleep $((exp_num + 2))
+	# wait for active link change
+	sleep 1
 
+	exp_num=$(echo "${param}" | cut -f6 -d ' ')
 	active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
+	slowwait_for_counter $((exp_num + 5)) $exp_num \
+		tc_rule_handle_stats_get "dev s${active_slave#eth} ingress" 101 ".packets" "-n ${g_ns}"
 
 	# check result
 	real_num=$(tc_rule_handle_stats_get "dev s${active_slave#eth} ingress" 101 ".packets" "-n ${g_ns}")
@@ -296,8 +308,8 @@ garp_test()
 num_grat_arp()
 {
 	local val
-	for val in 10 20 30 50; do
-		garp_test "mode active-backup miimon 100 num_grat_arp $val peer_notify_delay 1000"
+	for val in 10 20 30; do
+		garp_test "mode active-backup miimon 50 num_grat_arp $val peer_notify_delay 500"
 		log_test "num_grat_arp" "active-backup miimon num_grat_arp $val"
 	done
 }
-- 
2.43.0


