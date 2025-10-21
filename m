Return-Path: <netdev+bounces-231405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04F1BF8F8D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA57561AF6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8229BD87;
	Tue, 21 Oct 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLr3swXP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F428DEE9
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083069; cv=none; b=kkWKZlf1ZFkLnq+y8uPcWcAq6b4o8no8vBIBrD3YXMW3qYyWEGlAz22VztJFxfgLnceRThuYGaX0GwnP2Lna0h9Fuy3vr8NY5EPMDJwekJWVAOwGE9cgyInNxNRLLCXjALiDRn6addZRM1VMx+GuMfE1hDt9pS0Sg0yLppI2N50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083069; c=relaxed/simple;
	bh=oI182w+3/w2Jty/1Eyh1rrMFlr+F7MQsgTtQgllv2xY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZiGRpqkpEZwkL9mrFtSUIm6LVoOKiEhkwUnq31pvSXqvBUHV0VxXQij1tXJ+2Xn2W4Iq7+lQ64hzcdTVp7J1dyHHiW1UvJXovmDIGqZ3YGpVxZ2oU02KCr45GseJ/jDJiEGlY/p09itVXNlf0lWEezGjfaKQY8n8K92hDXsbrU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLr3swXP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befbbaso6937694a91.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761083066; x=1761687866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MXBXsodVanh3OYdvkwJQrtN9kzbRMBdJEJt86Qp/20o=;
        b=KLr3swXPaolBCTq1Iy64B0Q9LywS3Nhk4FfdmhzbBw+giRJMW/6MRStyXPeKZmX6hD
         P/RlDf12AhYC9U7r3OpATAOLXG1waRIL7lhd4wi3zPIIqmOwEKhPyoDBpeI/Yzoq456x
         kSrciSzN5nKv5frbXF4nLbl4jJuZoQiVcWRCmp93uUTSDlx2FFz7S5v6aup04jqZYTGM
         dAGizqT/N3gq3tA+LMmrN0ZTa0YA6Y7OUq/iZMZPR3/+HA0EhOsV2KqSlTnvPeNfJHgL
         jepum7pycGVtvQaxM/W9isCBcDz/XSURdycPlovDyJmxmfrvHTItbsJkcy5VMl0h54pZ
         stgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083066; x=1761687866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXBXsodVanh3OYdvkwJQrtN9kzbRMBdJEJt86Qp/20o=;
        b=SccGFXxvWGTmyJlXiwTbm0SJgH/vtBkD01hJviAdviZTmIMpihRy5G3PtPQ8qflmqA
         1iVJOZSFnzEfZ6YeufulbOAGzYBBYuowEvXXE06RHS/L+n56FYX5dlWjKbAg9yu3iX/J
         jWZ8f9uQR45L6LZHoTKSphaWyvyhGsnfZvPB1L60HzDinFVXN7kexESRMlOWwvKCxZFJ
         Ae6PXkYF9xGefz+VJ+T7N/XYtXvju8Otcuq9Fq2Ur6J7zrPDyIeAbybHuOH6wgIvE/hK
         MROfkoesv2N6GXaVqHSZNg0RJubhylyr5fukRzCNVHDohhJckMphWNx0w5fTrsH36gbN
         1QLw==
X-Forwarded-Encrypted: i=1; AJvYcCWi5JSXaBr5R1qgU7yuqIyf3yj5o0lhuld7R39ujXarzzpnHinVWjCsPHA3otozKMPP+wwaAR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLsRvHteGF+KGBDoFDbku6Vy3sbGP6TAXcu5YXsauENkcSWsPT
	/F3myQzMg2zCBGJ8AtEKCLHSJokkLr8RrDAPAuH62xyPu1t1XMSTHS/o0xM74y2CvuRmssmgo4o
	zpE1J2g==
X-Google-Smtp-Source: AGHT+IHHnGo1mjqpxdKpQpIk/9tIv+uycvG0KrAybrx1oGANHCEJ6/+f/u6dV2TSahHFO09IyLVEliyd4jc=
X-Received: from pjbgj22.prod.google.com ([2002:a17:90b:1096:b0:33b:b387:9850])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2690:b0:33b:a5d8:f1b8
 with SMTP id 98e67ed59e1d1-33bcf86ce26mr23024066a91.15.1761083066294; Tue, 21
 Oct 2025 14:44:26 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:43:18 +0000
In-Reply-To: <20251021214422.1941691-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021214422.1941691-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251021214422.1941691-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/8] sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

SCTP_DBG_OBJCNT_INC() is called only when sctp_init_sock()
returns 0 after successfully allocating sctp_sk(sk)->ep.

OTOH, SCTP_DBG_OBJCNT_DEC() is called in sctp_close().

The code seems to expect that the socket is always exposed
to userspace once SCTP_DBG_OBJCNT_INC() is incremented, but
there is a path where the assumption is not true.

In sctp_accept(), sctp_sock_migrate() could fail after
sctp_init_sock().

Then, sk_common_release() does not call inet_release() nor
sctp_close().  Instead, it calls sk->sk_prot->destroy().

Let's move SCTP_DBG_OBJCNT_DEC() from sctp_close() to
sctp_destroy_sock().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/sctp/socket.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index ed8293a342402..d190e75e46454 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1553,8 +1553,6 @@ static void sctp_close(struct sock *sk, long timeout)
 	spin_unlock_bh(&net->sctp.addr_wq_lock);
 
 	sock_put(sk);
-
-	SCTP_DBG_OBJCNT_DEC(sock);
 }
 
 /* Handle EPIPE error. */
@@ -5109,9 +5107,12 @@ static void sctp_destroy_sock(struct sock *sk)
 		sp->do_auto_asconf = 0;
 		list_del(&sp->auto_asconf_list);
 	}
+
 	sctp_endpoint_free(sp->ep);
+
 	sk_sockets_allocated_dec(sk);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	SCTP_DBG_OBJCNT_DEC(sock);
 }
 
 static void sctp_destruct_sock(struct sock *sk)
-- 
2.51.0.915.g61a8936c21-goog


