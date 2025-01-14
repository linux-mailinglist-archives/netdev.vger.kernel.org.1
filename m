Return-Path: <netdev+bounces-158231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9BBA11294
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4713A188AED7
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B879720F09D;
	Tue, 14 Jan 2025 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zxXi4D28"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E92C20F077
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888142; cv=none; b=LhWGmy1iYDjNxvF0kYusz35pk1RWyDiwMhrslaJ70GEeOhNg0iWrocNIFptUu7ER/KRjnYaRAZ1Mfld+Vf7lb4MxlT4uITrWkC7L/+LMy+jZo9chf6fJizdu9TzJcSx1GTGbEL8h9LrDYgYziOp3i3rd/kU06R3bLJXRzL92F4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888142; c=relaxed/simple;
	bh=tT/u3IIvDrQGFqxuwLN9DETqDeVfLw9jgy72mii2fk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t7axUzyEoIu5w5mYBR+ZqUhrTDIN7CTOgxbx5cOVsRWBSaRO/z5Ejnc/1+rsd8rq5d/W1tThEwwsP8+CtYGnwQbXCevFfUyA145DWPBERUp5w6gaV7KHeVZSi6yJM5DgWR8HAmnOIyYVFVSUm30SUTNFkKeO8Ayvr/CkrWt4e+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zxXi4D28; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d89a389ee9so130017286d6.2
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736888140; x=1737492940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdRt2MenkusSF76OGzgxiaoJEpU/B6XIKvkKO5Wni2c=;
        b=zxXi4D28vWuVR2sfGWT1oNhoeqdXWcidWmmK37fLO0Me0unmioGiO8Fdsop66ALMP+
         yvtiY3DpdAHI7AhxOJRg4EsAlIyBWRP2gOrxwnGsYDoWLfIusjrz1p6Pf9UnRub4UHsN
         1sT0/ENxz/yHLKtxmRFyBbUeT/iZz5Kjxvk+EYjw2jXAuXUsSf7EjmyxqHhzTWSchm+E
         ph6/E5dTYLTSC/XnAwla8PZ27tXmj2k6PFZXJeVbrrx+VYDTnBIlcMCmpzbhUGuKItBM
         /qWQTe5UAnmFUrWqr/TlW+43uME5yVI7TyN2dQFuvzDtgJx1M8KZJFQiEdeSVkGxXiV0
         5sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736888140; x=1737492940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdRt2MenkusSF76OGzgxiaoJEpU/B6XIKvkKO5Wni2c=;
        b=bATXwwi0cj9altu9UrJ5XdGfz5gIdJ66jfMMNQxwqlWcpMcL/wH7bBf/vjbAZvoo9w
         /QRpIjkMmhLD9LfRqKeHN7U/jdiKOawwL0QZQsUAWLX7VrWriOs0tiGpJIn3ZSlOscli
         gkRDl6Mz4CRtEEsNhaCxoj3Xp1fFoh8IXr7ciJPQelybOoY3VJBDQyo2tqylZfw3JUZu
         q8DYRdbdBlwg0FYPNGEAOqyyiaWEyrvSq+LPbdbaJNgd5P+f//8qch9B9oDLLHFby/Dr
         F845kVY1HxI31eOwZGmb5V/kqTfM1zbIojb+TjjKutGYQ4ZTNslf0UYX8XaHcgS3qCWm
         38mw==
X-Gm-Message-State: AOJu0YyOcSvRWYkJHEHYWSRFigcq07v/MEtQj3SU+xs+nxZYonDJL4nV
	pjNIqo+IyI91THtgqczWv3s+GGxQBdb1hHoRfsfmW95KJIvfu889G/ewOHq1ou2sEdiGTMl177O
	/EmBHI0xrsw==
X-Google-Smtp-Source: AGHT+IFhzDvDEuef4XgbiDkCrEpXZ3fOyfaYxd12cBEQbBPPUf2wKyKOFKyFiRs6DqSFe7O1/LcHxu4kzovhvg==
X-Received: from qvbow4.prod.google.com ([2002:a05:6214:3f84:b0:6d8:aa06:d4bf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:400d:b0:6d8:7d63:f424 with SMTP id 6a1803df08f44-6df9b1ea89amr387929836d6.12.1736888140030;
 Tue, 14 Jan 2025 12:55:40 -0800 (PST)
Date: Tue, 14 Jan 2025 20:55:31 +0000
In-Reply-To: <20250114205531.967841-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114205531.967841-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250114205531.967841-6-edumazet@google.com>
Subject: [PATCH v3 net-next 5/5] net: reduce RTNL hold duration in
 unregister_netdevice_many_notify() (part 2)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

One synchronize_net() call is currently done while holding RTNL.

This is source of RTNL contention in workloads adding and deleting
many network namespaces per second, because synchronize_rcu()
and synchronize_rcu_expedited() can use 60+ ms in some cases.

For cleanup_net() use, temporarily release RTNL
while calling the last synchronize_net().

This should be safe, because devices are no longer visible
to other threads after unlist_netdevice() call
and setting dev->reg_state to NETREG_UNREGISTERING.

In any case, the new netdev_lock() / netdev_unlock()
infrastructure that we are adding should allow
to fix potential issues, with a combination
of a per-device mutex and dev->reg_state awareness.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 574bd40f3a2bfcc6e43300fad669b1579d48039a..0bb97bb392dcdfa82292fe1ae2ee8290b036df60 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11601,9 +11601,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 
 	rtnl_drop_if_cleanup_net();
 	flush_all_backlogs();
-	rtnl_acquire_if_cleanup_net();
-	/* TODO: move this before the prior rtnl_acquire_if_cleanup_net() */
 	synchronize_net();
+	rtnl_acquire_if_cleanup_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
 		struct sk_buff *skb = NULL;
-- 
2.48.0.rc2.279.g1de40edade-goog


