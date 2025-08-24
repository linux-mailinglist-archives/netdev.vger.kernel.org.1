Return-Path: <netdev+bounces-216334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1228CB332E5
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 23:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702CC3BD740
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF8524A044;
	Sun, 24 Aug 2025 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LH6sIpfW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9421B224244
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756072465; cv=none; b=VTo8jbRXy3W7pkNjGHNf6KPqIUz049mroV2bDJnGMdwRbsnbHnnbzrf56vOlykZlFVMOuJiGrumP0go2VJm26gXdcGtSqV/cLRUdrYTZ6r7PpHc0ep5c/HWT3ow8G9LygPCw6cU1SSXC/TJLaxwP3VPBV2SSlr2xHrPZKjmIt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756072465; c=relaxed/simple;
	bh=+OmDIt0K428THjh4Z4TVMvO7jaL2IvlA9mhj9EVSX2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O2aUZZRSAYUiybJAxJzRRWbscPK0xTT7uYb4X968GRnPMF8RBXrnTt4DLCjqp3I/HJgOLsasIW2hu3sVC0WejqzcZGMx0htl1SQopiK2vfswkcCZchdVpf6ml58fyyE8xq7A4dkZp2LwJ+azAKiC4M2cbFuUCsOTs/HJG8fGjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LH6sIpfW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174c8fd2so6150819a12.2
        for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756072463; x=1756677263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Mri/jtNOLBKBbuiyvlad7TKi8IcKKrXpfWr2xd4/9o=;
        b=LH6sIpfWNaPAbh6h29YKjyUss6hIckZtLj4Rwmld/Vj3TbKonsHs/Grfv/zokMquup
         Te6QZuZmcQ2E4r1mJGmHvuJw9N6FSb+Pq8zWknF75+gr2VVDxb7KHoRNvrE7BWR6Ulv6
         sIXjXhl93qIttq81eL/1z5n6/G7iyjFz/LcJIQ8YNbbhLXm9Upa97fWMGe8AuTGnbjx0
         ErTGNeG3y3MP85YWTLHC8lDHG+iTERQ4L3K/fnVCjBcoNbaMw1cnIsUMYUvhy1Zp4spI
         W/nhD+lGXQv+x9H/haluJQ5/vRaUFP+DrbywDLChfZsEIHeBLuVBKWxhxFdbNgZHE4mG
         sp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756072463; x=1756677263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Mri/jtNOLBKBbuiyvlad7TKi8IcKKrXpfWr2xd4/9o=;
        b=Te1HWbq1lFPvRyssN36oN5FcCrNpQ2n6ZxuiNiNxTVnJbqq/RY7A5l3Z29n0kM++t/
         bPimxJhISVwsIu/2yYvmrSW6kc/IxWnzKOW1KcwdXPcuXd/Hfw466CKNPoZcQKT6KLep
         8iNjYZw/jsKvZfl7HMgl4ATj55WxaeLdGrdadyv6iE7KZh6sfO7eQ1WmceB/I299eDw/
         qotiFbsYqrlV5gQtED7oGa45BObtUsaVoUm8JSUnNOQvcGen3LkiejD41iIKcqa067AU
         lBWq04E2eiGkfrt+LlylIq0kIxrIoK263NM83DnKoRcqnoRI8F+j3dy68xJCm2vxhX3l
         kuhA==
X-Forwarded-Encrypted: i=1; AJvYcCX7LQ1ERZYMXLfV4PLyc/8fQLFjXnjAXZUfVPKR0MrF/H2+SRy9hJnSMhZvcOCPLVtC3bpVdnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuUMgDy2V7b0fxzOAt0Lh132kw/Xl9Ztaq+2moUhjsRNxIJfB+
	pbtgjMKSaQ69Q8rUFHUhIM+Hv6aZ+83eIIzW/1Rdb97Gaw0YEseTMm6xleKy6LcpkEe0BZIhVrm
	3P1jKeh9pnYKq+A==
X-Google-Smtp-Source: AGHT+IEkGz4UiM95aKZlqUyv1wNYo0QNmYqOkDxhj/CIQGjqMUxE+JxVAY7TbV1PpeQ5NpzFpUmvXmXTFSz1QA==
X-Received: from pji6.prod.google.com ([2002:a17:90b:3fc6:b0:31e:cee1:4d04])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:12cf:b0:240:750:58d with SMTP id adf61e73a8af0-24340bc9941mr13735201637.27.1756072462836;
 Sun, 24 Aug 2025 14:54:22 -0700 (PDT)
Date: Sun, 24 Aug 2025 21:54:18 +0000
In-Reply-To: <20250824215418.257588-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250824215418.257588-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250824215418.257588-3-skhawaja@google.com>
Subject: [PATCH net-next v7 2/2] selftests: Add napi threaded busy poll test
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
2.51.0.rc1.193.gad69d77794-goog


