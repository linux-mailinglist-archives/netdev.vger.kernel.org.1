Return-Path: <netdev+bounces-178205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4548CA7578B
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588283AA099
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944C51DFDA5;
	Sat, 29 Mar 2025 18:57:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA71DF985
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743274640; cv=none; b=BhHiJ5uaBz1UvV/ejH1EN0oPlbmE8BO8XOgk/HUkDppuDVNb+qXZX+cLc1a4CoT2lMAXSd33YtbG50NRtUvRfeZJ7elfBlEcfglcYCMS6JmJPy9l2bdpltyniY3OReNRyUv7SgHP3LuszsTmMvLcY/ue8zAw6tSsbrXQRlVM7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743274640; c=relaxed/simple;
	bh=X7KmEadZjppxjeK02+ADtaxBZWNPB0A0AyWhTDqlsbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpdeAdbHKt0w/G9gSDhItH6X3Laffq61/yiFlvIrt9qtIHShYJFB0jDUwqP4DZXUDGcbGPMibU2ToSNp/YUWOznAcKM+foxrq8zbK8Nm1HZ4nWSLBn+xZ9wq6D0xBFUQ0aYLRaeII8mkau+Soh2Bck66wljV7mBxHbMyJDZA8ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223fd89d036so73132525ad.1
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 11:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743274638; x=1743879438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcYRnerQ6JYJ7ayFAv8/Jf2/Ey5llrN6cVGamxlnHzM=;
        b=qJaAhiEXodChPCtjk6ssta3qsUXRZyIXXwkuRZfLqRXbJyxv8gMRnj4KWTzo6Fyfr8
         ui4/6pHBq5Z97MIMVhsE18j4767In5csi9b5tv5oD7Q6FUQWwV20jAkdROoHC9yhVD/6
         iqJ5ZqBBWj6xdSkU1RjDgyjqiPlfzYB7I+k9017mOK2ZhOfVy7QoBeI9fij653G6U0O+
         qTWmpwOh0FJZPocBMFmomkBbc0L3nHmfCZyPcdJ6D2w0IFKgg7nKVSLWdl3AyKODiO1P
         gS5c0jpiNiRwEZjFPrPvUbXCcYv0Re82TABCxmIfNUvjKrzgfwYHuyAM430AAghqW5Bq
         5rbg==
X-Gm-Message-State: AOJu0YxsIxKA3QPqhCiXydHvxeJLC9mtsiBKkZ4h4znIHOiBChTvGsd7
	LFEV/6wTTWQ7CL7WpmVEINGf7o4S+dTOHD8A53PDZjfln4w7gv9w/aJ2FAA=
X-Gm-Gg: ASbGncvEfZeye1d2IzzjpYR8WS8kfoitRkw0ZW9VEDZ+uCD6oyjLrcgNX9agxp46+3t
	RlOPW9eK70U0oalCtPtVHqWSII960zJy3tYVZv5Jb/w7TgNoXbBLhyZgBoZ47rD3smTBzKaV/zL
	5+TAwqZFe2pNz9GoK7yjIRzXssLwmU9lCNcBCzdUEs9wB8r4dsDyGIyXTA6omyXNV6Ka0y7reuJ
	mrWdVR9rjl5+K4rO6klezxO5DkQisEOwufGeQWGj5J+D2BvlW7qIx0QDXkUXmk/NcQH9GbMgjxz
	puXceoSlGqqj19hckw7xd5yY5d/V1N4zn8nxkfUIqjPE
X-Google-Smtp-Source: AGHT+IECg3yi9o4tYm5VuXaL/enumDHimBuH65yGMvCOEfTZa9/9fiKhcZpJpKZRCIJuHXEaJ6Mzmg==
X-Received: by 2002:a17:903:19ed:b0:224:3db:a296 with SMTP id d9443c01a7336-2292f946dd7mr59887465ad.2.1743274637711;
        Sat, 29 Mar 2025 11:57:17 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1ce127sm39648225ad.108.2025.03.29.11.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 11:57:17 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v3 08/11] selftests: net: use netdevsim in netns test
Date: Sat, 29 Mar 2025 11:57:01 -0700
Message-ID: <20250329185704.676589-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250329185704.676589-1-sdf@fomichev.me>
References: <20250329185704.676589-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netdevsim has extra register_netdevice_notifier_dev_net notifiers,
use netdevim instead of dummy device to test them out.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/lib.sh        | 25 +++++++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh | 13 ++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 975be4fdbcdb..701905eeff66 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -222,6 +222,31 @@ setup_ns()
 	NS_LIST+=("${ns_list[@]}")
 }
 
+# Create netdevsim with given id and net namespace.
+create_netdevsim() {
+    local id="$1"
+    local ns="$2"
+
+    modprobe netdevsim &> /dev/null
+    udevadm settle
+
+    echo "$id 1" | ip netns exec $ns tee /sys/bus/netdevsim/new_device >/dev/null
+    local dev=$(ip netns exec $ns ls /sys/bus/netdevsim/devices/netdevsim$id/net)
+    ip -netns $ns link set dev $dev name nsim$id
+    ip -netns $ns link set dev nsim$id up
+
+    echo nsim$id
+}
+
+# Remove netdevsim with given id.
+cleanup_netdevsim() {
+    local id="$1"
+
+    if [ -d "/sys/bus/netdevsim/devices/netdevsim$id/net" ]; then
+        echo "$id" > /sys/bus/netdevsim/del_device
+    fi
+}
+
 tc_rule_stats_get()
 {
 	local dev=$1; shift
diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/selftests/net/netns-name.sh
index 0be1905d1f2f..38871bdef67f 100755
--- a/tools/testing/selftests/net/netns-name.sh
+++ b/tools/testing/selftests/net/netns-name.sh
@@ -7,10 +7,12 @@ set -o pipefail
 DEV=dummy-dev0
 DEV2=dummy-dev1
 ALT_NAME=some-alt-name
+NSIM_ADDR=2025
 
 RET_CODE=0
 
 cleanup() {
+    cleanup_netdevsim $NSIM_ADDR
     cleanup_ns $NS $test_ns
 }
 
@@ -25,12 +27,15 @@ setup_ns NS test_ns
 
 #
 # Test basic move without a rename
+# Use netdevsim because it has extra asserts for notifiers.
 #
-ip -netns $NS link add name $DEV type dummy || fail
-ip -netns $NS link set dev $DEV netns $test_ns ||
+
+nsim=$(create_netdevsim $NSIM_ADDR $NS)
+ip -netns $NS link set dev $nsim netns $test_ns ||
     fail "Can't perform a netns move"
-ip -netns $test_ns link show dev $DEV >> /dev/null || fail "Device not found after move"
-ip -netns $test_ns link del $DEV || fail
+ip -netns $test_ns link show dev $nsim >> /dev/null ||
+    fail "Device not found after move"
+cleanup_netdevsim $NSIM_ADDR
 
 #
 # Test move with a conflict
-- 
2.48.1


