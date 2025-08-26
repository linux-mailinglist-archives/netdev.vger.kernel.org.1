Return-Path: <netdev+bounces-216919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D67B35FAF
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1872F685700
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18862186E40;
	Tue, 26 Aug 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+coETAl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F61E411C
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212649; cv=none; b=o2Fq9SCzvX/E3KoaFijntlANMNbDRnNwZ5c/cdcKCl30dHPM//Ts7dTGz1uG8yLBdSVY4PViWzp2yx/hNZE+NvFAeWymbgSpvsNZI+BL2IIK4VaHIYHHh3/wNPE7hPrknF6xTLxC/SS9DIFsSzm3nAnOlwmaYwvbInHO/Hc4ii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212649; c=relaxed/simple;
	bh=aR2Z1r2q6dr4apDp4I9Mxg9lj4nJbn8N4G4bZjqo5lk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QvWu3Zr3sPc8Ha7Rm7JPb59c5odVfwVxyG4QArloOSwC7wEIGYYzclghdiMngZkZ7Oe9FBYSpJJksSrbiXJVhtkJERPNB5jM+/pTqYkgK6dn+ZVrhfkT45HqDRbtuIhgLTcfHywol07KMmB/MVHYF12/OiFm9IzMqmGoDPjI4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+coETAl; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e8706c668cso1436381185a.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756212646; x=1756817446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xrOkA3oYw2dOrIGkyrujqSdFVXYObQw4fJ66SaxLd8E=;
        b=u+coETAlFKa/uGfL7my+Vv1I1O7EEJs24loG77gnzF/KZP9K0Pjv5Cml5tJw4L9SZ3
         /D4PtgaWEizindeictUYdIaYpN7Wl9qJ5rtTtfdf7vvKRzPf/kOQ3zgWO3xxdawYQFB9
         ymB+GB/PMZpc2VL7grmrhPh4Lil9pZ8lye2ktVGGd/nCHSgbNaChJVs19rF46FP3Uelk
         9WyClOxFL8axTDZ3Gcb37w6AvCh0StAWBBPPC1DT34XgyufxCzPvsMJwuugdRii0zv3c
         KsRaF8ytCTSoi8YQHVr7ShHo0EEh7mdzv3ALePSHX7MWvek9krGrevUPjwfFOl85luT9
         pvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212646; x=1756817446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrOkA3oYw2dOrIGkyrujqSdFVXYObQw4fJ66SaxLd8E=;
        b=rGEp2IKAzmbRKFukXjFe7Tu3wJvduFbYG+fKXDZVN4Dh3WBYxsVeVJDFAwWH4QXFNG
         xz8w+1ZCMfD7vrBoaiem15Z/nfk7oEcPK3TuTYlvBBMj+lAhLlUAHyfZzvrI0GMiDKIM
         cCDbo8+MHBE/jiXoj152RWY9rvRl0IaMOO34M59irQsWKPr/JXwHUuHkXUQ2hbFqcbg2
         OuIFGYSazOUsJCkCPAUjQ/MTi+WIcx7DFuAcJL3baGHCr390OZRKGfx2zQpBMpBluuz2
         KEGuovZFOMGHib55dmMOqsgiSirwV+QvW4QLq4NhcgbNRHgMUfhlmccb+ZORigtR6Qhy
         j6+g==
X-Forwarded-Encrypted: i=1; AJvYcCXJnr+qcJuW5JQHjZ8M9QmtsbY2pQSb8hQc2Z87+fgEaAUEfs1hGc6Mg16Ou8h4LLpXM6KL7m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpOzKf1pzIff62v80vqCegWJS9mbdr7vB1jLAzldAa4NK03WtA
	ixhnVqJpy8DwceYsP77S+I1YozTf+fIEkomNV3QS1Hj1o/xyOWRCLXvitUaJZ8hzlCkgnoxLCdl
	XGfsXkkML4ISPag==
X-Google-Smtp-Source: AGHT+IGImfDuwQOSBQk7o/EqCXkgZaouk/pmktRGZ2F8uOplUxl8ygoq0vQWl76WjvsjoOGjMrUTvNwQvKCWNA==
X-Received: from qvbpr11.prod.google.com ([2002:a05:6214:140b:b0:709:dd9d:b828])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:29ec:b0:70d:ad6e:ec27 with SMTP id 6a1803df08f44-70dad6eed58mr148361846d6.23.1756212646407;
 Tue, 26 Aug 2025 05:50:46 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:50:31 +0000
In-Reply-To: <20250826125031.1578842-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826125031.1578842-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826125031.1578842-6-edumazet@google.com>
Subject: [PATCH v2 net-next 5/5] inet: raw: add drop_counters to raw sockets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

When a packet flood hits one or more RAW sockets, many cpus
have to update sk->sk_drops.

This slows down other cpus, because currently
sk_drops is in sock_write_rx group.

Add a socket_drop_counters structure to raw sockets.

Using dedicated cache lines to hold drop counters
makes sure that consumers no longer suffer from
false sharing if/when producers only change sk->sk_drops.

This adds 128 bytes per RAW socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h | 2 +-
 include/net/raw.h    | 1 +
 net/ipv4/raw.c       | 1 +
 net/ipv6/raw.c       | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index bc6ec295917321b38489efb4a82897ad02ee9b52..261d02efb615cfb7fa5717a88c1b2612ef0cbd82 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -295,7 +295,7 @@ struct raw6_sock {
 	__u32			offset;		/* checksum offset  */
 	struct icmp6_filter	filter;
 	__u32			ip6mr_table;
-
+	struct socket_drop_counters drop_counters;
 	struct ipv6_pinfo	inet6;
 };
 
diff --git a/include/net/raw.h b/include/net/raw.h
index 32a61481a253b2cf991fc4a3360e56604ef8490d..d5270913906077f88cbd843ed1edde345b4d42d7 100644
--- a/include/net/raw.h
+++ b/include/net/raw.h
@@ -81,6 +81,7 @@ struct raw_sock {
 	struct inet_sock   inet;
 	struct icmp_filter filter;
 	u32		   ipmr_table;
+	struct socket_drop_counters drop_counters;
 };
 
 #define raw_sk(ptr) container_of_const(ptr, struct raw_sock, inet.sk)
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 0f9f02f6146eef6df3f5bbb4f564e16fbabd1ba2..d54ebb7df966d561c8f29b390212a4e6140dcada 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -793,6 +793,7 @@ static int raw_sk_init(struct sock *sk)
 {
 	struct raw_sock *rp = raw_sk(sk);
 
+	sk->sk_drop_counters = &rp->drop_counters;
 	if (inet_sk(sk)->inet_num == IPPROTO_ICMP)
 		memset(&rp->filter, 0, sizeof(rp->filter));
 	return 0;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 4026192143ec9f1b071f43874185bc367c950c67..4ae07a67b4d4f1be6730c252d246e79ff9c73d4c 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -1175,6 +1175,7 @@ static int rawv6_init_sk(struct sock *sk)
 {
 	struct raw6_sock *rp = raw6_sk(sk);
 
+	sk->sk_drop_counters = &rp->drop_counters;
 	switch (inet_sk(sk)->inet_num) {
 	case IPPROTO_ICMPV6:
 		rp->checksum = 1;
-- 
2.51.0.261.g7ce5a0a67e-goog


