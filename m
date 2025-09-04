Return-Path: <netdev+bounces-219781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE0DB42F40
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 03:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCAC0540E98
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 01:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B1F1D416E;
	Thu,  4 Sep 2025 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zC5Gvj/n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D581922DD
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756950869; cv=none; b=RfqtHzg1iOSZTtGE6KPMRrojoZbr0eI4OGVmvUgAVv22Dr4IOkmHLMqnZNslAXT46/zfQw6CPXRde7nnHNx7obkGM4WAmVvQSFEuaCCY6RKoW6Od/nX7qt9NXy1opcKozHV6bWxB1qEDzw7BxU5QbU64Q3qP8k6mpAcW5ECoC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756950869; c=relaxed/simple;
	bh=XJ2w39arK3fRgybqNhjgZP1Tcx4gajUCbYzSmTWi86k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O3JA0nyakuywzGEVH1jxh4jZKNNdye8JbK3B8IzIobB8ukt04NxADKzLymKiKdxxYTrOLUwa7AV3NVFCxwVeoklqUvMRDd0edYdcSXuSZNdnl9Q1FBjkT8cH7Avx3xOgPiBv6PS82VuS9UCbE6/NOBsfQn4BDDKFy+ufqNQtYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zC5Gvj/n; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24b4aa90c20so6748355ad.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756950867; x=1757555667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IRx4kg27853Mr4e9hA+gLj9Dgi+6DG8uKC/JACslLYk=;
        b=zC5Gvj/nwgtQ9tsSmUjBkGPv6/i1UFpc/ZFuWHg8aMdhfApc10P2/CIK+1CnCGNAz2
         qRy2D9cUbT06m+8xgoICMuSVDiGNV+KaHnYFWLw8XhF6EHc6ZyPEm5VBjey7Kw6TLZrB
         b9qVCYTP6Nam5tCKvdprEBGeAv1JoarWKZ6GQiBi/gTYUAgwoR1oQKQcfxJiy1lRyl9i
         WAtceC8r6Pmv5blSX8C2mvMVVJJ6vKfekSFq0Uxg9I/+Ba/jE8WEY0m9mxaQo1tlh8Nr
         AjUq3Mt8FMfw1r+moCMdWBxpcVeCpPXUfqXQXDlajzg7+vAMQF+yTu0tPBZJN4cCHgjG
         yfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756950867; x=1757555667;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IRx4kg27853Mr4e9hA+gLj9Dgi+6DG8uKC/JACslLYk=;
        b=usbzaMm8q3yZOXUHglE6bSQ20s1RuUzZggu9WUCx/Gq0IeTbFS3prRUPhvblYQtUaC
         k/Xuz0CpYIf3qqOlEOYsXWmeRK6550Z6vUmnT7Ly9KBfVq3Ab9e7rUiv4V/hCjUGbHAl
         pRaH4CHx3+A1jbws2wzeyBHT7H19VxLzYdKcjb3LUBA33wqUkIIlx02nuIkkfjlGs7BY
         2977VKyDmCLWqhfSScBaA7Q8qP/Wv9tv6ahsaA1+cuTqDnTdH7HHKhS0wA4uDpM2lxRS
         yQbohgnfCymjIN1VRHZack9myzEuQXpGnq/QPNPmxWKISaUhQCL+/ePO6labYhdb3ok6
         HhLg==
X-Forwarded-Encrypted: i=1; AJvYcCUI7I5XxCigvG1vMAtuzw1pn5mgV5OkzfivaI6hy3+o3IX+Su6r+e5JsE2W1dQ/PBqjhyx+2Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHlt5sR49HP7kQIxxaqhaxByK2W5FTLgOGc6cdn/0CpVefHo9S
	Kp5n7L+6PowNRzucvAZEC3lX1ulb/YULKea2HLGoygAJCeV44BiaWreOn2kZ6RCZHuynlTjy4id
	F8aUIoOqf023xfeXxMLtRuA==
X-Google-Smtp-Source: AGHT+IHcFQSoXchOed2TjeTjT95yO5RWgQUSyQZlzYxtK4QqB68HJsKmykhfTUK/vL/mSNZkLle5C+DJss8Ua6wi
X-Received: from plrs20.prod.google.com ([2002:a17:902:b194:b0:234:659b:127c])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:19c6:b0:24c:c1b3:604 with SMTP id d9443c01a7336-24cc1b30801mr16136975ad.1.1756950867079;
 Wed, 03 Sep 2025 18:54:27 -0700 (PDT)
Date: Thu,  4 Sep 2025 01:54:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904015424.1228665-1-marcharvey@google.com>
Subject: [PATCH net-next v2] selftests: net: Add tests to verify team driver
 option set and get.
From: Marc Harvey <marcharvey@google.com>
To: jiri@resnulli.us, andrew+netdev@lunn.ch
Cc: edumazet@google.com, willemb@google.com, maheshb@google.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, kuba@kernel.org, 
	liuhangbin@gmail.com, Marc Harvey <marcharvey@google.com>
Content-Type: text/plain; charset="UTF-8"

There are currently no kernel tests that verify setting and getting
options of the team driver.

In the future, options may be added that implicitly change other
options, which will make it useful to have tests like these that show
nothing breaks. There will be a follow up patch to this that adds new
"rx_enabled" and "tx_enabled" options, which will implicitly affect the
"enabled" option value and vice versa.

The tests use teamnl to first set options to specific values and then
gets them to compare to the set values.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v2:
  - Fixed shellcheck failures.
  - Fixed test failing in vng by adding a config option to enable the
    team driver's active backup mode.
  - Link to v1: https://lore.kernel.org/netdev/20250902235504.4190036-1-marcharvey@google.com/

 .../selftests/drivers/net/team/Makefile       |   6 +-
 .../testing/selftests/drivers/net/team/config |   1 +
 .../selftests/drivers/net/team/options.sh     | 192 ++++++++++++++++++
 3 files changed, 197 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/team/options.sh

diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index eaf6938f100e..8b00b70ce67f 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -1,11 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for net selftests
 
-TEST_PROGS := dev_addr_lists.sh propagation.sh
+TEST_PROGS := dev_addr_lists.sh propagation.sh options.sh
 
 TEST_INCLUDES := \
 	../bonding/lag_lib.sh \
 	../../../net/forwarding/lib.sh \
-	../../../net/lib.sh
+	../../../net/lib.sh \
+	../../../net/in_netns.sh \
+	../../../net/lib/sh/defer.sh \
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/team/config b/tools/testing/selftests/drivers/net/team/config
index 636b3525b679..558e1d0cf565 100644
--- a/tools/testing/selftests/drivers/net/team/config
+++ b/tools/testing/selftests/drivers/net/team/config
@@ -3,4 +3,5 @@ CONFIG_IPV6=y
 CONFIG_MACVLAN=y
 CONFIG_NETDEVSIM=m
 CONFIG_NET_TEAM=y
+CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
 CONFIG_NET_TEAM_MODE_LOADBALANCE=y
diff --git a/tools/testing/selftests/drivers/net/team/options.sh b/tools/testing/selftests/drivers/net/team/options.sh
new file mode 100755
index 000000000000..82bf22aa3480
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/options.sh
@@ -0,0 +1,192 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# These tests verify basic set and get functionality of the team
+# driver options over netlink.
+
+# Run in private netns.
+test_dir="$(dirname "$0")"
+if [[ $# -eq 0 ]]; then
+        "${test_dir}"/../../../net/in_netns.sh "$0" __subprocess
+        exit $?
+fi
+
+ALL_TESTS="
+        team_test_options
+"
+
+source "${test_dir}/../../../net/lib.sh"
+
+TEAM_PORT="team0"
+MEMBER_PORT="dummy0"
+
+setup()
+{
+        ip link add name "${MEMBER_PORT}" type dummy
+        ip link add name "${TEAM_PORT}" type team
+}
+
+get_and_check_value()
+{
+        local option_name="$1"
+        local expected_value="$2"
+        local port_flag="$3"
+
+        local value_from_get
+
+        if ! value_from_get=$(teamnl "${TEAM_PORT}" getoption "${option_name}" \
+                        "${port_flag}"); then
+                echo "Could not get option '${option_name}'" >&2
+                return 1
+        fi
+
+        if [[ "${value_from_get}" != "${expected_value}" ]]; then
+                echo "Incorrect value for option '${option_name}'" >&2
+                echo "get (${value_from_get}) != set (${expected_value})" >&2
+                return 1
+        fi
+}
+
+set_and_check_get()
+{
+        local option_name="$1"
+        local option_value="$2"
+        local port_flag="$3"
+
+        local value_from_get
+
+        if ! teamnl "${TEAM_PORT}" setoption "${option_name}" "${option_value}" \
+                        "${port_flag}"; then
+                echo "'setoption ${option_name} ${option_value}' failed" >&2
+                return 1
+        fi
+
+        get_and_check_value "${option_name}" "${option_value}" "${port_flag}"
+        return $?
+}
+
+# Get a "port flag" to pass to the `teamnl` command.
+# E.g. $1="dummy0" -> "port=dummy0",
+#      $1=""       -> ""
+get_port_flag()
+{
+        local port_name="$1"
+
+        if [[ -n "${port_name}" ]]; then
+                echo "--port=${port_name}"
+        fi
+}
+
+attach_port_if_specified()
+{
+        local port_name="${1}"
+
+        if [[ -n "${port_name}" ]]; then
+                ip link set dev "${port_name}" master "${TEAM_PORT}"
+                return $?
+        fi
+}
+
+detach_port_if_specified()
+{
+        local port_name="${1}"
+
+        if [[ -n "${port_name}" ]]; then
+                ip link set dev "${port_name}" nomaster
+                return $?
+        fi
+}
+
+#######################################
+# Test that an option's get value matches its set value.
+# Globals:
+#   RET - Used by testing infra like `check_err`.
+#   EXIT_STATUS - Used by `log_test` to whole script exit value.
+# Arguments:
+#   option_name - The name of the option.
+#   value_1 - The first value to try setting.
+#   value_2 - The second value to try setting.
+#   port_name - The (optional) name of the attached port.
+#######################################
+team_test_option()
+{
+        local option_name="$1"
+        local value_1="$2"
+        local value_2="$3"
+        local possible_values="$2 $3 $2"
+        local port_name="$4"
+        local port_flag
+
+        RET=0
+
+        echo "Setting '${option_name}' to '${value_1}' and '${value_2}'"
+
+        attach_port_if_specified "${port_name}"
+        check_err $? "Couldn't attach ${port_name} to master"
+        port_flag=$(get_port_flag "${port_name}")
+
+        # Set and get both possible values.
+        for value in ${possible_values}; do
+                set_and_check_get "${option_name}" "${value}" "${port_flag}"
+                check_err $? "Failed to set '${option_name}' to '${value}'"
+        done
+
+        detach_port_if_specified "${port_name}"
+        check_err $? "Couldn't detach ${port_name} from its master"
+
+        log_test "Set + Get '${option_name}' test"
+}
+
+#######################################
+# Test that getting a non-existant option fails.
+# Globals:
+#   RET - Used by testing infra like `check_err`.
+#   EXIT_STATUS - Used by `log_test` to whole script exit value.
+# Arguments:
+#   option_name - The name of the option.
+#   port_name - The (optional) name of the attached port.
+#######################################
+team_test_get_option_fails()
+{
+        local option_name="$1"
+        local port_name="$2"
+        local port_flag
+
+        RET=0
+
+        attach_port_if_specified "${port_name}"
+        check_err $? "Couldn't attach ${port_name} to master"
+        port_flag=$(get_port_flag "${port_name}")
+
+        # Just confirm that getting the value fails.
+        teamnl "${TEAM_PORT}" getoption "${option_name}" "${port_flag}"
+        check_fail $? "Shouldn't be able to get option '${option_name}'"
+
+        detach_port_if_specified "${port_name}"
+
+        log_test "Get '${option_name}' fails"
+}
+
+team_test_options()
+{
+        # Wrong option name behavior.
+        team_test_get_option_fails fake_option1
+        team_test_get_option_fails fake_option2 "${MEMBER_PORT}"
+
+        # Correct set and get behavior.
+        team_test_option mode activebackup loadbalance
+        team_test_option notify_peers_count 0 5
+        team_test_option notify_peers_interval 0 5
+        team_test_option mcast_rejoin_count 0 5
+        team_test_option mcast_rejoin_interval 0 5
+        team_test_option enabled true false "${MEMBER_PORT}"
+        team_test_option user_linkup true false "${MEMBER_PORT}"
+        team_test_option user_linkup_enabled true false "${MEMBER_PORT}"
+        team_test_option priority 10 20 "${MEMBER_PORT}"
+        team_test_option queue_id 0 1 "${MEMBER_PORT}"
+}
+
+require_command teamnl
+setup
+tests_run
+exit "${EXIT_STATUS}"
-- 
2.51.0.338.gd7d06c2dae-goog


