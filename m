Return-Path: <netdev+bounces-215024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23599B2CB3F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 19:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9E15C3EC1
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F030C36E;
	Tue, 19 Aug 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muvHv8XE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769EB30BF71
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625235; cv=none; b=urLqCLdXwVJJYICmmWh9J+EfmVmUKby7Ui4Ew1ZUZWHXtVK9yDT0eIZ5MFZIRDo+Bb3lw50PaBG69kkbopaRaZwd6581mGBspUrp3gxzOQNQy1lYou8Q1Q/IwHq9xVB6Y8Y8n8iQHNAycJzx5AVnnHEDZ5lxpKAXGazFBq5MFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625235; c=relaxed/simple;
	bh=KMOu85zz4OCUoQuhE+oRG6+Vn12B2baiVz+Cj1jDcfc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UUHH4FMj2eoXRNQaV19xe7pVsfS6rF9iHC6Z6dbQvcFaQTNXvsEGWTdJXPD8Qqm9zh9PnPpuQJvqgDWykUZ/0BTggEZEw1Sl8rBkYLmkQxzzk8MbvSgqI1XKfhzHCiGZyxJTCppqFmuQfPmV/8VdRfx8hjHZzxFKBFTZ05J9uR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muvHv8XE; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b0fa8190d4so4005151cf.0
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755625232; x=1756230032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VDIszKQwk1vj5ShaLt1rWtBgy4cO5fPEmtNO2bf+LLY=;
        b=muvHv8XEH/X+qz1g5Kbw/FUadk0aOJCUaAqfVheJvUFXliKxwY696u9yZwTf7PBkBI
         J3G526JHkbPSbRUZX4lwGZ48k58CjKzhR4/TewwxcLHBrdJrfo4Hmq/k4iqFFfEWOYgK
         nk43yVcgJd235lOqSaVipJYnrIuVuhMLheN1+VvjBcfb95P+AWlVKEKPZr1BKaNYllQ3
         gUYbEpfcejFFBz6mJ11FkNTBjHmNba+rW2XR6HalefSSg1IF80qAryUi5/pYVD4QdFXZ
         qjX5vE8FNE8I7MJoq3s/LLo0sIcAzRIV4xc7m6HXP+fKl1HssOWDGmakxDaimlCk5JaW
         dLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625232; x=1756230032;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDIszKQwk1vj5ShaLt1rWtBgy4cO5fPEmtNO2bf+LLY=;
        b=eqy1TaPmB0Ulj6PMsT+ChPEql9x3ZO/1Yc4+tI26BC1uJfIVUOkv7ZOlHrY/tpWFIV
         HlE91Kw1FQcdQDuUthvjbGJpLU7c3Y4CwKqwtuJTn400xGMrBIOX9+VCFzN6bO98WAGg
         e0eiDFm9xdArri8xWY6SQ31+JJr2vEK4bNtMD6SL3/Sw/jzsEafIUS9+0qrNXHpQ4bTv
         SJBj0lX7i8D8eAtZghTaz4yhT3WCxCWwk/f/EmFnfp5ch4Bqs6Upyo+DcZ1PGCypGbO/
         jEuDKNylaA8K1hm/at+vjJJDLTdffBun15T5xDkTBRCnUNydw4fWoyJSNIeSJEYCnYB8
         gnNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEdi9l//+6cADsENSGBfFZ3+VgsNaY4TWh0JqoHpsdgVxAWa1KrjIHOv7mUs/d8TEJuRJsXLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2NlNZ4sSP8EBEO9ympnrgPE+TYrfmCQbjiPuNWnicYnKGLZRl
	0V8BeQkg9bOdDTuN+AqmjavNOE4CGAgeBkcpFOqkqeybYMNKCSH8znZsDYcE/LMdTzXCF6T0AyI
	X1J2CU59wKpzpyQ==
X-Google-Smtp-Source: AGHT+IFt6lxSiLC+KHbJJ4Vk1pZrljPmyB/2FDDOAPWRcZ+Q/PUF5KmoHrujm6AAuzBrn4XmXFra8BxVMTHx2g==
X-Received: from qvon4.prod.google.com ([2002:a0c:e944:0:b0:70b:b4cb:65c3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1c0c:b0:70b:be30:62c7 with SMTP id 6a1803df08f44-70c689212cdmr35979686d6.24.1755625232200;
 Tue, 19 Aug 2025 10:40:32 -0700 (PDT)
Date: Tue, 19 Aug 2025 17:40:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250819174030.1986278-1-edumazet@google.com>
Subject: [PATCH net-next] net: set net.core.rmem_max and net.core.wmem_max to
 4 MB
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

SO_RCVBUF and SO_SNDBUF have limited range today, unless
distros or system admins change rmem_max and wmem_max.

Even iproute2 uses 1 MB SO_RCVBUF which is capped by
the kernel.

Decouple [rw]mem_max and [rw]mem_default and increase
[rw]mem_max to 4 MB.

Before:

$ sysctl net.core.rmem_default net.core.rmem_max net.core.wmem_default net.core.wmem_max
net.core.rmem_default = 212992
net.core.rmem_max = 212992
net.core.wmem_default = 212992
net.core.wmem_max = 212992

After:

$ sysctl net.core.rmem_default net.core.rmem_max net.core.wmem_default net.core.wmem_max
net.core.rmem_default = 212992
net.core.rmem_max = 4194304
net.core.wmem_default = 212992
net.core.wmem_max = 4194304

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/admin-guide/sysctl/net.rst | 4 ++++
 Documentation/networking/ip-sysctl.rst   | 6 +++---
 include/net/sock.h                       | 4 ++--
 net/core/sock.c                          | 8 ++++----
 net/ipv4/arp.c                           | 2 +-
 net/ipv6/ndisc.c                         | 2 +-
 6 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 7b0c4291c6861e5694c36f89ddbb19d0397e4190..2ef50828aff16b01baf32f5ded9b75a6e699b184 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -222,6 +222,8 @@ rmem_max
 
 The maximum receive socket buffer size in bytes.
 
+Default: 4194304
+
 rps_default_mask
 ----------------
 
@@ -247,6 +249,8 @@ wmem_max
 
 The maximum send socket buffer size in bytes.
 
+Default: 4194304
+
 message_burst and message_cost
 ------------------------------
 
diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 9756d16e3df1400626ce24726feceaeefa5da523..cb0fce8512bfa3ed6c61654787eca1b2bd9312d8 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -209,7 +209,7 @@ neigh/default/unres_qlen_bytes - INTEGER
 
 	Setting negative value is meaningless and will return error.
 
-	Default: SK_WMEM_MAX, (same as net.core.wmem_default).
+	Default: SK_WMEM_DEFAULT, (same as net.core.wmem_default).
 
 		Exact value depends on architecture and kernel options,
 		but should be enough to allow queuing 256 packets
@@ -805,8 +805,8 @@ tcp_rmem - vector of 3 INTEGERs: min, default, max
 	This value results in initial window of 65535.
 
 	max: maximal size of receive buffer allowed for automatically
-	selected receiver buffers for TCP socket. This value does not override
-	net.core.rmem_max.  Calling setsockopt() with SO_RCVBUF disables
+	selected receiver buffers for TCP socket.
+	Calling setsockopt() with SO_RCVBUF disables
 	automatic tuning of that socket's receive buffer size, in which
 	case this value is ignored.
 	Default: between 131072 and 32MB, depending on RAM size.
diff --git a/include/net/sock.h b/include/net/sock.h
index c8a4b283df6fc4b931270502ddbb5df7ae1e4aa2..4a9169a8d92493db64315b09c2fc105a6d55966d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2924,8 +2924,8 @@ void sk_get_meminfo(const struct sock *sk, u32 *meminfo);
  */
 #define _SK_MEM_PACKETS		256
 #define _SK_MEM_OVERHEAD	SKB_TRUESIZE(256)
-#define SK_WMEM_MAX		(_SK_MEM_OVERHEAD * _SK_MEM_PACKETS)
-#define SK_RMEM_MAX		(_SK_MEM_OVERHEAD * _SK_MEM_PACKETS)
+#define SK_WMEM_DEFAULT		(_SK_MEM_OVERHEAD * _SK_MEM_PACKETS)
+#define SK_RMEM_DEFAULT		(_SK_MEM_OVERHEAD * _SK_MEM_PACKETS)
 
 extern __u32 sysctl_wmem_max;
 extern __u32 sysctl_rmem_max;
diff --git a/net/core/sock.c b/net/core/sock.c
index 7c26ec8dce630f0d24a622a418c15e6594d1babb..66c65f4a03f38850b9f42e82188a9df1c3485ce1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -281,12 +281,12 @@ static struct lock_class_key af_elock_keys[AF_MAX];
 static struct lock_class_key af_kern_callback_keys[AF_MAX];
 
 /* Run time adjustable parameters. */
-__u32 sysctl_wmem_max __read_mostly = SK_WMEM_MAX;
+__u32 sysctl_wmem_max __read_mostly = 4 << 20;
 EXPORT_SYMBOL(sysctl_wmem_max);
-__u32 sysctl_rmem_max __read_mostly = SK_RMEM_MAX;
+__u32 sysctl_rmem_max __read_mostly = 4 << 20;
 EXPORT_SYMBOL(sysctl_rmem_max);
-__u32 sysctl_wmem_default __read_mostly = SK_WMEM_MAX;
-__u32 sysctl_rmem_default __read_mostly = SK_RMEM_MAX;
+__u32 sysctl_wmem_default __read_mostly = SK_WMEM_DEFAULT;
+__u32 sysctl_rmem_default __read_mostly = SK_RMEM_DEFAULT;
 
 DEFINE_STATIC_KEY_FALSE(memalloc_socks_key);
 EXPORT_SYMBOL_GPL(memalloc_socks_key);
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 5cfc1c9396732171b79ce0aac2b0ee11ddfcbd05..833f2cf97178ee6a50fb3c99d02ed5b17ab5a879 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -170,7 +170,7 @@ struct neigh_table arp_tbl = {
 			[NEIGH_VAR_DELAY_PROBE_TIME] = 5 * HZ,
 			[NEIGH_VAR_INTERVAL_PROBE_TIME_MS] = 5 * HZ,
 			[NEIGH_VAR_GC_STALETIME] = 60 * HZ,
-			[NEIGH_VAR_QUEUE_LEN_BYTES] = SK_WMEM_MAX,
+			[NEIGH_VAR_QUEUE_LEN_BYTES] = SK_WMEM_DEFAULT,
 			[NEIGH_VAR_PROXY_QLEN] = 64,
 			[NEIGH_VAR_ANYCAST_DELAY] = 1 * HZ,
 			[NEIGH_VAR_PROXY_DELAY]	= (8 * HZ) / 10,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 7d5abb3158ec9640a45d4f36fbbfdfce070c0dd0..57aaa7ae8ac3109d808dd46e8cfe54b57e48b214 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -130,7 +130,7 @@ struct neigh_table nd_tbl = {
 			[NEIGH_VAR_DELAY_PROBE_TIME] = 5 * HZ,
 			[NEIGH_VAR_INTERVAL_PROBE_TIME_MS] = 5 * HZ,
 			[NEIGH_VAR_GC_STALETIME] = 60 * HZ,
-			[NEIGH_VAR_QUEUE_LEN_BYTES] = SK_WMEM_MAX,
+			[NEIGH_VAR_QUEUE_LEN_BYTES] = SK_WMEM_DEFAULT,
 			[NEIGH_VAR_PROXY_QLEN] = 64,
 			[NEIGH_VAR_ANYCAST_DELAY] = 1 * HZ,
 			[NEIGH_VAR_PROXY_DELAY] = (8 * HZ) / 10,
-- 
2.51.0.rc1.193.gad69d77794-goog


