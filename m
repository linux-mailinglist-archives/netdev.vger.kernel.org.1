Return-Path: <netdev+bounces-244521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 386F7CB95E2
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCA9330E92CA
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30AF2D949E;
	Fri, 12 Dec 2025 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="Tz72vEDr"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4C2D948F;
	Fri, 12 Dec 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765557883; cv=none; b=eW4Aw7zrVq/9SGoVNxrP5cRoZPIq4NaUcZZV3KzX3H9LfaDvIG6vcepAZ7UmNBd4/iVWfQ9Ts7BNSnRrOBA98r9vIv0y6m1Et50AiwvbV6kdBM0RQ6YQMN1QxTjlo2RGGeOB4QE78f5o//K2OdshWP5uIDo/J2SJk2nF8mSgKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765557883; c=relaxed/simple;
	bh=sjrFZKrpSHviCDWjRbwp3v938e4qqR4vg3h8Q3I52/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=knPjpPnqR1GOdCas634Zc9eLt+yDlbxp84y8S9WiYIo+7ZI62gGr+N8DUX/lE6MIzMYJCIR3dXeiqVZnQcCV7nEPLrcEQsQoDOj3QguAV3czKlBJ1LKacXGoYnsa3asALLLXmuqkxRNP7hypiZ2sZ68OwDqiL10w9vNSWQIFUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=Tz72vEDr; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1765557425; bh=sjrFZKrpSHviCDWjRbwp3v938e4qqR4vg3h8Q3I52/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tz72vEDrO1Cn9Nz7TZh3d2qKV4TI9++WhWJ6pkz8UNH5d6PodhHZ8A4AtufeksKPc
	 DI0ARTT70PQ6Q8HwUJK5VuB5iCekjM15hnG+PEBKDgv9VUiMqHVXN48uGvgXS1PErS
	 ZSSvmceuQv59wrA9sXEDzgOMe9UjZp1MV0bxlh1YxMBdLKGdsXpeLxHGXRX+iYyPFo
	 OhwYYrh8QajwQOji4VoeUZmkDjSzR+SHuNrHQxWJVTjYhFS3Ivjr5m0jF1Sd/+EeP0
	 YySrZ5Hem/U5boa/zEIzXj05XqnZZzTfjs+XpI/JDutoEBzg7ea0EYcxIwb2Rojb0p
	 pGj2xOaPJ6wMA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 064C2125485;
	Fri, 12 Dec 2025 17:37:04 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v3 2/8] landlock: Refactor TCP socket type check
Date: Fri, 12 Dec 2025 17:36:58 +0100
Message-Id: <20251212163704.142301-3-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251212163704.142301-1-matthieu@buffet.re>
References: <20251212163704.142301-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the socket type check earlier, so that we will later be able to add
elseifs for other types. Ordering of checks (socket is of a type we
enforce restrictions on) / (current creds have landlock restrictions)
should not change anything.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 security/landlock/net.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index e6367e30e5b0..59438285e73b 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -62,9 +62,6 @@ static int current_check_access_socket(struct socket *const sock,
 	if (!subject)
 		return 0;
 
-	if (!sk_is_tcp(sock->sk))
-		return 0;
-
 	/* Checks for minimal header length to safely read sa_family. */
 	if (addrlen < offsetofend(typeof(*address), sa_family))
 		return -EINVAL;
@@ -214,16 +211,30 @@ static int current_check_access_socket(struct socket *const sock,
 static int hook_socket_bind(struct socket *const sock,
 			    struct sockaddr *const address, const int addrlen)
 {
+	access_mask_t access_request;
+
+	if (sk_is_tcp(sock->sk))
+		access_request = LANDLOCK_ACCESS_NET_BIND_TCP;
+	else
+		return 0;
+
 	return current_check_access_socket(sock, address, addrlen,
-					   LANDLOCK_ACCESS_NET_BIND_TCP);
+					   access_request);
 }
 
 static int hook_socket_connect(struct socket *const sock,
 			       struct sockaddr *const address,
 			       const int addrlen)
 {
+	access_mask_t access_request;
+
+	if (sk_is_tcp(sock->sk))
+		access_request = LANDLOCK_ACCESS_NET_CONNECT_TCP;
+	else
+		return 0;
+
 	return current_check_access_socket(sock, address, addrlen,
-					   LANDLOCK_ACCESS_NET_CONNECT_TCP);
+					   access_request);
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
-- 
2.47.3


