Return-Path: <netdev+bounces-43024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D577D1007
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D82A282363
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8ED1CF9B;
	Fri, 20 Oct 2023 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3DrCm2J"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607F1C6A0
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:58:08 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98414D60
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9c4ae201e0so663612276.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806687; x=1698411487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPzcKzNKeRtADYBalFzrHOn+FGjL6+SKDGFbdLmUVao=;
        b=i3DrCm2JOkOl0gtkhdoUpP1m7j0yw5sU7khEbEeVk3y3xbk/Ucw6xuXn0hH8UbisHO
         K4ZhypsTOPd3LBwXa2zopyW2zbhjoxhA6xRCX9sh1Vtjxnf4mwtDM1GzUkB17JYCHV4D
         g2RUHssAQYkSOZOyAoc/Vp4viUu8by7BTtmY3YsnZ6JRtNrvUepOycVcCQE/bqywW3Ki
         hWN5uc4iDOYwWz9DhC/9RhywDbccIkYroqAfV9SAF6lE9WdG3i9rsUa3gWKy7atp7xtn
         ko2qyGWGZgVHzPwYysl1JUxrIUejtbdv8uzGu8UM4pdav2v5W6Qxv401V8BOwZ9Z8Aa5
         sT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806687; x=1698411487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPzcKzNKeRtADYBalFzrHOn+FGjL6+SKDGFbdLmUVao=;
        b=sxQXu37Rq0ZfQHYMGJBZC5R3JXdZUfkhqMhNmYPLVg3GMDmsLQSSkXbqmXjvUDdTVU
         N4qZKuzoGsMctnELRrt5mtX54fA9rnbuLCA+SCW1aRtosHzP76KqBKvyTadeMA+tbulB
         yzWlskO5hV52FBzOsY/RgOrzRU1MCjDl154ywZruyLOwcCLCgccHmVNQm0E+sBVaZk8U
         wmc/2orVCO8gWzXNDwd/b6wJ/tFPz4h6srFcZEZQpWPZ2Mt7oXrNmZ0BaJjamupvl+yV
         +SbaCOMkX38YzeLlaOATMfRSp2QGuKGrfkX4kaRp7H1Qbx6SeYae9o4Znr+ZzKvG2yi+
         iAMw==
X-Gm-Message-State: AOJu0YyTzV3i+3hVmCJoF8cIcvzBWI068xoWyppBmrrSbWmS+++3XL8k
	WY4RVFdwkmNUb7ULfIPuNdZgdiJQO8Db0g==
X-Google-Smtp-Source: AGHT+IGTNlhV33w2QK6cB7va6YLxcKPSiH8SvXYqYJT6KbMokk/cci6UoxWTyo7RT1AlAWSRi9J+eLNwLs/QJw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:34d1:0:b0:d9a:6360:485b with SMTP id
 b200-20020a2534d1000000b00d9a6360485bmr121530yba.2.1697806686863; Fri, 20 Oct
 2023 05:58:06 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:45 +0000
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-11-edumazet@google.com>
Subject: [PATCH net-next 10/13] tcp: add RTAX_FEATURE_TCP_USEC_TS
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This new dst feature flag will be used to allow TCP to use usec
based timestamps instead of msec ones.

ip route .... feature tcp_usec_ts

Also document that RTAX_FEATURE_SACK and RTAX_FEATURE_TIMESTAMP
are unused.

RTAX_FEATURE_ALLFRAG is also going away soon.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h            |  5 +++++
 include/uapi/linux/rtnetlink.h | 18 +++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index e15452df9804f6d5badddaed3445c5586b1fcea3..04a0e647ef747e5c83520cd1b1c2156d3a315ba5 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -576,4 +576,9 @@ void tcp_sock_set_quickack(struct sock *sk, int val);
 int tcp_sock_set_syncnt(struct sock *sk, int val);
 int tcp_sock_set_user_timeout(struct sock *sk, int val);
 
+static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
+{
+	return dst_feature(dst, RTAX_FEATURE_TCP_USEC_TS);
+}
+
 #endif	/* _LINUX_TCP_H */
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 51c13cf9c5aee4a2d1ab33c1a89043383d67b9cf..aa2482a0614aa685590fcc73819cbe1baac63d66 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -502,13 +502,17 @@ enum {
 
 #define RTAX_MAX (__RTAX_MAX - 1)
 
-#define RTAX_FEATURE_ECN	(1 << 0)
-#define RTAX_FEATURE_SACK	(1 << 1)
-#define RTAX_FEATURE_TIMESTAMP	(1 << 2)
-#define RTAX_FEATURE_ALLFRAG	(1 << 3)
-
-#define RTAX_FEATURE_MASK	(RTAX_FEATURE_ECN | RTAX_FEATURE_SACK | \
-				 RTAX_FEATURE_TIMESTAMP | RTAX_FEATURE_ALLFRAG)
+#define RTAX_FEATURE_ECN		(1 << 0)
+#define RTAX_FEATURE_SACK		(1 << 1) /* unused */
+#define RTAX_FEATURE_TIMESTAMP		(1 << 2) /* unused */
+#define RTAX_FEATURE_ALLFRAG		(1 << 3)
+#define RTAX_FEATURE_TCP_USEC_TS	(1 << 4)
+
+#define RTAX_FEATURE_MASK	(RTAX_FEATURE_ECN |		\
+				 RTAX_FEATURE_SACK |		\
+				 RTAX_FEATURE_TIMESTAMP |	\
+				 RTAX_FEATURE_ALLFRAG |		\
+				 RTAX_FEATURE_TCP_USEC_TS)
 
 struct rta_session {
 	__u8	proto;
-- 
2.42.0.655.g421f12c284-goog


