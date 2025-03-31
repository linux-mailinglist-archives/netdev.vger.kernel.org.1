Return-Path: <netdev+bounces-178344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC59A76AD7
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496AD3B7C6D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF0A21CC68;
	Mon, 31 Mar 2025 15:06:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DA21CA0F
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433580; cv=none; b=cVHdlhX3G7XJ+w01NbQThPK1gmtpdbZ1cjfym7pisisKtUDfwEcVPs3v+BAibN18Tr6UMgLe+X/gSQ/XhmfFO3a2W5cOk5bqJDIouwhdXO+UubfsqcwriXccqQ4wM3xhfqu6Qy8na6NyV9zSCBj//65Jm5n3ddaCOKmwQdzq5LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433580; c=relaxed/simple;
	bh=X7KmEadZjppxjeK02+ADtaxBZWNPB0A0AyWhTDqlsbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOKJQ6kTAZyxPOBU+su4gEhGOJ5MvrsoARI+tKEwzwMuQLas/jBEyAbq5lgdX/Z7fzulQCq9YzOwUqEEgy5wAxS18kAQSVQjoyw22k5qE2eOcrTFg7LZzOrY5UeO0L/4Gin6B9ZYdpLx/D2K4KhkcHvK/usWrsL/yyMRHlg2bWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240b4de12bso61171045ad.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433577; x=1744038377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcYRnerQ6JYJ7ayFAv8/Jf2/Ey5llrN6cVGamxlnHzM=;
        b=AkHORvAjsXFDM/3LXfu0JH/8nVu7BTP93qk3wx3s7mVm+WpWi2GvC5t4Wcyb2VKNxQ
         f5q8e7g/1fRkbEg2ujeVmx44z1RYhphyK5xagSfnux3xwk85ICyQKXI5JA3+ctqehcWI
         W09pu8Fn0dr4yS6wqgH0/5Uyc+YLoeBcVnKuGFoEZ+K7KfCNWUVznj8VDghXlqKKmu0Y
         3A2/CW3Jp38qbW9uyVm0HRG0CjxjoDmWRbeWYfMbS+bekl3i/GlbtgoRLZMHeAv6CWlO
         24JHkgiGUxkVmPWilcMuTHekiYdekBpJhtrd9Itz8YKQatNJ9CWtfJcfe18U8vhXCI0K
         B2dA==
X-Gm-Message-State: AOJu0Yzj5LOiajwoLvK8IRM3rKDr1bEjF+hd7Gro81xiZ4aIRT5Nn0OY
	6AQfLnaTRQZy5ISnBZQjWpii7yC0kwlYp35HtCK4AutucHjk1GUCs2xp
X-Gm-Gg: ASbGncuEwFAp+75fFIdQcR0zQ4FBNlTZtTRprBVKV/QsW6DJ35CXhKtylWhyjS9Jzf4
	9e7U2sgz7M9095Iej+bD+aXEpmHQYzvH6PoAkfdMmE+s/XQLLgDtdVjAHREgwfvMczRu6WUOBZx
	tWLa0F6xLU9fOEVKmcSNn9xhsTqcWVKCPLOEhF4vHTSXPkPb+4jJ5Xc+cXm7267TUdHwaBW2nSC
	GHmCHf3z7PkC3BKAyDqUFa9SWcGOE7QW9R7+PYudv+Ywt0xcygsAylfuaAWkPGJuC6MmKs5qAC6
	mPxobm1xpPuAr17kdOqJQlOVvnPYDQyoWUsYyUO0nRg8
X-Google-Smtp-Source: AGHT+IGjOG0q40LY5lJlDLN0mtQjJpCsahZunrT/R0XcrGTHk0OiUZfqamBx8dNIsGOKRFRPl92APg==
X-Received: by 2002:a05:6a00:2e18:b0:736:a973:748 with SMTP id d2e1a72fcca58-739804484admr14028130b3a.22.1743433576792;
        Mon, 31 Mar 2025 08:06:16 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af93b69f577sm6475734a12.19.2025.03.31.08.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:06:16 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v4 08/11] selftests: net: use netdevsim in netns test
Date: Mon, 31 Mar 2025 08:06:00 -0700
Message-ID: <20250331150603.1906635-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331150603.1906635-1-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
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


