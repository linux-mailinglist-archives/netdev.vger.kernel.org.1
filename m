Return-Path: <netdev+bounces-90174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CAF8ACF4D
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 16:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9101F21492
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C898C1509BC;
	Mon, 22 Apr 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oj1LaLC/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62731509A1
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795961; cv=none; b=Abhl/PsbvN8gCEOJXhsgMmWxVzlsnCAAi5kFmZf9RH/cOXEJ9T4FJRh2hef1cwjVh7i0xF5wjIZ1nXNM+n5utxC4XUcrDQd+nPTaDrDEs9zx8cmC6dkumkG0Ma7cYTtr5YcZZoUrhs6U6ojoaA497uRFqS5A+6dOJDn/lh7lO4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795961; c=relaxed/simple;
	bh=pEs2DOgHbEnlmxgz0Kbt4d7wfqqZXgBiD+OP4Iao7aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy1B/V2F7hh3gt91yhmqeVMSnZC+sPfkdesaMztGom43FsZm1ltC7pKuUFrzi0Rozjqs74w79SKaPViyszbMBZDnI9syNP4PgReQCev0UZ7DPn/xT2QF/XYONEQSYWlECOtMX9gcaySvDAwrIpkG4jCV7mkOqM95LAnLXIAXmg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oj1LaLC/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a55b93f5540so118593566b.1
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713795958; x=1714400758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIINu9KyBDBX/cBbMG71Op3zuuN85u67R5eLl+Z8CAA=;
        b=oj1LaLC/0Npd+ApqHJ4eCRIQlx324izXZU+U/HcCvO3O4Fyt0BJVzdDMrrCfJYNPH8
         uVgCFBgiR2ZZ85IeIRHscqVuHWQxlhv3xNoH/WX2mrfJmR1D0tpU0GZT4Ti40bMTof4V
         fOwaQUgIy2DCfysV9V7mHVtGkuwuys7SRgCaGF0aLAs0snqJh/BacxWcbPg5JbiHGOfq
         nvOqchs7jbd9DbuSVBBrxfCvMrEwkt0AqtHyg8Ksj5IepclkJCZrO037boIBHkecPecN
         bDT6+1ab4ltyvIg3V6JRg+g97nWVquCJwU7HkQ6Y8Yv4iDNcwOdEE0+Ugj8ux4RAHnLl
         V/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713795958; x=1714400758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIINu9KyBDBX/cBbMG71Op3zuuN85u67R5eLl+Z8CAA=;
        b=w1yMyWKInnfANgY5T4tqq9eB3sfjr3QiZI4gCjYiLWawe4R+JqGEjWVmrqe2gKMGX3
         VepXboaPy7Mlj16lLJtU9r9h5Z9ML9IvJThMgbyVdPTuFjQj881Cw20eLVGW3r7MKZsM
         XxpUnmp192zU952JErUxnn5xZ3dqV4Ckw+ui4vX8TMVudvtZ7KJJk4FNxYUw5f8YwtPk
         I8ml3JodfA1/xjPBCgmEjT3Kaha9+DIokOFXvEftaNtT4/OGvVE/gv022pIvspJfUkSN
         N+X+srsZY2lb7TaXUiQbcs2l4k4dy3HsUhS9CgXJDiaWGIdEBOK2DimHVPVdW3xQAoqS
         Efqg==
X-Forwarded-Encrypted: i=1; AJvYcCXwcwu94IY6idz+B5tRs0+qQhZdrXl11Cvpy1s9/PNTYib1GBI1qA1s99Dj/iml0+yLVmQshUsA1V3qfSxr9ocfgqPqmyrt
X-Gm-Message-State: AOJu0YzjadM2QjxVniMnGpHl9QcG/5laVZI8B05+YKxboB4uhF5E/AK/
	P81WnegOnEYnmW6MSQMURnREyAT9PpQ9zMwEAlPOxIIjmun03wemFff2vNUb3pY=
X-Google-Smtp-Source: AGHT+IFh1b4YvcxkXn79fjVZAVGT+9/f6mdpQVJpiEwFbDvIxWmfO30Zx7tHQFeDivtwsDwo7il/6g==
X-Received: by 2002:a17:906:f1d6:b0:a55:5c04:89a4 with SMTP id gx22-20020a170906f1d600b00a555c0489a4mr6594385ejb.21.1713795958020;
        Mon, 22 Apr 2024 07:25:58 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id i22-20020a1709061cd600b00a55a10eb070sm2796438ejh.214.2024.04.22.07.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 07:25:57 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:25:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	horms@kernel.org, Carolyn Wyborny <carolyn.wyborny@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jan Glaza <jan.glaza@intel.com>
Subject: Re: [PATCH iwl-next v4 5/5] ixgbe: Enable link management in E610
 device
Message-ID: <ZiZzdAX-qI-7wCMC@nanopsycho>
References: <20240422130611.2544-1-piotr.kwapulinski@intel.com>
 <20240422130611.2544-6-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422130611.2544-6-piotr.kwapulinski@intel.com>

Mon, Apr 22, 2024 at 03:06:11PM CEST, piotr.kwapulinski@intel.com wrote:

[...]


>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>index 559b443..ea6df1e 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>@@ -1,5 +1,5 @@
> /* SPDX-License-Identifier: GPL-2.0 */
>-/* Copyright(c) 1999 - 2018 Intel Corporation. */
>+/* Copyright(c) 1999 - 2024 Intel Corporation. */
> 
> #ifndef _IXGBE_H_
> #define _IXGBE_H_
>@@ -20,6 +20,7 @@
> #include "ixgbe_type.h"
> #include "ixgbe_common.h"
> #include "ixgbe_dcb.h"
>+#include "ixgbe_e610.h"
> #if IS_ENABLED(CONFIG_FCOE)
> #define IXGBE_FCOE
> #include "ixgbe_fcoe.h"
>@@ -28,7 +29,6 @@
> #include <linux/dca.h>
> #endif
> #include "ixgbe_ipsec.h"
>-

Leftover hunk?


> #include <net/xdp.h>
> 
> /* common prefix used by pr_<> macros */

[...]


>+static const struct ixgbe_mac_operations mac_ops_e610 = {
>+	.init_hw			= ixgbe_init_hw_generic,
>+	.start_hw			= ixgbe_start_hw_X540,
>+	.clear_hw_cntrs			= ixgbe_clear_hw_cntrs_generic,
>+	.enable_rx_dma			= ixgbe_enable_rx_dma_generic,
>+	.get_mac_addr			= ixgbe_get_mac_addr_generic,
>+	.get_device_caps		= ixgbe_get_device_caps_generic,
>+	.stop_adapter			= ixgbe_stop_adapter_generic,
>+	.set_lan_id			= ixgbe_set_lan_id_multi_port_pcie,
>+	.read_analog_reg8		= NULL,

Pointless initialization, it's null already. You have many cases of
this below.



>+	.write_analog_reg8		= NULL,
>+	.set_rxpba			= ixgbe_set_rxpba_generic,
>+	.check_link			= ixgbe_check_link_e610,
>+	.blink_led_start		= ixgbe_blink_led_start_X540,
>+	.blink_led_stop			= ixgbe_blink_led_stop_X540,
>+	.set_rar			= ixgbe_set_rar_generic,
>+	.clear_rar			= ixgbe_clear_rar_generic,
>+	.set_vmdq			= ixgbe_set_vmdq_generic,
>+	.set_vmdq_san_mac		= ixgbe_set_vmdq_san_mac_generic,
>+	.clear_vmdq			= ixgbe_clear_vmdq_generic,
>+	.init_rx_addrs			= ixgbe_init_rx_addrs_generic,
>+	.update_mc_addr_list		= ixgbe_update_mc_addr_list_generic,
>+	.enable_mc			= ixgbe_enable_mc_generic,
>+	.disable_mc			= ixgbe_disable_mc_generic,
>+	.clear_vfta			= ixgbe_clear_vfta_generic,
>+	.set_vfta			= ixgbe_set_vfta_generic,
>+	.fc_enable			= ixgbe_fc_enable_generic,
>+	.set_fw_drv_ver			= ixgbe_set_fw_drv_ver_x550,
>+	.init_uta_tables		= ixgbe_init_uta_tables_generic,
>+	.set_mac_anti_spoofing		= ixgbe_set_mac_anti_spoofing,
>+	.set_vlan_anti_spoofing		= ixgbe_set_vlan_anti_spoofing,
>+	.set_source_address_pruning	=
>+				ixgbe_set_source_address_pruning_x550,
>+	.set_ethertype_anti_spoofing	=
>+				ixgbe_set_ethertype_anti_spoofing_x550,
>+	.disable_rx_buff		= ixgbe_disable_rx_buff_generic,
>+	.enable_rx_buff			= ixgbe_enable_rx_buff_generic,
>+	.get_thermal_sensor_data	= NULL,
>+	.init_thermal_sensor_thresh	= NULL,
>+	.fw_recovery_mode		= NULL,
>+	.enable_rx			= ixgbe_enable_rx_generic,
>+	.disable_rx			= ixgbe_disable_rx_e610,
>+	.led_on				= ixgbe_led_on_generic,
>+	.led_off			= ixgbe_led_off_generic,
>+	.init_led_link_act		= ixgbe_init_led_link_act_generic,
>+	.reset_hw			= ixgbe_reset_hw_e610,
>+	.get_media_type			= ixgbe_get_media_type_e610,
>+	.get_san_mac_addr		= NULL,
>+	.get_wwn_prefix			= NULL,
>+	.setup_link			= ixgbe_setup_link_e610,
>+	.get_link_capabilities		= ixgbe_get_link_capabilities_e610,
>+	.get_bus_info			= ixgbe_get_bus_info_generic,
>+	.setup_sfp			= NULL,
>+	.acquire_swfw_sync		= ixgbe_acquire_swfw_sync_X540,
>+	.release_swfw_sync		= ixgbe_release_swfw_sync_X540,
>+	.init_swfw_sync			= ixgbe_init_swfw_sync_X540,
>+	.prot_autoc_read		= prot_autoc_read_generic,
>+	.prot_autoc_write		= prot_autoc_write_generic,
>+	.setup_fc			= ixgbe_setup_fc_e610,
>+	.fc_autoneg			= ixgbe_fc_autoneg_e610,
>+};
>+
>+static const struct ixgbe_phy_operations phy_ops_e610 = {
>+	.init				= ixgbe_init_phy_ops_e610,
>+	.identify			= ixgbe_identify_phy_e610,
>+	.read_reg			= NULL,
>+	.write_reg			= NULL,
>+	.read_reg_mdi			= NULL,
>+	.write_reg_mdi			= NULL,
>+	.identify_sfp			= ixgbe_identify_module_e610,
>+	.reset				= NULL,
>+	.setup_link_speed		= ixgbe_setup_phy_link_speed_generic,
>+	.read_i2c_byte			= NULL,
>+	.write_i2c_byte			= NULL,
>+	.read_i2c_sff8472		= NULL,
>+	.read_i2c_eeprom		= NULL,
>+	.write_i2c_eeprom		= NULL,
>+	.setup_link			= ixgbe_setup_phy_link_e610,
>+	.set_phy_power			= NULL,
>+	.check_overtemp			= NULL,
>+	.enter_lplu			= ixgbe_enter_lplu_e610,
>+	.handle_lasi			= NULL,
>+	.read_i2c_byte_unlocked		= NULL,
>+};
>+
>+static const struct ixgbe_eeprom_operations eeprom_ops_e610 = {
>+	.init_params			= NULL,
>+	.read				= ixgbe_read_ee_aci_e610,
>+	.read_buffer			= NULL,
>+	.write				= NULL,
>+	.write_buffer			= NULL,
>+	.validate_checksum		= ixgbe_validate_eeprom_checksum_e610,
>+	.update_checksum		= NULL,
>+	.calc_checksum			= NULL,
>+};
>+

[...]


>+/**
>+ * ixgbe_process_link_status_event - process the link event
>+ * @adapter: pointer to adapter structure
>+ * @link_up: true if the physical link is up and false if it is down
>+ * @link_speed: current link speed received from the link event
>+ *
>+ * Return: 0 on success and negative on failure.
>+ */
>+static int
>+ixgbe_process_link_status_event(struct ixgbe_adapter *adapter, bool link_up,
>+				u16 link_speed)
>+{
>+	struct ixgbe_hw *hw = &adapter->hw;
>+	int status;
>+
>+	/* update the link info structures and re-enable link events,
>+	 * don't bail on failure due to other book keeping needed

Why don't you start the sentence with capital letter and end with "."?


>+	 */
>+	status = ixgbe_update_link_info(hw);
>+	if (status)
>+		e_dev_err("Failed to update link status, err %d aq_err %d\n",
>+			  status, hw->aci.last_status);
>+
>+	ixgbe_check_link_cfg_err(adapter, hw->link.link_info.link_cfg_err);
>+
>+	/* Check if the link state is up after updating link info, and treat
>+	 * this event as an UP event since the link is actually UP now.
>+	 */
>+	if (hw->link.link_info.link_info & IXGBE_ACI_LINK_UP)
>+		link_up = true;
>+
>+	/* turn off PHY if media was removed */
>+	if (!(adapter->flags2 & IXGBE_FLAG2_NO_MEDIA) &&
>+	    !(hw->link.link_info.link_info & IXGBE_ACI_MEDIA_AVAILABLE)) {
>+		(adapter->flags2 |= IXGBE_FLAG2_NO_MEDIA);
>+		if (ixgbe_aci_set_link_restart_an(hw, false))
>+			e_dev_err("can't set link to OFF\n");
>+	}

[...]

