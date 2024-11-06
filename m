Return-Path: <netdev+bounces-142538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AABF9BF922
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404042820F5
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDFE20C486;
	Wed,  6 Nov 2024 22:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSeESIhn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544061DF265
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931566; cv=none; b=Q5k/tCQFNMkbcDsdwfVRZFNW7xm9gYDaMCDhfNRD0MpVNNTU2TAbM9fxEQDIFau3FQZAQEcHXmgdR1ShfPPxBWE/OeAxcOuZo4AHfGBUlExUmI4cgm6hyPBcsLkZ4m8f5L4P/3Cob5Cb7GnupHCChkiXL5S0rVLZ/vuR4n4w5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931566; c=relaxed/simple;
	bh=kjRuAVZN7YhfW/dlbodqbLjBeqpEsJKbMhP3nEZWvuk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UTpGY0quy8OvAAhuK58o7b37h9P3YCWYFosxCQJ1OcCemTTCIIss6ZuR8GteCI1s4LSiIYBF+nWZfnhv2xQtCyBednqCJV9uUQuFOtR4zv3sQ13OhbrWqMhfYXvHoxf8RQYFxC9LQKrAaNzwQ96cVuhJ0939fztEjDFfWjkqPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BSeESIhn; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6cbe4fc0aa7so4030816d6.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 14:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730931564; x=1731536364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QDw05guzxwvDuA9pzT6sKxBvGBvVvZZwVtPv1bmSrsg=;
        b=BSeESIhnJPrx+b14Q2Tk3DFH4DeDG5XJN5piKFCl04MhWEHyzt2+J1imBhfVyDhoBv
         G0xSNbDbIhC20y+SEtO9qKeo5XC+q76UXejgW1gvS5vy1U5KTQVLvG707/raAfkDbhT7
         PrfRpam8uxmSUF9Vg0XV5eJSpA+4Rij+vQLfpkMUEeZvRPYQSvUihWZm6HgAtCBMU4lE
         6DEx9K9xNllI1tB+0J0GKrhdC5HrJ7xFWSx4SL+zk4JtHxl/BaVhsOG09YjNULKo4J1w
         B0Z/3bVB/QmicANXosv3OZ4yTzYzo5W5dLfiAJwNxoi9RZTPY6xB9AmoFvrY61TEZwz4
         9FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931564; x=1731536364;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDw05guzxwvDuA9pzT6sKxBvGBvVvZZwVtPv1bmSrsg=;
        b=tSb8g+6Kve8ZIlytuHYq+Ge+5zRv74LZPSezGiD7Cgwgb0CPQVsWx9MNMnldOGA6gL
         AO++GdQ0zD11yG7oAzdV8uXCWX86i8S0Bpoh/x5Gq4jlILnnMMqK+gAdpQ0pe73yx9s8
         52UhS4jXpL2IHtSBdztvRllwV7VtxA+XOxdOVaDpIptS20nn8zCfADzWmuFp3Lt8m7Ty
         sofldctLoDXPCHEB3vcCOXkBeMXlwC9wI5jKdf1x8m+tiObvSp368z8xe3njsyBgQ+r1
         pdqg+MkcVINbfLgP/R9W/GFknIaxmevw+Sn4ZRzGStjXqRqMnZ/rNFob/MuRwNwj7M6J
         FGiA==
X-Gm-Message-State: AOJu0Yx0C6Jcg0CPYcf1a57s4g6XXinbvK580ZQvlvGlIjCRivkC7Ho1
	W/AzKJF+IUjKMIwu97caJXep8O9ycnMnemiZnwOJw9Oxs/Y8L8p5g6B0pNa0fb4kKLmUl0Hhfbx
	KEpTYXpI9/Q==
X-Google-Smtp-Source: AGHT+IHtk2Tji6VSSXHqIUHRbfLEzlnfmPsiicqB7M9gqrs+51WHfyM/9e5ZwY4VACuyGqRoMyamIucAOqb8Xg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a0c:f986:0:b0:6cb:e7e8:9ead with SMTP id
 6a1803df08f44-6d35c17a8a7mr196216d6.7.1730931563979; Wed, 06 Nov 2024
 14:19:23 -0800 (PST)
Date: Wed,  6 Nov 2024 22:19:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106221922.1544045-1-edumazet@google.com>
Subject: [PATCH net] net/smc: do not leave a dangling sk pointer in __smc_create()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Ignat Korchagin <ignat@cloudflare.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Dust Li <dust.li@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

Thanks to commit 4bbd360a5084 ("socket: Print pf->create() when
it does not clear sock->sk on failure."), syzbot found an issue with AF_SMC:

smc_create must clear sock->sk on failure, family: 43, type: 1, protocol: 0
 WARNING: CPU: 0 PID: 5827 at net/socket.c:1565 __sock_create+0x96f/0xa30 net/socket.c:1563
Modules linked in:
CPU: 0 UID: 0 PID: 5827 Comm: syz-executor259 Not tainted 6.12.0-rc6-next-20241106-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
 RIP: 0010:__sock_create+0x96f/0xa30 net/socket.c:1563
Code: 03 00 74 08 4c 89 e7 e8 4f 3b 85 f8 49 8b 34 24 48 c7 c7 40 89 0c 8d 8b 54 24 04 8b 4c 24 0c 44 8b 44 24 08 e8 32 78 db f7 90 <0f> 0b 90 90 e9 d3 fd ff ff 89 e9 80 e1 07 fe c1 38 c1 0f 8c ee f7
RSP: 0018:ffffc90003e4fda0 EFLAGS: 00010246
RAX: 099c6f938c7f4700 RBX: 1ffffffff1a595fd RCX: ffff888034823c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000ffffffe9 R08: ffffffff81567052 R09: 1ffff920007c9f50
R10: dffffc0000000000 R11: fffff520007c9f51 R12: ffffffff8d2cafe8
R13: 1ffffffff1a595fe R14: ffffffff9a789c40 R15: ffff8880764298c0
FS:  000055557b518380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa62ff43225 CR3: 0000000031628000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  sock_create net/socket.c:1616 [inline]
  __sys_socket_create net/socket.c:1653 [inline]
  __sys_socket+0x150/0x3c0 net/socket.c:1700
  __do_sys_socket net/socket.c:1714 [inline]
  __se_sys_socket net/socket.c:1712 [inline]

For reference, see commit 2d859aff775d ("Merge branch
'do-not-leave-dangling-sk-pointers-in-pf-create-functions'")

Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Ignat Korchagin <ignat@cloudflare.com>
Cc: D. Wythe <alibuda@linux.alibaba.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Dust Li <dust.li@linux.alibaba.com>
---
 net/smc/af_smc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 0316217b7687388de37e0dfe1e11fe6b4ee6b628..9d76e902fd770f5b10d9cd8ae977f1d80552066f 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3359,8 +3359,10 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
 	else
 		rc = smc_create_clcsk(net, sk, family);
 
-	if (rc)
+	if (rc) {
 		sk_common_release(sk);
+		sock->sk = NULL;
+	}
 out:
 	return rc;
 }
-- 
2.47.0.199.ga7371fff76-goog


