Return-Path: <netdev+bounces-74309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99D860D69
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915E21C23A20
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE1F1AAD2;
	Fri, 23 Feb 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UBOYABlm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D551AAD0
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678821; cv=none; b=Gg0jzcNHSKAfN9XoIUzuA8H+gNL1fj7/EXITxA5dbiAToE0b9U9txpcFOfgXii+ki065TVeAFvJfoLtiLX00KjOaRWr5H0ac6KlrmhdxxcqaEiYHqzjfq8Zg3Sxf+xKQpNmmpO6MmZTQbjB/Sl3/FdaV17nYBhEzYXVlwmlgXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678821; c=relaxed/simple;
	bh=/YQJaOC8KKneZsITi4EqWJMMils7Y9fUUMhdIWy175Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suZP8Rlz/5c5QQcFeYN3a9YFaEOZcL1zjI5+5PlVZpLiitQcZnS/r//quxvQJQkePHq9D6dMbU0d29u3Qr5MGYY9j+pxB1VfVDmdStAUPlUNAG269uD1XzJ7V74Lawl7aJFpsKwQtYXVIm8iMzZe7TSx3s93M7htqWPOwNDzuXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UBOYABlm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41294136c27so1693025e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 01:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708678813; x=1709283613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vwho6sYbuHMCv8+nnj2kvEHbPveN7/84Xj3XB5WocPw=;
        b=UBOYABlmhc03nDhvKDtr0WAZtZGpcpFbRyW9u3z1fCKjK/YCAxl0cwCQXt7vl1UNsN
         S1lle2T8EgdPHfck/FxSfOqs9jklsx26MHk4fV3UoJ+MV+L2vgolyUSxSyYbuvHLdjXm
         +ajzotoWrgzoE/QihmsyMgOSJ5xSQRrxKywjNDWe6kW08IiLVjniebW/C8tH/Zb51NL3
         RqzQLJcpM/RafCXcOwy/fEX6IFhJOJvGB282BhPaH82w98uWDK9Ui5M8QXTnqTK7rTj7
         ti5aEJb2cax4jraNOc6FikECVmhDEG+O/21VLFFgKhmftsRKm11HBZrXTnu/WWVdy4SY
         wB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708678813; x=1709283613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vwho6sYbuHMCv8+nnj2kvEHbPveN7/84Xj3XB5WocPw=;
        b=gpbhj5YjEkrecfi2Glw8auLzvEuDy6edjnjioh82y4duHLcFQQ8JxU9tHvwJgpytP4
         WIo2xCI2YOZBuWyuQA3byuM9W5KGsLVhiTbi/2ITqpVwxKV/G3ZOKbwGoSqKyWaC3ACk
         aIVox4+jcCAr9r02f7VPvM4DK7ALCE1crjTLSMygHFDdYbvgN+RVwyek5bnafFy+NUt5
         0KZ1rpLmM8cCprWc0Ud3ggqhmJHPLsEu7OeczlRZ5yIO/fiVqvMWMkSpOl7iR9mkbA2w
         nTzZ08RTIEhJsrkl9hq2RkW0KpeAepPVeXfNurogfI+9TeTKFYmzzZIQTHcXpvmhQ9Qa
         LipQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGVNiEemvHVnsF18V9QI+nHTxR+c7uX+qPmoSOPTzf9gEXRw4hnPGNp92YO7mjTMDbRGi1vuarSI6FHTuqXp114PaTUuCQ
X-Gm-Message-State: AOJu0YwyDHXEh9eaxszuaf5GVPLOw1BvpFNYf8VXmAA8jMVf4Qn5LzQV
	kLppCFYqwS/CStitsn5uX7rbhz14h5deOqifNn0lRvys512R2T7dx8+5bjIYxTI=
X-Google-Smtp-Source: AGHT+IF3xOjCSCtZGfcxKWQhLgwyvOhCkUsX7sey7EWpxnHrrJj5rIzkRQ3siHeUR7E65GKBcX8coQ==
X-Received: by 2002:a05:600c:46d0:b0:412:9017:c716 with SMTP id q16-20020a05600c46d000b004129017c716mr707934wmo.17.1708678812760;
        Fri, 23 Feb 2024 01:00:12 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b004128812dcb6sm1582580wmo.28.2024.02.23.01.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:00:12 -0800 (PST)
Date: Fri, 23 Feb 2024 10:00:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net] dpll: rely on rcu for netdev_dpll_pin()
Message-ID: <ZdhemRFgWb7WldEM@nanopsycho>
References: <20240222164851.2534749-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222164851.2534749-1-edumazet@google.com>

Thu, Feb 22, 2024 at 05:48:51PM CET, edumazet@google.com wrote:
>This fixes a possible UAF in if_nlmsg_size(),
>which can run without RTNL.
>
>Add rcu protection to "struct dpll_pin"
>
>Note: This looks possible to no longer acquire RTNL in
>netdev_dpll_pin_assign().

Yeah, looks like no longer needed. Will you do a follow-up for net-next
once this is applied to -net?


>
>Fixes: 5f1842692880 ("netdev: expose DPLL pin handle for netdevice")
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Jiri Pirko <jiri@nvidia.com>
>Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>---
> drivers/dpll/dpll_core.c  |  2 +-
> drivers/dpll/dpll_core.h  |  2 ++
> include/linux/dpll.h      | 11 +++++++++++
> include/linux/netdevice.h | 11 +----------
> net/core/dev.c            |  2 +-
> net/core/rtnetlink.c      |  2 ++
> 6 files changed, 18 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 5152bd1b0daf599869195e81805fbb2709dbe6b4..4c2bb27c99fe4e517b0d92c4ae3db83a679c7d11 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -564,7 +564,7 @@ void dpll_pin_put(struct dpll_pin *pin)
> 		xa_destroy(&pin->parent_refs);
> 		xa_erase(&dpll_pin_xa, pin->id);
> 		dpll_pin_prop_free(&pin->prop);
>-		kfree(pin);
>+		kfree_rcu(pin, rcu);
> 	}
> 	mutex_unlock(&dpll_lock);
> }
>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>index 717f715015c742238d5585fddc5cd267fbb0db9f..2b6d8ef1cdf36cff24328e497c49d667659dd0e6 100644
>--- a/drivers/dpll/dpll_core.h
>+++ b/drivers/dpll/dpll_core.h
>@@ -47,6 +47,7 @@ struct dpll_device {
>  * @prop:		pin properties copied from the registerer
>  * @rclk_dev_name:	holds name of device when pin can recover clock from it
>  * @refcount:		refcount
>+ * @rcu:		rcu_head for kfree_rcu()
>  **/
> struct dpll_pin {
> 	u32 id;
>@@ -57,6 +58,7 @@ struct dpll_pin {
> 	struct xarray parent_refs;
> 	struct dpll_pin_properties prop;
> 	refcount_t refcount;
>+	struct rcu_head rcu;
> };
> 
> /**
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index 9cf896ea1d4122f3bc7094e46a5af81b999937dc..4ec2fe9caf5a3f284afd0cfe4fc7c2bf42cbbc60 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -10,6 +10,8 @@
> #include <uapi/linux/dpll.h>
> #include <linux/device.h>
> #include <linux/netlink.h>
>+#include <linux/netdevice.h>
>+#include <linux/rtnetlink.h>
> 
> struct dpll_device;
> struct dpll_pin;
>@@ -167,4 +169,13 @@ int dpll_device_change_ntf(struct dpll_device *dpll);
> 
> int dpll_pin_change_ntf(struct dpll_pin *pin);
> 
>+static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
>+{
>+#if IS_ENABLED(CONFIG_DPLL)
>+	return rcu_dereference_rtnl(dev->dpll_pin);
>+#else
>+	return NULL;
>+#endif

Why you moved netdev_dpll_pin() here?


>+}
>+
> #endif
>diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>index ef7bfbb9849733fa7f1f097ba53a36a68cc3384b..a9c973b92294bb110cf3cd336485972127b01b58 100644
>--- a/include/linux/netdevice.h
>+++ b/include/linux/netdevice.h
>@@ -2469,7 +2469,7 @@ struct net_device {
> 	struct devlink_port	*devlink_port;
> 
> #if IS_ENABLED(CONFIG_DPLL)
>-	struct dpll_pin		*dpll_pin;
>+	struct dpll_pin	__rcu	*dpll_pin;
> #endif
> #if IS_ENABLED(CONFIG_PAGE_POOL)
> 	/** @page_pools: page pools created for this netdevice */
>@@ -4035,15 +4035,6 @@ bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);
> void netdev_dpll_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin);
> void netdev_dpll_pin_clear(struct net_device *dev);
> 
>-static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
>-{
>-#if IS_ENABLED(CONFIG_DPLL)
>-	return dev->dpll_pin;
>-#else
>-	return NULL;
>-#endif
>-}
>-
> struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again);
> struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
> 				    struct netdev_queue *txq, int *ret);
>diff --git a/net/core/dev.c b/net/core/dev.c
>index 73a0219730075e666c4f11f668a50dbf9f9afa97..0230391c78f71e22d3c0e925ff8d3d792aa54a32 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -9078,7 +9078,7 @@ static void netdev_dpll_pin_assign(struct net_device *dev, struct dpll_pin *dpll
> {
> #if IS_ENABLED(CONFIG_DPLL)
> 	rtnl_lock();
>-	dev->dpll_pin = dpll_pin;
>+	rcu_assign_pointer(dev->dpll_pin, dpll_pin);
> 	rtnl_unlock();
> #endif
> }
>diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>index 9c4f427f3a5057b52ec05405e8b15b8ca2246b4b..6239aa62a29cb8752a53e3f75a48a1e2fdd3b0ec 100644
>--- a/net/core/rtnetlink.c
>+++ b/net/core/rtnetlink.c
>@@ -1057,7 +1057,9 @@ static size_t rtnl_dpll_pin_size(const struct net_device *dev)
> {
> 	size_t size = nla_total_size(0); /* nest IFLA_DPLL_PIN */
> 
>+	rcu_read_lock();

Why do you need to take the rcu read lock here? Isn't this called
with either rtnl held of rcu read lock held?

And if you need to take rcu read lock here, why you use
rcu_dereference_rtnl() instead of rcu_dereference() in
netdev_dpll_pin()?



> 	size += dpll_msg_pin_handle_size(netdev_dpll_pin(dev));
>+	rcu_read_unlock();
> 
> 	return size;
> }
>-- 
>2.44.0.rc1.240.g4c46232300-goog
>
>

