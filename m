Return-Path: <netdev+bounces-54540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA628076B6
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764FA1F2113C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17126A012;
	Wed,  6 Dec 2023 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYkUmmGN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97604D5E
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 09:36:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db547d41413so80923276.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 09:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701884176; x=1702488976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uEWHJNYVUo6R7N1RLz6jWmSsMLyT4x9PBiBwx26DOVU=;
        b=RYkUmmGNTf2Qbg29A2mpCiLHi3WTdkyPULwd9M/uzFIpdvscQ+9nGCmKThpKjz0TbD
         hCS21B9zOGtz5yiHF+KA3u+YduJ+NwubPCZtMc7hT/6iZZK/w7UP8m2Gt6wmQwjdHQMc
         dAPjfNuMBi8TwinI6kpkVFcmimoKmf8QWzRncO5FxueHnMO8s/QM2/FS8oUd/BnIoJDg
         OG32lm1UQAoRKjRgbBwn5/jfeZ6TNISAkQHb+HmqmI942pV4HI8Mf8vUz9YyG7elsnir
         KLDK3WB69P5xBsML809BuhGMKOmxa/I0WSpop5aW7Xrsze9r2Iim3ksXmvvyuRXrGZlX
         QCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701884176; x=1702488976;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEWHJNYVUo6R7N1RLz6jWmSsMLyT4x9PBiBwx26DOVU=;
        b=JIYuQCk4gq2m2WywzkAicvMG6qbgFn6YLwH6eNSCl0UYxduyoXQ/wizhJnJds+vLcY
         SYkFvTZxGuNdEZrj23X6mTqo1EfB/wvYPbJPlXzop+zgygBEuTBcifNYBTeebYp7EWGL
         m+mK/Xs+h8ij8BiSTsSf7cr+cQoWNnsXxOn404NDLIzlkRCRlxlDEjxdLWq+2YUpbQxW
         u+qbHjai2Q6m1klFBQUk0XGLevwXJ51t3iuc4IvQLylbVyG4yUzpXDpeiA21xRiSfEur
         o3+4IgVMaIQLLEBmMxGVu0j8ICN8/FPuRfrfM0qb15g6W9ofvEcUa031tGXuHPAyrZtV
         VVZw==
X-Gm-Message-State: AOJu0YzDi3e72gdITe0slfoBCJifODBRlRfkr80CMIEAxfEzo7HqjV/x
	1fitKDzRylZ2VMV1Vm7ciIxaXVb4
X-Google-Smtp-Source: AGHT+IFUqffFBaUeBWYnkYEPtOrzU94XuLjVtw0P24WQ20kQr/WhCCvo0beInjFpOd6on6tdYtFB9zjZ
X-Received: from athina.mtv.corp.google.com ([2620:15c:211:200:868c:db6b:ace8:1af9])
 (user=maze job=sendgmr) by 2002:a25:ba51:0:b0:db5:4209:22cc with SMTP id
 z17-20020a25ba51000000b00db5420922ccmr97912ybj.5.1701884175757; Wed, 06 Dec
 2023 09:36:15 -0800 (PST)
Date: Wed,  6 Dec 2023 09:36:12 -0800
Message-Id: <20231206173612.79902-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH net v4] net: ipv6: support reporting otherwise unknown prefix
 flags in RTM_NEWPREFIX
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, David Ahern <dsahern@kernel.org>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lorenzo points out that we effectively clear all unknown
flags from PIO when copying them to userspace in the netlink
RTM_NEWPREFIX notification.

We could fix this one at a time as new flags are defined,
or in one fell swoop - I choose the latter.

We could either define 6 new reserved flags (reserved1..6) and handle
them individually (and rename them as new flags are defined), or we
could simply copy the entire unmodified byte over - I choose the latter.

This unfortunately requires some anonymous union/struct magic,
so we add a static assert on the struct size for a little extra safety.

Cc: David Ahern <dsahern@kernel.org>
Cc: Lorenzo Colitti <lorenzo@google.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 include/net/addrconf.h | 12 ++++++++++--
 include/net/if_inet6.h |  4 ----
 net/ipv6/addrconf.c    |  6 +-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 82da55101b5a..61ebe723ee4d 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -31,17 +31,22 @@ struct prefix_info {
 	__u8			length;
 	__u8			prefix_len;
=20
+	union __packed {
+		__u8		flags;
+		struct __packed {
 #if defined(__BIG_ENDIAN_BITFIELD)
-	__u8			onlink : 1,
+			__u8	onlink : 1,
 			 	autoconf : 1,
 				reserved : 6;
 #elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8			reserved : 6,
+			__u8	reserved : 6,
 				autoconf : 1,
 				onlink : 1;
 #else
 #error "Please fix <asm/byteorder.h>"
 #endif
+		};
+	};
 	__be32			valid;
 	__be32			prefered;
 	__be32			reserved2;
@@ -49,6 +54,9 @@ struct prefix_info {
 	struct in6_addr		prefix;
 };
=20
+/* rfc4861 4.6.2: IPv6 PIO is 32 bytes in size */
+static_assert(sizeof(struct prefix_info) =3D=3D 32);
+
 #include <linux/ipv6.h>
 #include <linux/netdevice.h>
 #include <net/if_inet6.h>
diff --git a/include/net/if_inet6.h b/include/net/if_inet6.h
index 3e454c4d7ba6..f07642264c1e 100644
--- a/include/net/if_inet6.h
+++ b/include/net/if_inet6.h
@@ -22,10 +22,6 @@
 #define IF_RS_SENT	0x10
 #define IF_READY	0x80000000
=20
-/* prefix flags */
-#define IF_PREFIX_ONLINK	0x01
-#define IF_PREFIX_AUTOCONF	0x02
-
 enum {
 	INET6_IFADDR_STATE_PREDAD,
 	INET6_IFADDR_STATE_DAD,
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3aaea56b5166..2692a7b24c40 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6149,11 +6149,7 @@ static int inet6_fill_prefix(struct sk_buff *skb, st=
ruct inet6_dev *idev,
 	pmsg->prefix_len =3D pinfo->prefix_len;
 	pmsg->prefix_type =3D pinfo->type;
 	pmsg->prefix_pad3 =3D 0;
-	pmsg->prefix_flags =3D 0;
-	if (pinfo->onlink)
-		pmsg->prefix_flags |=3D IF_PREFIX_ONLINK;
-	if (pinfo->autoconf)
-		pmsg->prefix_flags |=3D IF_PREFIX_AUTOCONF;
+	pmsg->prefix_flags =3D pinfo->flags;
=20
 	if (nla_put(skb, PREFIX_ADDRESS, sizeof(pinfo->prefix), &pinfo->prefix))
 		goto nla_put_failure;
--=20
2.43.0.rc2.451.g8631bc7472-goog


