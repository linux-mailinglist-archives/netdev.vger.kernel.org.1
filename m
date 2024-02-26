Return-Path: <netdev+bounces-74924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF098675F9
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 14:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4FE2871D8
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 13:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2800E7F7CA;
	Mon, 26 Feb 2024 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZSkJ6qNC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7504F888
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952773; cv=none; b=ebiiQOOP/Vf9jVUK5fAIRSek1ACZTeyhzGBJ9jvvkXFxzhgwADgTVdQmhCdRd7X29qk1pijLM7/J4UxIipHOth5QWaln1ZVL5uP7up71V5cp86pAiQOvariNsD9d2oIxIeSF3mC0VGHDdftnqJLVe6WJg22+AkC0JK+0L2YFOaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952773; c=relaxed/simple;
	bh=UTmyhbhs9g5cTN+8uvojzsECaO0Ei218yFGlhE7A+h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLhVmyCcfibeMtZutILEWPF3EO0NbC3YSKIYSdTT+Qw5NT+bxqn+EXMi+aEHTXCgYUTceTUVxIqkzGGmw6omlxCdfWHkCgjoKWoYSyg/E6CjScUN9+OSr7ijCm4zliwg1h9CVrkPneTmBdDDaHKrok/dcxjSxJYAph9c0G+v7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZSkJ6qNC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512bde3d197so2531166e87.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 05:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708952769; x=1709557569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YMKYVGv/KK/8pUrW3LcueP4DGGtQ42W7t5yap8esPqk=;
        b=ZSkJ6qNCemowAdilNclRViteTI/Xa5TXfjnN6QBe1ZgtdNW6SXNMwWkBsAOIAP2P6X
         muEVZbkgDTidJYd56ro+5BcLewMw9rz/1jKsVHabOEzZhhomWp9U25X769jiGCeAP/An
         BEo5+l61ROJeKB0KISQGb4zR9hzG2eIwiPPTBXvJatUzUSoEk843PUWYaCEXPVbX+fI3
         W06tm1tgEjZ3vgFN8iprvEcGAI0yYuurFq201AgzywAWqDCjUPfaJ6U7khlpkh33BVOX
         EwGdZ82yqmqIuAahU4R9xqgRm2Ov0CS/aw1pE6XnK8YU5jYNTKtYI+tvDThq+YvKjUDq
         bvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708952769; x=1709557569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMKYVGv/KK/8pUrW3LcueP4DGGtQ42W7t5yap8esPqk=;
        b=on0cLVRqlC3zVPiROMjvW8eVF56reW6oB+RVKS7w0zUexFb/dN2lt6WxzN4xt7bddf
         QsTyXABLc6tTrFSgPFOXqhGGx1yCnm7rsOaeb1kzOjuhLDv6ZS/yC4FKDfu9FFhPf4m2
         G8XI9XNcCOJDHv6jqOaFPWOAj0oXXmc/+PSBzDONhelgov/3gPjjffsy92zk3YGOwwEK
         hgZG/zOPVLcPrIKKlUyxFpQh5xwFcAENjKOxjdRz6zTenyEMLpGWA9FyaZ3tJNCg5KcC
         l2KvtHIeDAVZ+1UZRDD6268krO4DpOE+MuQRofOYiCWMYIHnks3m/eBwQJM+W7LSUwmf
         sz0g==
X-Forwarded-Encrypted: i=1; AJvYcCUhfCMgk6b3D/1U6LfyMUxWE1p1+Lc7pQhW4h/Fs84/+ETU8AHwOjTkRZQ1SGxTfgAqK+7RXric4/yMEs7aRM2XUvPiK14u
X-Gm-Message-State: AOJu0Yy2G0OyvPE1Dh5ueYMm6mf7MrfqVGK3AJyk8U4FAYPeivxP7wbg
	UJLv2qKhksxi6ivXqGwBlJoHGsv36qDnTBThXu4uGVAqkp4pU/u5KtQbXpIL6UY=
X-Google-Smtp-Source: AGHT+IEh1j4GhpFj6ma50tPv16zlacRXeVI800n1XbX+GISypzoq7k3CDPuftoc2e12u6UNrAZCvDw==
X-Received: by 2002:a05:6512:3ba6:b0:511:a477:64aa with SMTP id g38-20020a0565123ba600b00511a47764aamr5315148lfv.51.1708952768690;
        Mon, 26 Feb 2024 05:06:08 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id hi17-20020a05600c535100b0041290251dc2sm11713850wmb.14.2024.02.26.05.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 05:06:08 -0800 (PST)
Date: Mon, 26 Feb 2024 14:06:06 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pawel Kaminski <pawel.kaminski@intel.com>
Cc: intel-wired-lan@osuosl.org, netdev@vger.kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: Add support for
 devlink loopback param.
Message-ID: <ZdyMvu7HTFL8pRfi@nanopsycho>
References: <20231208004227.195801-1-pawel.kaminski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208004227.195801-1-pawel.kaminski@intel.com>

Fri, Dec 08, 2023 at 01:42:27AM CET, pawel.kaminski@intel.com wrote:
>Add support for driver-specific devlink loopback param. Supported values
>are "enabled", "disabled" and "prioritized". Default configuration is
>set to "enabled".
>
>Add documentation in networking/devlink/ice.rst.
>
>In previous generations of Intel NICs the trasmit scheduler was only
>limited by PCIe bandwidth when scheduling/assigning hairpin-badwidth
>between VFs. Changes to E810 HW design introduced scheduler limitation,
>so that available hairpin-bandwidth is bound to external port speed.
>In order to address this limitation and enable NFV services such as
>"service chaining" a knob to adjust the scheduler config was created.
>Driver can send a configuration message to the FW over admin queue and
>internal FW logic will reconfigure HW to prioritize and add more BW to
>VF to VF traffic. As end result for example 10G port will no longer limit
>hairpin-badwith to 10G and much higher speeds can be achieved.
>
>Devlink loopback param set to "prioritized" enables higher

What's the downside of having this always on?

How is this different to "enabled"? See more below.


>hairpin-badwitdh on related PFs. Configuration is applicable only to
>8x10G and 4x25G cards.
>
>Changing loopback configuration will trigger CORER reset in order to take
>effect.
>
>Example command to change current value:
>devlink dev param set pci/0000:b2:00.3 name loopback value prioritized \

The name is misleading (IIU what the know is about). Could you think
about naming it differently?


>        cmode runtime
>
>Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
>Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Pawel Kaminski <pawel.kaminski@intel.com>
>---
>Changes in v2:
> - improved commit message,
> - added documentation change
> - changed parameter devlink mode to "runtime"
> - Link to v1: https://lore.kernel.org/all/20231201235949.62728-1-pawel.kaminski@intel.com/
>---
> Documentation/networking/devlink/ice.rst      |  15 ++
> .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  11 +-
> drivers/net/ethernet/intel/ice/ice_common.c   |   6 +-
> drivers/net/ethernet/intel/ice/ice_devlink.c  | 128 +++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
> 5 files changed, 158 insertions(+), 3 deletions(-)
>
>diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
>index 7f30ebd5debb..efc6be109dc3 100644
>--- a/Documentation/networking/devlink/ice.rst
>+++ b/Documentation/networking/devlink/ice.rst
>@@ -11,6 +11,7 @@ Parameters
> ==========
> 
> .. list-table:: Generic parameters implemented
>+   :widths: 5 5 90
> 
>    * - Name
>      - Mode
>@@ -22,6 +23,20 @@ Parameters
>      - runtime
>      - mutually exclusive with ``enable_roce``
> 
>+.. list-table:: Driver specific parameters implemented
>+   :widths: 5 5 90
>+
>+   * - Name
>+     - Mode
>+     - Description
>+   * - ``loopback``
>+     - runtime
>+     - Controls loopback behavior by tuning scheduler bandwidth.
>+       Supported values are ``enabled``, ``disabled``, ``prioritized``.
>+       The latter allows for bandwidth higher than external port speed
>+       when looping back traffic between VFs. Works with 8x10G and 4x25G

Sorry, this is insufficient documentation. Does not tell me anything
about what the know is and how the values change the behaviour of that.



>+       cards.
>+
> Info versions
> =============
> 
>diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>index 6a5e974a1776..13d0e3cbc24c 100644
>--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>@@ -230,6 +230,13 @@ struct ice_aqc_get_sw_cfg_resp_elem {
> #define ICE_AQC_GET_SW_CONF_RESP_IS_VF		BIT(15)
> };
> 
>+/* Loopback port parameter mode values. */
>+enum ice_loopback_mode {
>+	ICE_LOOPBACK_MODE_ENABLED = 0,
>+	ICE_LOOPBACK_MODE_DISABLED = 1,
>+	ICE_LOOPBACK_MODE_PRIORITIZED = 2,
>+};
>+
> /* Set Port parameters, (direct, 0x0203) */
> struct ice_aqc_set_port_params {
> 	__le16 cmd_flags;
>@@ -238,7 +245,9 @@ struct ice_aqc_set_port_params {
> 	__le16 swid;
> #define ICE_AQC_PORT_SWID_VALID			BIT(15)
> #define ICE_AQC_PORT_SWID_M			0xFF
>-	u8 reserved[10];
>+	u8 loopback_mode;
>+#define ICE_AQC_SET_P_PARAMS_LOOPBACK_MODE_VALID BIT(2)
>+	u8 reserved[9];
> };
> 
> /* These resource type defines are used for all switch resource
>diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
>index 2f67ea1feb60..2efa781efcdb 100644
>--- a/drivers/net/ethernet/intel/ice/ice_common.c
>+++ b/drivers/net/ethernet/intel/ice/ice_common.c
>@@ -1019,7 +1019,7 @@ int ice_init_hw(struct ice_hw *hw)
> 		status = -ENOMEM;
> 		goto err_unroll_cqinit;
> 	}
>-
>+	hw->port_info->loopback_mode = ICE_LOOPBACK_MODE_ENABLED;
> 	/* set the back pointer to HW */
> 	hw->port_info->hw = hw;
> 
>@@ -2962,6 +2962,10 @@ ice_aq_set_port_params(struct ice_port_info *pi, bool double_vlan,
> 	cmd = &desc.params.set_port_params;
> 
> 	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_set_port_params);
>+
>+	cmd->loopback_mode = pi->loopback_mode |
>+				ICE_AQC_SET_P_PARAMS_LOOPBACK_MODE_VALID;
>+
> 	if (double_vlan)
> 		cmd_flags |= ICE_AQC_SET_P_PARAMS_DOUBLE_VLAN_ENA;
> 	cmd->cmd_flags = cpu_to_le16(cmd_flags);
>diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>index 65be56f2af9e..97182bacafa3 100644
>--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>@@ -1429,6 +1429,127 @@ ice_devlink_enable_iw_validate(struct devlink *devlink, u32 id,
> 	return 0;
> }
> 
>+#define DEVLINK_LPBK_DISABLED_STR "disabled"
>+#define DEVLINK_LPBK_ENABLED_STR "enabled"
>+#define DEVLINK_LPBK_PRIORITIZED_STR "prioritized"
>+
>+/**
>+ * ice_devlink_loopback_mode_to_str - Get string for loopback mode.
>+ * @mode: Loopback mode used in port_info struct.
>+ *
>+ * Return: Mode respective string or "Invalid".
>+ */
>+static const char *ice_devlink_loopback_mode_to_str(enum ice_loopback_mode mode)
>+{
>+	switch (mode) {
>+	case ICE_LOOPBACK_MODE_ENABLED:
>+		return DEVLINK_LPBK_ENABLED_STR;
>+	case ICE_LOOPBACK_MODE_PRIORITIZED:
>+		return DEVLINK_LPBK_PRIORITIZED_STR;
>+	case ICE_LOOPBACK_MODE_DISABLED:
>+		return DEVLINK_LPBK_DISABLED_STR;
>+	}
>+
>+	return "Invalid";
>+}
>+
>+/**
>+ * ice_devlink_loopback_str_to_mode - Get loopback mode from string name.
>+ * @mode_str: Loopback mode string.
>+ *
>+ * Return: Mode value or negative number if invalid.
>+ */
>+static int ice_devlink_loopback_str_to_mode(const char *mode_str)
>+{
>+	if (!strcmp(mode_str, DEVLINK_LPBK_ENABLED_STR))
>+		return ICE_LOOPBACK_MODE_ENABLED;
>+	else if (!strcmp(mode_str, DEVLINK_LPBK_PRIORITIZED_STR))
>+		return ICE_LOOPBACK_MODE_PRIORITIZED;
>+	else if (!strcmp(mode_str, DEVLINK_LPBK_DISABLED_STR))
>+		return ICE_LOOPBACK_MODE_DISABLED;
>+
>+	return -EINVAL;
>+}
>+
>+/**
>+ * ice_devlink_loopback_get - Get loopback parameter.
>+ * @devlink: Pointer to the devlink instance.
>+ * @id: The parameter ID to set.
>+ * @ctx: Context to store the parameter value.
>+ *
>+ * Return: Zero.
>+ */
>+static int ice_devlink_loopback_get(struct devlink *devlink, u32 id,
>+				    struct devlink_param_gset_ctx *ctx)
>+{
>+	struct ice_pf *pf = devlink_priv(devlink);
>+	struct ice_port_info *pi;
>+	const char *mode_str;
>+
>+	pi = pf->hw.port_info;
>+	mode_str = ice_devlink_loopback_mode_to_str(pi->loopback_mode);
>+	snprintf(ctx->val.vstr, sizeof(ctx->val.vstr), "%s", mode_str);
>+
>+	return 0;
>+}
>+
>+/**
>+ * ice_devlink_loopback_set - Set loopback parameter.
>+ * @devlink: Pointer to the devlink instance.
>+ * @id: The parameter ID to set.
>+ * @ctx: Context to get the parameter value.
>+ *
>+ * Return: Zero.
>+ */
>+static int ice_devlink_loopback_set(struct devlink *devlink, u32 id,
>+				    struct devlink_param_gset_ctx *ctx)
>+{
>+	int new_loopback_mode = ice_devlink_loopback_str_to_mode(ctx->val.vstr);
>+	struct ice_pf *pf = devlink_priv(devlink);
>+	struct device *dev = ice_pf_to_dev(pf);
>+	struct ice_port_info *pi;
>+
>+	pi = pf->hw.port_info;
>+	if (pi->loopback_mode != new_loopback_mode) {
>+		pi->loopback_mode = new_loopback_mode;
>+		dev_info(dev, "Setting loopback to %s\n", ctx->val.vstr);
>+		ice_schedule_reset(pf, ICE_RESET_CORER);
>+	}
>+
>+	return 0;
>+}
>+
>+/**
>+ * ice_devlink_loopback_validate - Validate passed loopback parameter value.
>+ * @devlink: Unused pointer to devlink instance.
>+ * @id: The parameter ID to validate.
>+ * @val: Value to validate.
>+ * @extack: Netlink extended ACK structure.
>+ *
>+ * Supported values are:
>+ * "enabled" - loopback is enabled, "disabled" - loopback is disabled
>+ * "prioritized" - loopback traffic is prioritized in scheduling.
>+ *
>+ * Return: Zero when passed parameter value is supported. Negative value on
>+ * error.
>+ */
>+static int ice_devlink_loopback_validate(struct devlink *devlink, u32 id,
>+					 union devlink_param_value val,
>+					 struct netlink_ext_ack *extack)
>+{
>+	if (ice_devlink_loopback_str_to_mode(val.vstr) < 0) {
>+		NL_SET_ERR_MSG_MOD(extack, "Error: Requested value is not supported.");
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
>+enum ice_param_id {
>+	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>+	ICE_DEVLINK_PARAM_ID_LOOPBACK,
>+};
>+
> static const struct devlink_param ice_devlink_params[] = {
> 	DEVLINK_PARAM_GENERIC(ENABLE_ROCE, BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> 			      ice_devlink_enable_roce_get,
>@@ -1438,7 +1559,12 @@ static const struct devlink_param ice_devlink_params[] = {
> 			      ice_devlink_enable_iw_get,
> 			      ice_devlink_enable_iw_set,
> 			      ice_devlink_enable_iw_validate),
>-
>+	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_LOOPBACK,
>+			     "loopback", DEVLINK_PARAM_TYPE_STRING,
>+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>+			     ice_devlink_loopback_get,
>+			     ice_devlink_loopback_set,
>+			     ice_devlink_loopback_validate),
> };
> 
> static void ice_devlink_free(void *devlink_ptr)
>diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
>index 1fff865d0661..c8d75a1820a1 100644
>--- a/drivers/net/ethernet/intel/ice/ice_type.h
>+++ b/drivers/net/ethernet/intel/ice/ice_type.h
>@@ -713,6 +713,7 @@ struct ice_port_info {
> 	u16 sw_id;			/* Initial switch ID belongs to port */
> 	u16 pf_vf_num;
> 	u8 port_state;
>+	u8 loopback_mode;
> #define ICE_SCHED_PORT_STATE_INIT	0x0
> #define ICE_SCHED_PORT_STATE_READY	0x1
> 	u8 lport;
>-- 
>2.41.0
>
>

