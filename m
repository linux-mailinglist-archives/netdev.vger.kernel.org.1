Return-Path: <netdev+bounces-74379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A9786116E
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C071C21734
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDAA7C6D4;
	Fri, 23 Feb 2024 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZrfjmJng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E27BAFF
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691113; cv=none; b=av+e3NmR7RadHh+JuLKnOe57ZtoKjP/uGveI9lpYyBOpd7jTKsmLtoqzXNGNFK6fb+3QIwbmJEpcrc9vP6dw4Zhm+k7ERVCXfC/sJYBb2zrUfu6Nw2dyAuk5RwQP4R5tXm98SmDptRFOcV91l0hwvWTelCq/aKj628+VAYpQdEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691113; c=relaxed/simple;
	bh=mTpyNNoXxczar/J5X5yS3GrrWg6KCVTf7Epoc8WA4Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNavbS8XIbRDDT5YaJrXoKjhtPmvXNeV7AX24Laa7f7zxa5/oLXPYv5vrZ0bSW9IbN6o5BTV4Bhd5aMLyZ7Y6Hf4Q5HUwmGwDEK/1rULaQxZEUq9mKXb0bFB2diN6pb5hrvkmScjt3I4ZGQhz/kUCtBN44bYfO3jMPPqQeYnCPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZrfjmJng; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so3487961fa.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 04:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708691110; x=1709295910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uNVvxwMRdnprK1R5WBlYd8Uq0OHLSpzuvshKSMx+8xY=;
        b=ZrfjmJng8DutPiXVwvtbmMJlzv4tLA9j0KDtUs/6rvG8Vw2/pMX/4KWAoqY7K2vjic
         DnDSBzHnXlc4RH9a2uHFwYrF+yTtbSQn1eU4f1LhE3lIprjwHdxhJwwCcTl7mDDCPnkf
         nbvg28UK3+Xx71daO4W3MMLVTUhgnkes1O5qt/nw3HUtfrd/WFRiKezmUEgHezAs8jng
         +w0v6I+zwHMLRBdEbLtVdelDzBKICAPfbcxoxmQtwOWoqd1Qd6seEnyOiGhgoL8V9VcG
         PEKfz+FaCJZufmOWZRaaBsk26XVbVWSGDrYtBaskTK334bJdqphDVzrV25rZdwbrjE69
         9A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708691110; x=1709295910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNVvxwMRdnprK1R5WBlYd8Uq0OHLSpzuvshKSMx+8xY=;
        b=oV+d+RtcVW/Nl243MkG9jBRNtdYE7SigpRZ1v9WyapHcFe4TQ+IhSAB+iCcuIWDfVk
         T493e6ihK3QWto4XWSrYrnxEfCQi3fyYiUj9bco4gjsYk1+aRHCyqBbhzksK/M+KysOE
         cjgVYIxKb5HXYNAinQ25Jp3fjjy478qLqdQcpjCNWV98ldend00t1W052cFYsV2xbJQ8
         4rWHHQ7YoP3VTG3byoNiHY+rq+bk9wiMm0Vho8YElvIygptfBpocEpjtS/SN+puwFccZ
         LgLRLw1pMjK6OJGassmz7Ik+Q+/F5rbC8zhCbi6abyS+UG4D7+95TuvhgHQEq6VdLnUZ
         JsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtxwKGUgIyfBUBXjF6bU/H2YGiSttmvJ5U6/ioDAh6dfPl6JXBuCmkbvBAqdsa0WTwNiJieBMMyPY32zmzZr7nJ66JFuSu
X-Gm-Message-State: AOJu0YxQjL8ohsUAVvjvz4y0nY6EvNcqdZV/YyP3y7Y9rc23INpRFM7w
	S9j6VvdHDHcGbBJAtSf0eqApFd7HldGMeJt7COaOIk7ix0km6OepW/QlfxuvTAA=
X-Google-Smtp-Source: AGHT+IHidiJM9Ow2hscOVb14EteftYW84cDvlCxRc5FdtlJr37RFZajjJjspkVZTF26L0cSAUuB2Qg==
X-Received: by 2002:a2e:2281:0:b0:2d2:6ed8:9f72 with SMTP id i123-20020a2e2281000000b002d26ed89f72mr1147873lji.0.1708691109576;
        Fri, 23 Feb 2024 04:25:09 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id a17-20020adffad1000000b0033cf60e268fsm2572296wrs.116.2024.02.23.04.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:25:08 -0800 (PST)
Date: Fri, 23 Feb 2024 13:25:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net] dpll: rely on rcu for netdev_dpll_pin()
Message-ID: <ZdiOo6sIzQ5p0l_v@nanopsycho>
References: <20240222164851.2534749-1-edumazet@google.com>
 <ZdhemRFgWb7WldEM@nanopsycho>
 <CANn89iJaykUZ0iOCB+-6CzFk0fNHpHUjLLOUx6sgQkLj7=NZLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJaykUZ0iOCB+-6CzFk0fNHpHUjLLOUx6sgQkLj7=NZLQ@mail.gmail.com>

Fri, Feb 23, 2024 at 12:51:43PM CET, edumazet@google.com wrote:
>On Fri, Feb 23, 2024 at 10:00 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Feb 22, 2024 at 05:48:51PM CET, edumazet@google.com wrote:
>> >This fixes a possible UAF in if_nlmsg_size(),
>> >which can run without RTNL.
>> >
>> >Add rcu protection to "struct dpll_pin"
>> >
>> >Note: This looks possible to no longer acquire RTNL in
>> >netdev_dpll_pin_assign().
>>
>> Yeah, looks like no longer needed. Will you do a follow-up for net-next
>> once this is applied to -net?
>
>Absolutely, this came while I was working on my RTNL->RCU conversion
>of "ip l" in net-next.
>
>
>
>>
>>
>> >
>> >Fixes: 5f1842692880 ("netdev: expose DPLL pin handle for netdevice")
>> >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >Cc: Jiri Pirko <jiri@nvidia.com>
>> >Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>> >Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> >---
>> > drivers/dpll/dpll_core.c  |  2 +-
>> > drivers/dpll/dpll_core.h  |  2 ++
>> > include/linux/dpll.h      | 11 +++++++++++
>> > include/linux/netdevice.h | 11 +----------
>> > net/core/dev.c            |  2 +-
>> > net/core/rtnetlink.c      |  2 ++
>> > 6 files changed, 18 insertions(+), 12 deletions(-)
>> >
>> >diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>> >index 5152bd1b0daf599869195e81805fbb2709dbe6b4..4c2bb27c99fe4e517b0d92c4ae3db83a679c7d11 100644
>> >--- a/drivers/dpll/dpll_core.c
>> >+++ b/drivers/dpll/dpll_core.c
>> >@@ -564,7 +564,7 @@ void dpll_pin_put(struct dpll_pin *pin)
>> >               xa_destroy(&pin->parent_refs);
>> >               xa_erase(&dpll_pin_xa, pin->id);
>> >               dpll_pin_prop_free(&pin->prop);
>> >-              kfree(pin);
>> >+              kfree_rcu(pin, rcu);
>> >       }
>> >       mutex_unlock(&dpll_lock);
>> > }
>> >diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>> >index 717f715015c742238d5585fddc5cd267fbb0db9f..2b6d8ef1cdf36cff24328e497c49d667659dd0e6 100644
>> >--- a/drivers/dpll/dpll_core.h
>> >+++ b/drivers/dpll/dpll_core.h
>> >@@ -47,6 +47,7 @@ struct dpll_device {
>> >  * @prop:             pin properties copied from the registerer
>> >  * @rclk_dev_name:    holds name of device when pin can recover clock from it
>> >  * @refcount:         refcount
>> >+ * @rcu:              rcu_head for kfree_rcu()
>> >  **/
>> > struct dpll_pin {
>> >       u32 id;
>> >@@ -57,6 +58,7 @@ struct dpll_pin {
>> >       struct xarray parent_refs;
>> >       struct dpll_pin_properties prop;
>> >       refcount_t refcount;
>> >+      struct rcu_head rcu;
>> > };
>> >
>> > /**
>> >diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>> >index 9cf896ea1d4122f3bc7094e46a5af81b999937dc..4ec2fe9caf5a3f284afd0cfe4fc7c2bf42cbbc60 100644
>> >--- a/include/linux/dpll.h
>> >+++ b/include/linux/dpll.h
>> >@@ -10,6 +10,8 @@
>> > #include <uapi/linux/dpll.h>
>> > #include <linux/device.h>
>> > #include <linux/netlink.h>
>> >+#include <linux/netdevice.h>
>> >+#include <linux/rtnetlink.h>
>> >
>> > struct dpll_device;
>> > struct dpll_pin;
>> >@@ -167,4 +169,13 @@ int dpll_device_change_ntf(struct dpll_device *dpll);
>> >
>> > int dpll_pin_change_ntf(struct dpll_pin *pin);
>> >
>> >+static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
>> >+{
>> >+#if IS_ENABLED(CONFIG_DPLL)
>> >+      return rcu_dereference_rtnl(dev->dpll_pin);
>> >+#else
>> >+      return NULL;
>> >+#endif
>>
>> Why you moved netdev_dpll_pin() here?
>
>Because of the rcu_dereference_rtnl() call, not available to
>include/linux/netdevice.h
>
>Adding the missing include would have been more painful.
>include/linux/netdevice.h being included everywhere and being bloated already,
>I think moving netdev_dpll_pin() helper in  dpll.h is better (should
>not increase compile time for the kernel)

Fair enough.


>
>>
>>
>> >+}
>> >+
>> > #endif
>> >diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> >index ef7bfbb9849733fa7f1f097ba53a36a68cc3384b..a9c973b92294bb110cf3cd336485972127b01b58 100644
>> >--- a/include/linux/netdevice.h
>> >+++ b/include/linux/netdevice.h
>> >@@ -2469,7 +2469,7 @@ struct net_device {
>> >       struct devlink_port     *devlink_port;
>> >
>> > #if IS_ENABLED(CONFIG_DPLL)
>> >-      struct dpll_pin         *dpll_pin;
>> >+      struct dpll_pin __rcu   *dpll_pin;
>> > #endif
>> > #if IS_ENABLED(CONFIG_PAGE_POOL)
>> >       /** @page_pools: page pools created for this netdevice */
>> >@@ -4035,15 +4035,6 @@ bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);
>> > void netdev_dpll_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin);
>> > void netdev_dpll_pin_clear(struct net_device *dev);
>> >
>> >-static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
>> >-{
>> >-#if IS_ENABLED(CONFIG_DPLL)
>> >-      return dev->dpll_pin;
>> >-#else
>> >-      return NULL;
>> >-#endif
>> >-}
>> >-
>> > struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again);
>> > struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
>> >                                   struct netdev_queue *txq, int *ret);
>> >diff --git a/net/core/dev.c b/net/core/dev.c
>> >index 73a0219730075e666c4f11f668a50dbf9f9afa97..0230391c78f71e22d3c0e925ff8d3d792aa54a32 100644
>> >--- a/net/core/dev.c
>> >+++ b/net/core/dev.c
>> >@@ -9078,7 +9078,7 @@ static void netdev_dpll_pin_assign(struct net_device *dev, struct dpll_pin *dpll
>> > {
>> > #if IS_ENABLED(CONFIG_DPLL)
>> >       rtnl_lock();
>> >-      dev->dpll_pin = dpll_pin;
>> >+      rcu_assign_pointer(dev->dpll_pin, dpll_pin);
>> >       rtnl_unlock();
>> > #endif
>> > }
>> >diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>> >index 9c4f427f3a5057b52ec05405e8b15b8ca2246b4b..6239aa62a29cb8752a53e3f75a48a1e2fdd3b0ec 100644
>> >--- a/net/core/rtnetlink.c
>> >+++ b/net/core/rtnetlink.c
>> >@@ -1057,7 +1057,9 @@ static size_t rtnl_dpll_pin_size(const struct net_device *dev)
>> > {
>> >       size_t size = nla_total_size(0); /* nest IFLA_DPLL_PIN */
>> >
>> >+      rcu_read_lock();
>>
>> Why do you need to take the rcu read lock here? Isn't this called
>> with either rtnl held of rcu read lock held?
>>
>> And if you need to take rcu read lock here, why you use
>> rcu_dereference_rtnl() instead of rcu_dereference() in
>> netdev_dpll_pin()?
>
>This is because I discovered the issue while working on net-next tree,
>and basically had to fix the bug in net tree, I had to prune my WIP to
>get to the fix.
>
>You are right, the rcu_read_lock() is not really needed here.

Okay.


