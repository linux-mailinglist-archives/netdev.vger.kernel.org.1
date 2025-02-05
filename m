Return-Path: <netdev+bounces-162812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ABFA28000
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 01:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B805E1888047
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7170E25A652;
	Wed,  5 Feb 2025 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzle17QT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9685173
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714262; cv=none; b=EvJdMnw//g0MKGZMPNYkyNRHZ2teaMMnDowavU1LykhhgTpb8vBTmiOS0mg8kQREIFqGe59LsBb+oFS3KY+XHPSj2TtRYOnlU9bIRWFiVDZK2oFCTHKESsPQtHW7QQYuE+qXgHQ/QR+BEYBDE4qsE5dCmgxaWP6JUB9BL8mxDUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714262; c=relaxed/simple;
	bh=AiVG/9rO+Mccot2xBfYlRHIcLJPs5TaZbdGL/nCuPQQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LMqeomN6Jwqm85sPsySv21rsGjTj3bOqu7BgfFpTd7pBT/ckVgy08qmiC2Yyoh7HdlJJz6gwHSWWlji3tB0i6kFB7qJv8azi46pxko4IbLB95JPbH8yM/5KEZR5N7AGhAsfiCGfhPr8GxhKqKy1rccE4O0zZqwCSlEal6tD9lss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzle17QT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f9c1b95ed9so3968884a91.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 16:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738714260; x=1739319060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CPbkx13oTcOZX9OHMPOw2/BKbIzs1tWcDA26CEsjMbg=;
        b=mzle17QTcQ1s56rO+3LwsJzNVkP0Ll0O9Fbao90exYZ+QizSsl4cPZQ8P1CTNG0N3O
         5Jh9E8ty4iVKQmT2qFdDmBlYZbkiPLxi/QN5NnC1KGLhnkdFyDYeBd/ubFKqMqnpplCB
         fpE1RrUcIa6EvNvzsirfBMpjN73+EwHO/FAPRURt9PhiieeF7u5X4e7e1ltCFlcCzwM9
         Ht+bKxfFSd2dDL64I9wk+6dh6xBNxPPp9VIuOvUWeb6BFBM1P5F/8U5Urq+3WCPWo356
         oBf/sfgRMpeRuQG+FtCkVkBsoh2LTMD1S4B+j4uLzkO3vjHMbxFS+FjI4y+tBwuY6N/q
         b9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738714260; x=1739319060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPbkx13oTcOZX9OHMPOw2/BKbIzs1tWcDA26CEsjMbg=;
        b=g8B12xwXC5+8iJj0Wh2PUg0Wr/EIFDmBr3WutpzzrOdoIuSn13g+qXXF8FwD6gKbne
         pPP/tdR8iQgBi/LmTLYBcro976Bs4PFmPV7OSSMwZVdfaqnFtNCmnxpUV2sNCoc0gKm7
         /ekvFQcAU4XJzHIiTHAsnQKvTwtmJ4X3nVFbAsprgASVDPEGHZfDMCKVNPl3f8u2PBM6
         /4QO+cS19p18Y2AsxH64Y30h0tz8Q0NrLglPKiA0eAeD22YbzFIQOMIKtOC/2kAkxqzJ
         XDAR0exNFuvJ/BTmBvt6pv7d8A4Sn+RfXyiS0DZXJ6XvQy6xUEipmxiQHNagG0/QeSsW
         gZNA==
X-Gm-Message-State: AOJu0YyoAmtNMudwzBY96hWOJnfWZeit4a/lYki0++/0lbccjM+yQLeN
	Wt4ZMRt6Mdwrz2eGwH6bL/tFs0mtZqLbPnYcM+LKKzxHa47yA71NEuPSAmhTVGtNef9QiEV+q3Q
	XL2aTy7SKdQ==
X-Google-Smtp-Source: AGHT+IHMIsxUDhBj7fP3ul7LHaHVQu/zqUFU9rM+5BQOw2IsmEfnhBnwPysVkj/IQ9ubmSR2u5R/u9PxAQy5IQ==
X-Received: from pjbqa1.prod.google.com ([2002:a17:90b:4fc1:b0:2f2:e8f5:d7e8])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:33c4:b0:2ee:59af:a432 with SMTP id 98e67ed59e1d1-2f9e085130amr1025814a91.31.1738714260093;
 Tue, 04 Feb 2025 16:11:00 -0800 (PST)
Date: Wed,  5 Feb 2025 00:10:52 +0000
In-Reply-To: <20250205001052.2590140-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205001052.2590140-5-skhawaja@google.com>
Subject: [PATCH net-next v3 4/4] selftests: Add napi threaded busy poll test
 in `busy_poller`
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Add testcase to run busy poll test with threaded napi busy poll enabled.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 tools/testing/selftests/net/busy_poll_test.sh | 25 ++++++++++++++++++-
 tools/testing/selftests/net/busy_poller.c     | 14 ++++++++---
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/busy_poll_test.sh b/tools/testing/selftests/net/busy_poll_test.sh
index 7db292ec4884..aeca610dc989 100755
--- a/tools/testing/selftests/net/busy_poll_test.sh
+++ b/tools/testing/selftests/net/busy_poll_test.sh
@@ -27,6 +27,9 @@ NAPI_DEFER_HARD_IRQS=100
 GRO_FLUSH_TIMEOUT=50000
 SUSPEND_TIMEOUT=20000000
 
+# NAPI threaded busy poll config
+NAPI_THREADED_POLL=2
+
 setup_ns()
 {
 	set -e
@@ -62,6 +65,9 @@ cleanup_ns()
 test_busypoll()
 {
 	suspend_value=${1:-0}
+	napi_threaded_value=${2:-0}
+	prefer_busy_poll_value=${3:-$PREFER_BUSY_POLL}
+
 	tmp_file=$(mktemp)
 	out_file=$(mktemp)
 
@@ -73,10 +79,11 @@ test_busypoll()
 					     -b${SERVER_IP}        \
 					     -m${MAX_EVENTS}       \
 					     -u${BUSY_POLL_USECS}  \
-					     -P${PREFER_BUSY_POLL} \
+					     -P${prefer_busy_poll_value} \
 					     -g${BUSY_POLL_BUDGET} \
 					     -i${NSIM_SV_IFIDX}    \
 					     -s${suspend_value}    \
+					     -t${napi_threaded_value} \
 					     -o${out_file}&
 
 	wait_local_port_listen nssv ${SERVER_PORT} tcp
@@ -109,6 +116,15 @@ test_busypoll_with_suspend()
 	return $?
 }
 
+test_busypoll_with_napi_threaded()
+{
+	# Only enable napi threaded poll. Set suspend timeout and prefer busy
+	# poll to 0.
+	test_busypoll 0 ${NAPI_THREADED_POLL} 0
+
+	return $?
+}
+
 ###
 ### Code start
 ###
@@ -154,6 +170,13 @@ if [ $? -ne 0 ]; then
 	exit 1
 fi
 
+test_busypoll_with_napi_threaded
+if [ $? -ne 0 ]; then
+	echo "test_busypoll_with_napi_threaded failed"
+	cleanup_ns
+	exit 1
+fi
+
 echo "$NSIM_SV_FD:$NSIM_SV_IFIDX" > $NSIM_DEV_SYS_UNLINK
 
 echo $NSIM_CL_ID > $NSIM_DEV_SYS_DEL
diff --git a/tools/testing/selftests/net/busy_poller.c b/tools/testing/selftests/net/busy_poller.c
index 04c7ff577bb8..f7407f09f635 100644
--- a/tools/testing/selftests/net/busy_poller.c
+++ b/tools/testing/selftests/net/busy_poller.c
@@ -65,15 +65,16 @@ static uint32_t cfg_busy_poll_usecs;
 static uint16_t cfg_busy_poll_budget;
 static uint8_t cfg_prefer_busy_poll;
 
-/* IRQ params */
+/* NAPI params */
 static uint32_t cfg_defer_hard_irqs;
 static uint64_t cfg_gro_flush_timeout;
 static uint64_t cfg_irq_suspend_timeout;
+static enum netdev_napi_threaded cfg_napi_threaded_poll = NETDEV_NAPI_THREADED_DISABLE;
 
 static void usage(const char *filepath)
 {
 	error(1, 0,
-	      "Usage: %s -p<port> -b<addr> -m<max_events> -u<busy_poll_usecs> -P<prefer_busy_poll> -g<busy_poll_budget> -o<outfile> -d<defer_hard_irqs> -r<gro_flush_timeout> -s<irq_suspend_timeout> -i<ifindex>",
+	      "Usage: %s -p<port> -b<addr> -m<max_events> -u<busy_poll_usecs> -P<prefer_busy_poll> -g<busy_poll_budget> -o<outfile> -d<defer_hard_irqs> -r<gro_flush_timeout> -s<irq_suspend_timeout> -t<napi_threaded_poll> -i<ifindex>",
 	      filepath);
 }
 
@@ -86,7 +87,7 @@ static void parse_opts(int argc, char **argv)
 	if (argc <= 1)
 		usage(argv[0]);
 
-	while ((c = getopt(argc, argv, "p:m:b:u:P:g:o:d:r:s:i:")) != -1) {
+	while ((c = getopt(argc, argv, "p:m:b:u:P:g:o:d:r:s:i:t:")) != -1) {
 		/* most options take integer values, except o and b, so reduce
 		 * code duplication a bit for the common case by calling
 		 * strtoull here and leave bounds checking and casting per
@@ -168,6 +169,12 @@ static void parse_opts(int argc, char **argv)
 
 			cfg_ifindex = (int)tmp;
 			break;
+		case 't':
+			if (tmp == ULLONG_MAX || tmp > 2)
+				error(1, ERANGE, "napi threaded poll value must be 0-2");
+
+			cfg_napi_threaded_poll = (enum netdev_napi_threaded)tmp;
+			break;
 		}
 	}
 
@@ -246,6 +253,7 @@ static void setup_queue(void)
 						  cfg_gro_flush_timeout);
 	netdev_napi_set_req_set_irq_suspend_timeout(set_req,
 						    cfg_irq_suspend_timeout);
+	netdev_napi_set_req_set_threaded(set_req, cfg_napi_threaded_poll);
 
 	if (netdev_napi_set(ys, set_req))
 		error(1, 0, "can't set NAPI params: %s\n", yerr.msg);
-- 
2.48.1.362.g079036d154-goog


