Return-Path: <netdev+bounces-141712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7F09BC17E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0C7B21DA8
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E621ABEBA;
	Mon,  4 Nov 2024 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUX8sQYF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B01FE117
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763203; cv=none; b=qWsHo87JA+8LdNd66OiGwugE969jDsnuXjpBWVS/7/Ej8ekrzi5nMgzL4r8ej9PYue++UgjlYmFomajR65lDYE4WifBhCXUJI4RUuNpj3RbBsal6JAntALtGcDXruDUPelHxTwBdcUrsm/tuOBiCNomi4u8JO2iiohQb90xivsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763203; c=relaxed/simple;
	bh=LgQe7J5Py/2tAd8bMqhLOGuV2XDWPY4JY8JAJbwjIrc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=urQ8vPk1v+TF9wUssXmt2ZjsXieigXNVPJ+3RhUFSgj9ZGx5irfJ6NLs8pPnY9IU+XsL1IKs96LywQSMfEE7wKm7UsAWByxqm5zldRfVNxzQbfajIr8CXWh5EZFXl+anPfXcHIXznOa+qS3IFIBnnOzP7GN8w42a3NpEtXIeSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUX8sQYF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30ba241e7eso9077046276.2
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 15:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730763201; x=1731368001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MLnYBvA6SkbTyLn/Rnb+BMsmOBhuuTv1NoPy4srfiBs=;
        b=cUX8sQYFpjmwclCn+2w88ER93tidQjvesgbs3Zt0h1n1IYQfoyxJhfJYBpu6mDlpUn
         76I/hYRq0kA18JIlj3li0qDbbbkC3C/bdu3nvQm5gQag0bkd6rgCCFn40+Girhge1DDq
         aLE+cBgfAdaIIwB/EqnuzikizBWlxajGJwgQGzquVGlsqM+eiGGHqrdepVIrwmXL9Swt
         MTo+vih/LAOMuXZhuaIBU2uJBK0PaPrf48Ypd5IeQMGkWrPQifdn8ajYL+6dW2cYZw8a
         OwjvZiKQ9ahjRlRrWEj5FkV/LqivtROG8t+aL1CIXy+ST+w/YElSV3xnSVSkiCpYa9ZC
         5P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730763201; x=1731368001;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MLnYBvA6SkbTyLn/Rnb+BMsmOBhuuTv1NoPy4srfiBs=;
        b=q1sNIVaBs++qoY+1YIRvCarPIq34k6NXe90M5H40GGjOdGcl1h4Mq3HUSaTZqjdlIf
         QskRiJYj5nXRh3Z188Nt+QhXexNn7El+U0B8c1iqv88eFfdIdggANhhsBRECvQHllVMA
         rCLVo48b7EjzGwxWJfLmlmG/kGmj1j0D4qJn7jEuD61HklrSyOQNlyOjA0WFifvVPTu+
         WO4JrUIRiknmNzCfdzCH2hv32MBsP6qm0MTwaNNXKCdwI0Tz8Ge/+zM1sMlRk0mlGBL0
         BLTQGFQZhP6h43egjV/iEFtiVor0s0oFLZQW86NuPJXNbIn9kEcipnek23VoS5kRcPE9
         1VWQ==
X-Gm-Message-State: AOJu0Yzwd49DFWH73Uj7HcOWCfdZZDdItZCUvUjIz6tRI41pLhQY1qtE
	mnqyshzbGOYQKaqMqyzh3jZ8q6m4tVI6WZ7pLbO4DJi7y9e0a/VcXgtBWba2x0WUhx+mXnjufSi
	NAO4a5d4MZVIbyr7m53uUMMQf4nTpGAeSX9ariO5LvFJ7UD7to4Lj65JrzrX3qHGaP89VWdBbq6
	/cUv0hLZDDtDLB7ea5tEZ5ioTME0dv1zZF
X-Google-Smtp-Source: AGHT+IFCFCbCym2iIwKVgJZm+K6KBwyQ04f57ctt6RCUWmsaqZxsOuBheuNLLAbxIfhbdMZ6s58Gy5fU4eI=
X-Received: from wangfe.mtv.corp.google.com ([2a00:79e0:2e35:7:4cf7:d778:5c81:56cd])
 (user=wangfe job=sendgmr) by 2002:a25:83c3:0:b0:e30:c79e:16bc with SMTP id
 3f1490d57ef6-e30c79e1861mr22756276.8.1730763200199; Mon, 04 Nov 2024 15:33:20
 -0800 (PST)
Date: Mon,  4 Nov 2024 15:33:15 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241104233315.3387982-1-wangfe@google.com>
Subject: [PATCH 2/2] selftests: rtnetlink: add ipsec packet offload test
From: Feng Wang <wangfe@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, leonro@nvidia.com
Cc: wangfe@google.com
Content-Type: text/plain; charset="UTF-8"

From: wangfe <wangfe@google.com>

Duplicating kci_test_ipsec_offload to create a packet offload test.
Using the netdevsim as a device for testing ipsec packet mode.
Test the XFRM commands for setting up IPsec hardware packet offloads,
especially configuring the XFRM interface ID.

Signed-off-by: wangfe <wangfe@google.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 124 +++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index bdf6f10d0558..4ce31625d593 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -24,6 +24,7 @@ ALL_TESTS="
 	kci_test_macsec_offload
 	kci_test_ipsec
 	kci_test_ipsec_offload
+	kci_test_ipsec_packet_offload
 	kci_test_fdb_get
 	kci_test_neigh_get
 	kci_test_bridge_parent_id
@@ -841,6 +842,129 @@ EOF
 	end_test "PASS: ipsec_offload"
 }
 
+#-------------------------------------------------------------------
+# Example commands
+#   ip x s add proto esp src 14.0.0.52 dst 14.0.0.70 \
+#            spi 0x07 mode tunnel reqid 0x07 replay-window 32 \
+#            aead 'rfc4106(gcm(aes))' 1234567890123456dcba 128 \
+#            sel src 14.0.0.52/24 dst 14.0.0.70/24
+#            offload packet dev ipsec1 dir out if_id 1
+#   ip x p add dir out src 14.0.0.52/24 dst 14.0.0.70/24 \
+#            tmpl proto esp src 14.0.0.52 dst 14.0.0.70 \
+#            spi 0x07 mode tunnel reqid 0x07 \
+#            offload packet dev ipsec1 if_id 1
+#
+#-------------------------------------------------------------------
+kci_test_ipsec_packet_offload()
+{
+	local ret=0
+	algo="aead rfc4106(gcm(aes)) 0x3132333435363738393031323334353664636261 128"
+	srcip=192.168.123.3
+	dstip=192.168.123.4
+	sysfsd=/sys/kernel/debug/netdevsim/netdevsim0/ports/0/
+	sysfsf=$sysfsd/ipsec
+	sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
+	probed=false
+
+	if ! mount | grep -q debugfs; then
+		mount -t debugfs none /sys/kernel/debug/ &> /dev/null
+	fi
+
+	# setup netdevsim since dummydev doesn't have offload support
+	if [ ! -w /sys/bus/netdevsim/new_device ] ; then
+		run_cmd modprobe -q netdevsim
+		if [ $ret -ne 0 ]; then
+			end_test "SKIP: ipsec_packet_offload can't load netdevsim"
+			return $ksft_skip
+		fi
+		probed=true
+	fi
+
+	echo "0" > /sys/bus/netdevsim/new_device
+	while [ ! -d $sysfsnet ] ; do :; done
+	udevadm settle
+	dev=`ls $sysfsnet`
+
+	ip addr add $netdevsimip dev $dev
+	ip link set $dev up
+	if [ ! -d $sysfsd ] ; then
+		end_test "FAIL: ipsec_packet_offload can't create device $dev"
+		return 1
+	fi
+	if [ ! -f $sysfsf ] ; then
+		end_test "FAIL: ipsec_packet_offload netdevsim doesn't support offload"
+		return 1
+	fi
+
+	# flush to be sure there's nothing configured
+	ip x s flush ; ip x p flush
+
+	# create offloaded out SA
+	run_cmd ip x p add offload packet dev $dev dir out src $srcip/24 \
+	    dst $dstip/24 tmpl proto esp src $srcip dst $dstip spi 9 \
+	    mode tunnel reqid 42 if_id $ipsec_if_id
+
+	run_cmd ip x s add proto esp src $srcip dst $dstip spi 9 \
+	    mode tunnel reqid 42 $algo sel src $srcip/24 dst $dstip/24 \
+	    offload packet dev $dev dir out if_id $ipsec_if_id
+
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: ipsec_packet_offload can't create SA"
+		return 1
+	fi
+
+	# does offload show up in ip output
+	lines=`ip x s list | grep -c "crypto offload parameters: dev $dev dir"`
+	if [ $lines -ne 1 ] ; then
+		check_err 1
+		end_test "FAIL: ipsec_packet_offload SA missing from list output"
+	fi
+
+	# setup xfrm interface
+	ip link add $ipsecdev type xfrm dev lo if_id $ipsec_if_id
+	ip link set $ipsecdev up
+	ip addr add $srcip/24 dev $ipsecdev
+
+	# we didn't create a peer, make sure we can Tx
+	ip neigh add $dstip dev $dev lladdr 00:11:22:33:44:55
+	# use ping to exercise the Tx path
+	ping -I $ipsecdev -c 3 -W 1 -i 0 $dstip >/dev/null
+
+	# remove xfrm interface
+	ip link delete $ipsecdev
+
+	# does driver have correct offload info
+	run_cmd diff $sysfsf - << EOF
+SA count=1 tx=3
+sa[0] tx ipaddr=0x00000000 00000000 00000000 00000000
+sa[0]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
+sa[0]    key=0x34333231 38373635 32313039 36353433
+EOF
+	if [ $? -ne 0 ] ; then
+		end_test "FAIL: ipsec_packet_offload incorrect driver data"
+		check_err 1
+	fi
+
+	# does offload get removed from driver
+	ip x s flush
+	ip x p flush
+	lines=`grep -c "SA count=0" $sysfsf`
+	if [ $lines -ne 1 ] ; then
+		check_err 1
+		end_test "FAIL: ipsec_packet_offload SA not removed from driver"
+	fi
+
+	# clean up any leftovers
+	echo 0 > /sys/bus/netdevsim/del_device
+	$probed && rmmod netdevsim
+
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: ipsec_packet_offload"
+		return 1
+	fi
+	end_test "PASS: ipsec_packet_offload"
+}
+
 kci_test_gretap()
 {
 	DEV_NS=gretap00
-- 
2.47.0.199.ga7371fff76-goog


