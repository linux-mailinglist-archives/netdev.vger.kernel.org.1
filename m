Return-Path: <netdev+bounces-118996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25061953CD5
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502C51C23FD1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325C11514C8;
	Thu, 15 Aug 2024 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuZlv9KJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C91537D9
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758112; cv=none; b=prafxRiChYCY7N8kpIXFe8VIUCx5zkQMG03lvUNKlnnYqD92o1fT2XQo6SmF55F7VHgBkf5zfQkZb+FDKoGW1yzUNdt0J3f6m4Uctf++sd2E94E984fpwAjd/bfhNnU+IkIuE6ynLZSS7Uw35iVWhzaf5Nx8dCde41W+PIUQIYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758112; c=relaxed/simple;
	bh=4XKDJ2bCqnBWJ8j950CFtg4kuxeFoCoq9gkSPMwTOeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DPKqpyAggHUfQRw+ovnu3IyIhJY7DKhs5Cv+qnAIMfUrukME2dkv6cZE7yoZXGcEXhW2iO77401xfnGLKQgJSM3bIUJZLS4qSGbTSdzC0RNjoKuT4w2VQ9OwuSKscYAEFhYMYKc7vWVZJ2KvrO2OBHBmQXUSIf3ws7rJ5UlZ6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuZlv9KJ; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81fd1e1d38bso72924839f.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758110; x=1724362910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXaU+LmZo4dJEO29WyuVDJEWmFHTosV3Q9/izfCnvaI=;
        b=iuZlv9KJnbBp/X6699OkTyAPFGxuF84AafihKgnWsZz0MO19qybwJ/tKdIr5rP2N7i
         gOmfbyVks4CpjiPhfDuWhgs4OSdJbIIylIS7TwgD4YCEWlhD9MSWFOGLfTQDjvdjTwWi
         tJvDu/EUORIwbmr8GPVt45PFHDr1fbit7DmZ9IGLN9hW2TCHJJDh2n6AowFaC0RXx3Qb
         7louClVD18MKL5eHA7Go/fCGT7hzN0jjd6oQdxwGwLh5Tyis17GLBBVjInwqposiPs6L
         viAOdeuC9UpQq3jWJjOYLXgfnyE4ji1zaMF5+PnO5RpuPpvChhXJq6UDcB0cWJAE8gcz
         2RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758110; x=1724362910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXaU+LmZo4dJEO29WyuVDJEWmFHTosV3Q9/izfCnvaI=;
        b=Wnjr2SV7TrVmrC9EgJMjHfmAwkkmXse9nvdkAiXh6tu8fxjDb8xi9/WYS78Jumz7Ks
         QG2MIWyBOVx2jlVF/BHTVH7P2rN/KKokXzUrKGPbxQ7UvLfKQsTOWqag8D87OdG8P7Or
         TtOcrY49j0aDt517t71io5O/FqphanARwTQ9J4fNsDQnjRhavCf1wIMQ5tyxjuzxvyfL
         dFVsL3DJK2EDBml04gGceJqqO5R2bpAYUzzFmIfsQJWtgwushVDWj+2ydlwhVmJOXECO
         zT303sUZ8yOR6hCrsuEo+N2AY53MzALnwI6PW9E1nW2jjViiRINYsSoaNigMMQnlEVTc
         YTtg==
X-Forwarded-Encrypted: i=1; AJvYcCV5ButFz7WBbkwteRP3fP6yhd5TbWtz4/cNGMQBUqLX4LErmdc0udbFXOPBhhjNnK/8JRPZd3ST5aFmmquxEFs8tB5o0Tmc
X-Gm-Message-State: AOJu0YxAHyz6alB2Z/v2JBeZ7jxx7S/molKnK0yERNbmB7fKSr4psa3/
	tT0tqBTKr9fz1nw6S9J3yWvFCB9qwv3SUXjGWIWsvNQGumd5dXx1
X-Google-Smtp-Source: AGHT+IF8gD8L/u7JWscMIjLHOXrnEZCMtvWWBvRBSRlQeAo3Yprnsl87czA4vhAVzek2zM0OYo+9rw==
X-Received: by 2002:a05:6e02:20ce:b0:39a:e9f4:87b7 with SMTP id e9e14a558f8ab-39d26d71a00mr12535415ab.26.1723758109692;
        Thu, 15 Aug 2024 14:41:49 -0700 (PDT)
Received: from jshao-Precision-Tower-3620.tail18e7e.ts.net ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d28e13cd8sm642125ab.22.2024.08.15.14.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:41:49 -0700 (PDT)
From: Mingrui Zhang <mrzhang97@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	ncardwell@google.com,
	netdev@vger.kernel.org
Cc: Mingrui Zhang <mrzhang97@gmail.com>,
	Lisong Xu <xu@unl.edu>
Subject: [PATCH net v3 3/3] tcp_cubic: fix to use emulated Reno cwnd one RTT in the future
Date: Thu, 15 Aug 2024 16:40:35 -0500
Message-Id: <20240815214035.1145228-4-mrzhang97@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815214035.1145228-1-mrzhang97@gmail.com>
References: <20240815214035.1145228-1-mrzhang97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original code estimates RENO snd_cwnd using the estimated 
RENO snd_cwnd at the current time (i.e., tcp_cwnd).

The patched code estimates RENO snd_cwnd using the estimated 
RENO snd_cwnd after one RTT (i.e., tcp_cwnd_next_rtt), 
because ca->cnt is used to increase snd_cwnd for the next RTT.

Fixes: 89b3d9aaf467 ("[TCP] cubic: precompute constants")
Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
Signed-off-by: Lisong Xu <xu@unl.edu>
---
v2->v3: Corrent the "Fixes:" footer content
v1->v2: Separate patches

 net/ipv4/tcp_cubic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 7bc6db82de66..a1467f99a233 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -315,8 +315,11 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 			ca->tcp_cwnd++;
 		}
 
-		if (ca->tcp_cwnd > cwnd) {	/* if bic is slower than tcp */
-			delta = ca->tcp_cwnd - cwnd;
+		/* Reno cwnd one RTT in the future */
+		u32 tcp_cwnd_next_rtt = ca->tcp_cwnd + (ca->ack_cnt + cwnd) / delta;
+
+		if (tcp_cwnd_next_rtt > cwnd) {  /* if bic is slower than Reno */
+			delta = tcp_cwnd_next_rtt - cwnd;
 			max_cnt = cwnd / delta;
 			if (ca->cnt > max_cnt)
 				ca->cnt = max_cnt;
-- 
2.34.1


