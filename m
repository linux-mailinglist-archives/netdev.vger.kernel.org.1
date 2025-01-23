Return-Path: <netdev+bounces-160680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4414A1AD22
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 00:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29364166411
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 23:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FB51D5CF2;
	Thu, 23 Jan 2025 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivANrdgf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2331D5AD8
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737673965; cv=none; b=DahrFyrKEQD6kJSyW2LnXMI8p12cBvE40ccqAwokk02om1ZWYJJe1S1sQ8bzRLLGVuRwhzx6PbGbpTe23hF8Qh+8uHQFoLHUgN15Iq5YlAOR7OZganodNzLKZgxJ78v7StRvpcEUWfT+MjaXwHry7FqNd35J3N4sFArbmtUSA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737673965; c=relaxed/simple;
	bh=172Kk9RdKO6Ntth20RvJAgF6oxpCsPrh3O92h4h98ic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RXZ1JEfNdqVPW/9R/H5TF7xTzcsZa/0x4Ai5PMDTDcY/gZIcz5KvWuNX7dWSrDQFz+KcRqc/bdVigWPxxzbuozvzebz7De017DbOjIRSAnvZucbMQAhcf03E9elw/zeSNMwWALiV9u/iVPtLwIT2DxnyjkIm4SJAq9tzTRI0jgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivANrdgf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so4213969a91.3
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 15:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737673963; x=1738278763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYPNvZTUoIwJrSMLoTHaNaezqP1C9WRuC6S2ZKlVyFk=;
        b=ivANrdgfRncMbKDDuYI4dVTMA/hwZ+1H/OedfulTHE/liRy108o9yoArkkj+onxSTq
         N7gx102VWuXwucibO5VoHk0xCNh8cqW9azfLMAsPlji2Rs6+XJZWmUNR4zAi5YF2uBEL
         WVu6ns07Td/l0sa3cVrNWjHNlMSBGojSO44Lq1Lm2cIFBmIDm4Ye/C4KORjW6DVhalTw
         rcICYpsuUYcTal44OilTvzUNlxMseEOzGv5SQWjqI5NirMvn8x5uWZzcU+ZQhNteU7XA
         Y4VabA0szkAGqomkixN4zwixX+SGmLUImhA0s9dPfU44fApdlnLX0X31n9pPj53Zk9w5
         pItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737673963; x=1738278763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYPNvZTUoIwJrSMLoTHaNaezqP1C9WRuC6S2ZKlVyFk=;
        b=SC8pvtLhbrQsUNMvLp5zTKyNcx9jpd2TiIAfa2Qivuu5Th2y4YRhFl+4j0v7076E4E
         5aC95C830XnQS86Dq9dYRXVEbf0DGCxw9ApiiEnG623QnXeBMHkPbwgECP+jm0xopp7G
         ejpThEWzJkJwyuNSdxDoIGSpc9dlt4503F2WjXCypZM2EIwSwYyRfB55WBC+e/rn5mlA
         bQWqFUuEGZh4ObWR71ZNJsU2g/ydO7Eu4W0UHlPWdGIhOvhFKw4WDysM4lcD154uvCb5
         B/k38abCJIYWp7VZLapW0GCnsd6Jz18NbxQqRaL68mJdZeYfjHw0Az/HUCiW80CL9wdv
         V1JA==
X-Gm-Message-State: AOJu0YzP239nOvBDa8rfmF1K2ecbgJWLeOYngxhGTcCyosOH8+dfJK0a
	kjoWIeZ+NuFVADGi21cYoWh6NaAw99qu1LjnZTBx8fkOufewb/63NguCqWatoEh1ndTHnrd6IKG
	1XWcVW7eBhA==
X-Google-Smtp-Source: AGHT+IFfWesATEV3uzhlZYVZ22AMZRfwTZ7JgDJ4ilhj+5brJql7R6SAM+xlaAzFIg40x0EYZ4cvk4clWB9Dkw==
X-Received: from pfbcg7.prod.google.com ([2002:a05:6a00:2907:b0:725:eb9c:47e4])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a95:b0:72d:8fa2:9998 with SMTP id d2e1a72fcca58-72dafa44feamr42612736b3a.14.1737673963105;
 Thu, 23 Jan 2025 15:12:43 -0800 (PST)
Date: Thu, 23 Jan 2025 23:12:36 +0000
In-Reply-To: <20250123231236.2657321-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250123231236.2657321-1-skhawaja@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250123231236.2657321-5-skhawaja@google.com>
Subject: [PATCH net-next v2 4/4] selftests: Add napi threaded busy poll test
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
2.48.1.262.g85cc9f2d1e-goog


