Return-Path: <netdev+bounces-205754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 692B2B00068
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574DB1C875D0
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6192E54DC;
	Thu, 10 Jul 2025 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pcagf/6t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4A2E54B8
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146330; cv=none; b=f67S+GPbZQG0yrN6PbMN7Q+kYY45+KBl74cpMEHHCWhleWL6NGvOk4g3ytJMRlkmYuNy5Wo7/dFrAyijab8Jir7AQtl1JQQIYtiYicG7M+YojzyiHUPti3HYGjyPRhDJLr2/pkMXcVfUZWwo0ysXtxtfoPdmtFoaetseFS7IUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146330; c=relaxed/simple;
	bh=/jCwisRBrQmUwawi79aGNrTjeiUEdJ83vf4WNOnWu/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5joqn3XIHa4ltVxACcZtdRxXWN5lxrVO830V+Vn82BXJ41PGrhre2h6yCUyi55j3qMDGSPvST7EbaQYvBr9C/O2QoW/NYV4aDhfdXBSOemw0+KCIrGTBYsetNxQHHelyj5ChbCpclws1lwWv0sP0siYWmu95CoUILePO7ojyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pcagf/6t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752146328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oeU07VlcLtDzcEl8VUco5BUOGkahI0EiFm7/oqOCbxQ=;
	b=Pcagf/6tMk3R/Lk6veiDc4g7Ck0+0w/tMVoMwd6nP/2B/1Q6lGJmrbV8fnUvjSN5XUr0Vv
	82+6AO39UuxmYNa04AYo7/NKe+6JwRhl04V3Q77JY0MT6OnvF1aBiTFWwE+Dz3qph1DglE
	24DxOBH1lmeZLjNBmeN2KcY1RlwQdBI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-pgPEZo2jO-mC-lR0zONVzQ-1; Thu, 10 Jul 2025 07:18:46 -0400
X-MC-Unique: pgPEZo2jO-mC-lR0zONVzQ-1
X-Mimecast-MFC-AGG-ID: pgPEZo2jO-mC-lR0zONVzQ_1752146325
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-553ab0afaa4so604060e87.3
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 04:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752146325; x=1752751125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeU07VlcLtDzcEl8VUco5BUOGkahI0EiFm7/oqOCbxQ=;
        b=cH8B5DIuqoYjLe6gvV0zLoVDige5961B/1lRvyiSvTIj7JtR4OJhIQJLS77OCve3xS
         0J4TNLP334pJYE2WMgaXwNq7JtF9cC3P0iz25Ai0cqucWgWLlhACkbDDACitNHZI44+d
         r21D1Tq3MCgSh77daL7K/ZXGR3i9sh7ANQvWsPWpg/LHcwDtXwC/rJk+QH//zz8d/1ar
         yqvtZ1Iwd4HpYf1odOSb3v4IyPFOpkqOqnHUSlUUsIXxuhAfiUOG6frIJuoid9cM5CoW
         4PCWRUonuo8lnvc6H2HZMVJtZJ4X0+7+Q72YyX7DN8nAOi/nVtlOyEoONdqArKo3kqFQ
         Q6tQ==
X-Gm-Message-State: AOJu0YxCz3TbdpXLs4draVAQPQpao/Kmbbui5/5kyKlq2j7Pjdc/l0E3
	l77K0p7a/GWjrJKb4y6OhGbJmUEuaq5Elz2B2GokNZcUrDEH55t0r0i6chiuJTcOd/oQ6iyqpci
	m8j5bLGXgfVu5z8xdAGKnyMrWR1zQWeK7DKvHV8u7IeqWdp15XMC+5AG6Pw==
X-Gm-Gg: ASbGncvJcbMnS11E08WBOMBfW573y5je067ZaGAw1v/fCDinUYeBWpvKJ24Zt9BxP5m
	zxaFx1WyfUnxzKpZ7i48Gf6l/8O0DMEId4Cz4mMPEVlVgJHlUNHAeUaK+ZA6iydqli3x1/GW8jp
	/smYPQl0u8yCYV+TVH2Q2nm6UhoBYxS7CFqxaD22Wo3ZfusNfuLrNj+N5oxGMBVm+fbwrmcHKl0
	AOxHyLM9MNJgp4udpCpxif+sd2604mI8XVj5zkCbg7C4ZPhD//CaDpEwVemnAK9dADWcOZaFvS/
	+Y/W9cXO/2aIbkVjrwW1
X-Received: by 2002:a05:6512:a8c:b0:553:adf7:e740 with SMTP id 2adb3069b0e04-5592e3e0855mr923765e87.28.1752146324944;
        Thu, 10 Jul 2025 04:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIk87mwJCG8QzmLoCZVYDBYdI0gpkdA/2ERSccEruX0F5Vgr7atFgRUmYWbcH2SP2hM5YmdQ==
X-Received: by 2002:a05:6512:a8c:b0:553:adf7:e740 with SMTP id 2adb3069b0e04-5592e3e0855mr923750e87.28.1752146324460;
        Thu, 10 Jul 2025 04:18:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbfcfsm340434e87.40.2025.07.10.04.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:18:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id F233D1B8A3DA; Thu, 10 Jul 2025 13:18:41 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 10 Jul 2025 13:18:34 +0200
Subject: [PATCH net-next v4 2/2] selftests: net: add netdev-l2addr.sh for
 testing L2 address functionality
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250710-netdevsim-perm_addr-v4-2-c9db2fecf3bf@redhat.com>
References: <20250710-netdevsim-perm_addr-v4-0-c9db2fecf3bf@redhat.com>
In-Reply-To: <20250710-netdevsim-perm_addr-v4-0-c9db2fecf3bf@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Add a new test script to the network selftests which tests getting and
setting of layer 2 addresses through netlink, including the newly added
support for setting a permaddr on netdevsim devices.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/net/Makefile         |  1 +
 tools/testing/selftests/net/lib.sh           | 23 +++++++++++
 tools/testing/selftests/net/netdev-l2addr.sh | 59 ++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 54377659652907af7232907e570eea2a9c5ba3dc..66a3ef221ad758d7844034c66a1dff4497b1ab54 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -63,6 +63,7 @@ TEST_PROGS += ip_local_port_range.sh
 TEST_PROGS += rps_default_mask.sh
 TEST_PROGS += big_tcp.sh
 TEST_PROGS += netns-sysctl.sh
+TEST_PROGS += netdev-l2addr.sh
 TEST_PROGS_EXTENDED := toeplitz_client.sh toeplitz.sh xfrm_policy_add_speed.sh
 TEST_GEN_FILES =  socket nettest
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index ff0dbe23e8e0c8d3a66159d9b82fdc1fc5d4804d..04f82a980cd3a32938ed1fe96188ec9b7a99e22c 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -240,6 +240,29 @@ create_netdevsim() {
     echo nsim$id
 }
 
+create_netdevsim_port() {
+    local nsim_id="$1"
+    local ns="$2"
+    local port_id="$3"
+    local perm_addr="$4"
+    local orig_dev
+    local new_dev
+    local nsim_path
+
+    nsim_path="/sys/bus/netdevsim/devices/netdevsim$nsim_id"
+
+    echo "$port_id $perm_addr" | ip netns exec "$ns" tee "$nsim_path"/new_port > /dev/null || return 1
+
+    orig_dev=$(ip netns exec "$ns" find "$nsim_path"/net/ -maxdepth 1 -name 'e*' | tail -n 1)
+    orig_dev=$(basename "$orig_dev")
+    new_dev="nsim${nsim_id}p$port_id"
+
+    ip -netns "$ns" link set dev "$orig_dev" name "$new_dev"
+    ip -netns "$ns" link set dev "$new_dev" up
+
+    echo "$new_dev"
+}
+
 # Remove netdevsim with given id.
 cleanup_netdevsim() {
     local id="$1"
diff --git a/tools/testing/selftests/net/netdev-l2addr.sh b/tools/testing/selftests/net/netdev-l2addr.sh
new file mode 100755
index 0000000000000000000000000000000000000000..18509da293e5bda2ccbbc678b2a240275c255bd7
--- /dev/null
+++ b/tools/testing/selftests/net/netdev-l2addr.sh
@@ -0,0 +1,59 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+set -o pipefail
+
+NSIM_ADDR=2025
+TEST_ADDR="d0:be:d0:be:d0:00"
+
+RET_CODE=0
+
+cleanup() {
+    cleanup_netdevsim "$NSIM_ADDR"
+    cleanup_ns "$NS"
+}
+
+trap cleanup EXIT
+
+fail() {
+    echo "ERROR: ${1:-unexpected return code} (ret: $_)" >&2
+    RET_CODE=1
+}
+
+get_addr()
+{
+    local type="$1"
+    local dev="$2"
+    local ns="$3"
+
+    ip -j -n "$ns" link show dev "$dev" | jq -er ".[0].$type"
+}
+
+setup_ns NS
+
+nsim=$(create_netdevsim $NSIM_ADDR "$NS")
+
+get_addr address "$nsim" "$NS" >/dev/null || fail "Couldn't get ether addr"
+get_addr broadcast "$nsim" "$NS" >/dev/null || fail "Couldn't get brd addr"
+get_addr permaddr "$nsim" "$NS" >/dev/null && fail "Found perm_addr without setting it"
+
+ip -n "$NS" link set dev "$nsim" address "$TEST_ADDR"
+ip -n "$NS" link set dev "$nsim" brd "$TEST_ADDR"
+
+[[ "$(get_addr address "$nsim" "$NS")" == "$TEST_ADDR" ]] || fail "Couldn't set ether addr"
+[[ "$(get_addr broadcast "$nsim" "$NS")" == "$TEST_ADDR" ]] || fail "Couldn't set brd addr"
+
+if create_netdevsim_port "$NSIM_ADDR" "$NS" 2 "FF:FF:FF:FF:FF:FF" 2>/dev/null; then
+    fail "Created netdevsim with broadcast permaddr"
+fi
+
+nsim_port=$(create_netdevsim_port "$NSIM_ADDR" "$NS" 2 "$TEST_ADDR")
+
+get_addr address "$nsim_port" "$NS" >/dev/null || fail "Couldn't get ether addr"
+get_addr broadcast "$nsim_port" "$NS" >/dev/null || fail "Couldn't get brd addr"
+[[ "$(get_addr permaddr "$nsim_port" "$NS")" == "$TEST_ADDR" ]] || fail "Couldn't get permaddr"
+
+cleanup_netdevsim "$NSIM_ADDR" "$NS"
+
+exit $RET_CODE

-- 
2.50.0


