Return-Path: <netdev+bounces-117436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46C394DF30
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 00:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D9D281F69
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 22:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1F913DDA2;
	Sat, 10 Aug 2024 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ykxd/Zca"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5313210F
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723329239; cv=none; b=gpyd0x4ZiZlHqGSicL+0hJi0lgp8Qmebpnjz6XOf4K7z3z7mE6fziV9LORbfN6HDtT5NVLD8qXUpB35JRjAUp1X/XFJOO3Bd4Mdp77OehfcEsWyD/G++E5fWm1+sC7MhIb1hSbjzdS+p0w5odN2gLqZMvTpAI9Y0tzjN70qSqa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723329239; c=relaxed/simple;
	bh=XezRatnM+6hw7oRSk116g9OpbO0b65RPQsItLBn8coQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SEy/OMZLQPzbWKlzBGej/HfCksheWlhkLvRAAzOz+0Kdz2R4Zx7Lvaavq8T1/MT4Q2duAdO+21Zk1Si/5S16KS3OgZPG18ZNP4E4RANtJEuhb1nzxlQsvgqE6+6XbwEmfg4SzKccVaPv2Kef3tsCBk//6xfWy/LcIV5HPK8gar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ykxd/Zca; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-37636c3872bso14129215ab.3
        for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723329237; x=1723934037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=588YmN6AQ76s60NCV51w6ZYydzqK6hGBSAcyY5ZCpT8=;
        b=Ykxd/Zcaw6TOQtjb5VNBSVX5jWPs4/OSAZSD4fqq3a1j5FVe8Yp4lbg0YXiYTRqebs
         86xFQHtMloypQ9tA4bThuFh4Hdo+yQNDYoe+Gix9l1TSEdiQAdTscenPtFUsLSZyp5oJ
         iteYd9rMfo6bgrxnsB+VJyz5Ac84Wihu6+fZZzxMFC9XIL3kdDKY5jYxqETkfnN66p+5
         0J0J7sl4Es4KH5e7QEfN1WY/xoCk26b8H+jVQafPWFEj7t/x7XAJqjdrUMA1ZRpGNNjH
         EyXcnVPz0nqOppdt1QpksS6KJAh7bvMpyq8FcUSfHeulH6mVVLA5FBw53jQ1pfVOTgWO
         Rsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723329237; x=1723934037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=588YmN6AQ76s60NCV51w6ZYydzqK6hGBSAcyY5ZCpT8=;
        b=vfnmwF4u7JPRRGQAoWvgPP7oMH6mXvr8d7XyjlepnBmk1449kSVn0Sm8hBiM+j8V0S
         1IhMyKAo/IXU905uLwuNQDGPgyeu8W/2shJaDHEVUbI4y+bWVuxeHhk1jaP0Un0JnoA+
         5ghSbkcrtmATKZKGBLM6JxonXyZNqNtZWVaZ8FYUfVHp3lD6i2knWGsOR3VaLTYNDhod
         uAp9pKPoYr1Pchmgerl+p6dDIMXX6Jcm4qJYDIJda2aYB/7EyrfhcBqe/hF9TKHxkC6A
         QRjxZHHZEKbb8TfSzBonL04QoYw0BNeH7kDVXDEODH7mLCHg4veaIDEpPF9/PProrEOD
         LRKw==
X-Forwarded-Encrypted: i=1; AJvYcCW3BQtUj4ok1iip6HwaWzgwWXNdL1D21AvnIP37K2Wa0zifJwc5C6oHQUk6RJlZqlHVvFjXmObdJLVf4OK5GGkI0fp0c4gv
X-Gm-Message-State: AOJu0YzJ/Kmh2T7i5nAf39phmcWQgF8dgOqnh6QLECg1eKjitR3akjXn
	fjWmCVGhQJi/K0ZnmNNv7MjOmbE7oAmlAv2x4AcEJWb0kUUtEa+b
X-Google-Smtp-Source: AGHT+IH/cvJttBn6YbEUk5HobxrKwzJYdMRXpFujirw/sjHh4NMCyMscXLV0xaGLGUt0st0IvxhmAA==
X-Received: by 2002:a05:6e02:144c:b0:399:ed4:6e9e with SMTP id e9e14a558f8ab-39b7a44966bmr62822215ab.17.1723329237095;
        Sat, 10 Aug 2024 15:33:57 -0700 (PDT)
Received: from jshao-Precision-Tower-3620.tail18e7e.ts.net ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca76a01364sm761526173.95.2024.08.10.15.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 15:33:56 -0700 (PDT)
From: Mingrui Zhang <mrzhang97@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	netdev@vger.kernel.org
Cc: Mingrui Zhang <mrzhang97@gmail.com>,
	Lisong Xu <xu@unl.edu>
Subject: [PATCH net] tcp_cubic fix to achieve at least the same throughput as Reno
Date: Sat, 10 Aug 2024 17:31:30 -0500
Message-Id: <20240810223130.379146-1-mrzhang97@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch fixes some CUBIC bugs so that  "CUBIC achieves at least
the same throughput as Reno in small-BDP networks"
[RFC 9438: https://www.rfc-editor.org/rfc/rfc9438.html]

It consists of three bug fixes, all changing function bictcp_update()
of tcp_cubic.c, which controls how fast CUBIC increases its
congestion window size snd_cwnd.

Bug fix 1:
 	ca->ack_cnt += acked;	/* count the number of ACKed packets */
 
 	if (ca->last_cwnd == cwnd &&
-	    (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
+	    (s32)(tcp_jiffies32 - ca->last_time) <= min(HZ / 32, usecs_to_jiffies(ca->delay_min)))
 		return;
 
 	/* The CUBIC function can update ca->cnt at most once per jiffy.

The original code bypasses bictcp_update() under certain conditions
to reduce the CPU overhead. Intuitively, when last_cwnd==cwnd,
bictcp_update() is executed 32 times per second. As a result, 
it is possible that bictcp_update() is not executed for several 
RTTs when RTT is short (specifically < 1/32 second = 31 ms and 
last_cwnd==cwnd which may happen in small-BDP networks), 
thus leading to low throughput in these RTTs.

The patched code executes bictcp_update() 32 times per second
if RTT > 31 ms or every RTT if RTT < 31 ms, when last_cwnd==cwnd.

Bug fix 2:
 	if (tcp_friendliness) {
 		u32 scale = beta_scale;
 
-		delta = (cwnd * scale) >> 3;
+		if (cwnd < ca->bic_origin_point)
+			delta = (cwnd * scale) >> 3;
+		else
+			delta = cwnd;
 		while (ca->ack_cnt > delta) {		/* update tcp cwnd */
 			ca->ack_cnt -= delta;
 			ca->tcp_cwnd++;
 		}

The original code follows RFC 8312 (obsoleted CUBIC RFC).

The patched code follows RFC 9438 (new CUBIC RFC).

"Once _W_est_ has grown to reach the _cwnd_ at the time of most
recently setting _ssthresh_ -- that is, _W_est_ >= _cwnd_prior_ --
the sender SHOULD set α__cubic_ to 1 to ensure that it can achieve
the same congestion window increment rate as Reno, which uses AIMD
(1,0.5)."

Bug fix 3:
-		if (ca->tcp_cwnd > cwnd) {	/* if bic is slower than tcp */
-			delta = ca->tcp_cwnd - cwnd;
+		u32 tcp_cwnd_next_rtt = ca->tcp_cwnd + (ca->ack_cnt + cwnd) / delta;
+
+		if (tcp_cwnd_next_rtt > cwnd) {  /* if bic is slower than tcp */
+			delta = tcp_cwnd_next_rtt - cwnd;
 			max_cnt = cwnd / delta;
 			if (ca->cnt > max_cnt)
 				ca->cnt = max_cnt;
 
The original code estimates RENO snd_cwnd using the estimated 
RENO snd_cwnd at the current time (i.e., tcp_cwnd).

The patched code estimates RENO snd_cwnd using the estimated 
RENO snd_cwnd after one RTT (i.e., tcp_cwnd_next_rtt), 
because ca->cnt is used to increase snd_cwnd for the next RTT.

Experiments:

Below are Mininet experiments to demonstrate the performance difference
between the original CUBIC and patched CUBIC.

Network: link capacity = 100Mbps, RTT = 4ms

TCP flows: one RENO and one CUBIC. initial cwnd = 10 packets.
The first data packet of each flow is lost

snd_cwnd of RENO and original CUBIC flows

https://github.com/zmrui/tcp_cubic_fix/blob/main/reno_and_cubic.jpg

snd_cwnd of RENO and patched CUBIC (with bug fixes 1, 2, and 3) flows.

https://github.com/zmrui/tcp_cubic_fix/blob/main/reno_and_cubic_fixb1b2b3.jpg

The result of patched CUBIC with different combinations of
bug fixes 1, 2, and 3 can be found at the following link,
where you can also find more experiment results.

https://github.com/zmrui/tcp_cubic_fix


Thanks
Mingrui, and Lisong

Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
Signed-off-by: Lisong Xu <xu@unl.edu>
---
 net/ipv4/tcp_cubic.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 5dbed91c6178..2b5723194bfa 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -219,7 +219,7 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 	ca->ack_cnt += acked;	/* count the number of ACKed packets */
 
 	if (ca->last_cwnd == cwnd &&
-	    (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
+	    (s32)(tcp_jiffies32 - ca->last_time) <= min(HZ / 32, usecs_to_jiffies(ca->delay_min)))
 		return;
 
 	/* The CUBIC function can update ca->cnt at most once per jiffy.
@@ -301,14 +301,19 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 	if (tcp_friendliness) {
 		u32 scale = beta_scale;
 
-		delta = (cwnd * scale) >> 3;
+		if (cwnd < ca->bic_origin_point)
+			delta = (cwnd * scale) >> 3;
+		else
+			delta = cwnd;
 		while (ca->ack_cnt > delta) {		/* update tcp cwnd */
 			ca->ack_cnt -= delta;
 			ca->tcp_cwnd++;
 		}
 
-		if (ca->tcp_cwnd > cwnd) {	/* if bic is slower than tcp */
-			delta = ca->tcp_cwnd - cwnd;
+		u32 tcp_cwnd_next_rtt = ca->tcp_cwnd + (ca->ack_cnt + cwnd) / delta;
+
+		if (tcp_cwnd_next_rtt > cwnd) {  /* if bic is slower than tcp */
+			delta = tcp_cwnd_next_rtt - cwnd;
 			max_cnt = cwnd / delta;
 			if (ca->cnt > max_cnt)
 				ca->cnt = max_cnt;
-- 
2.34.1


