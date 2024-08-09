Return-Path: <netdev+bounces-117169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9309B94CF52
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD36CB21D70
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78D218CBFA;
	Fri,  9 Aug 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XnKOUjq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D6415A86B
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202597; cv=none; b=K3tSFwIb5Lgl9ZUtSoNDV9JSMHBhAWFgcCvqgu4H8sT4h3rr/EkBstB56LfRr51kg0xr9LwfRZ0LEttvhKYq/Ptv6psaLfNptlEApdKbC48wshz66xbH8DHME3+QLK5wBcRgCEBlg2ON0PZsIDIGjVIsf8jSHoL1f8ASBiyRzLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202597; c=relaxed/simple;
	bh=dwT/N1+ege4r3isdmGZ0YRrqjMSTMUJqxLE1juptsxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbYX7F8MH58/jBqqR7rA69c/T9+hg1lflc35i9Mgvomzb44KA1+uxqillBZf7soEf+7hWg7Hz/vVikPpO8ZdS9KeKnX4m4kqw5pkv2GxHRKinxuBbJxp7KKYxcZIDXFZcaoDbgZVb0JufBDItYcDhbkko3grJNSb2essaXJ2bfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XnKOUjq5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5b5b67d0024so2225916a12.0
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 04:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723202594; x=1723807394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jqs3wXs1Z9yJZzCBe7zSUm9Khvj+BEMMZ+xivgid3GY=;
        b=XnKOUjq5fW3Qr3Qnj3Was62filrevGKUjxiO9SsAtyxpwxpV6UBv9WxlYkcuJzbwfW
         Phs5W+I82bqXHb38qin2q0/2woGfLq6qi3Mf6AVNMsCB7U8BBzgZqJAtCBXHTXMk8Z8u
         HBAhXh6pmA7RzGVB2LtVfBwidC/XBzjuJBzdXjp4OioMuNgWzJqRGhCikCTMNQIwODkH
         VOkjPYHsMo+U/o9JfP12KltypEk1eaQMHwerx4snJ1EEEori/yOupJR84ZixP/dqUvYp
         +NPmQJhn5STJ9y+FnLLs/EhbRfV1c2RmNBQtFIsRrxYOOxZ9BUe/ySa2Jk2PpKxFlrR3
         Qvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723202594; x=1723807394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jqs3wXs1Z9yJZzCBe7zSUm9Khvj+BEMMZ+xivgid3GY=;
        b=fEbRWWVyLmHueMSCvMrRfExi8t++F9p/GH2yTKLiOwTisS3j6biQf4AEEEhtCYqmli
         XCKQWrzrNEspByphhWoemK34baqEuCHRgXwHu+cx5VUsKECzL+/x98fy2RGYgglWgigU
         eIAF08dluqJf5pzZhu5JVq6mH6Xi8J9pTym1kjOjOBJ1VI6xIgBgic+DdzDyvAVSmxW3
         mDJ19GsxHJ+aeZhOsm9+CMTMo6OnuFfbp4hjW7kijkm8+z2ENwJ3khyJjI7PG9YVgxKM
         axcagU2pDLZQtoL2qciBYvpLIs1QuI6a1WGuak90v6pWgKtGwiFXvvcmR+VRWPIVHmjd
         JItA==
X-Forwarded-Encrypted: i=1; AJvYcCVQLebHrR3a1oP+eQrL+7/no5WzepRIZKfxNY1g6zsdDiLlv6MZkB5rrV5830XEvDi9EMBrEPZ9hlG8YKAR82t/CVhxQJpM
X-Gm-Message-State: AOJu0YxvDv96x0ULk4VikgjNjbeWJ8fjdPvHVM9XZvP61/QBaFMOfPI0
	tWU8rrtU46ImtSzx7GtDP4VZtJ+dxF7obMT9h/h3qKZwyqP55hv4XirQukH8Q0I=
X-Google-Smtp-Source: AGHT+IGxQmFR3g/kUcqufNSz0CoWrmDJEGC7NmxCYRe/u31pNTAJYkT5/TwCPMP0uFM9U+0AoLucJg==
X-Received: by 2002:a17:907:f786:b0:a7a:b4bd:d0eb with SMTP id a640c23a62f3a-a80aa5993c9mr98840266b.24.1723202593690;
        Fri, 09 Aug 2024 04:23:13 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc2asm832150266b.63.2024.08.09.04.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:23:13 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:23:12 +0200
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
Subject: Re: [PATCH net-next v3 06/15] ice: base subfunction aux driver
Message-ID: <ZrX8IDdyfCrXaDv0@nanopsycho.orion>
References: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
 <20240808173104.385094-7-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808173104.385094-7-anthony.l.nguyen@intel.com>

Thu, Aug 08, 2024 at 07:30:52PM CEST, anthony.l.nguyen@intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Implement subfunction driver. It is probe when subfunction port is
>activated.
>
>VSI is already created. During the probe VSI is being configured.
>MAC unicast and broadcast filter is added to allow traffic to pass.
>
>Store subfunction pointer in VSI struct. The same is done for VF
>pointer. Make union of subfunction and VF pointer as only one of them
>can be set with one VSI.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
>Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>---
> drivers/net/ethernet/intel/ice/Makefile       |   1 +
> .../ethernet/intel/ice/devlink/devlink_port.c |  41 ++++++
> .../ethernet/intel/ice/devlink/devlink_port.h |   3 +
> drivers/net/ethernet/intel/ice/ice.h          |   7 +-
> drivers/net/ethernet/intel/ice/ice_main.c     |  10 ++
> drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 139 ++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  15 ++
> 7 files changed, 215 insertions(+), 1 deletion(-)
> create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
>
>diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
>index 03500e28ac99..4d987f5dcdc1 100644
>--- a/drivers/net/ethernet/intel/ice/Makefile
>+++ b/drivers/net/ethernet/intel/ice/Makefile
>@@ -31,6 +31,7 @@ ice-y := ice_main.o	\
> 	 ice_idc.o	\
> 	 devlink/devlink.o	\
> 	 devlink/devlink_port.o \
>+	 ice_sf_eth.o	\
> 	 ice_ddp.o	\
> 	 ice_fw_update.o \
> 	 ice_lag.o	\
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>index 5d1fe08e4bab..f06baabd0112 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>@@ -489,6 +489,47 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
> 	devl_port_unregister(&vf->devlink_port);
> }
> 
>+/**
>+ * ice_devlink_create_sf_dev_port - Register virtual port for a subfunction
>+ * @sf_dev: the subfunction device to create a devlink port for
>+ *
>+ * Register virtual flavour devlink port for the subfunction auxiliary device
>+ * created after activating a dynamically added devlink port.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev)
>+{
>+	struct devlink_port_attrs attrs = {};
>+	struct ice_dynamic_port *dyn_port;
>+	struct devlink_port *devlink_port;
>+	struct devlink *devlink;
>+	struct ice_vsi *vsi;
>+
>+	dyn_port = sf_dev->dyn_port;
>+	vsi = dyn_port->vsi;
>+
>+	devlink_port = &sf_dev->priv->devlink_port;
>+
>+	attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
>+
>+	devlink_port_attrs_set(devlink_port, &attrs);
>+	devlink = priv_to_devlink(sf_dev->priv);
>+
>+	return devl_port_register(devlink, devlink_port, vsi->idx);
>+}
>+
>+/**
>+ * ice_devlink_destroy_sf_dev_port - Destroy virtual port for a subfunction
>+ * @sf_dev: the subfunction device to create a devlink port for
>+ *
>+ * Unregisters the virtual port associated with this subfunction.
>+ */
>+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
>+{
>+	devl_port_unregister(&sf_dev->priv->devlink_port);
>+}
>+
> /**
>  * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
>  * @dyn_port: dynamic port instance to deallocate
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>index 08ebf56664a5..97b21b58c300 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>@@ -5,6 +5,7 @@
> #define _DEVLINK_PORT_H_
> 
> #include "../ice.h"
>+#include "../ice_sf_eth.h"
> 
> /**
>  * struct ice_dynamic_port - Track dynamically added devlink port instance
>@@ -34,6 +35,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf);
> void ice_devlink_destroy_vf_port(struct ice_vf *vf);
> int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port);
> void ice_devlink_destroy_sf_port(struct ice_dynamic_port *dyn_port);
>+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev);
>+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev);
> 
> #define ice_devlink_port_to_dyn(port) \
> 	container_of(port, struct ice_dynamic_port, devlink_port)
>diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>index d61f8e602cac..0046684004ff 100644
>--- a/drivers/net/ethernet/intel/ice/ice.h
>+++ b/drivers/net/ethernet/intel/ice/ice.h
>@@ -449,7 +449,12 @@ struct ice_vsi {
> 	struct_group_tagged(ice_vsi_cfg_params, params,
> 		struct ice_port_info *port_info; /* back pointer to port_info */
> 		struct ice_channel *ch; /* VSI's channel structure, may be NULL */
>-		struct ice_vf *vf; /* VF associated with this VSI, may be NULL */
>+		union {
>+			/* VF associated with this VSI, may be NULL */
>+			struct ice_vf *vf;
>+			/* SF associated with this VSI, may be NULL */
>+			struct ice_dynamic_port *sf;
>+		};
> 		u32 flags; /* VSI flags used for rebuild and configuration */
> 		enum ice_vsi_type type; /* the type of the VSI */
> 	);
>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>index e10f10a21c95..bdd88617ec9b 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -15,6 +15,7 @@
> #include "ice_dcb_nl.h"
> #include "devlink/devlink.h"
> #include "devlink/devlink_port.h"
>+#include "ice_sf_eth.h"
> #include "ice_hwmon.h"
> /* Including ice_trace.h with CREATE_TRACE_POINTS defined will generate the
>  * ice tracepoint functions. This must be done exactly once across the
>@@ -5908,8 +5909,16 @@ static int __init ice_module_init(void)
> 		goto err_dest_lag_wq;
> 	}
> 
>+	status = ice_sf_driver_register();
>+	if (status) {
>+		pr_err("Failed to register SF driver, err %d\n", status);
>+		goto err_sf_driver;
>+	}
>+
> 	return 0;
> 
>+err_sf_driver:
>+	pci_unregister_driver(&ice_driver);
> err_dest_lag_wq:
> 	destroy_workqueue(ice_lag_wq);
> 	ice_debugfs_exit();
>@@ -5927,6 +5936,7 @@ module_init(ice_module_init);
>  */
> static void __exit ice_module_exit(void)
> {
>+	ice_sf_driver_unregister();
> 	pci_unregister_driver(&ice_driver);
> 	ice_debugfs_exit();
> 	destroy_workqueue(ice_wq);
>diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>new file mode 100644
>index 000000000000..abe495c2d033
>--- /dev/null
>+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
>@@ -0,0 +1,139 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/* Copyright (c) 2024, Intel Corporation. */
>+#include "ice.h"
>+#include "ice_lib.h"
>+#include "ice_fltr.h"
>+#include "ice_sf_eth.h"
>+#include "devlink/devlink_port.h"
>+#include "devlink/devlink.h"
>+
>+/**
>+ * ice_sf_dev_probe - subfunction driver probe function
>+ * @adev: pointer to the auxiliary device
>+ * @id: pointer to the auxiliary_device id
>+ *
>+ * Configure VSI and netdev resources for the subfunction device.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int ice_sf_dev_probe(struct auxiliary_device *adev,
>+			    const struct auxiliary_device_id *id)
>+{
>+	struct ice_sf_dev *sf_dev = ice_adev_to_sf_dev(adev);
>+	struct ice_dynamic_port *dyn_port = sf_dev->dyn_port;
>+	struct ice_vsi *vsi = dyn_port->vsi;
>+	struct ice_pf *pf = dyn_port->pf;
>+	struct device *dev = &adev->dev;
>+	struct ice_sf_priv *priv;
>+	struct devlink *devlink;
>+	int err;
>+
>+	vsi->type = ICE_VSI_SF;
>+	vsi->port_info = pf->hw.port_info;
>+	vsi->flags = ICE_VSI_FLAG_INIT;
>+
>+	priv = ice_allocate_sf(&adev->dev, pf);
>+	if (!priv) {
>+		dev_err(dev, "Subfunction devlink alloc failed");
>+		return -ENOMEM;
>+	}
>+
>+	priv->dev = sf_dev;
>+	sf_dev->priv = priv;
>+	devlink = priv_to_devlink(priv);
>+
>+	devl_lock(devlink);
>+
>+	err = ice_vsi_cfg(vsi);
>+	if (err) {
>+		dev_err(dev, "Subfunction vsi config failed");
>+		goto err_free_devlink;
>+	}
>+	vsi->sf = dyn_port;
>+
>+	err = ice_devlink_create_sf_dev_port(sf_dev);
>+	if (err) {
>+		dev_err(dev, "Cannot add ice virtual devlink port for subfunction");
>+		goto err_vsi_decfg;
>+	}
>+
>+	err = devl_port_fn_devlink_set(&dyn_port->devlink_port, devlink);
>+	if (err) {
>+		dev_err(dev, "Can't link devlink instance to SF devlink port");
>+		goto err_devlink_destroy;
>+	}
>+
>+	ice_napi_add(vsi);
>+	devl_unlock(devlink);
>+
>+	devlink_register(devlink);

Use devl_register() and do it before you call devl_unlock() :)

>+
>+	return 0;
>+
>+err_devlink_destroy:
>+	ice_devlink_destroy_sf_dev_port(sf_dev);
>+err_vsi_decfg:
>+	ice_vsi_decfg(vsi);
>+err_free_devlink:
>+	devl_unlock(devlink);
>+	devlink_free(devlink);
>+	return err;
>+}
>+
>+/**
>+ * ice_sf_dev_remove - subfunction driver remove function
>+ * @adev: pointer to the auxiliary device
>+ *
>+ * Deinitalize VSI and netdev resources for the subfunction device.
>+ */
>+static void ice_sf_dev_remove(struct auxiliary_device *adev)
>+{
>+	struct ice_sf_dev *sf_dev = ice_adev_to_sf_dev(adev);
>+	struct ice_dynamic_port *dyn_port = sf_dev->dyn_port;
>+	struct ice_vsi *vsi = dyn_port->vsi;
>+	struct devlink *devlink;
>+
>+	devlink = priv_to_devlink(sf_dev->priv);
>+	devl_lock(devlink);
>+
>+	ice_vsi_close(vsi);
>+
>+	ice_devlink_destroy_sf_dev_port(sf_dev);
>+	devl_unregister(devlink);

Interesting, you call devl_unregister() here...


>+	devl_unlock(devlink);
>+	devlink_free(devlink);
>+	ice_vsi_decfg(vsi);
>+}
>+
>+static const struct auxiliary_device_id ice_sf_dev_id_table[] = {
>+	{ .name = "ice.sf", },
>+	{ },
>+};
>+
>+MODULE_DEVICE_TABLE(auxiliary, ice_sf_dev_id_table);
>+
>+static struct auxiliary_driver ice_sf_driver = {
>+	.name = "sf",
>+	.probe = ice_sf_dev_probe,
>+	.remove = ice_sf_dev_remove,
>+	.id_table = ice_sf_dev_id_table
>+};
>+
>+/**
>+ * ice_sf_driver_register - Register new auxiliary subfunction driver
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+int ice_sf_driver_register(void)
>+{
>+	return auxiliary_driver_register(&ice_sf_driver);
>+}
>+
>+/**
>+ * ice_sf_driver_unregister - Unregister new auxiliary subfunction driver
>+ *
>+ */
>+void ice_sf_driver_unregister(void)
>+{
>+	auxiliary_driver_unregister(&ice_sf_driver);
>+}
>diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.h b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
>index 267da33a0135..e972c50f96c9 100644
>--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.h
>+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
>@@ -7,9 +7,24 @@
> #include <linux/auxiliary_bus.h>
> #include "ice.h"
> 
>+struct ice_sf_dev {
>+	struct auxiliary_device adev;
>+	struct ice_dynamic_port *dyn_port;
>+	struct ice_sf_priv *priv;
>+};
>+
> struct ice_sf_priv {
> 	struct ice_sf_dev *dev;
> 	struct devlink_port devlink_port;
> };
> 
>+static inline struct
>+ice_sf_dev *ice_adev_to_sf_dev(struct auxiliary_device *adev)
>+{
>+	return container_of(adev, struct ice_sf_dev, adev);
>+}
>+
>+int ice_sf_driver_register(void);
>+void ice_sf_driver_unregister(void);
>+
> #endif /* _ICE_SF_ETH_H_ */
>-- 
>2.42.0
>
>

