Return-Path: <netdev+bounces-178657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AF4A78095
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D606418851E0
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2797420F06A;
	Tue,  1 Apr 2025 16:35:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C70820E70E
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525308; cv=none; b=KViqTCVCY+zEozXXy9z/aWgq7foVs/fgSxMpQr4E5+AeHDSV42qLEyoHmvRJSmgTVSWHxZAklVcHMZouUXhHMCT19XdQTG+k6J1NDqs+nBnTGBmohzmI7OPxAh+bLmxaAYvIxI0cd/2ARThE9rc2TAv/uwVmBoANrgIDjqZmBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525308; c=relaxed/simple;
	bh=d7JvG3+7EDCHito5Pw1XyustXPnDzUgGCpwAMdHun1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZimsA8kXmDsoJSW9nWrZsmvWtYbyZVy7f+ks4lWQ1bgZDlm9IoEi2V/cMI5cczTGMNQ+1apR/QHqRLQAAYC7UPvUE66ggo684YzRTOX+dFtkI1rZEBoT5USNQHPjtQzYY3lXlnsXILfLpHmVqKRHhn3PIr04tQZXBGfUAYlDIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223f4c06e9fso107469285ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 09:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525305; x=1744130105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiPqGUN65xqmstpHwHf6M/veERZEgyfwG65731/G/BY=;
        b=M+bKIzDC+YuGtvg3QuEhhu9y9T8h44ArfOPMTDsX8AznsjnNBOjv7qdjgvAklMH3dR
         Cw5ZA6E4bTjfxA1W6KLo1gu+MiC54peCtiV3pIf15buMNpg0IM0l1OXYCQJOE1lxBasc
         p8+tklbdKuSEgLgh4b56wH+UV2nAlvZsOrZyEzrugcaRMj06CBElyU/1mCMsNmAUV1eY
         YpTQEVlqE3LSUXdLEL5gNvzGt2wJGxrg9/8jcuRjKNRSNg1qR6o3GMbWj8emwdrIeghc
         f9go1R2bVbfEf8eFGhmE08Boa4QBF9m/fWJim0N6SGFFcfXP1zmV41LKeTcG3yVFz16W
         VYTQ==
X-Gm-Message-State: AOJu0Yx0I7mV12oQGEVRxnaddFi1jSWPsWtLREWQigRGC5GmLMAOpVvn
	wizrO0R4WnOr6tW4cI2Me9KiUNS3B96y2hwH8Kp4CjrsdcJimPb19cBeII753Q==
X-Gm-Gg: ASbGncsf9Kn9pp4dflCEaUQzoEDwsA2FHUH9jNR/kC9K7gdPjrThqiZcXyy/37SlqEh
	WQuWpYcDECwHWTi0apiCLQ0NGMQKyUk6TtryL+bGFCDJdGF26HqJx5Fdz03k+g5IUJ1YR1eku/V
	fwwIUG8GYbjfUCv8zXycc7cEHlkDLlSiyw7JYTxqww1HplOM4xfA7D08XjcSG0xfd0rUtpex+7k
	N57asodUc1cg4tqLYc7hGceenyRQP9saD2EVfhlR5o5ROm+HlirgnXw+o/d+ljbSWxfEFRv9Rti
	R9hJN6mrnp4sD+fkwvnkfNiKMHMmZ01iQE8S6aJ62gUN
X-Google-Smtp-Source: AGHT+IFM3+SrbXG6XEfuI1EjqDuyDuQPpR8R+/0lKIAqsZuUi++maDKuKcOXzI1oQUUqod4Td6+Aug==
X-Received: by 2002:a17:903:2c8:b0:224:3610:bef4 with SMTP id d9443c01a7336-2296834c024mr8384025ad.25.1743525305490;
        Tue, 01 Apr 2025 09:35:05 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1f9240sm90412855ad.236.2025.04.01.09.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:35:05 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v5 08/11] selftests: net: use netdevsim in netns test
Date: Tue,  1 Apr 2025 09:34:49 -0700
Message-ID: <20250401163452.622454-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401163452.622454-1-sdf@fomichev.me>
References: <20250401163452.622454-1-sdf@fomichev.me>
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
2.49.0


