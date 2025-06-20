Return-Path: <netdev+bounces-199803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8404AE1D54
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B918918914BF
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37616290BB4;
	Fri, 20 Jun 2025 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="09g5//je"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2A28C037
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429729; cv=none; b=ud+foOx4upqZ36LyvPORbHJe4EZ/LX6aSBnuYLY0IiJLlQ15xvgEmrOWCdpaSj3rMWJtZtfhkkxlx3L4Lu5A0WN9fXcbiyaEqt8fZuPaoIz3ln8XJs7wN8Z1y77+H3NHfhD7948JhpYhRDX0jz2AHwo9meGkiP/kHkBaxfv5MEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429729; c=relaxed/simple;
	bh=wyJ1AldihjksKlj0Wf2rIKS5eZVrGID1CU6W7BIEKE0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h1J47mYjxR4eh4gupgAdchKtv8TQQmBN8TOskBYPE+haNm1jzJ/H0wRqbNG/3ATqH2P7sfE67o46yH5+2w2a7NoVgo4+I2s4Af8mc/PLtL2zUKQ+3aimijFBwjU9VQy/benlVwK/yHqF3hBueWzvZU/kB+iDXn2kYIm1PDfGXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=09g5//je; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a42d650185so24549301cf.0
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750429726; x=1751034526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IVaerTtZwHPPzoFw7+UHIbyQpPa6eoLdpIq4+wIutf0=;
        b=09g5//jeMjmwjiE3lniy0SXqHFjbUCm0f+Dq8x0QfdY4fWzaIrbMKHYnTgBgCKF00+
         DHfI802rParhluNAcCQH645QSu05ZDztbIYgys2VqFxVFEUQGkKBkmP+x807EVu/ZYS4
         UgtB+yZJxTfMJI/ZO5/N24ZdmIIb8CBC2Q+r0aPqE5mjyNjDRTQD4V/B+uGJBWHtCBdM
         23S2D3pJrCB0O/zFlPoBywdcuR1gMzrRiN2XNAtWMNhpV4MPHvChLGlAMbsfvqvW06Vs
         Fnn10dIm2rV6tC6CTcBYhFDtsF38DeBX+XNDYQiolCvc0VSB5zuV7VxbkcBPxsbPF7k4
         1vtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750429726; x=1751034526;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVaerTtZwHPPzoFw7+UHIbyQpPa6eoLdpIq4+wIutf0=;
        b=vg4jAeGFXXaPubrPg8PPBxN/plHWjl9blA570XfdBlzzKQV1S/lo4bkCexESauCiAh
         6lo1FYZgjrgmQMxV1qHsgf5enK7UK+LbmOWtAsOGYJiefXXEm8D+ARmHaTBI1tpwoPDV
         VnAtk4Tht4SYj3GVCsXYogcYayRqe79EEqp7LNUbZddmJZBcZUkVT73dWGOx1yu94ms9
         MMIVdM7Prf9vK8G15X70MA1K0YPkHEyNmeZ4b23AWoI60WuX65+XHNkzZkJdKoEEBmcQ
         OnudNEs3y7WYgFwP29q6nSv5H6eKWJQsboyegnmZxxte11LKg6GOv/ufyyXNe/NaymBM
         GhrA==
X-Forwarded-Encrypted: i=1; AJvYcCVQkVI9z6CjqbRfGolxETXMr+lswilmbuf9ZFFn9e06RZELiRwv1cW0ITdttIuf0qL8e62cITc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGhZ3IywDCq8bIO61JUpkVCYsjCE6IQPBzMd35lfZ/3nnN6kLg
	LplT2WMV+3nMK9pM2os+GnsBwO4e9vRGw7sEsvSattdncKDYlscq5RNKcV7wkP14lmzYgJbbkY/
	yoI/K672sDM+rOQ==
X-Google-Smtp-Source: AGHT+IHt6RPEWkkMjV5lXQt8JXrLL8j6pX1s7GO56JXDD/r3C+BzzjUMkJ1Yc4NJ0wpm0+lmXCMaKzZ/zzX7fg==
X-Received: from qtbfy22.prod.google.com ([2002:a05:622a:5a16:b0:4a4:379a:b887])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:7c82:b0:4a7:7b5c:90a5 with SMTP id d75a77b69052e-4a77b5c9336mr25862041cf.7.1750429726492;
 Fri, 20 Jun 2025 07:28:46 -0700 (PDT)
Date: Fri, 20 Jun 2025 14:28:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620142844.24881-1-edumazet@google.com>
Subject: [PATCH net] atm: clip: prevent NULL deref in clip_push()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+1316233c4c6803382a8b@syzkaller.appspotmail.com, 
	Cong Wang <xiyou.wangcong@gmail.com>, Gengming Liu <l.dmxcsnsbh@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Blamed commit missed that vcc_destroy_socket() calls
clip_push() with a NULL skb.

If clip_devs is NULL, clip_push() then crashes when reading
skb->truesize.

Fixes: 93a2014afbac ("atm: fix a UAF in lec_arp_clear_vccs()")
Reported-by: syzbot+1316233c4c6803382a8b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68556f59.a00a0220.137b3.004e.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Gengming Liu <l.dmxcsnsbh@gmail.com>
---
 net/atm/clip.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/atm/clip.c b/net/atm/clip.c
index 61b5b700817de541d2882fb21f07992648460d4a..b234dc3bcb0d4aea0febff50d1b023cb7ad9dfe8 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -193,12 +193,6 @@ static void clip_push(struct atm_vcc *vcc, struct sk_buff *skb)
 
 	pr_debug("\n");
 
-	if (!clip_devs) {
-		atm_return(vcc, skb->truesize);
-		kfree_skb(skb);
-		return;
-	}
-
 	if (!skb) {
 		pr_debug("removing VCC %p\n", clip_vcc);
 		if (clip_vcc->entry)
@@ -208,6 +202,11 @@ static void clip_push(struct atm_vcc *vcc, struct sk_buff *skb)
 		return;
 	}
 	atm_return(vcc, skb->truesize);
+	if (!clip_devs) {
+		kfree_skb(skb);
+		return;
+	}
+
 	skb->dev = clip_vcc->entry ? clip_vcc->entry->neigh->dev : clip_devs;
 	/* clip_vcc->entry == NULL if we don't have an IP address yet */
 	if (!skb->dev) {
-- 
2.50.0.rc2.701.gf1e915cc24-goog


