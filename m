Return-Path: <netdev+bounces-79733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9417D87B14F
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 20:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71ED1C27F51
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 19:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FD86280C;
	Wed, 13 Mar 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Cky7LxcD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DF2626AE
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355095; cv=none; b=Oqqi+9qE/uziPQMjJPxH52Nrwpcly2v6VukjDh1bbDpfs6qkJs2ZXlGTCoS96wFltRzt/aZnzUbJSgtATuD9v83pIL8sNMjHKZsGRRw641p08CZn7SKkMADg16YP7ORpj7CVzIjzwOljTQaL7lEgYdR9W5CdaCUj7dmOT+Q1zZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355095; c=relaxed/simple;
	bh=URUD89ZpV/M99TV8Q1KUNJTJb1wy6+G5vnL3bqgQajI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TvdQKjGwpfkZFqojzUD3EBw3sN4HqfecCVL6E0WaUXcAXP2S06rBz20T4gvoZqoLK8V7VKDGoouqbxkdESYB/2Cm3zx9qjnzNx2rzIrBRkYUcuOthA0j/Z9uadOdP27HgFMPHrzCr/pFZJlscnXzrDRFdaducrNx7iJyYMjwMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Cky7LxcD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e94c12f33so59128f8f.3
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710355091; x=1710959891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EzQDcDpN2IS5wJV2ssrZ8U1t23GsreBp6xfIco7Uu8=;
        b=Cky7LxcDwl9vYQPaUJ5wQy2Ax1nAJmgIqeHWpJODKvLtN0HLjG5djofTuzwlU/QAwl
         e0xwC1B0W++UHhocrPrQaUWaRyoEGvVPHAy8SlRwRscGvi81ZiLEfNjZ5Mu4mYZcCCis
         ntJGzNaRGwaVsE2m3WCGexuBOd5EvOndLpg9I6i+pPnLee2dajfMfpmlznQTMBYeRvqv
         Jr7AezquA3Lb8VkThZ8bobSd5cuBAwrwr9O0NVvDo6amGkyOh6uAaEenihnpfPL+aYrf
         7dVJfuEW8sgiaEg/PZYUhY2OfVsusEPjVM8svO4IeqS9vkkKm1DJt7mmqF2QPdBjONA3
         5UIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710355091; x=1710959891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EzQDcDpN2IS5wJV2ssrZ8U1t23GsreBp6xfIco7Uu8=;
        b=J3By3UqefG9hIrWTm2ez3VPEm/9U7/Mo+IiE30Wd8YLPY38Za4mUyZXJ72dgFnU7QP
         XmTDIT5/t2K1MkieCws9a+F+M56oz0aoERZVaA4vW9U29hK9OTEf7nHq0uHKRVQmB9PL
         BzfuqHSmLHQ+LMsY9PxDQmwlvKPs85HRcYLwjJspql56YpxPf/uEtTc26N0/ybZ2f/oF
         HssgaDxxSIsNuBHLFMrEdI/Zx2a5ZCHhDmOWnjaaFlHhsFtZ4+pQim5rRtY/22MY+m6T
         XjHkdkPDA+OMXaL3tH3M+HY+tMtIHW6q6EKekK2RqCzzDnvwp+4KRWH7C/2cquvP4IPI
         Qy7g==
X-Forwarded-Encrypted: i=1; AJvYcCXKp3IXAdwOzPatb5+dhMjzumlsR9S1UknZe946sJ3gkiL0TETt7CWsmwqTBH/mBjWmK7htFchanUKFAYdCLBaN9t75rCCI
X-Gm-Message-State: AOJu0YzasY980cUaWTe7KMycPs6POmLkbOxRnaWw9ZQNSOM1Bqbz97Ng
	k63Ym1cNvXgKiQIwjEdJ+GKcGXDaCM57NwhafPTC8pxfuH9lD+eXBCnTWrJj3Yw=
X-Google-Smtp-Source: AGHT+IGN0kdH+ft/mrswhUd/gRl1XEtRbqs37iks4KzueF1kvu0EfYAfDh8X+dFbpFZ5Sfi7yl0azA==
X-Received: by 2002:adf:fa0f:0:b0:33e:800d:e87a with SMTP id m15-20020adffa0f000000b0033e800de87amr2281197wrr.34.1710355090852;
        Wed, 13 Mar 2024 11:38:10 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.85])
        by smtp.gmail.com with ESMTPSA id az19-20020adfe193000000b0033e9d9f891csm7089876wrb.58.2024.03.13.11.38.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 Mar 2024 11:38:10 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH net v3 2/2] selftests: net: veth: test the ability to independently manipulate GRO and XDP
Date: Wed, 13 Mar 2024 19:37:59 +0100
Message-Id: <20240313183759.87923-3-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240313183759.87923-1-ignat@cloudflare.com>
References: <20240313183759.87923-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should be able to independently flip either XDP or GRO states and toggling
one should not affect the other.

Adjust other tests as well that had implicit expectation that GRO would be
automatically enabled.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 tools/testing/selftests/net/udpgro_fwd.sh |  4 ++++
 tools/testing/selftests/net/veth.sh       | 24 ++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 9cd5e885e91f..380cb15e942e 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -217,6 +217,7 @@ for family in 4 6; do
 	cleanup
 
 	create_ns
+	ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
 	ip netns exec $NS_DST ethtool -K veth$DST rx-gro-list on
 	run_test "GRO frag list" $BM_NET$DST 1 0
 	cleanup
@@ -227,6 +228,7 @@ for family in 4 6; do
 	# use NAT to circumvent GRO FWD check
 	create_ns
 	ip -n $NS_DST addr add dev veth$DST $BM_NET$DST_NAT/$SUFFIX
+	ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
 	ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
 	ip netns exec $NS_DST $IPT -t nat -I PREROUTING -d $BM_NET$DST_NAT \
 					-j DNAT --to-destination $BM_NET$DST
@@ -240,6 +242,7 @@ for family in 4 6; do
 	cleanup
 
 	create_vxlan_pair
+	ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
 	ip netns exec $NS_DST ethtool -K veth$DST rx-gro-list on
 	run_test "GRO frag list over UDP tunnel" $OL_NET$DST 1 1
 	cleanup
@@ -247,6 +250,7 @@ for family in 4 6; do
 	# use NAT to circumvent GRO FWD check
 	create_vxlan_pair
 	ip -n $NS_DST addr add dev $VXDEV$DST $OL_NET$DST_NAT/$SUFFIX
+	ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
 	ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
 	ip netns exec $NS_DST $IPT -t nat -I PREROUTING -d $OL_NET$DST_NAT \
 					-j DNAT --to-destination $OL_NET$DST
diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 5ae85def0739..3a394b43e274 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -249,9 +249,9 @@ cleanup
 create_ns
 ip -n $NS_DST link set dev veth$DST up
 ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp
-chk_gro_flag "gro vs xdp while down - gro flag on" $DST on
+chk_gro_flag "gro vs xdp while down - gro flag off" $DST off
 ip -n $NS_DST link set dev veth$DST down
-chk_gro_flag "                      - after down" $DST on
+chk_gro_flag "                      - after down" $DST off
 ip -n $NS_DST link set dev veth$DST xdp off
 chk_gro_flag "                      - after xdp off" $DST off
 ip -n $NS_DST link set dev veth$DST up
@@ -260,6 +260,21 @@ ip -n $NS_SRC link set dev veth$SRC xdp object ${BPF_FILE} section xdp
 chk_gro_flag "                      - after peer xdp" $DST off
 cleanup
 
+create_ns
+ip -n $NS_DST link set dev veth$DST up
+ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp
+ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
+chk_gro_flag "gro vs xdp while down - gro flag on" $DST on
+ip -n $NS_DST link set dev veth$DST down
+chk_gro_flag "                      - after down" $DST on
+ip -n $NS_DST link set dev veth$DST xdp off
+chk_gro_flag "                      - after xdp off" $DST on
+ip -n $NS_DST link set dev veth$DST up
+chk_gro_flag "                      - after up" $DST on
+ip -n $NS_SRC link set dev veth$SRC xdp object ${BPF_FILE} section xdp
+chk_gro_flag "                      - after peer xdp" $DST on
+cleanup
+
 create_ns
 chk_channels "default channels" $DST 1 1
 
@@ -327,11 +342,14 @@ if [ $CPUS -gt 2 ]; then
 fi
 
 ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp 2>/dev/null
-chk_gro_flag "with xdp attached - gro flag" $DST on
+chk_gro_flag "with xdp attached - gro flag" $DST off
 chk_gro_flag "        - peer gro flag" $SRC off
 chk_tso_flag "        - tso flag" $SRC off
 chk_tso_flag "        - peer tso flag" $DST on
 ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
+chk_gro "        - no aggregation" 10
+ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
+chk_gro_flag "        - gro flag with GRO on" $DST on
 chk_gro "        - aggregation" 1
 
 
-- 
2.39.2


