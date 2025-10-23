Return-Path: <netdev+bounces-232279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1180C03CFC
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254313B4599
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 23:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B1D2BDC00;
	Thu, 23 Oct 2025 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+YMU/nD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71D255240
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261477; cv=none; b=h45XMGYonZt6xa2BAgt7BEZ2NZ/0a4jv4XjaaBgYTMzu5Yl3ikYF+SQGneJJt5yCcLPlP8ysMtl8SNXTwTA7bnRL5kbA+qsxBeBBtrSEsWb1G5yAZNRk8rhxF7nhaLAGxMUyWRpaRxgZOGJiYkHSYwI2FLGRv8o9zQHVJOlS+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261477; c=relaxed/simple;
	bh=eepb6CFfGDQC09Sy/24Rtzwj1pIvAFykxiZYQRBaCpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EIfS0VSS78cOOOv9hygdKe+ZfkntxUYfun9kfKkD9Y6e81h/MEmC1DyfRcXC9qZgENwfJrDG2N88isfBppmJAWr40UrEqxGX1uZ2TVQnr4YZGh9e+Tq4zA/VXpCKhzDKqw7fvKo4Cn7g8aOJ0Z1Jh2OnaVXrBw+WMIoPl3EgdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w+YMU/nD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b55443b4110so946813a12.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 16:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761261475; x=1761866275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LXl5yVRKLn6z/9KiE3OHahGyzawPLwWd2qFS+XcPUHo=;
        b=w+YMU/nDt2QYec4WswuvwhQ6Cuy8xTsnNvcHsz5qknyHEW/vp9pxV8xfhizP28+67f
         U8M9A4htRAKdBNT2QI4EkdDhFBPk9BbGzboJnPbnBNRL6O1DoNKBKAzfNx81/WNDCG7x
         6x0F4jXdRBjCz9FARjOBlw+QEaSqw9G9gIcpWJsyzQuCjcJJL1npC3JWZExlGdrvDLsm
         0UogG2pPKachFWzSHIJRKAnB0X69FOElneCbwHNG0dfWVHfE5ANaGypSA7+VozL7Cffo
         BC8/WA8WThYJZSJ3QCWkpbaw2kS1aJ2W4lAORtPJyMmBQpDxFTxuCwzWu/mdIyhGqreh
         7yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261475; x=1761866275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXl5yVRKLn6z/9KiE3OHahGyzawPLwWd2qFS+XcPUHo=;
        b=FQvqtXyA6rgUqv/jLDVjXaittDO7b/fMR3+S6f/1BBoszEGdCPL9zL3xSCAs7S0fBs
         FRHw7sFyvEwTqGBmPGSUHbfhbeZ0xaWegDYAGSovVorrsXmDNupEzP5pGIEuMvrfvw8m
         dbWgq8XfBzuFA4P8XbaALfqbmEr7QCn2FV/y+wOcrSCigZNgaX4Tjc+1Tz+XL+NRQ1WU
         xIG+Gbd8ynupWyiseouEr+O6NLOY0Aq2bpxxS3hlIDFANi0XIzKfnO7OITB3ujhJLAyY
         92BKBsZxoZitNKn5X9pLaQFWxvsPVOhZffOe7VITv2G+279MywwkxVAAQRxrzVzyqvGD
         U0EA==
X-Forwarded-Encrypted: i=1; AJvYcCXH81ntWUK/kI3ynmNmhkJhWn2gu0K4k2kVCSqy16SOWr3bSMGWPMNGJmloojwNZqqwmWNhXRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywps0kF/ZiZ3mvOW+wduPrcGAb74emxkVySkKL3DwgAV3M8wRXo
	e+NMNaz/WKEDOj4Q9Vpd54VLXuk+00wRbstw2GvNhjpucWC71WFU66F+yjwqYYRSStxeJMSp88B
	PC/hzag==
X-Google-Smtp-Source: AGHT+IFG1MdEPQO7YAbbzAkIP0iM7lCxAwhvxAYF8d3H7vOOyZetkNz59Pnl/AE/wSQ5gCRBbooZ5OlRJpg=
X-Received: from pjbpb12.prod.google.com ([2002:a17:90b:3c0c:b0:33b:ba24:b207])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a08:b0:33b:20b9:d249
 with SMTP id adf61e73a8af0-33dafdf9809mr854413637.0.1761261475247; Thu, 23
 Oct 2025 16:17:55 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:16:50 +0000
In-Reply-To: <20251023231751.4168390-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023231751.4168390-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 1/8] sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().
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
2.51.1.851.g4ebd6896fd-goog


