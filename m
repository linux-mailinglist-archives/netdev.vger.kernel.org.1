Return-Path: <netdev+bounces-174111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB95FA5D85D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F042C7A8F81
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7F4235360;
	Wed, 12 Mar 2025 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wl2pPJkU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BE11DE3A4
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768756; cv=none; b=BEsDtIuQK06M3PC+XkCB+DDzHBhCPvQKXSSMJeoLLXqIxWdKeXdh5NxIu3s78eesZ/aHV+CZUTspAyfxRvC5bEyya66/ID+iPupGei7lJlbVMB2ELYsXYzgflqpV/4ylvQpn5y6DaNM5wTDA46bKaNj2FZ7fIxiH7sBx05UGTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768756; c=relaxed/simple;
	bh=o+ViccANnwtPQK6beE2Ek6GhpXQpLVuXaqM6V1qBC6g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JoffasqOSjeKhVXETvhw3hSnjBYxdNXwkWGd/UJTHSFLMYP0/majOniLgWAaJn5TWKGPUPDrBp3t13NWS2kugNNqnd5lEM+TSTjaX/MVWzeTCWau6HWh2ugsBBJ22A6JljQWoXSqupj84NRCLk9e5crpMNvSEZAnjheQ2e4CXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wl2pPJkU; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4768656f608so67507731cf.1
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 01:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741768753; x=1742373553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3YMgZGhIeFJFM9A+JA73ZmpaCyrupc1flaPZhMT69rI=;
        b=Wl2pPJkUZs+5x74JnInbMBQGHfqwtpT6i9+kx4Ib9s70HUtkcU6Ip3CnJ0RrNDYEcj
         T9Em4q/DM9jOUaQs0bLskjGoBGFuO0Pml8auYWPkSvJNUz5zg9xGw+Hccv4Sah/h1WTS
         +DtTeZLz8ug8pTzip79i3lnWzCVNZ/BZOMZ5JOPP/pfHHDEbmCl0AOaUia7RXc10BC3D
         3kyS6y+ZlD02diDnDsWQK1NsoJDthv6cHPAnrdnOHOMwopjpDwicsW/gKtK17sHlX4UW
         BjcrkwXNam0SUITOBragK4t4DGJt+pD6oDiGakWuv4p/7J2dIZxwYiBNtOos8uuv8sgr
         EjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741768753; x=1742373553;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YMgZGhIeFJFM9A+JA73ZmpaCyrupc1flaPZhMT69rI=;
        b=bk0mhgInG3Z6UW+FrOu4cA1yT/8Y3uQK/l/4e4Ri+8ruSYa6uJ3P9SZr0Zxuj4BJ7i
         urt03nP+7X54Q70tO0gzMSYartkUD+/aYG1bp33uucmDbKzUwhA0FefMY0uy65rhyv1a
         Wfl4Fl2kBA3bN12vKDHO5UbDvDiVxIW6Uto6wrjksGfGYOo7sh+eZX/CpYhXtLcPpTIC
         oru8b0ODq0qAlKh3OHlRAS8iRnKLFxBtfcXnsIsN0wrIK7C+dAZfmOHrrtjro5kuQBa1
         9eBZWiOk9guP8DmdvxcFcN0XM4xJRsMi+IbeAdTeLU8nbgNVWgVmoCX8wRgA+16mjCRq
         VHDA==
X-Forwarded-Encrypted: i=1; AJvYcCVTkAygN+XRmmMga1nq0SkQt8A7Bk7yaYOd01oA/tozwlzh+unMq/M9n3RhKlEbUoaDrW6HqI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpCT8WbO0fasnxcit8KRc+axJjfiYAZAtOxLdp43fYauxSGI6h
	ngXtFsQfJPytkLIql++N4DWQcLuArmBRLU/Vd7x+8VerjUnNkCgQs4YO3iR2OzHj3FO5kpmV8qZ
	+Ibn3LazG4Q==
X-Google-Smtp-Source: AGHT+IFzvZ7RFiWxoui/45v8ULx5XziBqoe8UMflBFzveyj6sE9YSq9qoG/xEo7LSyz6A0U4CgOeIvQU2T9H0w==
X-Received: from qtbbz19.prod.google.com ([2002:a05:622a:1e93:b0:476:9243:e24d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:144c:b0:476:85d9:5ec0 with SMTP id d75a77b69052e-47685d9665dmr128480751cf.0.1741768753696;
 Wed, 12 Mar 2025 01:39:13 -0700 (PDT)
Date: Wed, 12 Mar 2025 08:39:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312083907.1931644-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: cache RTAX_QUICKACK metric in a hot cache line
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_in_quickack_mode() is called from input path for small packets.

It calls __sk_dst_get() which reads sk->sk_dst_cache which has been
put in sock_read_tx group (for good reasons).

Then dst_metric(dst, RTAX_QUICKACK) also needs extra cache line misses.

Cache RTAX_QUICKACK in icsk->icsk_ack.dst_quick_ack to no longer pull
these cache lines for the cases a delayed ACK is scheduled.

After this patch TCP receive path does not longer access sock_read_tx
group.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_connection_sock.h | 3 ++-
 net/core/sock.c                    | 6 +++++-
 net/ipv4/tcp_input.c               | 3 +--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index d9978ffacc970efd308d0011a094aec41b561e65..f736d3097e43d97ee32f5d31f0e566536fe05a35 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -117,7 +117,8 @@ struct inet_connection_sock {
 		#define ATO_BITS 8
 		__u32		  ato:ATO_BITS,	 /* Predicted tick of soft clock	   */
 				  lrcv_flowlabel:20, /* last received ipv6 flowlabel	   */
-				  unused:4;
+				  dst_quick_ack:1, /* cache dst RTAX_QUICKACK		   */
+				  unused:3;
 		unsigned long	  timeout;	 /* Currently scheduled timeout		   */
 		__u32		  lrcvtime;	 /* timestamp of last received data packet */
 		__u16		  last_seg_size; /* Size of last incoming segment	   */
diff --git a/net/core/sock.c b/net/core/sock.c
index a0598518ce898f53825f15ec78249103a3ff8306..323892066def8ba517ff59f98f2e4ab47edd4e63 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2565,8 +2565,12 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 	u32 max_segs = 1;
 
 	sk->sk_route_caps = dst->dev->features;
-	if (sk_is_tcp(sk))
+	if (sk_is_tcp(sk)) {
+		struct inet_connection_sock *icsk = inet_csk(sk);
+
 		sk->sk_route_caps |= NETIF_F_GSO;
+		icsk->icsk_ack.dst_quick_ack = dst_metric(dst, RTAX_QUICKACK);
+	}
 	if (sk->sk_route_caps & NETIF_F_GSO)
 		sk->sk_route_caps |= NETIF_F_GSO_SOFTWARE;
 	if (unlikely(sk->sk_gso_disabled))
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4e221234808898131a462bc93ee4c9c0ae04309e..5bf8868ca2b56919b15e0c99de83210ed05ad6a7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -333,9 +333,8 @@ static void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
 static bool tcp_in_quickack_mode(struct sock *sk)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	const struct dst_entry *dst = __sk_dst_get(sk);
 
-	return (dst && dst_metric(dst, RTAX_QUICKACK)) ||
+	return icsk->icsk_ack.dst_quick_ack ||
 		(icsk->icsk_ack.quick && !inet_csk_in_pingpong_mode(sk));
 }
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


