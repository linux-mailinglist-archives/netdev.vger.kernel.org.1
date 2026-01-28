Return-Path: <netdev+bounces-254278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFTjCCsaemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:16:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D34A4A29AB
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15ED23013DAC
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511C426E175;
	Wed, 28 Jan 2026 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Z7UbvK+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89ED26FD97
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609747; cv=none; b=SbBBFnvINqjm8cuBzrcAJrMoEPMAU8qlpILDDXVTF9vw786W0bNgcZSaRVmn0yA2hWjyNOEi8rDZsFhKfzJbQeEV5obtBbpOp7jM2nXgxCqznQnEm7gladXk2hhzq8JOHHWRDJd2Z9EmE3gIGTh0Ej9B7I1zpVrLTczDLECTRso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609747; c=relaxed/simple;
	bh=jZBWO+apflum0vrSfQGh/tO/WHisXU743ZhdaFYF9KI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UXOxe6tZUM+fWIsuGO2TIGTu2/n+IFEw6C36LfrmONseG4YVHd3I804Ba7FimHxeWMaR69znyO2+7WARdQULcxmzqKuU7Egcj+c/8wjHs9hVZy46aIex0UgfBJQBgjmSnhjucR7WC2/yfYSMEkE2GnTjhtoxAGfBvFkImOHB97s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Z7UbvK+; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c71156fe09so296807685a.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 06:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769609745; x=1770214545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZR6YJ8YHAZy3j0QRtPcZKMtMyf33NYTNGDRHY/Yj6M=;
        b=3Z7UbvK+8LKPDmT1RB77uZdJ1svdE0UtQZvkZ5VMgIEn0XsCveWHgmP5tm3sEyLGTE
         ZLpiFQXJyX8iFB/wfJcpSJp/SDYZY6/4+KCLtu7h5E2UoBW+bE5G6zruTvxN1ymTzulK
         ph3mgOx/3BNCj/Dlqxxkbh7iYReT3RAX3pAhgob182ok9BpGTZ0eDGVI6SOP+D6mI6Xq
         JWXQwOOG1Aut2k27Jm4TuNy3SN2Uh372gB7466x0TBtenDMH7bGlNTVxuIq/y7AEiwQ/
         +yrkuPHAfdPW/HsgO+br8M6kIwndBCHa6dIVRjJNk6/MJucxWFsbKJI0gqhifRL3bE4X
         pvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769609745; x=1770214545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZR6YJ8YHAZy3j0QRtPcZKMtMyf33NYTNGDRHY/Yj6M=;
        b=jK/ZY24XnIOGuH+3PdLtJgrSNxaoIgFby4eKZCkBzcd8ZT/AbjGWB6FW+xXVY0mLJ5
         xMmgFekAY72QKdaC0Vag0Qw17j3jm8YeA2/X+zLQNFMX+S0nFT1PQQ7MbnGsn5EGS92V
         5gzX+qIaXqxrDYCZHfwtkTjPts9erya4c/nx2139RMR5pritYtjDP1SpMXHZrUKmKs9T
         ESNjqcGVPH6jWMwMu+yuRqxqg6Lec2oAB9NgCwkQXQumQDc3uBisS90dvXitOkmdLJFc
         swKsn0oFnMd287IEY7iczVzZWrWoJsOE0a43TEXT63iMEPuIl1d6F10DDib/dWrZLoF5
         3iCg==
X-Forwarded-Encrypted: i=1; AJvYcCXPcvZ5HTQUUsHlkKVsZrZ7uTrT3vdELsmP6G4bTbexH01PLGVHnvat5m9yTvzUgwDUqCc6Bv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9N5/UN4VWeKPWrb5sIZRofSerR46maTqewbAsqjSa0/WA/a1j
	f8j+JNqQ2DrFOzIosW9kR8hsj92i/99q/9HoERGWFiODniHGkDKuI8p2slOBzDW3Lmzekxle39p
	zx0FhfxD23Zh24Q==
X-Received: from qkntp7.prod.google.com ([2002:a05:620a:3c87:b0:8b2:ea9e:61a6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1789:b0:8c6:9fc2:9f99 with SMTP id af79cd13be357-8c70b8e6367mr622439885a.45.1769609744600;
 Wed, 28 Jan 2026 06:15:44 -0800 (PST)
Date: Wed, 28 Jan 2026 14:15:39 +0000
In-Reply-To: <20260128141539.3404400-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260128141539.3404400-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260128141539.3404400-3-edumazet@google.com>
Subject: [PATCH v2 net 2/2] net/sched: cls_u32: use skb_header_pointer_careful()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, GangMin Kim <km.kim1503@gmail.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254278-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D34A4A29AB
X-Rspamd-Action: no action

skb_header_pointer() does not fully validate negative @offset values.

Use skb_header_pointer_careful() instead.

GangMin Kim provided a report and a repro fooling u32_classify():

BUG: KASAN: slab-out-of-bounds in u32_classify+0x1180/0x11b0
net/sched/cls_u32.c:221

Fixes: fbc2e7d9cf49 ("cls_u32: use skb_header_pointer() to dereference data safely")
Reported-by: GangMin Kim <km.kim1503@gmail.com>
Closes: https://lore.kernel.org/netdev/CANn89iJkyUZ=mAzLzC4GdcAgLuPnUoivdLaOs6B9rq5_erj76w@mail.gmail.com/T/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/cls_u32.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 2a1c00048fd6f4b700bee11c80502aa3ff993331..58e849c0acf412d3a5ed5cd9a2b32929a720cb17 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -161,10 +161,8 @@ TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
 			int toff = off + key->off + (off2 & key->offmask);
 			__be32 *data, hdata;
 
-			if (skb_headroom(skb) + toff > INT_MAX)
-				goto out;
-
-			data = skb_header_pointer(skb, toff, 4, &hdata);
+			data = skb_header_pointer_careful(skb, toff, 4,
+							  &hdata);
 			if (!data)
 				goto out;
 			if ((*data ^ key->val) & key->mask) {
@@ -214,8 +212,9 @@ TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
 		if (ht->divisor) {
 			__be32 *data, hdata;
 
-			data = skb_header_pointer(skb, off + n->sel.hoff, 4,
-						  &hdata);
+			data = skb_header_pointer_careful(skb,
+							  off + n->sel.hoff,
+							  4, &hdata);
 			if (!data)
 				goto out;
 			sel = ht->divisor & u32_hash_fold(*data, &n->sel,
@@ -229,7 +228,7 @@ TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
 			if (n->sel.flags & TC_U32_VAROFFSET) {
 				__be16 *data, hdata;
 
-				data = skb_header_pointer(skb,
+				data = skb_header_pointer_careful(skb,
 							  off + n->sel.offoff,
 							  2, &hdata);
 				if (!data)
-- 
2.52.0.457.g6b5491de43-goog


