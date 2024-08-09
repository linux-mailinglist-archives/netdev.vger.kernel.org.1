Return-Path: <netdev+bounces-117170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E23894CF58
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFB51C21010
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36A61922DA;
	Fri,  9 Aug 2024 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DkuZX5Mg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03215D5C3
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202810; cv=none; b=npcV3IWTUsp8CBbRJxy51SXeR1glfxWpsW9mAPJc9oLzpyCg7bGY0TguzZzfXqLqupDaNZnffpvn1yKDyZIIurBApF8MeStlT0XjgS2dFHWE2GnAm5MKFwK8QEOuJ10duk7X4aNtp2ryXprf5V2V3hak88GHqiH6D8DSHBXF1fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202810; c=relaxed/simple;
	bh=I21/k4M+smONtBbemV0dwQfxrBEjlXwgm/1t0A/ZV2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j78rrKsKCzIvaJd9Fn1BlXlp+IbABawXlTsVajEKgzwatqpapa/O9t0zaB8ikITOj9mMiGe4TYOR5EYVd286gu9O6Dh4Iv8uuQf0CyX9pbP/ilRrL8AyzgPp5PF8MuNW4cnkY+bZLl8vPgCw4nWDXLDg/C2DMBqaMPtLjU3z4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DkuZX5Mg; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7ad02501c3so254249066b.2
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 04:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723202806; x=1723807606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dyBrMDXTQ39wHjzfyzPo9wg3KCRi+H4mjBgxTfLs5I=;
        b=DkuZX5Mguvm0l7XpTgtJv77KmKvKJ0yrtmcUBxqG6kMgpc9Ii2rzx0QE985gSJlHUH
         eMv1KoSyG+v0mb9+a4sWgsnvFk1O2cu3LKsuoulCjaHAiirb0CSIkm4f0GExpuFHWTmC
         A8h7sKi2++vuhhQonN7JSEVMdXkAp47r5jZQpsL/2+QQ3GlgTQVcCQmminhzlg19gfUC
         9RMz3yGvrTZHTUEUmm4TDxPI/a+dR/ZhBo/6CzHMhv/oZoWk1pf/uU16uV9O6Odr4L8O
         RDoTOoDyp8BO9i9MU755/OvtQUvA72T82U/zomkIJO95JPGqgSrrVugTY4wElIHclgwj
         DYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723202806; x=1723807606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dyBrMDXTQ39wHjzfyzPo9wg3KCRi+H4mjBgxTfLs5I=;
        b=o8c/wlFjugPcL/7eoZmJXNycJDBj9c6EhwI3hgUMsGZFgbEAbBX2//vTpy9+A8Twg9
         zO+jeXs0kReBtIwR318gjJF9LBz2Su1bhby5o7uZQcPcp/nWg2+9X3OvICCSU0SakdMe
         QZLT3v0SnGiUQUvHtkPypjuorbcPqtnFFzp3JlvhfgX4qrdh58IT3Tj86BJtS1ugcyCV
         TYVEwBoaudUGMDu0hUuXxwX/Z3OuhbgcoMs69tr4wHtCN4fzMj+FlNx2sito/Mo2+A6F
         X5wwZ387HFVujmZXsKXL6zsjSDpqCZuLmGo0xciYqH9Dw9K6CI45vnSnO7wighDdiZQs
         jsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvk95VsgpAinI69YxDeZPwyd4JP2NQhlVarHHES4YzvfN1/2G+7KWnrDALSVK/tumVrCMpGserEZGppPxgioVjfzGji708
X-Gm-Message-State: AOJu0YyRJeJz6sCKz1cKFVTu+aOyZjn7EHwTgie8TxL7+flML2mZaCC3
	EKLp4Qw1hYG6K3Zg4ILyrtFH9S1oaRzecIHIy0qcu+M13d2sP/4lGgR+qlL6ATU=
X-Google-Smtp-Source: AGHT+IGNIEZJWnDHoGm0dQjG1PiGRV7KYByYX6iQaTqgTAUfGK8fTXZnTPv9Agsmkzq/3YSoTwrXJw==
X-Received: by 2002:a17:907:7f17:b0:a7d:9d6f:2b97 with SMTP id a640c23a62f3a-a80aa67b107mr103556166b.48.1723202806259;
        Fri, 09 Aug 2024 04:26:46 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cb83sm829623166b.49.2024.08.09.04.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:26:45 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:26:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	michal.swiatkowski@linux.intel.com, jiri@nvidia.com,
	shayd@nvidia.com, wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v3 15/15] ice: allow to activate and deactivate
 subfunction
Message-ID: <ZrX89AVg5o9lzSEA@nanopsycho.orion>
References: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
 <20240808173104.385094-16-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808173104.385094-16-anthony.l.nguyen@intel.com>

Thu, Aug 08, 2024 at 07:31:01PM CEST, anthony.l.nguyen@intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Use previously implemented SF aux driver. It is probe during SF
>activation and remove after deactivation.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
>Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>---
> .../ethernet/intel/ice/devlink/devlink_port.c | 176 ++++++++++++++++++
> .../ethernet/intel/ice/devlink/devlink_port.h |   7 +
> drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 103 ++++++++++
> drivers/net/ethernet/intel/ice/ice_sf_eth.h   |   3 +
> 4 files changed, 289 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>index 4cfd90581d92..675a2b60892b 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>@@ -530,6 +530,48 @@ void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
> 	devl_port_unregister(&sf_dev->priv->devlink_port);
> }
> 
>+/**
>+ * ice_activate_dynamic_port - Activate a dynamic port
>+ * @dyn_port: dynamic port instance to activate
>+ * @extack: extack for reporting error messages
>+ *
>+ * Activate the dynamic port based on its flavour.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int
>+ice_activate_dynamic_port(struct ice_dynamic_port *dyn_port,
>+			  struct netlink_ext_ack *extack)
>+{
>+	int err;
>+
>+	if (dyn_port->active)
>+		return 0;
>+
>+	err = ice_sf_eth_activate(dyn_port, extack);
>+	if (err)
>+		return err;
>+
>+	dyn_port->active = true;
>+
>+	return 0;
>+}
>+
>+/**
>+ * ice_deactivate_dynamic_port - Deactivate a dynamic port
>+ * @dyn_port: dynamic port instance to deactivate
>+ *
>+ * Undo activation of a dynamic port.
>+ */
>+static void ice_deactivate_dynamic_port(struct ice_dynamic_port *dyn_port)
>+{
>+	if (!dyn_port->active)
>+		return;
>+
>+	ice_sf_eth_deactivate(dyn_port);
>+	dyn_port->active = false;
>+}
>+
> /**
>  * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
>  * @dyn_port: dynamic port instance to deallocate
>@@ -542,6 +584,8 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
> 	struct devlink_port *devlink_port = &dyn_port->devlink_port;
> 	struct ice_pf *pf = dyn_port->pf;
> 
>+	ice_deactivate_dynamic_port(dyn_port);
>+
> 	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
> 	ice_eswitch_detach_sf(pf, dyn_port);
> 	ice_vsi_free(dyn_port->vsi);
>@@ -629,8 +673,140 @@ ice_devlink_port_del(struct devlink *devlink, struct devlink_port *port,
> 	return 0;
> }
> 
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

Interesting. The patch subject and description talks about "activation"
yet you also set/get hw address here. Either split to 2 patches of
adjust the patch subject and desctiption.




>+				int hw_addr_len,
>+				struct netlink_ext_ack *extack)
>+{
>+	struct ice_dynamic_port *dyn_port;
>+
>+	dyn_port = ice_devlink_port_to_dyn(port);
>+
>+	if (dyn_port->attached) {
>+		NL_SET_ERR_MSG_MOD(extack,
>+				   "Ethernet address can be change only in detached state");
>+		return -EBUSY;
>+	}
>+
>+	if (hw_addr_len != ETH_ALEN || !is_valid_ether_addr(hw_addr)) {
>+		NL_SET_ERR_MSG_MOD(extack, "Invalid ethernet address");
>+		return -EADDRNOTAVAIL;
>+	}
>+
>+	ether_addr_copy(dyn_port->hw_addr, hw_addr);
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
>+/**
>+ * ice_devlink_port_fn_state_set - devlink handler for port state set
>+ * @port: pointer to devlink port
>+ * @state: state to set
>+ * @extack: extack for reporting error messages
>+ *
>+ * Activates or deactivates the port.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int
>+ice_devlink_port_fn_state_set(struct devlink_port *port,
>+			      enum devlink_port_fn_state state,
>+			      struct netlink_ext_ack *extack)
>+{
>+	struct ice_dynamic_port *dyn_port;
>+
>+	dyn_port = ice_devlink_port_to_dyn(port);
>+
>+	switch (state) {
>+	case DEVLINK_PORT_FN_STATE_ACTIVE:
>+		return ice_activate_dynamic_port(dyn_port, extack);
>+
>+	case DEVLINK_PORT_FN_STATE_INACTIVE:
>+		ice_deactivate_dynamic_port(dyn_port);
>+		break;
>+	}
>+
>+	return 0;
>+}
>+
>+/**
>+ * ice_devlink_port_fn_state_get - devlink handler for port state get
>+ * @port: pointer to devlink port
>+ * @state: admin configured state of the port
>+ * @opstate: current port operational state
>+ * @extack: extack for reporting error messages
>+ *
>+ * Gets port state.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int
>+ice_devlink_port_fn_state_get(struct devlink_port *port,
>+			      enum devlink_port_fn_state *state,
>+			      enum devlink_port_fn_opstate *opstate,
>+			      struct netlink_ext_ack *extack)
>+{
>+	struct ice_dynamic_port *dyn_port;
>+
>+	dyn_port = ice_devlink_port_to_dyn(port);
>+
>+	if (dyn_port->active)
>+		*state = DEVLINK_PORT_FN_STATE_ACTIVE;
>+	else
>+		*state = DEVLINK_PORT_FN_STATE_INACTIVE;
>+
>+	if (dyn_port->attached)
>+		*opstate = DEVLINK_PORT_FN_OPSTATE_ATTACHED;
>+	else
>+		*opstate = DEVLINK_PORT_FN_OPSTATE_DETACHED;
>+
>+	return 0;
>+}
>+
> static const struct devlink_port_ops ice_devlink_port_sf_ops = {
> 	.port_del = ice_devlink_port_del,
>+	.port_fn_hw_addr_get = ice_devlink_port_fn_hw_addr_get,
>+	.port_fn_hw_addr_set = ice_devlink_port_fn_hw_addr_set,
>+	.port_fn_state_get = ice_devlink_port_fn_state_get,
>+	.port_fn_state_set = ice_devlink_port_fn_state_set,
> };
> 
> /**
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>index 479d2b976745..d60efc340945 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>@@ -11,22 +11,29 @@
>  * struct ice_dynamic_port - Track dynamically added devlink port instance
>  * @hw_addr: the HW address for this port
>  * @active: true if the port has been activated
>+ * @attached: true it the prot is attached
>  * @devlink_port: the associated devlink port structure
>  * @pf: pointer to the PF private structure
>  * @vsi: the VSI associated with this port
>  * @repr_id: the representor ID
>  * @sfnum: the subfunction ID
>+ * @sf_dev: pointer to the subfunction device
>  *
>  * An instance of a dynamically added devlink port. Each port flavour
>  */
> struct ice_dynamic_port {
> 	u8 hw_addr[ETH_ALEN];
> 	u8 active: 1;
>+	u8 attached: 1;
> 	struct devlink_port devlink_port;
> 	struct ice_pf *pf;
> 	struct ice_vsi *vsi;
> 	unsigned long repr_id;
> 	u32 sfnum;
>+	/* Flavour-specific implementation data */
>+	union {
>+		struct ice_sf_dev *sf_dev;
>+	};
> };
> 
> void ice_dealloc_all_dynamic_ports(struct ice_pf *pf);
>diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>index 9eb8993df25a..27a5baee7880 100644
>--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>@@ -150,6 +150,7 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
> 	devl_unlock(devlink);
> 
> 	devlink_register(devlink);
>+	dyn_port->attached = true;
> 
> 	return 0;
> 
>@@ -189,6 +190,8 @@ static void ice_sf_dev_remove(struct auxiliary_device *adev)
> 	devl_unlock(devlink);
> 	devlink_free(devlink);
> 	ice_vsi_decfg(vsi);
>+
>+	dyn_port->attached = false;
> }
> 
> static const struct auxiliary_device_id ice_sf_dev_id_table[] = {
>@@ -205,6 +208,8 @@ static struct auxiliary_driver ice_sf_driver = {
> 	.id_table = ice_sf_dev_id_table
> };
> 
>+static DEFINE_XARRAY_ALLOC1(ice_sf_aux_id);
>+
> /**
>  * ice_sf_driver_register - Register new auxiliary subfunction driver
>  *
>@@ -223,3 +228,101 @@ void ice_sf_driver_unregister(void)
> {
> 	auxiliary_driver_unregister(&ice_sf_driver);
> }
>+
>+/**
>+ * ice_sf_dev_release - Release device associated with auxiliary device
>+ * @device: pointer to the device
>+ *
>+ * Since most of the code for subfunction deactivation is handled in
>+ * the remove handler, here just free tracking resources.
>+ */
>+static void ice_sf_dev_release(struct device *device)
>+{
>+	struct auxiliary_device *adev = to_auxiliary_dev(device);
>+	struct ice_sf_dev *sf_dev = ice_adev_to_sf_dev(adev);
>+
>+	xa_erase(&ice_sf_aux_id, adev->id);
>+	kfree(sf_dev);
>+}
>+
>+/**
>+ * ice_sf_eth_activate - Activate Ethernet subfunction port
>+ * @dyn_port: the dynamic port instance for this subfunction
>+ * @extack: extack for reporting error messages
>+ *
>+ * Activate the dynamic port as an Ethernet subfunction. Setup the netdev
>+ * resources associated and initialize the auxiliary device.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+int
>+ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
>+		    struct netlink_ext_ack *extack)
>+{
>+	struct ice_pf *pf = dyn_port->pf;
>+	struct ice_sf_dev *sf_dev;
>+	struct pci_dev *pdev;
>+	int err;
>+	u32 id;
>+
>+	err = xa_alloc(&ice_sf_aux_id, &id, NULL, xa_limit_32b,
>+		       GFP_KERNEL);
>+	if (err) {
>+		NL_SET_ERR_MSG_MOD(extack, "Could not allocate SF ID");
>+		return err;
>+	}
>+
>+	sf_dev = kzalloc(sizeof(*sf_dev), GFP_KERNEL);
>+	if (!sf_dev) {
>+		err = -ENOMEM;
>+		NL_SET_ERR_MSG_MOD(extack, "Could not allocate SF memory");
>+		goto xa_erase;
>+	}
>+	pdev = pf->pdev;
>+
>+	sf_dev->dyn_port = dyn_port;
>+	sf_dev->adev.id = id;
>+	sf_dev->adev.name = "sf";
>+	sf_dev->adev.dev.release = ice_sf_dev_release;
>+	sf_dev->adev.dev.parent = &pdev->dev;
>+
>+	err = auxiliary_device_init(&sf_dev->adev);
>+	if (err) {
>+		NL_SET_ERR_MSG_MOD(extack, "Failed to initialize SF device");
>+		goto sf_dev_free;
>+	}
>+
>+	err = auxiliary_device_add(&sf_dev->adev);
>+	if (err) {
>+		NL_SET_ERR_MSG_MOD(extack, "Failed to add SF device");
>+		goto aux_dev_uninit;
>+	}
>+
>+	dyn_port->sf_dev = sf_dev;
>+
>+	return 0;
>+
>+aux_dev_uninit:
>+	auxiliary_device_uninit(&sf_dev->adev);
>+sf_dev_free:
>+	kfree(sf_dev);
>+xa_erase:
>+	xa_erase(&ice_sf_aux_id, id);
>+
>+	return err;
>+}
>+
>+/**
>+ * ice_sf_eth_deactivate - Deactivate Ethernet subfunction port
>+ * @dyn_port: the dynamic port instance for this subfunction
>+ *
>+ * Deactivate the Ethernet subfunction, removing its auxiliary device and the
>+ * associated resources.
>+ */
>+void ice_sf_eth_deactivate(struct ice_dynamic_port *dyn_port)
>+{
>+	struct ice_sf_dev *sf_dev = dyn_port->sf_dev;
>+
>+	auxiliary_device_delete(&sf_dev->adev);
>+	auxiliary_device_uninit(&sf_dev->adev);
>+}
>diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.h b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
>index e972c50f96c9..c558cad0a183 100644
>--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.h
>+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
>@@ -27,4 +27,7 @@ ice_sf_dev *ice_adev_to_sf_dev(struct auxiliary_device *adev)
> int ice_sf_driver_register(void);
> void ice_sf_driver_unregister(void);
> 
>+int ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
>+			struct netlink_ext_ack *extack);
>+void ice_sf_eth_deactivate(struct ice_dynamic_port *dyn_port);
> #endif /* _ICE_SF_ETH_H_ */
>-- 
>2.42.0
>
>

