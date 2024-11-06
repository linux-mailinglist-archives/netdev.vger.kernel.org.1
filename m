Return-Path: <netdev+bounces-142223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815E69BDE3D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 06:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407DD283BA1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 05:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652CC1922E6;
	Wed,  6 Nov 2024 05:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH83XALX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD881922D7;
	Wed,  6 Nov 2024 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730870102; cv=none; b=s6lyFhultiy8os3bF9RI2q6A+UKDiydbgTzHOIaYpxHtGYG2mbCLNFITRcFFF+XiG6rkmjgrXRUUkGnzsLDrwmTRa/zFzQ+4TQCLWOaDYiswOI1mTKTtg9o144rKt0PkzvTxtd1jcVW8UpK4VJUCO1PqYZZfJF0st2lKhNQcEZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730870102; c=relaxed/simple;
	bh=hPy0N/ggUKEFmDgES9LnVN+aRaEPJhuUjeclsVaej90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQgy6wQ9KmOa78iIURASsq3PIt3iHz2ALp01/PNSsZK2sDGmro6ob/SAuHIRu+r6ayo21w9iG3lSa9RKDj1zveq1vUhnjIWUh+kIXnPrbu9zbDK4j+2q2Jzp4R6daJzbQATDD5E//DHQO/kZ35AD0loWIOblIx10sis68O2YK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZH83XALX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c8c50fdd9so3521735ad.0;
        Tue, 05 Nov 2024 21:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730870100; x=1731474900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYDOLMZA+kc/pY3CV46oKmS2BO0tiarAplcF7SwTosE=;
        b=ZH83XALXZAtrjLvI+NyCAwY/ouL/v9wQrOvx5BO4s8S9vibxZmaVQRmZm1kjrC3e43
         Sk2jVsFSVgAVZI7caJofcS3vGtOLzTCmXe3JJvKgxQyKqXKJtkfulf9aOlMsBqknS3bA
         vPmlIxzqo9HLh88/VvKLVhdtYKQmP4yP/qKWVXKr2WkuuvEQcJXtTfZSkmGVznCupt2n
         Z7DUZ8QHRas1Pc/6QrqFFjyrX7OMHgTAw9mft2g4NtpGx1+7k8RipI4A1Ch6/YSCKrVz
         nblBvhNJr4S3QLUJKkPl4eqnZHe9yKiemUIMk9MD90qpsbFx7+9Xh+lB69Es9VPPtWa+
         7U3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730870100; x=1731474900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYDOLMZA+kc/pY3CV46oKmS2BO0tiarAplcF7SwTosE=;
        b=Yr+umXeYR5JZvGmipgN1oCNLMlfmPl1bnTbYhcOuSGZXsKM3ODvkd6cn3VBHaHv61q
         9PyaKIDS2lo+Zbjx0/XfRWyd9VXpUwj/7x++E2XcoFzLiiF/kEXJB3Jo9hAzX0TJS9d7
         zc1zLnY5FDpNZDwTRtw5EYplwzYip0OPFkFd6p4XZWGmAnZwIsh9IagewBHxY4Y6g94Z
         oKFxsnE7srNKj/F1A7YfneAgADZjVfHjv37ilpoJV9+GZKO/LphPFd46lfVClE3gMC1u
         IeNAFFGg3TqW6/mt0+JM0f9GTeVOt0vz5DiMg7liA6NI8GhFtZrscKUywVm75w5OdFhk
         qgEA==
X-Forwarded-Encrypted: i=1; AJvYcCXK+NNoQ2cqrCS6SQcfT/1PLDBTyg5Dd7f65QMiuH9FaEVfQko8FRQtlmtt8jMhjP8RAqHDLhMiwkQhetI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVeG2jXTxiVN1gAOa4TB2BirjBose7+8MduUwAWjdVe2pkFAu2
	kRzoTYbXN/Rii0dO3UPQpEnbrB4fAEHDb/c3pWhJIWIP14pvBd3j+YaZzOAW104=
X-Google-Smtp-Source: AGHT+IGCR/cFNZkRzV9ePYjy/322zuIXX7VlmPCgSRA/zFwQPhqKjQGu9sHwjG4RxUb8TQvJkk/GRg==
X-Received: by 2002:a17:90b:1d0f:b0:2d8:7a63:f9c8 with SMTP id 98e67ed59e1d1-2e9998b7716mr2055074a91.14.1730870099812;
        Tue, 05 Nov 2024 21:14:59 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ee3e4sm87988945ad.3.2024.11.05.21.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 21:14:59 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 2/2] selftests: bonding: add ns multicast group testing
Date: Wed,  6 Nov 2024 05:14:42 +0000
Message-ID: <20241106051442.75177-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106051442.75177-1-liuhangbin@gmail.com>
References: <20241106051442.75177-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to make sure the backup slaves join correct multicast group
when arp_validate enabled and ns_ip6_target is set. Here is the result:

TEST: arp_validate (active-backup ns_ip6_target arp_validate 0)     [ OK ]
TEST: arp_validate (join mcast group)                               [ OK ]
TEST: arp_validate (active-backup ns_ip6_target arp_validate 1)     [ OK ]
TEST: arp_validate (join mcast group)                               [ OK ]
TEST: arp_validate (active-backup ns_ip6_target arp_validate 2)     [ OK ]
TEST: arp_validate (join mcast group)                               [ OK ]
TEST: arp_validate (active-backup ns_ip6_target arp_validate 3)     [ OK ]
TEST: arp_validate (join mcast group)                               [ OK ]
TEST: arp_validate (active-backup ns_ip6_target arp_validate 4)     [ OK ]
TEST: arp_validate (join mcast group)                               [ OK ]
TEST: arp_validate (active-backup ns_ip6_target arp_validate 5)     [ OK ]
TEST: arp_validate (join mcast group)                               [ OK ]
TEST: arp_validate (active-backup ns_ip6_target arp_validate 6)     [ OK ]
TEST: arp_validate (join mcast group)                               [ OK ]

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../drivers/net/bonding/bond_options.sh       | 54 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index 41d0859feb7d..edc56e2cc606 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -11,6 +11,8 @@ ALL_TESTS="
 
 lib_dir=$(dirname "$0")
 source ${lib_dir}/bond_topo_3d1c.sh
+c_maddr="33:33:00:00:00:10"
+g_maddr="33:33:00:00:02:54"
 
 skip_prio()
 {
@@ -240,6 +242,54 @@ arp_validate_test()
 	done
 }
 
+# Testing correct multicast groups are added to slaves for ns targets
+arp_validate_mcast()
+{
+	RET=0
+	local arp_valid=$(cmd_jq "ip -n ${s_ns} -j -d link show bond0" ".[].linkinfo.info_data.arp_validate")
+	local active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
+
+	for i in $(seq 0 2); do
+		maddr_list=$(ip -n ${s_ns} maddr show dev eth${i})
+
+		# arp_valid == 0 or active_slave should not join any maddrs
+		if { [ "$arp_valid" == "null" ] || [ "eth${i}" == ${active_slave} ]; } && \
+			echo "$maddr_list" | grep -qE "${c_maddr}|${g_maddr}"; then
+			RET=1
+			check_err 1 "arp_valid $arp_valid active_slave $active_slave, eth$i has mcast group"
+		# arp_valid != 0 and backup_slave should join both maddrs
+		elif [ "$arp_valid" != "null" ] && [ "eth${i}" != ${active_slave} ] && \
+		     ( ! echo "$maddr_list" | grep -q "${c_maddr}" || \
+		       ! echo "$maddr_list" | grep -q "${m_maddr}"); then
+			RET=1
+			check_err 1 "arp_valid $arp_valid active_slave $active_slave, eth$i has mcast group"
+		fi
+	done
+
+	# Do failover
+	ip -n ${s_ns} link set ${active_slave} down
+	# wait for active link change
+	slowwait 2 active_slave_changed $active_slave
+	active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
+
+	for i in $(seq 0 2); do
+		maddr_list=$(ip -n ${s_ns} maddr show dev eth${i})
+
+		# arp_valid == 0 or active_slave should not join any maddrs
+		if { [ "$arp_valid" == "null" ] || [ "eth${i}" == ${active_slave} ]; } && \
+			echo "$maddr_list" | grep -qE "${c_maddr}|${g_maddr}"; then
+			RET=1
+			check_err 1 "arp_valid $arp_valid active_slave $active_slave, eth$i has mcast group"
+		# arp_valid != 0 and backup_slave should join both maddrs
+		elif [ "$arp_valid" != "null" ] && [ "eth${i}" != ${active_slave} ] && \
+		     ( ! echo "$maddr_list" | grep -q "${c_maddr}" || \
+		       ! echo "$maddr_list" | grep -q "${m_maddr}"); then
+			RET=1
+			check_err 1 "arp_valid $arp_valid active_slave $active_slave, eth$i has mcast group"
+		fi
+	done
+}
+
 arp_validate_arp()
 {
 	local mode=$1
@@ -261,8 +311,10 @@ arp_validate_ns()
 	fi
 
 	for val in $(seq 0 6); do
-		arp_validate_test "mode $mode arp_interval 100 ns_ip6_target ${g_ip6} arp_validate $val"
+		arp_validate_test "mode $mode arp_interval 100 ns_ip6_target ${g_ip6},${c_ip6} arp_validate $val"
 		log_test "arp_validate" "$mode ns_ip6_target arp_validate $val"
+		arp_validate_mcast
+		log_test "arp_validate" "join mcast group"
 	done
 }
 
-- 
2.46.0


