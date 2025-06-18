Return-Path: <netdev+bounces-198978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912AEADE8FB
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C01717AD0D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B84C27E7FC;
	Wed, 18 Jun 2025 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJ47mG8H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB885BA27
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242733; cv=none; b=ndYkToxgd56Ub/OR3Q33001w/GlQkEzZpDB3GQQt+ijaGdEPYqpbInGqr0UYuYgP61/8ulX9PGzyzV3p7WR1vyZjkQZfQXR54h35iTSbBIzINAnGL7ahtvp61xemlQYEHrWi9xIakGvA80m6wCnPc5RofUlQO7tJx+AKjBHQPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242733; c=relaxed/simple;
	bh=IVTuL+spRVInXPR7rElEZ1uHHFT5pjQ4LIDFnB+xwWI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cn6DF7K3RjLtTut+nMeIbH19RyEOW9NZmgX2lBInr45WjxOLLVeFhY8GQMbt6cFKXm+JWLCFYh8G+pqWCmgBkt/nTjMoS43jClFIDH6pqQzO60hVz5R05dsSQgxWoeAISWTl+MiPOSFB2GsrakEht2y52M8f5oSzv1k+ErAtykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJ47mG8H; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748475d2a79so5048456b3a.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 03:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750242730; x=1750847530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPqi0smyhAR7jJDpx1epBOIvB0NQ/2pUQf8Aoo17ZjI=;
        b=rJ47mG8H4XPD6UGN+cecgvZxItf14XfUH3tMSTyFE0duOiOrXtNJtx5v7zb7tMi7Cl
         /xKa46UuyfsqPGvOL7m0gnw69FNILGo/6ZgYTQBXEZBKOz10oRgUTwJaMJ/AcR/xn2tz
         EqQDvp3wIoG6IUqxTs+RLtrZ0mwcLATh6C+kldPIsQKvx3odsROXm81/w1kVtcLP/DmM
         i9K6pH+/tUP8iEaolQdE2LwsK89vftMcOj15ka581MmE2ljH5oFsZMp1CkLFuX4cbj79
         ee92qzJKEES1UBb4RzNWOn/zCM91wEVh/SM3JfLHKVeWUk+R9L7+UjqysbxwOtTqWs/X
         ZI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750242730; x=1750847530;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPqi0smyhAR7jJDpx1epBOIvB0NQ/2pUQf8Aoo17ZjI=;
        b=mYB9ywoZ7NC8u+dRgakAzxEdcqEOySMOGO7Otyz869AP9OnLwHZWz5qJUdx9QTGc9/
         jgnjGDVF0IKU4KqJkPWFhNrKpMQTVSAXJ+uISy9dV72f3DhW0lTr5fGzzs/BLNge36qt
         DJIcSDB+GTqVvwWyB6na/A101zBf8F8QuI+/IdocSi237FuQS/7bAvL5EVvs4AEAaiSU
         ufMbeSMbCshgl0IrjmFPCiKWdnr9SnP4gK96HZu3dmHOrSZDfZTdRkNyxCw1feesMqFM
         qxke9AG5iXC8AbKdx3H9cdm0ukSWsJGXmcAF9YS/m95vUTOPiIu3RYpkKWjc8/Tk59Hp
         1Ngg==
X-Forwarded-Encrypted: i=1; AJvYcCWpbmX98jc+K9HG+Y0NQD3hdd9uTJhvI4wPxjVOfDZPcIBX6WSTkbZFVirgU+Q8aAoo1+4lJ+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8PN81KXJ7PhenLU6JH+D8Z8F1ChTgGBb8UDO7TMuHRx2qYqA
	4BxPtoCg8B7KEpzm6HGpQojira5xkBN76qFrJbkDvWij/9kvcjLb7yzIMscz6SR90SRV/oA0YkI
	RFSqDXUdCkLc49BkJP2oTyQ9EFA==
X-Google-Smtp-Source: AGHT+IFUejWAczU2iqpthHyJDCiDTFpzw/kUxx70AErqj8xVclqiX7Nhv9W7OCHwT0KLTqPf6Eg6ygrx1ViutHcWDQ==
X-Received: from pfba10.prod.google.com ([2002:a05:6a00:ac0a:b0:748:ea16:c7ad])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:328c:b0:1fa:9819:c0a5 with SMTP id adf61e73a8af0-21fbd55aeefmr25341548637.11.1750242730145;
 Wed, 18 Jun 2025 03:32:10 -0700 (PDT)
Date: Wed, 18 Jun 2025 19:32:04 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Message-ID: <20250618103204.3458380-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v3] selftest: Add selftest for multicast address notifications
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This commit adds a new kernel selftest to verify RTNLGRP_IPV4_MCADDR
and RTNLGRP_IPV6_MCADDR notifications. The test works by adding and
removing a dummy interface and then confirming that the system
correctly receives join and removal notifications for the 224.0.0.1
and ff02::1 multicast addresses.

The test relies on the iproute2 version to be 6.13+.

Tested by the following command:
$ vng -v --user root --cpus 16 -- \
make -C tools/testing/selftests TARGETS=3Dnet
TEST_PROGS=3Drtnetlink_notification.sh \
TEST_GEN_PROGS=3D"" run_tests

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v2:
- Move the test cases to a separate file.

Changelog since v1:
- Skip the test if the iproute2 is too old.

 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/rtnetlink_notification.sh   | 159 ++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100755 tools/testing/selftests/net/rtnetlink_notification.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests=
/net/Makefile
index 70a38f485d4d..ad258b25bc9d 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -40,6 +40,7 @@ TEST_PROGS +=3D netns-name.sh
 TEST_PROGS +=3D link_netns.py
 TEST_PROGS +=3D nl_netdev.py
 TEST_PROGS +=3D rtnetlink.py
+TEST_PROGS +=3D rtnetlink_notification.sh
 TEST_PROGS +=3D srv6_end_dt46_l3vpn_test.sh
 TEST_PROGS +=3D srv6_end_dt4_l3vpn_test.sh
 TEST_PROGS +=3D srv6_end_dt6_l3vpn_test.sh
diff --git a/tools/testing/selftests/net/rtnetlink_notification.sh b/tools/=
testing/selftests/net/rtnetlink_notification.sh
new file mode 100755
index 000000000000..a2c1afed5023
--- /dev/null
+++ b/tools/testing/selftests/net/rtnetlink_notification.sh
@@ -0,0 +1,159 @@
+#!/bin/bash
+#
+# This test is for checking rtnetlink notification callpaths, and get as m=
uch
+# coverage as possible.
+#
+# set -e
+
+ALL_TESTS=3D"
+	kci_test_mcast_addr_notification
+"
+
+VERBOSE=3D0
+PAUSE=3Dno
+PAUSE_ON_FAIL=3Dno
+
+source lib.sh
+
+# set global exit status, but never reset nonzero one.
+check_err()
+{
+	if [ $ret -eq 0 ]; then
+		ret=3D$1
+	fi
+	[ -n "$2" ] && echo "$2"
+}
+
+run_cmd_common()
+{
+	local cmd=3D"$*"
+	local out
+	if [ "$VERBOSE" =3D "1" ]; then
+		echo "COMMAND: ${cmd}"
+	fi
+	out=3D$($cmd 2>&1)
+	rc=3D$?
+	if [ "$VERBOSE" =3D "1" -a -n "$out" ]; then
+		echo "    $out"
+	fi
+	return $rc
+}
+
+run_cmd() {
+	run_cmd_common "$@"
+	rc=3D$?
+	check_err $rc
+	return $rc
+}
+
+end_test()
+{
+	echo "$*"
+	[ "${VERBOSE}" =3D "1" ] && echo
+
+	if [[ $ret -ne 0 ]] && [[ "${PAUSE_ON_FAIL}" =3D "yes" ]]; then
+		echo "Hit enter to continue"
+		read a
+	fi;
+
+	if [ "${PAUSE}" =3D "yes" ]; then
+		echo "Hit enter to continue"
+		read a
+	fi
+
+}
+
+kci_test_mcast_addr_notification()
+{
+	local tmpfile
+	local monitor_pid
+	local match_result
+
+	tmpfile=3D$(mktemp)
+
+	ip monitor maddr > $tmpfile &
+	monitor_pid=3D$!
+	sleep 1
+	if [ ! -e "/proc/$monitor_pid" ]; then
+		end_test "SKIP: mcast addr notification: iproute2 too old"
+		rm $tmpfile
+		return $ksft_skip
+	fi
+
+	run_cmd ip link add name test-dummy1 type dummy
+	run_cmd ip link set test-dummy1 up
+	run_cmd ip link del dev test-dummy1
+	sleep 1
+
+	match_result=3D$(grep -cE "test-dummy1.*(224.0.0.1|ff02::1)" $tmpfile)
+
+	kill $monitor_pid
+	rm $tmpfile
+	# There should be 4 line matches as follows.
+	# 13: test-dummy1=C2=A0 =C2=A0 inet6 mcast ff02::1 scope global=C2=A0
+	# 13: test-dummy1=C2=A0 =C2=A0 inet mcast 224.0.0.1 scope global=C2=A0
+	# Deleted 13: test-dummy1=C2=A0 =C2=A0 inet mcast 224.0.0.1 scope global=
=C2=A0
+	# Deleted 13: test-dummy1=C2=A0 =C2=A0 inet6 mcast ff02::1 scope global=
=C2=A0
+	if [ $match_result -ne 4 ];then
+		end_test "FAIL: mcast addr notification"
+		return 1
+	fi
+	end_test "PASS: mcast addr notification"
+}
+
+kci_test_rtnl()
+{
+	local current_test
+	local ret=3D0
+
+	for current_test in ${TESTS:-$ALL_TESTS}; do
+		$current_test
+		check_err $?
+	done
+
+	return $ret
+}
+
+usage()
+{
+	cat <<EOF
+usage: ${0##*/} OPTS
+
+        -t <test>   Test(s) to run (default: all)
+                    (options: $(echo $ALL_TESTS))
+        -v          Verbose mode (show commands and output)
+        -P          Pause after every test
+        -p          Pause after every failing test before cleanup (for deb=
ugging)
+EOF
+}
+
+#check for needed privileges
+if [ "$(id -u)" -ne 0 ];then
+	end_test "SKIP: Need root privileges"
+	exit $ksft_skip
+fi
+
+for x in ip;do
+	$x -Version 2>/dev/null >/dev/null
+	if [ $? -ne 0 ];then
+		end_test "SKIP: Could not run test without the $x tool"
+		exit $ksft_skip
+	fi
+done
+
+while getopts t:hvpP o; do
+	case $o in
+		t) TESTS=3D$OPTARG;;
+		v) VERBOSE=3D1;;
+		p) PAUSE_ON_FAIL=3Dyes;;
+		P) PAUSE=3Dyes;;
+		h) usage; exit 0;;
+		*) usage; exit 1;;
+	esac
+done
+
+[ $PAUSE =3D "yes" ] && PAUSE_ON_FAIL=3D"no"
+
+kci_test_rtnl
+
+exit $?
--=20
2.50.0.rc1.591.g9c95f17f64-goog


