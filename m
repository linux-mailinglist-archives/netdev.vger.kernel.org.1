Return-Path: <netdev+bounces-158230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8E0A11292
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5203A1278
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8722220F088;
	Tue, 14 Jan 2025 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOWISYhV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10820E030
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888141; cv=none; b=sUkxNv5xu9y2bUPcWKSzTakiB7J39vd5GjMztwW1Fhc07Vr6+znKe9tMwSCruRYYcC/x0xr3mbOORtO4GHNZsfFTNB6CWI/RdgeANx7Bk+fE2y09sEv1ZveSE9n0uuMgzFC7bUx5Uf4dnhSPWGD94osLmSYIiGHEVcPVFiS9o5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888141; c=relaxed/simple;
	bh=rQSLxR8KbIxeQ2MuKcauUf63uJ3Gtr7BoD8Hx1aKMQU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qatN9Pa2cHZ8mTphwZDt8IlH+Mazz6bFElNR4tYcJwFEzCzEIx2Tj1YRaBSgATou6WnmtNSIApVk81ll9uzGPgWC5W/bjZD3WxtmxdPOSc77tHkrqdk45bE7dpm5/c3+FvkgubxZwCQopNXPg1ShuFyj17OtLkJ6yvGOK8tYbzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOWISYhV; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b9e433351dso847692285a.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736888139; x=1737492939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EPbS0Ap1+J6rIE2hC9wrsURuYYqX/S/O4Nkt98Y22n0=;
        b=EOWISYhVHma2GDV91IQ/HZuEXggSn5lQcJNBCso0/Cl3H1lmbkjjW86eUdf0tHqhu7
         dsxhMNllUbnxlHJ79zZuCa7Hlx3Qcpx+LFRUYRo2EN6+oh8G9wcRCEYCKEiD4O/PwQwS
         teX90IqBkzTNoy1ijUAxS39wwlfVDu2FRIOOegLrw2v+WTQirlB61HlWUudXssp5U3Dg
         cfBUIOl7FU9wCmTfv/7rOlVgaiSroX2K/i2oLB+E6W1s4p6gCg3PX3ARrtKKWDQSKhm8
         bBnVOTj9d4PDu3KlzGap657HQUH4AUV74S/bK3rSFxs/EQK99Y0BKWSg755MjqjPMA3m
         i11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736888139; x=1737492939;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPbS0Ap1+J6rIE2hC9wrsURuYYqX/S/O4Nkt98Y22n0=;
        b=CibDBRIA3J6PwpfBEtsgRA1pTNtnVy0OOeHC9Ty4QQEMhEudBFeAleydtcEitJizYn
         Y9GfSHZkioti0bs3GfFZdhuSwFnG/LkynormJED/k4Hz6IyzECFYUae1SjK2dsWASbG4
         taIG6yqv6zXl3WnwTJI4YFLm6M9DrK8E6MeCpIU6DR8hCaomYHLFyxep6lTb2s5db7qx
         6VjN8AkZZfKmEM+jWPAh1He/wLwbNuLjWkck7ZXHoBv13n3Ca3SMvZ52F6NFiybEcrDo
         RGCInMrCpp4bW1ZYatxmEwK9JyZToIRhncDEoYI9E7lsrTms2Xhm0Y2nbZ0NckW46ZvT
         NICg==
X-Gm-Message-State: AOJu0Yzb42npFR24ejkj/NSY0JtLBhePDt3XfPh410QJInVTNIfvz+S3
	R36hK/B+GvvZFhwqpr67Kc9l1GuVMbJXhGHM5xHsvkflEeyStchSqNCml8nzg5yfNrL7ebJwxmd
	BZlF6gk+1oA==
X-Google-Smtp-Source: AGHT+IG93FrNRSnt60s1uDStXVAC9Yeuy3Lhrf0vOkYTx2SfiLBgvGDdhpr1IaJOMs5Q6lQ4DDsGhJBXcP+JWA==
X-Received: from qknoo23.prod.google.com ([2002:a05:620a:5317:b0:7b6:c486:8de9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4556:b0:7a9:aac8:f244 with SMTP id af79cd13be357-7bcd96e56d0mr3747912685a.13.1736888138809;
 Tue, 14 Jan 2025 12:55:38 -0800 (PST)
Date: Tue, 14 Jan 2025 20:55:30 +0000
In-Reply-To: <20250114205531.967841-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114205531.967841-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250114205531.967841-5-edumazet@google.com>
Subject: [PATCH v3 net-next 4/5] net: reduce RTNL hold duration in
 unregister_netdevice_many_notify() (part 1)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Two synchronize_net() calls are currently done while holding RTNL.

This is source of RTNL contention in workloads adding and deleting
many network namespaces per second, because synchronize_rcu()
and synchronize_rcu_expedited() can use 60+ ms in some cases.

For cleanup_net() use, temporarily release RTNL
while calling the last synchronize_net().

This should be safe, because devices are no longer visible
to other threads at this point.

In any case, the new netdev_lock() / netdev_unlock()
infrastructure that we are adding should allow
to fix potential issues, with a combination
of a per-device mutex and dev->reg_state awareness.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index f4dd92bed2223269053b6576e4954fcce218a2e5..574bd40f3a2bfcc6e43300fad669b1579d48039a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11602,6 +11602,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	rtnl_drop_if_cleanup_net();
 	flush_all_backlogs();
 	rtnl_acquire_if_cleanup_net();
+	/* TODO: move this before the prior rtnl_acquire_if_cleanup_net() */
 	synchronize_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
@@ -11662,7 +11663,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 #endif
 	}
 
+	rtnl_drop_if_cleanup_net();
 	synchronize_net();
+	rtnl_acquire_if_cleanup_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
 		netdev_put(dev, &dev->dev_registered_tracker);
-- 
2.48.0.rc2.279.g1de40edade-goog


