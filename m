Return-Path: <netdev+bounces-122878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14270962F67
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04ED284CB4
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0CF1A76D8;
	Wed, 28 Aug 2024 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqfI5lPF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11271D554
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868655; cv=none; b=ddeHm5dtinbumJKuLhM1fT2OxevgQWKk9KnXKBC9uvuKVsA2UwBvwT9JoW7aw8zrTMKHx1xW/mS8iWihRLwfi6yTUUPWa1aVvPp0fskmsdjXvpBZi2tBkMIVEpd58lestpAh1BuVVQNeqWLjzCcT5AySPiX98l/KKfCmXjk2B20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868655; c=relaxed/simple;
	bh=THN6N+z6HTuTI67pEM9EBpVPotgg0tCD6rERdldGC2I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nHV3IFkBHBszHVWXXv9ZeELaS+DImMYvM4/vt5+6ZTi1Z5c4F9fHbkxhTxHuWwXlpAYMbViSrpvRRS+VLXqtu8OU9kYsQuS5DTNbVDKo3tY252Qu0RllVIFQ1RpzRHPFlALbwhr5Ab597SzFvAOv/FX+MxkeosxD+WEm/rI/LJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqfI5lPF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso11774137276.1
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724868653; x=1725473453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qMw4yuHSPRsBryq2SOo7EUqRcp8n9c/EkhNEJvWc1jQ=;
        b=VqfI5lPF02IjQkNzCOoAwXNREavq7hCUyo3TWznBwfQBGuciGUNyXbKZmLJfwxeGEA
         YxXnz5ILUtDrJ+gIaE46au0Mzpn1GSQiy7AG2QYwIfU0cqlSxUHndWdzdXHaUegP7d8b
         wyu310jsmtmBIdHEPCcznsXllwGdD1KLBZzDe0sF9UJjjsRfXwxElebz4j4NUy6Bv+K5
         KN2iD6JRLMCXRnssfW66qoLFaa9mlcrQ5z1Ky/hEmFvPOHznRn+Zaxw/CrCclomjBcAU
         OQzD82fqzAvfd7R3/27ejkg+b/nQIaSBiaXtfuvg2gLHMmiR+lNpihNbFt0PDOiSYS8I
         zuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868653; x=1725473453;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMw4yuHSPRsBryq2SOo7EUqRcp8n9c/EkhNEJvWc1jQ=;
        b=On6nCAj9IFauKNzdjGMv1cgH9oqlmBmPd39y7BQzyG1XJThOQKNrerfh0Vmr9zsWop
         iGZJ2hoobFNI5cw91WDlPEL0uHhyYFnG18RC7td11LLUnc8LEqvyaaQDbP5mUVe+MRM8
         F+lIeFjzfVVLg02xymPqJumbcMVdoheXDkpMug3JfPhruN+V6YnA253mci/oMDVicfkC
         7sGIkgS+M0EYVOp9uS/Hkh3TrZa11BLMVgVT6lPl3rNwKFcMLJBKfkJaSBBSYliXiXJl
         spKv32dhGdcUIbuANQxeb4gLVDdMJriQQBCY5d4IIvxJXzYMTjGZp5OGIdGXekOjUK8u
         4D0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrcuWf9hJbGlLxsnt8lneTLoyZd22xf5vTGWXuWvrrId+1u9vwQUu84/ItRCFuA5nDRi0v9ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6so4yXcZ9l3LAnslf3PmHuAk+66YZcS2HKZJmRSbinxilElm
	gvoEpv/h0AA82GwFaDwJsq8r1KQ9YcN7WBIC+BahxgLAfry6yoCVXWh+IsnzhQYnZdMMbXwgZcJ
	I3u+uDc0Z1suULdvONRB+tg==
X-Google-Smtp-Source: AGHT+IE/24yf0KVv5ga+Tezi0I6drNwMQCd3ZlAqSHhaGuBore+QwJhr0wBXg2KuphlBqgKz6r9pK3tLmhWCprpmqA==
X-Received: from namang.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:33a8])
 (user=namangulati job=sendgmr) by 2002:a25:c50d:0:b0:e13:e775:5a3c with SMTP
 id 3f1490d57ef6-e1a5ab4e33dmr226276.2.1724868652605; Wed, 28 Aug 2024
 11:10:52 -0700 (PDT)
Date: Wed, 28 Aug 2024 18:10:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828181011.1591242-1-namangulati@google.com>
Subject: [PATCH] Add provision to busyloop for events in ep_poll.
From: Naman Gulati <namangulati@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Cc: Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, skhawaja@google.com, 
	Joe Damato <jdamato@fastly.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

NAPI busypolling in ep_busy_loop loops on napi_poll and checks for new
epoll events after every napi poll. Checking just for epoll events in a
tight loop in the kernel context delivers latency gains to applications
that are not interested in napi busypolling with epoll.

This patch adds an option to loop just for new events inside
ep_busy_loop, guarded by the EPIOCSPARAMS ioctl that controls epoll napi
busypolling.

A comparison with neper tcp_rr shows that busylooping for events in
epoll_wait boosted throughput by ~3-7% and reduced median latency by
~10%.

To demonstrate the latency and throughput improvements, a comparison was
made of neper tcp_rr running with:
    1. (baseline) No busylooping
    2. (epoll busylooping) enabling the epoll busy looping on all epoll
    fd's
    3. (userspace busylooping) looping on epoll_wait in userspace
    with timeout=3D0

Stats for two machines with 100Gbps NICs running tcp_rr with 5 threads
and varying flows:

Type                Flows   Throughput             Latency (=CE=BCs)
                             (B/s)      P50   P90    P99   P99.9   P99.99
baseline            15	    272145      57.2  71.9   91.4  100.6   111.6
baseline            30	    464952	66.8  78.8   98.1  113.4   122.4
baseline            60	    695920	80.9  118.5  143.4 161.8   174.6
epoll busyloop      15	    301751	44.7  70.6   84.3  95.4    106.5
epoll busyloop      30	    508392	58.9  76.9   96.2  109.3   118.5
epoll busyloop      60	    745731	77.4  106.2  127.5 143.1   155.9
userspace busyloop  15	    279202	55.4  73.1   85.2  98.3    109.6
userspace busyloop  30	    472440	63.7  78.2   96.5  112.2   120.1
userspace busyloop  60	    720779	77.9  113.5  134.9 152.6   165.7

Per the above data epoll busyloop outperforms baseline and userspace
busylooping in both throughput and latency. As the density of flows per
thread increased, the median latency of all three epoll mechanisms
converges. However epoll busylooping is better at capturing the tail
latencies at high flow counts.

Signed-off-by: Naman Gulati <namangulati@google.com>
---
 fs/eventpoll.c                 | 53 ++++++++++++++++++++++++++--------
 include/uapi/linux/eventpoll.h |  3 +-
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f53ca4f7fcedd..6cba79261817a 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -232,7 +232,10 @@ struct eventpoll {
 	u32 busy_poll_usecs;
 	/* busy poll packet budget */
 	u16 busy_poll_budget;
-	bool prefer_busy_poll;
+	/* prefer to busypoll in napi poll */
+	bool napi_prefer_busy_poll;
+	/* avoid napi poll when busy looping and poll only for events */
+	bool event_poll_only;
 #endif
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -430,6 +433,24 @@ static bool ep_busy_loop_end(void *p, unsigned long st=
art_time)
 	return ep_events_available(ep) || busy_loop_ep_timeout(start_time, ep);
 }
=20
+/**
+ * ep_event_busy_loop - loop until events available or busy poll
+ * times out.
+ *
+ * @ep: Pointer to the eventpoll context.
+ *
+ * Return: true if events available, false otherwise.
+ */
+static bool ep_event_busy_loop(struct eventpoll *ep)
+{
+	unsigned long start_time =3D busy_loop_current_time();
+
+	while (!ep_busy_loop_end(ep, start_time))
+		cond_resched();
+
+	return ep_events_available(ep);
+}
+
 /*
  * Busy poll if globally on and supporting sockets found && no events,
  * busy loop will return if need_resched or ep_events_available.
@@ -440,23 +461,29 @@ static bool ep_busy_loop(struct eventpoll *ep, int no=
nblock)
 {
 	unsigned int napi_id =3D READ_ONCE(ep->napi_id);
 	u16 budget =3D READ_ONCE(ep->busy_poll_budget);
-	bool prefer_busy_poll =3D READ_ONCE(ep->prefer_busy_poll);
+	bool event_poll_only =3D READ_ONCE(ep->event_poll_only);
=20
 	if (!budget)
 		budget =3D BUSY_POLL_BUDGET;
=20
-	if (napi_id >=3D MIN_NAPI_ID && ep_busy_loop_on(ep)) {
+	if (!ep_busy_loop_on(ep))
+		return false;
+
+	if (event_poll_only) {
+		return ep_event_busy_loop(ep);
+	} else if (napi_id >=3D MIN_NAPI_ID) {
+		bool napi_prefer_busy_poll =3D READ_ONCE(ep->napi_prefer_busy_poll);
+
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end,
-			       ep, prefer_busy_poll, budget);
+				ep, napi_prefer_busy_poll, budget);
 		if (ep_events_available(ep))
 			return true;
 		/*
-		 * Busy poll timed out.  Drop NAPI ID for now, we can add
-		 * it back in when we have moved a socket with a valid NAPI
-		 * ID onto the ready list.
-		 */
+		* Busy poll timed out.  Drop NAPI ID for now, we can add
+		* it back in when we have moved a socket with a valid NAPI
+		* ID onto the ready list.
+		*/
 		ep->napi_id =3D 0;
-		return false;
 	}
 	return false;
 }
@@ -523,13 +550,15 @@ static long ep_eventpoll_bp_ioctl(struct file *file, =
unsigned int cmd,
=20
 		WRITE_ONCE(ep->busy_poll_usecs, epoll_params.busy_poll_usecs);
 		WRITE_ONCE(ep->busy_poll_budget, epoll_params.busy_poll_budget);
-		WRITE_ONCE(ep->prefer_busy_poll, epoll_params.prefer_busy_poll);
+		WRITE_ONCE(ep->napi_prefer_busy_poll, epoll_params.prefer_busy_poll);
+		WRITE_ONCE(ep->event_poll_only, epoll_params.event_poll_only);
 		return 0;
 	case EPIOCGPARAMS:
 		memset(&epoll_params, 0, sizeof(epoll_params));
 		epoll_params.busy_poll_usecs =3D READ_ONCE(ep->busy_poll_usecs);
 		epoll_params.busy_poll_budget =3D READ_ONCE(ep->busy_poll_budget);
-		epoll_params.prefer_busy_poll =3D READ_ONCE(ep->prefer_busy_poll);
+		epoll_params.prefer_busy_poll =3D READ_ONCE(ep->napi_prefer_busy_poll);
+		epoll_params.event_poll_only =3D READ_ONCE(ep->event_poll_only);
 		if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params)))
 			return -EFAULT;
 		return 0;
@@ -2203,7 +2232,7 @@ static int do_epoll_create(int flags)
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ep->busy_poll_usecs =3D 0;
 	ep->busy_poll_budget =3D 0;
-	ep->prefer_busy_poll =3D false;
+	ep->napi_prefer_busy_poll =3D false;
 #endif
 	ep->file =3D file;
 	fd_install(fd, file);
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.=
h
index 4f4b948ef3811..3bc0f4eed976c 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -89,9 +89,10 @@ struct epoll_params {
 	__u32 busy_poll_usecs;
 	__u16 busy_poll_budget;
 	__u8 prefer_busy_poll;
+	__u8 event_poll_only:1;
=20
 	/* pad the struct to a multiple of 64bits */
-	__u8 __pad;
+	__u8 __pad:7;
 };
=20
 #define EPOLL_IOC_TYPE 0x8A
--=20
2.46.0.295.g3b9ea8a38a-goog


