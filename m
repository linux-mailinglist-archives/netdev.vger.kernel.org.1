Return-Path: <netdev+bounces-74341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C462C860F43
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F95B2858B3
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7345B5D732;
	Fri, 23 Feb 2024 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPkRFKvh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D8E5D46B
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684173; cv=none; b=C69igUZMJZ5kgf4VkAA2QHsdg/Z2rIijJheAbn41jqt6qmOaUF9Yeq28dFD6lvZMZ4kWhejMmz53OKOEOikPaHLHJpWtSQ2tPRopeVwecNTb10X1ZQFsKIK4C3ig0oxMe2hubstRkrfXJikALECOXZiHOAZi62v6lMNXHsgTQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684173; c=relaxed/simple;
	bh=RTnwmupBOYfKe3zaPNw8b8LZ6kq8GKT/E/SmZKeIaZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0jGmdGiMES1n47jIkM5wiUTChsoOVA3aaPcii+PHBClKCM6xFOvmI+nTN156J/rC0yw71JzlpcbN/kcM1lyDZgQljg79C1R5wJInrdLGk2JAzBvopWtuZHJClJtREnLVnTMxWL9TZ7wn2wGG3ztl1r/wqVIvWDPw+smxHWoYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPkRFKvh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d7431e702dso964825ad.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684171; x=1709288971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/qUIqzG6cW/AClaTA+wsAnlXkMG+HDloY0t3WTwDFI=;
        b=kPkRFKvh5aFAxvp4xgPcZEJi5D3xax6EEVLYQsPEOIcETq0mgCWxtcutvQitF/RiFe
         rsBBlfoA14be1zGqNK2BabQer7ax5lrm/z5frZ3je50R8Bm8yMvIxwlLbcQiRwdzRy+D
         hLZn8qQqhh8shrjbwh9ReMTPtFWM7ruJM7qULapUt9C6vVkI0LEvm8HK3fJYsdCBJkwW
         XDigRyXA80U75TjGjSwUKv4OF8G5mRlUmxMzbm4HnmWUsrj2S1yUZoLat5MVdmofkWGu
         gwkbLAOoeVpOJ3kSVzScrS0lG6IvZXjFFq/ivQsfdihYMQbS83gi1twBDg0dK3MbE2cg
         U9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684171; x=1709288971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/qUIqzG6cW/AClaTA+wsAnlXkMG+HDloY0t3WTwDFI=;
        b=gViByCIAEpMmXsDLONhumr6zyg4w0mp3Yv/bDXJ/zV7gBw2k5N+Ie9xb4sO4rXo91+
         FZQ2poHjUv0eIblj3GBM3hnq3YBE1bGi4Zgz9B7lo08sKIEKacMZGAAwfHNHrYC7O4+8
         pZy4SDVe/mbaePhjVnVS+riGHF4QNJMjxgDmkYNEvtXX/SHX70X354fA3Zi5Om5Sunr9
         Mt1xsmVFRaWEKYIgpzmZ4bFESue4872ecR28CcOJipQ4VDCDzafkNT4JgWPvaaUyTN4p
         vVsE96NqHQHWClpt/zRXsOtz4XN/4SxAZfMwUdb243/0sm0WFyse0zhCffhJeFshYswp
         Ltkg==
X-Gm-Message-State: AOJu0YyJy/uxleuJ9KoiiCmlcUWEk3wf7/jg4DgNDtN+8qujf1a6j0r0
	dsFgNItzodsxRgQfJQ9J9GLoHFBMr/7W1lhG3xGVBr6ituNthknv
X-Google-Smtp-Source: AGHT+IGvyFR5BKv8LmYNArH+90c5yG7I44FygACqC2vl6lxudZarUviqBqJchJitR2gpt08vz4vnpA==
X-Received: by 2002:a17:902:e881:b0:1dc:6cda:bcd2 with SMTP id w1-20020a170902e88100b001dc6cdabcd2mr784605plg.34.1708684171343;
        Fri, 23 Feb 2024 02:29:31 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id jz8-20020a170903430800b001db717d2dbbsm11380543plb.210.2024.02.23.02.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:29:30 -0800 (PST)
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
Subject: [PATCH net-next v9 02/10] tcp: directly drop skb in cookie check for ipv4
Date: Fri, 23 Feb 2024 18:28:43 +0800
Message-Id: <20240223102851.83749-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240223102851.83749-1-kerneljasonxing@gmail.com>
References: <20240223102851.83749-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only move the skb drop from tcp_v4_do_rcv() to cookie_v4_check() itself,
no other changes made. It can help us refine the specific drop reasons
later.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
--
v9
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
1. add reviewed-by tag (David)

v8
Link: https://lore.kernel.org/netdev/CANn89i+foA-AW3KCNw232eCC5GDi_3O0JG-mpvyiQJYuxKxnRA@mail.gmail.com/
1. add reviewed-by tag (Eric)

v7
Link: https://lore.kernel.org/all/20240219041350.95304-1-kuniyu@amazon.com/
1. add reviewed-by tag (Kuniyuki)
---
 net/ipv4/syncookies.c | 4 ++++
 net/ipv4/tcp_ipv4.c   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index be88bf586ff9..38f331da6677 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -408,6 +408,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	struct rtable *rt;
 	__u8 rcv_wscale;
 	int full_space;
+	SKB_DR(reason);
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -477,10 +478,13 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (ret)
 		inet_sk(ret)->cork.fl.u.ip4 = fl4;
+	else
+		goto out_drop;
 out:
 	return ret;
 out_free:
 	reqsk_free(req);
 out_drop:
+	kfree_skb_reason(skb, reason);
 	return NULL;
 }
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0c50c5a32b84..0a944e109088 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1915,7 +1915,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		struct sock *nsk = tcp_v4_cookie_check(sk, skb);
 
 		if (!nsk)
-			goto discard;
+			return 0;
 		if (nsk != sk) {
 			if (tcp_child_process(sk, nsk, skb)) {
 				rsk = nsk;
-- 
2.37.3


