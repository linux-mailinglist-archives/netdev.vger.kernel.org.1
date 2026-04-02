Return-Path: <netdev+bounces-274433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIGJHgcxzmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:04:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BB386720
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 719B6300D959
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE09325726;
	Thu,  2 Apr 2026 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYAoCrIs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B72D0C9C
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120331; cv=none; b=rDj8TvOd7rJhQoX1T6MsE/mtHmyoxriGjSqqQ9BMnheiotiCI3lUORwJoo9m+KOKeEURIRafLmc5KjZN6cFO407qbLs8IzY+b41PdGuu5asF/ICEwTYDVOZ4A/xqhVOXpvYyKSk1vsJyLOOEgosvRUWE7cwiEIIM7CHIt6knXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120331; c=relaxed/simple;
	bh=HeWDqnuCUNbOc87pipFww7ZSD9lUJ4uF/bVhvwUP5dk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LOEp4/qm1phxa5Wmit3Chqbu6gML+L1+/ayqsYG1kmUdTy6HynMPuPef4evXZJHUjAP1mUsuLjhgjK/92fSgF3HMUeDJ1/c92Or1sCnCtRQNqfY9h4f6H275KNY9diQKHWsMMCe+ULT3XI/sDWQE6qxFZvTVHbP6+HQpR62nCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYAoCrIs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad617d5b80so3346725ad.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 01:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775120330; x=1775725130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p7eDGaE6Ein2wXGTpixfHgCZRKEO6wTdrWwl2xXLB1w=;
        b=aYAoCrIsb+zsEfXeBalK6vn2sH2SAhPEr+t3qE+nSABdDpzxD9f3whjFwQ4DIM+R7p
         3xadKY/hR5wij5uOTjDDVqLanZBTcv/6h0CuCP+Dcfc89rkS+VKNxGoNWTRWiCtCedih
         142xZcM74ex5ZY34TvLwweVx8RnEpvtkoDoJHNvUL6yb+XxaCdXPWtg4dBF4Y7HdtvLY
         sCkWb4HC4q0fY3NvXWHgVVRg2sJ6wemspkSuCui1vA25eIsBcJSKBmojwvS/01Q4gNhO
         fLdAudsVche9+9oODiiGZ1lLJOgOTsofJTbN1gvxIgM9WocRDTgcuwrx0QXiMdwnLj7W
         wKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120330; x=1775725130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7eDGaE6Ein2wXGTpixfHgCZRKEO6wTdrWwl2xXLB1w=;
        b=TT2pRMhVsxToqYe1d2KJvuYBH3dNvS2t1NeeFkAdgfE5eLvvk9429QJoTlrTDvMh4Z
         8nHXSf5tIG3tgdDTnffAUCNvjyxcPR1fJLtjLW6YfudduRG3qTRopwjpmtDK284Zfcx+
         gomqFo9Z2yWQxuYs5rfYVCoNqdTPFDriN1+nayXH+E9/t4z82FFI5afHuSG/uxiufpja
         nvWPy0Dsmgmsg6FAzlH6ISY4ZcqjMQZjqDbx3AL2AJHVJjeh5Q2tJYmPtebVJmx830gC
         /Eab4F5TcLGHrmO+uoE8dyXungl8ZBKq0XbMEhV22SIY75GqG1MHzJkgfw9zSj8Xfx3A
         Q+Aw==
X-Gm-Message-State: AOJu0YwX9+POghAio0GrNW2ehLDpWIl+1LAAYNvNMrCFflUmFSr537wL
	aBhgdNuYlYZFSuJZSYQ53EC4D9sBW79GtISrH2tyiyxQcvS9TyMnNeTX
X-Gm-Gg: AeBDiet3ZfPKFwhBRuWMH682GML/030jxcYzwQc5SP/or9GBQeewcPpbabffeJAtviT
	IWhdtd7ZkuRqaEEBqm0uOlmoW7tS8XRczcdSP7Nag4+9F0VhzfaR9uPfdaytkJ8q8JxhyOtNi+t
	IzqPgjgQnusyNodJ1tX+pofpN9+3PEMsYbq6KL4Lmbv5f/dyJSBjzX9kTeZFJArJ7upp491eHyK
	+J42o2MXHV4ZByfuCQiJMnZen2nYFS69Lsk+/B9SSpRM6PtzXxOLWISg2mebplEQ5DREK/aUias
	jmg6VbhwbpYY/1kM+iIKc/PLge4ISAFpA56GkpfMwiT7Wzr/a1FXPPlYFLumcTLlH1vZhCCfHGB
	2iOdI3hDBclTBU5XYyNRTW7+zSaH/Ttqabab9NkLtyZCKZUIE5scNWuVf2CCCUMOO3Q7uTTcaQL
	lMpVHteIBH+6Qoxtdp0WgZWmHrYFd18aiWo9J2Y1KauxV60zCpNcOZnx5iV9Xuncxh73OmNQ==
X-Received: by 2002:a17:903:2c8:b0:2b0:b41e:c5c3 with SMTP id d9443c01a7336-2b269c57341mr69585175ad.29.1775120329967;
        Thu, 02 Apr 2026 01:58:49 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d1a2sm23524595ad.7.2026.04.02.01.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:58:49 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH net-next] net-timestamp: take track of the skb when wait_for_space occurs
Date: Thu,  2 Apr 2026 16:58:31 +0800
Message-Id: <20260402085831.36983-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274433-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: CD6BB386720
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even
though it might not carry the last byte of the sendmsg.

If we don't do so, we might be faced with no single timestamp that
can be received by application from the error queue. The following steps
reproduce this:
1) skb A is the current last skb before entering wait_for_space process
2) tcp_push() pushes A without any tag
3) A is transmitted from TCP to driver without putting any skb carring
   timestamps in the error queue, like SCHED, DRV/HARDWARE.
4) sk_stream_wait_memory() sleeps for a while and then returns with an
   error code. Note that the socket lock is released.
5) skb A finally gets acked and removed from the rtx queue.
6) continue with the rest of tcp_sendmsg_locked(): it will jump to(goto)
   'do_error' label and then 'out' label.
7) at this moment, skb A turns out to be the last one in this send
   syscall, and miss the following tcp_tx_timestamp() opportunity before
   the final tcp_push
8) application receives no timestamps this time

The original commit ad02c4f54782 ("tcp: provide timestamps for partial writes")
says it is best effort. Now it's time to cover the only potential point
to avoid missing record.

The side effect is obvious that we might record more than one time for a
single send syscall since the skb that we keep track of in this scenario
might not be the last one. But tracing more than one skb is not a bad
thing since there is an emerging/promissing trend to do a detailed
packet granularity monitor.

Thanks to the great ID, namely, tskey, application that is responsible
for the collect/sort of timestamps leverages it to put that record in
between two consecutive send syscalls correctly.

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 516087c622ad..2db80d75cfa4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1411,9 +1411,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 wait_for_space:
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		tcp_remove_empty_skb(sk);
-		if (copied)
+		if (copied) {
+			tcp_tx_timestamp(sk, &sockc);
 			tcp_push(sk, flags & ~MSG_MORE, mss_now,
 				 TCP_NAGLE_PUSH, size_goal);
+		}
 
 		err = sk_stream_wait_memory(sk, &timeo);
 		if (err != 0)
-- 
2.41.3


