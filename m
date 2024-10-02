Return-Path: <netdev+bounces-131258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4A798DE85
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8251F21E24
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB261D096A;
	Wed,  2 Oct 2024 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgYfayaw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF261D07BF
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881946; cv=none; b=Xpq3oUIih74k1xDGMIIjHD9kufb1uEfyQ5z8l0nPnRljAD73HD7L0bP9sh2e1pY1/mYMXQ3HJna5LkY2l+Fev0o6D3/Bw8WYntvE+F71YMGeWqb38Bn3+snT3ajJlMnmsieUAJ5/iZVixeBKufsjsq2MgGK1kyLVGWiOY6QzkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881946; c=relaxed/simple;
	bh=S02fnBp2QC8x2lP2HKUSjRaV/xMbzvpWCIa5XOjH0HQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DcXMLqLGD7MfKpVu55yMlE2mGL38zzMbIM0mU4O4REe6my0F4L1Z6ts2gHkAVZtFEVv1sPumI0YlcaR6i/JAX8oEMoDPE7q6kIOEjtY5an5k2i0AUlb7I2BEraq0jRZDHhycizVCfxjgWRHftiLTR+vvKIMk3wxeArrcYVMSYzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgYfayaw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28694ff555so804272276.2
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727881943; x=1728486743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5OHplBJymcQiJsKljbqkoP5MLiZp3oI1C7UhXAYYc0=;
        b=kgYfayawIyQfqk9Wz9/Xl8s6Z+tzk4rUh1iJh7xAZG0RCKWbkjQ7TpWyYPlGaUhw+e
         Z285pu/vzwS2ml/lXgDm5EY3TLREeAo9MXupHm99N6otGj6LAlzwJ9YVypR4RsD/LB+I
         93mIDDCLsULQdXMzKHqPs5MODnvm5UXbX31c0y/hpo+0D87/oVMRn/65vFVpC4M/8Ga7
         EYmC8CmfAjUY73pozCd4lZjqpyli8f4g8UlTyzcYevxsNPdp4pJ7jO6edsyLwZ4AfqzL
         qNMC1zQbcf04xKeq/tQLhc8E8xie1THdZQJBfeK5qdR30B16SxaxeEcy6R1GPoQUnqAz
         K6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881943; x=1728486743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5OHplBJymcQiJsKljbqkoP5MLiZp3oI1C7UhXAYYc0=;
        b=DifUhxvKaWHVU7xcVv4YS6mJV4VPVDetXsrTD6i1qmFJ8dOisKplvKH3NEFncIwU5O
         a824G1AHY7r6DvhWycADtUDag+fYoLwaDyIATJtGh1E8P9k3sKaNfHfRvH5F/k5Kh2+V
         tkejQYrqI1wyMMmIhxhU4C992Mw/PWLEbuFHEOeienTcwPkBFPh437C3m+GUxzjKkwAy
         ng7zkuQzjebIDLMNwxHZdpWEd9V/v01UxqNcEMAqDErAsVz0lodHE8bzx9xwnEpJN0FM
         +FXVVrO1OAgesv7UOgldiwtN7qq79u/w+PnAw67yovnBcRMCo57Di5FznfxlhyTbY/mI
         Zl6A==
X-Forwarded-Encrypted: i=1; AJvYcCXG2KddYJwU61GBmn1bTcs4ik5b/LofQIood8P3SBoEwUxckhxehU7vB+biKfA9axks3XTYfpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiXxVB0a2UZSIiyTg9Vf4b6v8GZueB0UjrkFMqchmCDq2bNSNM
	rqD319jGhBUyjwT2s7Qe5Dhf4dCgNr6jVwZdC3rv1sYsqqSyC7jiqYxA3Z7sHHIe/aQBXA4QeOB
	FY5cbsAOYdA==
X-Google-Smtp-Source: AGHT+IF42wd8QRhwHUUTmnO6SqsRllfqId2XVTOa8ZELOAEm9zAq3XDp8BKPsRU+txvnUGiPko0pEXRtDlqHVA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:910:0:b0:e1c:ed3d:7bb7 with SMTP id
 3f1490d57ef6-e263837e6camr2483276.1.1727881943060; Wed, 02 Oct 2024 08:12:23
 -0700 (PDT)
Date: Wed,  2 Oct 2024 15:12:18 +0000
In-Reply-To: <20241002151220.349571-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002151220.349571-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241002151220.349571-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/2] net: add IFLA_MAX_PACING_OFFLOAD_HORIZON
 device attribute
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

v2: addressed Jakub feedback
( https://lore.kernel.org/netdev/20240930152304.472767-2-edumazet@google.com/T/#mf6294d714c41cc459962154cc2580ce3c9693663 )

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/networking/net_cachelines/net_device.rst | 1 +
 include/linux/netdevice.h                              | 4 ++++
 include/uapi/linux/if_link.h                           | 1 +
 net/core/rtnetlink.c                                   | 4 ++++
 tools/include/uapi/linux/if_link.h                     | 1 +
 5 files changed, 11 insertions(+)

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
2.46.1.824.gd892dcdcdd-goog


