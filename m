Return-Path: <netdev+bounces-60484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5879981F7EC
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 12:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF331B20A2E
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147216FCB;
	Thu, 28 Dec 2023 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="aL0LjljP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FAC6FBE;
	Thu, 28 Dec 2023 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T164805BbzMpr0x;
	Thu, 28 Dec 2023 11:39:36 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4T16472wZjzMppB5;
	Thu, 28 Dec 2023 12:39:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1703763575;
	bh=HFUa+gi6H03BBjcBoQQZYSYsAH4d4PrSY7gBDXIdSxw=;
	h=From:To:Cc:Subject:Date:From;
	b=aL0LjljPs1ZmEelw3LKIuJ4a56TODbjHwEsslr1ax65dsQEyfy3Nj0ZePlhmm7f4h
	 kYyEqYaFZpl0HYakOinZKl4eKlaWokxqT8f4+8dwve7gNEpFWSwHQDDkrxeR/yURiZ
	 MRnX+Wpl4Iaf5B7pEoVJbTgj/3hgJTbpykm1GlLM=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@parisplace.org>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] selinux: Fix error priority for bind with AF_UNSPEC on AF_INET6 socket
Date: Thu, 28 Dec 2023 12:39:17 +0100
Message-ID: <20231228113917.62089-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The IPv6 network stack first checks the sockaddr length (-EINVAL error)
before checking the family (-EAFNOSUPPORT error).

This was discovered thanks to commit a549d055a22e ("selftests/landlock:
Add network tests").

Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: Eric Paris <eparis@parisplace.org>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Closes: https://lore.kernel.org/r/0584f91c-537c-4188-9e4f-04f192565667@collabora.com
Fixes: 0f8db8cc73df ("selinux: add AF_UNSPEC and INADDR_ANY checks to selinux_socket_bind()")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/selinux/hooks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index feda711c6b7b..9fc55973d765 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4667,6 +4667,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 				return -EINVAL;
 			addr4 = (struct sockaddr_in *)address;
 			if (family_sa == AF_UNSPEC) {
+				if (sock->sk->__sk_common.skc_family ==
+					    AF_INET6 &&
+				    addrlen < SIN6_LEN_RFC2133)
+					return -EINVAL;
 				/* see __inet_bind(), we only want to allow
 				 * AF_UNSPEC if the address is INADDR_ANY
 				 */
-- 
2.43.0


