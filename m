Return-Path: <netdev+bounces-165574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC77A3298C
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B6CE7A2BF6
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC75D21129B;
	Wed, 12 Feb 2025 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ECdu5PlG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B92101BE
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372966; cv=none; b=cOvagV4kRjODQPrXvnBJ76ukq81W928BytizdUT2h6sLqMofy4f90YA+VYcY/oQTe7n5pZWI6vt0Jq6PDIFxqgoFQjwyuyRSbVq4vg3lfLa5QaI/hm8RYEaqH4n9JgauiPEu6sLof+RbgJZ6cNwzkfoKfCycizP31oAMveC3VoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372966; c=relaxed/simple;
	bh=prM8Rb7GKhuPzPoAk8Inm5H8aGGrbNGHzWE5rHHymiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8qWUMH5RTHulVK/iZtSn7W+MyvOnwhO82WrJ77gYVpyOKJxMfs3ELM3tqFCp0+3CxBReLNxGZSN3kFrEuLMGyJIWLFO7xQdxiVTi7tjhwivjNpmOJN7XWfQI4qjSQr4hlvgPYYcYV1iiPjZeVXQuO7SjTaTaRDdZ3cD0+OaLC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ECdu5PlG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dc1dfd9f2so4672502f8f.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 07:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739372962; x=1739977762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuuXeCZqGKKqy3wYcb60X8FTK9fgYMfx8AgwL2f6mtw=;
        b=ECdu5PlGyJhitPuZFKpwr1So4rPK+n2pFkHdno11mVLjWbtrkmC3A9mPItzlCTNlmO
         4FUwAsgSdjiP0tXv7v7m0JVRo0jbyYxUzkheZpz1fJnfrWcmqdaASs1j6xqwm5TUhfTB
         YN28eK3PGv1/DOr5H+AfbZ/RTnVRcrt/WNtK9lbe2wYDiMjucpBwksLBnF1AI9KwYCPt
         4J1G0nWaxUNSqaI3xWhBDUuQ3egiO/ufCsXlwhwvkCEBYBArgMmR5XMrFnWF4qBNa7AQ
         UZCwVLCjWueZ9zWuRo0ZzybgsXB0FykcHSOhPc0nQvNskeMg7VbEkOnLwA0k9471pV7p
         Pk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739372962; x=1739977762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuuXeCZqGKKqy3wYcb60X8FTK9fgYMfx8AgwL2f6mtw=;
        b=aRzVtSOu1w18cVvrmu01d/aI0jpE8OgwZU3XRAEXNbVc4x7DWkDqnbnM7g4l7XPBZX
         4uqqZD58DdXm85s6eI5MPin6ixzKi8WBTzCSktx7Po6vZeir5TrS7p/h74JzIYOBHNYQ
         oHCjZX2Zaf9EWvR3lY5uoB7WyS+0eX2a4EhZaOyBvPd2J6NzyUswaYFq+pKJCYzjek3d
         8uIfu5GvxziB3IUY2SRSceskWngpWY/SRIyF8/eCX68RNjOTA0tmVmvk6XPzzOOd20BQ
         tGrVBtv2mgUgO+aBHr645l6ZnRTvJt9HXfhp+vJdWEUvEyYrLAKr9iqnTvlbsAYPeR8d
         clpw==
X-Forwarded-Encrypted: i=1; AJvYcCUF+cLdo6WSEOE1QQx3yNgeC5oarFRLFgoRlqw6M9Yjy0nMy/vTz3D2ByO2iI5k1KnceGgRYao=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+G0yXRBCOUCIv9uKDgpteMSEi/FZcLx8TGNTw0OkcCF62jlH
	P0BXs4GDniveP2oU4zevtE6QpHcXceJbwWOS873W7/HX9zrzGQ+jwcDWQyIs8EY=
X-Gm-Gg: ASbGncu2y4AusOJsVCBz7s9qEHCD/foz07oihbLD++4XdT2KnrSY/Y4kjM+1JPhUTg8
	xK+IfJ8x/HgYMQb0ex375Q7TlAiC4uYG/yDgPZ5cWiLeGz8COrO2IktKitGaCQc0ZPU27Lo+0B3
	UYG4Ejlyq4IBTW4DA6oUrZ6G9n0GGgdxfJ9icBrXzyb8ZtfJtGQ1cLidSGxi6KPHJor1u+NAknC
	Ckc3AkzLSzt+XsovOION+VK1yH0/2GNt8HZrtUVVbShiKD0J1gFrhp7tnwCWLMufBobvnPI7jz3
	ntCeYQ38WwrN9ty9H553Fq/B7A==
X-Google-Smtp-Source: AGHT+IHEs7cbkyhoyUtfu7LQjjDbsnmIeLRrr4v+Uh+LRvNX0FEpoY+Il0Jgg8M+pYleUbFhB7ZY9g==
X-Received: by 2002:a5d:5f94:0:b0:38e:65d8:b677 with SMTP id ffacd0b85a97d-38e65d8b981mr2878490f8f.33.1739372962150;
        Wed, 12 Feb 2025 07:09:22 -0800 (PST)
Received: from jiri-mlt ([194.212.255.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7e8sm22551005e9.26.2025.02.12.07.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:09:21 -0800 (PST)
Date: Wed, 12 Feb 2025 16:09:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
	netdev@vger.kernel.org, horms@kernel.org, 
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH iwl-next v3 02/14] ixgbe: add initial devlink support
Message-ID: <cmywoei5shisdjbt7ipv6rmfxx6jgafu2ccb4xr3phq3ealx3n@kxsdwd6u5bgk>
References: <20250212131413.91787-1-jedrzej.jagielski@intel.com>
 <20250212131413.91787-3-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212131413.91787-3-jedrzej.jagielski@intel.com>

Wed, Feb 12, 2025 at 02:14:01PM +0100, jedrzej.jagielski@intel.com wrote:
>Add an initial support for devlink interface to ixgbe driver.
>
>Similarly to i40e driver the implementation doesn't enable
>devlink to manage device-wide configuration. Devlink instance
>is created for each physical function of PCIe device.
>
>Create separate directory for devlink related ixgbe files
>and use naming scheme similar to the one used in the ice driver.
>
>Add a stub for Documentation, to be extended by further patches.
>
>Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>---
>v2: fix error patch in probe; minor tweaks
>---
> Documentation/networking/devlink/index.rst    |  1 +
> Documentation/networking/devlink/ixgbe.rst    |  8 ++
> drivers/net/ethernet/intel/Kconfig            |  1 +
> drivers/net/ethernet/intel/ixgbe/Makefile     |  3 +-
> .../ethernet/intel/ixgbe/devlink/devlink.c    | 80 +++++++++++++++++++
> .../ethernet/intel/ixgbe/devlink/devlink.h    | 10 +++
> drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  8 ++
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 22 +++++
> 8 files changed, 132 insertions(+), 1 deletion(-)
> create mode 100644 Documentation/networking/devlink/ixgbe.rst
> create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
>
>diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
>index 948c8c44e233..8319f43b5933 100644
>--- a/Documentation/networking/devlink/index.rst
>+++ b/Documentation/networking/devlink/index.rst
>@@ -84,6 +84,7 @@ parameters, info versions, and other features it supports.
>    i40e
>    ionic
>    ice
>+   ixgbe
>    mlx4
>    mlx5
>    mlxsw
>diff --git a/Documentation/networking/devlink/ixgbe.rst b/Documentation/networking/devlink/ixgbe.rst
>new file mode 100644
>index 000000000000..c04ac51c6d85
>--- /dev/null
>+++ b/Documentation/networking/devlink/ixgbe.rst
>@@ -0,0 +1,8 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+
>+=====================
>+ixgbe devlink support
>+=====================
>+
>+This document describes the devlink features implemented by the ``ixgbe``
>+device driver.
>diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
>index 1640d2f27833..56ee58c9df21 100644
>--- a/drivers/net/ethernet/intel/Kconfig
>+++ b/drivers/net/ethernet/intel/Kconfig
>@@ -147,6 +147,7 @@ config IXGBE
> 	depends on PCI
> 	depends on PTP_1588_CLOCK_OPTIONAL
> 	select MDIO
>+	select NET_DEVLINK
> 	select PHYLIB
> 	help
> 	  This driver supports Intel(R) 10GbE PCI Express family of
>diff --git a/drivers/net/ethernet/intel/ixgbe/Makefile b/drivers/net/ethernet/intel/ixgbe/Makefile
>index b456d102655a..11f37140c0a3 100644
>--- a/drivers/net/ethernet/intel/ixgbe/Makefile
>+++ b/drivers/net/ethernet/intel/ixgbe/Makefile
>@@ -4,12 +4,13 @@
> # Makefile for the Intel(R) 10GbE PCI Express ethernet driver
> #
> 
>+subdir-ccflags-y += -I$(src)
> obj-$(CONFIG_IXGBE) += ixgbe.o
> 
> ixgbe-y := ixgbe_main.o ixgbe_common.o ixgbe_ethtool.o \
>            ixgbe_82599.o ixgbe_82598.o ixgbe_phy.o ixgbe_sriov.o \
>            ixgbe_mbx.o ixgbe_x540.o ixgbe_x550.o ixgbe_lib.o ixgbe_ptp.o \
>-           ixgbe_xsk.o ixgbe_e610.o
>+           ixgbe_xsk.o ixgbe_e610.o devlink/devlink.o
> 
> ixgbe-$(CONFIG_IXGBE_DCB) +=  ixgbe_dcb.o ixgbe_dcb_82598.o \
>                               ixgbe_dcb_82599.o ixgbe_dcb_nl.o
>diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
>new file mode 100644
>index 000000000000..c052e95c9496
>--- /dev/null
>+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
>@@ -0,0 +1,80 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/* Copyright (c) 2025, Intel Corporation. */
>+
>+#include "ixgbe.h"
>+#include "devlink.h"
>+
>+static const struct devlink_ops ixgbe_devlink_ops = {
>+};
>+
>+/**
>+ * ixgbe_allocate_devlink - Allocate devlink instance
>+ * @adapter: pointer to the device adapter structure
>+ *
>+ * Allocate a devlink instance for this physical function.
>+ *
>+ * Return: 0 on success, -ENOMEM when allocation failed.
>+ */
>+int ixgbe_allocate_devlink(struct ixgbe_adapter *adapter)
>+{
>+	struct ixgbe_devlink_priv *devlink_private;
>+	struct device *dev = &adapter->pdev->dev;
>+	struct devlink *devlink;
>+
>+	devlink = devlink_alloc(&ixgbe_devlink_ops,
>+				sizeof(*devlink_private), dev);
>+	if (!devlink)
>+		return -ENOMEM;
>+
>+	devlink_private = devlink_priv(devlink);
>+	devlink_private->adapter = adapter;

struct ixgbe_adapter * should be returned by devlink_priv(), that is the
idea, to let devlink allocate the driver private for you.



>+
>+	adapter->devlink = devlink;
>+
>+	return 0;
>+}
>+
>+/**
>+ * ixgbe_devlink_set_switch_id - Set unique switch ID based on PCI DSN
>+ * @adapter: pointer to the device adapter structure
>+ * @ppid: struct with switch id information
>+ */
>+static void ixgbe_devlink_set_switch_id(struct ixgbe_adapter *adapter,
>+					struct netdev_phys_item_id *ppid)
>+{
>+	u64 id = pci_get_dsn(adapter->pdev);
>+
>+	ppid->id_len = sizeof(id);
>+	put_unaligned_be64(id, &ppid->id);
>+}
>+
>+/**
>+ * ixgbe_devlink_register_port - Register devlink port
>+ * @adapter: pointer to the device adapter structure
>+ *
>+ * Create and register a devlink_port for this physical function.
>+ *
>+ * Return: 0 on success, error code on failure.
>+ */
>+int ixgbe_devlink_register_port(struct ixgbe_adapter *adapter)
>+{
>+	struct devlink_port *devlink_port = &adapter->devlink_port;
>+	struct devlink *devlink = adapter->devlink;
>+	struct device *dev = &adapter->pdev->dev;
>+	struct devlink_port_attrs attrs = {};
>+	int err;
>+
>+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
>+	attrs.phys.port_number = adapter->hw.bus.func;
>+	ixgbe_devlink_set_switch_id(adapter, &attrs.switch_id);
>+
>+	devlink_port_attrs_set(devlink_port, &attrs);
>+
>+	err = devl_port_register(devlink, devlink_port, 0);
>+	if (err) {
>+		dev_err(dev,
>+			"devlink port registration failed, err %d\n", err);
>+	}

Don't use "{}" for single statement.


>+
>+	return err;
>+}
>diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.h b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
>new file mode 100644
>index 000000000000..d73c57164aef
>--- /dev/null
>+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
>@@ -0,0 +1,10 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/* Copyright (c) 2025, Intel Corporation. */
>+
>+#ifndef _IXGBE_DEVLINK_H_
>+#define _IXGBE_DEVLINK_H_
>+
>+int ixgbe_allocate_devlink(struct ixgbe_adapter *adapter);
>+int ixgbe_devlink_register_port(struct ixgbe_adapter *adapter);
>+
>+#endif /* _IXGBE_DEVLINK_H_ */
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>index e6a380d4929b..37d761f8c409 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>@@ -17,6 +17,8 @@
> #include <linux/net_tstamp.h>
> #include <linux/ptp_clock_kernel.h>
> 
>+#include <net/devlink.h>
>+
> #include "ixgbe_type.h"
> #include "ixgbe_common.h"
> #include "ixgbe_dcb.h"
>@@ -612,6 +614,8 @@ struct ixgbe_adapter {
> 	struct bpf_prog *xdp_prog;
> 	struct pci_dev *pdev;
> 	struct mii_bus *mii_bus;
>+	struct devlink *devlink;
>+	struct devlink_port devlink_port;
> 
> 	unsigned long state;
> 
>@@ -830,6 +834,10 @@ struct ixgbe_adapter {
> 	spinlock_t vfs_lock;
> };
> 
>+struct ixgbe_devlink_priv {
>+	struct ixgbe_adapter *adapter;
>+};
>+
> static inline int ixgbe_determine_xdp_q_idx(int cpu)
> {
> 	if (static_key_enabled(&ixgbe_xdp_locking_key))
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>index 7236f20c9a30..1617ece95f1f 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>@@ -49,6 +49,7 @@
> #include "ixgbe_sriov.h"
> #include "ixgbe_model.h"
> #include "ixgbe_txrx_common.h"
>+#include "devlink/devlink.h"
> 
> char ixgbe_driver_name[] = "ixgbe";
> static const char ixgbe_driver_string[] =
>@@ -11275,6 +11276,10 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 	hw->back = adapter;
> 	adapter->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);
> 
>+	err = ixgbe_allocate_devlink(adapter);
>+	if (err)
>+		goto err_devlink;
>+
> 	hw->hw_addr = ioremap(pci_resource_start(pdev, 0),
> 			      pci_resource_len(pdev, 0));
> 	adapter->io_addr = hw->hw_addr;
>@@ -11613,6 +11618,11 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 	}
> 	strcpy(netdev->name, "eth%d");
> 	pci_set_drvdata(pdev, adapter);
>+
>+	devl_lock(adapter->devlink);
>+	ixgbe_devlink_register_port(adapter);
>+	SET_NETDEV_DEVLINK_PORT(adapter->netdev, &adapter->devlink_port);
>+
> 	err = register_netdev(netdev);
> 	if (err)
> 		goto err_register;
>@@ -11667,11 +11677,15 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 	if (err)
> 		goto err_netdev;
> 
>+	devl_register(adapter->devlink);
>+	devl_unlock(adapter->devlink);
> 	return 0;
> 
> err_netdev:
> 	unregister_netdev(netdev);
> err_register:
>+	devl_port_unregister(&adapter->devlink_port);
>+	devl_unlock(adapter->devlink);
> 	ixgbe_release_hw_control(adapter);
> 	ixgbe_clear_interrupt_scheme(adapter);
> 	if (hw->mac.type == ixgbe_mac_e610)
>@@ -11685,6 +11699,8 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 	kfree(adapter->rss_key);
> 	bitmap_free(adapter->af_xdp_zc_qps);
> err_ioremap:
>+	devlink_free(adapter->devlink);
>+err_devlink:
> 	disable_dev = !test_and_set_bit(__IXGBE_DISABLED, &adapter->state);
> 	free_netdev(netdev);
> err_alloc_etherdev:
>@@ -11717,6 +11733,8 @@ static void ixgbe_remove(struct pci_dev *pdev)
> 		return;
> 
> 	netdev  = adapter->netdev;
>+	devl_lock(adapter->devlink);
>+	devl_unregister(adapter->devlink);
> 	ixgbe_dbg_adapter_exit(adapter);
> 
> 	set_bit(__IXGBE_REMOVING, &adapter->state);
>@@ -11752,6 +11770,10 @@ static void ixgbe_remove(struct pci_dev *pdev)
> 	if (netdev->reg_state == NETREG_REGISTERED)
> 		unregister_netdev(netdev);
> 
>+	devl_port_unregister(&adapter->devlink_port);
>+	devl_unlock(adapter->devlink);
>+	devlink_free(adapter->devlink);
>+
> 	ixgbe_stop_ipsec_offload(adapter);
> 	ixgbe_clear_interrupt_scheme(adapter);
> 
>-- 
>2.31.1
>

