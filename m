Return-Path: <netdev+bounces-281167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE3GBZck7mn0qwAAu9opvQ
	(envelope-from <netdev+bounces-281167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:43:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E6B46A635
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4203B3005327
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EC5366074;
	Sun, 26 Apr 2026 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3AqaEBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F6366546
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214592; cv=none; b=Ih7oMuMRqC/RJUns2f7rOFdDmigY5JOYgWw7vPPNpMkw8kvng3S3SlRuKSSUEWBjp/Ur96V3igc0zOmKGdhcSe7cIrecw0wAaZBmCoNvCiEEhTByz5yiUQK7jn8JeHP5ShPIF8Ogxh9inw8qg7r7n+bXdGym40+OLMun7CwfeuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214592; c=relaxed/simple;
	bh=GTNaJU5rfiK/7CNFGset7McFd/fW6p7Tcwie3dvvoTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmNihbVkOI2mcF6BBdEVvSPQh+fvTOt0DpztEDlpcVf0a8/jJ2Fvb283J6Frw7Dhjh2YEenKjZWu/flIzH8p63m1MBhLCAAV907rtZDAJo8UPYfvBRTqa9yrkb7h6ym217CibfhkBvfoPQN42TGPkVaa2qNtBuSiwVooe5Omnkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3AqaEBx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso98669945e9.1
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214589; x=1777819389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KpsmARPAtRSvoDa9ymJ5i0W11MeQfCElgcBQa+2W2k=;
        b=D3AqaEBxrIgQBPDf2orZ4mLmKmnzyer1H6/PBz8GoahCZHrkm9i201Fe/gpunZ7Gf5
         suqIcZwmT07Z5Jg5pH/VpelOrgnw51964yiXFNV2jNBBxAUtm2iYms4uigklXOG5fgVX
         11Aar0tIoMAkyl0+cKCRQr/e/BumPBEsEhbq2o7fpF3dGJnglcojHONwzsW26BHl2bMo
         qSkEJdAPBqrdxh3UmjMcNzZpNvRokXQ8fSUsTR3D6P1jiFN7VKAzAeJNG+kAu6SzdJ/W
         NqmjfmcpZnJjaW53FYtN4q+F2GB0S9SJ7SIDDpCphRJzMlPg4bUu4vy8hETUKaLpx+Yk
         mQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214589; x=1777819389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2KpsmARPAtRSvoDa9ymJ5i0W11MeQfCElgcBQa+2W2k=;
        b=s0wep9bBcqdEJHEBpZ6jSdpVf6m5etHMZKA3ynV+sl4xQCSPg8xFa/IUqgGUcdFanQ
         FQdKjHQ+OarIvroJvPM+bOxpUs/sXk/5VsNFyZ9I0SGIJA710lIm5jZ7uAWAS8Rlyf/d
         X0BHaWPvQH9quIfzt+TwAARAINojovJ+cEsIjUrfF5Bgvz3eXWkwss4VLt8pyThueSv6
         6TTlGkkkxuBMvfAutnCIC7LVqe9Gsz4U81GkhphQE2Xo33VMXx2skJtMJt1v1J5WF8fI
         /DRh0A9mYDxyzToRwc8QS/xIggGNGzkq0PeOyDqJGZWbLRhCuw1kw+Ud+59sUDKELGjj
         086Q==
X-Gm-Message-State: AOJu0Yy3wmkw2hf4vHOgMjSK9qVngrg5f1vwAekUjqwyKeVKPyXhfD5S
	h30sazoXgxxANfUyiZfZiD/7vzNLWC6APh7C8F0qrdwiT97anVQvuP1gPn3JBA==
X-Gm-Gg: AeBDievTsAAbbN8UPV+Nylz3E8v3f6vx4fEasByuoqntd7CCXQcOJit533FC278olzW
	uVojvR8AWax8kwCoZQ+3XxKxTJfTvT9dJdOOUr3AGla++H52DtfJoVrgvd8Z2MNRCbOyeCKxmAw
	qVTXK8aF3qYKlE23bPdIPpHzJJLw7EDKtBj8TJWCicv2DDjRfYu565BCCQKf/ynHNghgv7eGMrV
	k7ZZZezvV5popn89owp5VusW5Pedm8+4abFtr95FUsXAB8eEXMPO3+hOvn7S8VgpDQWoe0ncPOG
	aum50RVb9CJaNG9ehorcahrxzWDk5TEIZVPYwVmCJiHOjexj3Wwitp6AB2ENcZyqRsQyLbnr4Qv
	Mdn8QEl28mxwXpwRvycE9A6/NRadD+HJH/Vjv3NKGxbEDhMxKR+n8VkqkF5bc2UF8ZOX+mE3xEF
	g4UK/t8EY4qwaXPnmg+jMb+ImEhYSVU+Wc4tavVUx/4vMyqSJVPmQR/YK/KUl0LOaWnYYMwRB9z
	b9DEBjVPZDULFE=
X-Received: by 2002:a05:600c:3515:b0:488:8b99:54a1 with SMTP id 5b1f17b1804b1-488fb78e7c5mr542589465e9.28.1777214588545;
        Sun, 26 Apr 2026 07:43:08 -0700 (PDT)
Received: from ubuntu-f6bvp (lfbn-idf1-1-366-193.w86-195.abo.wanadoo.fr. [86.195.82.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm658230335e9.8.2026.04.26.07.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:43:08 -0700 (PDT)
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: [PATCH net 2/5] rose: hold loopback neighbour reference across timer callback
Date: Sun, 26 Apr 2026 16:43:02 +0200
Message-ID: <20260426144305.984349-3-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260426144305.984349-1-bernard.f6bvp@gmail.com>
References: <20260426144305.984349-1-bernard.f6bvp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16E6B46A635
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281167-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

rose_loopback_timer() dereferences rose_loopback_neigh throughout its
body but holds no reference on it.  A concurrent rose_loopback_clear()
followed by rose_add_loopback_neigh() could free and reallocate the
neighbour while the timer body is running, causing a use-after-free.

Take a reference with rose_neigh_hold() at the start of the callback
(bailing out if the pointer is already NULL) and release it with
rose_neigh_put() at the single exit point.  The neigh cannot be freed
while the callback holds a reference.

Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")
Tested-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
Signed-off-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
---
 net/rose/rose_loopback.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/rose/rose_loopback.c b/net/rose/rose_loopback.c
index 914c8f453a1d..d66913df360d 100644
--- a/net/rose/rose_loopback.c
+++ b/net/rose/rose_loopback.c
@@ -66,10 +66,15 @@ static void rose_loopback_timer(struct timer_list *unused)
 	unsigned int lci_i, lci_o;
 	int count;
 
+	if (rose_loopback_neigh)
+		rose_neigh_hold(rose_loopback_neigh);
+	else
+		return;
+
 	for (count = 0; count < ROSE_LOOPBACK_LIMIT; count++) {
 		skb = skb_dequeue(&loopback_queue);
 		if (!skb)
-			return;
+			goto out;
 		if (skb->len < ROSE_MIN_LEN) {
 			kfree_skb(skb);
 			continue;
@@ -109,6 +114,10 @@ static void rose_loopback_timer(struct timer_list *unused)
 			kfree_skb(skb);
 		}
 	}
+
+out:
+	rose_neigh_put(rose_loopback_neigh);
+
 	if (!skb_queue_empty(&loopback_queue))
 		mod_timer(&loopback_timer, jiffies + 1);
 }
-- 
2.51.0


