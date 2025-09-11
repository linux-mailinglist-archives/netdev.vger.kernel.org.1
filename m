Return-Path: <netdev+bounces-222331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0E8B53DC2
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140C21BC6079
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C172DF130;
	Thu, 11 Sep 2025 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBCZChtm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C12DECAF
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626148; cv=none; b=s6yIv09LKAHnj4d5QNS2o2qGApDgM0p8oGLvTkwWVCb1fib6sHKNCUzBT9bWlDZ7nVhdOx+aVI6WrL8JNmvvSw/V50Aq8JOplX+2XR7YJJjZu/ERJC82tin4Vs4L6RJu35dMpIzdx9jho/Is0hzRRMH+oCr7yms1VxB0Y+RXRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626148; c=relaxed/simple;
	bh=90cOkWhcxtw4IcoI1JbBum0dLXQJm0JslvLUHQqtCLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=njzcZTnFssmd+79ftmmyni/DNR9vq4sylsnNJ6HDf/MhrH6Dw+1NXZB6fNlfGZ6QaeAmG7vK4Y82yfy1OHW9FYb37Q5NWzW6zoU2itTsUTVHnZ29RQdJGAhn/KyX1mgPMjle5bT+1FrRkCNajFo47H7BHTrIDkQvKD7Uz4cvUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wBCZChtm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7741f6b939dso1036785b3a.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757626146; x=1758230946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qUs6RYzKJZgzG01Z/ScbfFo7ruWiH8vc3C3obzRpHNA=;
        b=wBCZChtmZoveoJisguwa4XwFBkyf8/rdZM7F7LSrjqe1aS5RST3NCbF3MDi58M2v6K
         XUZ+zB9M4lzeIBMhhSkysAnvVSiVSUAdN19B/Ph4bnwylGV/2UR79k32j15AdexfdUYC
         aS348nps0sDzDrYdkU+aozolBJ4SBZ64d4IYOBpkb7sbVCX+kx7t1oLcjE7y76M3mHqD
         QDMHtODsBW8K/FDGGz0LN1zbVTZaYEUjfgkYRN9uAgb1uFmhj9BLY7zhznUwiTF0r4oF
         WiW9V7T1dya9YbcyGJPvyppn7vERxxhnLG0MXPBBc+iLmPMENnmsNEi4ikiWIpd2aWOW
         RwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626146; x=1758230946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUs6RYzKJZgzG01Z/ScbfFo7ruWiH8vc3C3obzRpHNA=;
        b=Te7yRwQLoUc1mE1JPxMW9l4hUQlkKZvQ6joD7UgZIM6ElNJ9kVVS0x9W7LBU9VgpZW
         6dAyW0+4euzzI/GB+xmAN+hxcz8rkd5lVVr+6OVCHLwBZu2GwWP2myL0gJR3KLZSVTKi
         GJcfjv4AuZBRBSuQ/1ueC+WKQ/LRlXkf5ADdLeZ6xexGmGhbJhIorJQ+AQUjpluyiLJv
         mDMxBkYoA2U6fqLkWgyhaiYv19JcuUCsMTQ1PscSUR0CXA1TXIUeue8zLAfQr9oHz79l
         lZ5Duz2Z4TOtS2dmKte8jTN6Mtf+EnZhwSbheZLPybhYoImsPmxIMe8QxEKjwRVfsJ7w
         +gRA==
X-Forwarded-Encrypted: i=1; AJvYcCXabZzrof4o3c2szCvNyylhnhSuR5ohVOO9xNDdljPLNCrx4oKTSs4cEpAwAE7Kfcsg7qjhzio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYtKd76nCDw7YTqAOxgyI/ynxHxtkIXfYSv4bVHg14SmHsBdg
	/R3wRrF0mJxOgF2aYEpwnYbMhDIWq46sp3mdMKnCnosZuKmH/K3uMc/g+YUr6IlWip6qIYTdZrI
	YaGqyAWOHynDAhA==
X-Google-Smtp-Source: AGHT+IGiFlQ+dthFtQNDtYRCuw4hU5IrO5Dd9bfzjzPitQL392dI5TXvGvEDIkmUYfHUOWK18RtYqJJkqpzqDQ==
X-Received: from pfbdh14.prod.google.com ([2002:a05:6a00:478e:b0:76b:3822:35ea])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:989:b0:776:26f:4d20 with SMTP id d2e1a72fcca58-7761251cf9amr740492b3a.1.1757626146085;
 Thu, 11 Sep 2025 14:29:06 -0700 (PDT)
Date: Thu, 11 Sep 2025 21:29:01 +0000
In-Reply-To: <20250911212901.1718508-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250911212901.1718508-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250911212901.1718508-3-skhawaja@google.com>
Subject: [PATCH net-next v9 2/2] selftests: Add napi threaded busy poll test
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
2.51.0.384.g4c02a37b29-goog


