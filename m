Return-Path: <netdev+bounces-262089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNjvNTGXomn14AQAu9opvQ
	(envelope-from <netdev+bounces-262089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:20:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 437EE1C0F2C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C14EB317A968
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 07:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCC236A024;
	Sat, 28 Feb 2026 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jReCwRGu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0436682C
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262981; cv=none; b=ocOJFy4UzWpoXJfDL+i/XyKsWYX3iJLJeft8S67R8OL1kWD/pysxqVNwRBEraVS14NQFt72wTYd1Mjo+hSByGT2/029Wo8PcrTWD2CacRJdbgT5N519TvwlV6zZOKx59kjC03LkJUy7CyS60xOQMUBdMinl4l2m8gLg1bmIKWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262981; c=relaxed/simple;
	bh=FTYLMrg6206po8qLXh2VYTUEJmwCnHlioxfcai+cfUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPM/lDcFJoVELKB6aGHf9xdgmzm3lgaE1k1xFEejms5sf7wYzeC6ufZE2rMaBFu8zrU4WR27R7bFdLLvf/JJnskLt3feskKkaxgmqZOxMG05+4cV59d2kYp6frqy43cD7NSXW2xF9U5oFtvDDUoAdLq/d1/AI7wC5Mt/j44Bc8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jReCwRGu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad21f437eeso21209905ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772262979; x=1772867779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmJzsuFRLBUvnAtfdwJXgQ3SY6YhuOsJjknIwY8/1vI=;
        b=jReCwRGuxAZTpGSv4xtdEhrhebWp1jjsCF24myJP4kS5CZeWVX50vb5LNJaU5AZxJ/
         rm0k85Bn+s5RC91qgyyJ78u00pPqAWK1P3AQnVZvG9N186xuKjHKANJYkPzoGoI5fCEu
         EKBOm3F6iqyx/aQfwomeeTLOOq6nNjL9osKeMyrPOfzHTa1yN0Wnxa21sb2Sq7UXhpDI
         iFdOgW6o2t/el0IzDjd3haDOThhIyZ1n1ZA7DRxY2JFbdq6SigcMd8i97ONttNiVcCtI
         spQmV8w87Zs7rbTY3Kr4Xsz0IDq9Cmvaw+rMUEmM6i/0ahzGkJtDhjYv4KiNk588vGj1
         6T3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772262979; x=1772867779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bmJzsuFRLBUvnAtfdwJXgQ3SY6YhuOsJjknIwY8/1vI=;
        b=X96gaFZDQpWDLaQCgWlEC4IldsNfBESIDT4SgoHb9xHRO5lPq07sHYizEv24vLG0JW
         Cj/lLFsx8WbFLiD1hXb0nibEYaSxyOOKe40hZ4DBV/D7eP0djnJtN+EfHFVaAUR61Pvj
         GPFNnBGg6jM8uc/7/+RNALQ0flrRFy+7a1sZtbeE7gRYdsRwO4aJK4hDdSb3wrLhHf/6
         A+lD4yhktXYdODqPbOtgRQFx0LcT4uiJDy3YOUx8s54zDTT4stYfZtFJ3quE5P0AgqYw
         CHxzpoEeyatLnovhead6BZMIHKX27YfAAeit9fiEi0bbBhECSV9vixlGE6ItKUY5zqVV
         YgqA==
X-Gm-Message-State: AOJu0YzjooTnG4xh20Y6e417TjC3o0oTwwjWZkXMVXxxxbTPYa7JgVAI
	i1ckY/U0xbEgI23p4yfaDcAopzmlX/zW0PVDmuqaIXc6Qmctr/4LavNc
X-Gm-Gg: ATEYQzxJmGm5cYlKu5JvZbbqrNe8EXtSxQFMj6DvHml9blKbSRI78V9+1Ten/P18cd2
	xEPBSdMMRrQaB9yf9npaeZzbWJy/Al9GfQTto9s1OqKda/lupgI/XQkSbSlxyT+ef2tbqaTyBFa
	hOrjb4FxynoNJ7ZkXTRwUK9Nr6zdlwAF1jF2KdKfzLEV0C/pz2cCzC3etDJVsPzcmLSVzxlqq1b
	63U8dsHWR2j+vew0/dre4dnGeG7bQjZx/VDfRDz4oXC3X6Oq88YoNSDfmEI22ES4p4nyZIDAy3L
	6e0tBcpm4Fy8jHqxUE2Ozl+zSlSlMvE/UgbudVzAPWL1pEiNA3kShFkAUqU20PIZjoho9pRVV9N
	FyT+Q4eNl/plI3GCKFebBwmwZYtT7MtoyyNoGpk1JHJfGVDjGpznnca9FU87ZgeClWcyDt/hkWK
	Zh/847JWl269VwXseU1rcZqWJpS3UjCb+bxibO4OBhP6y4BSK8Xjwe8Bus+w==
X-Received: by 2002:a17:902:ea08:b0:2aa:e9f0:146c with SMTP id d9443c01a7336-2adf79cd7d5mr104999395ad.29.1772262979381;
        Fri, 27 Feb 2026 23:16:19 -0800 (PST)
Received: from localhost.localdomain ([183.96.230.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b4535sm72004075ad.17.2026.02.27.23.16.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Feb 2026 23:16:19 -0800 (PST)
From: Kibaek Yoo <psykibaek@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kibaek Yoo <psykibaek@gmail.com>
Subject: [PATCH v2 2/2] selftests: net: add macvlan multicast test for shared source MAC
Date: Sat, 28 Feb 2026 16:16:13 +0900
Message-ID: <20260228071613.4360-2-psykibaek@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228071613.4360-1-psykibaek@gmail.com>
References: <20260225100024.38937-1-psykibaek@gmail.com>
 <20260228071613.4360-1-psykibaek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262089-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[psykibaek@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 437EE1C0F2C
X-Rspamd-Action: no action

Add a selftest that verifies multicast delivery to a macvlan bridge
port when the source MAC of the incoming frame matches the macvlan's
own MAC address.

This scenario occurs with protocols like VRRP where multiple hosts
share the same virtual MAC address. Without the corresponding kernel
change, macvlan bridge mode does not handle this case and the
multicast frame is not delivered.

Signed-off-by: Kibaek Yoo <psykibaek@gmail.com>
---
 tools/testing/selftests/net/Makefile          |  1 +
 .../selftests/net/macvlan_mcast_shared_mac.sh | 93 +++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100755 tools/testing/selftests/net/macvlan_mcast_shared_mac.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index afdea6d95bde0..c12f6f600ee5e 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -54,6 +54,7 @@ TEST_PROGS := \
 	l2tp.sh \
 	link_netns.py \
 	lwt_dst_cache_ref_loop.sh \
+	macvlan_mcast_shared_mac.sh \
 	msg_zerocopy.sh \
 	nat6to4.sh \
 	ndisc_unsolicited_na_test.sh \
diff --git a/tools/testing/selftests/net/macvlan_mcast_shared_mac.sh b/tools/testing/selftests/net/macvlan_mcast_shared_mac.sh
new file mode 100755
index 0000000000000..ff5b893472474
--- /dev/null
+++ b/tools/testing/selftests/net/macvlan_mcast_shared_mac.sh
@@ -0,0 +1,93 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test multicast delivery to macvlan bridge ports when the source MAC
+# matches the macvlan's own MAC address (e.g., VRRP virtual MAC shared
+# across multiple hosts).
+#
+# Topology:
+#
+#   NS_SRC                          NS_BRIDGE
+#   veth_src (SHARED_MAC) <----->  veth_dst
+#                                     |
+#                                     +-- macvlan0 (bridge mode, SHARED_MAC)
+#
+# A multicast packet sent from NS_SRC with source MAC equal to
+# macvlan0's MAC must still be delivered to macvlan0.
+
+source lib.sh
+
+SHARED_MAC="00:00:5e:00:01:01"
+MCAST_ADDR="239.0.0.1"
+
+setup() {
+	setup_ns NS_SRC NS_BRIDGE
+
+	ip -net "${NS_BRIDGE}" link add veth_dst type veth \
+		peer name veth_src netns "${NS_SRC}"
+
+	ip -net "${NS_SRC}" link set veth_src address "${SHARED_MAC}"
+	ip -net "${NS_SRC}" link set veth_src up
+	ip -net "${NS_SRC}" addr add 192.168.1.1/24 dev veth_src
+
+	ip -net "${NS_BRIDGE}" link set veth_dst up
+
+	ip -net "${NS_BRIDGE}" link add macvlan0 link veth_dst \
+		type macvlan mode bridge
+	ip -net "${NS_BRIDGE}" link set macvlan0 address "${SHARED_MAC}"
+	ip -net "${NS_BRIDGE}" link set macvlan0 up
+	ip -net "${NS_BRIDGE}" addr add 192.168.1.2/24 dev macvlan0
+
+	# Accept all multicast so the mc_filter passes for any group.
+	ip -net "${NS_BRIDGE}" link set macvlan0 allmulticast on
+}
+
+cleanup() {
+	rm -f "${CAPFILE}" "${CAPOUT}"
+	cleanup_ns "${NS_SRC}" "${NS_BRIDGE}"
+}
+
+test_macvlan_mcast_shared_mac() {
+	CAPFILE=$(mktemp)
+	CAPOUT=$(mktemp)
+
+	echo "Testing multicast delivery to macvlan with shared source MAC"
+
+	# Listen for one ICMP packet on macvlan0.
+	timeout 5s ip netns exec "${NS_BRIDGE}" \
+		tcpdump -i macvlan0 -c 1 -w "${CAPFILE}" icmp &> "${CAPOUT}" &
+	local pid=$!
+	if ! slowwait 1 grep -qs "listening" "${CAPOUT}"; then
+		echo "[FAIL] tcpdump did not start listening"
+		return "${ksft_fail}"
+	fi
+
+	# Send multicast ping from NS_SRC; source MAC equals macvlan0's MAC.
+	ip netns exec "${NS_SRC}" \
+		ping -W 0.1 -c 3 -I veth_src "${MCAST_ADDR}" &> /dev/null
+
+	wait "${pid}"
+
+	local count
+	count=$(tcpdump -r "${CAPFILE}" 2>/dev/null | wc -l)
+	if [[ "${count}" -ge 1 ]]; then
+		echo "[ OK ]"
+		return "${ksft_pass}"
+	else
+		echo "[FAIL] expected at least 1 ICMP packet on macvlan0," \
+			"got ${count}"
+		return "${ksft_fail}"
+	fi
+}
+
+if [ ! -x "$(command -v tcpdump)" ]; then
+	echo "SKIP: Could not run test without tcpdump tool"
+	exit "${ksft_skip}"
+fi
+
+trap cleanup EXIT
+
+setup
+test_macvlan_mcast_shared_mac
+
+exit $?
-- 
2.50.1 (Apple Git-155)


