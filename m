Return-Path: <netdev+bounces-241248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EB9C81FE3
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B136E34325A
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527642C15B5;
	Mon, 24 Nov 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/54BPmX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9142C08AB
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007065; cv=none; b=Zskflzt+JKCIVd1GbPz5+iGUCSNmys3bBcTCYaC46RFJr3JboelbzMISXCJx5FfvepCklzTCnxsrDlS7SNHym7X83geYbx3nPq3+tivj7sgQkncQ8Q7n1jjXj+HQBoe7J4tEJje/w+nwv/DODl5AZdYUKo8j354ZTJQgAnPF7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007065; c=relaxed/simple;
	bh=zdTJRxl3gIoKsEVPv/AsWgjcekjWrPrfo7DSxqisorQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AdmqVR+XxfgSyUUJh5ZKdD+IMnhcRgjQKx1k6RPPPNyTMy5L9dhnOgShDrReFRrOZZEFOboGZIeHJn3XhIM+k2aZxuuPAVipBTb80FPrnEzA0uM72KqIrRXerFSTV0D4g8WzSVADF4+QdKLyQbPFZxAGQj5CABB3LBhIQRj0PSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/54BPmX; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7c6db96dfcdso9352524a34.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 09:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764007063; x=1764611863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lRHsxwPDMkMjZNkEUA/oU1QIE2hS5ItFaNxg27Cv/h0=;
        b=u/54BPmXt/byEvZwwetycLj2OffhxdpXxoEz9hDUbVw7M0V+0Biq0u8z8gNTRt6twE
         vCAx+2MQpXQOEhGp9EnDzKC71EVo4H05UzLwN8WXxwi0pWteEsE0JrBcX9ZIXQKkV/d+
         jr7iBSJownzawvGiR4ST/3JPAfoDBItuRHBQZHOGDrZiU+kmknrqnbOIqNbUdmcyj5Nk
         TIzlspw/iUfJQjBJAB70PSSPBMVa5t67SQZDG/RbwJ+eaR/2CAreLnnUYtgDagdAl0aF
         zp5d7+Vo/aPQtmd7lE1AXXHu1IzDMtVXi9JnNk5sQ/1CF5VfHWeP1b96JahqVKAh8IZS
         EdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764007063; x=1764611863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRHsxwPDMkMjZNkEUA/oU1QIE2hS5ItFaNxg27Cv/h0=;
        b=QPOeOLQlBoKxHsX9fyFyE8cDXwZDFWuqV7yKYu7LAiF1GbV+xDPp5rctrgCzllA12V
         igJY3xPYgMujVNU8CaJ3hythQqVzYih0d4qz+IxeaUQvW3GB6yTeN+Pm7r3AJkMuzzE0
         ewglsxiqPd4tRNIzXv5yWRRCNIHYS8s3GHP8ABeRDnBsj0xF8Ux63Ye5gtSV2SQ/aGd1
         v+SHIr0VXtuIrwtXivX1yir9YvJx9/IBN4ZuVdNLNG5ApxFkqsfVMhb82Fogn8rMYn//
         7zhWpPNroU4w3TUubYSqx1cjM67KliEmotjf4y4HfUlG5t2FyK6L3oftFR4BH1X7yKch
         WhQA==
X-Forwarded-Encrypted: i=1; AJvYcCVKPwTI4YUZGuhrbvmpsIwXPbjVbv225tHQ+DvHIkX8ZoMpu59RkcTzznDuoguwIFaIjbJ7aVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJtlsomVTVyCMmoVBwtnCHvbSxEjH4fJDALLEQhwicjVxnXaE
	c4drlBVkLKHrxviQhWxoa4+TTjLBvxtlDeOSa+X+wiOs5z03i1jwENU+ocG8jEOdFl3usDsDtLv
	dUuPzvFzby3H/AA==
X-Google-Smtp-Source: AGHT+IFN5lGAEtxRcD7vyxxjSnnetZgZA9HFCFFrUwELiyeko8f2yew7hWuMiGk1pArTH8U24MmdVFy7IhaMug==
X-Received: from qvbpa7.prod.google.com ([2002:a05:6214:4807:b0:880:1ab8:a32b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:580a:0:b0:4ed:b1fe:f885 with SMTP id d75a77b69052e-4ee58848f99mr200188031cf.19.1764006617153;
 Mon, 24 Nov 2025 09:50:17 -0800 (PST)
Date: Mon, 24 Nov 2025 17:50:11 +0000
In-Reply-To: <20251124175013.1473655-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251124175013.1473655-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124175013.1473655-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] net: move sk_dst_pending_confirm and
 sk_pacing_status to sock_read_tx group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These two fields are mostly read in TCP tx path, move them
in an more appropriate group for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 4 ++--
 net/core/sock.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index a5f36ea9d46f05970e36e3dc6c10051e5b0ecd42..7c372a9d9b10c97f9d0c4d6faab267a04bd68e0b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -481,8 +481,6 @@ struct sock {
 		struct rb_root	tcp_rtx_queue;
 	};
 	struct sk_buff_head	sk_write_queue;
-	u32			sk_dst_pending_confirm;
-	u32			sk_pacing_status; /* see enum sk_pacing */
 	struct page_frag	sk_frag;
 	struct timer_list	sk_timer;
 
@@ -493,6 +491,8 @@ struct sock {
 	__cacheline_group_end(sock_write_tx);
 
 	__cacheline_group_begin(sock_read_tx);
+	u32			sk_dst_pending_confirm;
+	u32			sk_pacing_status; /* see enum sk_pacing */
 	unsigned long		sk_max_pacing_rate;
 	long			sk_sndtimeo;
 	u32			sk_priority;
diff --git a/net/core/sock.c b/net/core/sock.c
index 3b74fc71f51c13547591c4e8524d0475fcb27c8e..43553771bd5c43e951e09e4b9eeef82071937267 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4501,14 +4501,14 @@ static int __init sock_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_send_head);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_write_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_write_pending);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_dst_pending_confirm);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_pacing_status);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_frag);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_timer);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_pacing_rate);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_zckey);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx, sk_tskey);
 
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_dst_pending_confirm);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_pacing_status);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_max_pacing_rate);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_sndtimeo);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_priority);
-- 
2.52.0.460.gd25c4c69ec-goog


