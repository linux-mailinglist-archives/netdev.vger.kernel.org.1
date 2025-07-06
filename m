Return-Path: <netdev+bounces-204420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC70AFA5F7
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9E63B3C7A
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7C2139C9;
	Sun,  6 Jul 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSXXDCHa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6572639
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751813161; cv=none; b=TRjGRuOZFc2kfPnwg6KFPRbg75GNNcCrG2p4T/45aAHZO5P9jQ3DuGFls2zdiWUWzIfaSu7A/IbOGsQViX2N/ChBxcHhXNQZpBdgG4kkystfVz0LB8SbLl56RzPcN4kKpHfLRAgeoDp+mvqLRpEJDKByNApTjLnf/fW+c/nwU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751813161; c=relaxed/simple;
	bh=mFeREj8KVy9p4wg+TilWC0oWt5cRo1EpuHU2MeT1TH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JP1ot11S+NWbBxpAeZkuCnjcqTeXAunN7xrNoH1bWpdNfNZQ0pWCdIJh93KGzUZ1fYGBaovsflAdbWSLIRe4yzLbbKtvUFfS+iUDqEWzjcrNBrly6ZfC4I5/Q7D049JaKHijHGX2RfHVFp8zIesTBogaowSgj8P9Rs64jKK1EB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSXXDCHa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751813158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbfg2vSIfe5USBXm9Aha2lp/UmKnS6YnRYBJ9S2zu5E=;
	b=ZSXXDCHabGOy5o+ThGQ5/OWuP7EfjdAGHbQczxBUYVBpc41WyHrdgsCP69ZThj4yxNC8Bo
	cRJq4rEpnP08YnGWfg5GDMYwBwRMxzUSzXfjDzuzqNpXUInyQti8nqjd61J1dArt8y1XrG
	zBs0Td+lNQ+aneo8Mby1VLtGU3nz82k=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-dTJcPkCOPkugyco2lw7s7A-1; Sun, 06 Jul 2025 10:45:57 -0400
X-MC-Unique: dTJcPkCOPkugyco2lw7s7A-1
X-Mimecast-MFC-AGG-ID: dTJcPkCOPkugyco2lw7s7A_1751813156
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5551d40d2dbso1013299e87.1
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 07:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751813156; x=1752417956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbfg2vSIfe5USBXm9Aha2lp/UmKnS6YnRYBJ9S2zu5E=;
        b=aiEttihIsQjJD+mYfWuO81zUEgr0rNAI3F1F5NFSdcW6bYD+IVcr2rs3F815UPyut+
         jjGkT+w2DeMzNKxJXKnzCe/8/bwtP8WFavtvCIo7yLHyg1qtchOzm9iD/FVc8PSoIXwn
         yK8eHPcWILi2ee/ngvOxry5+VsBJgq0ZwBO/cZy4Ra/JGj5GGGga3TTX9t7C9NdoBPb5
         6E013SNn+k6cEzZwfnzpq9om6gEt4UDDC2pFadupGlG942nwOOtAO8XgtYyj1oBTwey9
         EGAHoCMP8fjwQcqpnL41ZNzqX8I6oex/RPvDE06esGwHSU2AEzaJBIT4LDCh2mzSp6j0
         ABrg==
X-Gm-Message-State: AOJu0YzArqx1KRXEf/JsCw9all1dk7oYiug/SUXMxXhhiMkhcOHa9Q3h
	bt7uWpiw9CV9Z3wKNCAAxAYQhaBhf9R8WA6ke0+N461BdNLpWDpZc1iKAXgVcSPbdjuUMmQgj+r
	5mocrWcITslJmMcpDPrjJURB2hmLhckMFIE8aCBHqvxHP9ioeP4/VsgtfTQ==
X-Gm-Gg: ASbGncu1ouXrD0IIgeG4+i70iOmVZcK8SZXLt3fnb6wYsmu5zaMFprxNbrdRc02I1UY
	UizeZblJkz/pxN4WFOyXuEcN69n3KqbKCHbLM56wyH46e5QlOWORmJQ45zV4e+8CpD1Zis5lRgZ
	S85O/Yc7fhZK0zeF2KGgm+TzqWCb0NvLg9Zp5pUwKICuj6B73YOpJCFglmoIi7jOPxVFFkGD41C
	qkcte/y4Jz1uyl6u0bI9s05nxKiMmK9rNDV2xfuiu+xG8NbHow/+iLiAkhaCRhuRNFbsobFs2FD
	B628T3NcxXjrLHnpOZO/HZTbS6SfP0eGcoUO51WNxo98ayI=
X-Received: by 2002:a2e:a549:0:b0:32a:8ae2:a8a7 with SMTP id 38308e7fff4ca-32f00c661bbmr30040191fa.8.1751813155599;
        Sun, 06 Jul 2025 07:45:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4E8Z6izy/7WuZXk9NrRfPbbNW8QTcI2DjS7BJoGZ1ym3EyUDD2d1tSAobmIFiqkI1UqbSXw==
X-Received: by 2002:a2e:a549:0:b0:32a:8ae2:a8a7 with SMTP id 38308e7fff4ca-32f00c661bbmr30039991fa.8.1751813155097;
        Sun, 06 Jul 2025 07:45:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32e1afc2356sm9599271fa.33.2025.07.06.07.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 07:45:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EE45A1B89EAF; Sun, 06 Jul 2025 16:45:52 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Sun, 06 Jul 2025 16:45:32 +0200
Subject: [PATCH net-next v3 2/2] selftests: net: add netdev-l2addr.sh for
 testing L2 address functionality
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250706-netdevsim-perm_addr-v3-2-88123e2b2027@redhat.com>
References: <20250706-netdevsim-perm_addr-v3-0-88123e2b2027@redhat.com>
In-Reply-To: <20250706-netdevsim-perm_addr-v3-0-88123e2b2027@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Add a new test script to the network selftests which tests getting and
setting of layer 2 addresses through netlink, including the newly added
support for setting a permaddr on netdevsim devices.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/net/Makefile         |  1 +
 tools/testing/selftests/net/lib.sh           | 23 ++++++++++
 tools/testing/selftests/net/netdev-l2addr.sh | 69 ++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

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
index ff0dbe23e8e0c8d3a66159d9b82fdc1fc5d4804d..f4c3c90bd89acd3ee060b76d53afb43499a35a64 100644
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
+    echo "$port_id $perm_addr" | ip netns exec "$ns" tee "$nsim_path"/new_port > /dev/null
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
index 0000000000000000000000000000000000000000..a53f33ee368c2e59b1a867d5d1fdb391db1b67a8
--- /dev/null
+++ b/tools/testing/selftests/net/netdev-l2addr.sh
@@ -0,0 +1,69 @@
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
+    local found=0
+    local type="$1"
+    local dev="$2"
+    local ns="$3"
+    local output
+
+    output=$(ip -n "$ns" link show dev "$dev" | grep "link/")
+
+    for k in $output; do
+        if [ "$found" -eq "1" ]; then
+            echo "$k"
+            return 0
+        fi
+        if [[ "$k" == "$type" ]]; then
+            found=1
+        fi
+    done
+
+    return 1
+}
+
+setup_ns NS
+
+nsim=$(create_netdevsim $NSIM_ADDR "$NS")
+
+get_addr link/ether "$nsim" "$NS" >/dev/null || fail "Couldn't get ether addr"
+get_addr brd "$nsim" "$NS" >/dev/null || fail "Couldn't get brd addr"
+get_addr perm "$nsim" "$NS" && fail "Found perm_addr without setting it"
+
+ip -n "$NS" link set dev "$nsim" address "$TEST_ADDR"
+ip -n "$NS" link set dev "$nsim" brd "$TEST_ADDR"
+
+[[ "$(get_addr link/ether "$nsim" "$NS")" == "$TEST_ADDR" ]] || fail "Couldn't set ether addr"
+[[ "$(get_addr brd "$nsim" "$NS")" == "$TEST_ADDR" ]] || fail "Couldn't set brd addr"
+
+nsim_port=$(create_netdevsim_port "$NSIM_ADDR" "$NS" 2 "$TEST_ADDR")
+
+get_addr link/ether "$nsim_port" "$NS" >/dev/null || fail "Couldn't get ether addr"
+get_addr brd "$nsim_port" "$NS" >/dev/null || fail "Couldn't get brd addr"
+[[ "$(get_addr permaddr "$nsim_port" "$NS")" == "$TEST_ADDR" ]] || fail "Couldn't get permaddr"
+
+cleanup_netdevsim "$NSIM_ADDR" "$NS"
+
+exit $RET_CODE

-- 
2.50.0


