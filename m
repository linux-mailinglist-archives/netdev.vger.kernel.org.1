Return-Path: <netdev+bounces-204028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE7BAF87EF
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0A01C21734
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4A924C068;
	Fri,  4 Jul 2025 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiLlCexu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F524887C
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751610264; cv=none; b=XNQ8vQMH8qo00pQXg0gMDGQVZx6Siwe6ZI5m0m8CPMlD92I4v1AoF2uXJQBunCaT9ClnsEioxg+bn7DdWJfBUzxdfV31HRsRfPphD5neqAtynoNcNQeityIXk62ynuGTt58Zuvzwqkd8F4VVLrfSOXKBo/u3TWIU9c46S8TIR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751610264; c=relaxed/simple;
	bh=ss1a3WoMumBRxWoS2u/gB9RspJTAN9uBm+XZMLYS4QY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oRrO+xnxmqYuFdr/i+6Er6JvMNKD6A+jN36yCb5mRXEarBAdJT67YNfZMiVOvhttmMPG5zgrUG6W1HjwTXqS1VKuSIiT71Fqm+9x95hrmwKTCVfbcb2F7a2LTnoYyCW+1NZk19tLpqklZVk3rYn+yjpQF9eTNN+ChG2x97vDzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WiLlCexu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23692793178so6337485ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 23:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751610262; x=1752215062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FU2p5KPSKOjBLosIOwcO+JuAB0SeYJwOYD2dkWC7D4=;
        b=WiLlCexuHcPt3C1CA4XKyqTJty7u0d3/EizcW1Rh+glPVN9vTSUolROtCMIYPivIT4
         e/TDex8/xJLMdil+SUxfI74wDtlMDKAaQ5VxYFni4Hmyr2IXgOzb0JB3ikGqrvofDzp9
         QF5XJkCUExRJlHw7Zq/n/bNIXIcu229lXVdUy6b3bsAWOUHULy+xKFv+04+B2wnAwi2k
         Ajs+GM4QttwXnLaUdz+Th6O1dz8qjBD1Rz4S54/3H9YKe8BG0DqvgTPeBpIHkp0rj5rR
         DG1OdXiDsc9uD+L+bq3hsNL335qCcz4JdI8jjw3gdT6q3BAPPGoVt1eBIwLlO3ETkZPP
         MS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751610262; x=1752215062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FU2p5KPSKOjBLosIOwcO+JuAB0SeYJwOYD2dkWC7D4=;
        b=QjT0nvbHSPvmJ9jKGc1csA/tGDF0CKPi++iE77lmcmtRIO4lpm8lE4mUsRqfgte6m1
         qDLaootfMufCPlkmpRVgEKx8dMnAOZrYWBlLrTewhUTHEYiwvycE/DlSCqjCxvS3zIXD
         vYtZiYatFgxRHJhDClSrU7cmiodVHgNjV4DCALpaZWbBxfEQ5GCL3wY5ec/AFcyCPb80
         lcRYlgUlfqTXW3tTpjYbOeO8Qd3UKksvOGLsA9nFUkHAGWuDknFkoLaShRf4c90Z2r+Q
         o6/9/6uLvA18N7p8TLsQr7lgnLy+Qae7qwFWX1xaysaz6hr9paVmOh2rBWEAUvB19A77
         CN4g==
X-Forwarded-Encrypted: i=1; AJvYcCXtncaFr9Fe2iyo89IgnL62Q8qLixzvZnpNAvzfGncfkNGQUMOhAmIcfIvHGlI2TIBNrEkYsvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMsyqCNK6p0O4D2qZlpuGuJMYux6EYG8nLvQYDvHf1GFVEe8J1
	TlwI80/Rzrs5EtEmwhW1mcqa5DOLSjaZcMM4vrIssU2DQ7m+lqaT+QD0nkevrEiI1DC/WkdhnO6
	sjO26GQ==
X-Google-Smtp-Source: AGHT+IGmsIcXBEJXqi5szh0A87FM5Enjra9zjxVBxeXgkbbT1sbRta4PGzZ6tu4czcNlGfPhlxKDFOTL1UE=
X-Received: from plhk8.prod.google.com ([2002:a17:902:d588:b0:23c:8603:9e00])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f10:b0:237:d734:5642
 with SMTP id d9443c01a7336-23c8613c6a0mr28321605ad.41.1751610262328; Thu, 03
 Jul 2025 23:24:22 -0700 (PDT)
Date: Fri,  4 Jul 2025 06:23:52 +0000
In-Reply-To: <20250704062416.1613927-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704062416.1613927-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704062416.1613927-3-kuniyu@google.com>
Subject: [PATCH v2 net 2/3] atm: clip: Fix memory leak of struct clip_vcc.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ioctl(ATMARP_MKIP) allocates struct clip_vcc and set it to
vcc->user_back.

The code assumes that vcc_destroy_socket() passes NULL skb
to vcc->push() when the socket is close()d, and then clip_push()
frees clip_vcc.

However, ioctl(ATMARPD_CTRL) sets NULL to vcc->push() in
atm_init_atmarp(), resulting in memory leak.

Let's serialise two ioctl() by lock_sock() and check vcc->push()
in atm_init_atmarp() to prevent memleak.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/atm/clip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/atm/clip.c b/net/atm/clip.c
index f36f2c7d8714..9c9c6c3d9886 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -645,6 +645,9 @@ static struct atm_dev atmarpd_dev = {
 
 static int atm_init_atmarp(struct atm_vcc *vcc)
 {
+	if (vcc->push == clip_push)
+		return -EINVAL;
+
 	mutex_lock(&atmarpd_lock);
 	if (atmarpd) {
 		mutex_unlock(&atmarpd_lock);
@@ -669,6 +672,7 @@ static int atm_init_atmarp(struct atm_vcc *vcc)
 static int clip_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	struct atm_vcc *vcc = ATM_SD(sock);
+	struct sock *sk = sock->sk;
 	int err = 0;
 
 	switch (cmd) {
@@ -689,14 +693,18 @@ static int clip_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		err = clip_create(arg);
 		break;
 	case ATMARPD_CTRL:
+		lock_sock(sk);
 		err = atm_init_atmarp(vcc);
 		if (!err) {
 			sock->state = SS_CONNECTED;
 			__module_get(THIS_MODULE);
 		}
+		release_sock(sk);
 		break;
 	case ATMARP_MKIP:
+		lock_sock(sk);
 		err = clip_mkip(vcc, arg);
+		release_sock(sk);
 		break;
 	case ATMARP_SETENTRY:
 		err = clip_setentry(vcc, (__force __be32)arg);
-- 
2.50.0.727.gbf7dc18ff4-goog


