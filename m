Return-Path: <netdev+bounces-95993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAD98C3F50
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBFD286DD3
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382714A634;
	Mon, 13 May 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="noot6eFP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4651914A614
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597657; cv=none; b=Um9P1EEzxomkdaB0VNikA5dGP/dFIAlVHCdEWOvjiFRTZsjnDtVVsS827gKq6qe0sdjiFWmVxgjHeGKEpR14DE+O2Mv4qf+tJk4ta3tUePU+SM+ZoDOWLDmcNPBRETeR42AxkJXwSY9aFg6cc9Wk/+eNgPbJQaLWip43gr8jvM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597657; c=relaxed/simple;
	bh=Szhqf8ooS3BEnxzlJQIEQprMys0NYgaUTf6nvTDM9gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wvgil2WBhr46hRANZcQj0p2c/J4iZDF+nmRiDCkFxy1OY17DilRgvjteCtkYOPreHPpRQNE2YkKVIYxrpynkShd9jUr/jn1sXWZo8/SkClrXZfuy4SYsFmMmBOjR+xwA93mUT96l4ncsBSOco6WcTuRKQFW4wKSKyAstebxalRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=noot6eFP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34db9a38755so4110860f8f.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1715597654; x=1716202454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QznyFO3rd2jTKjUKQdNYdAWkDeClk6MN0UCvUizPFTo=;
        b=noot6eFPhzdZZFVjPPRmDJZUMvVSZ98nGq2W5wLh4lvkRdxPlp/BN0yWepWFEdp1mY
         I5GZiiiu1KVMzMwx5/WMKTq0TjbdtLJBMJbQvF+2JZ6atRU1HB4kwgNX31esA4HuJFZs
         wvSIYcal1EC7DSmrVpSt8FUB6gk7RbPwpANfRnjZh/qSMlYZDyYs2wpwPGeFi7JwOPBW
         nnAlMQSbrXJmwybRSO7TRaGZj86GmAr9Ehv2H9XO26ZOEj9t06D0c4ZNivv8Gro77Jst
         7n69XnKw11ovVGJhbfRtA4TGGX/kjHLbXdP6Tj3roCST2N7IpaeJ6D6AMah4L9id7VLy
         W6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715597654; x=1716202454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QznyFO3rd2jTKjUKQdNYdAWkDeClk6MN0UCvUizPFTo=;
        b=XsfGkFhl0cLCeq7tYxQayUDXGkWEL3A0CxshewQ5q6KCgDBCN7ji665EIeJuF2XLod
         YJdyqZCpT4TlDKbdb53KNtfaALT/b+94zA7Z99TyE2rAZKLtbgH8TFPIdpseWR2SfEMQ
         8HbhmmT3tUwPZ9IHLnOV/2cSlW/pd/wccivBB8XC2qp0OgwBdej84vL3PEZ/ZHajsq97
         gWGO07m8XvRT6rN1QpsJzb0QoCQQbU2H6+QnTs08GosU9JKcBIwbOHI/hMOTmumKWnNW
         eJMUuSircOaNohJARcNi5B1SSDflRYA24yZllNVTh2FXvWZorw/JmqD41ipjCcq7sgbE
         6W/w==
X-Gm-Message-State: AOJu0YxTD419S4O5ordNCUu8rIHRt35z59HuNGGppzqlfkZprnzwv1mw
	w2aAKa/Tn5hUtnn1KctUjIFCgUOW+ivL824Q7J7k2VnXgmYwz2J0oiT+Dz3lxtzcKnNzba5FvT2
	nTqA=
X-Google-Smtp-Source: AGHT+IEXbqs6Pb+37F0hG90tB6d+LlaxcFt6/mbYceVpmrr4At3DbXjN5EY536uv7vYGDcnRNjRAoQ==
X-Received: by 2002:a05:6000:1042:b0:34c:54c8:3f2d with SMTP id ffacd0b85a97d-3504aa63858mr7314779f8f.69.1715597653869;
        Mon, 13 May 2024 03:54:13 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfd3sm10873420f8f.84.2024.05.13.03.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 03:54:13 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	edumazet@google.com,
	pabeni@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net] selftests: net: bridge: increase IGMP/MLD exclude timeout membership interval
Date: Mon, 13 May 2024 13:52:57 +0300
Message-ID: <20240513105257.769303-1-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running the bridge IGMP/MLD selftests on debug kernels we can get
spurious errors when setting up the IGMP/MLD exclude timeout tests
because the membership interval is just 3 seconds and the setup has 2
seconds of sleep plus various validations, the one second that is left
is not enough. Increase the membership interval from 3 to 5 seconds to
make room for the setup validation and 2 seconds of sleep.

Fixes: 34d7ecb3d4f7 ("selftests: net: bridge: update IGMP/MLD membership interval value")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Could you please validate this fixes the flakes for the netdev CI?
It fixed them for me with the CI's debug kernel config. :)

 tools/testing/selftests/net/forwarding/bridge_igmp.sh | 6 +++---
 tools/testing/selftests/net/forwarding/bridge_mld.sh  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index 2aa66d2a1702..e6a3e04fd83f 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -478,10 +478,10 @@ v3exc_timeout_test()
 	RET=0
 	local X=("192.0.2.20" "192.0.2.30")
 
-	# GMI should be 3 seconds
+	# GMI should be 5 seconds
 	ip link set dev br0 type bridge mcast_query_interval 100 \
 					mcast_query_response_interval 100 \
-					mcast_membership_interval 300
+					mcast_membership_interval 500
 
 	v3exclude_prepare $h1 $ALL_MAC $ALL_GROUP
 	ip link set dev br0 type bridge mcast_query_interval 500 \
@@ -489,7 +489,7 @@ v3exc_timeout_test()
 					mcast_membership_interval 1500
 
 	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q
-	sleep 3
+	sleep 5
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
 			 select(.grp == \"$TEST_GROUP\" and \
diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
index e2b9ff773c6b..f84ab2e65754 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
@@ -478,10 +478,10 @@ mldv2exc_timeout_test()
 	RET=0
 	local X=("2001:db8:1::20" "2001:db8:1::30")
 
-	# GMI should be 3 seconds
+	# GMI should be 5 seconds
 	ip link set dev br0 type bridge mcast_query_interval 100 \
 					mcast_query_response_interval 100 \
-					mcast_membership_interval 300
+					mcast_membership_interval 500
 
 	mldv2exclude_prepare $h1
 	ip link set dev br0 type bridge mcast_query_interval 500 \
@@ -489,7 +489,7 @@ mldv2exc_timeout_test()
 					mcast_membership_interval 1500
 
 	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
-	sleep 3
+	sleep 5
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
 			 select(.grp == \"$TEST_GROUP\" and \
-- 
2.44.0


