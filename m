Return-Path: <netdev+bounces-138734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA89AEACA
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AF1283735
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE291F76A9;
	Thu, 24 Oct 2024 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q4H44h4l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C381F6671
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784488; cv=none; b=plo7H7VEOdiQcoymQmAsOrf47U8jwiHuGJpmaLRTpsYPgk4+4jCJ938EDL5cdw+R2RbXF5rJNYd/Rxhx5h5NEeC0/u2VHOHs1Tunim9LHzr45/qq0pQxAFknoiC6DtNK7vi9m6NH5s9dkf654hvgtj4bghiVJgNAhu57iaUwhNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784488; c=relaxed/simple;
	bh=NzPc+MEj5MreWpjdXm1DbGCwZggmK4QJNf3BY6pCpQ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q7JQ42N5cMd0yVm1EFxyT+41QBNLezIkWnkccL3Vl8jeZ8CFvywk+YQtu/a1MG/5emQBOc2GfFBJqtsH6D7f0wL+F3hxDew0q0SEx8Px/fwtRR1Rrtu7hjLXugVoNdZYcmvl1J5QognPtBUUr0lxeVY0edO/ZBpIFGX3dBohFdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q4H44h4l; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3497c8eb0so13269797b3.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729784484; x=1730389284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVCwH2qwQsHmN0+2O9f30RekvhfpBGTgGaTAQxr8yx0=;
        b=Q4H44h4lHjR+UfwbdcZ/enieC5qC1yMVkSeI67Gf7WuwFk9gyT5vzK0lZ31kQWrwOv
         GtZBr/T0TiSp90qQNam5n/iPAn2NTRtYlqxLZyfYXgQDrsu+j2gEQgQqT2DnnvXYy4NS
         eD4+W9qzFCwik+Bb5DWAJI5tV1eQXuEPx931cBIZbYLZByO925a7ozFcP294IGuBXh6J
         74ECeMDo5e/EZUjyCIy3bXj2HBrEZpJI3MFBxSYXU2MXOQj6OtLwsPkacSd19uPnibAP
         YLf4uuSDxzlrP9XyRqLbu1ztv5l5eYsLwP5p0s/zkjtxGMJ75Nav/pXZ13oCyBU67Agx
         2/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784484; x=1730389284;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVCwH2qwQsHmN0+2O9f30RekvhfpBGTgGaTAQxr8yx0=;
        b=IO6N2NMbfhUgZqjyNW8uPQehSoGCb27D/JWM/uXR0fJDypYrnjSI91/XHgCyARxtsC
         zd/yUfOTmamYUKQTqJqlE36BLylcisNfz5GFykpGz4H3M6NoeYA9wpLT6d4ijWhOU2PJ
         qtSCAKQyqKNr7S7PyJsMj7qCSjIUs1RE5dMH67GVJIculGUCmP1sdCEjSnu/cr5x35Sz
         pxKhGPORwp13U4E3h9eQFUJIPyGVvRRsNqbUBSXmBA+UyqzxDV8liH7pU8hPSRbYKw05
         v3ULgVi1uYpkhoYCe8V/CyXg/c4eLkn+70Yytab/9ef/hqpqHxE9L9Z2HktqfDwrE2YH
         4tKA==
X-Gm-Message-State: AOJu0Yx7dIFZzckw9R5bFn8Bnm7iIMPh94xbeAfKWysyaL9zaLQ7hZHf
	l1zt4uSIQw5BHimEQdcEl3NBly4i5Ew+CNjk1WJqukLD+BuIueF0jhUMF6Idmr2lJGPbdQ==
X-Google-Smtp-Source: AGHT+IH8cpbT76BX6JBBLR00DzTeXjj2NwIYBc279rSkgJv+J57Il/QyAZ/Bq2x2UOSCbiVnbo6+/Hbb
X-Received: from varda.mtv.corp.google.com ([2a00:79e0:2e3f:8:b6f:d0ad:2aa:2e51])
 (user=maze job=sendgmr) by 2002:a05:690c:9a10:b0:6d9:d865:46c7 with SMTP id
 00721157ae682-6e858169005mr1160717b3.2.1729784484216; Thu, 24 Oct 2024
 08:41:24 -0700 (PDT)
Date: Thu, 24 Oct 2024 08:41:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241024154119.1096947-1-maze@google.com>
Subject: [PATCH net-next] net: define and implement new SOL_SOCKET
 SO_RX_IFINDEX option
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is currently only implemented for TCP and is not
guaranteed to return correct information for a multitude
of reasons (including multipath reception), but there are
scenarios where it is useful: in particular a strong host
model where connections are only viable via a single interface,
for example a VPN interface.  One could for example choose
to use this to SO_BINDTODEVICE.

Test:
  // Python 2.7.18 (default, Jul 13 2022, 18:14:36)
  import socket
  SO_RX_IFINDEX=3D82
  s =3D socket.socket(socket.AF_INET6, socket.SOCK_STREAM, 0)
  c =3D socket.socket(socket.AF_INET6, socket.SOCK_STREAM, 0)
  s.bind(('::', 8888))
  s.listen(128)
  c.connect(('::', 8888))
  a =3D s.accept()
  print a  # (<socket._socketobject object>, ('::1', 58144, 0, 0))
  p=3Da[0]
  p.getsockname()  # ('::1', 8888, 0, 0)
  p.getpeername()  # ('::1', 58144, 0, 0)
  c.getsockname()  # ('::1', 58144, 0, 0)
  c.getpeername()  # ('::1', 8888, 0, 0)
  p.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 1 (lo)
  c.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 0 (unknown)
  c.send(b'X')  # 1
  p.recv(2)  # 'X'
  p.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 1 (lo)
  c.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 0 (unknown)
  p.send(b'Z')  # 1
  c.recv(2)  # 'Z'
  p.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 1 (lo)
  c.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 1 (lo)

Which shows we should possibly fix the 3-way handshake SYN-ACK
to set sk->sk_rx_dst_ifindex.

Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 arch/alpha/include/uapi/asm/socket.h  | 2 ++
 arch/mips/include/uapi/asm/socket.h   | 2 ++
 arch/parisc/include/uapi/asm/socket.h | 2 ++
 arch/sparc/include/uapi/asm/socket.h  | 2 ++
 include/uapi/asm-generic/socket.h     | 2 ++
 net/core/sock.c                       | 4 ++++
 6 files changed, 14 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi=
/asm/socket.h
index 302507bf9b5d..5f139b095a49 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -148,6 +148,8 @@
=20
 #define SCM_TS_OPT_ID		81
=20
+#define SO_RX_IFINDEX		82
+
 #if !defined(__KERNEL__)
=20
 #if __BITS_PER_LONG =3D=3D 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/a=
sm/socket.h
index d118d4731580..ff25d24b4dea 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -159,6 +159,8 @@
=20
 #define SCM_TS_OPT_ID		81
=20
+#define SO_RX_IFINDEX		82
+
 #if !defined(__KERNEL__)
=20
 #if __BITS_PER_LONG =3D=3D 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/ua=
pi/asm/socket.h
index d268d69bfcd2..3f89c388e356 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -140,6 +140,8 @@
=20
 #define SCM_TS_OPT_ID		0x404C
=20
+#define SO_RX_IFINDEX		82
+
 #if !defined(__KERNEL__)
=20
 #if __BITS_PER_LONG =3D=3D 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi=
/asm/socket.h
index 113cd9f353e3..f1af74f5f1ad 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -141,6 +141,8 @@
=20
 #define SCM_TS_OPT_ID            0x005a
=20
+#define SO_RX_IFINDEX            0x005b
+
 #if !defined(__KERNEL__)
=20
=20
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/s=
ocket.h
index deacfd6dd197..b16c69e22606 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -143,6 +143,8 @@
=20
 #define SCM_TS_OPT_ID		81
=20
+#define SO_RX_IFINDEX		82
+
 #if !defined(__KERNEL__)
=20
 #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32__=
))
diff --git a/net/core/sock.c b/net/core/sock.c
index 7f398bd07fb7..6c985413c21f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1932,6 +1932,10 @@ int sk_getsockopt(struct sock *sk, int level, int op=
tname,
 		v.val =3D READ_ONCE(sk->sk_mark);
 		break;
=20
+	case SO_RX_IFINDEX:
+		v.val =3D READ_ONCE(sk->sk_rx_dst_ifindex);
+		break;
+
 	case SO_RCVMARK:
 		v.val =3D sock_flag(sk, SOCK_RCVMARK);
 		break;
--=20
2.47.0.105.g07ac214952-goog


