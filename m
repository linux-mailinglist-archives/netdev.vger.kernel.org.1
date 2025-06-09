Return-Path: <netdev+bounces-195802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B07E7AD24BF
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F0E7A2811
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B418F21B9DB;
	Mon,  9 Jun 2025 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZjPwz9lx"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B5B21B8EC
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488978; cv=none; b=J3NlA3CNgnqLuoaHa2eCoprgf4MoVsa/mT37es/eDJEen8+XvPex0Cqo7sfvf9iDIGLoDrP2ql3hTAcs781MqFxA8pfL4QV94FQzjzfkyNOtPhkM1TGwJqMudxklRaxxt0GqlFvgRikS5Ra8X/+J6L0XtEssipqCJzMgVXrb4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488978; c=relaxed/simple;
	bh=ejShZg3nrpO6t61lC7z8J0natiNtxxqmp/l4Uo1BTzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gVsZkOx9UOec0kVHwBfy7w7+68U7W5fSKLy7EVwq5m2SiAfO6IhvQaX2i2qRwmloaQsmPuBxR2O1fhUYv4cRigdifZv/xDWuQ/y7/luH//HVsZfHb7eF6iGpO7pckxHYgmEqeIYDT2jHCsqgFf6YrGC6o57EysinbMP+gsaOVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZjPwz9lx; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uOfzs-005947-Nq; Mon, 09 Jun 2025 19:09:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=K62tSSJO9AzfPfkS5uR12qqvaFjnl+xhv7L+AEP9hsc=; b=ZjPwz9lxlTYO4dOlYrCPRqpn1B
	imk7KtYIP2RXb+Q4dpsNfZg6dVH2AnBxm7Lix1b7/UC1bQW+BMJTZF4HKm7MJ7srTw6xBIsV1U6G4
	L2CVrmXdSVJVLXj+wn9//MqfQC+66oPHH75Glxhm0L4T0uK75zJOHiI2RxzvztYQPphMgAgGeKTL1
	B6Xp1KP2Hqq7OCf4ym9qdcCCbVqBC8go9wvoERj4Otvxaken0gy0r1RXR/ICvQKvh+uB09RvdIvTT
	JivTL7om6nYXC4EneRxYIyhbRIEg3qKRSQVP0RFR+8mdU1MlIqJH/9xfmPvvgURkPacWMPqv35XPq
	Tayg6U7g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uOfzr-0005ZP-E2; Mon, 09 Jun 2025 19:09:19 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uOfzi-00EhDz-Qx; Mon, 09 Jun 2025 19:09:10 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 09 Jun 2025 19:08:03 +0200
Subject: [PATCH net] net: Fix TOCTOU issue in sk_is_readable()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-skisreadable-toctou-v1-1-d0dfb2d62c37@rbox.co>
X-B4-Tracking: v=1; b=H4sIAPIUR2gC/x3M3QoCIRBA4VeRuU6waQ3pVaILf8ZtKDQci0D23
 Vf28rs4Z4BQYxK4qQGNfixcy8T5pCA+fVlJc5oGNGiNRavlxdLIJx/epHuNvX71xWFcMOdwdRZ
 m+WmU+X9c71Cow2Pbdg3pfnRqAAAA
X-Change-ID: 20250525-skisreadable-toctou-382c42ffb685
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

sk->sk_prot->sock_is_readable is a valid function pointer when sk resides
in a sockmap. After the last sk_psock_put() (which usually happens when
socket is removed from sockmap), sk->sk_prot gets restored and
sk->sk_prot->sock_is_readable becomes NULL.

This makes sk_is_readable() racy, if the value of sk->sk_prot is reloaded
after the initial check. Which in turn may lead to a null pointer
dereference.

Ensure the function pointer does not turn NULL after the check.

Fixes: 8934ce2fd081 ("bpf: sockmap redirect ingress support")
Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 include/net/sock.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 92e7c1aae3ccafe3a806dcee07ec77a469c0f43d..4c37015b7cf71e4902bdf411cfa57528a5d16ab3 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -3010,8 +3010,11 @@ int sock_ioctl_inout(struct sock *sk, unsigned int cmd,
 int sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
 static inline bool sk_is_readable(struct sock *sk)
 {
-	if (sk->sk_prot->sock_is_readable)
-		return sk->sk_prot->sock_is_readable(sk);
+	const struct proto *prot = READ_ONCE(sk->sk_prot);
+
+	if (prot->sock_is_readable)
+		return prot->sock_is_readable(sk);
+
 	return false;
 }
 #endif	/* _SOCK_H */

---
base-commit: 82cbd06f327f3c2ccdee990bd356c9303ae168f9
change-id: 20250525-skisreadable-toctou-382c42ffb685

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


