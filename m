Return-Path: <netdev+bounces-273460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id w7ANKOlKy2kYFgYAu9opvQ
	(envelope-from <netdev+bounces-273460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 06:17:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4A5363DCC
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 06:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D8AC3011BCF
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 04:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D4256C6C;
	Tue, 31 Mar 2026 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilg3xpvA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F42BD0B
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774930662; cv=none; b=gPjIJz0tY1VKu7AxKlGHr55SG9cLVVXQED4AU+X+9LXLkuwkLZlAckXTUvGTcEce+wTtROqF11Q2eexfaSorAmheATwL6aUseUmERSbu5LhKoQv46TqD6wwq7F4O0zjVhw/6qimUGa3zHzDb5hIcPQzOFrRF0i9X6vbs54tP168=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774930662; c=relaxed/simple;
	bh=MzKWxHAFEdlv7c8Yic4u4Sd+ALjU03D5yfSHvoFpels=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IED/FGSvR+rYiM9ryz/kiakKXrkq0Iq3k2zjTk9vyNk+u7Mz3JvelSqs1VAYQBg3Uuh9cx4eecAfqzWR/Av75o3Z58M6dlcGq2tqb8kS0FgSSoo9Na6sXlkKmVALWVSWrL2NtxDevrC83RCnBM+N2OXysaCNPw9ZTqvC9Bb2+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilg3xpvA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so2150065a91.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 21:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774930661; x=1775535461; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nxzt6stp5aPEeLuKTRFa6u/3qIPruI7QYvk4qIZhq0I=;
        b=ilg3xpvAZFxY4uJiyQOYLM2TXpOn0Bilcj4jj5rnR2d/SJLibmQ7z5sFZn803dw1TQ
         CsypG4FRI4gojybMIgx0RLp8id9K/i7dwD8jZ4I9XFWo0BZTIuGd4d+25TmY1/+IiyQi
         0c5A4Hfuvmf+gT3WCFl6XWxy+Hk0DbqRTaB0N7QJnoM9r6FwG+7xLuSBe3+yhCPHAV40
         9YwYfPQKHKPaqpg4rx6mcpzb8QjDxN2+loa0zZq2oPgvrmEju+odyAPEjog5rcW05RPN
         ylY8oF/a8w7WUdfkZZido9OSrwyRNQJAvP0lTnrmSo/N9WZ9f6jTYD4zIa8nRSiNAdpJ
         ST3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774930661; x=1775535461;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxzt6stp5aPEeLuKTRFa6u/3qIPruI7QYvk4qIZhq0I=;
        b=G5gAeuF4FUcLsLjWnINhxhyPRB85NRZAbC9d6Y+nznFUXdDw6/BLV2R/a98DVNnoKM
         JRfxIxBk0lAjRDgPEmz/zIFaWB8Wt6YM8ZRC4tbCS/JLu8hCP+uOSwBqrw5OmkdI/Pxe
         b0eYEsy0T1AfIOGA/3R/nhT5Qkt8D6AM/jSNb11yp7XmBMXBRpxtJ0oiGPk3J+ejI724
         jTuuNfv2PZxtOC1KRdQc30ERsgKNu4JTiKZn7fLqJZlphGnSWVRD9kOlDNzZ70kCjYES
         ImKpc9aeQNltQHrhfIGMmDr67sNlw9bCBzhB/r7RYNbmjhQUx0gP0GX5MGOlIsu42M/N
         tr8g==
X-Forwarded-Encrypted: i=1; AJvYcCU2lAICd0tBhUONSG/JIICaWU/eieIY8+NGpAue/wkGUT+7gDwHWnk+HfmQUkGLlJ2R3gLNB5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEjojR7J7Vuqe9P+QVHU4O4OpPauccVR0TbO8wOXJnhBosetVc
	IM5Z0R8PgUhgVqHmA+/1GLrEY74e0avVO1ZvGwWWkoG8Lqa4cV/0CKKT
X-Gm-Gg: ATEYQzxBXCmAHvAVA81Q7SbyGz9KGyrtDpV4ZN2cnNUrwZt3C/m+LGZOxo5mpv3hbV7
	Q2NvpsQs3yVMxSFpBh2cQOrxa7VJeWLe6CrB6C9hMLtXHDRiNbkf2tnlmjhBl5SpfmxWJCD5B33
	lJtxoVoS+ZYNQGd2jKY2wmIv0RHHX1cvGtyEBWheV7TjhaascI5ubnSqYL8cdQsBPu9+MHpKvg7
	IJKkRuWO6xwGeVc6aRNJnWgS3jVSFKmj51PwUXupMO3fRO6TYKiEEJhVHFvCqjj8XpytdzM3V1e
	YSoN8GFDeOENXxMoJoznqujc7AQp9hkOzZhC02MbtW+jODw6B56iAFHPATSpkPgBu2cNboy8jun
	u9QKB5PaIgnCn8Tj+L8FPr6NGFRtyCUGs1QQ4ejMm94ZtUDoTvlnM7ysriSgiPdgg7FjthJxmvG
	DHJvpywHSBB+mU6ibbnfEl+jAWX67h+3f/mnUYeAe1PcAw1Xnu83Aw81G+XgS1VkQhrz8+bH94d
	LvK4xyvK4exRkfpm7KyX/4iXRVFXBpM96Y61cbj0usx/Nl8Ic8=
X-Received: by 2002:a17:90b:48d2:b0:358:f0d0:1a19 with SMTP id 98e67ed59e1d1-35c2ffffaa2mr13567427a91.12.1774930660820;
        Mon, 30 Mar 2026 21:17:40 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:500:c92f:4f4e:9953:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24265a954sm99614135ad.18.2026.03.30.21.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 21:17:40 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 31 Mar 2026 12:17:18 +0800
Subject: [PATCH net v3] ipv6: fix data race in fib6_metric_set() using
 cmpxchg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-b4-fib6_metric_set-kmemleak-v3-1-88d27f4d8825@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQqDMBQE0KtI1k0xX422q96jFEnSr340WpIgL
 eLdG7JyVbqcGXizMY+O0LNrtjGHK3la5hiKU8bMoOYeOT1jZpCDzAuQXJe8Iy1bi8GRaT0GPlq
 0E6qR10pV4lI30JSKReHlsKN30u9sxsAesRzIh8V90uMq0vQXvgouuGkunRG6EGDyW28VTWez2
 OSucLTq3xZEq5BSg6kbXRk4Wvu+fwF5ei2wFwEAAA==
X-Change-ID: 20260326-b4-fib6_metric_set-kmemleak-7aa51978284a
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fei Liu <feliu@redhat.com>, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-273460-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED4A5363DCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fib6_metric_set() may be called concurrently from softirq context without
holding the FIB table lock. A typical path is:

  ndisc_router_discovery()
    spin_unlock_bh(&table->tb6_lock)        <- lock released
    fib6_metric_set(rt, RTAX_HOPLIMIT, ...) <- lockless call

When two CPUs process Router Advertisement packets for the same router
simultaneously, they can both arrive at fib6_metric_set() with the same
fib6_info pointer whose fib6_metrics still points to dst_default_metrics.

  if (f6i->fib6_metrics == &dst_default_metrics) {   /* both CPUs: true */
      struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
      refcount_set(&p->refcnt, 1);
      f6i->fib6_metrics = p;   /* CPU1 overwrites CPU0's p -> p0 leaked */
  }

The dst_metrics allocated by the losing CPU has refcnt=1 but no pointer
to it anywhere in memory, producing a kmemleak report:

  unreferenced object 0xff1100025aca1400 (size 96):
    comm "softirq", pid 0, jiffies 4299271239
    backtrace:
      kmalloc_trace+0x28a/0x380
      fib6_metric_set+0xcd/0x180
      ndisc_router_discovery+0x12dc/0x24b0
      icmpv6_rcv+0xc16/0x1360

Fix this by:
 - Set val for p->metrics before published via cmpxchg() so the metrics
   value is ready before the pointer becomes visible to other CPUs.
 - Replace the plain pointer store with cmpxchg() and free the allocation
   safely when competition failed.
 - Add READ_ONCE()/WRITE_ONCE() for metrics[] setting in the non-default
   metrics path to prevent compiler-based data races.

Fixes: d4ead6b34b67 ("net/ipv6: move metrics from dst to rt6_info")
Reported-by: Fei Liu <feliu@redhat.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
Changes in v3:
- move variable declarations to the top of function (Jiayuan Chen)
- Link to v2: https://lore.kernel.org/r/20260327-b4-fib6_metric_set-kmemleak-v2-1-366b2c78b5c2@gmail.com

Changes in v2:
- Set val for p->metrics before published via cmpxchg() (Eric Dumazet)
- Add READ_ONCE()/WRITE_ONCE() for metrics[] setting (Jiayuan Chen)
- Link to v1: https://lore.kernel.org/r/20260326-b4-fib6_metric_set-kmemleak-v1-1-c89fc1b312c0@gmail.com
---
 net/ipv6/ip6_fib.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index dd26657b6a4a..45ef4d65dcbc 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -727,20 +727,28 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 
 void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val)
 {
+	struct dst_metrics *m;
+
 	if (!f6i)
 		return;
 
-	if (f6i->fib6_metrics == &dst_default_metrics) {
+	if (READ_ONCE(f6i->fib6_metrics) == &dst_default_metrics) {
+		struct dst_metrics *dflt = (struct dst_metrics *)&dst_default_metrics;
 		struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
 
 		if (!p)
 			return;
 
+		p->metrics[metric - 1] = val;
 		refcount_set(&p->refcnt, 1);
-		f6i->fib6_metrics = p;
+		if (cmpxchg(&f6i->fib6_metrics, dflt, p) != dflt)
+			kfree(p);
+		else
+			return;
 	}
 
-	f6i->fib6_metrics->metrics[metric - 1] = val;
+	m = READ_ONCE(f6i->fib6_metrics);
+	WRITE_ONCE(m->metrics[metric - 1], val);
 }
 
 /*

---
base-commit: c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f
change-id: 20260326-b4-fib6_metric_set-kmemleak-7aa51978284a

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>


