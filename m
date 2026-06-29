Return-Path: <netdev+bounces-302815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8NbULI3FQmomBQoAu9opvQ
	(envelope-from <netdev+bounces-302815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:20:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B116DE415
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:20:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=bd4p6ltj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302815-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302815-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B531D300B19C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B243B14B4;
	Mon, 29 Jun 2026 19:20:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91563976A7
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 19:20:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760838; cv=none; b=mYJIGVTno3oegW6iooVuXw/bU44QTg85xp+G3Tlq5tYKLEgVWybWH2T2xMNN9eb3Xhssowzi3ZDcgK++pwX4D62T46ryFpti8rlALL+nkU0yS45rArosHfBA7bOXJJo6Y6vW/cGvPwZk2wnSmx26Hs0eIYoxtDdBWBWKL7xHznA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760838; c=relaxed/simple;
	bh=QBZxmTWawUTZNQSQjCCZw78T/8SJZ6wFeJT6/geEVGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BVmDi7Xvawv0nEwOqDxoEfUcnAzp+ozGPadUBG7GBKS3T9U9/KqFlr5DN2+FP06x6/GMHN3/B5TdQ1QHy7EqIEn540m5b39U+zwP7ucBZ5z0fss1hp6z/qoaNmx61qU8rfFwdWEJyMokE6fwvP1gs33/YNlZfRgcA1hcjyzuYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tanshuhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bd4p6ltj; arc=none smtp.client-ip=74.125.82.201
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30ec59471a3so1207638eec.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782760836; x=1783365636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fpTPHw0jPF1PHgzGmVWLf8QEAGl8IOcqrkx31ztxko=;
        b=bd4p6ltjqlA3As4odq1WHdN4n5ECMvrczee92pBCx52PdzmmzcJ+Le+u6hcaUEBp2z
         b6HBkVEd7NoIWLFA8VRR36oBo7Uf3lwGIL856FZpBBR0rXl1IlyyrWz5yUrB+tkfo96j
         Htb0QKxZT/KecBS64DmN3EiCGLM1/oatgd5vh18fXrrjhKK2PpGhVVc0VUk2PfdcZPYf
         eFn25OVUzW3Ms2qYsRQ2N12o66akau/9L4tcl9Fm3eWEqtBruW7o+NaDryuo3iS6UKQs
         Zetky7YCw9US64RHgwmyIA7C2BRhtQPQ5V0pASSn8uo3CKAL7fu17z2ddJttn4rztvkQ
         YGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760836; x=1783365636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fpTPHw0jPF1PHgzGmVWLf8QEAGl8IOcqrkx31ztxko=;
        b=Rorn+8woBzyRp01v1IuKYMbI6bhwUlpzhzscIzfxmDTXzbKP9CmeUFPyZTR95th2c/
         +WFprSy604E2AVyJxqVndvcfr7IDoewZ+D4wh1MrbJUzjjrqGvKHVTQ2H6mYNGBuqlw8
         glEqoXppzh8puTFdzdAXnVb8NOgrWOK7XVFoE3JPe6AqzeZrsJm6v4GsiFrC6dfvFMA0
         gRhbjDPnbGb2nQJ5Qym+RoxFhc0l0cTL+WEsv+1mByr+ktMTOJWeS3xHDdorCf2J1RwW
         T/0Jt7K9MaqAlXCmZfjJomIyJ3+WctYnYS0ZjvR0q1xwiJYtPMoiwr1x2kUyKbMlAdVO
         CQFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr5g2VO86FBPLGcL9ZMiOa+he2vSiR4XIlWbmXNr9F+ov5ObYZi8PVXX+KU3BzSnJ+QTusD52U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5u//KdFgXFQp7K5gbhj8kMHnONQaavLcOTECbX/eej/H62Nkq
	yC8s8Ce4mXKEc4/AEiPd/KESMn/cAaEW7sTzASIkYqKin4ECGsFjTE83iK5QnM7XUk3FGB80p+e
	O1sqHIhE1HP9U+58c7A==
X-Received: from dyjw37.prod.google.com ([2002:a05:7300:56a5:b0:30c:9f7d:e238])
 (user=tanshuhao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:3b09:b0:30c:ab96:7306 with SMTP id 5a478bee46e88-30ee1cc79a8mr325933eec.22.1782760835402;
 Mon, 29 Jun 2026 12:20:35 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:20:27 -0700
In-Reply-To: <20260629192029.4013794-1-tanshuhao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629192029.4013794-1-tanshuhao@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629192029.4013794-3-tanshuhao@google.com>
Subject: [PATCH net-next v1 2/2] selftests: net: Add kthread preserving test
 in napi_threaded and busy_poll_test
From: Shuhao Tan <tanshuhao@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Shuhao Tan <tanshuhao@google.com>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:shuah@kernel.org,m:tanshuhao@google.com,m:almasrymina@google.com,m:skhawaja@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tanshuhao@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302815-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tanshuhao@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52B116DE415

Add a testcase to ensure the kthread stays the same across NIC link
flap.

Add a testcase to ensure the same kthread can poll different napis
across NIC link flap.

Signed-off-by: Shuhao Tan <tanshuhao@google.com>
---
 .../selftests/drivers/net/napi_threaded.py    | 41 ++++++++++++++++++-
 tools/testing/selftests/net/busy_poll_test.sh | 24 +++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/napi_threaded.py b/tools/testing/selftests/drivers/net/napi_threaded.py
index f4be72b2145a..20110fb6942e 100755
--- a/tools/testing/selftests/drivers/net/napi_threaded.py
+++ b/tools/testing/selftests/drivers/net/napi_threaded.py
@@ -127,6 +127,44 @@ def change_num_queues(cfg, nl) -> None:
     _assert_napi_threaded_enabled(nl, napi0_id)
     _assert_napi_threaded_enabled(nl, napi1_id)
 
+def nic_link_flap(cfg, nl) -> None:
+    """
+    Test that if threaded is enabled, and NIC goes through
+    a reset, the kthread stays unchanged across the link flap.
+    """
+    napis = nl.napi_get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_ge(len(napis), 2)
+
+    napi0_id = napis[0]['id']
+    napi1_id = napis[1]['id']
+
+    _setup_deferred_cleanup(cfg)
+
+    # set threaded
+    _set_threaded_state(cfg, 1)
+    napis = nl.napi_get({'ifindex': cfg.ifindex}, dump=True)
+
+    # check napi threaded is set for both napis
+    _assert_napi_threaded_enabled(nl, napi0_id)
+    _assert_napi_threaded_enabled(nl, napi1_id)
+
+    pid0 = napis[0].get('pid')
+    pid1 = napis[1].get('pid')
+
+    cmd(f"ip link set {cfg.ifname} down")
+    cmd(f"ip link set {cfg.ifname} up")
+
+    # re-acquire napi info
+    napis = nl.napi_get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_ge(len(napis), 2)
+
+    # check napi threaded is set for both napis
+    _assert_napi_threaded_enabled(nl, napi0_id)
+    _assert_napi_threaded_enabled(nl, napi1_id)
+
+    # check the kthread remains the same
+    ksft_eq(napis[0].get('pid'), pid0)
+    ksft_eq(napis[1].get('pid'), pid1)
 
 def main() -> None:
     """ Ksft boiler plate main """
@@ -134,7 +172,8 @@ def main() -> None:
     with NetDrvEnv(__file__, queue_count=2) as cfg:
         ksft_run([napi_init,
                   change_num_queues,
-                  enable_dev_threaded_disable_napi_threaded],
+                  enable_dev_threaded_disable_napi_threaded,
+                  nic_link_flap],
                  args=(cfg, NetdevFamily()))
     ksft_exit()
 
diff --git a/tools/testing/selftests/net/busy_poll_test.sh b/tools/testing/selftests/net/busy_poll_test.sh
index 5ec1c85c1623..897ce6700601 100755
--- a/tools/testing/selftests/net/busy_poll_test.sh
+++ b/tools/testing/selftests/net/busy_poll_test.sh
@@ -124,6 +124,23 @@ test_busypoll_with_napi_threaded()
 	return $?
 }
 
+test_busypoll_with_napi_threaded_link_flap()
+{
+	# Only enable napi threaded poll. Set suspend timeout and prefer busy
+	# poll to 0. Run again after a link flap.
+	test_busypoll 0 ${NAPI_THREADED_MODE_BUSY_POLL} 0 || return $?
+
+	ip netns exec nssv ip link set dev $NSIM_SV_NAME down
+	ip netns exec nscl ip link set dev $NSIM_CL_NAME down
+
+	ip netns exec nssv ip link set dev $NSIM_SV_NAME up
+	ip netns exec nscl ip link set dev $NSIM_CL_NAME up
+
+	test_busypoll 0 ${NAPI_THREADED_MODE_BUSY_POLL} 0
+
+	return $?
+}
+
 ###
 ### Code start
 ###
@@ -176,6 +193,13 @@ if [ $? -ne 0 ]; then
 	exit 1
 fi
 
+test_busypoll_with_napi_threaded_link_flap
+if [ $? -ne 0 ]; then
+	echo "test_busypoll_with_napi_threaded_link_flap failed"
+	cleanup_ns
+	exit 1
+fi
+
 echo "$NSIM_SV_FD:$NSIM_SV_IFIDX" > $NSIM_DEV_SYS_UNLINK
 
 echo $NSIM_CL_ID > $NSIM_DEV_SYS_DEL
-- 
2.55.0.rc0.799.gd6f94ed593-goog


