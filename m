Return-Path: <netdev+bounces-231884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B080EBFE458
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 23:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A11D04E6555
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED992FF15F;
	Wed, 22 Oct 2025 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/3A7BCc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3FC2701B1
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167848; cv=none; b=mH34gTFE6nB3fGgYfi/f6FXcfNNjjhl+7unhXG442nIOloVp3TiI+g9yDs3ietk48f67UZuoU5yYnS6jkSDGOO4qCzrpRA6EDK63o1+voiAdFt/OGIztddcBFabdlTz6Ou5UMhXhDpoR3n18ziJQ3+AUd1I/y5Pao/XaYia3xpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167848; c=relaxed/simple;
	bh=ahGep6W32+gNV6oNtpOuYveNFz+hFzSORjjfmF+eRZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ca33g3sent2MyAH42YutF4oapGEKhrvZr1S5NEU4hqM7hb9aExfubDE89jT3jzIKB9n1Gtt6sqOE7S1lueDiPXDToBjnd1SLWYlpxjlCGuDpcR4dzfCYxxMjCG67Ik+v64dWlu9CNK4tUG0uy10DHs8TRwyZA226EFcYh1ZdDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/3A7BCc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-339b704e2e3so88091a91.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761167846; x=1761772646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zC1K3IqyVSO0xtPymYXFv2IA0fNslGgFU0Blzcbsmno=;
        b=N/3A7BCcvIgMLf1iQ+tYgZJC91KJWkAgj1GoqBrrpUfBN2E8NzX0cHBnGJvnnFN7Co
         IQDzDdZbjnkgssV0cO2BZeGP4Fccs/nQLWE+SL4i/oJqS0XEjubnXH4e4nIoghi1UYp5
         2wXjCIFvzb6IKo6k9PAgvCPDUE5JvLt5FAB5j8go0A0g6a3A8GgSbUFQQAT75C71r/Ab
         M1ZC8SuYwp9GZP6NRA6/D8RNnVs59DjMGsf1iYU0+9prrxyn7Q2EcpOnvctQjFPM+Vj6
         ww0vnMBuZUCfJ4WPdte1YbG3eTMYYXtCZT9grCluYzExuBbmbwlHDU0VIX/riTeGJiKL
         jHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761167846; x=1761772646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zC1K3IqyVSO0xtPymYXFv2IA0fNslGgFU0Blzcbsmno=;
        b=nx0Gtpk6mi4da6GXjCzBaYmphVZIGTrzEZAMaXA1/jUP6zo/KFMBmRGz0igMXnvo6z
         HPE/DRTmZRNPSagothyWTPj2CkcHMWUjHRbuxI0PLMzlG52bS2WMFWf0v0KPSmlmjOR0
         bnoFK507M1zpb2vJOf+irqndcA8e/BmFhYqLKaPv5JLyaI0tWzTzQItpPuqeH3hVL/GZ
         lwNoeVxr4CdW2xa4RhjWZndAeJa5wykldFDnWCTeZpLbsb6rxERuXwTvtNzZD6UgjnIX
         yAeyEGdP3DXhj02WlupGvRLwzbdTeAIA2UDlENT9c/lalgfkMWpx8elLz3MS1rZoqBmt
         Eb9A==
X-Forwarded-Encrypted: i=1; AJvYcCXCuI4LgzF3Ecpe7INV6U9y/VWUJlhTcIgXYkuw18njaEXvYQMrtaWiTVdyGnolFLkR9tMIDMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOQjycEL8iFbEPTLSy7fXMHhx2MIIW0X7rKZMCbQj5UL+S4XFd
	uFg67jgVXaR8rWOxzEnqRmYvhaGEyJjvG3xGKw+LBpiMk1MZwVHZafz/9CB6U58OJd+8vET9T8o
	EtWC5qQ==
X-Google-Smtp-Source: AGHT+IFWEulJ5rWTn8gl2RfPZa6sZRrfZaT0vTzM1+EoEHyNwJau+tizb6zu7WA33NEsXmZNF6/glxvztEI=
X-Received: from pjyd13.prod.google.com ([2002:a17:90a:dfcd:b0:33b:cfaf:ce3e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4a:b0:33b:aaf9:e980
 with SMTP id 98e67ed59e1d1-33bcf939e86mr30875872a91.35.1761167845941; Wed, 22
 Oct 2025 14:17:25 -0700 (PDT)
Date: Wed, 22 Oct 2025 21:17:01 +0000
In-Reply-To: <20251022211722.2819414-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022211722.2819414-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 1/8] sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().
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
index ed8293a34240..d190e75e4645 100644
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
2.51.1.814.gb8fa24458f-goog


