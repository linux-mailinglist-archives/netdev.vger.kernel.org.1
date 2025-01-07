Return-Path: <netdev+bounces-155989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C756A0486D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94920188964E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8741E47DB;
	Tue,  7 Jan 2025 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buDNxbPl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7670018C937
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271529; cv=none; b=jcK5aVWbIFZHq68MT//7K7oHIQTf+s8SiBzXST8BkNwj7RmApsM9sZoCYsZ2rnn+YOgw3V5MK8rNYeii/2PDd9UhbkT1Y/MQ8TZcpPBXJeAOZs0Jdb/SUuSt6rvE6iwluBspsjpVA7qnbmvjpm1kb3kfzf+fET/AhabmvL2PA+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271529; c=relaxed/simple;
	bh=vvHJsNZfs8a27k8zTsQo7kKPdJPs3tLoWM/n0R9OT+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BC3c6C4y4oAlT7ZibZcfdKlOVAvCBIB/fU+YOkCcDZ7uMQpNfbPToDZFKU6cJ1glo5bGeY4pxscXJks6HCYZtD3s+wwpImNAtVolHBfTCc534Hd0BM/qfFX7Pi/KRKFkJN3UMPC8b1P8zXpzpDbOoQNder39jl5qhnzZ+RnGgcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=buDNxbPl; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e549de22484so8884233276.2
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 09:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736271527; x=1736876327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CcwIt0Uo0z7zPC6nu2T1OIPBfOjdzNaM9QUuptz60Aw=;
        b=buDNxbPlSH5+CW6gZ17yDwLlazzOHOXecJGQYYTpNbRt6WlFW7bPlihxE2v38PP+Qu
         at0fZY8tbXINJXyifB2XDX56n7/pOaXpNwsuVLGDQQEEYUYxHV6pRSx0AmrB4lxtvZ/9
         th2pzbCuBsBdxCR1I2/Nx3kCGKR72ZBy9EbcuHiCsaZQWJGWgdD04rKHILGlZxglj+wa
         QiuDxxyaV0PeR6024eT7Avfp4utMBeNMEJuyJEtrsxQdvsi15yxOpuBRz/ocWLg2BnXr
         JGSOUYzRxLOHig9WaPt4gj5Gz6KBD3FKb1lKqnZYbzepmJmnZ5puZTs/WkVxThrOjuq4
         LNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736271527; x=1736876327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcwIt0Uo0z7zPC6nu2T1OIPBfOjdzNaM9QUuptz60Aw=;
        b=i2sTEayqkqnSjb+bjBo3lKmtsDV5VNydaQRNCzskTSDFm2HHZTPmcKb7GHXNQxKLr9
         m5eMUyTd+qgtNmFNUiOn6cEpDoVTupLsRyGCxhFu4uN8iCMseqwZojWX4T6wp8iqaBnw
         AhLdDbthegD9HZ0F5OrzmDQ4UID+zhe4M9UUw15scqHnk68AGKq0qx8rsNA46ZEKdTs4
         QlpaDp2Ifa6FHcJ6SvuMHiy60MM58cD+RvMRT0w/ILYiLuwo/QaYGER/Tv6G0VI3ouwZ
         0f/1OHqNV7jQ9tyGXNIk470a1k8P5XiY136jZYNzVw3Si67v2Tb4/2K696A+X72fT2ga
         mrAw==
X-Gm-Message-State: AOJu0Yw2lRxvN15SC0l7zMqjO6OSIgnaBcvQcxvm8xzA/Sfhra4XMwOY
	p9qFiLa4kR4LVanuV4bCVCua8dV/fSATno2oUWFYceK/kAXTqV2nxaBmOd+UYEMiFxyVUA7vkZr
	x24OG+KIqqQ==
X-Google-Smtp-Source: AGHT+IH6IKOwZKwMYvyXUzv00azDOf3cBObuiSj86dq6wZWpS8p/vM8G7Lk7gWIy+sYetGJuJhOJxyKvZ7iWJg==
X-Received: from ywbir11.prod.google.com ([2002:a05:690c:6c0b:b0:6f0:1645:7f09])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:102:b0:6f2:9533:8fb1 with SMTP id 00721157ae682-6f3f80cdf5cmr419580497b3.7.1736271527475;
 Tue, 07 Jan 2025 09:38:47 -0800 (PST)
Date: Tue,  7 Jan 2025 17:38:38 +0000
In-Reply-To: <20250107173838.1130187-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250107173838.1130187-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250107173838.1130187-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] net: reduce RTNL hold duration in unregister_netdevice_many_notify()
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

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 342ab7d6001da8983db450f50327fc7915b0a8ba..9e93b13b9a76bd256d93d05a13d21dca883d6ab8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11529,8 +11529,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 
 	__rtnl_unlock();
 	flush_all_backlogs();
-	rtnl_lock();
 	synchronize_net();
+	rtnl_lock();
 
 	list_for_each_entry(dev, head, unreg_list) {
 		struct sk_buff *skb = NULL;
@@ -11590,7 +11590,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 #endif
 	}
 
+	__rtnl_unlock();
 	synchronize_net();
+	rtnl_lock();
 
 	list_for_each_entry(dev, head, unreg_list) {
 		netdev_put(dev, &dev->dev_registered_tracker);
-- 
2.47.1.613.gc27f4b7a9f-goog


