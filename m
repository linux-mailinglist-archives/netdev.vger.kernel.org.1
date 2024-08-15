Return-Path: <netdev+bounces-118820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4481952D9E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1471C23567
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454E07DA9E;
	Thu, 15 Aug 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekX3HEXe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3AA1714A3
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721875; cv=none; b=c8+huYjvzCvuK3g5WyxX1wohb/Htha9pvZhOZjDJ/N/5+zxE++3dUJ3HY4W6i2TwHnmkitgQ2Wc0wJRpks4wQJSKiIsrRhRjZC2pmHd1YLLANZ0X1+uBeyyfH++Z4HcYebE4Oi8/OSg1ZBFdJEmR2qTNi/Uct714Qj7V4kqg46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721875; c=relaxed/simple;
	bh=HKDeMAR4b5rFbDFaaFPgm2vIKLOBeHRUZM+Hjqan3+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jl+YYeYj1oo9SEwE+5E3vLh1sXd44OsJQEfOZXbfUoIYlsw0ExIv5xBtwmGHTViDQYnI02NQYsDOTGRTv5YPr12tG6yiujKHT3Usqx+ni+8lhDK3z2qUcAV27K1I5TydT9b9xFvZP+poEieXvJPpcPSj8l8H5S8QVqO9acCWQrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekX3HEXe; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c68b71ada4so653269a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 04:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723721873; x=1724326673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/yNayYpqSsyft6W3uQUIFwwke3rQ+bWb3rq6DLbVds=;
        b=ekX3HEXeuo7nEWiYOdinQKPhY6TNC/vmLWlP8WgzdovdIJ9XsTu30w1qx2HURPRLeg
         XY4VqnHwv59ftPXBneuMnsjBID8ZRNUnfYqIKTzKeh8qATLRL1ofX6QMVh63pikhi0Gu
         eX6bbJavXs5SnX7TmYu1767AZMGzNgzUcoZVEvTQf16R70eCc2VEf2zQkk/m7hN2N3FC
         Nlt10xmlaVpDKjukaRtmkRkVk5P92qxKIhdTmvV6YhnJLs6G7psLR1aGcZwF6tphXUo3
         XYM9aYTSXcrPmEWL6ROA4U0NqkB8T1JY1HCHf1HpQg3EhFNzS2ZnE/zWjQ4SgWipj3IO
         P6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721873; x=1724326673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/yNayYpqSsyft6W3uQUIFwwke3rQ+bWb3rq6DLbVds=;
        b=I9G3Hw8Mr/8e3+CQgLgqzwbE3BRFjHDjRcpUHS/GMI9W/QumCwHlgpPRmx0tLkOU23
         3TJ+EDVF05APRx+hNOfVIr20em1Ce+VoMic4YudRM8SpkxljjiwdHTbA9ln1gUPKEDUV
         bB97VI+OfAUSWeSM2GAQmogLMHxUHRTLWeaHT4j6DVrNw1TckEh1GyDEJXTkqbBoGA4Y
         //trx7nhwGQm29ydU4/mCKLB19OztBQwrNdtmf7s7TBoznL57OLhzk9iXJHNPwv2Uy/O
         uo3nmt1I7Fc91JRQwadp8ylv2gSx02gnr/g8KBzf2R3reho3LwQ06d67woDY9SgHa7Ts
         W89w==
X-Gm-Message-State: AOJu0Yzmvmp9xz4yVQFAq6N+bAF31HVRx1XkqLy+hovwbE3daRG9aLMg
	0k1KNsU4VcVI01ZaXUPS46HwKcDAJrEB3Hmrm3AW7Yy/gaXKyPC+
X-Google-Smtp-Source: AGHT+IFyCxTWVWZZ5N/NvToYGH2s5LCqB3z5lY9NGpmY7Trsz/MA++bMTe2QjDiuXRAjeOxrTXoHXQ==
X-Received: by 2002:a05:6a20:2d22:b0:1c8:95cb:c42c with SMTP id adf61e73a8af0-1c8eae2f6b5mr8540328637.6.1723721872825;
        Thu, 15 Aug 2024 04:37:52 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3c88406f2sm1140517a91.42.2024.08.15.04.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:37:52 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Jade Dong <jadedong@tencent.com>
Subject: [PATCH v2 net-next] tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process
Date: Thu, 15 Aug 2024 19:37:45 +0800
Message-Id: <20240815113745.6668-1-kerneljasonxing@gmail.com>
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
v2
Link: https://lore.kernel.org/all/20240814035136.60796-1-kerneljasonxing@gmail.com/
1. change from fin_wait2 to timewait test statement, no functional
change (Kuniyuki)
---
 net/ipv4/inet_hashtables.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 9bfcfd016e18..b95215fc15f6 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -563,7 +563,8 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 			continue;
 
 		if (likely(inet_match(net, sk2, acookie, ports, dif, sdif))) {
-			if (sk2->sk_state == TCP_TIME_WAIT) {
+			if (sk2->sk_state == TCP_TIME_WAIT &&
+			    inet_twsk(sk2)->tw_substate == TCP_TIME_WAIT) {
 				tw = inet_twsk(sk2);
 				if (sk->sk_protocol == IPPROTO_TCP &&
 				    tcp_twsk_unique(sk, sk2, twp))
-- 
2.37.3


