Return-Path: <netdev+bounces-156330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28173A061B8
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7108C3A3155
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310D21FF60A;
	Wed,  8 Jan 2025 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJiYJ6hZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC81FF1DE
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353386; cv=none; b=MEzR5L6AtPglsJfNidtbcz5dC/4mQeBw7hlIdw215ERMo8K+lm66FZGeFrN1VdfVV42bzX1KQP5f0Symcb02UjkSI2CQYZt00/Jz6JYPH7Q1PkIR9jKm68SqwsAM6pNDaPetC3niHG9o96+6XcYC+et9vueBf4SYFWqs0WIRuSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353386; c=relaxed/simple;
	bh=wismHMKSvkDLHvKmME2OpAhqeD4lUtTjzazscDtaTdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L3WEU0sYznES8KZ2fCS2EXrjobR7hODjnrEcH5xyDyqmVH+tS/vtP/uLp7YtxvfdjEod46gjlaO6u5ZJm5YSPi9XlzBWQrwconD4/PiXU5FBq6mv2pR8bM5D4pDkNzhxadllWziTcH2PcKwz77ZJsvEjdxiCbcwdjPVv8L7or/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJiYJ6hZ; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6e7f07332so832657985a.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 08:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736353383; x=1736958183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbzDviwearz7TxyF2UixIH7xoEZaBfrGaEL+pcXWhJQ=;
        b=kJiYJ6hZ5rHXok7dvJaNmYTaXX70Rj+t5oECGYg/7HJu7y2GHKuzqsG9Ty0caWnjiv
         D5yMBaC/bIj9BMo5oBwwD/sUohoWLZsJUHK518FM0iflDpCUKthdgp0NR7gNtyEv341T
         bq56p3JCEGMzvUY7dr0EAA7pBm6xW5jcsvivRXZT0BusHqzR3FAPfRToSMLdW/xCGW7g
         XJZ4cNupZLdykgk+oU0hNCssRYkG2zvTGTrsHTlmNIprCG+fHWcFvtY9Ci6yly3tzxv4
         QB4Gakk1fSIwv/c0REBl4PPRA/couKZYp54mi1bktSL/uzhnpw29+CSr11Hj26/JjLgv
         jKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736353383; x=1736958183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbzDviwearz7TxyF2UixIH7xoEZaBfrGaEL+pcXWhJQ=;
        b=X1bkqjxXM4mmD2qsJtGGECInQN9vvg2GYhClzxQralG0A8AoACcLHuiZbhwfc3tqnC
         GAi8ns3rQ9xFgNId1QMYA/OVOiWOQx9c6jw/5vcrJpFUnbbUt3fymgYNtMBKgjSJTJy3
         i0As+HsL51HJ+hxipPk52v3ym8e9gbgpRL1gjxUe53OWAdPksD/3SsXo6Ka4EQL0BNlZ
         z4p8/3fz0PSZTMufB9qNuy4pgciOKlBd95dMrnqVOBQY3Zn5+ZidODjtqUEanE3C34yF
         1JSMd6UKtEDyEjXk41C44/tN2evNonbp6imzPUU7zwKdqqL/6elNE3xfr8/zY8NbGkkH
         zULA==
X-Gm-Message-State: AOJu0YydxarQ8EE/xuRBJvpe1h8dvfcVNfKrizIhym8n4BSWB6MQ0urc
	OLcEnoWa4fKcgHBYQXbcXpxiwWYIvFFWZ15MeGRw0nluHR5UYxqtQcsUD/rHf4EMCwMM/BriDz6
	IT9thHD6L6Q==
X-Google-Smtp-Source: AGHT+IFwzjUWqgEdwXHUHJjfvt/nO42t+9163f8nVWhcCTbo4bCGLODKqe9HLFxwlLw1c9BzQmUoFK6PI3aZFQ==
X-Received: from qkbbk28.prod.google.com ([2002:a05:620a:1a1c:b0:7b6:c94b:252f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:25cf:b0:7b6:f113:b658 with SMTP id af79cd13be357-7bcd96e47b2mr476641185a.12.1736353382939;
 Wed, 08 Jan 2025 08:23:02 -0800 (PST)
Date: Wed,  8 Jan 2025 16:22:55 +0000
In-Reply-To: <20250108162255.1306392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108162255.1306392-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108162255.1306392-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/4] net: reduce RTNL hold duration in unregister_netdevice_many_notify()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Two synchronize_net() calls are currently done while holding RTNL.

This is source of RTNL contention in workloads adding and deleting
many network namespaces per second, because synchronize_rcu()
and synchronize_rcu_expedited() can use 10+ ms in some cases.

For cleanup_net() use, temporarily release RTNL
while calling synchronize_net().

This should be safe, because devices are no longer visible
to other threads after the call to unlist_netdevice(),
and the netns are in dismantle phase.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 86fa9ae29d31a25dca8204c75fd39974ef84707d..dde5d40e8f6b1ad5309ebc6a6e163ddb96f66f73 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11563,8 +11563,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 
 	rtnl_drop_if_cleanup_net();
 	flush_all_backlogs();
-	rtnl_acquire_if_cleanup_net();
 	synchronize_net();
+	rtnl_acquire_if_cleanup_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
 		struct sk_buff *skb = NULL;
@@ -11624,7 +11624,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 #endif
 	}
 
+	rtnl_drop_if_cleanup_net();
 	synchronize_net();
+	rtnl_acquire_if_cleanup_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
 		netdev_put(dev, &dev->dev_registered_tracker);
-- 
2.47.1.613.gc27f4b7a9f-goog


