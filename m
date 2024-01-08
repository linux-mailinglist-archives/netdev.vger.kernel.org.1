Return-Path: <netdev+bounces-62337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1391826AED
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 10:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64815282563
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63023125A2;
	Mon,  8 Jan 2024 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="V6tQasb5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E30C12B99
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-50e8ca6c76dso1552916e87.3
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 01:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704706864; x=1705311664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8G+K5fy0HhUmQ3VUPZS+WOaF1lcIx6Tgk5vqHUVYxE=;
        b=V6tQasb5HYkdRJvsh+Ox36h2OJQYl6nu36Jy5qlA37IzZGqbJwkfuOxvkE4e04Wptd
         idZIvskBSCO4nTo/svzOoFvwz+CbUpLTA5Mjd6vyOGyLP206MqX1aXMa+pNQiNSIRq8k
         qCIIO7TwPy0VdK2V+354HzOpoekGEyaaqY9s1M6tClKRkQEd+Hg2BeoLx77qKFyGWAgd
         UKs5FolhISBIExT2bfyNRIXe3QH01IiT+SzzANzCSqp6/abQ4l8kY4BK7LWaiWhpIwI5
         nufdqg9u893nByuQtoXDDvYpKYXsTpJg8Uqa2Q6RCeWsXhnc2d7KVEhixv4lEJh7mfSO
         R7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706864; x=1705311664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8G+K5fy0HhUmQ3VUPZS+WOaF1lcIx6Tgk5vqHUVYxE=;
        b=wITRzt8PZtWITyYJcPD4fRQvYQ2iM4hBCFnH2PNxPMj503E2YlAMEQWMzskZa7k/vg
         BxlKPl+1XJoq5BL6buKO0XcM0/3ne7xT1gBodTsJzXUmNCUdYacuMsGSafrVMKIEblYH
         hbvy9ZtUQShcfxjOvdEn91NMRgw84MctXg9+r871EfHJVZO51jrtz+WY48/o6EVKCqDh
         CMXa7Oo2xAPeGFV96piA4MnEatajc6AtLndoWCG45MEv4sRcbLPbarQN6d2Q8GUMx1Y/
         II07pli0mAT1AKYnwO3/OllqiIKx6sDv8WkiBml/R4G4G4znX3unlb12Lxc9O5NU57+I
         TlkQ==
X-Gm-Message-State: AOJu0Yz9j4Wp1WpUgnJGeRYLWuTXc0tezkrK1jFselqMQNx3wuylAvTP
	d7VncXnhhMxWj2fEH0zQxI6Nh+bmG1plphm/w9oEFjnUkTAJgh8s7CZDRQ==
X-Google-Smtp-Source: AGHT+IGHk93Ajrt7mQzwRhOoVXLmW/aJqd1fhyT7ilckS5nYvC+nsDIi8YmdpuFsZZn2a5QUu//twZBjkCmG
X-Received: by 2002:a19:e055:0:b0:50e:55fc:1e3f with SMTP id g21-20020a19e055000000b0050e55fc1e3fmr941253lfj.135.1704706864559;
        Mon, 08 Jan 2024 01:41:04 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id c2-20020a056000184200b00336d3101131sm337033wri.40.2024.01.08.01.41.04;
        Mon, 08 Jan 2024 01:41:04 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 48C0660264;
	Mon,  8 Jan 2024 10:41:04 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1rMm7z-008OeJ-VX; Mon, 08 Jan 2024 10:41:03 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net v4 2/2] selftests: rtnetlink: check enslaving iface in a bond
Date: Mon,  8 Jan 2024 10:41:03 +0100
Message-Id: <20240108094103.2001224-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108094103.2001224-1-nicolas.dichtel@6wind.com>
References: <20240108094103.2001224-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal is to check the following two sequences:
> ip link set dummy0 up
> ip link set dummy0 master bond0 down

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 26827ea4e3e5..bbf9d2bd3d7b 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -28,6 +28,7 @@ ALL_TESTS="
 	kci_test_neigh_get
 	kci_test_bridge_parent_id
 	kci_test_address_proto
+	kci_test_enslave_bonding
 "
 
 devdummy="test-dummy0"
@@ -1239,6 +1240,33 @@ kci_test_address_proto()
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
+	if [ $ret -ne 0 ]; then
+		end_test "SKIP bonding tests: cannot add net namespace $testns"
+		return $ksft_skip
+	fi
+
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
+	end_test "PASS: enslave interface in a bond"
+	ip netns del "$testns"
+}
+
 kci_test_rtnl()
 {
 	local current_test
-- 
2.39.2


