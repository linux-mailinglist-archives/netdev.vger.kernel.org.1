Return-Path: <netdev+bounces-208273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FC1B0AC89
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B13A5A5197
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3C8230264;
	Fri, 18 Jul 2025 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuw4SjVH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D112253BA
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752880863; cv=none; b=XjoNH6xluXf8ck4dJInUcK41ttOXLrg9ZJLHg1QvgbM9Og7uKkLnq/34vpEV8Yjr8Fo8kKKhXAVthSj1xGdEXAGQTMX8+CjBwBQx2kyJSvAVe/gl7lvdqoM02Gq3YJxNuzXrvzixWpB1ZYUySBNEA63OQIxxrUQCJ1Ru4lqIxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752880863; c=relaxed/simple;
	bh=rQaABnBd6jZfBxNMAx6h6ZJ3JGF9bjF08Fhctht9hUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZNmTO8Grh7lXWkBldEE16y6P4i6KDtIxRYklfLDFPAyq37/I09ZicO/SFHt5tIjCyBPLIrmXXpPlOh2/WZ1JrEdIQM1g4TSwA/8vjkEQrMAeoTF37PmQQn6H/Nygc3tP3GEKg8Jmct4dTS6fr7iZreJoCO78E7idgyfBRu/UScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iuw4SjVH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b362d101243so1964389a12.0
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 16:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752880861; x=1753485661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbWHJAwy1tawpL9VMSdIi8E11vKPUuO0bOl5t00oi1Q=;
        b=iuw4SjVHwYnzgWlAjAkBmpxyyZKqOP1DuygwKKdYkZ1RwLp5qwvBAXwIj/n8v7WcLn
         0lJcjYclj5NqTK/Ipl6nYKYRCNWHLt1GUmq4clco5mlbbLj5JNmQAhv4urQh44cG01O6
         JruTTvh/mWTmTgH/BulrOvRae59qEfOKGNng00bmKIDAFPjlV/Yd01OXZfr+PaQp9ydg
         eKp5bCLdNg1HqCEdzJk3d0Jzh/MbOAgVhU05NUyri8NPoMzqi7h7BDUUlw7uaS1S+mtV
         +TF3PzFZ1YuGsfRg0P4sL2hhe9JlWmbj+eSdQozxvseX2A4S/B9KFAPZ9z2K9xJxwfaa
         kNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752880861; x=1753485661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbWHJAwy1tawpL9VMSdIi8E11vKPUuO0bOl5t00oi1Q=;
        b=GaRuaLqJDhuFG3VDxqI6RIS0KxkVN2XGxzD0dAzGCtTOfzJ6lETRMIRV284LVqlGSN
         GV+y4gFa5g9GYaaSlHGzKhBpC4bYcKr2fd1oVehYhIlsbc/f9rGMZepdut8WsdPO/gBN
         +VND6TiPY+yO3jiGoL8YMiDFOsLLlzprXWPGaOZBL0hgaFzBcCgi5KRtPwSy2oa3oAwv
         XSGI6LsYDo7BMBECxjp90xfScumn8RD+hpzqpCT4PYY7DK+fa3kfrjFLR1AXpYfTIKXj
         Nc6yNc2naEQf5aYiSAWRkuBCT9tQSZRKRwCO0gCbvvvL01f0Mz+jg/hH+giTvUkZ8Irc
         zzVg==
X-Gm-Message-State: AOJu0Yxsb0S1FTOY3tcusDqBF9hAYvZGzrt9rdsDmKcvSo6JiSENE8Tw
	zjKdQ5/Yza+3Irkg21+xJE/G5hOVqvQ1W5MwyEOditidPnD1rAqgtdwQsCZTkYChopO7dop2kly
	wyNWJ389vH7g7OA==
X-Google-Smtp-Source: AGHT+IH1Lh9JTObDy7Ij1NbY+cA8dZ6pYKMRDJpwQUVWlyiVBFsnF2UUtSbkJw6RxlqPJBmrlVw9qwNm0HMlnw==
X-Received: from pfoo21.prod.google.com ([2002:a05:6a00:1a15:b0:747:a97f:513f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a10f:b0:222:d817:3578 with SMTP id adf61e73a8af0-23813355721mr18341129637.36.1752880860835;
 Fri, 18 Jul 2025 16:21:00 -0700 (PDT)
Date: Fri, 18 Jul 2025 23:20:51 +0000
In-Reply-To: <20250718232052.1266188-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250718232052.1266188-1-skhawaja@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250718232052.1266188-6-skhawaja@google.com>
Subject: [PATCH net-next v6 5/5] selftests: Add napi threaded busy poll test
 in `busy_poller`
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Add testcase to run busy poll test with threaded napi busy poll enabled.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>

---
 tools/testing/selftests/net/busy_poll_test.sh | 25 ++++++++++++++++++-
 tools/testing/selftests/net/busy_poller.c     | 14 ++++++++---
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/busy_poll_test.sh b/tools/testing/selftests/net/busy_poll_test.sh
index 7d2d40812074..ab230df1057e 100755
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
2.50.0.727.gbf7dc18ff4-goog


