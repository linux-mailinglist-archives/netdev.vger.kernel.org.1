Return-Path: <netdev+bounces-134365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A93998EBD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F591C21DB5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FC61C9ECA;
	Thu, 10 Oct 2024 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WI6SQKTB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B371CB309
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582508; cv=none; b=EzIQbWGbzr6hkiRX1O2SvfktWAFM3VOjeGmEfhUBwQprXYGo82iw1H7mpXtcN4uuGfhvOAw2dofoaG7IFqsbBTzBdJ2SCahWtvvilWrM8nrgd+Q+Ewhjf8cyUog6xbU7v6CEC/U2gHQb97aD08Fc9/AbD+VjjCF7Yofhb46/kG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582508; c=relaxed/simple;
	bh=NzATUbh43EuFGnCyQ3XlFjHgissJsk7ZS5HmjCC4Frs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QDkPGnln/XwY3LTCpaZYVcrmXSPxqIIg/NPoGKJ4Q4rfvAzjAALmrY9DgD3v5Z/sZwuWA9rguPu5pxoJoLYn614oulI1Pb/2hxZ4EIXNLRbQEsquRFBnSjb6taMJlXxNcC/E8L23fuvKPD9xSgEp747ROrsROtczr2KZslhHVuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WI6SQKTB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3231725c9so22705827b3.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728582506; x=1729187306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h3wiCBXZ8nr1yKT9yyi5IAvXAKwwla0kpy0xY/U0HUc=;
        b=WI6SQKTB+qyl+hG+CfMcgJG2cgiiQwzZdOCuvV7HMPushJBLFdlmH3gGHsw+NKohf4
         mIKS0fM/T+IVn1V50MKiE7dJhazUyQ/npnuCQTvkixzhH3S+GAkyS3cIf+inV1tAfn3B
         0G4fbdMb9MUMZJjgqdda3BEzlLlCJoNnLedyqP58OCycV7fOI/2KIvjeies9Qs7AaG74
         m0RRpIFW/rrkVm9RrC8vWLBZt5SQnrTw1J/Olz2V/WFC6czjkMz+7vIbf99IbfuWuG5J
         PQCRSQF1X8i5e9pw4uvtSdq8WbrpSjmHuYM/K4cESSM6B8KcLEhFsVBScZoqV+/LncxL
         wTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582506; x=1729187306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3wiCBXZ8nr1yKT9yyi5IAvXAKwwla0kpy0xY/U0HUc=;
        b=vhwwKJ4mSENpvB4evIj2xyF/kFEdNE6b0jU0dOmZSqaC5RrhHuI/gQODp3fpwrtwBp
         1SuH7K9u0GMwOZ+egcjxtgS2wClpOXkMbxaG1PSxxRijowg+1MXzG8OxAfDFiBg4mHg+
         rUn9rGkUHcnrXm+iuKaRkpiKXHqCvOT6cFTtZTAlvOQ2eHqIdIKL4RPceEjovJE1kmT0
         DyA/EPpguaWErAfZEb12zBre7mPvnSVqBFOOWZHdYpAp0KaU1NAKfDXyHpL0plXhJj2d
         vsHeR2re3O8/AX8Ko4DKXHmd8zwCgPw+xO/2XFmlHh1vWondW0NdiYbt43mFjODVDK8d
         /iHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJQjikS32q/Jsm7Ctp+vR+CP6fekiZpCsFnZMkOLt+QRzcwOmLl/mo5J1sGCawjoem0KAJMhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrq7wHPNbF/ubqrW29QTnlv6UcEEE/FyAk8zSZklGg89wA34+n
	/AO1cNusCYBFrmyWXd1NXmQc7f1jgYSd/W7fTQ25X/nKKBAJJyXVeBSoJXEARjaY4R6GPDwhcSt
	8oxR/H2swDw==
X-Google-Smtp-Source: AGHT+IHO0CfV6PAIF8JSqKWhMs+641yhNfHS7BSmwz6Iu0/Zx+TbUUkxwh6rPx/tVbJyg3FEnGABjMXnZYaDMg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:4046:b0:6e2:1eba:ac07 with SMTP
 id 00721157ae682-6e32216f5b0mr732147b3.5.1728582506406; Thu, 10 Oct 2024
 10:48:26 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:48:16 +0000
In-Reply-To: <20241010174817.1543642-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010174817.1543642-5-edumazet@google.com>
Subject: [PATCH v3 net-next 4/5] ipv6: tcp: give socket pointer to control skbs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Neal Cardwell <ncardwell@google.com>, Brian Vazquez <brianvv@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_v6_send_response() send orphaned 'control packets'.

These are RST packets and also ACK packets sent from TIME_WAIT.

Some eBPF programs would prefer to have a meaningful skb->sk
pointer as much as possible.

This means that TCP can now attach TIME_WAIT sockets to outgoing
skbs.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/tcp_ipv6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7634c0be6acbdb67bb378cc81bdbf184552d2afc..597920061a3a061a878bf0f7a1b03ac4898918a9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -967,6 +967,9 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	}
 
 	if (sk) {
+		/* unconstify the socket only to attach it to buff with care. */
+		skb_set_owner_edemux(buff, (struct sock *)sk);
+
 		if (sk->sk_state == TCP_TIME_WAIT)
 			mark = inet_twsk(sk)->tw_mark;
 		else
-- 
2.47.0.rc1.288.g06298d1525-goog


