Return-Path: <netdev+bounces-195096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 663A4ACDF60
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 15:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FC7188C741
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 13:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE4528FFDA;
	Wed,  4 Jun 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ihgd5vuM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE21C4C92
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044320; cv=none; b=fffcLE7Sgr5huH4vAHEhrltbf0jVquM9NTmqG+S0IQOF392MD61tzn3izv2kCPFpdnlV+cY5VFqCCaMzcO+7TEeFN+gUTCos1rnBkTFHJEXGZvY2qNN8IuNwGFlu26+1ISaYA9m034NUaDPQ1cNhLF9frFOxFah95XqHFNlTSnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044320; c=relaxed/simple;
	bh=cGErVJ4bmTUQIicSnO7KQhivuRsnuHBrKz4OD/rUbh4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uFcoIqsZi+KsUqJL+JCX8mPLXfnpTXO1DZ30R5xm8U3BGddgfNASNJWPFrPT2onw0ARr4kX+mfzQOR8OgSa7cQufTykQyUXIYuwWmoJ1jew7e97tCcOClTQz1GZBlpT/WInU76yngfFiYrpRN7bUV5MoJDu2c47GwXUmk9AN2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihgd5vuM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7370e73f690so7850052b3a.3
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749044318; x=1749649118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=POMSTg6GJrne9/5wXc7WtA5ZTG+gDotXCkvMvnEGUlg=;
        b=ihgd5vuMVxI/gwPLRxKwKXSIcRXv4fA+gZ+5AiMEYXRfvI5vc789btaBl1t7mgpwaJ
         YTBC0Q5nSyOqiaILmPW3TKuhakbSRJbih99hkQEgbyl4ykuEyMxNPTg7qI7JVvuJHy+g
         63x5Oxcb4wt25pFLbfxO9pyUElc/yra88uf/sNyTry4PRmf3EnyDAyga2Cszx+PJfsph
         0lr0Mk6Dz4xI1qPnDEyg7aiMpqk6BbOKz6iH6JiCEBO0NH7G3K2llzepSkYNpg7cf+p3
         I+ksYlfodIeKM8Fu3j5tf4Me0POEQIC9XmGiUN589zyIigvqYVDt13jWaL0SDDLyZKwg
         hcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749044318; x=1749649118;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POMSTg6GJrne9/5wXc7WtA5ZTG+gDotXCkvMvnEGUlg=;
        b=uTrhXwWeWvYWKv+Jd4ywtve7v9zBUT3FiFMH2CRLy6WwuquhMfcMIrxedowE1eLPBO
         U5AZnCVgw0kburDmdGUlBbKOShbXLcZenOJVFJDm0dl6FSxA/SLfpf9VfdN/pO0V1xwx
         dV29wmpLRDDC5q9n8h++xZwbfGWrGMQIJmTRPtzbDl396OIqUm00TLB9adl1HDHkkeSb
         SCChzOzHhXdbbAxAJnGOEnwH/PK3KIh6CaLnPM7iX5mBrvg1ZWybRTWDdCT78ikdAJVA
         D8EPuKppf0AiQP2DWJIv52Q8AC+P9gj/OC3iQgczgFpWJQ173rgsldFqnrEvXvBauR01
         vrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxRruElO5L54n4DR9oWBohkiKSJC3FJIR8Gpjvb1eyjU1jhCW9KjdSH/Orxk7Lh9rqsrkXq7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUrD7OS/ChXnEpCtsRGm/2ei7PViEaGnf8PMwvgr1rmh/mTbnl
	Hkn61aYszCH8LVexiqS5loO66xfQxCp19cmCb45a+HwMv6aa2ZD6cjKBlRE6kFvsahw2DoR9CmQ
	YthcZyJnEwZlvpA==
X-Google-Smtp-Source: AGHT+IF4vNgBqWuqwN249CIMQHd9G+lKks99KaKviFeWr4MDQkTIvS3MGZ7G7Qa3Isdk0xrtzD7k4gXdR3NpcA==
X-Received: from qvbnh10.prod.google.com ([2002:a05:6214:390a:b0:6fa:a797:22e5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a0c:eda9:0:b0:6fa:fdb5:4a9d with SMTP id 6a1803df08f44-6fafdb54b14mr7053036d6.44.1749044307524;
 Wed, 04 Jun 2025 06:38:27 -0700 (PDT)
Date: Wed,  4 Jun 2025 13:38:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604133826.1667664-1-edumazet@google.com>
Subject: [PATCH net] calipso: unlock rcu before returning -EAFNOSUPPORT
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot reported that a recent patch forgot to unlock rcu
in the error path.

Adopt the convention that netlbl_conn_setattr() is already using.

Fixes: 6e9f2df1c550 ("calipso: Don't call calipso functions for AF_INET sk.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
---
 net/netlabel/netlabel_kapi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 6ea16138582c0b6ad39608f2c08bdfde7493a13e..33b77084a4e5f34770f960d7c82e481d9889753a 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1165,8 +1165,10 @@ int netlbl_conn_setattr(struct sock *sk,
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		if (sk->sk_family != AF_INET6)
-			return -EAFNOSUPPORT;
+		if (sk->sk_family != AF_INET6) {
+			ret_val = -EAFNOSUPPORT;
+			goto conn_setattr_return;
+		}
 
 		addr6 = (struct sockaddr_in6 *)addr;
 		entry = netlbl_domhsh_getentry_af6(secattr->domain,
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


