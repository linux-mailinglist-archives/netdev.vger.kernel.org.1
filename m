Return-Path: <netdev+bounces-53614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC4E803ECD
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BCA1C20B10
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BA733088;
	Mon,  4 Dec 2023 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVdPUscQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CCED2
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 11:52:56 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d8d3271ff5so16595457b3.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 11:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701719575; x=1702324375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YvciRx9OYqENvtEAHl7xtPGEx0pk0Ryzs9H8zTzgu/4=;
        b=JVdPUscQcGSyV1r2ZR1j4d1nPeoYukpjkR0rBF+6sQzrTXubYpsg/D+S1SrnuZcQcT
         u+Mkb2uiuAjHBtbY9LJlVs0QaiXX4U7JrFp83Gwo2yDjc+9US4u7VxAK8qAEHrREsJZi
         zck04wrVGxjZmNGjHXqYtt4tv/kFRAKBAWheGiuMdHdImGF4Ta7+/FzBWKLryK/RpPlQ
         J5v8qhct//hmiUI0MEwsP4V0n1oiCHeNdDbnbwN1yDnxC/YJzVSzAmlY2tDHoWu9Pz2T
         HySgsXmnJD1sjCNu11IB1uPHy2t4jk6Vl0csKbHaTdWlXIEvnZiM8k7BK1VIhJXUgD/p
         KL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701719575; x=1702324375;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvciRx9OYqENvtEAHl7xtPGEx0pk0Ryzs9H8zTzgu/4=;
        b=INnEVKXFfGdVkjV8zF2oFNEmkRHCaU5fmmbvi0zTHW1wmEgAKyC9jGqoFbf0NfD4LV
         jgkGfWAZuK4lHDigyRRbu/uNuT7lJAlLnXA+jCD5SNj/FwjwDg5oNwWErV8+MJfJDyGh
         Rrw/Jh/A7Ov66QQlfjTAqq3eqsdZgpIc6nQCDbxXY6+ulKaHhsmdK2hHNMaHTsmENkaE
         A9HfqIEl89RLLHrT5Jg5aM9LEssT0wvuj3VqPqp8VlZU6Eua50BZXTuy1ptQxj/WeZYN
         nmVIZmAOpIukGCyw+1vmuvw1747akFxqGXlB5QaybbME+XNkSxw0Yu4/agSi6abnQd8e
         MMhw==
X-Gm-Message-State: AOJu0YyDH03CHH4x/UIEjn5zIwhzmf+OLDHQLdLPANQbihlF5y3Pka27
	e9oT1JFSGNVzVgcJJgd+3WbEOFDh
X-Google-Smtp-Source: AGHT+IEcUJlnjh1o/W2YGQ8wlHZAP/zlh/EOYU864pFGOH2Gx2yXKaT/OaYBeLOLd0F6ejz4CpcS+BWa
X-Received: from athina.mtv.corp.google.com ([2620:15c:211:200:7145:562f:ad2:1a99])
 (user=maze job=sendgmr) by 2002:a81:be18:0:b0:5d1:104a:acb5 with SMTP id
 i24-20020a81be18000000b005d1104aacb5mr789869ywn.2.1701719575697; Mon, 04 Dec
 2023 11:52:55 -0800 (PST)
Date: Mon,  4 Dec 2023 11:52:52 -0800
Message-Id: <20231204195252.2004515-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH net] net: ipv6: support reporting otherwise unknown prefix
 flags in RTM_NEWPREFIX
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Shirley Ma <mashirle@us.ibm.com>, David Ahern <dsahern@kernel.org>, 
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

Cc: Shirley Ma <mashirle@us.ibm.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Lorenzo Colitti <lorenzo@google.com>
Fixes: 60872d54d963 ("[IPV6]: Add notification for MIB:ipv6Prefix events.")
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 include/net/addrconf.h | 12 ++++++++++--
 include/net/if_inet6.h |  4 ----
 net/ipv6/addrconf.c    |  6 +-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 82da55101b5a..1faece7b9c72 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -31,17 +31,22 @@ struct prefix_info {
 	__u8			length;
 	__u8			prefix_len;
=20
+	union {
+		__u8		flags;
+		struct {
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


