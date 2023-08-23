Return-Path: <netdev+bounces-30080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0650F785ECC
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EF91C20312
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC941F186;
	Wed, 23 Aug 2023 17:40:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D22C139
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 17:40:07 +0000 (UTC)
X-Greylist: delayed 67 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Aug 2023 10:40:03 PDT
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406E210D0
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:40:03 -0700 (PDT)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 23 Aug
 2023 20:38:53 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 23 Aug
 2023 20:38:52 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<wireguard@lists.zx2c4.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, syzbot <syzkaller@googlegroups.com>,
	<lvc-project@linuxtesting.org>,
	<syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com>
Subject: [PATCH net] wireguard: receive: fix data-race around receiving_counter.counter
Date: Wed, 23 Aug 2023 10:38:39 -0700
Message-ID: <20230823173839.43938-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.253.138]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Syzkaller with KCSAN identified a data-race issue when accessing
keypair->receiving_counter.counter.

This patch uses READ_ONCE() and WRITE_ONCE() annotations to fix the
problem.

Fixes: a9e90d9931f3 ("wireguard: noise: separate receive counter from send counter")
Reported-by: syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/net/wireguard/receive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index 0b3f0c843550..b5232ffa8bc7 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -251,7 +251,7 @@ static bool decrypt_packet(struct sk_buff *skb, struct noise_keypair *keypair)
 
 	if (unlikely(!READ_ONCE(keypair->receiving.is_valid) ||
 		  wg_birthdate_has_expired(keypair->receiving.birthdate, REJECT_AFTER_TIME) ||
-		  keypair->receiving_counter.counter >= REJECT_AFTER_MESSAGES)) {
+		  READ_ONCE(keypair->receiving_counter.counter) >= REJECT_AFTER_MESSAGES)) {
 		WRITE_ONCE(keypair->receiving.is_valid, false);
 		return false;
 	}
@@ -318,7 +318,7 @@ static bool counter_validate(struct noise_replay_counter *counter, u64 their_cou
 		for (i = 1; i <= top; ++i)
 			counter->backtrack[(i + index_current) &
 				((COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1)] = 0;
-		counter->counter = their_counter;
+		WRITE_ONCE(counter->counter, their_counter);
 	}
 
 	index &= (COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1;
-- 
2.25.1


