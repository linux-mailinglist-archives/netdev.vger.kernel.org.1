Return-Path: <netdev+bounces-210980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C94B15FD5
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 13:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D870D3A7A96
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DEF290D81;
	Wed, 30 Jul 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBaB3MLO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD35836124
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876397; cv=none; b=BnYKzS+GFOPq82xr9c5pT4KvLAn/DxhVaUheqlpYifGMv5JxoCgpDlEzjvz2NCbEbp3qqZYEOwDXmi0Pew1g79ZKdxuTjWEnWMiBT0vZsXb7Y68Cmnx1EkbsRR3xMiiBEO7b3HU3kdc3uwtpdVtpivEXwgQGQ0V9CAMhIQaxk0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876397; c=relaxed/simple;
	bh=yVabHxfSqLwN2uVGH1+otX9ABzDaJCeiioqaHtBO4cU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OKu7hsMxBfEYFRsqrjgkKHrQlpAnQIdF5a39fcRrzbiVh38b0z2R1kMxAFRbdjKYpvSyKlYb3dy7TAAVVJpVJyNOJ45CJ+xMdvrJVNXjjrDDWIwyEnKbtHkhspjTwPLhrlHOcpJkrZWJHb3yueCSwpP+Y3EczugZEOYwxxKYFMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hBaB3MLO; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e1b84c9a3dso1011874785a.2
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 04:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753876394; x=1754481194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SSn9CrZE9qB6hDrHRGXLwFtTDwyA0YiugOykJbTpTVY=;
        b=hBaB3MLOwz7cUvHCPAim7kxgci6Fpf/CXc/jGr2cuPNYqKlXyLP46i1quU8Xj0qQNK
         rxd1lIzvvIFfQPdmsqQ2oFgaiyezwoXJ+EyfG7ebjH9m1HYD0KvtMO98vxdNN3+QU5TV
         Sm47fqaKpTLywTzNn/PWaepdCX0ui2PtujaaOHPozZEeuJJZoVx6P53GN3++J+rVxAwT
         LL/nkRMtPaS69yPHj0NeDbX6p6sEbB5STEOYECqm0biuj2AA2eCbS/iJOh+V7LwFaB8T
         qNei6NEYH/tiqq2PeJVfkBLdckbSzmYoXCng+L5iDNFtgjc0jQ7sULDjhEkHJYYdFlml
         f7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753876394; x=1754481194;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSn9CrZE9qB6hDrHRGXLwFtTDwyA0YiugOykJbTpTVY=;
        b=JBCE0uw9R/yqhU8nPh2Lvy7K84Gc3KNhqmaMk5BwApXD4zuTLbLU2c3Y6tF2J7ZRXY
         +DmNGwOeAKe09RU2Aq5DzFZ3eSMjKeFI8wdXEpntAlJvHhYqnHLMmhDAEvj+ovEE5jah
         4lexl9heOGmptf1ioewiQ/3IZgJjqTKr6ZKaQZ7wzbAlbg6MBNZuumiBEqa62kkZntmy
         iwR8Vp/o8gQm0INKLSGpT+RXsGWKPdpjU4qMobHNLeRg+zc9BbgO0LcOM5kQd/e+vDHd
         daBBx73sSDv5nf+qlyZKddseoRyUMFp8bR0hd55KJPv2BpImjLBoASGyIVSuI3V7aY+R
         FHrA==
X-Forwarded-Encrypted: i=1; AJvYcCW72dLbKhY5EsYrfhxKGZyLwhH9988MiQ8f6iYW0k2gcN8Q3Pnm3Q1/b1XTtbPZs3vHAv8JHE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWIuGff0jPpQwv5qrk6qVUPU9tahtGFwwMcYApNmGTctlnMst
	HGwVp1Uerepdi5bFoLMA5h6lNS5VIGv/qBDjjqPP/Uc+c62O77InvzGMFSIToDoiKwFSPz36dNR
	Og7xi0UgK5RqKYg==
X-Google-Smtp-Source: AGHT+IEJaj+Z1pgpktar/UYEDrChghCEcsx9mVGhvi04vuPxsnrcyC9Mj1EfMqxjRyyBgSskqd8PFD/fRzHg+w==
X-Received: from qkgl18.prod.google.com ([2002:ae9:f012:0:b0:7e3:2d1d:1b6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:ac14:b0:7e6:6ea5:aae2 with SMTP id af79cd13be357-7e66ef80aa6mr345711285a.11.1753876394644;
 Wed, 30 Jul 2025 04:53:14 -0700 (PDT)
Date: Wed, 30 Jul 2025 11:53:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730115313.3356036-1-edumazet@google.com>
Subject: [PATCH net] selftests: avoid using ifconfig
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Dong Chenchen <dongchenchen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"

ifconfig is deprecated and not always present, use ip command instead.

Fixes: e0f3b3e5c77a ("selftests: Add test cases for vlan_filter modification during runtime")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Dong Chenchen <dongchenchen2@huawei.com>
---
 tools/testing/selftests/net/vlan_hw_filter.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/vlan_hw_filter.sh b/tools/testing/selftests/net/vlan_hw_filter.sh
index 0fb56baf28e4a477ea68af1d8461f0ee82ca528d..e195d5cab6f75aa069b3952e850e73272b774a28 100755
--- a/tools/testing/selftests/net/vlan_hw_filter.sh
+++ b/tools/testing/selftests/net/vlan_hw_filter.sh
@@ -55,10 +55,10 @@ test_vlan0_del_crash_01() {
 	ip netns exec ${NETNS} ip link add bond0 type bond mode 0
 	ip netns exec ${NETNS} ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
 	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter off
-	ip netns exec ${NETNS} ifconfig bond0 up
+	ip netns exec ${NETNS} ip link set dev bond0 up
 	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter on
-	ip netns exec ${NETNS} ifconfig bond0 down
-	ip netns exec ${NETNS} ifconfig bond0 up
+	ip netns exec ${NETNS} ip link set dev bond0 down
+	ip netns exec ${NETNS} ip link set dev bond0 up
 	ip netns exec ${NETNS} ip link del vlan0 || fail "Please check vlan HW filter function"
 	cleanup
 }
@@ -68,11 +68,11 @@ test_vlan0_del_crash_02() {
 	setup
 	ip netns exec ${NETNS} ip link add bond0 type bond mode 0
 	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter off
-	ip netns exec ${NETNS} ifconfig bond0 up
+	ip netns exec ${NETNS} ip link set dev bond0 up
 	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter on
 	ip netns exec ${NETNS} ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
-	ip netns exec ${NETNS} ifconfig bond0 down
-	ip netns exec ${NETNS} ifconfig bond0 up
+	ip netns exec ${NETNS} ip link set dev bond0 down
+	ip netns exec ${NETNS} ip link set dev bond0 up
 	ip netns exec ${NETNS} ip link del vlan0 || fail "Please check vlan HW filter function"
 	cleanup
 }
@@ -84,9 +84,9 @@ test_vlan0_del_crash_03() {
 	ip netns exec ${NETNS} ip link add bond0 type bond mode 0
 	ip netns exec ${NETNS} ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
 	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter off
-	ip netns exec ${NETNS} ifconfig bond0 up
+	ip netns exec ${NETNS} ip link set dev bond0 up
 	ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter on
-	ip netns exec ${NETNS} ifconfig bond0 down
+	ip netns exec ${NETNS} ip link set dev bond0 down
 	ip netns exec ${NETNS} ip link del vlan0 || fail "Please check vlan HW filter function"
 	cleanup
 }
-- 
2.50.1.552.g942d659e1b-goog


