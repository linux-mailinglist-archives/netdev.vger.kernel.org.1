Return-Path: <netdev+bounces-233648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56FAC16C7D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF001C24D9E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4666B34CFA3;
	Tue, 28 Oct 2025 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hVJT0B4/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DBC2D6E62
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683414; cv=none; b=K8d8TAGcsT7Xodrv0SsDoCIV6HTDTRVtepTnUjEFlyAwgqYGXMZkMcGyxLJl4V1GaTaseBq3QNUPmlLidVtNkvwOa3NuvW89yMwtZciuLIM3gB8/C5/jV0+um/KcRRpX2Re2pEH4AgJPT0wRO09Vs48YKK4mLTjsoS/1kM/Rgj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683414; c=relaxed/simple;
	bh=qGyFO386U+kmYqETXmE7yfFZ0qYCyLX1HVIuqhVgtKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vnh/59kQbyJ9a05cUAlgp6sn3G0EZ60UBlNddAPLMLinzm53EqUSDgI1RHnCE03IIMXzKUyTcBA6F4Qm5wAaTQD+n7XvP8gJ77I08IaSOsjYH6RaweA/Cg0M20/fIItBL3SAjQObuKAPjdDG9W5z01Rn1tBhFOLzAlcl+x/ZxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hVJT0B4/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6cdfcb112bso12426674a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 13:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761683412; x=1762288212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6QlLBK1dO279KLObKzPUpdI8BqAf/SLckVAwoN3WEgU=;
        b=hVJT0B4/um364w+64y8HpKzBYFo2HPFlRlul2rDZ3/Poqrqv7mkpjyQOOeZzNUSkmC
         MOq4v8Z+iUGxW+scVTcRwgs5V4w3HZvwz8RgU+2oVxdM1zzQnt6HAIa/Z8q9hGbBtsEj
         zNO+FQnyquuoIzH/PjLtGvigQzIkPI/Wp19t1Bc82AEcjzRJroLgfef/t1hOqvdm87tM
         rFCyflvlfjC8qeQZ80HZXEsiTcyi41DRc2uV3VZ1mpoUYWoXrC96Gv5JghHzyPdTHKIL
         BPPjMVpL90Fovl8X4IQ57evG9UG9VlIJeYyt1oap5qsZqkAlTy/vQQsRJozp0thu9Tpw
         jhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761683412; x=1762288212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QlLBK1dO279KLObKzPUpdI8BqAf/SLckVAwoN3WEgU=;
        b=CQsbtaiti/+FZqwvKI+TjNEA90wJswIfSs4nyqJs5Y2ZcvPDzrrl7YQaI6LsSyIH9n
         FmL/TTYPts1DSzYRC/rmMlkvWpBt5iy3K+DBSw0hxJJXptzVen+eKFIGsbA/c/YnilQH
         EFCKxtGDnY/62ifNCmTtMfMXJWYzIX26HcKWCGb+wr3L207kgcGbhTVwmFB3qor6dBcM
         3rHP5XHH79e/4omxKR1LcIGx0mz6h+0VdWEe05NI/BTLmIUKFs7CSIEMYn3RYE02Aqaa
         xMRDvOQfSzKtQmWCyoz+s9T/yqUA3ibNPoxYtk3Fu9QTvigve53RGG/Cr+zfGVnRh6fP
         GqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOJCOoY7sYjlW1cXYHx/9dAQ0RrdFNjsZPieyTei96hH2aQa3hRpOMHT/6obw0mHzjRCxbtGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVitXQuvGDM0ouPoQGxyhH36RDrHOOzIg1ErtjJSV4HW2OZNPm
	qVuiHZ/SBbGgnuGLx/xj7/3KIpwiwdf4sEswURN3I9Q6AGXVzjmcXt9ZpWVfoeO0lNnMKGciBsN
	/FxHqFMKknrsA2w==
X-Google-Smtp-Source: AGHT+IFXim7aLw6aynthOgMnNQNOfsDFkNt2r/feRdZClo3i696CJNaTX5FHbL0yH+UqwtoNJVj2J9I7L2PQ2A==
X-Received: from pjbft22.prod.google.com ([2002:a17:90b:f96:b0:32e:d644:b829])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d1a:b0:341:8e52:4ca with SMTP id adf61e73a8af0-3465798aa5cmr263464637.5.1761683411795;
 Tue, 28 Oct 2025 13:30:11 -0700 (PDT)
Date: Tue, 28 Oct 2025 20:30:06 +0000
In-Reply-To: <20251028203007.575686-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028203007.575686-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028203007.575686-3-skhawaja@google.com>
Subject: [PATCH net-next v10 2/2] selftests: Add napi threaded busy poll test
 in `busy_poller`
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com
Cc: Joe Damato <joe@dama.to>, mkarsten@uwaterloo.ca, netdev@vger.kernel.org, 
	skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Add testcase to run busy poll test with threaded napi busy poll enabled.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/busy_poll_test.sh | 24 ++++++++++++++++++-
 tools/testing/selftests/net/busy_poller.c     | 16 ++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/busy_poll_test.sh b/tools/testing/selftests/net/busy_poll_test.sh
index 7d2d40812074..5ec1c85c1623 100755
--- a/tools/testing/selftests/net/busy_poll_test.sh
+++ b/tools/testing/selftests/net/busy_poll_test.sh
@@ -27,6 +27,8 @@ NAPI_DEFER_HARD_IRQS=100
 GRO_FLUSH_TIMEOUT=50000
 SUSPEND_TIMEOUT=20000000
 
+NAPI_THREADED_MODE_BUSY_POLL=2
+
 setup_ns()
 {
 	set -e
@@ -62,6 +64,9 @@ cleanup_ns()
 test_busypoll()
 {
 	suspend_value=${1:-0}
+	napi_threaded_value=${2:-0}
+	prefer_busy_poll_value=${3:-$PREFER_BUSY_POLL}
+
 	tmp_file=$(mktemp)
 	out_file=$(mktemp)
 
@@ -73,10 +78,11 @@ test_busypoll()
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
@@ -109,6 +115,15 @@ test_busypoll_with_suspend()
 	return $?
 }
 
+test_busypoll_with_napi_threaded()
+{
+	# Only enable napi threaded poll. Set suspend timeout and prefer busy
+	# poll to 0.
+	test_busypoll 0 ${NAPI_THREADED_MODE_BUSY_POLL} 0
+
+	return $?
+}
+
 ###
 ### Code start
 ###
@@ -154,6 +169,13 @@ if [ $? -ne 0 ]; then
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
index 04c7ff577bb8..3a81f9c94795 100644
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
+static enum netdev_napi_threaded cfg_napi_threaded_poll = NETDEV_NAPI_THREADED_DISABLED;
 
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
+			if (tmp > 2)
+				error(1, ERANGE, "napi threaded poll value must be 0-2");
+
+			cfg_napi_threaded_poll = (enum netdev_napi_threaded)tmp;
+			break;
 		}
 	}
 
@@ -247,6 +254,9 @@ static void setup_queue(void)
 	netdev_napi_set_req_set_irq_suspend_timeout(set_req,
 						    cfg_irq_suspend_timeout);
 
+	if (cfg_napi_threaded_poll)
+		netdev_napi_set_req_set_threaded(set_req, cfg_napi_threaded_poll);
+
 	if (netdev_napi_set(ys, set_req))
 		error(1, 0, "can't set NAPI params: %s\n", yerr.msg);
 
-- 
2.51.1.838.g19442a804e-goog


