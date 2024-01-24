Return-Path: <netdev+bounces-65407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5166983A628
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B598B25891
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B6182BE;
	Wed, 24 Jan 2024 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQY9D0q2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C213182DD
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090310; cv=none; b=c26gVfLqHsZT/F0k+IKHcKB0TdD9vp1NxmOX4s/btNZkGyM0hWAtgiz3QlM0XVBA+RmX0uVESamJX9UzDX7M2OWkD9oyoqu9KH05G+f0gwKUSUEWBMJvNVrI3hhUMGW+PlVWrjUvvEBCBJsFvbq2jk7L+pFXmLtvRvgIl1Yr5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090310; c=relaxed/simple;
	bh=jhDLcoazW2E5MVGTqI/p46vi+gWkM54IlvHUKP8IXSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSw1rvmOFXddVFpfXLuJ+MZShMIHUXgVJ1pvWnCkghtmO0OqftFLr3lPsgO2L/RUGHgcUgKDKBG+DgubtuTw1Km6iYushO8XP4PhqkNDC5cGlau0MUBfujPbiFORU4+Du6hcXCT4sEHocKLs+jEes+aRD6PzxiBFRjr3buaSUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQY9D0q2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2903cd158f8so3027682a91.2
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 01:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706090308; x=1706695108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtz9SDGu51uPwXitkL16jBkXc5UEmIDif1hY3bKERas=;
        b=gQY9D0q2TMUs2GMeTdD96YbWX7wcVPeYoKaanM6R7tYXb/IH2a2fw50EMmDYNkhNO9
         /BI7aYJunpdj7dGKT5ZSETPtggctv7ari2fe2ntSSdxfElDIlDzv6FFG/1uNKLldXLW9
         tlu0f1kL4N81vS++vqoMW6zsj5J1DhQPTcE0vGTd96uGEB79p1NTBFIFerCII5Qn/PDX
         wkwYQ2xhCwUnu/+B9uZoweJXCEYlDPgpXAGSJHYKjlaEzSHlIN3JETUuwMTpYNJ310Oy
         JmLuoDkSNPj6VrLrAjq7w8Iuplz4RDCkvljFPp/d9QLu9cRtQf4d+A8Rag5JjfffY8H/
         Q9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706090308; x=1706695108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtz9SDGu51uPwXitkL16jBkXc5UEmIDif1hY3bKERas=;
        b=UIFU2hoch9x/KCYPKHuKDKI34QTAKweLyW80AGpidK3QnUhqweeuhs/hS4zbeS07/k
         2jcN8MUFPcBV1vp5ItThNiQs97oVJToTbqueNB6FFb8r2xl/KpQ5j+w834JDwJLchU2X
         9YpmGIFmt1ThKDQdGaruec1Canse4wKEd+2PsQyM2m+d2358V2YGvuf5DpOtzC1qKH3M
         Uo/XcTCdD8FnV39R/G1gOP6/bIh+jg76LfuKEHIG+cMLaVk6ilt8dQ9K7Quk4CeUubjB
         YJ+s4eKAr3B2gXZF6Jv3dyJYKhh0nDYwgVOC6EdQER8EkUTUwhs/CPCCazHlbce5vPb1
         /y5w==
X-Gm-Message-State: AOJu0YwQXoEAKUM/DdggW1Jwr6zlRUsd0kwi9fghge4BXLEfjc9Bt/h7
	Zh8k1LnPzapyAUlaANydjoJtVs8CO7CC9cIbzvXqtd8QWUimPLCS7BVI9Tn6kKJV9qUP
X-Google-Smtp-Source: AGHT+IEuJK5ITtISGs1PUxkm1ZfhsSpolLmcQA6R7+9cP28nN0QjcCvJ8M/a4/7ZmugbdUoKXZ5HDg==
X-Received: by 2002:a17:90a:714c:b0:28f:ee85:5c72 with SMTP id g12-20020a17090a714c00b0028fee855c72mr3725902pjs.23.1706090307671;
        Wed, 24 Jan 2024 01:58:27 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id so12-20020a17090b1f8c00b0028dfdfc9a8esm13055367pjb.37.2024.01.24.01.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:58:27 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 2/4] selftests: bonding: use tc filter to check if LACP was sent
Date: Wed, 24 Jan 2024 17:58:12 +0800
Message-ID: <20240124095814.1882509-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124095814.1882509-1-liuhangbin@gmail.com>
References: <20240124095814.1882509-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use tc filter to check if LACP was sent, which is accurate and save
more time.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../net/bonding/bond-break-lacpdu-tx.sh        | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
index 6358df5752f9..5087291d15ce 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
@@ -20,21 +20,22 @@
 #    +------+ +------+
 #
 # We use veths instead of physical interfaces
+REQUIRE_MZ=no
+NUM_NETIFS=0
+lib_dir=$(dirname "$0")
+source "$lib_dir"/net_forwarding_lib.sh
 
 set -e
-tmp=$(mktemp -q dump.XXXXXX)
 cleanup() {
 	ip link del fab-br0 >/dev/null 2>&1 || :
 	ip link del fbond  >/dev/null 2>&1 || :
 	ip link del veth1-bond  >/dev/null 2>&1 || :
 	ip link del veth2-bond  >/dev/null 2>&1 || :
 	modprobe -r bonding  >/dev/null 2>&1 || :
-	rm -f -- ${tmp}
 }
 
 trap cleanup 0 1 2
 cleanup
-sleep 1
 
 # create the bridge
 ip link add fab-br0 address 52:54:00:3B:7C:A6 mtu 1500 type bridge \
@@ -67,13 +68,12 @@ ip link set fab-br0 up
 ip link set fbond up
 ip addr add dev fab-br0 10.0.0.3
 
-tcpdump -n -i veth1-end -e ether proto 0x8809 >${tmp} 2>&1 &
-sleep 15
-pkill tcpdump >/dev/null 2>&1
 rc=0
-num=$(grep "packets captured" ${tmp} | awk '{print $1}')
-if test "$num" -gt 0; then
-	echo "PASS, captured ${num}"
+tc qdisc add dev veth1-end clsact
+tc filter add dev veth1-end ingress protocol 0x8809 pref 1 handle 101 flower skip_hw action pass
+if slowwait_for_counter 15 2 \
+	tc_rule_handle_stats_get "dev veth1-end ingress" 101 ".packets" "" &> /dev/null; then
+	echo "PASS, captured 2"
 else
 	echo "FAIL"
 	rc=1
-- 
2.43.0


