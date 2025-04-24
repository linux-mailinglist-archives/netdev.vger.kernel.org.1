Return-Path: <netdev+bounces-185724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FA4A9B8BB
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C321B687B4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0601FCCF8;
	Thu, 24 Apr 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPPb8PV/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE6B1F91C7
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524951; cv=none; b=Fa0Suqmyz7LyFGj/EZ7jP1TSlvfS2brG+QdfpatCpmS4CEN8XEK5lPiwSVu0+cKhz7g04p6HAKg7kG5BpSAXozSb/Ko9jU4I7tIMT+hiNWmrDE+cHRCuS+NP4vjrCZMAsQ5A+RX20emzDlqesAL9mJRLRftIUfa0i2jbLvkXJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524951; c=relaxed/simple;
	bh=5INTacSeeD5pHwWRgLHBam/AsBOEkRynbd7THYTuXdA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=adbnKCfZcNYLfGirtKMSXEq6vMB5mP/0R36rddQWFvYPy8oLzzxiREemsCp2GRb2BoPnHfnaHerDb0IliSr6Ds7oTsYcaXBKhg/FDIQzFNN1hzr3HZCyeng6/DpzxVVNjMM1LCdoH8gCGRc+f+6rcfrPfWkv91H1L59Zx8Rbg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EPPb8PV/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7377139d8b1so1259454b3a.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745524949; x=1746129749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oyFAHo410p6RsaGtDevMPb2lxgUtdoffu9P3maZ2om0=;
        b=EPPb8PV/8i79pFd+bGwpyI9AJKV1Ha0fTTbmUd8famo17JnLGPi5K5crBFyh4YUqXy
         KMgWCvpLuayTQ3uw+mJTS2SUiQRdHcQfJYLyLkgrQV8Pwg46ZmBdFg6Uk8l12bgOwAbD
         dBkBIIv6DxLpSqDkC+Vf4RQP3hEQgblTl1v/X7l95hY/+8mcX6G5dmebh4brR9+Wk8q9
         Q4/dWQugaTsugxNT37v0Hj6Wd7iSJNOqaNX0B1UigwFJ9O2pmIBtix/Ik58G/pWDrV0i
         nMEYjf2NufZ7hY2To4olB1YbKJsair7pW6D35QHSBwQaKFvbzjZYcqZ97EO2fZ+FyJXZ
         gbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745524949; x=1746129749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyFAHo410p6RsaGtDevMPb2lxgUtdoffu9P3maZ2om0=;
        b=uwq4KTQKIia+62k/Ss+iMhIaeMJ63yGpWoWCX5mG3nWZvD1zRDf7NjGB0qU6YV5+HV
         mgrwgFFoVYMDVJpXdrF/om9cD3Rs1N8ygFqoKSbtI3aJQ1d8AIlJIQBLQnzj9ICgQ48K
         X0xnT34c1ANmnOkrx3ic/rCXbvxmEVirxvZu+zkeQ2E+GJAKMudbeOwuEe41ZrmydsBy
         aCVUB0eqDSFmcMsut7yq8qjTomVG9c+eYnA8jUBnWtqwvL+bfZjk+vr1Ilu0HDOfagTE
         +GU4NzIuAbFk8YWOrHYMZNDIYc3INU40OGfQr+tsSwEfLXgjmLYvNOZT25633f4l1kAA
         7zWA==
X-Gm-Message-State: AOJu0YxMsaBKQk/7XLl/kU6JLZTCr+0u6oAS4fonysI7OS33W6bjzfEI
	QPWyuzmIwdFvMAawie6SpHUqVlK8JFdi4m8RYE/olknKdA3FpnfZ4Mcrq12fFF1+6khoZWAkYJl
	ZLqCa2tgtLQ==
X-Google-Smtp-Source: AGHT+IGrdl6qRTIYViiHaj7FoI5cG9CogIw3wxLUBjWYdYTA+5u35SJaY1bLS1wJE+9xAKbIvs2/USdvG4JstA==
X-Received: from pfoh23.prod.google.com ([2002:aa7:86d7:0:b0:739:8c87:ed18])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:44cb:b0:736:b9f5:47c6 with SMTP id d2e1a72fcca58-73e33094288mr1280045b3a.16.1745524949331;
 Thu, 24 Apr 2025 13:02:29 -0700 (PDT)
Date: Thu, 24 Apr 2025 20:02:22 +0000
In-Reply-To: <20250424200222.2602990-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424200222.2602990-1-skhawaja@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250424200222.2602990-5-skhawaja@google.com>
Subject: [PATCH net-next v5 4/4] selftests: Add napi threaded busy poll test
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
2.49.0.850.g28803427d3-goog


