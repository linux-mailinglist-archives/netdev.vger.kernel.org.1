Return-Path: <netdev+bounces-130440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269C798A863
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D429A283A7D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9971925A6;
	Mon, 30 Sep 2024 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fxno63GE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0875F18FDDA
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709790; cv=none; b=j/7xfbFrIqLh/3JTFWdjj+oOj7lEyj/OI1PJDzIeV8T4GgjO2qoBAhejZSNAZo/ceXA0nIZGMMSjnkZeRzpp5bNufi01RozEfv5vIRzHKt+4cLASL2FOr/1JYr1oqJLUVs+VBTQhRh9EbqGCBbsdsMknnxytQRcnCsseC/EjW+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709790; c=relaxed/simple;
	bh=ceHjmvBFYX89PThdapZEWhyHk8F8GeI1bly9y6VqVmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CLC+mhsxVMfDmr9/xz5AcIX/HHRfcbmdZFNkDl9WcK8gxE3hXwgq2h7wkYyAX3KzAu8VpOUqDEAJlgfrEot5utVifloicLBoM/x/Z/FeG1pJ9jAYQB4VMEzfeEZhb2B3xyaJZi+oqkCJUMzUabRFtdXoDHNOYRKfo/1vpsc0480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fxno63GE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso6182334276.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727709788; x=1728314588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ7hVLv1ieJfGJF2jSeHIxyK1IHHOG3eDGgYt7uFwgk=;
        b=fxno63GEdKgwDH3EF4TU5OL/SBcJidzvxY4HWOTO3zCzoGTugSLNKg75sflFN+7zI0
         dgnfuFz5C+l1tSeKaDkLTjTf32CRPJc7O6ZQKe0F0OjqK49ZwdkeQ8AsxLgNIGjdB2sF
         OhBFHXhKEOnob21kWMgbv40WzjXfD2vIgurajr6ZT6POz5HlmzsmWaF5oDCq7hTIcBzc
         rVOlFVwM8hVpCqP4ueECnm//EFCfFH5LDm3hOLyW0I0FSpvZJE8MsTFLDm5SNp0+xKei
         ZduQGxU+/LiDws0atE3Il2Nz63cKj4dxCt/csX7dz2ByHzdsPl0yRaz7HGEQxGhFo7Za
         IGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727709788; x=1728314588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ7hVLv1ieJfGJF2jSeHIxyK1IHHOG3eDGgYt7uFwgk=;
        b=kSS/1XBwKOpCg3r15ParZoys8EuUaSHTFLH7hvZv0z5tDpKp+p2HnFHfWHGjAzX9BC
         d/+nLCBtkDtZeVo6uiZ70gmp/R4O828bsYFlYoMMDrnCRB1VE5Yws72mXD0VxZdm2vdA
         2BhIcgBRHVPd4NDj4ejH+EHJh/eDYGECyObmGy3DpLZ9i3CsiNBXZkuaWX2esFalbVPi
         0SFvePm6mn7ft3twW5o8NLryiHTepka5UJv7PngtlgZsGFyUKT1Hp0WfdnDqFt1YmZdw
         PDXvBAK2RmbVLB6rF8AW7ug94NPeCj0Keak3ZLEMHKH6nsq9Mt+EGDrsAEwUkF0oe+9w
         F/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWY8HGNjdT+maFBBVApQl06UdFG78b3wGhLiK+X7ZmKFKuPIDMQn4pG2/MQm4E9+tH9ZPghDtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqpMX6a3UIMwpRMaQGi/gKTuAJoTdHrzAcn64fle2Gq2kcM2Y+
	4VrmoIhMpsHQfS6Rn/L2qIPKFdUzcNOEhwMrAnZnwwqU83+Dgg9MX0KISi2Q1FS7nLoY32zV9qK
	sbvK8NwAxSw==
X-Google-Smtp-Source: AGHT+IFLkSdMWCKCC9xlKs5dD8qTaO1pme3o83PWZ6abryYIZUnVkgFsp+NYxruXpkLXhhGgLdUhs7EMzOUfcQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1343:b0:e25:17cb:352e with SMTP
 id 3f1490d57ef6-e2604b7f6b9mr9698276.9.1727709787963; Mon, 30 Sep 2024
 08:23:07 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:23:03 +0000
In-Reply-To: <20240930152304.472767-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240930152304.472767-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240930152304.472767-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] net: add IFLA_MAX_PACING_OFFLOAD_HORIZON device attribute
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Jeffrey Ji <jeffreyji@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
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

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/net_cachelines/net_device.rst | 1 +
 include/linux/netdevice.h                              | 4 ++++
 include/uapi/linux/if_link.h                           | 1 +
 net/core/rtnetlink.c                                   | 5 +++++
 tools/include/uapi/linux/if_link.h                     | 1 +
 5 files changed, 12 insertions(+)

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
index f0a52098708584aa27461b7ee941fa324adcaf20..898a9e0061dc9dd7b8f8691b778873ec0fe0059e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1118,6 +1118,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_PERM_ADDRESS */
 	       + rtnl_devlink_port_size(dev)
 	       + rtnl_dpll_pin_size(dev)
+	       + nla_total_size_64bit(sizeof(u64))  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
 	       + 0;
 }
 
@@ -1867,6 +1868,9 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 			READ_ONCE(dev->tso_max_size)) ||
 	    nla_put_u32(skb, IFLA_TSO_MAX_SEGS,
 			READ_ONCE(dev->tso_max_segs)) ||
+	    nla_put_u64_64bit(skb, IFLA_MAX_PACING_OFFLOAD_HORIZON,
+			      READ_ONCE(dev->max_pacing_offload_horizon),
+			      IFLA_PAD) ||
 #ifdef CONFIG_RPS
 	    nla_put_u32(skb, IFLA_NUM_RX_QUEUES,
 			READ_ONCE(dev->num_rx_queues)) ||
@@ -2030,6 +2034,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
 	[IFLA_GSO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_MAX_PACING_OFFLOAD_HORIZON]= { .type = NLA_REJECT },
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
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
2.46.1.824.gd892dcdcdd-goog


