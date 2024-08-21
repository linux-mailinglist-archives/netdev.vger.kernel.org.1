Return-Path: <netdev+bounces-120658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A5195A16D
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B33A2817C9
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0C1474C3;
	Wed, 21 Aug 2024 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4cOdlE3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985E13A243
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254426; cv=none; b=Nqizd/uhNkhrq9G/fwznpq+SNgc3C9L9cY2p1kHIotOEgfBTpuUWbz6PoBib232BmeNDOj2//u/bFuBME2ud+km9XIr2AQkxojpQt6fGmVsMVD12+tATyv5PnlKktth28He9N711L+BzIz6dEPohJ9lhVVh7yrFEPLO0zyZFft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254426; c=relaxed/simple;
	bh=XnIajjxuq/4PN5Y4meyL99PBkbSxbvvxCuWcamwhKpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tHAVHWw5CEmYrKzagpnIOcLhii4gGH0vqIclvCPbeY/Pg2as11R5MCG/Te0ff9Gk/15oN4i1ebifClhX3+7na4wMBCYOMww32T2sm2WaASrq7zL1Cuc1N6GHDoIGVCqzT2x6LgCFd9hpDI156vQDbNoMz17TBDvsxdGETyYbSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4cOdlE3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-202508cb8ebso26135415ad.3
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724254424; x=1724859224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cBRR5rqTzmvw+BCgE74ahVmicZdmUn6HCl2MYGGdS44=;
        b=e4cOdlE3QVnPU/BoVQEEreyW60wJRjTdk10R7TV1GwCRS3qlnZZ7j0MkcN7Zl0DtV0
         n/z4mOCIgmf7r2bjaSUDulH4jM6tteEZ8aGnBpusGDQu2rTGNn0MwEGfjTmKkjTDxP1N
         ljmQEb92ZqU4zsorSaQRDDyTznnklRaTlcBA1JnZLII1lwqRw5uPlVQLV5loU4EAXOki
         D4iF3H5VsBR39rJZ7EQ62x/gPHCAfH1d/DV2hS443h66Axtey67+5BGJiQqeg8k7JH97
         5sXK0EEUhOq9krsWJ4PbWTI0BehxqxD+51G6pjdxBzzPL1bAytwmR+DVa9f6Glnu6Y+T
         SRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724254424; x=1724859224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBRR5rqTzmvw+BCgE74ahVmicZdmUn6HCl2MYGGdS44=;
        b=rIUWqMDyOD9O3Tl2frOXccqN3jwOu+ZE1g8kMJWZkHj6TliNUBn4NKP7E9gVRYER6/
         0jaY/1Gkm42o38yvZTp9OYpdteYxOHAF/AIr50+/gLra+qv9R4VVFD4+krZYlrrMorbq
         G+7Vkqu4nvWpuu4ROKXGeRHoL0FJtT8L00L6MP/tDMBUR2GZbVguh6FBXH5ibDNVKAy1
         58xex7AySSmQIVh3Qc6VubdJ0vWUsFlsXzO2eTYKnMnrIiIKtfzPzhS6AI9DZ4Tm5e/H
         WejrP5/B5mgd4aHcYnkDc8Kyb0Sw7APCtziIRNTG7Tqz9jJ8ThjIl/wHkkKM5hnoxEbN
         MnVA==
X-Gm-Message-State: AOJu0YzfWsS6BLZ9o771S09uZFwGRIacjwrL6LOwveScGFz/6ki+JW9g
	icNj2i7XKRQGFulyhcbozIYK4yoQN6wEgZKYunDyKvoSSahwH4pS
X-Google-Smtp-Source: AGHT+IE2R1U6yBZk6ViWHf8F2Q+p2EoZjjC/q4i/tqFnI+tjSZSTCT2wl9fy2uhjzFYUo9brDIDGHA==
X-Received: by 2002:a17:902:ecc5:b0:202:e83:eb12 with SMTP id d9443c01a7336-20367d14bf5mr34716325ad.22.1724254424251;
        Wed, 21 Aug 2024 08:33:44 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038b303sm95155675ad.192.2024.08.21.08.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 08:33:43 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Jade Dong <jadedong@tencent.com>
Subject: [PATCH v3 net-next] tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process
Date: Wed, 21 Aug 2024 23:33:25 +0800
Message-Id: <20240821153325.3204-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

We found that one close-wait socket was reset by the other side
due to a new connection reusing the same port which is beyond our
expectation, so we have to investigate the underlying reason.

The following experiment is conducted in the test environment. We
limit the port range from 40000 to 40010 and delay the time to close()
after receiving a fin from the active close side, which can help us
easily reproduce like what happened in production.

Here are three connections captured by tcpdump:
127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965525191
127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 2769915070
127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
127.0.0.1.40002 > 127.0.0.1.9999: Flags [F.], seq 1, ack 1
// a few seconds later, within 60 seconds
127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
127.0.0.1.9999 > 127.0.0.1.40002: Flags [.], ack 2
127.0.0.1.40002 > 127.0.0.1.9999: Flags [R], seq 2965525193
// later, very quickly
127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 3120990805
127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1

As we can see, the first flow is reset because:
1) client starts a new connection, I mean, the second one
2) client tries to find a suitable port which is a timewait socket
   (its state is timewait, substate is fin_wait2)
3) client occupies that timewait port to send a SYN
4) server finds a corresponding close-wait socket in ehash table,
   then replies with a challenge ack
5) client sends an RST to terminate this old close-wait socket.

I don't think the port selection algo can choose a FIN_WAIT2 socket
when we turn on tcp_tw_reuse because on the server side there
remain unread data. In some cases, if one side haven't call close() yet,
we should not consider it as expendable and treat it at will.

Even though, sometimes, the server isn't able to call close() as soon
as possible like what we expect, it can not be terminated easily,
especially due to a second unrelated connection happening.

After this patch, we can see the expected failure if we start a
connection when all the ports are occupied in fin_wait2 state:
"Ncat: Cannot assign requested address."

Reported-by: Jade Dong <jadedong@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v3
Link: https://lore.kernel.org/all/20240815113745.6668-1-kerneljasonxing@gmail.com/
1. take the ipv6 case into consideration. (Eric)

v2
Link: https://lore.kernel.org/all/20240814035136.60796-1-kerneljasonxing@gmail.com/
1. change from fin_wait2 to timewait test statement, no functional
change (Kuniyuki)
---
 net/ipv4/tcp_ipv4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fd17f25ff288..b37c70d292bc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -144,6 +144,9 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 			reuse = 0;
 	}
 
+	if (tw->tw_substate == TCP_FIN_WAIT2)
+		reuse = 0;
+
 	/* With PAWS, it is safe from the viewpoint
 	   of data integrity. Even without PAWS it is safe provided sequence
 	   spaces do not overlap i.e. at data rates <= 80Mbit/sec.
-- 
2.37.3


