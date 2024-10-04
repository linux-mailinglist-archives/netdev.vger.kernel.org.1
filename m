Return-Path: <netdev+bounces-132213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4014F990FA2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C42F1C231A7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458021D90B0;
	Fri,  4 Oct 2024 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mx7qh+pJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC55E1D8A10
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069416; cv=none; b=Xgl0euIV8qa39LOMfU8ZhpxFXnWpMKT/ZSkz8TyBAdjYpPCosaJmCpYDOXDJclwA0QJHYpBbowhocr0a/NiGtQhR8sZdNqAwLaDejFLDUshxJwCIeUGvMr9rLElR7TA2WcgDE13wdXa8rtWxgBOxx3s419lab+uEIbG4SxkHvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069416; c=relaxed/simple;
	bh=0rzp6qGAOYnBUXj/52siehyJKvpdFknwMUEQ4grP85g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Za/0oeFwMQCd1NZ5bq4UJMInJAdY0mm+IQqEhPhfEVqNSPFWIr4N6pLyiDDK2OonNLXTbY6Y7+qgrA5nqLOm2Qe3OJ+dTpzbudNRS0MkhsG+mPkMnT6hQ/wONdWJ3u3JOitDKUJaol4uOQ8VSVCtoOMJROOv/whtLilONdVMdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mx7qh+pJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e251ba2243so30602167b3.1
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 12:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728069414; x=1728674214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGl4Ykkhxa6wsFpVpS2Ggk5e4pmo9W77Io/UbFbXN5Q=;
        b=Mx7qh+pJkjLY0AbGpa2ZFdPvHpTkIPC4cF1aj0T71jNj9sGjGQyK2Ug00oMUa4upgx
         E+mwL1KoDBsB+jK/mMHywzpzdkH3ZGYKbk/EGDrzOpw5QALwF8dtOoWXVyuBoY0W/VTk
         PxZSJ5GkC4igt/ULyJqkA+qSPXnJ7RSH8kN0kPpHik9mcdQPzW36OJWIFtZ27dilcG23
         OGhciZSiObI6OxjPoACDvN19A0qOOVhUmq9NeqHIuz8NewlrmzAnYKFuEzqxur3oiiMB
         lT3iMNlj/X/eaUcITS2vybDSYq1OSoXi142o70IgwO952wq9FRvfmIedbLagnUaR4aYU
         7zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069414; x=1728674214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGl4Ykkhxa6wsFpVpS2Ggk5e4pmo9W77Io/UbFbXN5Q=;
        b=dKgbgAb33eAxmX69hk44FoBqag6Z2Cc3YxvwwHNYnJi/SstriIujFjONvS84uiyMvO
         TF/49D4aIRieDKGVXVrdVzMhwNV/JLdtDMpD74ESwjFeo7kHLbT7wAjdjm0C3LyAOWAP
         UJogfnMQdiGrzs2sPP9Coq+C8wFi71c/e10UvsIkMhY+8iDaYZDJBh/WWY2B75GdfeCN
         fsAlbNfVq4VSBOavr0YAMfu9Htr70LV1Y3u1DZDXFCiAcVxjKzvnYU0F2o+wrjCEXnxi
         vEFOOYES/92xjwJ0l6w3E/3aDusYPtFDVi1EC2TRAtL+x39txsWdA+U3qzdZh+5fgfs0
         bU2A==
X-Gm-Message-State: AOJu0YzKXObajkr9zBck2KIfq5j5VUmHQPDP/RqJqnQmJMm+azjRHu7z
	rcJPE6yAmMhGibtC7Z5YlKpuMeeIdJ1pPOCYuIMjHND+KFW5S2UPxVZ+cb/OT3Dg5lHG4iH/WgC
	I77bACNdScg==
X-Google-Smtp-Source: AGHT+IFYzTM6qsBwAhyEqWyqdXHRPaFUxH4rSS2aQUAFSc4GroIJ35gOs1Og3JCR+73Hk6pjlvdC2lkiLlK/9w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:95b:b0:68e:8de6:617c with SMTP
 id 00721157ae682-6e2c7cd7ee0mr815847b3.5.1728069413766; Fri, 04 Oct 2024
 12:16:53 -0700 (PDT)
Date: Fri,  4 Oct 2024 19:16:43 +0000
In-Reply-To: <20241004191644.1687638-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004191644.1687638-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241004191644.1687638-5-edumazet@google.com>
Subject: [PATCH net-next 4/5] ipv6: tcp: give socket pointer to control skbs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
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
index d71ab4e1efe1c6598cf3d3e4334adf0881064ce9..9a15adb8dbcc1e518d43e4e9b563b5bb29ef9430 100644
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
2.47.0.rc0.187.ge670bccf7e-goog


