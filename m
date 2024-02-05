Return-Path: <netdev+bounces-69137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA0C849B58
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 14:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21094B28E68
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84B71CABD;
	Mon,  5 Feb 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xdkc1RCX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F371C683
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138068; cv=none; b=hOc8yPr1mzmS5IOciVDABFISjTSeBVG3X3FkFvXCUuo9QK4PX8M5azCBum1DpchyIwZn9YQjFs+JrvLTQaCKnfDpwCyb0IA9iGq3X3kdER/16ylSOuEcYfrZbBI/UP8dsnDUAIuEwS4UeFU2rbkNEgZ+7Uw1aQXmQoEUWAb1eQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138068; c=relaxed/simple;
	bh=9sCZCUTM9/Bv/osCyDQdlDwrCLiHF/EY3ax+mpZSXpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kpuro9ka+/4XTOUmMegzjfa7O4NLu1ijMI99pwStDYUUVz51hhEELhCB/RtUXzFMlCI99sahpuHjrYfYNUWV/mR1su6Zko23sZEkhE2C78JsE2pv8HYqbN3+oOvU2lHimbJIDSv1+bOz5ca4Ug6GBEbcNHijQQKudYrcFWWbjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xdkc1RCX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d51ba18e1bso39633515ad.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 05:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707138066; x=1707742866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0292U331PRMk/JKM5bmBjV7z2aP5Wa2jlTcLtcJEHno=;
        b=Xdkc1RCX3GKdAxGh3OgXLI0FarCIPqftzKNDjeKGaDLrXmmWjGeRR/g0O/6E1e5DXC
         LQF84uxdxpPIzMDeYGRc8ZHyNhyYxSGj7OdvTgKFZoGSW7chenyQ73OFP2UiZIkOmtCz
         hGkglNiKA2K7L4Y7jAZf7gr8j4n9Mmvc6Bio6LDinavL3XZ53NKKYLhmewuxyyf+kRHx
         ZHxZECFL+SIZQYm9PaX+426+gDnFz+wCn46DdsWH+q72D8gJiqSL7FO0ifPxYDuB2a8g
         aEnVm9oj5DBsuvy6MbEmLoy/eA+RbBIyzIaH3Xp+HFMKhsjtHR+pueDrTPFN5iI5+LHz
         PnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138066; x=1707742866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0292U331PRMk/JKM5bmBjV7z2aP5Wa2jlTcLtcJEHno=;
        b=N9WAoeF3BqxlvYBQzJnAFF9iHyAfWeaFW76b+kIhLV0Cpr4Jup04GUv/PXXSXkkvKd
         h2OQCfMotQNGBi89tG23R8rpdIKNETLXZ9qs7fTEHeir64rxHsn52TIF4Bbfh5tQZzZu
         aba/fGw5cLuwzgnYV7N5q5pWaszhREnOzXhni6Swv9T9XMP6E1Xvmv4zuVkuA+xldp5x
         mxH7Du+fBbSaGtaLOM+lKwMCBY7vcKc55IKW6guphKbO3GYbk50rm3nTDNZuJPRyTSVN
         eQ8oEUYrIRiNOzfOqYDpJEShHw41QjGbNDSIiXdCJDiK+bp29vKiNqS3zb+tKfO2Ekf3
         JC4w==
X-Gm-Message-State: AOJu0YyawgNLqjwn7qmthHVW8k/zOrkhsrvq4NvhCACtOHsAq8jhggvN
	RI25x07Lgnm/ZlTEWhRN1OaKPxLP5oDYGsdIRbct4pnBIgimC+MqTbZUF5HBbOD88Q==
X-Google-Smtp-Source: AGHT+IHfss23bNnQLsGjdQKo+zNLgfCMyUPheqf4XSG+s6U3LEX5XsYYwdI61PrpcNm71kkHJsayNw==
X-Received: by 2002:a17:903:124b:b0:1d9:14fb:d142 with SMTP id u11-20020a170903124b00b001d914fbd142mr13795602plh.32.1707138065674;
        Mon, 05 Feb 2024 05:01:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV6AIpq/8Ug/iHKPpKN5AxOVKr3FelNHKdOGu63FeG618VJgACzczkmLUa++YQa+2Na1sroWVY+lQf2olG2zfvR12yrauC9r7JWw1F9ytSo8TFHEGPkxl9AIH7ANTeL6+MnRSfjTmH6NsbkYMr8QhTHT1W7CTTfG/oxUbw/NsO9opFAdxanjwXZBM3mUfNwGWjinAUxyWVT/3Z9owQms1snembUGXVBnQSS9K7OI6iNy638o5cp/k1K6eZk6bsAYyR4kw==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b001d9351f63d4sm6252159plh.68.2024.02.05.05.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:01:05 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv5 net-next 2/4] selftests: bonding: use tc filter to check if LACP was sent
Date: Mon,  5 Feb 2024 21:00:46 +0800
Message-ID: <20240205130048.282087-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205130048.282087-1-liuhangbin@gmail.com>
References: <20240205130048.282087-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use tc filter to check if LACP was sent, which is accurate and save
more time.

No need to remove bonding module as some test env may buildin bonding.
And the bond link has been deleted.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../net/bonding/bond-break-lacpdu-tx.sh       | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
index 6358df5752f9..1ec7f59db7f4 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
@@ -20,21 +20,21 @@
 #    +------+ +------+
 #
 # We use veths instead of physical interfaces
+REQUIRE_MZ=no
+NUM_NETIFS=0
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 set -e
-tmp=$(mktemp -q dump.XXXXXX)
 cleanup() {
 	ip link del fab-br0 >/dev/null 2>&1 || :
 	ip link del fbond  >/dev/null 2>&1 || :
 	ip link del veth1-bond  >/dev/null 2>&1 || :
 	ip link del veth2-bond  >/dev/null 2>&1 || :
-	modprobe -r bonding  >/dev/null 2>&1 || :
-	rm -f -- ${tmp}
 }
 
 trap cleanup 0 1 2
 cleanup
-sleep 1
 
 # create the bridge
 ip link add fab-br0 address 52:54:00:3B:7C:A6 mtu 1500 type bridge \
@@ -67,13 +67,12 @@ ip link set fab-br0 up
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


