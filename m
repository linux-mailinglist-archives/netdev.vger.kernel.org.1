Return-Path: <netdev+bounces-73960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A6985F6EB
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47609B23A98
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC445953;
	Thu, 22 Feb 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvInTVnx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB545943
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601433; cv=none; b=Mfq9cTxOhzdp2A5ODhsSzOcwcf1A19cEbT49yAHb9EiQ6djAhsO2X4Nd9qfsl4m7GPFInDZt46E1eU/SttFAlCHEdtXHOLqnxeoAqFb9i1fnhMSkh5enEkqSu5mRsh1MGr5STAgZeEbUY7W83RiAnETDWVtDpeFpFQmyJxlkAqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601433; c=relaxed/simple;
	bh=/7i9HNom86S0jZ5WI0UH5wwtkj6Zj4rZY3+iUEd4Xzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vf6nwIftu061n+DXQHE6ssgmAfqDrKgy0Um3TXZdyyR1kWvsBXAU2Yvq6XKbkLXtcs2dTBaM1dMnaqFvltpU0cHMY6Z8mXkQ9SSwh2dXE/aIxp0oHG4KryLx0L05DL3DQypqIMwCzCGhEDZwBYqgvipF4hSZLv4eTJjrkSbLDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvInTVnx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e3ffafa708so4955818b3a.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601430; x=1709206230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6tLAaflz1oPuS6Bxa5Ojahd9wniHFDgfVpAduBJSGU=;
        b=bvInTVnxton70VV6q2mkkzt/YJDBd8a35a1PFuKGQTwb4iLzUfDDgeqLcRB+NksJ0G
         zjML4nzWxk9Md8COMEGyKt4GqQbXmAthRLf4TzAz80LCF6J3CEHxo7BPcz51b3q5vN3Z
         t8mnv9N9BEu3oqv6tWI2k4oF4V+CYgldm8lrukOjLsi+k3tXvcKc+gKpIUG/PFyUeii6
         C/iIBzYC9SwcsRetIv26V9SLWL2T5zhhOEF10gYUE+Pl8lUaQqb4i+JcE5G0IX9jGrgH
         VU+h6xID9zLRP9pMv8a3jPzclbX+kh38gtbi+XvkIOq7DK1TNnlJ49dA4mh7oelCDDda
         IrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601430; x=1709206230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6tLAaflz1oPuS6Bxa5Ojahd9wniHFDgfVpAduBJSGU=;
        b=ggcbU0YP/QGw73EkPz4YAQy957vRj1bSKcCktW3N+XUSeZ/B0VYsObZ6hMb1QcGwiA
         6pdbRztun6aigpBR6lm4mDUyAQm3kmLlgqwchdzW+cGXSdonsavQkYjqR8rPMS4bekv3
         0jPY+Xyw3P3HEXwZjuPywLoWUntIs9mWdjK4w8dUZlv4PaZ1/PgeJvYi3Scn+tkJuHek
         Z9bceMaIQlNS/Yhdx/idh9n1eHAYd4Dj0wGJunInbF4+zIKXE6zHf/1OWsoXSee3HjjU
         sG8pLILHRjgRlxH1BN3WPLYy+RefcxOA4NaBI3lwdPh/uFKVY5JgaIaXzUJ45t58C7jf
         xK+w==
X-Gm-Message-State: AOJu0Yy/oxg5nDxM+leHYfu1jDAi9pmZqLRJAe2vdqw9riApO38e2/A6
	taVpaNxMSTa9Ykzf9h2VwGluLzdjENjaeGfcP6qsf1F5a40c7oYe
X-Google-Smtp-Source: AGHT+IFjQNk0xwu4P0dNLo9tm5/QRDFO1hesjuCDy7GyyaE779+Yg/j8axC8ZaBUpX4RVj8Qd0sesA==
X-Received: by 2002:a05:6a20:d80e:b0:19e:a2d5:2d7d with SMTP id iv14-20020a056a20d80e00b0019ea2d52d7dmr29242922pzb.37.1708601430116;
        Thu, 22 Feb 2024 03:30:30 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902a9c300b001dc0955c635sm5978637plr.244.2024.02.22.03.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:30:29 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v8 07/10] tcp: add more specific possible drop reasons in tcp_rcv_synsent_state_process()
Date: Thu, 22 Feb 2024 19:30:00 +0800
Message-Id: <20240222113003.67558-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240222113003.67558-1-kerneljasonxing@gmail.com>
References: <20240222113003.67558-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This patch does two things:
1) add two more new reasons
2) only change the return value(1) to various drop reason values
for the future use

For now, we still cannot trace those two reasons. We'll implement the full
function in the subsequent patch in this series.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
--
v8
Link: https://lore.kernel.org/netdev/CANn89i+EF77F5ZJbbkiDQgwgAqSKWtD3djUF807zQ=AswGvosQ@mail.gmail.com/
1. add reviewed-by tag (Eric)
---
 net/ipv4/tcp_input.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 74c03f0a6c0c..83308cca1610 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6361,6 +6361,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 				inet_csk_reset_xmit_timer(sk,
 						ICSK_TIME_RETRANS,
 						TCP_TIMEOUT_MIN, TCP_RTO_MAX);
+			SKB_DR_SET(reason, TCP_INVALID_ACK_SEQUENCE);
 			goto reset_and_undo;
 		}
 
@@ -6369,6 +6370,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 			     tcp_time_stamp_ts(tp))) {
 			NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_PAWSACTIVEREJECTED);
+			SKB_DR_SET(reason, TCP_RFC7323_PAWS);
 			goto reset_and_undo;
 		}
 
@@ -6572,7 +6574,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 reset_and_undo:
 	tcp_clear_options(&tp->rx_opt);
 	tp->rx_opt.mss_clamp = saved_clamp;
-	return 1;
+	/* we can reuse/return @reason to its caller to handle the exception */
+	return reason;
 }
 
 static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
-- 
2.37.3


