Return-Path: <netdev+bounces-211598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABAAB1A51B
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C7C16658C
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140F0272E51;
	Mon,  4 Aug 2025 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0vrMME2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F5271A71;
	Mon,  4 Aug 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318381; cv=none; b=FxDkMZgJ9f8MDPCMPq2u+uPwwdnPoPIzrwPXe9ZvC29lqf5N6IoUPhUWQ7jXl8AoTrFBEzUQ+Vs1/0tW1g3w+qSZyhSWsAIubDa204dzP3yzp0rZ755cpqXFuK2dqMPCzcuC9VfCe/D6XbDN4UxBkSmHbHiSqiWls35BO5Q7wZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318381; c=relaxed/simple;
	bh=ebp3JoLTgHnQ9fLbWDG1soFYetCpXYo67PxlRTTeTYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAE81vfvENsuX5pVbV1HyQPzwpYH/L8vM9skB81UiMeNNo2W4zMazZprao70tJ+Vtd3WrjZeLrJcQqDlXH6YIexP7n60nlZt4JEE1czI8l364SnxGyXiaxF/qu+OwTYdLnyEL0pZkRzWrR27hh4rNHjb5hU8M2CUS/awYG61+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0vrMME2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-458bdde7dedso14180815e9.0;
        Mon, 04 Aug 2025 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754318378; x=1754923178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i1gOoy2iegrEXM05cefOZh4ifR0VlE6cRcebi5dNSeY=;
        b=W0vrMME20GGYsfV4GV4CaFZ6VP8YKAuXY1xDky6lU5BJkfEDwrz4Rg7ai0ZVsFiQeN
         XF+nBqsDYswuT6CgE1wh67HDe2p2CyS+P4bHP+TZli9ER4uuUCrufFTmu5fy8txQwwIi
         9H9j4zIqtEsXMtblxEd5qpMXvxwSf9Rz00IqNdWyaOlE+BkHhZpFCxtJbPJ+0W9vGUAd
         ywUaZVkVlDOh+U8D1Xg/TucmE4kBKh45AGSV6ycYtJ4z7KPyyUFcNm5em2c3m1LXeCd0
         Mx/T7it+H7MuU6vfjZ4ObCZShxIiYSHZ9lNkbkMkmBG4Sah50KDP4e4vhHy5nWnqKJMG
         b4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754318378; x=1754923178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1gOoy2iegrEXM05cefOZh4ifR0VlE6cRcebi5dNSeY=;
        b=qONFJlehenZJ4BF2GmpRYFdvUfMPAKsjQfYcRWmFsGXQQfqjughVBCKEW9u20rueTi
         y58M2A+kJET1ReFjWM2Upt3qlrrRhfwQwKQyBR3TvrCU3yCzxuBP7yMar1j5dxE7ytSM
         Ef8OhX9UJAAR+A2YDtgbMYw4pm4UctBVY7ut1+aSzYLaBtmWjIEnPVeDYBY1c3hWwpEW
         HQeO9xRoEwhTPLtyEDQb0RRGB2Nonedcp20GslU+QACEK4+HGKVbkndgBkBmX1CtYEPE
         9SQoDHaMmEzkf1iDCWH1/BoCYJ8Xh5FEOR/plD9Q66jUmP7zZtkmDauWkl6zb0p56eYN
         p81Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI//DfadRGGyPu9nlYp0PJgF4FjDFtVmE+3zaO+3XP5zjGmiIoClZqyRA3cxVVooWboO18ZFs1cbtsZFg=@vger.kernel.org, AJvYcCVs28Lwjs2w63v42u9vbV7Ae5+HNYlxYdNAYZrYQqzxGCBMX7/xBEcl2spEZ5oARH7wD244ejHs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oh1iLP37YY6eLqpwt4Xp3dJ9s1pypXlevzIMJcqBi1rc1xdv
	aD0xIB4gwqkMCb/sijP7d2Nrg3y2koHYkRaWkptHP/3muRdYvY37pEQHZKgF6rdA
X-Gm-Gg: ASbGncugtRFAOr7+EKp1/QBxpRKDkTgMAeqNT0s6QG9ueVWK0SiGs78EqzL9McDsdmo
	cvN3JZK3khrUODCW+PEtudkivXmYZOr2tJ89obnlo95VRukki6sC0GCsxwrmgaOaoAe1uSv/t1C
	Xp6OyDFwE1CRXxxnVyG2kEQ89arh2PcdDFXvi16+EQF2Zv2a3tMfvu3XdOfX6ZTvzwxefsQbcj8
	IZ3XFEQ1qVi+KssMcMLzYe+lhQNZ+6S9EL6WpcahuNtKH3hAsImy6dWCAlAyHjYCr8KtELJjAzk
	5EiOtvwe+kq3r9XdHfhawuCWC8JhNbZpLwoZUSZo2UkUWegwPMkZPzW95wr2nsD5K5gsdCliStw
	I/Qa7oUyW8D1QhhPDlnpZkgUo
X-Google-Smtp-Source: AGHT+IFUWR5CpVX9TI35vtFHdX9dbaOEm0sLPmgmQoyvPqHl8ORvGu2Hj/N4bvjtt8JgR3bWBjXDlA==
X-Received: by 2002:a05:600c:6610:b0:456:1608:c807 with SMTP id 5b1f17b1804b1-458b6b4377emr72486485e9.26.1754318377453;
        Mon, 04 Aug 2025 07:39:37 -0700 (PDT)
Received: from fedora ([2001:16a2:6713:7d00:e3c:d6fc:37a:c91f])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459dc7e1ddesm31987685e9.27.2025.08.04.07.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 07:39:37 -0700 (PDT)
From: Osama Albahrani <osalbahr@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Osama Albahrani <osalbahr@gmail.com>
Subject: [PATCH] net: tcp_ipv4.c: Add missing space
Date: Mon,  4 Aug 2025 17:39:14 +0300
Message-ID: <20250804143918.6007-1-osalbahr@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit resolves the following checkpatch.pl error:

```
ERROR: spaces required around that '=' (ctx:VxW)
+	.twsk_destructor= tcp_twsk_destructor,
 	                ^
```

Assuming the purpose was to align the equal signs, I also added a space in
the previous line.

Signed-off-by: Osama Albahrani <osalbahr@gmail.com>
---
 net/ipv4/tcp_ipv4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 84d3d556ed80..2585e176b031 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2458,8 +2458,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 }
 
 static struct timewait_sock_ops tcp_timewait_sock_ops = {
-	.twsk_obj_size	= sizeof(struct tcp_timewait_sock),
-	.twsk_destructor= tcp_twsk_destructor,
+	.twsk_obj_size		= sizeof(struct tcp_timewait_sock),
+	.twsk_destructor	= tcp_twsk_destructor,
 };
 
 void inet_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
-- 
2.50.1


