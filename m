Return-Path: <netdev+bounces-94872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8EF8C0EAE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265AD1F215DE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB38012FB0A;
	Thu,  9 May 2024 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MkYRV3IX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741AF13049F
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715252823; cv=none; b=ENSLBQnkZmNfzv91JR6pTP8FFjyve7u8wtgVKNo6QxoXDGi2+6Buc+i5jdZ1XaWb+ZC8hVceoM3AbbQq9FI2KHbrnH9mVXx5aIxexLKq2vFa97WjcGnqv5sMQGyoYndS6dXr8slulKAxsPZdhNzDYne+lYzH6obvrV0KHFEXG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715252823; c=relaxed/simple;
	bh=9GDZDLHaZDrf5lrc7KKFaCUdS7Zb0YGy2uVV0xunmU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUkiZQM4qtGRVDcbGJGpVibmMHZXxyYJAJyEhVduVMe1Ilaj3E7NhIXdVYLK+Lt6tyFYo0QoWfojsfZoqi40lQiEnpfCYb+ATGDdwSXEP+KAX9nN7NnqLiioRYgEsTmmQHO61u0XPHD0hdS4l+wTj07ldo7Qu4InwgnwFY1+pmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MkYRV3IX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a1054cf61so172244266b.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715252817; x=1715857617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9uXqYchpwUJ5l7izFzyWFwLWWLL66EG6OcReGAN+Tx0=;
        b=MkYRV3IXhiAmreTuMHA21/xiTwdnYaYIUPojOg7cMUyCj88w9yCE8rd6U1BB7L4SX7
         yPn0IJFruDFCNVvNDFuZGeqCpgUimcBOpogZa0UBA85XdsJH8ahkLAJmPbP6+dPFAmP6
         nV5emuZzIKTLSIIYSbq4gTQGE9jce5wwzN8rVzuzNn2Yit1H/JwYgLU3qCbx163yBE8P
         DBM7BbXiT+jYTBeJHAJ3phX33Fn/7QPcCh4D92TW8k91H0zBZeaevj+q25UaXhlPPtkG
         h6mg9T/yjO2jgrAO7FKhke7xsxpfNIbp69kNDMYYIV6RU5J0KE+15eV7RATiF810IUYo
         tC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715252817; x=1715857617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uXqYchpwUJ5l7izFzyWFwLWWLL66EG6OcReGAN+Tx0=;
        b=uFwdBjgq9z8t/fcjTXIIut9rnoVxC2jzei0PS0mfoEO+r4c7Eycp/JdGJnovpr/JZJ
         AcpFLPjo5YZ6rfpyYOcWKMk/e1q6C6hn/zlG6//Uh12wqZySGFagC0cW69Nj6SO1lVlZ
         4Nv6USLX3dWGtqG7gLWP6XIuFKymLSqZzysHXR7pb9DvE/tmDmlLnltWCtFI+Ic3pKwV
         ldDUmdcB3GqZVCu9lAw+5vdciYt4H/FgmkeEEeWnFLy1D/uNn6flgP4QqJ6bDqOztm0u
         7Dm20gp8FIDXGYbs4z3PYjE5nbt65wSSQW+r5bm+jbtM4k9GxB1X/ypzFwjesJt8Cuzz
         Ljxg==
X-Forwarded-Encrypted: i=1; AJvYcCXsLkeeTHaNy5fG1C+pc6RreSR2141QzKNrv8ZrMFIeOW//hHyaGR2ZcxEgVOgWV8Kv+1A5KD1Uias+mwgbE8eV/0Q5k3+C
X-Gm-Message-State: AOJu0YxIYT4oKpByZQciGWoMRhQ1zpQjqxNAPipKE1+U3kr+ebtVI2el
	HpUm3xNgvph8UGozto4K6CBXmrLgxhQvXAtklvoS+K7RKV57xK0m4yzQZJM2seI=
X-Google-Smtp-Source: AGHT+IHG5Z4S2HT+ANQbZuipH+hFwfiEJRLYd2Lh7UfSe+O2LNiJvKatmfgbpzFqxGHcVfxQAXcL2Q==
X-Received: by 2002:a17:906:194e:b0:a59:efd0:b247 with SMTP id a640c23a62f3a-a59fb9587a9mr430184766b.40.1715252817271;
        Thu, 09 May 2024 04:06:57 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cf60sm62688866b.14.2024.05.09.04.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:06:56 -0700 (PDT)
Date: Thu, 9 May 2024 13:06:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 03/14] ice: add basic devlink subfunctions support
Message-ID: <ZjyuTA_zMXzZSa7L@nanopsycho.orion>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-4-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507114516.9765-4-michal.swiatkowski@linux.intel.com>

Tue, May 07, 2024 at 01:45:04PM CEST, michal.swiatkowski@linux.intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Implement devlink port handlers responsible for ethernet type devlink
>subfunctions. Create subfunction devlink port and setup all resources
>needed for a subfunction netdev to operate. Configure new VSI for each
>new subfunction, initialize and configure interrupts and Tx/Rx resources.
>Set correct MAC filters and create new netdev.
>
>For now, subfunction is limited to only one Tx/Rx queue pair.
>
>Only allocate new subfunction VSI with devlink port new command.
>This makes sure that real resources are configured only when a new
>subfunction gets activated. Allocate and free subfunction MSIX

Interesting. You talk about actitation, yet you don't implement it here.



>interrupt vectors using new API calls with pci_msix_alloc_irq_at
>and pci_msix_free_irq.
>
>Support both automatic and manual subfunction numbers. If no subfunction
>number is provided, use xa_alloc to pick a number automatically. This
>will find the first free index and use that as the number. This reduces
>burden on users in the simple case where a specific number is not
>required. It may also be slightly faster to check that a number exists
>since xarray lookup should be faster than a linear scan of the dyn_ports
>xarray.
>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
>Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> .../net/ethernet/intel/ice/devlink/devlink.c  |   3 +
> .../ethernet/intel/ice/devlink/devlink_port.c | 357 ++++++++++++++++++
> .../ethernet/intel/ice/devlink/devlink_port.h |  33 ++
> drivers/net/ethernet/intel/ice/ice.h          |   4 +
> drivers/net/ethernet/intel/ice/ice_lib.c      |   5 +-
> drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
> drivers/net/ethernet/intel/ice/ice_main.c     |   9 +-
> 7 files changed, 410 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>index 10073342e4f0..3fb3a7e828a4 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>@@ -6,6 +6,7 @@
> #include "ice.h"
> #include "ice_lib.h"
> #include "devlink.h"
>+#include "devlink_port.h"
> #include "ice_eswitch.h"
> #include "ice_fw_update.h"
> #include "ice_dcb_lib.h"
>@@ -1277,6 +1278,8 @@ static const struct devlink_ops ice_devlink_ops = {
> 
> 	.rate_leaf_parent_set = ice_devlink_set_parent,
> 	.rate_node_parent_set = ice_devlink_set_parent,
>+
>+	.port_new = ice_devlink_port_new,
> };
> 
> static int
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>index c9fbeebf7fb9..995c11f71b3f 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>@@ -5,6 +5,9 @@
> 
> #include "ice.h"
> #include "devlink.h"
>+#include "devlink_port.h"
>+#include "ice_lib.h"
>+#include "ice_fltr.h"
> 
> static int ice_active_port_option = -1;
> 
>@@ -428,3 +431,357 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
> 	devl_rate_leaf_destroy(&vf->devlink_port);
> 	devl_port_unregister(&vf->devlink_port);
> }
>+
>+/**
>+ * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
>+ * @dyn_port: dynamic port instance to deallocate
>+ *
>+ * Free resources associated with a dynamically added devlink port. Will
>+ * deactivate the port if its currently active.
>+ */
>+static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
>+{
>+	struct devlink_port *devlink_port = &dyn_port->devlink_port;
>+	struct ice_pf *pf = dyn_port->pf;
>+
>+	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
>+	devl_port_unregister(devlink_port);
>+	ice_vsi_free(dyn_port->vsi);
>+	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
>+	kfree(dyn_port);
>+}
>+
>+/**
>+ * ice_dealloc_all_dynamic_ports - Deallocate all dynamic devlink ports
>+ * @pf: pointer to the pf structure
>+ */
>+void ice_dealloc_all_dynamic_ports(struct ice_pf *pf)
>+{
>+	struct ice_dynamic_port *dyn_port;
>+	unsigned long index;
>+
>+	xa_for_each(&pf->dyn_ports, index, dyn_port)
>+		ice_dealloc_dynamic_port(dyn_port);
>+}
>+
>+/**
>+ * ice_devlink_port_new_check_attr - Check that new port attributes are valid
>+ * @pf: pointer to the PF structure
>+ * @new_attr: the attributes for the new port
>+ * @extack: extack for reporting error messages
>+ *
>+ * Check that the attributes for the new port are valid before continuing to
>+ * allocate the devlink port.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int
>+ice_devlink_port_new_check_attr(struct ice_pf *pf,
>+				const struct devlink_port_new_attrs *new_attr,
>+				struct netlink_ext_ack *extack)
>+{
>+	if (new_attr->flavour != DEVLINK_PORT_FLAVOUR_PCI_SF) {
>+		NL_SET_ERR_MSG_MOD(extack, "Flavour other than pcisf is not supported");
>+		return -EOPNOTSUPP;
>+	}
>+
>+	if (new_attr->controller_valid) {
>+		NL_SET_ERR_MSG_MOD(extack, "Setting controller is not supported");
>+		return -EOPNOTSUPP;
>+	}
>+
>+	if (new_attr->port_index_valid) {
>+		NL_SET_ERR_MSG_MOD(extack, "Port index is invalid");
>+		return -EOPNOTSUPP;
>+	}
>+
>+	if (new_attr->pfnum != pf->hw.bus.func) {
>+		NL_SET_ERR_MSG_MOD(extack, "Incorrect pfnum supplied");
>+		return -EINVAL;
>+	}
>+
>+	if (!pci_msix_can_alloc_dyn(pf->pdev)) {
>+		NL_SET_ERR_MSG_MOD(extack, "Dynamic MSIX-X interrupt allocation is not supported");
>+		return -EOPNOTSUPP;
>+	}
>+
>+	return 0;
>+}
>+
>+/**
>+ * ice_devlink_port_del - devlink handler for port delete
>+ * @devlink: pointer to devlink
>+ * @port: devlink port to be deleted
>+ * @extack: pointer to extack
>+ *
>+ * Deletes devlink port and deallocates all resources associated with
>+ * created subfunction.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int
>+ice_devlink_port_del(struct devlink *devlink, struct devlink_port *port,
>+		     struct netlink_ext_ack *extack)
>+{
>+	struct ice_dynamic_port *dyn_port;
>+
>+	dyn_port = ice_devlink_port_to_dyn(port);
>+	ice_dealloc_dynamic_port(dyn_port);
>+
>+	return 0;
>+}
>+
>+/**
>+ * ice_devlink_port_fn_hw_addr_set - devlink handler for mac address set
>+ * @port: pointer to devlink port
>+ * @hw_addr: hw address to set
>+ * @hw_addr_len: hw address length
>+ * @extack: extack for reporting error messages
>+ *
>+ * Sets mac address for the port, verifies arguments and copies address
>+ * to the subfunction structure.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int
>+ice_devlink_port_fn_hw_addr_set(struct devlink_port *port, const u8 *hw_addr,
>+				int hw_addr_len,
>+				struct netlink_ext_ack *extack)
>+{
>+	struct ice_dynamic_port *dyn_port;
>+
>+	dyn_port = ice_devlink_port_to_dyn(port);
>+
>+	if (hw_addr_len != ETH_ALEN || !is_valid_ether_addr(hw_addr)) {
>+		NL_SET_ERR_MSG_MOD(extack, "Invalid ethernet address");
>+		return -EADDRNOTAVAIL;
>+	}
>+
>+	ether_addr_copy(dyn_port->hw_addr, hw_addr);

How does this work? You copy the address to the internal structure, but
where you update the HW?


>+
>+	return 0;
>+}
>+
>+/**
>+ * ice_devlink_port_fn_hw_addr_get - devlink handler for mac address get
>+ * @port: pointer to devlink port
>+ * @hw_addr: hw address to set
>+ * @hw_addr_len: hw address length
>+ * @extack: extack for reporting error messages
>+ *
>+ * Returns mac address for the port.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int
>+ice_devlink_port_fn_hw_addr_get(struct devlink_port *port, u8 *hw_addr,
>+				int *hw_addr_len,
>+				struct netlink_ext_ack *extack)
>+{
>+	struct ice_dynamic_port *dyn_port;
>+
>+	dyn_port = ice_devlink_port_to_dyn(port);
>+
>+	ether_addr_copy(hw_addr, dyn_port->hw_addr);
>+	*hw_addr_len = ETH_ALEN;
>+
>+	return 0;
>+}
>+
>+static const struct devlink_port_ops ice_devlink_port_sf_ops = {
>+	.port_del = ice_devlink_port_del,
>+	.port_fn_hw_addr_get = ice_devlink_port_fn_hw_addr_get,
>+	.port_fn_hw_addr_set = ice_devlink_port_fn_hw_addr_set,
>+};
>+
>+/**
>+ * ice_reserve_sf_num - Reserve a subfunction number for this port
>+ * @pf: pointer to the pf structure
>+ * @new_attr: devlink port attributes requested
>+ * @extack: extack for reporting error messages
>+ * @sfnum: on success, the sf number reserved
>+ *
>+ * Reserve a subfunction number for this port. Only called for
>+ * DEVLINK_PORT_FLAVOUR_PCI_SF ports.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int
>+ice_reserve_sf_num(struct ice_pf *pf,
>+		   const struct devlink_port_new_attrs *new_attr,
>+		   struct netlink_ext_ack *extack, u32 *sfnum)
>+{
>+	int err;
>+
>+	/* If user didn't request an explicit number, pick one */
>+	if (!new_attr->sfnum_valid)
>+		return xa_alloc(&pf->sf_nums, sfnum, NULL, xa_limit_32b,
>+				GFP_KERNEL);
>+
>+	/* Otherwise, check and use the number provided */
>+	err = xa_insert(&pf->sf_nums, new_attr->sfnum, NULL, GFP_KERNEL);
>+	if (err) {
>+		if (err == -EBUSY)
>+			NL_SET_ERR_MSG_MOD(extack, "Subfunction with given sfnum already exists");
>+		return err;
>+	}
>+
>+	*sfnum = new_attr->sfnum;
>+
>+	return 0;
>+}
>+
>+/**
>+ * ice_devlink_create_sf_port - Register PCI subfunction devlink port
>+ * @dyn_port: the dynamic port instance structure for this subfunction
>+ *
>+ * Register PCI subfunction flavour devlink port for a dynamically added
>+ * subfunction port.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port)
>+{
>+	struct devlink_port_attrs attrs = {};
>+	struct devlink_port *devlink_port;
>+	struct devlink *devlink;
>+	struct ice_vsi *vsi;
>+	struct device *dev;
>+	struct ice_pf *pf;
>+	int err;
>+
>+	vsi = dyn_port->vsi;
>+	pf = dyn_port->pf;
>+	dev = ice_pf_to_dev(pf);
>+
>+	devlink_port = &dyn_port->devlink_port;
>+
>+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_SF;
>+	attrs.pci_sf.pf = pf->hw.bus.func;
>+	attrs.pci_sf.sf = dyn_port->sfnum;
>+
>+	devlink_port_attrs_set(devlink_port, &attrs);
>+	devlink = priv_to_devlink(pf);
>+
>+	err = devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
>+					  &ice_devlink_port_sf_ops);
>+	if (err) {
>+		dev_err(dev, "Failed to create devlink port for Subfunction %d",
>+			vsi->idx);
>+		return err;
>+	}
>+
>+	return 0;
>+}
>+
>+/**
>+ * ice_devlink_destroy_sf_port - Destroy the devlink_port for this SF
>+ * @dyn_port: the dynamic port instance structure for this subfunction
>+ *
>+ * Unregisters the devlink_port structure associated with this SF.
>+ */
>+void ice_devlink_destroy_sf_port(struct ice_dynamic_port *dyn_port)
>+{
>+       devl_port_unregister(&dyn_port->devlink_port);
>+}
>+
>+/**
>+ * ice_alloc_dynamic_port - Allocate new dynamic port
>+ * @pf: pointer to the pf structure
>+ * @new_attr: devlink port attributes requested
>+ * @extack: extack for reporting error messages
>+ * @devlink_port: index of newly created devlink port
>+ *
>+ * Allocate a new dynamic port instance and prepare it for configuration
>+ * with devlink.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int
>+ice_alloc_dynamic_port(struct ice_pf *pf,
>+		       const struct devlink_port_new_attrs *new_attr,
>+		       struct netlink_ext_ack *extack,
>+		       struct devlink_port **devlink_port)
>+{
>+	struct ice_dynamic_port *dyn_port;
>+	struct ice_vsi *vsi;
>+	u32 sfnum;
>+	int err;
>+
>+	err = ice_reserve_sf_num(pf, new_attr, extack, &sfnum);
>+	if (err)
>+		return err;
>+
>+	dyn_port = kzalloc(sizeof(*dyn_port), GFP_KERNEL);
>+	if (!dyn_port) {
>+		err = -ENOMEM;
>+		goto unroll_reserve_sf_num;
>+	}
>+
>+	vsi = ice_vsi_alloc(pf);
>+	if (!vsi) {
>+		NL_SET_ERR_MSG_MOD(extack, "Unable to allocate VSI");
>+		err = -ENOMEM;
>+		goto unroll_dyn_port_alloc;
>+	}
>+
>+	dyn_port->vsi = vsi;
>+	dyn_port->pf = pf;
>+	dyn_port->sfnum = sfnum;
>+	eth_random_addr(dyn_port->hw_addr);
>+
>+	err = xa_insert(&pf->dyn_ports, vsi->idx, dyn_port, GFP_KERNEL);
>+	if (err) {
>+		NL_SET_ERR_MSG_MOD(extack, "Port index reservation failed");
>+		goto unroll_vsi_alloc;
>+	}
>+
>+	err = ice_devlink_create_sf_port(dyn_port);
>+	if (err) {
>+		NL_SET_ERR_MSG_MOD(extack, "Port registration failed");
>+		goto unroll_xa_insert;
>+	}
>+
>+	*devlink_port = &dyn_port->devlink_port;
>+
>+	return 0;
>+
>+unroll_xa_insert:
>+	xa_erase(&pf->dyn_ports, vsi->idx);
>+unroll_vsi_alloc:
>+	ice_vsi_free(vsi);
>+unroll_dyn_port_alloc:
>+	kfree(dyn_port);
>+unroll_reserve_sf_num:
>+	xa_erase(&pf->sf_nums, sfnum);
>+
>+	return err;
>+}
>+
>+/**
>+ * ice_devlink_port_new - devlink handler for the new port
>+ * @devlink: pointer to devlink
>+ * @new_attr: pointer to the port new attributes
>+ * @extack: extack for reporting error messages
>+ * @devlink_port: pointer to a new port
>+ *
>+ * Creates new devlink port, checks new port attributes and reject
>+ * any unsupported parameters, allocates new subfunction for that port.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+int
>+ice_devlink_port_new(struct devlink *devlink,
>+		     const struct devlink_port_new_attrs *new_attr,
>+		     struct netlink_ext_ack *extack,
>+		     struct devlink_port **devlink_port)
>+{
>+	struct ice_pf *pf = devlink_priv(devlink);
>+	int err;
>+
>+	err = ice_devlink_port_new_check_attr(pf, new_attr, extack);
>+	if (err)
>+		return err;
>+
>+	return ice_alloc_dynamic_port(pf, new_attr, extack, devlink_port);
>+}
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>index 9223bcdb6444..f20d7cc522a6 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>@@ -4,9 +4,42 @@
> #ifndef _DEVLINK_PORT_H_
> #define _DEVLINK_PORT_H_
> 
>+#include "../ice.h"
>+
>+/**
>+ * struct ice_dynamic_port - Track dynamically added devlink port instance
>+ * @hw_addr: the HW address for this port
>+ * @active: true if the port has been activated
>+ * @devlink_port: the associated devlink port structure
>+ * @pf: pointer to the PF private structure
>+ * @vsi: the VSI associated with this port
>+ *
>+ * An instance of a dynamically added devlink port. Each port flavour
>+ */
>+struct ice_dynamic_port {
>+	u8 hw_addr[ETH_ALEN];
>+	u8 active: 1;
>+	struct devlink_port devlink_port;
>+	struct ice_pf *pf;
>+	struct ice_vsi *vsi;
>+	u32 sfnum;
>+};
>+
>+void ice_dealloc_all_dynamic_ports(struct ice_pf *pf);
>+
> int ice_devlink_create_pf_port(struct ice_pf *pf);
> void ice_devlink_destroy_pf_port(struct ice_pf *pf);
> int ice_devlink_create_vf_port(struct ice_vf *vf);
> void ice_devlink_destroy_vf_port(struct ice_vf *vf);
>+int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port);
>+void ice_devlink_destroy_sf_port(struct ice_dynamic_port *dyn_port);
>+
>+#define ice_devlink_port_to_dyn(p) \
>+	container_of(port, struct ice_dynamic_port, devlink_port)
> 
>+int
>+ice_devlink_port_new(struct devlink *devlink,
>+		     const struct devlink_port_new_attrs *new_attr,
>+		     struct netlink_ext_ack *extack,
>+		     struct devlink_port **devlink_port);
> #endif /* _DEVLINK_PORT_H_ */
>diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>index 7bdf3fd30f7a..8a30b786b334 100644
>--- a/drivers/net/ethernet/intel/ice/ice.h
>+++ b/drivers/net/ethernet/intel/ice/ice.h
>@@ -651,6 +651,9 @@ struct ice_pf {
> 	struct ice_eswitch eswitch;
> 	struct ice_esw_br_port *br_port;
> 
>+	struct xarray dyn_ports;
>+	struct xarray sf_nums;
>+
> #define ICE_INVALID_AGG_NODE_ID		0
> #define ICE_PF_AGG_NODE_ID_START	1
> #define ICE_MAX_PF_AGG_NODES		32
>@@ -907,6 +910,7 @@ int ice_vsi_open(struct ice_vsi *vsi);
> void ice_set_ethtool_ops(struct net_device *netdev);
> void ice_set_ethtool_repr_ops(struct net_device *netdev);
> void ice_set_ethtool_safe_mode_ops(struct net_device *netdev);
>+void ice_set_ethtool_sf_ops(struct net_device *netdev);
> u16 ice_get_avail_txq_count(struct ice_pf *pf);
> u16 ice_get_avail_rxq_count(struct ice_pf *pf);
> int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked);
>diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>index e2ce7395e2f2..bab2edaafb99 100644
>--- a/drivers/net/ethernet/intel/ice/ice_lib.c
>+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>@@ -7,6 +7,7 @@
> #include "ice_lib.h"
> #include "ice_fltr.h"
> #include "ice_dcb_lib.h"
>+#include "ice_type.h"
> #include "ice_vsi_vlan_ops.h"
> 
> /**
>@@ -440,7 +441,7 @@ static int ice_vsi_alloc_ring_stats(struct ice_vsi *vsi)
>  * This deallocates the VSI's queue resources, removes it from the PF's
>  * VSI array if necessary, and deallocates the VSI
>  */
>-static void ice_vsi_free(struct ice_vsi *vsi)
>+void ice_vsi_free(struct ice_vsi *vsi)
> {
> 	struct ice_pf *pf = NULL;
> 	struct device *dev;
>@@ -612,7 +613,7 @@ ice_vsi_alloc_def(struct ice_vsi *vsi, struct ice_channel *ch)
>  *
>  * returns a pointer to a VSI on success, NULL on failure.
>  */
>-static struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf)
>+struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf)
> {
> 	struct device *dev = ice_pf_to_dev(pf);
> 	struct ice_vsi *vsi = NULL;
>diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
>index f9ee461c5c06..5de0cc50552c 100644
>--- a/drivers/net/ethernet/intel/ice/ice_lib.h
>+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
>@@ -66,6 +66,8 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked);
> 
> int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags);
> int ice_vsi_cfg(struct ice_vsi *vsi);
>+struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf);
>+void ice_vsi_free(struct ice_vsi *vsi);
> 
> bool ice_is_reset_in_progress(unsigned long *state);
> int ice_wait_for_reset(struct ice_pf *pf, unsigned long timeout);
>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>index ce1cf1b03321..7033981666a7 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -3965,6 +3965,9 @@ static void ice_deinit_pf(struct ice_pf *pf)
> 
> 	if (pf->ptp.clock)
> 		ptp_clock_unregister(pf->ptp.clock);
>+
>+	xa_destroy(&pf->dyn_ports);
>+	xa_destroy(&pf->sf_nums);
> }
> 
> /**
>@@ -4058,6 +4061,9 @@ static int ice_init_pf(struct ice_pf *pf)
> 	hash_init(pf->vfs.table);
> 	ice_mbx_init_snapshot(&pf->hw);
> 
>+	xa_init(&pf->dyn_ports);
>+	xa_init(&pf->sf_nums);
>+
> 	return 0;
> }
> 
>@@ -5383,6 +5389,7 @@ static void ice_remove(struct pci_dev *pdev)
> 		ice_remove_arfs(pf);
> 
> 	devl_lock(priv_to_devlink(pf));
>+	ice_dealloc_all_dynamic_ports(pf);
> 	ice_deinit_devlink(pf);
> 
> 	ice_unload(pf);
>@@ -6677,7 +6684,7 @@ static int ice_up_complete(struct ice_vsi *vsi)
> 
> 	if (vsi->port_info &&
> 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
>-	    vsi->netdev && vsi->type == ICE_VSI_PF) {
>+	    ((vsi->netdev && vsi->type == ICE_VSI_PF))) {

I think this is some leftover, remove.


> 		ice_print_link_msg(vsi, true);
> 		netif_tx_start_all_queues(vsi->netdev);
> 		netif_carrier_on(vsi->netdev);
>-- 
>2.42.0
>
>

