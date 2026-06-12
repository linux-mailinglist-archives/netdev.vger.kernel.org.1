Return-Path: <netdev+bounces-298755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2tPJC9dDLGpXOgQAu9opvQ
	(envelope-from <netdev+bounces-298755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:37:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDC367B637
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:37:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=T7gcPcc8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298755-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298755-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32FA9301E800
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13930408034;
	Fri, 12 Jun 2026 17:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474A40759B
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:36:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285816; cv=none; b=W16AyMMypr0ZekwfqhW98MVd0P3mJ+zkQR5Lu0YhEOZ8GIontfxk/Xe2APFI/ucDuvO+35YTspaCrQCxkniRxEalK1PqUym9fE5o2X+fS3l+mDTCq0RlZiXI2zYIjdD4fl1P2EFuAYvB/DFaBHxSSd4woApcgpZFyZ5F7Iux15c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285816; c=relaxed/simple;
	bh=llZ8H1lfztnu03TuEAoA5P95ceB3NnCFNCOfl247eDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tEEoiIHDT43GiDVc6vCeodl+nHCPj6WovL/GlFLnMcs0Kg7D469+CpUdimQG+SAbxMLD+1ylT9f6zAIaQPNDkGPhYpIcLDSmC3HRgijYrEPcR/tAMEO/+ozcScYnRpqeV3O74qLynejwSGP8OyzSyvYMrr+QVlGhxN6sk5ghWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tanshuhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T7gcPcc8; arc=none smtp.client-ip=74.125.82.202
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304ec73b015so82083eec.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781285814; x=1781890614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EgcIZJWJZmsAs9uR37o6ITXG3G+FR+XpfTMm8NsA12M=;
        b=T7gcPcc8eKH3YVtLef7pkiedFVmYMrwXaWjJsGkcjgPOwScqmZSW0htw+sY18UjKhu
         mA/b41LTMBqveTsveNjpSUF6TzGOZPX1NYe3/f5U1IikGQOfwkCKi6ik5T44P07N3ryF
         1ItaW531BKedFu/Np/pCrOM7y8rJ0yWZeOl26FYkzhs+6MlDwPCiTVHXiHBMno0vneKV
         mub7P1TNMxk90YZvFnByYgUwfPMy+Yl8CLx9ItTu+NWr0ogZoZ1B2TJDr1144PEhXWzn
         crglSztZEixVjCmaP+1xOSDteynJWLV99y+hHpRaJ+tlRGyJlzFaMpN2skZ5VKL7Dsrp
         rqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781285814; x=1781890614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgcIZJWJZmsAs9uR37o6ITXG3G+FR+XpfTMm8NsA12M=;
        b=SwIjnKk7tMs6YiRQP/kF4rZElXzQhVkRyktC+EjpbOeZ0OCcDnO0bsKPOLMqIBYeoB
         ae9DTkCXGZKt1u7e6DJ94Sj1Q9peVtZ1jC2hsnPn0aCN6RBLpxrADAVCQmfOTEktv1o8
         XGi6iA94CZB/xs7yGbhIHF90piVySzbvVINMH4QiRXlcpX+HNHH4wwMmtFmxdlv7cuUY
         K8PPwPRWcqFN4n07glFVkl1duUaDsEWPe6N/MdFNacVkBJ0AKkF2qlYb90VmTBCnaBYo
         uuMKGFN1p19YBjJq0mL7gNH+I2mtCN0wt4vwrIZyFS2o2YRCjwVmEe49pWZZuKy7mvoI
         gCqA==
X-Forwarded-Encrypted: i=1; AFNElJ8D4/PYGZ8xni6antmcuHb4Vnjmguog71TvY78KImOUiQXD3NBhS72YjD7dp4uLcGxlCLjKtdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys+sNUrKrkHCAVS36IdalbwKjzhCJeDq910KGhZEM4+oEkSefh
	ZWQhQLKW+5jhe1FBtrXIcfo2FOPGoqOtqSaG51YePOfsMQCxFZngTm+I6WPmFvw2Izi9GxIPFis
	7WIuO06Izn3qlys8weg==
X-Received: from dycpb7.prod.google.com ([2002:a05:7301:9c07:b0:304:e89d:c06b])
 (user=tanshuhao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:8185:b0:307:26a3:75d8 with SMTP id 5a478bee46e88-3081ff40831mr2404473eec.1.1781285813469;
 Fri, 12 Jun 2026 10:36:53 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:36:42 -0700
In-Reply-To: <20260612173644.380972-1-tanshuhao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612173644.380972-1-tanshuhao@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612173644.380972-3-tanshuhao@google.com>
Subject: [RFC net-next v1 2/2] selftests: net: Add kthread preserving test in
 napi_threaded and busy_poll_test
From: Shuhao Tan <tanshuhao@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
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
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:tanshuhao@google.com,m:almasrymina@google.com,m:skhawaja@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tanshuhao@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298755-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DDC367B637

Add testcase to ensure the kthread stays the same across NIC link
flap.

Add testcase to ensure the same kthread can poll different napis
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
2.54.0.1136.gdb2ca164c4-goog


