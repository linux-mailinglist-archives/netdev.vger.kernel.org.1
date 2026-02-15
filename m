Return-Path: <netdev+bounces-258759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBhjJGVxkWkTiwEAu9opvQ
	(envelope-from <netdev+bounces-258759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 08:10:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCF913E310
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 08:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E80563017018
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 07:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040D4299950;
	Sun, 15 Feb 2026 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRHWKqIA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C120241103
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771139411; cv=none; b=dM81Sbu5aisB0nh11ORj4SakKe8lT11uQILCTlmHOYUhd9f0oHHawu2Vsehh9FO15fQhIk6Ga7vuAsk2Ddr/gw4DZqWV4XaUqeBxcv/I2BlNY5EvGYC/9wcoLPeAVQmR+rV71wHiIkNhKp3S9SNzjD3ztQ76Dg2ymymD3vr2BIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771139411; c=relaxed/simple;
	bh=48kQZ2ApYlekyRt0BAif+sMeREloJXMXGLg7PghooTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1Ql20ITAH89Eh4NSeLARzlYjlNzzPkHFmSfA4U7qCn2QRaX46sQ1uaEjKmooPPmoTpW2lt04hoADOzZEtm6Lg5WR5qYM7RllO0J9pV923AdQaaRouW2ynNtwdYvSKvwlyFysi1ufiJC1zsKdPv+QA7Q1o1p2QLoGwDI7CDb91M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRHWKqIA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c6e1dc5c5edso992825a12.1
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 23:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771139409; x=1771744209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oiLAHDVjSxKvSNOVbOnL+dTEI9S7sddzZ4pZsSNgz2s=;
        b=KRHWKqIA+Hwig0I2wXjTU+5im9uiaI6UvWHqlorLRby60XvL9xeecMbX0rGZVYE2hB
         ZHEcSSiRWfVVf8TLkZP6hXvZCoJh31ufNfiWbOIvPDWUGCzOhlLO7Y/QY+TIwObn5qMX
         3bjGH+o7SkqovpUQJq1ZPrih3DTe8Bn59uz5I+TDVaBibDUJXxOZRI9yaYk6Tnftj7MM
         eELB4Or1lz4gn+oF5k0s6YomvsNEI9ZWo6y/YKQygCl8pRHvUJiWmOr6kJNbPqg01+rS
         0jNbR5CvE5byP3UrsR6gST/mnlXl4+R9HDZ94NgySffWmOsXJxri8BqfyBhT0bSrR89X
         zArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771139409; x=1771744209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiLAHDVjSxKvSNOVbOnL+dTEI9S7sddzZ4pZsSNgz2s=;
        b=Uk5TpW5lO8d0ors4x2m8KSPbYQZnJAbdKeDN2GUO6AVPoHHYC+MaPt6O+Ph9S3Q8mF
         8hZxO+hXXHtA6nx4fzesz5i+qe9Llo88YACI2HH9cM/fj7b/eh/arkIBPbdcJfIOjOj1
         So808DCMkP3zogOFD08LZDzwqyT5E44b4coSPbq302gfoSS47kHAgJrgzyVrnJScZnCm
         aibOP//d74Dz4hjG3BYleh1sq2Uu1WCDuSkEh4DhVPDCq34+QWBRd9dvM+iJ++kS6TuQ
         C8IDLyyMhdegC81KMJf5SOubpBOaf030ZJUdXf+JAz5qK/lmUkKSM2AzY+HytnRPN+PB
         h7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTEMSPqTSnrcMPDtK2/dfEI+0a2wSA4veUQ6S5FqVNUSK8A9XVugH+FlyRRu5MldYO8VLd6ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUlCV1p6O3RUuEWxtcj0xpCbHOd+RcnsFgKsUu2E1OZFDDTTFd
	Ypy6JLfOeG8UiA9aV/PNWGIJkEqUm54ZZV6+Pc6x5EXitndFG+BLu5SX
X-Gm-Gg: AZuq6aKGIcC40Nhs7o3S0oEmwkkUbvjct8IAYkemaaih/I60u2V9+JBADWQ6r62lM98
	83vpjhxIdm7Jtd3i96+SjITgznoRj2w7e0mFx05NvhcroE7Y3yr+O/Q46Nno6v4Yy+U/y9JsRoc
	LzNISdHVr67kRjybTjdIw0RuSu3sHgTkBScG7CxBNt+WZ4zp8grqvOl7Ui/FzHBvffvcVw/8oR3
	tyayUcNjn9KubkijGOKVZkaKevLE9+P0K0F6o/1aN3zXWKr4GVMiNa0lgBwAv0PYjW4awPO25Qj
	IM8N/8TJbpaa1trOQYg+mYdhdfQDoM2ctbIUn1xOC2RA3Whncnl+BRiMLOKSTPPBYigwmrwIwEJ
	AEhmQjVROtgParklrRmfm25CfqQBWBD5ocPeI22k+bPgKU9a11+Q3MBRJF90uuuhkN9mVOG4LRe
	e5FWQlQBJQn1Hx2EXiXPi8KjqxCA3ja7MtfBWZfji+nbko942zhHqvR1to/QyHWRWdAPhxxrkj
X-Received: by 2002:a17:903:1aa8:b0:2ab:3ac6:8cf4 with SMTP id d9443c01a7336-2ab50598c3amr85915995ad.31.1771139409427;
        Sat, 14 Feb 2026 23:10:09 -0800 (PST)
Received: from tabrez-VivoBook-ASUSLaptop-X513UA-KM513UA.. ([2401:4900:93c4:3183:ba57:8db4:ce19:5f69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5bd3sm35445595ad.44.2026.02.14.23.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 23:10:09 -0800 (PST)
From: Tabrez Ahmed <tabreztalks@gmail.com>
To: allison.henderson@oracle.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tabrez Ahmed <tabreztalks@gmail.com>,
	syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Subject: [PATCH net] rds: tcp: fix uninit-value in __inet_bind
Date: Sun, 15 Feb 2026 12:39:50 +0530
Message-ID: <20260215070951.213341-1-tabreztalks@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258759-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabreztalks@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,aae646f09192f72a68dc];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: EDCF913E310
X-Rspamd-Action: no action

KMSAN reported an uninit-value access in __inet_bind() when binding an RDS TCP socket.
The uninitialized memory originates from rds_tcp_conn_alloc(), which uses kmem_cache_alloc() to allocate the rds_tcp_connection structure.

The structure is not zero-initialized, leaving random data in its fields.
When the networking stack later tries to bind the socket using these dirty values, KMSAN flags the uninitialized access.

Fix this by using kmem_cache_zalloc() instead of kmem_cache_alloc() to ensure the structure is zeroed out upon allocation.

Reported-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aae646f09192f72a68dc
Tested-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Fixes: 70041088e3b9 ("RDS: Add TCP transport to RDS")

Signed-off-by: Tabrez Ahmed <tabreztalks@gmail.com>
---
This is my first patch. Any feedback is appreciated!

 net/rds/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 45484a93d75f..04f310255692 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -373,7 +373,7 @@ static int rds_tcp_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 	int ret = 0;
 
 	for (i = 0; i < RDS_MPATH_WORKERS; i++) {
-		tc = kmem_cache_alloc(rds_tcp_conn_slab, gfp);
+		tc = kmem_cache_zalloc(rds_tcp_conn_slab, gfp);
 		if (!tc) {
 			ret = -ENOMEM;
 			goto fail;
-- 
2.43.0


