Return-Path: <netdev+bounces-69125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4DC849B08
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB8F1C22377
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEF04878F;
	Mon,  5 Feb 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5HfpMMv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC092E41C
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137292; cv=none; b=TC1IVHuOHpmSZBS3HVH22Lk/GR5WtJXwweXSfr3Hs8Y+g4W/0hnCRgmfab1qcEjHk54mXxn92rnmrFxsmXoQxJxILmdraNa3nW3ENP8bxA+kvPcmEp0ugQ5LEg4a1cjw7IwJxMKfDjPnOonJVNnXBt9mIiq8LxfXnwKYc5ZdDbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137292; c=relaxed/simple;
	bh=vieDUHajw9g9bI48TCXDZok68ePYZRrGPwH2sUEDu2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MSAgjTlW87jA47WAZBWohzTCCJZc073TCbtndoHyR9QF48ftpe9n5/SgeovZww2w1Zm9jg1s+1PKTnRGBNieQIjybF/2B20spNzE2PF42ATfaVcoEQQVP6iyM4+yOkuDBOTvlBzaWrkyFSgclcRrBU4Dza8rKKfu7Ur76BqMkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q5HfpMMv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc3645a6790so8061683276.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137290; x=1707742090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwMkZajDKB3tGfY3+yic7STHRhzWz7YpyyPaMIumdYU=;
        b=q5HfpMMv+gDzOPVB92baszWXrqccfD6STefNtANsqf3mL2Wf/8b5mESuLnUIJ1vgfv
         YdmcUtC73THlYtR5nl4kDCNLAmssEYRRdjOdEQcBsswSYwybGRCHkO1rmLRlNKpr/Wuk
         B1GDvvGvuXg+8RXUZtiSyrR3aD54jbr2yu07aBjTWCuD34FAyZP3hqLhLYhRGStYSCcX
         swNDBN3ZDpmOcydaih5rSNFA+Xz6OA+hFpww6IUp9NemAjIJfcOp0m2EYHWg87XvJh1M
         RSp82VAtGKeLjK7DuvzHIGr5ZJXnbGzKe2tHUGsXwQRIA/DIF9fGKoIJEM2tkxI3s5YT
         ILtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137290; x=1707742090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwMkZajDKB3tGfY3+yic7STHRhzWz7YpyyPaMIumdYU=;
        b=SI/aUQzO5NLQPW3690zXJ/Ehf1pJQBzHV6l8K14ZtVTTUSf+ahS6ZrTSbSPueEp/Es
         5gugl4c5GtoDoQD5sVZZGxgaHC8dpXMx5dFzRlZPxIt2Ic/WmH27LUbE/rzLUega5DFT
         Ma3dFSczzzy2l+6/v5vUhTDY2CoHllM7ukGPiKATqcL0cVELajZ8alnjswmYHpWfD9yX
         1R+qrYdJ9LdWDAoO/eHa3PRN1tdIWQ3y4oHtFZ6oD0MUCF+HvGXqp0W5HN8uxV6nbGnp
         7wMGgJRctb10SHH4ASdwUCiwEJIJ+iuTNy40JAfC6+rZrO1564fOOx6KKbCIjU6OBhEy
         vRRg==
X-Gm-Message-State: AOJu0YybwmczkulApI6MfRyT1/wJWY0VpsiMiwcgAcz8NSa0chRj6bmB
	H4KWqvWzGuCmVKHMRSSqjquqVr5PlDSvyUbZ4x+0+X8cQHtM8qK24etOizHkJX5BCljRKz73KyX
	1PX5yrulTmw==
X-Google-Smtp-Source: AGHT+IHbwZwLnH72w4g7nJ/5sbg4M88j606oqT6U/kG+FMLRyoIC4hmmErDu8r7LTNg5lQugj5EQJizAX+Y7ZA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:218d:b0:dc7:4b9:fbc5 with SMTP
 id dl13-20020a056902218d00b00dc704b9fbc5mr1542454ybb.9.1707137289860; Mon, 05
 Feb 2024 04:48:09 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:44 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-8-edumazet@google.com>
Subject: [PATCH v3 net-next 07/15] ipv4: add __unregister_nexthop_notifier()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

unregister_nexthop_notifier() assumes the caller does not hold rtnl.

We need in the following patch to use it from a context
already holding rtnl.

Add __unregister_nexthop_notifier().

unregister_nexthop_notifier() becomes a wrapper.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/nexthop.h |  1 +
 net/ipv4/nexthop.c    | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index d92046a4a078250eec528f3cb2c3ab557decad03..6647ad509faa02a9a13d58f3405c4a540abc5077 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -218,6 +218,7 @@ struct nh_notifier_info {
 
 int register_nexthop_notifier(struct net *net, struct notifier_block *nb,
 			      struct netlink_ext_ack *extack);
+int __unregister_nexthop_notifier(struct net *net, struct notifier_block *nb);
 int unregister_nexthop_notifier(struct net *net, struct notifier_block *nb);
 void nexthop_set_hw_flags(struct net *net, u32 id, bool offload, bool trap);
 void nexthop_bucket_set_hw_flags(struct net *net, u32 id, u16 bucket_index,
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 7270a8631406c508eebf85c42eb29a5268d7d7cf..70509da4f0806d25b3707835c08888d5e57b782e 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3631,17 +3631,24 @@ int register_nexthop_notifier(struct net *net, struct notifier_block *nb,
 }
 EXPORT_SYMBOL(register_nexthop_notifier);
 
-int unregister_nexthop_notifier(struct net *net, struct notifier_block *nb)
+int __unregister_nexthop_notifier(struct net *net, struct notifier_block *nb)
 {
 	int err;
 
-	rtnl_lock();
 	err = blocking_notifier_chain_unregister(&net->nexthop.notifier_chain,
 						 nb);
-	if (err)
-		goto unlock;
-	nexthops_dump(net, nb, NEXTHOP_EVENT_DEL, NULL);
-unlock:
+	if (!err)
+		nexthops_dump(net, nb, NEXTHOP_EVENT_DEL, NULL);
+	return err;
+}
+EXPORT_SYMBOL(__unregister_nexthop_notifier);
+
+int unregister_nexthop_notifier(struct net *net, struct notifier_block *nb)
+{
+	int err;
+
+	rtnl_lock();
+	err = __unregister_nexthop_notifier(net, nb);
 	rtnl_unlock();
 	return err;
 }
-- 
2.43.0.594.gd9cf4e227d-goog


