Return-Path: <netdev+bounces-288853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PZLDLOeCmpJ4QQAu9opvQ
	(envelope-from <netdev+bounces-288853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:08:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AB0565DC5
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7BB83008C1F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C4A38947A;
	Mon, 18 May 2026 05:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPqRBvg+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DBB3890FE
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080853; cv=none; b=r6xoehT4Ev8J1h4zuSZYGSDWR/Z3tfpzLd1f/aQBGRwBqUg/2U3YZb7HFIPZPc5oIs2jiW11aCHmqSk3A6mJxHK3V8WmFmFe3qMefL0pl49rNEci+pCSOExFllRTCuIja0iM+ga/lWlTKdropUG7cTY/nxsdn7E8+zbA1snEJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080853; c=relaxed/simple;
	bh=r499Di9Hokshi1Y6fI3eedJtvJ1aKuBQNReYTOefmTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PZLQfvIHiCWu1PMybaTJkyb7gD0yz5+z87kxbyQzmuVkm1gxLKnuMrFCB832LBWQTcdSB3xpGprdnWxrY1fiG7zRhhtrnAW7Hx6X07bbqi2DW6pXKoiqJJfm22jWuDxABVnkwWxq+3u75Aj60GPdLUvV1aCphZjeCZbhA0vQdFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jPqRBvg+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365fc4636bbso4167814a91.2
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779080852; x=1779685652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OsqTyVioLkIOXJSxMUadfToRl54+U4BL2jWjIN0phC0=;
        b=jPqRBvg+eENLxzi2IDwZVUmGgTmxU9u9gecwU4g8dcSheGqCMWZTxciOzMvMsTFvmQ
         jnjaf/0zBcMuUlug+YY2J9/TDQGTKvDrTbEyfOR/35z1xFUN2YiZLQOZ7I2INAHsU+6c
         iH4DQm7YWlqD59FlwvMwcPOyeH2UjYbwxVMKhHpmbPYOd1bXn5B9+OX/pKGwPL0S5M16
         lYcUcoDqMQBycqUj5ZkGToM2BtMdnJIIc7s1U7dLUidDPKdy9H2E9n/Ew35v5HAxWCa4
         9lfxVw8/15AOFXMJAZF4w0Q61S9b0+Wotd9gYuhjpxR8rRCOFRlaBk/zsMwn/DlbM5yy
         1WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779080852; x=1779685652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsqTyVioLkIOXJSxMUadfToRl54+U4BL2jWjIN0phC0=;
        b=MMxiVBfEMyKplMM1aNrLyldg2wU2/p6QjDo/0w0ZLNrTGghFu+7kpTXQ1/M9+1t3Aw
         iVHhpM8JgSdcS5gOuBpnQfm0abaabiKvbO8YtIDwXk6j4PgBw5xI4/HuqN/9LvO5W9O+
         PCxNtEuxIJ1XN8ix7PxxFaIVLW1Yss7TK1u0CbPznEekSqxqttXthe2MXNis7nDvGIuu
         CkB40/bw4nN8us9RTkM3DuXgcoCHRKna+VxqXck8xX/ga6TjysOraTZT6kiwDFQjA/28
         YctVEuDMyeykQrbFJIWKfoL2gNSt8RoKPNHKZqpR5XF1tc53aSSeq8F7FqsV6rAUcq4l
         N5bQ==
X-Forwarded-Encrypted: i=1; AFNElJ+usxQC0JBbzbmD20CwduEd0TrWbRz1BvpvIP8WbAC0i0gShEqj1aDbNl080QNQhPDMMgL0iSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMdFr5sRgB0aqymTeVhhJk9c+vpVZpR/yn1PTNiXXyzN08S8Z
	FNH34IvKKxm7V5oEHVdEfdItv/lad95wg0fVIlm7Gq9RZYmGSJvZBP2jjpNRo2XrqElfH18FfYK
	QiDMjrw==
X-Received: from pjwt6.prod.google.com ([2002:a17:90a:d146:b0:368:3aec:213])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:56cf:b0:369:a74b:28cc
 with SMTP id 98e67ed59e1d1-369a75a769dmr4844718a91.18.1779080851510; Sun, 17
 May 2026 22:07:31 -0700 (PDT)
Date: Mon, 18 May 2026 05:07:11 +0000
In-Reply-To: <20260518050726.318824-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518050726.318824-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518050726.318824-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/5] bareudp: Remove synchronize_net() in bareudp_sock_release().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C4AB0565DC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288853-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

synchronize_net() in bareudp_sock_release() has existed since
day 1, commit 571912c69f0e ("net: UDP tunnel encapsulation module
for tunnelling different protocols like MPLS, IP, NSH etc.").

It was most likely copied from a similar tunneling device like
vxlan or geneve.

bareudp_sock_release() is called from dev->netdev_ops->ndo_stop(),
and synchronize_net() in unregister_netdevice_many_notify() ensures
that inflight bareudp fast paths finish before bareudp_dev is freed.

Let's remove the redundant synchronize_net() in bareudp_sock_release().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/bareudp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 890a0650d9cf..bfcecdcffe67 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -287,7 +287,6 @@ static void bareudp_sock_release(struct bareudp_dev *bareudp)
 
 	sk = bareudp->sk;
 	rcu_assign_pointer(bareudp->sk, NULL);
-	synchronize_net();
 	udp_tunnel_sock_release(sk);
 }
 
-- 
2.54.0.563.g4f69b47b94-goog


