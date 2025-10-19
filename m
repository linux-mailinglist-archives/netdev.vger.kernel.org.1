Return-Path: <netdev+bounces-230749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C345BEEA60
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 19:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EB53B5EAF
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652841A9F8C;
	Sun, 19 Oct 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR4ermD3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20535966
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760893243; cv=none; b=VhdwvfbFJCh0eU0camRqSDlxwGAElp0LjrSDoDn9+wKGcsYjj8V0a4Fl0mLb7MjraxeMEEXVmteUu54/yHr5zYIp+MzoegNBmmqHxIsilbwlfSAMKOloIl2GQ0dYYPYRkD4W/zrgd68s5xNTBT+ucwAKGgYxj7YsGFZR/51Rl+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760893243; c=relaxed/simple;
	bh=PjDgNxlVxpxvR/toQXufEhgWxKZPOIL82AgrEwXPxEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKy1TzviFJIXTeytj4mpMc6QCNPJQFCjvS6/zI20Fbi/EgGsRjHIOdcLZ79ECGv3rqDvmaSjfWQ1WKrjxWHMnSj7AhJ9gkOUYYb9TLg/DWFJc41e0hVtmy8oSI7eAbT9KPNcmw1lhiRDDYl6N94IxIV/VcKkHczZv8yg10J2XKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR4ermD3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-88e4704a626so557464385a.0
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760893240; x=1761498040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1WbXALuGbpcuO9t7Qwi5yHTQM+NY8K1Dfz/3nuG1pE=;
        b=XR4ermD3fHK61ZGdIi6YEf7r0voAQtO13H6y17xAT3uYM7LMw6rvDylJMe1AONK2q8
         kg6OIFClDNJqNW4/3RNFqpG3tovbqpuu7LcRpwwi3s3C8W4JoH3eCP0W9oyZv5IHESGh
         sWUdiwgDGL7hNpN4VZvl6sMG8HGMMiDIXtwPgiQ7St3jnt0u1Pc/Vr+08o9fjPoma17c
         INFc+TS3RQ/XAgN1iCqvH0ehhi311/TIpyUWFNP4QmmAJ26IUsYfdBWEzcC93YUAQHUH
         llGxPxN9DpsinJ/6iII16BMObVvaSuch74vDYW72V/HgeBvrgwxyeBlQbm5LfePpN3/E
         dXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760893240; x=1761498040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1WbXALuGbpcuO9t7Qwi5yHTQM+NY8K1Dfz/3nuG1pE=;
        b=HVdIZYf2I/bOcfzCbzNpFDfRJOGbBRgiGS0cOOXsKGwvaagCAG+4l2nOaWJ2qo/WwR
         zjPrhuPyuT1QKUOT7FC6RHzRJJ2zuUqwCExtpxj5JnNnxPZ0MP9vI2oNOKn+7W0WEViy
         qyaPL2MsgGEjW1X7dTWAjpPQsnTqaCanC3iVQ63Rev3sLl5hC/FSe8JtXdbqfNWzM4Sc
         wOiznOuMZ/9pB/iOEuJUjBrt5BUhHCp4W/nJ45CWId+2UiTY9eoCErayCkGVLHakei7K
         OnXXt/XwjL8azk8Cicl96KJ4dgFsKWAnfIQED/x4z7RX6HB3f+o0Q1JwIl1tFjl7ICKD
         F8lw==
X-Forwarded-Encrypted: i=1; AJvYcCXQce+F1jfB+gUcO++3V669pS/ydBGExUNxc9JAjALTnYH9PvSDBZu2pGNPOSmnsGYQiO2qF9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsg1g6yprP+ereZ/HmV/LWGTbKTdDLJDQaCRo5rLNFJy+ujjzw
	lBc34hlpvtfHxWK/4q/6GmRpCIXTOyPnL8NMg83Iueh+0XnWNFq8O/pN
X-Gm-Gg: ASbGnctnaCzMUMb3zfGvNLhtYTTD8Sj5pKuRiOOcPOtr7cYbd1sqlrEm1VyTt+B8WiI
	bhECEle8gHNTM4rb73gc+5MM42D8rY7PqdePsIWcKIf7wGfeQswpD64BYet1YSIWBDKSvlvXvt7
	dBWx96m+EVQflrBeCe9WGBXwr3RhYDHTWDG5bCBJbyeUuUycPZ3PQDvKcwAPcK+dRsDCENearLN
	wsZgF9OTueZDvBmSYULR3w0+6cSaDe26WZ5spOJMPomM0yb9a6a7axA1zVBsxs9pqWY0gxka5Br
	Xd2GU5B8L6zTaZFQKagY4a1ou8PUcYapyo1NVndNEgJ+fe2XXVof/2CWsPlbOt9vyewda3FV8Ow
	fsf5UDFhvCQBBlsZflDFhlcNPJ7II5hdm1RL5Jy9l2i0eBLcZOoVCA0wo3SD1M+eIgP3vK61WIl
	/3CsS6noQSVOOL1Q==
X-Google-Smtp-Source: AGHT+IF4pq4PxQqmtKO4E4OsIVb1+IunUUBbkT5Zf3jvPepuTm4doaYmgj46bpXYCtJDfNkY/xDyDQ==
X-Received: by 2002:a05:620a:46a9:b0:891:9b1b:2792 with SMTP id af79cd13be357-8919b1b283emr942055785a.81.1760893240464;
        Sun, 19 Oct 2025 10:00:40 -0700 (PDT)
Received: from localhost.localdomain ([47.85.44.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba740sm384446285a.29.2025.10.19.10.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 10:00:39 -0700 (PDT)
From: Peng Yu <yupeng0921@gmail.com>
X-Google-Original-From: Peng Yu <peng.yu@alibaba-inc.com>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peng Yu <peng.yu@alibaba-inc.com>
Subject: [PATCH] net: set is_cwnd_limited when the small queue check fails
Date: Mon, 20 Oct 2025 01:00:16 +0800
Message-ID: <20251019170016.138561-1-peng.yu@alibaba-inc.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The limit of the small queue check is calculated from the pacing rate,
the pacing rate is calculated from the cwnd. If the cwnd is small,
the small queue check may fail.
When the samll queue check fails, the tcp layer will send less
packages, then the tcp_is_cwnd_limited would alreays return false,
then the cwnd would have no chance to get updated.
The cwnd has no chance to get updated, it keeps small, then the pacing
rate keeps small, and the limit of the small queue check keeps small,
then the small queue check would always fail.
It is a kind of dead lock, when a tcp flow comes into this situation,
it's throughput would be very small, obviously less then the correct
throughput it should have.
We set is_cwnd_limited to true when the small queue check fails, then
the cwnd would have a chance to get updated, then we can break this
deadlock.

Below ss output shows this issue:

skmem:(r0,rb131072,
t7712, <------------------------------ wmem_alloc = 7712
tb243712,f2128,w219056,o0,bl0,d0)
ts sack cubic wscale:7,10 rto:224 rtt:23.364/0.019 ato:40 mss:1448
pmtu:8500 rcvmss:536 advmss:8448
cwnd:28 <------------------------------ cwnd=28
bytes_sent:2166208 bytes_acked:2148832 bytes_received:37
segs_out:1497 segs_in:751 data_segs_out:1496 data_segs_in:1
send 13882554bps lastsnd:7 lastrcv:2992 lastack:7
pacing_rate 27764216bps <--------------------- pacing_rate=27764216bps
delivery_rate 5786688bps delivered:1485 busy:2991ms unacked:12
rcv_space:57088 rcv_ssthresh:57088 notsent:188240
minrtt:23.319 snd_wnd:57088

limit=(27764216 / 8) / 1024 = 3389 < 7712
So the samll queue check fails. When it happens, the throughput is
obviously less than the normal situation.

By setting the tcp_is_cwnd_limited to true when the small queue check
failed, we can avoid this issue, the cwnd could increase to a reasonalbe
size, in my test environment, it is about 4000. Then the small queue
check won't fail.

Signed-off-by: Peng Yu <peng.yu@alibaba-inc.com>
---
 net/ipv4/tcp_output.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b94efb3050d2..8c70acf3a060 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2985,8 +2985,10 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		    unlikely(tso_fragment(sk, skb, limit, mss_now, gfp)))
 			break;
 
-		if (tcp_small_queue_check(sk, skb, 0))
+		if (tcp_small_queue_check(sk, skb, 0)) {
+			is_cwnd_limited = true;
 			break;
+		}
 
 		/* Argh, we hit an empty skb(), presumably a thread
 		 * is sleeping in sendmsg()/sk_stream_wait_memory().
-- 
2.47.3


