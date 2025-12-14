Return-Path: <netdev+bounces-244607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F0FCBB530
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 01:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C062300983B
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 00:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18F03E47B;
	Sun, 14 Dec 2025 00:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdG15sA4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C52940B
	for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 00:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765671422; cv=none; b=oANp6bWVtX/tRPbmUtetato2zIoUIyeFPtlTaoTQncl03wsqZ4CmA2u70wZ61dy0KAHb/JppohftzmnERZ2YnMJiYJtVNirSN6kJt9pe2RQsSiTTiQtQcnUKwmlb/2uzFXqB6Ed2gh7Bl3nPHX7JI5/gu7/+ib3UfxxYpLQNgQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765671422; c=relaxed/simple;
	bh=4YnEvx2T6wIO+k4WvLZdUk0ePYrHjCLTLqetUiCY3HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSIlgllfTfeeC2+wrhBZ7quDBQNNaB7HqSPNWjgWskAy+hfnRM20c/8dYLe2O5YqPQ7iyn2/nNfyUekv+aC4lG1s16M5z0Fs2YtgeafWmRZUONnE2fHfQMjAnIOUgJ8A/TTezCFUIwxXZ9BzVKX+KFqbsdqejTKfFHiap5epVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdG15sA4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c3259da34so868403a91.2
        for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 16:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765671420; x=1766276220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXb+PpQxABhg5OSvFmLR0g0fj9WnLmBsWI+vQOQf3z8=;
        b=WdG15sA4A7A7aPrFFc3sLoB6Vmw+yYCy4U6Rv1dQvYwjYV54kKayP5jZfVnk7Xt6c7
         q01tcBcdUNnq4g616MTUFJL66uPDUYZhxzQyKb0z5D4n+NORMZGPCHmZVh+xmcKR6lhA
         vgbHJpf/QooXqSeXQl/GVPj4y4/MmxwoJe3vFoG48XswrpJjR7fNnnL+ty9v9iEmHeJ3
         Hku45/J7vU+bDZmKNxWWIjD4UCH1Akjg+42bUXRgmsMwT7wKUuHZLtOTdyZA6E16PLAg
         Ychf1QlT9c1fyp14Hnqjri7YeL/6YMSazJfP9vppf28W25NH3STFl6OHeHU2v6381B6H
         /0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765671420; x=1766276220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXb+PpQxABhg5OSvFmLR0g0fj9WnLmBsWI+vQOQf3z8=;
        b=ONYtoOP/H23L0M2U7LFL5pEVdv7yjXEbSt7LAuBIV/Cdso1eGn9yA/KkIT/CVhRD5J
         US+RN1g93MlnPeCyocXyFVnXTvfh4Ql9N8mDgsiOOdRvkpy75STnn2kFCW14VXDCdWtf
         QUT93s5MmZH4kt6ZLSAPgjtp9r96xmoCmF3Qgb64XBSVlX5UCtthICKOtVRegXlSk6eL
         bZnpSDVhPO5myktGFG0x/5IWZ5Jl3vMAyJemJYdP5HIWPXpb9gglCPHqELYl9tnXUJ6b
         deT4/haXfV7MkwzxVAS1dyyyDz9DXgljqCaufKl2xpAsfeeoBOkvmPUSrvs6Jajyo0AI
         c+LA==
X-Forwarded-Encrypted: i=1; AJvYcCX5SkTwJ+o+SIc6ohy01jOe/SSeNtd28yULkBTU/Z6+bHPjCeix0PAXyP8lgXQ64j41fQbkAZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhOxazBhd00n+Bn4Wn8P9RrJl8Gjlc7BQMMV3/d0fdSTmqz/P1
	IXvUW2igXKwnP/jDr7j5B4MthlQJw73qdWcK847PzvtpMrk1iQU/SaHc
X-Gm-Gg: AY/fxX6FZtT2RfRbt98cQXlFsENxWQpOK73yk8h4gw3NgCQWY0rSXGSbEqJ8I7x7FLq
	6vGCCpDW+YaIPBSozgXCZQRSfY7aZGsY+t4+4RzlAsnyc26teP34a3lGD3btehabBNeIu41go22
	LkeE08pQFcIjVnwLDFjSLecIox1lg9VD4XBKp/nSPpXRdfcZ6+lLyADgZhkE4RGZqIdoEjy0AZc
	Pe6AFRWzSEMOuwJQ0syNLl4YK6XGvlp3ZaUbJiLt1Zwq8XLihCB64p/Ta8fi97bO4fHUTSx+Z7Z
	XnijGJX4W85Bzyzx5Xua7R9um69/25FJ4nQeWfkyA9QbuElMQwmWorowZpbXixsgJHHUt4ZmYb/
	0skoJRrJxiJpk/oEhQ1pCDT4CpNcibXgxGWTXDQVbUaSNnAwLlgFJ7miJFEVRYgYIF6Wrk9Nzmk
	PsGb2YVfxspCFEmgt8UrN2iHz1Sj2cBj6SLct5VaU=
X-Google-Smtp-Source: AGHT+IEkbvehZPfODyds5PjOrUhsAgbJg/nqkZZGsbOgiCeo9uXm0nw94C/8hUoQCovwSJ1Mg9OSIg==
X-Received: by 2002:a17:90b:2749:b0:33b:ba50:fccc with SMTP id 98e67ed59e1d1-34abe477fc1mr5621266a91.18.1765671420426;
        Sat, 13 Dec 2025 16:17:00 -0800 (PST)
Received: from localhost.localdomain ([202.164.139.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe216c54sm5212504a91.7.2025.12.13.16.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 16:17:00 -0800 (PST)
Received: (nullmailer pid 1127174 invoked by uid 1000);
	Sun, 14 Dec 2025 00:14:10 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, Kathara Sasikumar <katharasasikumar007@gmail.com>, syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com
Subject: [PATCH] mac802154: fix uninitialized security header fields
Date: Sun, 14 Dec 2025 00:13:39 +0000
Message-ID: <20251214001338.1127132-2-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported an uninitialized-value access in
ieee802154_hdr_push_sechdr(). This happened because
mac802154_set_header_security() allowed frames with cb->secen=1 but
LLSEC disabled when secen_override=0, leaving parts of the security
header uninitialized.

Fix the validation so security-enabled frames are rejected whenever
LLSEC is disabled, regardless of secen_override. Also clear the full
header struct in the header creation functions to avoid partial
initialization.

Reported-by: syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com
Tested-by: syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
 net/mac802154/iface.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 9e4631fade90..a1222c1b62b3 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -328,8 +328,14 @@ static int mac802154_set_header_security(struct ieee802154_sub_if_data *sdata,
 
 	mac802154_llsec_get_params(&sdata->sec, &params);
 
-	if (!params.enabled && cb->secen_override && cb->secen)
-		return -EINVAL;
+	if (!cb->secen_override) {
+        	if (!params.enabled)
+                	return 0;
+	} else {
+        	if (cb->secen && !params.enabled)
+                	return -EINVAL;
+	}
+
 	if (!params.enabled ||
 	    (cb->secen_override && !cb->secen) ||
 	    !params.out_level)
@@ -366,7 +372,7 @@ static int ieee802154_header_create(struct sk_buff *skb,
 	if (!daddr)
 		return -EINVAL;
 
-	memset(&hdr.fc, 0, sizeof(hdr.fc));
+	memset(&hdr, 0, sizeof(hdr));
 	hdr.fc.type = cb->type;
 	hdr.fc.security_enabled = cb->secen;
 	hdr.fc.ack_request = cb->ackreq;
@@ -432,7 +438,7 @@ static int mac802154_header_create(struct sk_buff *skb,
 	if (!daddr)
 		return -EINVAL;
 
-	memset(&hdr.fc, 0, sizeof(hdr.fc));
+	memset(&hdr, 0, sizeof(hdr));
 	hdr.fc.type = IEEE802154_FC_TYPE_DATA;
 	hdr.fc.ack_request = wpan_dev->ackreq;
 	hdr.seq = atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
-- 
2.51.0


