Return-Path: <netdev+bounces-68279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E78465F0
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 03:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8201C24B8B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 02:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA35A8839;
	Fri,  2 Feb 2024 02:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoJsY9u+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819FC2CF
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841492; cv=none; b=oFs8EpGKWyoVlVrlAzao2GXNORqZRo7+czuoj211s5aZEJpgoy9z1lq3RdpvD4nwXl7mfptdN6ArWpP+XLZTxs67o9Oh9sdc83zrkbpPH+h6Gh9CNzLq8gCihfwskB4tD+HZtz/DUNCseDFpe2IU5jFcERJ/6EFAfrwtKPZzpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841492; c=relaxed/simple;
	bh=9sCZCUTM9/Bv/osCyDQdlDwrCLiHF/EY3ax+mpZSXpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zqh7aSHwWs9p5L6aPlTQuQzmhKiXURsR9ldiAYGYgfIrHsYeEtuLql7+tIxM7imU78qG9ClTohtPsLtS46ZMh0zHrGAwMQzI/IlF6eUTB5P15/UJM1q+V2bOrCME7hh4E9WCDs4OKeSSSuWPn0uW0XoSqEfr193vwHbaJAvzwGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoJsY9u+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d94323d547so13731665ad.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 18:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706841490; x=1707446290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0292U331PRMk/JKM5bmBjV7z2aP5Wa2jlTcLtcJEHno=;
        b=SoJsY9u+sW9AxEKwmgLEyhNdYPAQV9xPCDqTvUtE7NuYBO767tU2IewMNxPV+BIbq9
         /2qR4Bufi0k0bwQAlcvDH22+4LYVEDU7ffOTtt9MPNocLD6fTvfY7ltUwBA1jZiuU4pA
         j91oCQqPolKXH697stgBM9HNmAlBXZe9eJCtShZayT00+mQ8JFR0EmLIiDucR1P7tlfr
         4ZNDJry0KmVgmOazY6JSqn8GEO44Obys3UDP7VlYB8/iwHFRYZsgLLyc1UqzgZGrlNty
         Qhx/0sCnTuplPeEE6O6XGE6yi8ewf/mTF8FBF0lahVeiVavCqcDiSqLixAwfLRxzkROz
         77aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706841490; x=1707446290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0292U331PRMk/JKM5bmBjV7z2aP5Wa2jlTcLtcJEHno=;
        b=WKvhWB/nJfnNG8jfOQTYDVo2X1/Nnh9y/eQwWv5cF/+jBoHQtsoF4Xv47h/KHFlb3w
         7j48m11Xi7MlsPseNuXqzPcQzWPbCMsLm2WTnEvvRxl9pu5zOsJrYBw8MM/8j5s+CKpu
         lVPEKgV1LTf3A5pQu8FkYc9AqlWJMFs5KFtaZNNSqZb0fO/GZ0dMx3VCoqRGk23PvY2W
         tT7mrd0tgQT7s5Lw3qgvS2NUxdWCI8eiVUt09l3OjfWjzO/JXwGkWwLHkvyB8gmQe8BF
         D9/r3jAgg3/fCJ3Hr3CZGHGhzwi2M4O7WVIXc2m38tyYVJUHYqvl5YMtWvTwMCisuyt6
         XdPg==
X-Gm-Message-State: AOJu0YyGrOIlAQyZIGxv2OygtWGFEq5eZuJXd6ovVyf5QafdvRs4uLHM
	X4ga5gtq1bWMzczdawcD1oJ4sa1bPRE8d8JDiGs7SrXjHHHdtoJGS53Cz/New1AQeIho
X-Google-Smtp-Source: AGHT+IFJaPPv+zV8irfAAXJzsiqz/qn3WEddHTNgCe97pZzkHtiGUGQthDgX1QPYO3o/s5dTtyg/ag==
X-Received: by 2002:a17:902:f545:b0:1d9:232d:4c1c with SMTP id h5-20020a170902f54500b001d9232d4c1cmr1081597plf.52.1706841490217;
        Thu, 01 Feb 2024 18:38:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXoO0RpiBdZ35WtlW4lxLcC9+yhNGkuDYf4z2BMDt4KQ8Ls5Qd5QKSTQ3S8ZLpu9hAD0TJe+8+IRSg2an/KqMQ6Cymu24NKQDyLQAtRB8uT6B6T6VFClyD34+L0WIMbXgODCEMRd3MlsdxSEJO+SHUPl0ltCFXwdCYPcba54t+EnIJDmeeJLos3bl6nkn4BH5nqjbDJeSnrVk/cjTw4EZ7p9Xz2cjCKc9n7kmPfTKJ/w+x0xnbupOTKUaT7PcdxrbHYxg==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ji19-20020a170903325300b001d944b3c5f1sm493256plb.178.2024.02.01.18.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 18:38:09 -0800 (PST)
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
Subject: [PATCHv3 net-next 2/4] selftests: bonding: use tc filter to check if LACP was sent
Date: Fri,  2 Feb 2024 10:37:52 +0800
Message-ID: <20240202023754.932930-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202023754.932930-1-liuhangbin@gmail.com>
References: <20240202023754.932930-1-liuhangbin@gmail.com>
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


