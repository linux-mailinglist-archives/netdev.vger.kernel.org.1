Return-Path: <netdev+bounces-61618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5E0824684
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 922C2B22B8F
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C0824B5E;
	Thu,  4 Jan 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="WzOsoafM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2F250EA
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-40d8e7a50c1so7371105e9.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 08:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704386583; x=1704991383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy0yP1yJafP+MELjBEJ8WOyn3ovEgyUJvxintBHAgQA=;
        b=WzOsoafMlPAxYFPtGoVRTIJRb+UCcD14bpdxL1AIKOvo5/wAQ2vkqrUyzpHyHM8qWY
         yuUfAyY0sjAkAkGN4xHHyFQCDl4OVTDwSd+fcViM/ZxY4nvsUBCfy8qbdeYlu6b0lZ7u
         u8To60dMsQJHov/VM3NWCd2zYL5Oo/cGTMUUwUGukY5ypkRkGVcbOtBNifYjfmSCcwnf
         Y+SKcfkDrKvjABLerGcXzXeNOCGkM0zOsG4BmOUGnLApdSEn7aL6Q8FAOETrKBQfs/s8
         4GGIei0kE+W7dwmVi7vmGi+6K2ZvA8opZoRDBx9CnIchd8rddZ8FeYQ9csWw/kMWM+eK
         0/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386583; x=1704991383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy0yP1yJafP+MELjBEJ8WOyn3ovEgyUJvxintBHAgQA=;
        b=Ne7BQEo6YQ+FzI0cQSSBb/k39zCeM03hEymuFh9VB0rQRS+Bu14tS8vYw3U19oXJtm
         g6HpmiSFsdBueOQq1oU49/ehGzJr3gFIMhkTS98B+B5M1xZfGabuEPujKOQ5a+jydUX5
         XnjulHzbV5UPKxAL6oXBpTA2e3OALJKvW91YTyMWrh5TtqAB9q6y+7UIbzW061Kp0FUO
         LdA4OoONebZk2fZZQ2pMrsK04h3Z28R8J2bGiwkzbHNOPPOR+51SiEPJ2pHIGJfLhivP
         zuMQMxrq8A2NcLjYagr6wjaqVBJXicp6NpEiuP399wQO6+JUtZDxEwJ/hlQCOfUzMIHB
         97iw==
X-Gm-Message-State: AOJu0YzVFB3xZgi1ph1GKRj6evz4HZjC4qitrfcuL7GK2OgMVHaX5vid
	ox9MZzRn9PyCugOVOKXIGu/27F5+tV6S1pMWCfXYA22Kn7nh12Y0lK1tQg==
X-Google-Smtp-Source: AGHT+IFd8gRevlolG576Ep5f1feycWhNy2qQS4Mhw5R+iCQBkyy6ykcqKJXd0zHRTXWLaOXHOWv7hJKkEDw6
X-Received: by 2002:a05:600c:35c4:b0:40c:5822:bca7 with SMTP id r4-20020a05600c35c400b0040c5822bca7mr471938wmq.215.1704386583429;
        Thu, 04 Jan 2024 08:43:03 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id z21-20020a05600c0a1500b0040e315d6d58sm43634wmp.38.2024.01.04.08.43.03;
        Thu, 04 Jan 2024 08:43:03 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 26E44601FE;
	Thu,  4 Jan 2024 17:43:03 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1rLQoA-00GEpj-Qx; Thu, 04 Jan 2024 17:43:02 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net v3 2/2] selftests: rtnetlink: check enslaving iface in a bond
Date: Thu,  4 Jan 2024 17:43:00 +0100
Message-Id: <20240104164300.3870209-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104164300.3870209-1-nicolas.dichtel@6wind.com>
References: <20240104164300.3870209-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal is to check the following two sequences:
> ip link set dummy0 down
> ip link set dummy0 master bond0 up

and
> ip link set dummy0 up
> ip link set dummy0 master bond0 down

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 tools/testing/selftests/net/rtnetlink.sh | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 26827ea4e3e5..181c689457e1 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -28,6 +28,7 @@ ALL_TESTS="
 	kci_test_neigh_get
 	kci_test_bridge_parent_id
 	kci_test_address_proto
+	kci_test_enslave_bonding
 "
 
 devdummy="test-dummy0"
@@ -1239,6 +1240,44 @@ kci_test_address_proto()
 	return $ret
 }
 
+kci_test_enslave_bonding()
+{
+	local testns="testns"
+	local bond="bond123"
+	local dummy="dummy123"
+	local ret=0
+
+	run_cmd ip netns add "$testns"
+	if [ $? -ne 0 ]; then
+		end_test "SKIP bonding tests: cannot add net namespace $testns"
+		return $ksft_skip
+	fi
+
+	# test native tunnel
+	run_cmd ip -netns $testns link add dev $bond type bond mode balance-rr
+	run_cmd ip -netns $testns link add dev $dummy type dummy
+	run_cmd ip -netns $testns link set dev $dummy up
+	run_cmd ip -netns $testns link set dev $dummy master $bond down
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: initially up interface added to a bond and set down"
+		ip netns del "$testns"
+		return 1
+	fi
+
+	run_cmd ip -netns $testns link del dev $dummy
+	run_cmd ip -netns $testns link add dev $dummy type dummy
+	run_cmd ip -netns $testns link set dev $dummy down
+	run_cmd ip -netns $testns link set dev $dummy master $bond up
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: enslave a down interface in a bonding and set it up"
+		ip netns del "$testns"
+		return 1
+	fi
+
+	end_test "PASS: enslave iface in a bonding"
+	ip netns del "$testns"
+}
+
 kci_test_rtnl()
 {
 	local current_test
-- 
2.39.2


