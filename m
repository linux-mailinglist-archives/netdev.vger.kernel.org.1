Return-Path: <netdev+bounces-74809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9188668B8
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 04:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D02F1C2172D
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 03:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C45E1B7F6;
	Mon, 26 Feb 2024 03:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgXORYXf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944131B947
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917792; cv=none; b=fohzyyzBtcHwFR/p9CdlzaDn1GtoytMapIqao4byKkSyZyP4VkR1KGRthygjsaKx+0tlYMGPeweKwd2MOXhrChtNC6XS2kVFSbol8urY0E5cp9ZFLnSNUA0ot2oulUrh+x+RT9KnyZepTsNU/zBKYJVMNOv7o9bKMjzJ9gs8d4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917792; c=relaxed/simple;
	bh=IvVzRJKpHu6Y9FrWeV/oU1VDolb6oSYyI6DL7+sH+HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgpLHcWwRICSJO+Peab3vuDJ/GW9tW5UHtqdyKIDJ3suH63Ju9mzJmIxUI5+m4AVJxnw829EiSkiiE1uf2fKodY73w6VS6LsccvnP/lgTYVXHmi4uItkyop1xYd6LSizfkA8zuNVOrfRIsULrStvlc1kpgsI/cgM/g5QK/PFP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgXORYXf; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29acdf99d5aso43071a91.2
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 19:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708917790; x=1709522590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPQwmoTWvSZeHjoH5ZeiSRxpMNixM5ZS064sX1hE8hY=;
        b=TgXORYXfvV0agxz5VG0ARVPGjKbM9NpvrF3CV1uCUap3tuYd5hTfwjwpR3urmW7Gjd
         Ev2tE1Xu0hllzOCJT2CDedObRScIxku0GZ23+8vRYvhk9caIAYfLl/tOSrjeTKe0u2pM
         im8e0uqORKlJQjPuwRhIE95sTyYwRq3h67/RL40MDQqmbqDfM+dyIEx5LwRygcgMvRAL
         g+btHsvIJiS8ZLyRgZxKgVtsQgJNhedwMymdqZTPdC2+wKotQyCU1DR//6uMnaqusarB
         vkDQ5spkKy1+B99JIWeMoOLCrdgc6yB6dP5GFD63wfe0bDqIM2pZgia7wXJuKoPCqHrZ
         zdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917790; x=1709522590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPQwmoTWvSZeHjoH5ZeiSRxpMNixM5ZS064sX1hE8hY=;
        b=qU5QgbEZJgv0NOWGEMwiiPaP52GbVJhbg8hTROFGfjZI8x7usXsKO5KZxyDGouWF+7
         t7Qe17ltf0T6H3XiNUaSApER/8Q6pOoxOCYEv8GY+MnOnXl1ZiOgtr9z2oLhS3TCUqsE
         418CyKgB31/rdFlWiaGkLADdF+7NxIhLwpdU06gAPrS800RDCEuqy/32PGJKOMqVwLqJ
         YlNGPDCt0aV5j5x+xqIY/XqeW1c1XNiQSmy3jUB0LRaSExWilm4mAsb1HAfOTGUZEHcM
         EA3sT/iq8zJX22rGINPidivzYU8ecMNJfGTKR+V5ehN/nwIhcYCqBTKOwjB+UYFTipuM
         O3Nw==
X-Gm-Message-State: AOJu0Yx9xySKqnvw1RKUmAG9Kp6S+Zb07JvXT99pUjKwRQfVgDLlLBFB
	xOKaTlalkVdNS+xpVPWaU/FACxa95086JkXofJtiXbaE4JofXY4p3CjPCIxMMTg=
X-Google-Smtp-Source: AGHT+IEY49aBYUjN2WoZMr1iSrYKVQOOZAs1JohQM8d7mns2GrBfRPhJvbyujWOGNjrsGn5ybnjLLg==
X-Received: by 2002:a17:90b:1989:b0:29a:cb25:bde9 with SMTP id mv9-20020a17090b198900b0029acb25bde9mr568113pjb.26.1708917789957;
        Sun, 25 Feb 2024 19:23:09 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id fr12-20020a17090ae2cc00b0029a78f22bd2sm3262521pjb.33.2024.02.25.19.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:23:09 -0800 (PST)
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
Subject: [PATCH net-next v10 07/10] tcp: add more specific possible drop reasons in tcp_rcv_synsent_state_process()
Date: Mon, 26 Feb 2024 11:22:24 +0800
Message-Id: <20240226032227.15255-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240226032227.15255-1-kerneljasonxing@gmail.com>
References: <20240226032227.15255-1-kerneljasonxing@gmail.com>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
--
v9
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
1. add reviewed-by tag (David)

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


