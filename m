Return-Path: <netdev+bounces-242943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 611FDC96AA2
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED5643444CD
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E9306D23;
	Mon,  1 Dec 2025 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFjvC3xT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADADC305972
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584937; cv=none; b=BaPUFf5dOuDOwQEiEXX2ahbpqH2QDfYQKC1QqLQNjiJcvlR9NSwTh1EiunIlXAxg9hsi4dhnlLOAf+LLKM42oCQxxLEWAecfilY3xOkjy2xEIQq0EiurDHsypCjwicxxTK7hW8ztcl/plITjB9r+xJ+Fnvadsg7flmOxe6aRQao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584937; c=relaxed/simple;
	bh=p8nrLd8JgHXvBOx3nRAE8e12DQJPDzMeaIvncxSjwDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F88Gtyyk83x4nAdAzyAJyBtVMILE7YdE6T6edCRSqEqcnNnTNhdZ1fjQFNq5d/iogtmzEl0cpSYsE2++N5lMIjyqleIiU3EMqtrexjrHulQbOcxmwvY/ZtVD9dZ3EymZAQRDT+kgWCMFaSVhn6pnVd7bayJhuVUMh1oZKCrpSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFjvC3xT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b736ffc531fso632681166b.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 02:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764584933; x=1765189733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygDjwJpJeLSApr9Yk+KRSHapU8CeVBWTNC852WoTWfU=;
        b=VFjvC3xTsWBsSA3KGtfWnloKFemE07SRzAyOjU8np52KCeAkkWa2PbqaiSJz1BrrEH
         +VO9EmVORcXr+VPb1jKlX4yIJH29fNyb54aTvDXf+SWN5KYZGaGPfkQVqEUu9WhBfkrX
         chHDBgx1MWjYQ6tqjZIhMuME6/y0YKM4Zkbl+XP9liali0AuStphCEVSSynfItZ9H0aV
         qTSSm6HGMzn1KYhN1CYGsuENe8gNI9qrG1TBYMPaVkmp/A0LFQ2uQUNS7UPi6WUFV6Q9
         cnqEKaVkvhyPyLznv1NypGT3LoP6EGzK86oqxpQNLFjK4B1yaRtsXyTr0dVj48rfAJVb
         kXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764584933; x=1765189733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygDjwJpJeLSApr9Yk+KRSHapU8CeVBWTNC852WoTWfU=;
        b=EwzOMWWuTA+Hxtjo1CSAA7K2nS9AVAv5fOJzkUFVjSRQwJo3Qk85gKxY9Vdi6ba4cB
         nMYzwJ9rDGrloEDd4EwY7bdvexWnY5SN9ubp85JP/AWSK02IuLU18gxaIGJd7qotvvwS
         kuZ3Ceer6ouEgbSx0mTI2dcx3TksxTk5pSvRMu6QXQqdOen4T5SD3j9W9VJmnIKj/Jvl
         HEhMFBEk0WNkV0lbdwlzIiwZ0UEPRaFoOflLw6a1cnVZ/dcj6DsSzF+7Cu/yvmCuwoAt
         0PXYBA0CRh1A/CVMO9HNvgV1q029II+ejcWYdcTI9t+0rxSYmDSDiUvApwkrzAHIxeEk
         s6kg==
X-Forwarded-Encrypted: i=1; AJvYcCXbMH5HNAZD/Z4zOL2bQ0RCOs3vLkmibbnPc1HPcly7lBF1W8w41iPKgAjjD4gsn0BM/wEJtLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfbX+fU8lCpJQh954lYw8Yb1TsrIno1pBLiSSibJ7VwijUk5i
	92JAiA+Ckog/V3EtggMmPd5DpN0lMPnmq2H+aYtxwnsKQH1AxviSxsHy
X-Gm-Gg: ASbGncso35z4Hv1/bKrCOlxEROHhxVKjGMwBMa06Dp2RjX1F/p/IdbG3jaOtWuhcRjy
	QX4x0MKVelS9LVTBks8uR/S3wyjhDwZLGCf5HxOP9mq7CbBxih9O9I0D6G6+lgOJdtp2R6rvlZv
	7V/xbFT3x0mmzWn0lH5uL49J0WGmFjkakqY/DosVYgLn2jnGAH6h0yBufgi43aSSDqXdhtcDC7l
	HxYLpr/BErGxjFSf6v3tY/Ka06KfoY/FyYxYu5fVahU/t/4vnIyV1pcQZu+sTFW86abftw+oFEe
	5ItppS4/KzqoLiCIA1n2JECn1od8k1WHAtqhAuwAMe7jsOAodk5Iu4A+mRJ/2MMkNH0anPg4CQ1
	WbtZkbKj91xVWxavvh/9XFtjJUkFgrJ8T4/8ipSVJ6OqMqNMm7IhxBfc79KtMpyhWRwwcKxOnxr
	ZCvNyZplPE0iYMHHRvWXubvLR6KjJFMsnMl2omNF0/DbI94GtgeluaWIRX3nTwO6PXVOM=
X-Google-Smtp-Source: AGHT+IEeOymRIkFQOr4JB61bu2rSDxpP6cAksOESLtPWvBHBz4B7/Sh7AubPoUZ4gTkeiXgXOkHVKA==
X-Received: by 2002:a17:907:7245:b0:b76:339d:63ed with SMTP id a640c23a62f3a-b767183c00emr3758956666b.52.1764584932679;
        Mon, 01 Dec 2025 02:28:52 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162d26sm1190495766b.3.2025.12.01.02.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:28:52 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC/RFT net-next v2 5/5] selftests: no_forwarding: test VLAN uppers on VLAN-unaware bridged ports
Date: Mon,  1 Dec 2025 11:28:17 +0100
Message-ID: <20251201102817.301552-6-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201102817.301552-1-jonas.gorski@gmail.com>
References: <20251201102817.301552-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A VLAN upper on a bridged port consumes the VLAN on this port and
inhibits forwarding of it.

Add a test that for VLAN-unaware bridges a single VLAN upper prevents
forwarding of that VLAN from that port. This is asymmetric "blocking",
as other ports' traffic can still be forwarded to this port. This is not
tested, as this is a no-forward test, not a forward test.

Since we are testing VLAN uppers, skip checking untagged traffic in
those cases.

Disallowing VLAN uppers on bridge ports is a valid choice for switchdev
drivers, so test if we can create them first and skip the tests if not.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* new patch

 .../selftests/net/forwarding/no_forwarding.sh | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
index c8adf04e1328..d223b5b79a4f 100755
--- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
+++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="standalone two_bridges one_bridge_two_pvids bridge_aware_vlan_uppers"
+ALL_TESTS="standalone two_bridges one_bridge_two_pvids bridge_unaware_vlan_upper bridge_aware_vlan_uppers"
 NUM_NETIFS=4
 
 source lib.sh
@@ -226,6 +226,24 @@ one_bridge_two_pvids()
 	ip link del br0
 }
 
+bridge_unaware_vlan_upper()
+{
+	ip link add br0 type bridge && ip link set br0 up
+	ip link set $swp1 master br0
+	ip link set $swp2 master br0
+
+	if ! ip link add name $swp1.10 link $swp1 type vlan id 10 2>/dev/null; then
+		ip link del br0
+		echo "SKIP: bridge does not allow vlan uppers on bridge ports"
+		exit "$ksft_skip"
+	fi
+	vlan_destroy $swp1 10
+
+	run_test "Switch ports in VLAN-unaware bridge with VLAN upper" 1
+
+	ip link del br0
+}
+
 bridge_aware_vlan_uppers()
 {
 	ip link add br0 type bridge vlan_filtering 1 vlan_default_pvid 0
-- 
2.43.0


