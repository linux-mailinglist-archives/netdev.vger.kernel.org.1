Return-Path: <netdev+bounces-213777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CE5B268F5
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6AA1CE2ABF
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A53220F5C;
	Thu, 14 Aug 2025 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7d8HrzL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD821D3C5;
	Thu, 14 Aug 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180220; cv=none; b=gmTbH2qaSkHBcoYmtgezPltAcdsRfV+2sDgJM/f9zI8KCXyfU3rCF9XSRELqiuJ1AbzSV+7HjALXjzx5MPGNShOJHTx/PSilOJEDLmnIU2N+3sGRZ6Q9eYPU7THtagnvXzwktocm4xf8iqnBGE2B1OWUh2yHtriifWf8/FB5E/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180220; c=relaxed/simple;
	bh=P+9HgUpbubR24QEwTBNnkun+LVmOIGHZmzlAEkjm5pE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OeIcrYn4BOpazA6wEIaKVhajZbtn2H2CCCF5ln8BkkvVB5vWnNkjZvU1QtUDFVaQAa1O+BHh+uu44LwsyZ6P61fN1+nvIbPFAPsRITuZcpJaOAG4LRzOGwrj2yaI5Uz1Mn1MDiryKDOzVtyLJafHIKia3ySDyFBoVRV3CA5YNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7d8HrzL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b0b2d21so4915465e9.2;
        Thu, 14 Aug 2025 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755180217; x=1755785017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxXSu6aBR4j/2h9Jk21q3XAtSOVHdikpb6rC+rmqJY4=;
        b=B7d8HrzLlhGipVdK9+ebfxM4U05TGx1bJ+SJNjelXFARPYWDzgPzFdLsbtVKkiY7nf
         I3RHIUT1G9tuMPxgQ061jWCpeFzJF54JHnMjuWQvIICJdaJch/L3sVEZi32sWh8oxeoH
         jgI4Aca1qyZ+4rUOnB3uqixD0blB0OLTLr0HwepcCqe0X/CJi2+9zHXyEsQ2/HzRldoB
         VzI5pxf5mEYNPpYuK2+TVks++pLwjVLM4nnyERnk50aChiweK5iLQaHhinRaWY63PQZS
         lqoM+pQcDJvo5l/IvIjtCOe5UJocy2p1wGxKNe1GuC4uUzPS1+/3vtO4Grqid5x/1Sko
         WTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180217; x=1755785017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxXSu6aBR4j/2h9Jk21q3XAtSOVHdikpb6rC+rmqJY4=;
        b=jZlFgpobeMadOlBGMVyJjf4XOZq7w3mXS67kee6ZRDUNKE0twMd7GSIBfq42o2KD1e
         /4n6S0MTY6mUsQA7hCUIfscjid+28vC+H46uDazlhMJSZ3KDTUw8Jp7oKf0y1qyeZyP8
         y4+5xUkOxP0nMAZsAV9bjMNl9K7pkvyAzeHQzve856njdc4wikPf+fg9yyUfmcrNCfso
         eXByi+9+vc3Qv+29b4NoAgc3CLCqZ+JzQ7M2xNzckayCSks4vcuV/VzPLflb6c//6XcH
         43l1GjyLeeUMy7ul08EYNMpGOrZ+lVJTd86tHDZRyxYpLzE3NpaUEAtwgJ3qlx0pC9IK
         Wv4w==
X-Forwarded-Encrypted: i=1; AJvYcCWYH2ckpUGa0nuhUJYkmO8SCL+s7NxCLQOVLJ9KNlsF41DLCki9ygMfFx+HKtYjLe8iH6MJ6QGAfTvVdnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkhnS+Vc2a6oWvByEeA3/dXyVwyy5XJR6KdrSwFxBnFa1qU2ns
	YOAp4JIPQHgw21hImnJUrsHr9k41zOET4GPxuco3Cx7jyqKRMK5N5TUug1IIQQ==
X-Gm-Gg: ASbGncuRWUdTMrV8UN6mEAt85GKbL7oFEKd5wiv2yj4aaIMFexwYoqjdOpb8bxDr3kJ
	lsjye63GM0StUp96LKf+eAXJjeq+0mbHLZRIxAd5vprU7Xh7VU5G7qmGL164JkWl4/GlO9MSvs4
	SZg1pakeoM95UXqrmq1UdSN9FiDCaRLa/2CiCicZtNp70oxOGeS7qbBntZCi6CJy2k8tnoszzt7
	xNZJg/S2nqAN04V+N4kJ9t8SgY89sPWgyilPgwGA5v6cqAlDp6Szzu4Bb961EyCw5CALpzQohmj
	sEyJflxGjgzd70AkIEWxUAYcJ8rQdaGlQftMHGBppNRsh7UL07Vmutesfvof82aUAf5dWkmhFiV
	qtuBdztZan1NgJOXxuJxb
X-Google-Smtp-Source: AGHT+IEbb8zJmcQIRTw/3UL8iG8DmYayAWcPbjO65U5u2ao7Rjm9/MmIJW4SB2jaSmO7AhonQAQnsQ==
X-Received: by 2002:a05:600c:4ece:b0:455:f187:6203 with SMTP id 5b1f17b1804b1-45a1b654a11mr26145295e9.27.1755180216603;
        Thu, 14 Aug 2025 07:03:36 -0700 (PDT)
Received: from oscar-xps.. ([79.127.164.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6c2e95sm22483085e9.6.2025.08.14.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:03:36 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net-next v2 2/2] selftests: net: add test for dst hint mechanism with directed broadcast addresses
Date: Thu, 14 Aug 2025 16:03:09 +0200
Message-Id: <20250814140309.3742-3-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814140309.3742-1-oscmaes92@gmail.com>
References: <20250814140309.3742-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for ensuring that the dst hint mechanism is used for
directed broadcast addresses.

This test relies on mausezahn for sending directed broadcast packets.
Additionally, a high GRO flush timeout is set to ensure that packets
will be received as lists.

The test determines if the hint mechanism was used by checking
the in_brd statistic using lnstat.

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 tools/testing/selftests/net/route_hint.sh | 58 +++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100755 tools/testing/selftests/net/route_hint.sh

diff --git a/tools/testing/selftests/net/route_hint.sh b/tools/testing/selftests/net/route_hint.sh
new file mode 100755
index 000000000000..fab08d8b742d
--- /dev/null
+++ b/tools/testing/selftests/net/route_hint.sh
@@ -0,0 +1,58 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test ensures directed broadcast routes use dst hint mechanism
+
+CLIENT_NS=$(mktemp -u client-XXXXXXXX)
+CLIENT_IP4="192.168.0.1"
+
+SERVER_NS=$(mktemp -u server-XXXXXXXX)
+SERVER_IP4="192.168.0.2"
+
+BROADCAST_ADDRESS="192.168.0.255"
+
+setup() {
+	ip netns add "${CLIENT_NS}"
+	ip netns add "${SERVER_NS}"
+
+	ip -net "${SERVER_NS}" link add link1 type veth peer name link0 netns "${CLIENT_NS}"
+
+	ip -net "${CLIENT_NS}" link set link0 up
+	ip -net "${CLIENT_NS}" addr add "${CLIENT_IP4}/24" dev link0
+
+	ip -net "${SERVER_NS}" link set link1 up
+	ip -net "${SERVER_NS}" addr add "${SERVER_IP4}/24" dev link1
+
+	ip netns exec "${CLIENT_NS}" ethtool -K link0 tcp-segmentation-offload off
+	ip netns exec "${SERVER_NS}" sh -c "echo 500000000 > /sys/class/net/link1/gro_flush_timeout"
+	ip netns exec "${SERVER_NS}" sh -c "echo 1 > /sys/class/net/link1/napi_defer_hard_irqs"
+	ip netns exec "${SERVER_NS}" ethtool -K link1 generic-receive-offload on
+}
+
+cleanup() {
+	ip -net "${SERVER_NS}" link del link1
+	ip netns del "${CLIENT_NS}"
+	ip netns del "${SERVER_NS}"
+}
+
+directed_bcast_hint_test()
+{
+	echo "Testing for directed broadcast route hint"
+
+	orig_in_brd=$(ip netns exec "${SERVER_NS}" lnstat -k in_brd -s0 -i1 -c1 | tr -d ' |')
+	ip netns exec "${CLIENT_NS}" mausezahn link0 -a own -b bcast -A "${CLIENT_IP4}" \
+		-B "${BROADCAST_ADDRESS}" -c1 -t tcp "sp=1-100,dp=1234,s=1,a=0" -p 5 -q
+	sleep 1
+	new_in_brd=$(ip netns exec "${SERVER_NS}" lnstat -k in_brd -s0 -i1 -c1 | tr -d ' |')
+
+	res=$(echo "${new_in_brd} - ${orig_in_brd}" | bc)
+
+	[ "${res}" -lt 100 ]
+}
+
+trap cleanup EXIT
+
+setup
+
+directed_bcast_hint_test
+exit $?
-- 
2.39.5


