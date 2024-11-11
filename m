Return-Path: <netdev+bounces-143706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B09C3BC3
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 137F3B22746
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83B6189BB0;
	Mon, 11 Nov 2024 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcaWamqQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E8189B8C;
	Mon, 11 Nov 2024 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320229; cv=none; b=jEfTuW2f6i3YxWgwdDwgp+lEHN63gSlDIW1GeZZYWuNUWcQkysohROn0CDyxPwyayQZsxenTeCOKDUp6dm75yeWI8kaNL5TbANx2xfBdIsDTDWIMxdaZBJmNQ6R8LhP0prKVnGEgKM4Tw1D2QgIn6z6QHpEpmLPhF/LXWqXBurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320229; c=relaxed/simple;
	bh=hPy0N/ggUKEFmDgES9LnVN+aRaEPJhuUjeclsVaej90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndz+okpsU1qk3eawsU6BbBzYimCqT787lRxGYEA/rIpYEKy7Tj0HTMLr+A+m068sirT4FkN4cvqhR7Uxb++FLVAqRd9qCb/w0vqpG3r0upTORUlvREvM0UYxF6DrM9GVgP36+7+yiRH+hZTawOdKj1rwzgUvxlddi6VGRDXTwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcaWamqQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2836128a12.0;
        Mon, 11 Nov 2024 02:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731320227; x=1731925027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYDOLMZA+kc/pY3CV46oKmS2BO0tiarAplcF7SwTosE=;
        b=gcaWamqQL6XGRzTIQp1ctVpq+iEzYLAkDKB3s0cA9l8JelCtJTvJxujhBgG4t5bWFO
         d7XkNoxrtMryWX/QCQIs6Ed7o+ne4pjm3ptWN3lfNC+rr9KXd2XhP5CrspAKmzQbx4YJ
         Wc8FhGeYUrLKFX1Zi0xWiGM8t8Jg3bt1yXbbWg/fem4H/q1emXQdtAyfqLIAw7y3Rklj
         LHK1O2Mk6vVJF6X9JC6/SoAoCVMxUMd1681J+0KPfNpBSbe/NuY+PfFbBxDLlUbrLbkd
         hkUs+bxEzTx/RMfypWR8oqbdXyNvqHthvtWovCpv6bbu/1PEpQO2MVjPRbXcL0E0lwHL
         go6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731320227; x=1731925027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYDOLMZA+kc/pY3CV46oKmS2BO0tiarAplcF7SwTosE=;
        b=vpOEz3S+oNuyJyQcjPI/D1ISuF0p3sDH7CREQuNwOPmTQ41B5sVqWIT4IZpzNstK4j
         aPhGsCuCf+YVFJ1450vnKLwsJQ8y0EGDj7itUzmGK0OMZLFRm6zn5hUsYyhXbwDp2ktS
         /FkGhRjfb4FTfrhKL35IR2fKbxAan52obotmW572Kpl7mrlROukByx1s1QGayEnWR2Ho
         MHM5y/Dt9UHEvJ9YQtycrB3Xp8ywmGfyyP4p9OgxcwwHHXAwlVQs4xnDNbAotHjQ/1Jj
         yHgDcB9dSkrkyLxR7aMOvDJ34NEhMLsTtmAaBpSVBvrutrP9XC9zuTyjaV8EbbLrW+Ly
         lA8g==
X-Forwarded-Encrypted: i=1; AJvYcCUWnPH12HwPy5k5+NJRXVUa94VIJi0qvAVOJnIp1B+r87BRsQTP23UnE2dRXVbS8ux0g0IXHDbQwArEO0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0E6rsm/MUgL857vDpwdvCcmhc0IFQN4P8l7XPaN9pksldmvg
	cgaz+rd3LunC8ESoc9dR4nJHCvB/owVxp0TMiRxjLog2i3s7VZL9qzEdlLKULOj7gA==
X-Google-Smtp-Source: AGHT+IFu6dmMXBi45m2TUm4LxNdCe1T70EJ/x9v//Bf0vTCiMHtDuNOHBCb2ToGT85rUY0m7exvuTw==
X-Received: by 2002:a05:6a21:6d9f:b0:1db:daab:2ae7 with SMTP id adf61e73a8af0-1dc229afa19mr16591947637.19.1731320227165;
        Mon, 11 Nov 2024 02:17:07 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9b26b9bd8sm6309831a91.5.2024.11.11.02.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:17:06 -0800 (PST)
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
Subject: [PATCHv4 net 2/2] selftests: bonding: add ns multicast group testing
Date: Mon, 11 Nov 2024 10:16:50 +0000
Message-ID: <20241111101650.27685-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241111101650.27685-1-liuhangbin@gmail.com>
References: <20241111101650.27685-1-liuhangbin@gmail.com>
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


