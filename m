Return-Path: <netdev+bounces-163450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323C2A2A4A8
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6040F168567
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10998226183;
	Thu,  6 Feb 2025 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxjrCUiB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4564422687E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834486; cv=none; b=Zg6nZBTxgaBBVIQ28mVaLNbO3dAxqyC4aki6ylchDlDuDo8fPcFabWNRV8MKjFVrd6NZ1QHFyaU2wp8yj3J2U8McioVxnUnPYGwTmUBfKf0ZM7981N20+EqpFHlUSUtI7QRGRtoHPHj4y14ghqhkSrrgagVTf4JWJr9YoOw7gps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834486; c=relaxed/simple;
	bh=V/yrAGNf1B7zfGwG5q6rfhlSPWKIsGAjw6fZPh1m5ik=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JTwlOgWmK/rfeoc+OY+TJJGrlvpPZTcfjZ/14tarzwAatoMQsyDb5bz/E+mKbLm0jhXSM/vSIxa2iu5d6d2y9bbqCAwnua8ZhKk8RW3NMHVny+bRt9Gjf4TBC+0D7P+l1O3lxHd5K31iv2Ca4mNpAkZGmJlLA/xxQbHJ3B8MPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxjrCUiB; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7bb849aa5fbso147619985a.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 01:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738834483; x=1739439283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uurtZs1xfXC02uauUJAY7AwuD97Iy6zlJvIoGP16pYU=;
        b=NxjrCUiBaCYAXnWOVGWZ83j8Iy+LhNyRagn1MTmW+czLY2hkri5sFBvvkDDGjQ8gA0
         z77ECD4uJAshUVYL94Iuislllh3PvrBHrA6bdfKKCpONARkm6vjNs82nS2MIWonyCxE7
         gMxrghgmN2/A48+umMaJxmoLrKdQFSXNmf+ihRtTYmxfk4MxWt/ApChh2NpbmiJMGkxe
         SLJRnTcIi0ciRwtCtzhWcTnhcOW7Wd3XbTqKcIvsk+MF4fOsZftTYcyvMQRFSwl1K0sV
         +Jsao8xINYheYIiyr9fJb0V1d0b/+TidnTD5iUwoCi6dZDBiA2VmT8He6xi2MEB0OLpF
         CyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834483; x=1739439283;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uurtZs1xfXC02uauUJAY7AwuD97Iy6zlJvIoGP16pYU=;
        b=IRb0hkvhwSttxJJPXsd9voz+czTYP1voc/G2sbpP5tUxaFQ3DzPkNtmi1vYoznR/nP
         aUh0w5JzjoJ1bJGKBUl8l7MG2os8hxRlD5prSGlg+OPZMHdWszHqI8g/LIJLNeqfZBZa
         mmQT+pkMJGNVD9TInWRx+3Rf9GAm+WZ+ZJQFpVthvrcosjuhPiwiN60xCENRbmeawtt6
         Zo+SoWHOiYlHHhXBNB/hxvq+VzR0K4HE0ufPXQqJBymZ0zN581JUbEPx6s1Xz4S7Whrj
         m/Sifz4NS9B/ddZS9TCbIJXqjji1oCWsu7gVUxq1SSS0Oej/LGAaQ/epAqD65DdnJc3O
         MXXQ==
X-Gm-Message-State: AOJu0Yx+ysIuqFGNa8ZTdZE8t7gpBrMvU0Sdb41hG755uyR9X5e0FsZ7
	QJeX3u8AXSLAdzq5rmLfNPXFzowS0ONZ4gyhLM2RIRSYmTAH4KrrW+PF3mhOZU5h9ZY+tFtvilm
	MPDOeGj11/g==
X-Google-Smtp-Source: AGHT+IGsvK0ytXfhmzr+OnY2hTTK+GKZcixtx3dH+Q9EYfDociyyzODH5eoWeU9K9eVo/2dsI62CMezV0FxXrQ==
X-Received: from qkbdp7.prod.google.com ([2002:a05:620a:2b47:b0:7b6:742e:a33e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2710:b0:7a9:abee:992 with SMTP id af79cd13be357-7c03a02d532mr902526785a.50.1738834483138;
 Thu, 06 Feb 2025 01:34:43 -0800 (PST)
Date: Thu,  6 Feb 2025 09:34:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250206093436.2609008-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: do not export tcp_parse_mss_option() and tcp_mtup_init()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These two functions are not called from modules.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c  | 1 -
 net/ipv4/tcp_output.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index eb82e01da911048b41ca380f913ef55566be79a7..61da8ffc2f86fe59a1853a3651b2fc8d96bbe34a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4174,7 +4174,6 @@ u16 tcp_parse_mss_option(const struct tcphdr *th, u16 user_mss)
 	}
 	return mss;
 }
-EXPORT_SYMBOL_GPL(tcp_parse_mss_option);
 
 /* Look for tcp options. Normally only called on SYN and SYNACK packets.
  * But, this can also be called on packets in the established flow when
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bc95d2a5924fdc6ea609fa006432db9b13444706..ef9f6172680f5f3a9384132962d6e34cfbf83f14 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1813,7 +1813,6 @@ void tcp_mtup_init(struct sock *sk)
 	if (icsk->icsk_mtup.enabled)
 		icsk->icsk_mtup.probe_timestamp = tcp_jiffies32;
 }
-EXPORT_SYMBOL(tcp_mtup_init);
 
 /* This function synchronize snd mss to current pmtu/exthdr set.
 
-- 
2.48.1.362.g079036d154-goog


