Return-Path: <netdev+bounces-83359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED288920AC
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB5D1F226AE
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A88A1EB2D;
	Fri, 29 Mar 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ygSHdrxs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B91C0DCF
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726951; cv=none; b=pViy3YrBVrFv+hOgmHJr9oKo1hQ212gHjdN3rg6SJZt6ijQPoHTGnIrk95MgvQ0CJG5n1AyBBWG6mzXiHfC8dUORudyTYBvKpcvrvrssivJ42Ei0fwuRe4KuklcfQsHuvNHPK5vxG93dIhipz0CwSm7G+xTvxhjhYJatshXzhWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726951; c=relaxed/simple;
	bh=lFeGl7dZQs/ZceANoJRiP1nMhVUnouVH1jtKb+pAUk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g06RHoFluFgVA2n0LBIiQFjEwkhkVXcGPBUWfWK6LnCSzFLzO3SKFaG3nAZrcp+GCj6LS/3rC+ocd41DvlBXaQLy5FQC8LOS/5wXVTyZ64NCLVaX5z00twxuC+jF0PAwDroxzFdpiVmHgc3xHRkcxy/Dy+zrGL3ksLXzR2TJmqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ygSHdrxs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-610c23abd1fso38980727b3.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711726949; x=1712331749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jply39cwIs/FhQ97Ad44YD+TULK2Sf78Gyu9nOqDg5M=;
        b=ygSHdrxsY54NRdIZetlj/Y69ULykQcTwQjtpZFXHBiX3xmrHlpTJjt9qgcuxO0Pkbq
         onbNtcNWVuu2J07YFGKu+GymD1hwOlRbM2D9SIKekNMYjf76e6F0anAsdG/5k48oqoCp
         NZnsgIm88YvhEj7bXc1RWcdyp5ywHjjHvavGTAG1iJZGeFmiSlRAAlvLvW75Igg8CqO6
         HFi+9OvlcaTNUAlDafq9PhLH0QFUQE3FWem0/YFhlRkaIf81fWbUVqfihT4wlobpfLVF
         eq2a/UekUM39+u0xiKcPbuN82StWTJx5MsV5fcxND5xggfgwBxplOqSjD0LUCVnxAMdp
         GlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726949; x=1712331749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jply39cwIs/FhQ97Ad44YD+TULK2Sf78Gyu9nOqDg5M=;
        b=Qf6MiI6I7sHRHP4Eq7VeVoOoCPD0PuLPE2m2qgNgEWYH8WT9dfCRDWxw5lsuDxehEp
         1CkHbr5j0rd43b7+NeDJgT0BAE7LQKi7my/f1we8k9RmPKX781BXYncxv/FtGb1kSwVP
         eR4ajMPj5P6I6LbD9yxbdbo0ks9IwVjSJnd2hl6XfN7ojM5An9TEP2NpT9OECvDGcVIZ
         IjOiPBP5WXGGGia10vFzI/q5v2J6/i94hGwge7qS4vwkysxs31Laf9D7eKCny3B8mAci
         mzgtfqS1CqpCVLK6/RhpG3/KBLP1+QzAfSMiuiYKliyhDuJGd6TLeKvG2YluGLapi+cs
         4y/w==
X-Gm-Message-State: AOJu0YyccQyEgoCMqVc1tDIeGj0MaWoxaaTDDdkhLZy8Lr1eFWzCS8D6
	F2jRXP5uvK8sfQgtaQQBGQ48JhnMjGUYODBep/mN/RrQt479nURwhMSyclQwIO4S6LWNSyUdrNm
	4/bLCempPFw==
X-Google-Smtp-Source: AGHT+IGObWcfuDTpxaB2YNl3qmbcFeEonQuchJ4L065Op3Hp8qzbDUspWMck2EOKbWmAaypyLD5Jxxl4ewHcrA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:250e:b0:dda:ce5f:b4c3 with SMTP
 id dt14-20020a056902250e00b00ddace5fb4c3mr780544ybb.1.1711726949119; Fri, 29
 Mar 2024 08:42:29 -0700 (PDT)
Date: Fri, 29 Mar 2024 15:42:18 +0000
In-Reply-To: <20240329154225.349288-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329154225.349288-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/8] net: move kick_defer_list_purge() to net/core/dev.h
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


