Return-Path: <netdev+bounces-172858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6834A5650D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23457A3591
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B13C211A07;
	Fri,  7 Mar 2025 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lD++u51I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855920CCC2
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342808; cv=none; b=PI3NyiE7gVMBhZ/Q9i3JmH6t2kpas3oKv4jwA1OPfPifdnRQp1P4uxkuueguZbxvEeJrH6xhbJ5wAjiezJOKaMyv+uTnSbfr1AJSbocAEFeREugeBJOCoa6MGn6yHXvzDNqsjWgq++yU1geqWItjlQ6/Dx9maGMixTxFf5cxxo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342808; c=relaxed/simple;
	bh=+ccqlITWFwXwvlHIOrOv7LTtOIfItzyvWINU/gRflz0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QGQ1J0ijvv0pggtS3bbd1Y8VwGEf3P5GLlK61H7QNcS1aM1okux5lyduBgBDlR37WksJqYBRzpm7HutxYV2foFhqKnAM0VjF+A2Y9sweHmdG5lO3dFgDRfF+o1cbna0798j1cq46sZr80L72d5Hd2PJNJHtgMiljQDVja1TMM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lD++u51I; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c3b8b95029so260282585a.0
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741342804; x=1741947604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RZexNmGvSRfkzE2QSFGkvvSS6ipV8ORK3nXgduy0DdI=;
        b=lD++u51IfvpMB1gdKxoqgxG4by1fCx/SDrkzv1u+qM6LsAQrQb1TCXoxYa3cHqslKR
         U7eJqAv1eP+BM6pQuZk0Pvvx6+8MDisa2+kSIlHKq+J87l/uXiAZZUo+poOkkTFgRy6x
         e7ayGA4WCAI6cUdoM3NYKll0mOIXoR+622ASl5zCOXOwd8cU4yumS1xTSikTzGW+S02o
         eUmoILxzxBq52huo2oCIDxLMvlMAQFk9a16nxfqLyh9BwNHTGAQf7Xn6ik6UHd5CKCWX
         twYLAGynWrgRvXCp+hTzh9Vt4f2DwsjfU5W6X7gQwx5HwM09++XkzbiJkICcfDWuugUs
         3Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741342804; x=1741947604;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZexNmGvSRfkzE2QSFGkvvSS6ipV8ORK3nXgduy0DdI=;
        b=CIwqfilBp+uK87zJm05qEavv5rJxlEEXqgwdN7iN7d59KbG2KifumIn9lUfUatmoaa
         VlCMEw+epzEln0K3MuE8M6qKWj8nL76QVHHrcQ3TYFlD8x0A6VFNuQru7+uy5ZdrVAv2
         8MMx/6fUpWTpyC32rtagANJokGJTPxovAG6EfQCwQpzAde1vV/7ZHKB95EJXm8Iyu81B
         +puymVTK/MKUwD3YT2W4yDlskJGQAhiqY4q9e4hW59GzTHU554cmQqLYqLVXtt/Odktz
         toZ1Jqx/WGRnNtWLbEOsSq/Lxh5dIMq/wbZLCXHSJisthIxvS3H8TJJZdRexprFJSuXD
         pjVA==
X-Forwarded-Encrypted: i=1; AJvYcCX77Vu6tL9AIXAkgQeheXuS60B5ZQaAzC6VpgPwlxV+Cl++bphxkOG5+Rz5tB79y1gCFMqbivM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyANcuEO2g2uo2L1u8aUzAudDFvIBhAdPllEkl7gZCmvPcx86jC
	L5t1lYncQOtyhL1vTqhZYCh+fuwFLJcfCu+7MEUF814IzzzDxJVhhGKXNJhighp6SH6TEQ7lEbv
	y/A9zUNicwQ==
X-Google-Smtp-Source: AGHT+IH2TfFkjq0uhfxzGtmNx2RmL5ufQgOlXbzxnd9SYOK3alk6QnfYYwyI3dX4pBAq0hGNhOWex+cLDHxAPw==
X-Received: from qkao27.prod.google.com ([2002:a05:620a:a81b:b0:7c3:c857:4912])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1b8b:b0:7c0:b185:a946 with SMTP id af79cd13be357-7c4e6178d07mr326013485a.39.1741342804405;
 Fri, 07 Mar 2025 02:20:04 -0800 (PST)
Date: Fri,  7 Mar 2025 10:20:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307102002.2095238-1-edumazet@google.com>
Subject: [PATCH v2 net-next] udp: expand SKB_DROP_REASON_UDP_CSUM use
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

SKB_DROP_REASON_UDP_CSUM can be used in four locations
when dropping a packet because of a wrong UDP checksum.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: add two more call sites. (Willem feedback)
v1: https://lore.kernel.org/netdev/20250306183101.817063-1-edumazet@google.com/#r

 net/ipv4/udp.c | 6 +++---
 net/ipv6/udp.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 17c7736d8349433ad2d4cbcc9414b2f8112610af..d0bffcfa56d8deb14f38cc48a4a2b1d899ad6af4 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1848,7 +1848,7 @@ static struct sk_buff *__first_packet_length(struct sock *sk,
 			atomic_inc(&sk->sk_drops);
 			__skb_unlink(skb, rcvq);
 			*total += skb->truesize;
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
 		} else {
 			udp_skb_csum_unnecessary_set(skb);
 			break;
@@ -2002,7 +2002,7 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, is_udplite);
 		__UDP_INC_STATS(net, UDP_MIB_INERRORS, is_udplite);
 		atomic_inc(&sk->sk_drops);
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
 		goto try_again;
 	}
 
@@ -2117,7 +2117,7 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 		UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_udplite);
 		UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 	}
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
 
 	/* starting over for a new packet, but check if we need to yield */
 	cond_resched();
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3a0d6c5a8286b1685e8a1dec50365fe392ab9a87..024458ef163c9e24dfb37aea2690b2030f6a0fbc 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -586,7 +586,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		SNMP_INC_STATS(mib, UDP_MIB_CSUMERRORS);
 		SNMP_INC_STATS(mib, UDP_MIB_INERRORS);
 	}
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
 
 	/* starting over for a new packet, but check if we need to yield */
 	cond_resched();
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


