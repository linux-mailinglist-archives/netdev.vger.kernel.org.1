Return-Path: <netdev+bounces-178589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3960A77B28
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 14:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7082188F748
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C50B20126A;
	Tue,  1 Apr 2025 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G6Kx5mH9"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124291F0E56;
	Tue,  1 Apr 2025 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511253; cv=none; b=Fjfo5wemffn7ncVBZL0fpjntLjMQF7RUDYWNix5w47fqFl111aDOWp6GVTxfP8ZKzPKcMxakGqJdKNgtDbRky5xIW6pOuru4TnXWdPErBIvsq5Fx3WYBptTayaFJAZVLsCXtzBIAI1e/KZC4WQpeFiVLIcIX2D4I5MrkeUx6ELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511253; c=relaxed/simple;
	bh=Get7KAvoCaSnLRrPLPueAHCZCSCjbAm1U96QKIwX9RA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CCgElouZWUL87kijBz6mjKTj/5fuFxu43Xk9g6eLREdcUyFl1PWZ5BPDOklULR+Scl8U9Qj2kJY3gAf2jkOLsPfsQRknpIpAlCne80sCIDedNTkYNXeTmoF8iWKKO1UtFKg5mukp5aorGguJkH6cBzpSobNN//DEI7ulbvzwQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G6Kx5mH9; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6+nnE
	i89eaWkxtOk2uXcxBBZ5vP3fWMFYrDB8rldhD4=; b=G6Kx5mH9vyvEeZAKu41nB
	JOOg4O0//KJXxpE/acxhJ72DXkdVZzA8GsH7TPQ6UsuttLG++zY2OVma58OQqj6O
	N7DyHde3O9AFxapM9u7QVuwWJ/WqBVVk2zGCvzZy2jEEK2owzPlwz3hjpvLbBhrq
	db26P8TA0RC7O7uD08pRVM=
Received: from WIN-S4QB3VCT165.localdomain (unknown [36.28.141.24])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBnc1qy3utnVqF_TA--.58053S4;
	Tue, 01 Apr 2025 20:40:20 +0800 (CST)
From: Debin Zhu <mowenroot@163.com>
To: pabeni@redhat.com
Cc: 1985755126@qq.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mowenroot@163.com,
	netdev@vger.kernel.org,
	paul@paul-moore.com
Subject: [PATCH v3] netlabel: Fix NULL pointer exception caused by CALIPSO on IPv4 sockets
Date: Tue,  1 Apr 2025 20:40:18 +0800
Message-Id: <20250401124018.4763-1-mowenroot@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2a4f2c24-62a8-4627-88c0-776c0e005163@redhat.com>
References: <2a4f2c24-62a8-4627-88c0-776c0e005163@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBnc1qy3utnVqF_TA--.58053S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryUZF1kZr4DXFyUCr4xtFb_yoW8tFWrpF
	9rGwn8Zw18AFWxWrs3XrWkCry3KF48KF1xurn2yw4UAw1UGr18ta48KryFyFyayFW8Kwsx
	Xr4Sq3WYk348Z3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zio7KfUUUUU=
X-CM-SenderInfo: pprzv0hurr3qqrwthudrp/1tbiXxAilGfr3gwPWQAAsx

When calling netlbl_conn_setattr(), addr->sa_family is used
to determine the function behavior. If sk is an IPv4 socket,
but the connect function is called with an IPv6 address,
the function calipso_sock_setattr() is triggered.
Inside this function, the following code is executed:

sk_fullsock(__sk) ? inet_sk(__sk)->pinet6 : NULL;

Since sk is an IPv4 socket, pinet6 is NULL, leading to a
null pointer dereference.

This patch fixes the issue by checking if inet6_sk(sk)
returns a NULL pointer before accessing pinet6.

Fixes: ceba1832b1b2("calipso: Set the calipso socket label to match the secattr.")
Signed-off-by: Debin Zhu <mowenroot@163.com>
Signed-off-by: Bitao Ouyang <1985755126@qq.com>
Acked-by: Paul Moore <paul@paul-moore.com>

---
 net/ipv6/calipso.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index dbcea9fee..a8a8736df 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1072,8 +1072,13 @@ static int calipso_sock_getattr(struct sock *sk,
 	struct ipv6_opt_hdr *hop;
 	int opt_len, len, ret_val = -ENOMSG, offset;
 	unsigned char *opt;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
 
+	if (!pinfo)
+		return -EAFNOSUPPORT;
+
+	txopts = txopt_get(pinfo);
 	if (!txopts || !txopts->hopopt)
 		goto done;
 
@@ -1125,8 +1130,13 @@ static int calipso_sock_setattr(struct sock *sk,
 {
 	int ret_val;
 	struct ipv6_opt_hdr *old, *new;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
-
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
+
+	if (!pinfo)
+		return -EAFNOSUPPORT;
+
+	txopts = txopt_get(pinfo);
 	old = NULL;
 	if (txopts)
 		old = txopts->hopopt;
@@ -1153,8 +1163,13 @@ static int calipso_sock_setattr(struct sock *sk,
 static void calipso_sock_delattr(struct sock *sk)
 {
 	struct ipv6_opt_hdr *new_hop;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
 
+	if (!pinfo)
+		return;
+
+	txopts = txopt_get(pinfo);
 	if (!txopts || !txopts->hopopt)
 		goto done;
 
-- 
2.34.1


