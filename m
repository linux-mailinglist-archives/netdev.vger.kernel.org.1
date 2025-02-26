Return-Path: <netdev+bounces-169977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B28FDA46B06
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E4C16EB17
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A22023E229;
	Wed, 26 Feb 2025 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0x8LXeVx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F617239597
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598115; cv=none; b=H/T+VsqZP8S4Kpz1RcXJxMcRFhrDIMCCNerAcPfXHGu5UKVt0t1tZgS3V4D6AyTYjPviFVYWTCm4HjSCghXF54bLv4gNBHlIYJPjVZZSKgHBi6lq9A36msyblaj/ov1Coe0exxXqGeS4MPLowHg2SZWqJVJe9z4tI3Q0LJe3zn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598115; c=relaxed/simple;
	bh=HluyNYKDPS3yqo3t8x10fv0NM56bpm3mbUtXPJiO218=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AHqZ1Zyuw63+hXIicDorgRSEOqVHVCZQ9x2TJDQzZvhHyOG4XpK102mdQQ7scGieXGSyPURJTajNK3nDwZQn82vvnDODP5F3jP+jHJaPbTgZ8fU9alWKWN/MNTv2svV4nub2tfEOYI88WAPVRHJ28i7Nox5SKy+VwBEpI8Fru90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0x8LXeVx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc2b258e82so387690a91.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740598113; x=1741202913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HpZI8xRryv6g8FTanFu9SU8gg3zdTSULVs1dwlkDW4=;
        b=0x8LXeVx0vs+elJ7t7Y/Rp2t0gCScn2ZaaBHf6i3y+rhb1JiJoVOWvIEOaug5ZT1A/
         VdR/XV91ahTNfDoKSHHVBO4lEtUQVh+UlonriwXX0RL15CzwDvzGlrMKPEpQy/z42rFh
         lAaiH2JfmSmVTdWU3Enslkw35aoPTw4LcitKg8j0+uaZEDNFseqPFdzNH7FdfmDUQKFZ
         e2cEhAMbz59SGmAPtV1xOC6OTF04ScXpq+aQM39WLfp+Iikw3RXZ7diovuneQrZCSQ4+
         /sZIC5Ggq9Yl11loQeWXvtQKWrVPU9KHbgfRDwkgvvLwHNoFvZOuy7PeY2uxw827omf4
         qjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598113; x=1741202913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HpZI8xRryv6g8FTanFu9SU8gg3zdTSULVs1dwlkDW4=;
        b=vuYQOBxFZXMZTZSb4ry4s9L22AC+0kxPEuMZbPK533MZq9sfQMolsccDxkzavX+4sM
         P/fnbKYVPJu1yTyk7yhHJjRT2EiAYEiAuEYleJFgTmlJOucZKp7HejS+KeTDCXxEelk8
         jP8W62PzPQrFHU2qBNNXmvRdT/xyAFk8TOxkZxWHp5DP0gMspPVEJgOGH8VrqClaxM/F
         uHKBB6qW36HHzCEHfIG05u0l5Qqqmi+tlrB5xAlDNc7f5TRBuOwdWwMKePN01UAT5KY1
         ZLlY4t+ojczOe3z0JrKhh58l6ghZg65q2tbxRLp0BOFJBKqnVMKFQ6ew0aDptXO04bt8
         E1UQ==
X-Gm-Message-State: AOJu0YyD9P4+fl9yVXdCL5dQohaVo07wKbHTsZU027nxjbT8VB6nfh/l
	lEz8KaV6uOVIpzQpXqIqMVq3s2aM5+JmddX2lr4KzAIKqITvx9B/eID/3dss/MoXPWebms5j+A/
	wpYjeGNSBn9CV7gwUQkHxSdxMT5lW5REeM6bi5lVbDWMMiXd0eBCPFa3lFUlTDddStN4uS4wUNx
	3FcxmLeCt2k5cfZPDA8BuCZXmjPA0cHsrXFfFDSg2FEA==
X-Google-Smtp-Source: AGHT+IFamKsEIxS3hTVFncv5CtlIUj3ZMQ5fhZAA0nlmJ8T2PdSmaceymwgTxy7txezIrqrqgE/2n3/ypIdyBw==
X-Received: from pjuj12.prod.google.com ([2002:a17:90a:d00c:b0:2fc:1356:bcc3])
 (user=krakauer job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5686:b0:2ee:ee5e:42fb with SMTP id 98e67ed59e1d1-2fe7e2f795fmr7199088a91.13.1740598112745;
 Wed, 26 Feb 2025 11:28:32 -0800 (PST)
Date: Wed, 26 Feb 2025 11:27:25 -0800
In-Reply-To: <20250226192725.621969-1-krakauer@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226192725.621969-1-krakauer@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226192725.621969-4-krakauer@google.com>
Subject: [PATCH v2 3/3] selftests/net: deflake GRO tests
From: Kevin Krakauer <krakauer@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Kevin Krakauer <krakauer@google.com>
Content-Type: text/plain; charset="UTF-8"

GRO tests are timing dependent and can easily flake. This is partially
mitigated in gro.sh by giving each subtest 3 chances to pass. However,
this still flakes on some machines. Reduce the flakiness by:

- Bumping retries to 6.
- Setting napi_defer_hard_irqs to 1 to reduce the chance that GRO is
  flushed prematurely. This also lets us reduce the gro_flush_timeout
  from 1ms to 100us.

Tested: Ran `gro.sh -t large` 1000 times. There were no failures with
this change. Ran inside strace to increase flakiness.

Signed-off-by: Kevin Krakauer <krakauer@google.com>
---
 tools/testing/selftests/net/gro.sh        | 4 ++--
 tools/testing/selftests/net/setup_veth.sh | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index aabd6e5480b8..9e3f186bc2a1 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -18,10 +18,10 @@ run_test() {
   "--smac" "${CLIENT_MAC}" "--test" "${test}" "--verbose" )
 
   setup_ns
-  # Each test is run 3 times to deflake, because given the receive timing,
+  # Each test is run 6 times to deflake, because given the receive timing,
   # not all packets that should coalesce will be considered in the same flow
   # on every try.
-  for tries in {1..3}; do
+  for tries in {1..6}; do
     # Actual test starts here
     ip netns exec $server_ns ./gro "${ARGS[@]}" "--rx" "--iface" "server" \
       1>>log.txt &
diff --git a/tools/testing/selftests/net/setup_veth.sh b/tools/testing/selftests/net/setup_veth.sh
index 1f78a87f6f37..eb3182066d12 100644
--- a/tools/testing/selftests/net/setup_veth.sh
+++ b/tools/testing/selftests/net/setup_veth.sh
@@ -11,7 +11,8 @@ setup_veth_ns() {
 	local -r ns_mac="$4"
 
 	[[ -e /var/run/netns/"${ns_name}" ]] || ip netns add "${ns_name}"
-	echo 1000000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
+	echo 100000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
+	echo 1 > "/sys/class/net/${ns_dev}/napi_defer_hard_irqs"
 	ip link set dev "${ns_dev}" netns "${ns_name}" mtu 65535
 	ip -netns "${ns_name}" link set dev "${ns_dev}" up
 
-- 
2.48.1.658.g4767266eb4-goog


