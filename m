Return-Path: <netdev+bounces-131582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D098EEDF
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA42128465A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5439416DEA7;
	Thu,  3 Oct 2024 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOnT/a7F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A324315666C
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957645; cv=none; b=mkJOom+UwhSsbai/1OYek+nahtubygeVIYabYY20iVH4K2rn95T5B8JjH61fMcEZSiaza1PXk/ydusNMxqDgGtZSDBFzcPypMP293wj9d+jqYtHEDCAkU+KBaXPIEoLq40GhtBr7/NIPZ+ey//Hw/NdTmO8w7Si4Qg1M8neHQ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957645; c=relaxed/simple;
	bh=0zVU35+L6hsN/6lJdWr2+8u25qKrYPs7SL/3PzQUMSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVUhjprKb5KdqML1spePc7w9xzhNGfAA6SFN2ktna62G13lZhQxFeYeulTzdw4ayYp5f2ZCzTHmSI6fQsjBzfd9tcDGRRSIbzUgH6nuRAhYiX1jlbUkK8mL8deUece7FtZnoXCY9AIaQwLx2BtsYJxNTNtNJDJwjPGNg18P/hnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KOnT/a7F; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e23ee3110fso14918437b3.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 05:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727957642; x=1728562442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FIXnS1WeyfZA/K4XTE36vkuxtuByaCjsS7DMYGNgxN0=;
        b=KOnT/a7FLP/wz47onPMRgRsATpLpEHe2Ha+jucnv3xv0okpqoz9xJ85iRqYKtKVe/Z
         3TrzutqwfETg0ooRZ+Fb5+mlY1VeVCjFm6hhXZrkeM/KWY2RoPDlxtFNDCVOe7UgdeHg
         yvABliqc5lt9xksUMwzkfnvtMwbzwvUvm8RUmsVD9nk173KYk4I4a8RkmQIpGJwei7h2
         bruQBNioFawDDPe8m97N453mYgxkD2hbnaxGGz/p4XcINoUoPI73xCCIDyLg2bVZT+om
         iSwkCBZg42bHWIOjnckimYuaRfs/qD2nHBuwzQrSUfmnIzG26WhkX6SuSguwQoPwbnLv
         hFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727957642; x=1728562442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIXnS1WeyfZA/K4XTE36vkuxtuByaCjsS7DMYGNgxN0=;
        b=lM+DZAgoUa9KmDDejm7xbJq9Uk+SI+FQ8R8VUtH0YHUBj1Ch1v7z1p5uvQ5mxjPB8Y
         /vSHKyRSCiIbvdaOuwU15B+Hs2ew7CT2k7lHTTOROtzVCOo5ZdazIxuQKw1yKdOnghbL
         FAbgfBWkxPog2Baj3TNJ5Z6ddc326LAhkqnQZ2uNwvWTfqFPsFboKp0Nw0fiXitWfuCL
         sy6Ec8+N2G+IDWHXJO/rswp/Rckgyjl3M9ygWOe1O7CmA9fTb7XzbR2/J2hBACTWZC+a
         38N9PqjHQsry30bdCYqe7B48sJztfjhZJbZIrnh0CsTlHRchHwGfKAq9+JRRmXqfIT0W
         BKOQ==
X-Gm-Message-State: AOJu0Yz80yPmd9gZZ5rv+38+7S/c0XARBnLilV/NvbF2GlDp6lLl7hB5
	WkRlwBwYKgx5lY2JVY4KtPVSwLloMRDuKDkHH0F+sKefeMTcHbd0G7A43qslJMSmGsCgUKYEITJ
	M+pmIFUc03Q==
X-Google-Smtp-Source: AGHT+IEZSiICP+2MiQHoCOj7oh+RLp9EsZe0T4q2J4gx63nWBVck8GWpg58quqBUD4jtLmswzfOwEiU5UZN0qg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:aab4:0:b0:e25:e2d4:48d9 with SMTP id
 3f1490d57ef6-e263844488amr4057276.10.1727957642672; Thu, 03 Oct 2024 05:14:02
 -0700 (PDT)
Date: Thu,  3 Oct 2024 12:12:18 +0000
In-Reply-To: <20241003121219.2396589-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003121219.2396589-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003121219.2396589-2-edumazet@google.com>
Subject: [PATCH v3 net-next 1/2] net: add IFLA_MAX_PACING_OFFLOAD_HORIZON
 device attribute
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jeffrey Ji <jeffreyji@google.com>, 
	Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some network devices have the ability to offload EDT (Earliest
Departure Time) which is the model used for TCP pacing and FQ
packet scheduler.

Some of them implement the timing wheel mechanism described in
https://saeed.github.io/files/carousel-sigcomm17.pdf
with an associated 'timing wheel horizon'.

This patch adds dev->max_pacing_offload_horizon expressing
this timing wheel horizon in nsec units.

This is a read-only attribute.

Unless a driver sets it, dev->max_pacing_offload_horizon
is zero.

v2: addressed Jakub feedback ( https://lore.kernel.org/netdev/20240930152304.472767-2-edumazet@google.com/T/#mf6294d714c41cc459962154cc2580ce3c9693663 )
v3: added yaml doc (also per Jakub feedback)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/netlink/specs/rt_link.yaml               | 4 ++++
 Documentation/networking/net_cachelines/net_device.rst | 1 +
 include/linux/netdevice.h                              | 4 ++++
 include/uapi/linux/if_link.h                           | 1 +
 net/core/rtnetlink.c                                   | 4 ++++
 tools/include/uapi/linux/if_link.h                     | 1 +
 6 files changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 0c4d5d40cae905b370eb27437e2d311abba42c11..d7131a1afadf89c97c7abfe2b3b9534874ef1692 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1137,6 +1137,10 @@ attribute-sets:
         name: dpll-pin
         type: nest
         nested-attributes: link-dpll-pin-attrs
+      -
+        name: max-pacing-offload-horizon
+        type: uint
+        doc: EDT offload horizon supported by the device (in nsec).
   -
     name: af-spec-attrs
     attributes:
diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 22b07c814f4a4575d255fdf472d07c549536e543..49f03cb78c6e25109af969654c86ebeb19d38e12 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -183,3 +183,4 @@ struct_devlink_port*                devlink_port
 struct_dpll_pin*                    dpll_pin                                                        
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
+u64                                 max_pacing_offload_horizon
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e87b5e4883259a0723278ae3f1bee87e940af895..9eb5d9c63630e9a29a8ce2f8bc8042a520ed8398 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2009,6 +2009,8 @@ enum netdev_reg_state {
  *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
  *		   where the clock is recovered.
  *
+ *	@max_pacing_offload_horizon: max EDT offload horizon in nsec.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2399,6 +2401,8 @@ struct net_device {
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
 
+	u64			max_pacing_offload_horizon;
+
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 6dc258993b177093a77317ee5f2deab97fb04674..506ba9c80e83a5039f003c9def8b4fce41f43847 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -377,6 +377,7 @@ enum {
 	IFLA_GSO_IPV4_MAX_SIZE,
 	IFLA_GRO_IPV4_MAX_SIZE,
 	IFLA_DPLL_PIN,
+	IFLA_MAX_PACING_OFFLOAD_HORIZON,
 	__IFLA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f0a52098708584aa27461b7ee941fa324adcaf20..682d8d3127db1d11a3f04c4526119d08349e2bd6 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1118,6 +1118,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_PERM_ADDRESS */
 	       + rtnl_devlink_port_size(dev)
 	       + rtnl_dpll_pin_size(dev)
+	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
 	       + 0;
 }
 
@@ -1867,6 +1868,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 			READ_ONCE(dev->tso_max_size)) ||
 	    nla_put_u32(skb, IFLA_TSO_MAX_SEGS,
 			READ_ONCE(dev->tso_max_segs)) ||
+	    nla_put_uint(skb, IFLA_MAX_PACING_OFFLOAD_HORIZON,
+			 READ_ONCE(dev->max_pacing_offload_horizon)) ||
 #ifdef CONFIG_RPS
 	    nla_put_u32(skb, IFLA_NUM_RX_QUEUES,
 			READ_ONCE(dev->num_rx_queues)) ||
@@ -1975,6 +1978,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 }
 
 static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
+	[IFLA_UNSPEC]		= { .strict_start_type = IFLA_DPLL_PIN },
 	[IFLA_IFNAME]		= { .type = NLA_STRING, .len = IFNAMSIZ-1 },
 	[IFLA_ADDRESS]		= { .type = NLA_BINARY, .len = MAX_ADDR_LEN },
 	[IFLA_BROADCAST]	= { .type = NLA_BINARY, .len = MAX_ADDR_LEN },
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index f0d71b2a3f1e1a3d0945bc3a0efe31cd95940f72..96ec2b01e725b304874816af171d2455bc7b495c 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -377,6 +377,7 @@ enum {
 	IFLA_GSO_IPV4_MAX_SIZE,
 	IFLA_GRO_IPV4_MAX_SIZE,
 	IFLA_DPLL_PIN,
+	IFLA_MAX_PACING_OFFLOAD_HORIZON,
 	__IFLA_MAX
 };
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


