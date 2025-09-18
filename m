Return-Path: <netdev+bounces-224230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5533B829AB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 04:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA772A6C5C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 02:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6128622E406;
	Thu, 18 Sep 2025 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6R8zDoC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6A22A1D5
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160941; cv=none; b=uuOv77wbJvuV1dSWY1Gq29vhX6Kz9tXyPi5iIn9DTBpEBX0X7oxhtt6cI1qW1q91ll3e6GZY88VUiiCVKIUd9LzYefN8dexrvt5Qt7qnGBZ97fColi44CHo49eZAGRMmDHOy3hjrF4w706y+0cy72MJg/hlxylCGOg6pf97U64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160941; c=relaxed/simple;
	bh=2/fxoBw/eO0Z771F3ZbYw8Gx/hBEMx2AjmHFjOCRRp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJ+Z/rls2T93J9/yOo9uIdHJW4KbNMfz5f0QSoP1w8T+NMDH4R69raq10IxhGgTjEweipMMurAmCZjQAeoTWfLUfCUtT3gT8H+v7LJFdNeXRCmydEYDFVYFTuyu1UkHvQDTD/98Bm9K5LU7OftseZoGa6EgOBgmlCZfqAF7pNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6R8zDoC; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5241e51764so293144a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 19:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758160939; x=1758765739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKMKJckFeCNhR9+KARzoI/337ffofy4J8g8ZVKgyOpE=;
        b=b6R8zDoCRvV0Hzx2LWez0OaKxMKImpuO4va+D9qNYc31Sv7pZa6l+kzi63bEbMCAua
         nG5CIFOMSZnoKuJxTvfh4NEgvRirMJJ0DlKFyTS9a9AJRsu/qTiNCTyu/23hx1jjWJEC
         1nsBnYukvV8L1qaV/SbEYbtSgCOiWt7SwoGrmi7hAx8zh7S65RURV5bMc9v/G8uM26Bd
         4T7F3IERMJzb0DxfjWvgFpUKORd1+90gjQUfj2hnFIeGjOp1SsLlSYd3QYsRmTeJTghg
         sRvWrTpoohJdyXV1aOnsiIN93VxVCrPKf7GRzuxRJNcv2yXuKuLVf8r5vi9iIHTJnxuM
         CbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160939; x=1758765739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKMKJckFeCNhR9+KARzoI/337ffofy4J8g8ZVKgyOpE=;
        b=iM+syRRXz6z8yAeij3hC9b9ddD12ZlQcfvEUS9iJb8byueRecE+dpmKAhrV18Od0tB
         MF+hAGEWvAz73O1phxPm8n+g9nMCY7DhDtTLCfepUwvv9ENcJInLE8rrhyCgPD9cSN0O
         9CPG4MzuFaLjIJxa4ca3RZP8afScn9Rkt45dCOXaTdAM0e7TKYkmjL5SyhfJrLZtCI/w
         F2674ch+fsODuVwHS1BvRL/TV3l+uWF3pwfyvwOoxlTcqR/VmCGlXd62fHQoZiQZW1MT
         S+bqinrxqjJsxmkMnyngLkFYUC7HussHRxHxznRn6/yP7NjdNsVNuYMEfd+2qZxMlLGN
         rduA==
X-Gm-Message-State: AOJu0YzNIE0BRCdWrZFO35xFykXo5Il9XkOOQapBbexgIDxOCpKhbSc3
	QtQXd8Pthpe7lQe1HCioSlkTtfWhjSzHO/sOSukhMpAL/rRS4ERZ4UbNgMe8GJpCuLk=
X-Gm-Gg: ASbGnctbfxPf2slOAmD4oRWTGJjsv8KEElZhOQ9J3rQscTFSAX1wtITZJKvWySz76qu
	Wx+UIwnFlyXja0ff4OL3FGd5V3FioO+k3uXe+1XPouOTQZ4h0i5yNicapYWTEhTUk9M1Twz+JNY
	Iom5CGJvchpBz/uiw4NhLsHr7TAVh1wDUW4dIIjUl0vPFhMmntRK0YLuq6pDdaitpXtyiVa+VJI
	f0Wm0nGAoIp1GEFvucdJhwTPW8PCgcmw8Vp4sA69N5YUuoFA+hudw5Q+NduPzta3+dVm7jlEg48
	I8ITzhlto9uCldiMGQvzb/fwvPFacfaUpeS1b9Ug7cO4irg/hDo/nmANyGKBTLI/V+tvtNnn/y/
	9TipT2h7j1XkGSo9geiD1IXm2k46jE+OfvPk6vkTeJqc0hEwgxPTZN1Jl2an9QI9rQKG/eWU=
X-Google-Smtp-Source: AGHT+IHqki49y858cz8uAT3HNtxDkxnmtonF8Pw70pszjXa6oBUqHhCwlyfVaGai7TbfK2A2K0bU/w==
X-Received: by 2002:a05:6a20:7287:b0:260:80e1:33a3 with SMTP id adf61e73a8af0-27aaf1ce78dmr5871379637.32.1758160938776;
        Wed, 17 Sep 2025 19:02:18 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff38eaf1sm806417a12.24.2025.09.17.19.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 19:02:18 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 2/2] selftests: bonding: add ipsec offload test
Date: Thu, 18 Sep 2025 02:02:02 +0000
Message-ID: <20250918020202.440904-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250918020202.440904-1-liuhangbin@gmail.com>
References: <20250918020202.440904-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces a test for IPSec offload over bonding, utilizing netdevsim
for the testing process, as veth interfaces do not support IPSec offload.
The test will ensure that the IPSec offload functionality remains operational
even after a failover event occurs in the bonding configuration.

Here is the test result:

TEST: bond_ipsec_offload (active_slave eth0)                        [ OK ]
TEST: bond_ipsec_offload (active_slave eth1)                        [ OK ]

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: rebase to latest net, no code update
---
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_ipsec_offload.sh | 154 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   4 +
 3 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 44b98f17f8ff..c13ef40e7db1 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -11,7 +11,8 @@ TEST_PROGS := \
 	bond_options.sh \
 	bond-eth-type-change.sh \
 	bond_macvlan_ipvlan.sh \
-	bond_passive_lacp.sh
+	bond_passive_lacp.sh \
+	bond_ipsec_offload.sh
 
 TEST_FILES := \
 	lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh b/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
new file mode 100755
index 000000000000..4b19949a4c33
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
@@ -0,0 +1,154 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# IPsec over bonding offload test:
+#
+#  +----------------+
+#  |     bond0      |
+#  |       |        |
+#  |  eth0    eth1  |
+#  +---+-------+----+
+#
+# We use netdevsim instead of physical interfaces
+#-------------------------------------------------------------------
+# Example commands
+#   ip x s add proto esp src 192.0.2.1 dst 192.0.2.2 \
+#            spi 0x07 mode transport reqid 0x07 replay-window 32 \
+#            aead 'rfc4106(gcm(aes))' 1234567890123456dcba 128 \
+#            sel src 192.0.2.1/24 dst 192.0.2.2/24
+#            offload dev bond0 dir out
+#   ip x p add dir out src 192.0.2.1/24 dst 192.0.2.2/24 \
+#            tmpl proto esp src 192.0.2.1 dst 192.0.2.2 \
+#            spi 0x07 mode transport reqid 0x07
+#
+#-------------------------------------------------------------------
+
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/lib.sh
+algo="aead rfc4106(gcm(aes)) 0x3132333435363738393031323334353664636261 128"
+srcip=192.0.2.1
+dstip=192.0.2.2
+ipsec0=/sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
+ipsec1=/sys/kernel/debug/netdevsim/netdevsim0/ports/1/ipsec
+active_slave=""
+
+active_slave_changed()
+{
+        local old_active_slave=$1
+        local new_active_slave=$(ip -n ${ns} -d -j link show bond0 | \
+				 jq -r ".[].linkinfo.info_data.active_slave")
+        [ "$new_active_slave" != "$old_active_slave" -a "$new_active_slave" != "null" ]
+}
+
+test_offload()
+{
+	# use ping to exercise the Tx path
+	ip netns exec $ns ping -I bond0 -c 3 -W 1 -i 0 $dstip >/dev/null
+
+	active_slave=$(ip -n ${ns} -d -j link show bond0 | \
+		       jq -r ".[].linkinfo.info_data.active_slave")
+
+	if [ $active_slave = $nic0 ]; then
+		sysfs=$ipsec0
+	elif [ $active_slave = $nic1 ]; then
+		sysfs=$ipsec1
+	else
+		check_err 1 "bond_ipsec_offload invalid active_slave $active_slave"
+	fi
+
+	# The tx/rx order in sysfs may changed after failover
+	grep -q "SA count=2 tx=3" $sysfs && grep -q "tx ipaddr=$dstip" $sysfs
+	check_err $? "incorrect tx count with link ${active_slave}"
+
+	log_test bond_ipsec_offload "active_slave ${active_slave}"
+}
+
+setup_env()
+{
+	if ! mount | grep -q debugfs; then
+		mount -t debugfs none /sys/kernel/debug/ &> /dev/null
+		defer umount /sys/kernel/debug/
+
+	fi
+
+	# setup netdevsim since dummy/veth dev doesn't have offload support
+	if [ ! -w /sys/bus/netdevsim/new_device ] ; then
+		modprobe -q netdevsim
+		if [ $? -ne 0 ]; then
+			echo "SKIP: can't load netdevsim for ipsec offload"
+			exit $ksft_skip
+		fi
+		defer modprobe -r netdevsim
+	fi
+
+	setup_ns ns
+	defer cleanup_ns $ns
+}
+
+setup_bond()
+{
+	ip -n $ns link add bond0 type bond mode active-backup miimon 100
+	ip -n $ns addr add $srcip/24 dev bond0
+	ip -n $ns link set bond0 up
+
+	ifaces=$(ip netns exec $ns bash -c '
+		sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
+		echo "0 2" > /sys/bus/netdevsim/new_device
+		while [ ! -d $sysfsnet ] ; do :; done
+		udevadm settle
+		ls $sysfsnet
+	')
+	nic0=$(echo $ifaces | cut -f1 -d ' ')
+	nic1=$(echo $ifaces | cut -f2 -d ' ')
+	ip -n $ns link set $nic0 master bond0
+	ip -n $ns link set $nic1 master bond0
+
+	# we didn't create a peer, make sure we can Tx by adding a permanent
+	# neighbour this need to be added after enslave
+	ip -n $ns neigh add $dstip dev bond0 lladdr 00:11:22:33:44:55
+
+	# create offloaded SAs, both in and out
+	ip -n $ns x p add dir out src $srcip/24 dst $dstip/24 \
+	    tmpl proto esp src $srcip dst $dstip spi 9 \
+	    mode transport reqid 42
+
+	ip -n $ns x p add dir in src $dstip/24 dst $srcip/24 \
+	    tmpl proto esp src $dstip dst $srcip spi 9 \
+	    mode transport reqid 42
+
+	ip -n $ns x s add proto esp src $srcip dst $dstip spi 9 \
+	    mode transport reqid 42 $algo sel src $srcip/24 dst $dstip/24 \
+	    offload dev bond0 dir out
+
+	ip -n $ns x s add proto esp src $dstip dst $srcip spi 9 \
+	    mode transport reqid 42 $algo sel src $dstip/24 dst $srcip/24 \
+	    offload dev bond0 dir in
+
+	# does offload show up in ip output
+	lines=`ip -n $ns x s list | grep -c "crypto offload parameters: dev bond0 dir"`
+	if [ $lines -ne 2 ] ; then
+		check_err 1 "bond_ipsec_offload SA offload missing from list output"
+	fi
+}
+
+trap defer_scopes_cleanup EXIT
+setup_env
+setup_bond
+
+# start Offload testing
+test_offload
+
+# do failover and re-test
+ip -n $ns link set $active_slave down
+slowwait 5 active_slave_changed $active_slave
+test_offload
+
+# make sure offload get removed from driver
+ip -n $ns x s flush
+ip -n $ns x p flush
+line0=$(grep -c "SA count=0" $ipsec0)
+line1=$(grep -c "SA count=0" $ipsec1)
+[ $line0 -ne 1 -o $line1 -ne 1 ]
+check_fail $? "bond_ipsec_offload SA not removed from driver"
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index 832fa1caeb66..e5b7a8db4dfa 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -11,3 +11,7 @@ CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=m
+CONFIG_INET_ESP=y
+CONFIG_INET_ESP_OFFLOAD=y
+CONFIG_XFRM_USER=m
+CONFIG_NETDEVSIM=m
-- 
2.50.1


