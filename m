Return-Path: <netdev+bounces-166590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5169A36845
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F2A164479
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466A71FDA65;
	Fri, 14 Feb 2025 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/x2Uib/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D83E1FCF65
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572052; cv=none; b=tMRWoodHQTQKp5eCSUb1avFR1KhOi6uED7wKK6BETrXuPwM0TNYS0d6t9+uC8/IUlavAzu/NFSa98I9dDD5kUXLZiBD6VT+6It96ag++CoeeDAWvgZCTgVGPSCy1qrrcTltyd1hkDcWLp9hvUW9XjOnEiqJYyZDNqswWAulPNFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572052; c=relaxed/simple;
	bh=g85D/puBk1zSd3VtMeVRfXBQtPxNu1P76jbU9KEWX5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+KpAY5cw1Sl3THWZnmciC0OGA+LMrZ1JPPWlLQuTVZXK/A//+hLKkyKAa/VALjj0FM+lp1hkZOGdTACDskwy5OKdaCRF7r8Z9H2xF6iXCLUcPSQxVUhkv7wCAT7OZfEu5R9alR25Dv1TzQiBjb8nIAamkmMCtKKCwOFdMwoAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/x2Uib/; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e6621960eeso18191726d6.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739572049; x=1740176849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S39GL7Y92z5SSLodPKQ8HjsJVpllKR4D6nW172CS67Q=;
        b=C/x2Uib/vndPL1/iWVCHmK5e4Sxaj1U9wAj7GFvtf30wfbZ86hiKt5v4TPOynmyCtX
         xG0K15WrR3k+75Bl8kAKhiI4b+t/UOLOOSQpQZOzPw8Hy+OAiFil+0UuT5fxAvgi/Tw4
         dUNZu2pOQufqpLXvmzZxLRCbDjE86nKCqj0xWWWW1ug+jnv8nn4SQ4mW28WU8rd4QpfF
         lrkz8KNP5B92cDQVEAB6dmcpW3OzfiboUfN0/FHYFlY5wlAqUNYfIGz4qi8qCugasg+8
         mcZEOPt8QuepKpoXnFKTWSideS4416/X8M4yNCj/ZkuMRhEZaSUBau+CvDi+XB2dwI3M
         zaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572049; x=1740176849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S39GL7Y92z5SSLodPKQ8HjsJVpllKR4D6nW172CS67Q=;
        b=B30F3m++eHFafdz8uqznJztOccP6GLMsViRwUaRk5NiqNndQmnMbxbUFWOyYYMR+1j
         wj5giXhilyPGklk4I1QYVKYMKYb62k6HvBAz1QCuXbPzywUd+bEUHcppndFZYhuMbg1o
         MI3Ev9Pbk4SxGAM59EbFioba7JH9EwqUlj3OIzdswTIUEXWhfJcK56OUKR9HXdA03M5m
         qzs2vcGKciPydqe9kD4odFp4JoU1gcRS0JCU3dbftDPAcLyX4T6CLdtYc00FlXXvMyz+
         fCSXatzLYpJjldSDqeXLz3TLYIIfL4fmyBV7x2KKtOuUSrhtAwKLhGvCgoRcbda8Zozk
         5PhA==
X-Gm-Message-State: AOJu0YxGYELUEbzLh9L76WhK+O5NlWG8+CGuHvRE/F5T23Ehb0B4oPR1
	UW5DoJP5rjoS8QlM8SNnzJMkOFKY01MiYrprXk2pN0x0heq8/1iG8zd5Fg==
X-Gm-Gg: ASbGncuGvuXNsH/zkgeSw36t4qxQhLEW0wjMurlecfTbxbtvq1oI8zblhX9MYRnOt6d
	KCE96KlwpGxreRZAbK87xoUBaL6Y2FvkahBDdLLIxDSAe7yws3YcC0qq8MfZS4emV7J8sSsXYzW
	SGcYS2mZgRVqtvD5NXVJPNV6189wr+9J9EZ2Yxxh4+80RFxLmSSh5Pk7CqoHXGE9xlB/eYdY6Ck
	n9O5ObiSbcwLsdEV0J6maOnpBOafQLYVVGcYz4ibDTwprNJ7igKuuDoGYTE+z258PE+jO7eDJKD
	M8o14ejfVipJRj59Te2Ftycn3/mEDVj66n7fpOdB3azqH77Vy+eq1Nl9+mM9t5fvFwN4ALAAWcX
	Pe+2SfPbZJw==
X-Google-Smtp-Source: AGHT+IHBEU62iOZ0EtnPew3qRCjiua4tznJz/euf81mQ17J1RveLIHptiLkEMf708qQROPf8uWL4YQ==
X-Received: by 2002:ad4:5d4b:0:b0:6e4:4012:b6f1 with SMTP id 6a1803df08f44-6e66cfd6d09mr13895516d6.3.1739572049451;
        Fri, 14 Feb 2025 14:27:29 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7848b7sm25832916d6.27.2025.02.14.14.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:27:28 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 5/7] icmp: reflect tos through ip cookie rather than updating inet_sk
Date: Fri, 14 Feb 2025 17:27:02 -0500
Message-ID: <20250214222720.3205500-6-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
References: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Do not modify socket fields if it can be avoided.

The current code predates the introduction of ip cookies in commit
aa6615814533 ("ipv4: processing ancillary IP_TOS or IP_TTL"). Now that
cookies exist and support tos, update that field directly.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>

---

v1->v2:
  - remove no longer used local variable inet
---
 net/ipv4/icmp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 5482edb5aade..799775ba97d4 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -405,7 +405,6 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	struct ipcm_cookie ipc;
 	struct flowi4 fl4;
 	struct sock *sk;
-	struct inet_sock *inet;
 	__be32 daddr, saddr;
 	u32 mark = IP4_REPLY_MARK(net, skb->mark);
 	int type = icmp_param->data.icmph.type;
@@ -424,12 +423,11 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	sk = icmp_xmit_lock(net);
 	if (!sk)
 		goto out_bh_enable;
-	inet = inet_sk(sk);
 
 	icmp_param->data.icmph.checksum = 0;
 
 	ipcm_init(&ipc);
-	inet->tos = ip_hdr(skb)->tos;
+	ipc.tos = ip_hdr(skb)->tos;
 	ipc.sockc.mark = mark;
 	daddr = ipc.addr = ip_hdr(skb)->saddr;
 	saddr = fib_compute_spec_dst(skb);
@@ -737,8 +735,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	icmp_param.data.icmph.checksum	 = 0;
 	icmp_param.skb	  = skb_in;
 	icmp_param.offset = skb_network_offset(skb_in);
-	inet_sk(sk)->tos = tos;
 	ipcm_init(&ipc);
+	ipc.tos = tos;
 	ipc.addr = iph->saddr;
 	ipc.opt = &icmp_param.replyopts.opt;
 	ipc.sockc.mark = mark;
-- 
2.48.1.601.g30ceb7b040-goog


