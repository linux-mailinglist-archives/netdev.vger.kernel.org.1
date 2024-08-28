Return-Path: <netdev+bounces-122855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3741962D2A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F541284EDC
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8481A3BA1;
	Wed, 28 Aug 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWqQcZcC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457B1A3BD5
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860915; cv=none; b=dtcpRBwNSRSoyFo82f+RsNRUI+EfPvHAhs7mkg/uV9cAjOz9owAobGb1jNNrjOuRlZncvkSlcY0yZLnhFxrMim3wo2/8ZBGRJ6pPAUAbfT5EgXXngP3BtLnIYVbD8iPVv0r3hYLwIVhhtgRYIpXyXZf7g7BHCRe4xj9B526I3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860915; c=relaxed/simple;
	bh=OXKcCvkmbY498MHgmSIU742eTu6/0FU9DxDXbKkb4e8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u1xWAwAZ9mi29y/tQ6ECzJZfJDrrWk0Lo3/2KA41QWTiRK5PBTV5eM9S7Uk/5SUQiUBlqxwwtZ+ODfenEbLGoOiKpzfPaLBrk3a8a8SwJXDf61H11bwCHGPPItGy7PqbdMebqOsnzT3/6L3kyqrdBDDC0sLM+vPsWRkRglIZDzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWqQcZcC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc47abc040so60346035ad.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724860913; x=1725465713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfYCWBLg7UIhZTXWebG7/ldcD8FdQIiqeiT+y0kUwls=;
        b=SWqQcZcCLkjlbNiny/Okxt/wYS7wgVTfKZ9v0mg+6WcGM9hy6uszs3vyv+5FjhHm+h
         UZBblHwsb3pLkg7HYpz25uB7qBZYfatrgWNzZcb2FTA0YEwF6YsZwXvf2/kFvX5EfOOw
         KOACZKfRoBOIllnKiYAY8UwIXaDPmjP0u9aOKi85ZktiZogFT7rAspoUT/4/9WmjaXe0
         310+g7zwfe0Xm0+ujsLQ4buu+ImmNKwX9UuTGv9TWBXkqfEHL+cA2Z53noAIIufvv8HH
         AIy78LYT2PVvCGvc/bUsBKCkSOjX1CbnmzizxzdXJqaAIjhNmKqIcnj78aIKp0AHuaQ4
         wESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724860913; x=1725465713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfYCWBLg7UIhZTXWebG7/ldcD8FdQIiqeiT+y0kUwls=;
        b=f2yOXIJcHYL2xHnyLX9bbZ+bbkmATnK29oLJjBnvpdgSLMw27mDZKJs1Gg8nTR8t6r
         ql9b3pM0fmATZ7Zl7fZ55LvHWdjJD20cWi3tBhk3jauthmiIMzdYc5QaALu6A6wapQNF
         LP4a38GsQyGvaTqaaRMHCQRwhNG/R/XlY7W6l/7mVAKFZOX5jB5m9rwgBaaCNVRqKGAd
         eCCBWIoosOOsMAkSFWI2A5upNyfzWmKsaNdt8RfYzkgy2Jnw216wacYq4jieqZkvl5+2
         6mX3sqyhLdria85HmBYyRJ9BxkIWFq/ukIpec38r47PBHXW1YnUhFDLmdeNBeb6k/hSk
         827A==
X-Gm-Message-State: AOJu0YzY9cOTBFoBTyeHTCziokdFlgZZcTa2hUCF0Kqrnrlww4eqv2pA
	4ICX2M0KbYzCJLwp2COBgLhvKMm4GRxdu/Cr6hnq3Y1bjaRBfz35
X-Google-Smtp-Source: AGHT+IFcg9MLyjlwu8uk7ZISWkMOgaZXeEUMfkk/TT+1MWT695gT0mIB85VvHnPCi7LcDukOs/W7Fw==
X-Received: by 2002:a17:902:fc8f:b0:1fb:57e7:5bc6 with SMTP id d9443c01a7336-2039e486f6fmr235978035ad.23.1724860913365;
        Wed, 28 Aug 2024 09:01:53 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385564dd9sm100061755ad.51.2024.08.28.09.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:01:53 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v2 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
Date: Thu, 29 Aug 2024 00:01:44 +0800
Message-Id: <20240828160145.68805-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240828160145.68805-1-kerneljasonxing@gmail.com>
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Normally, if we want to record and print the rx timestamp after
tcp_recvmsg_locked(), we must enable both SOF_TIMESTAMPING_SOFTWARE
and SOF_TIMESTAMPING_RX_SOFTWARE flags, from which we also can notice
through running rxtimestamp binary in selftests (see testcase 7).

However, there is one particular case that fails the selftests with
"./rxtimestamp: Expected swtstamp to not be set." error printing in
testcase 6.

How does it happen? When we keep running a thread starting a socket
and set SOF_TIMESTAMPING_RX_SOFTWARE option first, then running
./rxtimestamp, it will fail. The reason is the former thread
switching on netstamp_needed_key that makes the feature global,
every skb going through netif_receive_skb_list_internal() function
will get a current timestamp in net_timestamp_check(). So the skb
will have timestamp regardless of whether its socket option has
SOF_TIMESTAMPING_RX_SOFTWARE or not.

After this patch, we can pass the selftest and control each socket
as we want when using rx timestamp feature.

Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8514257f4ecd..5e88c765b9a1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			struct scm_timestamping_internal *tss)
 {
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
+	u32 tsflags = READ_ONCE(sk->sk_tsflags);
 	bool has_timestamping = false;
 
 	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
@@ -2274,14 +2275,20 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			}
 		}
 
-		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE)
+		/* We have to use the generation flag here to test if we
+		 * allow the corresponding application to receive the rx
+		 * timestamp. Only using report flag does not hold for
+		 * receive timestamping case.
+		 */
+		if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+		    tsflags & SOF_TIMESTAMPING_RX_SOFTWARE)
 			has_timestamping = true;
 		else
 			tss->ts[0] = (struct timespec64) {0};
 	}
 
 	if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
-		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_RAW_HARDWARE)
+		if (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
 			has_timestamping = true;
 		else
 			tss->ts[2] = (struct timespec64) {0};
-- 
2.37.3


