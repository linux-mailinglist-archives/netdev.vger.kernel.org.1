Return-Path: <netdev+bounces-77366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D9B871715
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 08:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FA91C20FEB
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 07:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE427E781;
	Tue,  5 Mar 2024 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CD3rfMwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6918E1D
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624354; cv=none; b=evAqiUF8G9TUtCINwTWXSrhsqn8x6aHDucbLxaRhShNcruLg9g0xmCeEMssPedDTGJF6hnHFwcxEi85NqENHqe3/uAt1uLEX3iO+PZ9q59+KeySkXDCKixLIfkJguuQxjASALH2Mtc61ObD3z7KbHv4zAjBRQwuCcVJskK7mynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624354; c=relaxed/simple;
	bh=D0wIjOpwWfKNfT/cFE+Xsqr4L0YDH8N2Hq87P0rwCy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2qiZUycmN6bos0bUNe8uFMCAhRumfiM3tFlxs+ZWuSRfIG0rgj+Xwue96LU9/iVpTsHoZbkxsv1F/E4sUVQ8x+wXevItzBFyLp4/RovYkaH74+wergLzXkFlsR9ro8WA9XJu5Oecuf2en8ZEhFSeY9lJeuCuLlpZsVlJuEjY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CD3rfMwU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso6929526a12.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 23:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709624349; x=1710229149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZuSM+Z6zWDcaex2aB6ZuBoHCo80vuYI8vI7EdcezC8=;
        b=CD3rfMwUOoxVyfi/Fe0rideQ/rSQeswL5ts8gWcPn3UQ8SmW2EqHW7E40+q9cbwodP
         9HBc2nE69t+G2KcQ4M/H0WcCW4Ai1sMeB5so5TZBQxMbgW76dESjLQRmpPJWK58banJ/
         ZVF4c3lsBRNvavgdlBedR37NhFj74oLlLyqCp+qa4DDR9dhECtFiZXmDhGbx8/xRGKiG
         sk1I79IO/dxHbQ63AA9coMMLWaLz+ArBh1gDlbBLyOcDrhfMsQP4Mwonkx6XY0PScuho
         ffCN2iIK4Q1sOw2dse0YEDEUUYm6zkKsbJdHj6/ItNGW+ke92T9gfj/oZKjCWvR5B5AK
         GKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709624349; x=1710229149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZuSM+Z6zWDcaex2aB6ZuBoHCo80vuYI8vI7EdcezC8=;
        b=bv1nLjBA1Zi4Zq5JxZ33MESFdDsSJjlMbd/Nz3hk0xQBhs8HY/tUKzSqc/bSy+3OQL
         Yt1Vezb8YmBIhZYzzP+8LC0Ctcl5n7f/sZz3Jkxb+Shv4RdYhDTGky/7P/wDM36oIET+
         COWVdcdO+VNT/q9fUFCqr6Ce2dZG7FjT4FReaSdU6OW5o9FHBqDtkSlOrtBG50DVzMGa
         au79HnY/WtTYTyKxUbQT8A8Y9I++BlXarBHAFZ+YnZl+hPk3T2aybjVrli/G3LmNkeFx
         p/QyEvKjMxJEC8PoOipkbDbM6R47WTAm4AtbSOJlVKaK6ULyhWyq0xWsq4cZnKiPOtPb
         O2hg==
X-Forwarded-Encrypted: i=1; AJvYcCWk/ixgP/yllL2orypygyzIsb2/VNDhK7tiVL0Fw6rRHqjneB8IMVMTblp5Y3t+eUsKLV6IdIIZWClLgLGpO2JUTskbO0QU
X-Gm-Message-State: AOJu0YxbPg73SmQJl4l0xE/IGSFZYfUjn64jCJFfs6NXPF5ELv7+baDl
	fRTCi3F9dbc93hkGQkq1l9o+HITjQtprkE0QuFGICrP7f3UULXfAiJvb1aIborL1XQUGM8KT+xR
	+dZA=
X-Google-Smtp-Source: AGHT+IFLYNGEL6GYlNy0SWg2ETgtgvbUjYRFOdTvTL6Y4q8oI8kt/FtZUv1X9pf0W4kCuqVhZHp0ZA==
X-Received: by 2002:a05:6402:903:b0:566:f3d:c0b6 with SMTP id g3-20020a056402090300b005660f3dc0b6mr6809089edz.8.1709624349111;
        Mon, 04 Mar 2024 23:39:09 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id g2-20020a056402114200b0056735c5e9eesm2520741edw.75.2024.03.04.23.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 23:39:08 -0800 (PST)
Date: Tue, 5 Mar 2024 08:39:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Geert Uytterhoeven <geert@linux-m68k.org>,
	vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH net v2] dpll: move all dpll<>netdev helpers to dpll code
Message-ID: <ZebMG4gDnX4Wuh-B@nanopsycho>
References: <20240305013532.694866-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305013532.694866-1-kuba@kernel.org>

Tue, Mar 05, 2024 at 02:35:32AM CET, kuba@kernel.org wrote:
>Older versions of GCC really want to know the full definition
>of the type involved in rcu_assign_pointer().
>
>struct dpll_pin is defined in a local header, net/core can't
>reach it. Move all the netdev <> dpll code into dpll, where
>the type is known. Otherwise we'd need multiple function calls
>to jump between the compilation units.
>
>This is the same problem the commit under fixes was trying to address,
>but with rcu_assign_pointer() not rcu_dereference().
>
>Some of the exports are not needed, networking core can't
>be a module, we only need exports for the helpers used by
>drivers.
>
>Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>Link: https://lore.kernel.org/all/35a869c8-52e8-177-1d4d-e57578b99b6@linux-m68k.org/
>Fixes: 640f41ed33b5 ("dpll: fix build failure due to rcu_dereference_check() on unknown type")
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>v2:
> - covering the extra cases discovered by Geert
> - re-target the whole thing at net, doing temporary fixes in net
>   and refactoring in net-next feels wrong
>v1: https://lore.kernel.org/all/20240301001607.2925706-1-kuba@kernel.org/
>
>CC: vadim.fedorenko@linux.dev
>CC: arkadiusz.kubalewski@intel.com
>CC: jiri@resnulli.us
>---
> Documentation/driver-api/dpll.rst             |  2 +-
> drivers/dpll/dpll_core.c                      | 25 +++++++++---
> drivers/dpll/dpll_netlink.c                   | 38 ++++++++++++-------
> drivers/net/ethernet/intel/ice/ice_dpll.c     |  4 +-
> .../net/ethernet/mellanox/mlx5/core/dpll.c    |  4 +-
> include/linux/dpll.h                          | 26 ++++++-------
> include/linux/netdevice.h                     |  4 --
> net/core/dev.c                                | 22 -----------
> net/core/rtnetlink.c                          |  4 +-
> 9 files changed, 64 insertions(+), 65 deletions(-)
>
>diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
>index e3d593841aa7..ea8d16600e16 100644
>--- a/Documentation/driver-api/dpll.rst
>+++ b/Documentation/driver-api/dpll.rst
>@@ -545,7 +545,7 @@ In such scenario, dpll device input signal shall be also configurable
> to drive dpll with signal recovered from the PHY netdevice.
> This is done by exposing a pin to the netdevice - attaching pin to the
> netdevice itself with
>-``netdev_dpll_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin)``.
>+``dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin)``.
> Exposed pin id handle ``DPLL_A_PIN_ID`` is then identifiable by the user
> as it is attached to rtnetlink respond to get ``RTM_NEWLINK`` command in
> nested attribute ``IFLA_DPLL_PIN``.
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 241db366b2c7..7f686d179fc9 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -42,11 +42,6 @@ struct dpll_pin_registration {
> 	void *priv;
> };
> 
>-struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
>-{
>-	return rcu_dereference_rtnl(dev->dpll_pin);
>-}
>-
> struct dpll_device *dpll_device_get_by_id(int id)
> {
> 	if (xa_get_mark(&dpll_device_xa, id, DPLL_REGISTERED))
>@@ -513,6 +508,26 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
> 	return ERR_PTR(ret);
> }
> 
>+static void dpll_netdev_pin_assign(struct net_device *dev, struct dpll_pin *dpll_pin)
>+{
>+	rtnl_lock();
>+	rcu_assign_pointer(dev->dpll_pin, dpll_pin);
>+	rtnl_unlock();
>+}
>+
>+void dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin)
>+{
>+	WARN_ON(!dpll_pin);
>+	dpll_netdev_pin_assign(dev, dpll_pin);
>+}
>+EXPORT_SYMBOL(dpll_netdev_pin_set);
>+
>+void dpll_netdev_pin_clear(struct net_device *dev)
>+{
>+	dpll_netdev_pin_assign(dev, NULL);
>+}
>+EXPORT_SYMBOL(dpll_netdev_pin_clear);
>+
> /**
>  * dpll_pin_get - find existing or create new dpll pin
>  * @clock_id: clock_id of creator
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 4ca9ad16cd95..8746828ce819 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -8,6 +8,7 @@
>  */
> #include <linux/module.h>
> #include <linux/kernel.h>
>+#include <linux/netdevice.h>
> #include <net/genetlink.h>
> #include "dpll_core.h"
> #include "dpll_netlink.h"
>@@ -47,18 +48,6 @@ dpll_msg_add_dev_parent_handle(struct sk_buff *msg, u32 id)
> 	return 0;
> }
> 
>-/**
>- * dpll_msg_pin_handle_size - get size of pin handle attribute for given pin
>- * @pin: pin pointer
>- *
>- * Return: byte size of pin handle attribute for given pin.
>- */
>-size_t dpll_msg_pin_handle_size(struct dpll_pin *pin)
>-{
>-	return pin ? nla_total_size(4) : 0; /* DPLL_A_PIN_ID */
>-}
>-EXPORT_SYMBOL_GPL(dpll_msg_pin_handle_size);
>-
> /**
>  * dpll_msg_add_pin_handle - attach pin handle attribute to a given message
>  * @msg: pointer to sk_buff message to attach a pin handle
>@@ -68,7 +57,7 @@ EXPORT_SYMBOL_GPL(dpll_msg_pin_handle_size);
>  * * 0 - success
>  * * -EMSGSIZE - no space in message to attach pin handle
>  */
>-int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
>+static int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
> {
> 	if (!pin)
> 		return 0;
>@@ -76,7 +65,28 @@ int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
> 		return -EMSGSIZE;
> 	return 0;
> }
>-EXPORT_SYMBOL_GPL(dpll_msg_add_pin_handle);
>+
>+static struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)

You may add "dpll_" prefix to this helper as well to be aligned with the
rest while you are at it. Take it or leave it.
Patch looks fine.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>



>+{
>+	return rcu_dereference_rtnl(dev->dpll_pin);
>+}
>+
>+/**
>+ * dpll_netdev_pin_handle_size - get size of pin handle attribute of a netdev
>+ * @dev: netdev from which to get the pin
>+ *
>+ * Return: byte size of pin handle attribute, or 0 if @dev has no pin.
>+ */
>+size_t dpll_netdev_pin_handle_size(const struct net_device *dev)
>+{
>+	return netdev_dpll_pin(dev) ? nla_total_size(4) : 0; /* DPLL_A_PIN_ID */
>+}
>+
>+int dpll_netdev_add_pin_handle(struct sk_buff *msg,
>+			       const struct net_device *dev)
>+{
>+	return dpll_msg_add_pin_handle(msg, netdev_dpll_pin(dev));
>+}
> 
> static int
> dpll_msg_add_mode(struct sk_buff *msg, struct dpll_device *dpll,
>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
>index adfa1f2a80a6..c59e972dbaae 100644
>--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>@@ -1597,7 +1597,7 @@ static void ice_dpll_deinit_rclk_pin(struct ice_pf *pf)
> 	}
> 	if (WARN_ON_ONCE(!vsi || !vsi->netdev))
> 		return;
>-	netdev_dpll_pin_clear(vsi->netdev);
>+	dpll_netdev_pin_clear(vsi->netdev);
> 	dpll_pin_put(rclk->pin);
> }
> 
>@@ -1641,7 +1641,7 @@ ice_dpll_init_rclk_pins(struct ice_pf *pf, struct ice_dpll_pin *pin,
> 	}
> 	if (WARN_ON((!vsi || !vsi->netdev)))
> 		return -EINVAL;
>-	netdev_dpll_pin_set(vsi->netdev, pf->dplls.rclk.pin);
>+	dpll_netdev_pin_set(vsi->netdev, pf->dplls.rclk.pin);
> 
> 	return 0;
> 
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>index 928bf24d4b12..d74a5aaf4268 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>@@ -261,7 +261,7 @@ static void mlx5_dpll_netdev_dpll_pin_set(struct mlx5_dpll *mdpll,
> {
> 	if (mdpll->tracking_netdev)
> 		return;
>-	netdev_dpll_pin_set(netdev, mdpll->dpll_pin);
>+	dpll_netdev_pin_set(netdev, mdpll->dpll_pin);
> 	mdpll->tracking_netdev = netdev;
> }
> 
>@@ -269,7 +269,7 @@ static void mlx5_dpll_netdev_dpll_pin_clear(struct mlx5_dpll *mdpll)
> {
> 	if (!mdpll->tracking_netdev)
> 		return;
>-	netdev_dpll_pin_clear(mdpll->tracking_netdev);
>+	dpll_netdev_pin_clear(mdpll->tracking_netdev);
> 	mdpll->tracking_netdev = NULL;
> }
> 
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index c60591308ae8..e37344f6a231 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -122,15 +122,24 @@ struct dpll_pin_properties {
> };
> 
> #if IS_ENABLED(CONFIG_DPLL)
>-size_t dpll_msg_pin_handle_size(struct dpll_pin *pin);
>-int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin);
>+void dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin);
>+void dpll_netdev_pin_clear(struct net_device *dev);
>+
>+size_t dpll_netdev_pin_handle_size(const struct net_device *dev);
>+int dpll_netdev_add_pin_handle(struct sk_buff *msg,
>+			       const struct net_device *dev);
> #else
>-static inline size_t dpll_msg_pin_handle_size(struct dpll_pin *pin)
>+static inline void
>+dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin) { }
>+static inline void dpll_netdev_pin_clear(struct net_device *dev) { }
>+
>+static inline size_t dpll_netdev_pin_handle_size(const struct net_device *dev)
> {
> 	return 0;
> }
> 
>-static inline int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
>+static inline int
>+dpll_netdev_add_pin_handle(struct sk_buff *msg, const struct net_device *dev)
> {
> 	return 0;
> }
>@@ -169,13 +178,4 @@ int dpll_device_change_ntf(struct dpll_device *dpll);
> 
> int dpll_pin_change_ntf(struct dpll_pin *pin);
> 
>-#if !IS_ENABLED(CONFIG_DPLL)
>-static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
>-{
>-	return NULL;
>-}
>-#else
>-struct dpll_pin *netdev_dpll_pin(const struct net_device *dev);
>-#endif
>-
> #endif
>diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>index 735a9386fcf8..78a09af89e39 100644
>--- a/include/linux/netdevice.h
>+++ b/include/linux/netdevice.h
>@@ -79,8 +79,6 @@ struct xdp_buff;
> struct xdp_frame;
> struct xdp_metadata_ops;
> struct xdp_md;
>-/* DPLL specific */
>-struct dpll_pin;
> 
> typedef u32 xdp_features_t;
> 
>@@ -4042,8 +4040,6 @@ int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
> int dev_get_port_parent_id(struct net_device *dev,
> 			   struct netdev_phys_item_id *ppid, bool recurse);
> bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);
>-void netdev_dpll_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin);
>-void netdev_dpll_pin_clear(struct net_device *dev);
> 
> struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again);
> struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
>diff --git a/net/core/dev.c b/net/core/dev.c
>index 0230391c78f7..76e6438f4858 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -9074,28 +9074,6 @@ bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b)
> }
> EXPORT_SYMBOL(netdev_port_same_parent_id);
> 
>-static void netdev_dpll_pin_assign(struct net_device *dev, struct dpll_pin *dpll_pin)
>-{
>-#if IS_ENABLED(CONFIG_DPLL)
>-	rtnl_lock();
>-	rcu_assign_pointer(dev->dpll_pin, dpll_pin);
>-	rtnl_unlock();
>-#endif
>-}
>-
>-void netdev_dpll_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin)
>-{
>-	WARN_ON(!dpll_pin);
>-	netdev_dpll_pin_assign(dev, dpll_pin);
>-}
>-EXPORT_SYMBOL(netdev_dpll_pin_set);
>-
>-void netdev_dpll_pin_clear(struct net_device *dev)
>-{
>-	netdev_dpll_pin_assign(dev, NULL);
>-}
>-EXPORT_SYMBOL(netdev_dpll_pin_clear);
>-
> /**
>  *	dev_change_proto_down - set carrier according to proto_down.
>  *
>diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>index ae86f751efc3..bd50e9fe3234 100644
>--- a/net/core/rtnetlink.c
>+++ b/net/core/rtnetlink.c
>@@ -1057,7 +1057,7 @@ static size_t rtnl_dpll_pin_size(const struct net_device *dev)
> {
> 	size_t size = nla_total_size(0); /* nest IFLA_DPLL_PIN */
> 
>-	size += dpll_msg_pin_handle_size(netdev_dpll_pin(dev));
>+	size += dpll_netdev_pin_handle_size(dev);
> 
> 	return size;
> }
>@@ -1792,7 +1792,7 @@ static int rtnl_fill_dpll_pin(struct sk_buff *skb,
> 	if (!dpll_pin_nest)
> 		return -EMSGSIZE;
> 
>-	ret = dpll_msg_add_pin_handle(skb, netdev_dpll_pin(dev));
>+	ret = dpll_netdev_add_pin_handle(skb, dev);
> 	if (ret < 0)
> 		goto nest_cancel;
> 
>-- 
>2.44.0
>

