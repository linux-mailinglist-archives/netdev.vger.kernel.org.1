Return-Path: <netdev+bounces-218070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAD8B3B051
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997157C55EA
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A8A1F09B6;
	Fri, 29 Aug 2025 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlAWG0Dk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3471E32BE
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430174; cv=none; b=gA7NXr1jcwg0bs7cXJSYEvesgTfv1z/QRhOuh71ANXqg0pcaDMGPGsAlDxQR+J+bcZVgtYSPcucu9rG4lzBjpzJtTmpJf8Ry+IsP7e26J6PTDxYCuvlalzW33FuRMfYPF3GzdveN9+RFdQ8c9h1WPH+4wbgtMqxIidxRLFms2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430174; c=relaxed/simple;
	bh=v6G8u5cFdgIW4ciUeyF8ql8KUteAjf3+8b4+VoRxN0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pS2OTRhYraDPC8KnvcpEQT6ORHZ49JbIYni+nq3b3V0DbVng5clFM3JkO482zURTAAf2UUna9eP5sLyPMPfWtQDdGQiiNgBJZJVt3D2vBg3gbSqmiUcKOHTO13ot19Q4cvSfGCT/u6JBsHRsi4yl21idAQlTJ7+40c2wIREBz7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlAWG0Dk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327b5e7f2f6so1647980a91.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 18:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756430172; x=1757034972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQudhG9icTbXxO5b3nuYC/0+0frWQg0bahg9lGITbdU=;
        b=IlAWG0DkMxsbNfIWhbJw7wbBKOvED/7LFxwZ4hv7OEp/apwR3YYzKpYJgtns4UfdA0
         kklEQ597lwT7REXNm8kCydNsEqgRfuNFaAfMI58m98CuL/sCFMEEBlnGUv78gjOt0BI0
         olYPX3syMCvtsg+KeRQb17ky9eeKqP/o1GfjIIqFwCQG7tGdObc049BONcG/JZ+TFaRC
         amLOutIBsxUnoMz7vfCe4MEH6mhJ9KDIGXljocxyWhNwRKdFojO9Gp6kbj5yhrxsrAid
         n4l0/+1lc0UJG/X0f4hbn1GBIeRTb6CUKSvCIanEfdeE1//PBpsAU7BpyFiOFYSEyIid
         GsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756430172; x=1757034972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQudhG9icTbXxO5b3nuYC/0+0frWQg0bahg9lGITbdU=;
        b=xQmVzHm4rZHmQm2FDj4WlOetJQxgjy5UHLLYy2gmmreuAxS2Pj+dYZB5R+oTEt4lnJ
         WrVmDcs4iDMqTlqQgMIzfVDUspfHgTRoiPWVbVntBz2Smrqkib9E0cKgCwJ9pPiz84RU
         G7bxwP4xLlb5Q2DuIyekzSvCvRKOJe8YmuJyGIAkg3j2C81X2KHtAwmoktxx1VqkwJS3
         l7qEQAiJQ4AZA8wYBRF7ZByPum+4e4ZJoNBXJpmICzvD69lLMAjM4RFSZAFlJlQ3HUBc
         6BP+1JSGi3B7lNwwXjXPHqEeqK9VnQlwMEtItd90MmgIDmCk+zDKLxw6EaYe7rpioKUG
         86zw==
X-Forwarded-Encrypted: i=1; AJvYcCX0aaJptgSg6XwScnBnkJ4sU6/fzj4GEPlfoKcjgpAcWtRNbQMP4gp2WtIUIah5euN9e78GDlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8+KX1bhf96SXIHIlT18w2cLCdnp9G+0j6339b0KyVowotkD4
	b/4XYYqEt+KMhdC/vqVo/5AVihYJjnAcUU5hq0uhUTrk389Wpw/a0t4QIUueRUMOF2BKnZ+aFKV
	j99B5cpuEYf52og==
X-Google-Smtp-Source: AGHT+IHN4LSteaDp6wAWJJ7NJ3XLrkVR1hbp+hl8WZiSXnOpgfyE8Yz7mgflTCezCfOTSlsPbQh/kQ8QOeZVww==
X-Received: from pjbnc7.prod.google.com ([2002:a17:90b:37c7:b0:31e:d618:a29c])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fd0:b0:325:c92:4a89 with SMTP id 98e67ed59e1d1-32515e3cad8mr29449301a91.5.1756430171667;
 Thu, 28 Aug 2025 18:16:11 -0700 (PDT)
Date: Fri, 29 Aug 2025 01:16:06 +0000
In-Reply-To: <20250829011607.396650-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829011607.396650-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829011607.396650-3-skhawaja@google.com>
Subject: [PATCH net-next v8 2/2] selftests: Add napi threaded busy poll test
 in `busy_poller`
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca
Cc: Joe Damato <joe@dama.to>, netdev@vger.kernel.org, skhawaja@google.com
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
index 04c7ff577bb8..46401d5e01be 100644
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
2.51.0.338.gd7d06c2dae-goog


