Return-Path: <netdev+bounces-118309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7333495133B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 05:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D04285BDA
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 03:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F2E36134;
	Wed, 14 Aug 2024 03:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5weaN18"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F610953
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607534; cv=none; b=ibv1h5S+clFrj2VNMG91vdH7TecLdAqa6XvcsVelbZcZXmcK25/9HI1MAceSDY5yKi2vOSD8IAzf3ZTFQAjzlibBDJPkVHn7+oqdJTp7kH6kbeJQJTTaM8BxKfUkuhhMomEeoYZ2XkmbGPDMus4vcwE3/fd810bri7dsc8zhcmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607534; c=relaxed/simple;
	bh=LXUGjvhaJnmrKmeNev0DTJotVgDsl1uZzStxvYORpSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=szAvZl/8Kph9n/UB2JGrZlrq5yO6LMhcJp2JyBczfRW6CdvFgoo5Sm8SVufqnFZnshtRW5SQXFGYvceQ5qqiPdzXNpmVgcVuLWc9l2ta5HCxd3U81rldM+vnRDjKaIu6gMYPXu/bhniRnihnwCGcJJtcbLMroOOJy6UwwLLrxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5weaN18; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc65329979so56700665ad.0
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 20:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723607532; x=1724212332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kwJ03KLoxEVXEbuFOWqvMnF5sxx/GwPWsBPWcPSK/U=;
        b=J5weaN18r67TAIjsKE7jXDn4C8gRwrUWE/VEfvjrQs8axY/hBqRRfR7KZlZuAKwD4o
         Ze5cjYs0I+AAmnqHeGKWlJfOWDCSJWL2PF7zaKDtkrOQJn1lSXqMFle4elLT+z8fl3Az
         EKNMWbU84ZqFNvacuC9PdNiBWQRCIGf90VbZuWlp2rnx335lY7/IUhkKagLEhTNY0/Qh
         I4q7hC0pxIkYu4mVOlxkkpci9nzmSQIeBPnNcJoxvER444pGbngjE0DWsZSJ09VfjWQm
         JnLQP5xKp6T9bv5zogy+SB+l9C/VO9kzFJa1D1fzl+lUbOQF7Gm0eIRyJCx7ZE6YD3j/
         u/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723607532; x=1724212332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kwJ03KLoxEVXEbuFOWqvMnF5sxx/GwPWsBPWcPSK/U=;
        b=ckPsLP5KHtBy/4H5wWz+u5k/+p0+69gB8VqGkvNi3cj9s9xPC7jeN0bKKY2gQO5GpQ
         +gLvJiEdCsiI50cE2F5q/C8t/5hZEXP8hREs+kMXFvffVPr/DhHBB+9RMoPLGgOgv2Rv
         CS8AAu8zZXUAQU794puyQjxBA5/+LbnzBAZCmfGzfvV3gaj2hBbV6DPu2yh8uHm1IyQ9
         cqLfUDRmEAEmMBJHX7VJWic7NL9MUCskELFItqtqn8r24efLo1EH2PpaXuPkObhDG2FD
         0bpCjITBCnLxnsi+sSsR1sXe2/eGoV0kEkdARM87S+Tu1OkF5fS7MqpMX/gEIqWOr0Nl
         t1mw==
X-Gm-Message-State: AOJu0Yzk3gupb+zIugEAnDXvYGicWn71V70RwVzQjzO76ydX7RuB+sU3
	uOCFbughacJGEcD77SrhLx77uFvCLmcz9TjORViOyurdAXIofgJiYaEO+w==
X-Google-Smtp-Source: AGHT+IHJk/8eDbT9Vv0M7EQT9Yw7W0Ipmtmqna51f3tKcMYhWR2D5D/ezxJZ+WeVMa6aAttefPbPkg==
X-Received: by 2002:a17:902:cf10:b0:1fd:69e0:a8e5 with SMTP id d9443c01a7336-201d6577b90mr14600105ad.41.1723607531849;
        Tue, 13 Aug 2024 20:52:11 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1c4571sm20584615ad.251.2024.08.13.20.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 20:52:11 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Jade Dong <jadedong@tencent.com>
Subject: [PATCH net-next] tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process
Date: Wed, 14 Aug 2024 11:51:36 +0800
Message-Id: <20240814035136.60796-1-kerneljasonxing@gmail.com>
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
which is beyond our expectation, so we have to investigate the
underlying reason. The following experiment is conducted in the
test environment. We limit the port range from 40000 to 40010
and delay the time to close() after receiving a fin from the
active close side, which can help us easily reproduce like what
happened in production.

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
remain unread data. If one side haven't call close() yet, we should
not consider it as expendable and treat it at will.

Even though, sometimes, the server isn't able to call close() as soon
as possible like what we expect, it can not be terminated easily,
especially due to a second unrelated connection happening.

After this patch, we can see the expected failure if we start a
connection when all the ports are occupied in fin_wait2 state:
"Ncat: Cannot assign requested address."

Reported-by: Jade Dong <jadedong@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/inet_hashtables.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 9bfcfd016e18..6115ee0c5d90 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -563,7 +563,8 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 			continue;
 
 		if (likely(inet_match(net, sk2, acookie, ports, dif, sdif))) {
-			if (sk2->sk_state == TCP_TIME_WAIT) {
+			if (sk2->sk_state == TCP_TIME_WAIT &&
+			    inet_twsk(sk2)->tw_substate != TCP_FIN_WAIT2) {
 				tw = inet_twsk(sk2);
 				if (sk->sk_protocol == IPPROTO_TCP &&
 				    tcp_twsk_unique(sk, sk2, twp))
-- 
2.37.3


