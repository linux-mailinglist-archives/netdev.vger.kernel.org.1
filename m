Return-Path: <netdev+bounces-83012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8CA8906C2
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6151F2123F
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A0244373;
	Thu, 28 Mar 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxglwRYq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8AED8
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645395; cv=none; b=lnAkaWFvkDmQ6Co4VL6PI0kFOBDu/JC5wOlewj3WDKWsfDrCtrMlzqtQ19rGGNvOQ/Ez2vYov/v9G2DvEPqOP8/q6i2HOQGTi6crQ8yR5N5WDVJwh+KmXhQnXFtKfBfqqVg+ek+EL68bHTt05XKuVuHn1qON0hEMZrzGbosyvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645395; c=relaxed/simple;
	bh=lFeGl7dZQs/ZceANoJRiP1nMhVUnouVH1jtKb+pAUk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P2RgCzoTrJddRlvCbsJk2+MSf1FUgo/JNNLZgl1pmrlaM96HqLEcxpFOMRRzqisx9pQs5TnmT8JlAzSIIx60Rfyg/u2QzQ1XAmYgj72x3mGjx2sFq+B9gd+GJW9mDlcYv9GfV0hDXBPIcQUmFGmvAwvsLStCKwJ8WYejQOx76+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxglwRYq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so1421378276.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711645392; x=1712250192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jply39cwIs/FhQ97Ad44YD+TULK2Sf78Gyu9nOqDg5M=;
        b=RxglwRYqMRSA2np36Q3xwH1x4/f7c4W1e2KudJVrpAO0XtG3aH4wiJipnMXHr+HPYx
         PwL9HP8vHooJ+HDR+hbpAfpH3nh57QgEZUNHu5tQLhzLK63Jcx695ba73R6/LFd01kCZ
         CLn1jRvDBTemcHATa20geMUU6kec2zoszYd43+1gFDfgL1j+QqWal9u0Pd+AKUzYIBFJ
         iBBNEB/k3oz25VKELfszgbu8advQVzSlFnFSOUud0xmT7IX3B9PzHToCLgQCow2TgOq5
         cOHTm8vw+52ur6ONSEPLepP/2xgk/6ul/iQCVXrsCnnUpT8tIQBL2iVqrrjnV3LOKDt2
         isYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645392; x=1712250192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jply39cwIs/FhQ97Ad44YD+TULK2Sf78Gyu9nOqDg5M=;
        b=QZ7RcV2RfQ8G6mHL4UpogF5CqRImmXtZXDxyf7Vb/2fFW7Dxq5xDcf+k4NrdpT++xv
         u69xI9K2pTltkduP+2Jro9H1HXyJXIstOn5fK0u04T08EVMNySUQutGHxz+tzBaWr/pE
         jTfONqi8PGvUt+GiQyn8sJGjS6XrY7touSChTqDpUu1GPrCRJL70v9vw3QwYgTyKEDvE
         0LoLMU6PIRwaNcR0/SSoy+9COgbXKJiI+dpe7DAYNdUssmG35Od1pAaHt5XvPXJsfLh+
         BBUoLiGXy+Y0spyLoggPLmkbXfUQ5ybQ3LDJb5PJ0wLU8+okY5W40axGT7nR+Zm22/2B
         atQQ==
X-Gm-Message-State: AOJu0YxKkXbT7NZp3CHdRA/ZZmADakVfSpzXMckJ6NA9ZhzMgbLuubap
	+95WJ0OCapBJ5oHHQAo/KmyM5KDjKdx7Wr2tvx93k2oHzTb3FEMh7zZXoJir1bLB4G/G/hCUj1u
	EwYAyWzGKaA==
X-Google-Smtp-Source: AGHT+IG/P0JQvxEUyyUSbD8dr02ctAEomlSHiHMsKdqbDOB308hqdlTiFM7oSI1/wIeYAcxV4WtQY5hXAFIjJw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2413:b0:dc2:5273:53f9 with SMTP
 id dr19-20020a056902241300b00dc2527353f9mr249276ybb.1.1711645392697; Thu, 28
 Mar 2024 10:03:12 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:03:02 +0000
In-Reply-To: <20240328170309.2172584-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328170309.2172584-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240328170309.2172584-2-edumazet@google.com>
Subject: [PATCH net-next 1/8] net: move kick_defer_list_purge() to net/core/dev.h
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

kick_defer_list_purge() is defined in net/core/dev.c
and used from net/core/skubff.c

Because we need softnet_data, include <linux/netdevice.h>
from net/core/dev.h

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 1 -
 net/core/dev.h            | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e41d30ebaca61e48a2ceb43edf777fa8b9859ef2..cb37817d6382c29117afd8ce54db6dba94f8c930 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3287,7 +3287,6 @@ static inline void dev_xmit_recursion_dec(void)
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
 
-void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 2bcaf8eee50c179db2ca59880521b9be6ecd45c8..9d0f8b4587f81f4c12487f1783d8ba5cc49fc1d6 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -4,11 +4,9 @@
 
 #include <linux/types.h>
 #include <linux/rwsem.h>
+#include <linux/netdevice.h>
 
 struct net;
-struct net_device;
-struct netdev_bpf;
-struct netdev_phys_item_id;
 struct netlink_ext_ack;
 struct cpumask;
 
@@ -150,4 +148,6 @@ static inline void xdp_do_check_flushed(struct napi_struct *napi) { }
 #endif
 
 struct napi_struct *napi_by_id(unsigned int napi_id);
+void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
+
 #endif
-- 
2.44.0.478.gd926399ef9-goog


