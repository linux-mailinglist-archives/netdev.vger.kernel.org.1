Return-Path: <netdev+bounces-291138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKlKCYJhEmrwygYAu9opvQ
	(envelope-from <netdev+bounces-291138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 04:25:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 926725C11EC
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 04:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB900300E155
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 02:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D57A23FC5A;
	Sun, 24 May 2026 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8t+wmQj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C841E1024
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779589503; cv=none; b=INaz1X+7Mt5HYCHsJK9JWJbmnxbKapcjkKRzHqDldsg3iFsXzQjN9WY0Z4BI5ATWwZ6uYNW9+38T1cJqrZzGpQ57bCB0l30Ha/bAUU56JZBGdK1EqrSf+NA1rUuqTiOGE61LKWSg/s2ijJy7zGmYHbQ3pA7Ydhk+94RhfC/PiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779589503; c=relaxed/simple;
	bh=oNTzb7NkiEkjWclnnfQ+ldPnLfWe/Z2tuddaLXzWkfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9OEEg/2jqcdi/dgh+/sc06omrlSdGz0V3kAjNOKsD//88PDTIJqeBtizobpUcan27XlgC3Ds2XFsQA4mEp6faMnuM9/HjISxhSI9xEDD0z9x02VsZkaI/vvyRRsVLi96J5A1WnVwQyhUpbHYP45aDf+HnQGHXsHiUViHhV//jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8t+wmQj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so9343457a91.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 19:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779589501; x=1780194301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9aBpdYtn6siEZeQVdZJ+u5zexn0oUPIQQRdLGlWKXK8=;
        b=K8t+wmQjzfKy/xC5ZP5d8StbPZadyRk5h1C/0n50RCsJpBiafwZvMGT9ce96tDMLtJ
         FMqgOd8ndDeSKlU906t5i2qMo2CO8wuMIzliSuj3n0MjXM6/7x03ax6HutYaseLtMORv
         8t3XakaiwrlH4PFSxIZ2GEm+wvrQaAyOglFvkubUPKS+OJN/FzMoxRMNCnLgb4xyZ6UQ
         wE7Rhhx6MyoA5PkB72XnipsnnX6bVgiryXyvg04WkOXu33hZQfN7UAdCHb3W/I/KPDct
         QqWZ9ll4gfWHBG4J0Jx9Qss8z6bxkKm/C1nukxZbfsn7zvUuKTJfobgAi7nnwuCoBQ4V
         wURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779589501; x=1780194301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aBpdYtn6siEZeQVdZJ+u5zexn0oUPIQQRdLGlWKXK8=;
        b=Roz1PQv9//e2ZG3TzoP3EKXGk6j1owo6dvEjX3DVb9QiAJRY3z7mV8V41DXR6oprVV
         3Ide28zk/P58lEjDMkePZsHnWyfk8xZF+dWVUxxgsXve6VjbVDn0U8sat3S/DOWBBdKM
         ktw2+0O6N6G1R1rpf2lXtGBU65MO3prWAdYGmU1RMO0UtChZXiiiz8YAf2F9hWqS2aZY
         rhJzkMLX8HStvLMi0UEJ9CVX+x2DB7vBV740IKjqSjo2kaTnJljLNjlw5N9Rmm0YgtPC
         eQDm8J+jawwk52cov3OECfCv8IQ+G3j7RTAzDvja+Oj9UYsn4vP8NpLl2Sw3ubyY+OJv
         ZgFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ed92cKztl2SH2qVFNPuAA8VadGaKi0+GdLKD1E8k02bLzksluqtz9MYG2BXBTm28LGtuoGSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSKFPW9yvNkqZ/fgePgEm7ofoVmRfNk5+xHyazkq1kEOMmyshx
	AdiVyPMdyafaFTYG+KObxn3ft9mXVF8LSPSpIxTzJWJ5+sRgJmpNKc/8Utvyj3T9
X-Gm-Gg: Acq92OF2A6B0DMmAWzng/2XU6XX8GngBbYE6uA7EIQ6R48UDrkKxZHmQaBuwUy6Mfnq
	IRNzRJzGUxGBulx3fTUyDWdarzjPyGM/XFXSrGqWfHZEVb/wW7swfnZvbSYBUDIed5lpnmjI3k5
	y90nfbZ2B5VqYKuWg+GELWHgESDDeW1alIqeonTVgMXLLxSCMC3zb+jF8htjFsMQIqNHX+iUcjB
	CmQ19EZ8UANyHNwFUzD4+hFIIjO1MGRe05KT1aljnNPC07jI8ksqlnBFZdJGD4+nI/lT83CwPAg
	1/AfmtpoaLXZdU2Tp9XF5Y46R15bgUn3XZUF8w5fXq8IIJmCIQINNc8vYB32FRMeDIR5BHsUDZI
	0Ze38ZL/zlSZt2Z5ugz7NOo7o9CilSgUlTn43WEbfiCJYp3iA5n7chI5YWzjH5zSYpUsfwwYraY
	HugW2Eb+LDigCZqt50RtkW/h3ZzO5Gg0blhnQpcY0C2GJ7xOaY6HH/AQ==
X-Received: by 2002:a17:90b:38cc:b0:369:de03:29c8 with SMTP id 98e67ed59e1d1-36a6764cb9cmr9252232a91.23.1779589501010;
        Sat, 23 May 2026 19:25:01 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:ab70:7969:6f78:2a4f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c4ca35sm5804400a91.9.2026.05.23.19.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 19:25:00 -0700 (PDT)
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] ipv6: mcast: annotate data-races around mca_users
Date: Sun, 24 May 2026 11:24:56 +0900
Message-ID: <20260524022456.20689-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-291138-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 926725C11EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

/proc/net/igmp6 walks IPv6 multicast memberships under RCU and prints
mca_users without holding idev->mc_lock, while multicast join and leave
paths update the field while holding idev->mc_lock. Annotate this
intentional lockless snapshot with READ_ONCE() and the matching writers
with WRITE_ONCE().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 net/ipv6/mcast.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 6ddc18ac59b9..1297047fedb2 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -876,7 +876,7 @@ static struct ifmcaddr6 *mca_alloc(struct inet6_dev *idev,
 
 	mc->mca_addr = *addr;
 	mc->idev = idev; /* reference taken by caller */
-	mc->mca_users = 1;
+	WRITE_ONCE(mc->mca_users, 1);
 	/* mca_stamp should be updated upon changes */
 	mc->mca_cstamp = mc->mca_tstamp = jiffies;
 	refcount_set(&mc->mca_refcnt, 1);
@@ -950,7 +950,7 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
 
 	for_each_mc_mclock(idev, mc) {
 		if (ipv6_addr_equal(&mc->mca_addr, addr)) {
-			mc->mca_users++;
+			WRITE_ONCE(mc->mca_users, mc->mca_users + 1);
 			ip6_mc_add_src(idev, &mc->mca_addr, mode, 0, NULL, 0);
 			mutex_unlock(&idev->mc_lock);
 			in6_dev_put(idev);
@@ -995,7 +995,10 @@ int __ipv6_dev_mc_dec(struct inet6_dev *idev, const struct in6_addr *addr)
 	     (ma = mc_dereference(*map, idev));
 	     map = &ma->next) {
 		if (ipv6_addr_equal(&ma->mca_addr, addr)) {
-			if (--ma->mca_users == 0) {
+			int new_users = ma->mca_users - 1;
+
+			WRITE_ONCE(ma->mca_users, new_users);
+			if (new_users == 0) {
 				*map = ma->next;
 
 				igmp6_group_dropped(ma);
@@ -2974,7 +2977,7 @@ static int igmp6_mc_seq_show(struct seq_file *seq, void *v)
 		   "%-4d %-15s %pi6 %5d %08X %ld\n",
 		   state->dev->ifindex, state->dev->name,
 		   &im->mca_addr,
-		   im->mca_users, im->mca_flags,
+		   READ_ONCE(im->mca_users), im->mca_flags,
 		   (im->mca_flags & MAF_TIMER_RUNNING) ?
 		   jiffies_to_clock_t(im->mca_work.timer.expires - jiffies) : 0);
 	return 0;
-- 
2.43.0


