Return-Path: <netdev+bounces-121729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA6E95E426
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 17:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85DDB211A4
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6159915AADA;
	Sun, 25 Aug 2024 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm11eCpK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE13158DD1
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724599490; cv=none; b=VQGh/wixYr60nKidmJrec347ibXsKHAA+T1M9nsrOBBzz/Se7xKa3SlDbkyjTl5k0F2rmNuwF9wsmH7w/5WsFaJ8Kb8QukUI1JAI4OA61kzYtMGZdITqVgNkQgUF6TA3yoJ4oFKCYI7qMxBksHZ0RTpglUVVW6hNJq2lWby7Mf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724599490; c=relaxed/simple;
	bh=6xLZCt7kD5232S7if0U1ztY8+H6GCnlj3IUnRJaXAgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOANYyUm/WTl+3dxlfUhJitl2DmhFEYX2fZgV7Kf1EzUXycjRakGDUY0UwAmyHj3ReIRP2P2IY0CfxrwRAYoRn37QBTsKtdNhjdP6rm4SGKFbSh2bdgzuB5qOjt98vTpsbqn9O54RsGQY7hHlxO9Iu8lzm0fNDKJiSys+jpXeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qm11eCpK; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-27020fca39aso3051465fac.0
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724599488; x=1725204288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb5fKbNoO+MBQ8rKeDe304/HCsTgmy4qPM+fXVUQkF0=;
        b=Qm11eCpKj7KImjS4Ikr3IYgNG+mUjoIU9aPAHqH4sC6wbpIDyXpI3W/DzxjXS7rOUB
         7Q8eHyFPi8hhejufGLgIp9p8FzqJlGctrnMh9jdT89R/yoSI1oxtXfvno4vgrPMvZtkT
         zdRR2WLjG9HpR7PARZTbSqSE9a+jlHTTpHt7V6288QydLLFez/GkCnmxigXc44+pEePx
         ni7GAqrlq6ijvhf5/KcdRS4MdMfeUrdSZLtMe7Y2ewwpKhypPTg5X0K7o/ZZ6vDmr/ds
         cND/h3O+cTvTrsxI/Mj94Nw5wfPS9rLjX7641+cAUF2y9mIsGE1Vj5GysfJHBx63C2A5
         wxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724599488; x=1725204288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nb5fKbNoO+MBQ8rKeDe304/HCsTgmy4qPM+fXVUQkF0=;
        b=O2pq7EKAKlDNepPHFEpWWllK8argM16QeX8aOoreULkIsWdXtt6jIscLnk0xrzl+Ck
         WJlvh+xXZJGGIUnNXSsWck5ajro3Uor/SB2c4id9lasm+xp2tyCMBwSEUtycUXCLB6kK
         msJsOuIh9g6epbgEPSGIgUslW1k16P1EFlmTjNjiUKJweJgKjrBrFL9YplwiVTOTRWEu
         1xTie9zoYP8ZNFA446WrR48Kj+hPpSCfmcAmdiK9OInNe+h7oEQfCmiC7rC/UUSiTsqD
         yKWmRlbzCeJ07Mc7GFTNVALxVpi3BV/ZKwEOaYbiTJEucBRkO5GVC+pHdUEW+vyWsoec
         E7Kw==
X-Gm-Message-State: AOJu0YyKdZ6hQ0z+qcpRBmXYwIe1FdLHl6xER74K1ZDDjqnhlk/81sOS
	deMh4bBVVITlFoae8MuMQkILk2BuFPojkzpizG+3bN/QPqnJVbSd
X-Google-Smtp-Source: AGHT+IH/AB6ujWsEUmvNG5cUSy53mxRcXpfPGcK6NDxq65WqYXBQHSC8gWeXIerN0VFlD4ywLXJshw==
X-Received: by 2002:a05:6870:3329:b0:24c:59f7:e840 with SMTP id 586e51a60fabf-273e647489amr8238112fac.17.1724599487808;
        Sun, 25 Aug 2024 08:24:47 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430941bsm5775166b3a.168.2024.08.25.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 08:24:47 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
Date: Sun, 25 Aug 2024 23:24:39 +0800
Message-Id: <20240825152440.93054-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240825152440.93054-1-kerneljasonxing@gmail.com>
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
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
and set SOF_TIMESTAMPING_RX_HARDWARE option first, then running
./rxtimestamp, it will fail. The reason is the former thread
switching on netstamp_needed_key that makes the feature global,
every skb going through netif_receive_skb_list_internal() function
will get a current timestamp in net_timestamp_check(). So the skb
will have timestamp regardless of whether its socket option has
SOF_TIMESTAMPING_RX_SOFTWARE or not.

After this patch, we can pass the selftest and control each socket
as we want when using rx timestamp feature.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8514257f4ecd..49e73d66c57d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			struct scm_timestamping_internal *tss)
 {
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
+	u32 tsflags = READ_ONCE(sk->sk_tsflags);
 	bool has_timestamping = false;
 
 	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
@@ -2274,14 +2275,19 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			}
 		}
 
-		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE)
+		/* skb may contain timestamp because another socket
+		 * turned on netstamp_needed_key which allows generate
+		 * the timestamp. So we need to check the current socket.
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


