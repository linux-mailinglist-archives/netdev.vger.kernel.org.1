Return-Path: <netdev+bounces-203243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF500AF0E86
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE48717AB48
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F80323CEF9;
	Wed,  2 Jul 2025 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMExrMxU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7069822FE0A
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446590; cv=none; b=eTi5Cs5w++MRDqoTcIDHwPpP95HypwCvr3qXPdyBCqmlG2U51R9MTUG7BHgITYoEVcnAccxk5CiZnIWYqhMOfFn3sg2F13A5GI5SslRCWR/Rn3RKXAQtPSIo2s0jICQxKSACoYOCj+ZbamF5YnQIwEDBQCKiN4I777845Wmo10U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446590; c=relaxed/simple;
	bh=lXKdG049NUvrcoZ9Ja9VkZ7GPOQQsEfgP8dKPNSRynQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uKhChR14X4On0Grh3sQGdOMQpeu4vgEI/xBJqxaTTzWcVlxH4vJ6JGn9aEB2v/ajkeQqH/YVTQqj+mwOb5AdF4fRhWNJ6NrP9IqSJlHZdnor0dy2eVvcVcMn6CboFmUOqdhxZvakTLdcoJsb2ZwDRl2VS0UpEwbHge5RoS9aOqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMExrMxU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751446587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XEjJN081KSbmjEy8FR9BJwl1CZQFlf8e1QNksngA9zs=;
	b=SMExrMxUfNzB7yQd5XHHw5YX79PDA7ZW5WyWYlSan3SiEVHlMuJkyMvihtH3hgrnqaMj18
	OLSxkhio/0WCDdN/h7tNar2dIXtuzKFbRstGGsUnJWRDu2/PClASC1/BsPN9z3oBtOL6HS
	+C515Goj9sp3vlqRAWIsIu/YZqJ8kig=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-jR9go18eNiyV81WyVw3IzQ-1; Wed, 02 Jul 2025 04:56:26 -0400
X-MC-Unique: jR9go18eNiyV81WyVw3IzQ-1
X-Mimecast-MFC-AGG-ID: jR9go18eNiyV81WyVw3IzQ_1751446585
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae0a3511145so431496566b.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 01:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751446585; x=1752051385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEjJN081KSbmjEy8FR9BJwl1CZQFlf8e1QNksngA9zs=;
        b=t3PZrOE0vwtUaizFBuBZyFatXvQ4IRWWb/SPOZc9d0zTYc/UxCGGzqRj9o69fcSkQ5
         bGkK8DdIY218nTHMVPQfcDe9PxA0UoYAaEM9S6emMNGWvN9iJOhRpwK5O0FIG5b4sQQ+
         ZJE+UupLUorQapHPgHkaXlkGVC+oiFAHWi269bIicIGmO4MA36OAvGcRYTdEify6ql4M
         kLoqCxNC+mmAlEf0DQoqMAPeRJciAxc+dRhZuPXbFrv4cehkolce3f998rSPu2Hjy9sb
         2uOhPdkgAD7iBFVG/kGkcIoiJYzupU1bc1PZkiVjNx333Q3SMuzOBgDdfVgM5hn7cl2l
         QULA==
X-Gm-Message-State: AOJu0YxTqoNrBFilJg2JvMGNDjs9o5pKio4PhPQ8umSXZaW6ut5m9oA2
	G2QvdYPuTOgCu3zN8xtkqvZ74spQvwx/vwsggfqhXel4MHCiadrbFU7FHqE631NSqBqVO5CIsdg
	cVYLWkXRt3D76Tnm5TpZiAB6WkwY+7QosaovLXQw6wgsl7EU8YPJK8BLEAw==
X-Gm-Gg: ASbGncupyw8EC4dLbGmS7StPE/CVbNNZXXORRgzAHTyTkWCERnP278pqcTvqaEYUgPd
	y7GpMEx+fscNRrL45RWyf1wBWWKC2P/g43w06Mfe7JUVinEvEk9xUkbWr9UZOwytNYb3k69luzt
	AR+hMVm42mLjzu11Tgg53rzaDxQBnAHfpZTWSwSS9rrxfcXY1qddtFtQtx9B9/J/pHP9vtuNGji
	wPNsmqkZG185N/aa+/sigA7Fc6p8WeUc3R0visEJ2sJRTQZqIfdnqXkUQOfkREcMJaHFRyQakKH
	an7MMb/xnt327dsu18q3Fyv2IiG6MIbVT66++aeE/avi10M=
X-Received: by 2002:a17:907:9495:b0:ae3:6cc8:e431 with SMTP id a640c23a62f3a-ae3c2db00cemr202193566b.57.1751446584747;
        Wed, 02 Jul 2025 01:56:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx3zjKa+1cbjLDsmNVZGYXOcP8waoh1VHA5DLBy0TJLxDrFYeavyFMNO5g6ktFCJlbd59ORQ==
X-Received: by 2002:a17:907:9495:b0:ae3:6cc8:e431 with SMTP id a640c23a62f3a-ae3c2db00cemr202190366b.57.1751446584186;
        Wed, 02 Jul 2025 01:56:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca201asm1040578266b.150.2025.07.02.01.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:56:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id ABDDC1B38032; Wed, 02 Jul 2025 10:56:19 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Wed, 02 Jul 2025 10:55:57 +0200
Subject: [PATCH net-next v2 2/2] selftests: net: add netdev-l2addr.sh for
 testing L2 address functionality
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250702-netdevsim-perm_addr-v2-2-66359a6288f0@redhat.com>
References: <20250702-netdevsim-perm_addr-v2-0-66359a6288f0@redhat.com>
In-Reply-To: <20250702-netdevsim-perm_addr-v2-0-66359a6288f0@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Add a new test script to the network selftests which tests getting and
setting of layer 2 addresses through netlink, including the newly added
support for setting a permaddr on netdevsim devices.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/net/Makefile         |  1 +
 tools/testing/selftests/net/lib.sh           | 17 +++++++
 tools/testing/selftests/net/netdev-l2addr.sh | 68 ++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 54377659652907af7232907e570eea2a9c5ba3dc..66a3ef221ad758d7844034c66a1dff4497b1ab54 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -63,6 +63,7 @@ TEST_PROGS += ip_local_port_range.sh
 TEST_PROGS += rps_default_mask.sh
 TEST_PROGS += big_tcp.sh
 TEST_PROGS += netns-sysctl.sh
+TEST_PROGS += netdev-l2addr.sh
 TEST_PROGS_EXTENDED := toeplitz_client.sh toeplitz.sh xfrm_policy_add_speed.sh
 TEST_GEN_FILES =  socket nettest
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index ff0dbe23e8e0c8d3a66159d9b82fdc1fc5d4804d..b34df25a8f3a8ddb2c3ea5f1c03029cc3f0d7fae 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -240,6 +240,23 @@ create_netdevsim() {
     echo nsim$id
 }
 
+create_netdevsim_port() {
+    local nsim_id="$1"
+    local ns="$2"
+    local port_id="$3"
+    local perm_addr="$4"
+
+    echo "$port_id $perm_addr" | ip netns exec $ns tee /sys/bus/netdevsim/devices/netdevsim$nsim_id/new_port > /dev/null
+
+    local orig_dev=$(basename $(ip netns exec $ns find /sys/bus/netdevsim/devices/netdevsim$nsim_id/net/ -maxdepth 1 -name 'e*' | tail -n 1))
+    local new_dev=nsim${id}p$port_id
+
+    ip -netns $ns link set dev $orig_dev name $new_dev
+    ip -netns $ns link set dev $new_dev up
+
+    echo $new_dev
+}
+
 # Remove netdevsim with given id.
 cleanup_netdevsim() {
     local id="$1"
diff --git a/tools/testing/selftests/net/netdev-l2addr.sh b/tools/testing/selftests/net/netdev-l2addr.sh
new file mode 100755
index 0000000000000000000000000000000000000000..aa2a8bfc281f5afd87a1d93cde8e73b425c1b799
--- /dev/null
+++ b/tools/testing/selftests/net/netdev-l2addr.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+set -o pipefail
+
+NSIM_ADDR=2025
+TEST_ADDR="d0:be:d0:be:d0:00"
+
+RET_CODE=0
+
+cleanup() {
+    cleanup_netdevsim $NSIM_ADDR
+    cleanup_ns $NS
+}
+
+trap cleanup EXIT
+
+fail() {
+    echo "ERROR: ${1:-unexpected return code} (ret: $_)" >&2
+    RET_CODE=1
+}
+
+get_addr()
+{
+    local found=0
+    local type=$1
+    local dev=$2
+    local ns=$3
+
+    local output=$(ip -n $ns link show dev $dev | grep "link/")
+
+    for k in $output; do
+        if [ "$found" -eq "1" ]; then
+            echo $k
+            return 0
+        fi
+        if [[ "$k" == "$type" ]]; then
+            found=1
+        fi
+    done
+
+    return 1
+}
+
+setup_ns NS
+
+nsim=$(create_netdevsim $NSIM_ADDR $NS)
+
+get_addr link/ether $nsim $NS >/dev/null || fail "Couldn't get ether addr"
+get_addr brd $nsim $NS >/dev/null || fail "Couldn't get brd addr"
+get_addr perm $nsim $NS && fail "Found perm_addr without setting it"
+
+ip -n $NS link set dev $nsim address $TEST_ADDR
+ip -n $NS link set dev $nsim brd $TEST_ADDR
+
+[[ "$(get_addr link/ether $nsim $NS)" == "$TEST_ADDR" ]] || fail "Couldn't set ether addr"
+[[ "$(get_addr brd $nsim $NS)" == "$TEST_ADDR" ]] || fail "Couldn't set brd addr"
+
+nsim_port=$(create_netdevsim_port $NSIM_ADDR $NS 2 $TEST_ADDR)
+
+get_addr link/ether $nsim_port $NS >/dev/null || fail "Couldn't get ether addr"
+get_addr brd $nsim_port $NS >/dev/null || fail "Couldn't get brd addr"
+[[ "$(get_addr permaddr $nsim_port $NS)" == "$TEST_ADDR" ]] || fail "Couldn't get permaddr"
+
+cleanup_netdevsim $NSIM_ADDR $NS
+
+exit $RET_CODE

-- 
2.50.0


