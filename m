Return-Path: <netdev+bounces-176645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5126FA6B2DC
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 03:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E994487A18
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 02:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503521E47A3;
	Fri, 21 Mar 2025 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4G8b8LNX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A511E5B62
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523332; cv=none; b=YZrwl9X6cJBC9XNH2njqxvU7+7kog2fpz0JUEMDW7ki1sgG6PLuGedCeGJmzf3iFRtedAaTuEoXXVSApHQDSUXMudEnAecxvfq7LiQKQYxtF6c3Pg9QqyeDerAMHD4zL8gPX0G/SIOe+XUAgwIednWGKx7CV7wB94OX4wWdT3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523332; c=relaxed/simple;
	bh=7oUkBmJLg/7wYp9vE3OwGcGXYeQD+eD/8StBj7LkTsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hl2WIU4dFCAB3NbtHoyuiR/aTvVB8pLBhzMupb7QVRMO/bAmPLvlUP/z1hRp8saco+/JZt14EbQRnG1EbFsngzwgRMzZCahSw0Iv2iE/W1Kk4FmVub1WYvjr18znJne5CYDDA3hOlK/qhh4s2k07DZYSdy3cEzbSyZ7+Yze6ZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4G8b8LNX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so2217869a91.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 19:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742523328; x=1743128128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfHZQHWfTLkBAL38zUhu6EZQVch4Qlx9oNrQh6UOAFk=;
        b=4G8b8LNX6i+6aMyK//0QBGKmTWnzV5TvtvI3XKrdn342BSKc6p7ZUiFpxLkTU5NbzY
         GRjCkhXCtK77n8xA3bUNXYeqXjllpFzAxGwBVd3k3OfrFP9C7jr4agF68tiy72YKjODV
         /n740TNFEwHz1mmpq0StOgsr0pWt+Xp+2eNmO1yXm9QXAPr7RU7b+nejXA35lWqKLimI
         jSIeZgvd8o3NOPd977hwJWGOi+NHLwDKd1RpZbOjtoWyiH04I+j613ElvqeQnNe/mU16
         XDtsKE0VElvSgm3QhZ1vBY3bxUWeU1okzq84x5OW3Jzx+KTwcfeCt9tKN/4Km0q9vI+q
         b25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742523328; x=1743128128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfHZQHWfTLkBAL38zUhu6EZQVch4Qlx9oNrQh6UOAFk=;
        b=CA2/6AjhYWheJC921bWEhYxVegKxrZmFwTxDObfWpC9sfh1YbsrRgohryo//77LrTQ
         8YNRCPxAAdSAAaVCB7dxuaRMSmEqGZ45++ZUa/dm5HO9USjCmhaEw++gAqV3dXEivoWD
         Wf6XSthWZJfziLDN2ip+T/l/aul9xzEu1B/8yanM5dhqi0UxH5LTkMntYjwmzPQuvXay
         41rbWZpQHTEAWoiztH8sV/kuP8cr8nLuuahcUB5PFVT73DLnVmJGwuYMBMb7JIzeqIZk
         pqEl8xDB0hh2+e/IdaJHMkRoi6/8JqmexAkGel7mIm8/YMJcA3iMbROTQViuSMcCwYTO
         0PFw==
X-Gm-Message-State: AOJu0YzcD4D8D6GZof+We6jqr8cV3hI1g8fsjRjZRbP6L/PsOT8QihkT
	cjbO7hm90uJrICAGpbIj3C74mC2uR4OSubt8Ukm8W+7dZLz7KH7WBJcZm4e/bjNtYFco+NY2F+U
	s6t/39tVZVA==
X-Google-Smtp-Source: AGHT+IHpuQj+bU6J7ADoDnDiZb0SHr5Q8MpsS2+oXDq9bqXWlzQgMbiiX7T0HMPSVN6FbTeSmObLDaxEU5htaA==
X-Received: from pjyp14.prod.google.com ([2002:a17:90a:e70e:b0:2fc:1356:bcc3])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2747:b0:2fe:a336:fe63 with SMTP id 98e67ed59e1d1-3030ff10879mr2470792a91.24.1742523328321;
 Thu, 20 Mar 2025 19:15:28 -0700 (PDT)
Date: Fri, 21 Mar 2025 02:15:21 +0000
In-Reply-To: <20250321021521.849856-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321021521.849856-1-skhawaja@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321021521.849856-5-skhawaja@google.com>
Subject: [PATCH net-next v4 4/4] selftests: Add napi threaded busy poll test
 in `busy_poller`
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
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
2.49.0.395.g12beb8f557-goog


