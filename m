Return-Path: <netdev+bounces-165166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB50A30CA7
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3CE1883B07
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229241FDE35;
	Tue, 11 Feb 2025 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LWbRscGy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DC1EF096
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739279774; cv=none; b=mUnZl31ZkHJUrytYInahVuvXyxC+JQQl+qVFc8KGaxPXBOKZH57WAakVXx/jFpRkzOMlHuVXKpe06xoW5x/GfSCzQuvTiyTuCJuve9IvzNAEiYsUDo00AlH0MyOsAlhKLIbdU2PXB69hNwCuPrti9yDdEAhp4ijV8UqKbu3o4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739279774; c=relaxed/simple;
	bh=y/rExMQOGEoZymfux/d2NE2AYlmHCSC2cVRquEmjbw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p20DrBSnA+vjbb8KDsUWPSuGrx+IoZZrWtvoB38aHU08zAHbipNfxTdGd8UcB0sLVjWyry/1SBbDRllSVwsHaM9KdIQeTDDNye8ZQ/rSpuxtoDDy/v6aVnseIRXx+LVNkGObeXOmugF5CS4aSCDgcUj9aVCVlwVksPPE8fKLVH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LWbRscGy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38dc9f3cc80so1502936f8f.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 05:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739279769; x=1739884569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wEY5OY9mrcP1jwldrc805eQQ62d5L7xMicUn7siOwDY=;
        b=LWbRscGyqsMKvA3PtJsPZYnNEOnW3WjesAOPAGhA+sPfIgEVyjGDEwEmAP7UBeKsXf
         NWHRJd/L6RIPiFMahBSjt0VJp/kivRkJCxU7FjS80WTPY6iZFL3+brG2C31sNioGxC/z
         498OakRqGS1etdMmpl+qz9iowF9g7O12kQ0stH+or8g5eorJ/HpLY6fO19y9iNLBBJnr
         xMWhfWQ8Hk6MKv3fs5S+l37G6Ir0RcBDv/mbRFrPAD/Fup3Wynt7JSbXX6ggl70muuRu
         QMNNpjM2j9Kg3ZF7d7vVyKKsgmWrOvDgMNf7tNsVwE8qQ5FWt67188IUaWVdEwwF2Kj4
         herw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739279769; x=1739884569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEY5OY9mrcP1jwldrc805eQQ62d5L7xMicUn7siOwDY=;
        b=BluhDALL0aRDlao5BzwyVCzaMMun1CIKkWemWU3ydWWCY+08uLtgQS8mncHHWCZ97F
         pMFqjEy5O4OnJCc0oDA96cskmZyC3JvYe28Mxij6FgTEJcagLhPBCk6Jp6NzbahFFpKS
         35SeIp6O0r661f80gzVpLPLuYd+S1vIkBrf3O5l1Qbcddsqb0z9jOEyN1i90wkVllPN5
         8yF5tXkRBjKYy+iilSk7ybiiSx6VIkXNpiSELe6L2mD/PZ+XsF28X9xntdzMYZNDt1w4
         pAK2bzKaQ0m2F3Si55u3Klf/nHEEVrPOGstzrrPV6bZAl/mmBoIClwT8tHsjNChuuyeN
         Nzfg==
X-Forwarded-Encrypted: i=1; AJvYcCXCC4fb9ppFnFMX4/8FKwcSMSQIH42XeSlTdqpv2rJzVLxwWyZwNIvopxKyLkxidrHmwjmIwf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz30mUdSpuFJeEFGI5pUOh0itbOM/ucSR1LtlCo8lWgvsgkFu2z
	4jRHrQ5eMDZhurid7gmHAY5q6n4Zphz2KbqlLfL5PYoYNUnd7aTEmrDyCPUd384=
X-Gm-Gg: ASbGncv+6NZsMAFtQB+S/bjwUYuEYChxOBD7TEPQxJCS3c51P750DOFGf1D7wVK1CbZ
	QHu5HEIbrwZ70Y6hwuMbgozYfcaGW+vt7TW/6yfAObcML0POr8XqSCJMe25xk+WhP9USiWbJyUZ
	GLjvZfB1hqyOqyUeUTBWP+2WnlAQZVEGOSizexSZtkZP7FBtDGocbHLjpdGRbYdfE4uIW6tEtMx
	ItKwjiiOQ9UQXbWKD5uwSBw/HAdo2QGntPyeM1yDKqQVugsqRHLHzTuA92YXdTa+FqvKzJxMggy
	z3Svo1dDU5N3OGPCwg==
X-Google-Smtp-Source: AGHT+IF8PL3fWx2yVWPDDtC5Bo1rf0/Jdp8A66MC5YgPI0EVO+9rhP0lxP28PqP0YUOKrJTJDu9dGA==
X-Received: by 2002:a5d:6d81:0:b0:38d:c58f:4ce5 with SMTP id ffacd0b85a97d-38dc891f27bmr12358636f8f.0.1739279768445;
        Tue, 11 Feb 2025 05:16:08 -0800 (PST)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd530cce2sm8932186f8f.88.2025.02.11.05.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 05:16:07 -0800 (PST)
Date: Tue, 11 Feb 2025 14:15:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	Konrad Knitter <konrad.knitter@intel.com>, horms@kernel.org, Marcin Szycik <marcin.szycik@linux.intel.com>, 
	Sharon Haroni <sharon.haroni@intel.com>, Brett Creeley <bcreeley@amd.com>, 
	Rinitha S <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next v2 06/13] ice: add fw and port health reporters
Message-ID: <uhml4wrnlvms4ykas4tbi3dodm7h33glluog5kwjgp7qsbhoil@aeiuxo3unu4v>
References: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
 <20250115000844.714530-7-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115000844.714530-7-anthony.l.nguyen@intel.com>

Wed, Jan 15, 2025 at 01:08:32AM +0100, anthony.l.nguyen@intel.com wrote:
>From: Konrad Knitter <konrad.knitter@intel.com>
>
>Firmware generates events for global events or port specific events.
>
>Driver shall subscribe for health status events from firmware on supported
>FW versions >= 1.7.6.
>Driver shall expose those under specific health reporter, two new
>reporters are introduced:
>- FW health reporter shall represent global events (problems with the
>image, recovery mode);
>- Port health reporter shall represent port-specific events (module
>failure).
>
>Firmware only reports problems when those are detected, it does not store
>active fault list.
>Driver will hold only last global and last port-specific event.
>Driver will report all events via devlink health report,
>so in case of multiple events of the same source they can be reviewed
>using devlink autodump feature.
>
>$ devlink health
>
>pci/0000:b1:00.3:
>  reporter fw
>    state healthy error 0 recover 0 auto_dump true
>  reporter port

Why you add a "port" reporter, when we actually have per-port reporters
related to devlink port. For example in mlx5:
auxiliary/mlx5_core.eth.1/131071:
  reporter tx
    state healthy error 0 recover 0 grace_period 500 auto_recover true auto_dump true
  reporter rx
    state healthy error 0 recover 0 grace_period 500 auto_recover true auto_dump true


>    state error error 1 recover 0 last_dump_date 2024-03-17
>	last_dump_time 09:29:29 auto_dump true
>
>$ devlink health diagnose pci/0000:b1:00.3 reporter port
>
>  Syndrome: 262
>  Description: Module is not present.
>  Possible Solution: Check that the module is inserted correctly.
>  Port Number: 0

Ugh :/

Could you please convert?


>
>Tested on Intel Corporation Ethernet Controller E810-C for SFP
>
>Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>Co-developed-by: Sharon Haroni <sharon.haroni@intel.com>
>Signed-off-by: Sharon Haroni <sharon.haroni@intel.com>
>Co-developed-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
>Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
>Co-developed-by: Brett Creeley <brett.creeley@intel.com>
>Signed-off-by: Brett Creeley <brett.creeley@intel.com>
>Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
>Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
>Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>---
> .../net/ethernet/intel/ice/devlink/health.c   | 295 +++++++++++++++++-
> .../net/ethernet/intel/ice/devlink/health.h   |  15 +-
> .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  87 ++++++
> drivers/net/ethernet/intel/ice/ice_common.c   |  38 +++
> drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
> drivers/net/ethernet/intel/ice/ice_main.c     |   3 +
> drivers/net/ethernet/intel/ice/ice_type.h     |   5 +
> 7 files changed, 437 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
>index d23ae3aafaa7..ea40f7941259 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/health.c
>+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
>@@ -1,12 +1,270 @@
> // SPDX-License-Identifier: GPL-2.0
> /* Copyright (c) 2024, Intel Corporation. */
> 
>-#include "health.h"
> #include "ice.h"
>+#include "ice_adminq_cmd.h" /* for enum ice_aqc_health_status_elem */
>+#include "health.h"
> 
> #define ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, obj, name) \
> 	devlink_fmsg_put(fmsg, #name, (obj)->name)
> 
>+#define ICE_HEALTH_STATUS_DATA_SIZE 2
>+
>+struct ice_health_status {
>+	enum ice_aqc_health_status code;
>+	const char *description;
>+	const char *solution;
>+	const char *data_label[ICE_HEALTH_STATUS_DATA_SIZE];
>+};
>+
>+/*
>+ * In addition to the health status codes provided below, the firmware might
>+ * generate Health Status Codes that are not pertinent to the end-user.
>+ * For instance, Health Code 0x1002 is triggered when the command fails.
>+ * Such codes should be disregarded by the end-user.
>+ * The below lookup requires to be sorted by code.
>+ */
>+
>+static const char *const ice_common_port_solutions =
>+	"Check your cable connection. Change or replace the module or cable. Manually set speed and duplex.";
>+static const char *const ice_port_number_label = "Port Number";
>+static const char *const ice_update_nvm_solution = "Update to the latest NVM image.";
>+
>+static const struct ice_health_status ice_health_status_lookup[] = {
>+	{ICE_AQC_HEALTH_STATUS_ERR_UNKNOWN_MOD_STRICT, "An unsupported module was detected.",
>+		ice_common_port_solutions, {ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_MOD_TYPE, "Module type is not supported.",
>+		"Change or replace the module or cable.", {ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_MOD_QUAL, "Module is not qualified.",
>+		ice_common_port_solutions, {ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_MOD_COMM,
>+		"Device cannot communicate with the module.",
>+		"Check your cable connection. Change or replace the module or cable. Manually set speed and duplex.",
>+		{ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_MOD_CONFLICT, "Unresolved module conflict.",
>+		"Manually set speed/duplex or change the port option. If the problem persists, use a cable/module that is found in the supported modules and cables list for this device.",
>+		{ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_MOD_NOT_PRESENT, "Module is not present.",
>+		"Check that the module is inserted correctly. If the problem persists, use a cable/module that is found in the supported modules and cables list for this device.",
>+		{ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_INFO_MOD_UNDERUTILIZED, "Underutilized module.",
>+		"Change or replace the module or cable. Change the port option.",
>+		{ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_UNKNOWN_MOD_LENIENT, "An unsupported module was detected.",
>+		ice_common_port_solutions, {ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_INVALID_LINK_CFG, "Invalid link configuration.",
>+		NULL, {ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_PORT_ACCESS, "Port hardware access error.",
>+		ice_update_nvm_solution, {ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_PORT_UNREACHABLE, "A port is unreachable.",
>+		"Change the port option. Update to the latest NVM image."},
>+	{ICE_AQC_HEALTH_STATUS_INFO_PORT_SPEED_MOD_LIMITED, "Port speed is limited due to module.",
>+		"Change the module or configure the port option to match the current module speed. Change the port option.",
>+		{ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_PARALLEL_FAULT,
>+		"All configured link modes were attempted but failed to establish link. The device will restart the process to establish link.",
>+		"Check link partner connection and configuration.",
>+		{ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_INFO_PORT_SPEED_PHY_LIMITED,
>+		"Port speed is limited by PHY capabilities.",
>+		"Change the module to align to port option.", {ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_NETLIST_TOPO, "LOM topology netlist is corrupted.",
>+		ice_update_nvm_solution, {ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_NETLIST, "Unrecoverable netlist error.",
>+		ice_update_nvm_solution, {ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_TOPO_CONFLICT, "Port topology conflict.",
>+		"Change the port option. Update to the latest NVM image."},
>+	{ICE_AQC_HEALTH_STATUS_ERR_LINK_HW_ACCESS, "Unrecoverable hardware access error.",
>+		ice_update_nvm_solution, {ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_LINK_RUNTIME, "Unrecoverable runtime error.",
>+		ice_update_nvm_solution, {ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_DNL_INIT, "Link management engine failed to initialize.",
>+		ice_update_nvm_solution, {ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_PHY_FW_LOAD,
>+		"Failed to load the firmware image in the external PHY.",
>+		ice_update_nvm_solution, {ice_port_number_label}},
>+	{ICE_AQC_HEALTH_STATUS_INFO_RECOVERY, "The device is in firmware recovery mode.",
>+		ice_update_nvm_solution, {"Extended Error"}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_FLASH_ACCESS, "The flash chip cannot be accessed.",
>+		"If issue persists, call customer support.", {"Access Type"}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_NVM_AUTH, "NVM authentication failed.",
>+		ice_update_nvm_solution},
>+	{ICE_AQC_HEALTH_STATUS_ERR_OROM_AUTH, "Option ROM authentication failed.",
>+		ice_update_nvm_solution},
>+	{ICE_AQC_HEALTH_STATUS_ERR_DDP_AUTH, "DDP package authentication failed.",
>+		"Update to latest base driver and DDP package."},
>+	{ICE_AQC_HEALTH_STATUS_ERR_NVM_COMPAT, "NVM image is incompatible.",
>+		ice_update_nvm_solution},
>+	{ICE_AQC_HEALTH_STATUS_ERR_OROM_COMPAT, "Option ROM is incompatible.",
>+		ice_update_nvm_solution, {"Expected PCI Device ID", "Expected Module ID"}},
>+	{ICE_AQC_HEALTH_STATUS_ERR_DCB_MIB,
>+		"Supplied MIB file is invalid. DCB reverted to default configuration.",
>+		"Disable FW-LLDP and check DCBx system configuration.",
>+		{ice_port_number_label, "MIB ID"}},
>+};
>+
>+static int ice_health_status_lookup_compare(const void *a, const void *b)
>+{
>+	return ((struct ice_health_status *)a)->code - ((struct ice_health_status *)b)->code;
>+}
>+
>+static const struct ice_health_status *ice_get_health_status(u16 code)
>+{
>+	struct ice_health_status key = { .code = code };
>+
>+	return bsearch(&key, ice_health_status_lookup, ARRAY_SIZE(ice_health_status_lookup),
>+		       sizeof(struct ice_health_status), ice_health_status_lookup_compare);
>+}
>+
>+static void ice_describe_status_code(struct devlink_fmsg *fmsg,
>+				     struct ice_aqc_health_status_elem *hse)
>+{
>+	static const char *const aux_label[] = { "Aux Data 1", "Aux Data 2" };
>+	const struct ice_health_status *health_code;
>+	u32 internal_data[2];
>+	u16 status_code;
>+
>+	status_code = le16_to_cpu(hse->health_status_code);
>+
>+	devlink_fmsg_put(fmsg, "Syndrome", status_code);
>+	if (status_code) {
>+		internal_data[0] = le32_to_cpu(hse->internal_data1);
>+		internal_data[1] = le32_to_cpu(hse->internal_data2);
>+
>+		health_code = ice_get_health_status(status_code);
>+		if (!health_code)
>+			return;
>+
>+		devlink_fmsg_string_pair_put(fmsg, "Description", health_code->description);
>+		if (health_code->solution)
>+			devlink_fmsg_string_pair_put(fmsg, "Possible Solution",
>+						     health_code->solution);
>+
>+		for (size_t i = 0; i < ICE_HEALTH_STATUS_DATA_SIZE; i++) {
>+			if (internal_data[i] != ICE_AQC_HEALTH_STATUS_UNDEFINED_DATA)
>+				devlink_fmsg_u32_pair_put(fmsg,
>+							  health_code->data_label[i] ?
>+							  health_code->data_label[i] :
>+							  aux_label[i],
>+							  internal_data[i]);
>+		}
>+	}
>+}
>+
>+static int
>+ice_port_reporter_diagnose(struct devlink_health_reporter *reporter, struct devlink_fmsg *fmsg,
>+			   struct netlink_ext_ack *extack)
>+{
>+	struct ice_pf *pf = devlink_health_reporter_priv(reporter);
>+
>+	ice_describe_status_code(fmsg, &pf->health_reporters.port_status);
>+	return 0;
>+}
>+
>+static int
>+ice_port_reporter_dump(struct devlink_health_reporter *reporter, struct devlink_fmsg *fmsg,
>+		       void *priv_ctx, struct netlink_ext_ack __always_unused *extack)
>+{
>+	struct ice_pf *pf = devlink_health_reporter_priv(reporter);
>+
>+	ice_describe_status_code(fmsg, &pf->health_reporters.port_status);
>+	return 0;
>+}
>+
>+static int
>+ice_fw_reporter_diagnose(struct devlink_health_reporter *reporter, struct devlink_fmsg *fmsg,
>+			 struct netlink_ext_ack *extack)
>+{
>+	struct ice_pf *pf = devlink_health_reporter_priv(reporter);
>+
>+	ice_describe_status_code(fmsg, &pf->health_reporters.fw_status);
>+	return 0;
>+}
>+
>+static int
>+ice_fw_reporter_dump(struct devlink_health_reporter *reporter, struct devlink_fmsg *fmsg,
>+		     void *priv_ctx, struct netlink_ext_ack *extack)
>+{
>+	struct ice_pf *pf = devlink_health_reporter_priv(reporter);
>+
>+	ice_describe_status_code(fmsg, &pf->health_reporters.fw_status);
>+	return 0;
>+}
>+
>+static void ice_config_health_events(struct ice_pf *pf, bool enable)
>+{
>+	u8 enable_bits = 0;
>+	int ret;
>+
>+	if (enable)
>+		enable_bits = ICE_AQC_HEALTH_STATUS_SET_PF_SPECIFIC_MASK |
>+			      ICE_AQC_HEALTH_STATUS_SET_GLOBAL_MASK;
>+
>+	ret = ice_aq_set_health_status_cfg(&pf->hw, enable_bits);
>+	if (ret)
>+		dev_err(ice_pf_to_dev(pf), "Failed to %s firmware health events, err %d aq_err %s\n",
>+			str_enable_disable(enable), ret,
>+			ice_aq_str(pf->hw.adminq.sq_last_status));
>+}
>+
>+/**
>+ * ice_process_health_status_event - Process the health status event from FW
>+ * @pf: pointer to the PF structure
>+ * @event: event structure containing the Health Status Event opcode
>+ *
>+ * Decode the Health Status Events and print the associated messages
>+ */
>+void ice_process_health_status_event(struct ice_pf *pf, struct ice_rq_event_info *event)
>+{
>+	const struct ice_aqc_health_status_elem *health_info;
>+	u16 count;
>+
>+	health_info = (struct ice_aqc_health_status_elem *)event->msg_buf;
>+	count = le16_to_cpu(event->desc.params.get_health_status.health_status_count);
>+
>+	if (count > (event->buf_len / sizeof(*health_info))) {
>+		dev_err(ice_pf_to_dev(pf), "Received a health status event with invalid element count\n");
>+		return;
>+	}
>+
>+	for (size_t i = 0; i < count; i++) {
>+		const struct ice_health_status *health_code;
>+		u16 status_code;
>+
>+		status_code = le16_to_cpu(health_info->health_status_code);
>+		health_code = ice_get_health_status(status_code);
>+
>+		if (health_code) {
>+			switch (le16_to_cpu(health_info->event_source)) {
>+			case ICE_AQC_HEALTH_STATUS_GLOBAL:
>+				pf->health_reporters.fw_status = *health_info;
>+				devlink_health_report(pf->health_reporters.fw,
>+						      "FW syndrome reported", NULL);
>+				break;
>+			case ICE_AQC_HEALTH_STATUS_PF:
>+			case ICE_AQC_HEALTH_STATUS_PORT:
>+				pf->health_reporters.port_status = *health_info;
>+				devlink_health_report(pf->health_reporters.port,
>+						      "Port syndrome reported", NULL);
>+				break;
>+			default:
>+				dev_err(ice_pf_to_dev(pf), "Health code with unknown source\n");
>+			}
>+		} else {
>+			u32 data1, data2;
>+			u16 source;
>+
>+			source = le16_to_cpu(health_info->event_source);
>+			data1 = le32_to_cpu(health_info->internal_data1);
>+			data2 = le32_to_cpu(health_info->internal_data2);
>+			dev_dbg(ice_pf_to_dev(pf),
>+				"Received internal health status code 0x%08x, source: 0x%08x, data1: 0x%08x, data2: 0x%08x",
>+				status_code, source, data1, data2);
>+		}
>+		health_info++;
>+	}
>+}
>+
> /**
>  * ice_devlink_health_report - boilerplate to call given @reporter
>  *
>@@ -203,14 +461,26 @@ ice_init_devlink_rep(struct ice_pf *pf,
> 	return rep;
> }
> 
>-#define ICE_DEFINE_HEALTH_REPORTER_OPS(_name) \
>-	static const struct devlink_health_reporter_ops ice_ ## _name ## _reporter_ops = { \
>+#define ICE_HEALTH_REPORTER_OPS_FIELD(_name, _field) \
>+	._field = ice_##_name##_reporter_##_field,
>+
>+#define ICE_DEFINE_HEALTH_REPORTER_OPS_1(_name, _field1) \
>+	static const struct devlink_health_reporter_ops ice_##_name##_reporter_ops = { \
> 	.name = #_name, \
>-	.dump = ice_ ## _name ## _reporter_dump, \
>-}
>+	ICE_HEALTH_REPORTER_OPS_FIELD(_name, _field1) \
>+	}
>+
>+#define ICE_DEFINE_HEALTH_REPORTER_OPS_2(_name, _field1, _field2) \
>+	static const struct devlink_health_reporter_ops ice_##_name##_reporter_ops = { \
>+	.name = #_name, \
>+	ICE_HEALTH_REPORTER_OPS_FIELD(_name, _field1) \
>+	ICE_HEALTH_REPORTER_OPS_FIELD(_name, _field2) \
>+	}
> 
>-ICE_DEFINE_HEALTH_REPORTER_OPS(mdd);
>-ICE_DEFINE_HEALTH_REPORTER_OPS(tx_hang);
>+ICE_DEFINE_HEALTH_REPORTER_OPS_1(mdd, dump);
>+ICE_DEFINE_HEALTH_REPORTER_OPS_1(tx_hang, dump);
>+ICE_DEFINE_HEALTH_REPORTER_OPS_2(fw, dump, diagnose);
>+ICE_DEFINE_HEALTH_REPORTER_OPS_2(port, dump, diagnose);
> 
> /**
>  * ice_health_init - allocate and init all ice devlink health reporters and
>@@ -224,6 +494,12 @@ void ice_health_init(struct ice_pf *pf)
> 
> 	reps->mdd = ice_init_devlink_rep(pf, &ice_mdd_reporter_ops);
> 	reps->tx_hang = ice_init_devlink_rep(pf, &ice_tx_hang_reporter_ops);
>+
>+	if (ice_is_fw_health_report_supported(&pf->hw)) {
>+		reps->fw = ice_init_devlink_rep(pf, &ice_fw_reporter_ops);
>+		reps->port = ice_init_devlink_rep(pf, &ice_port_reporter_ops);
>+		ice_config_health_events(pf, true);
>+	}
> }
> 
> /**
>@@ -246,6 +522,11 @@ void ice_health_deinit(struct ice_pf *pf)
> {
> 	ice_deinit_devl_reporter(pf->health_reporters.mdd);
> 	ice_deinit_devl_reporter(pf->health_reporters.tx_hang);
>+	if (ice_is_fw_health_report_supported(&pf->hw)) {
>+		ice_deinit_devl_reporter(pf->health_reporters.fw);
>+		ice_deinit_devl_reporter(pf->health_reporters.port);
>+		ice_config_health_events(pf, false);
>+	}
> }
> 
> static
>diff --git a/drivers/net/ethernet/intel/ice/devlink/health.h b/drivers/net/ethernet/intel/ice/devlink/health.h
>index 532277fc57d7..5edfc4d2adce 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/health.h
>+++ b/drivers/net/ethernet/intel/ice/devlink/health.h
>@@ -13,8 +13,10 @@
>  * devlink health mechanism for ice driver.
>  */
> 
>+struct ice_aqc_health_status_elem;
> struct ice_pf;
> struct ice_tx_ring;
>+struct ice_rq_event_info;
> 
> enum ice_mdd_src {
> 	ICE_MDD_SRC_TX_PQM,
>@@ -25,17 +27,23 @@ enum ice_mdd_src {
> 
> /**
>  * struct ice_health - stores ice devlink health reporters and accompanied data
>- * @tx_hang: devlink health reporter for tx_hang event
>+ * @fw: devlink health reporter for FW Health Status events
>  * @mdd: devlink health reporter for MDD detection event
>+ * @port: devlink health reporter for Port Health Status events
>+ * @tx_hang: devlink health reporter for tx_hang event
>  * @tx_hang_buf: pre-allocated place to put info for Tx hang reporter from
>  *               non-sleeping context
>  * @tx_ring: ring that the hang occurred on
>  * @head: descriptor head
>  * @intr: interrupt register value
>  * @vsi_num: VSI owning the queue that the hang occurred on
>+ * @fw_status: buffer for last received FW Status event
>+ * @port_status: buffer for last received Port Status event
>  */
> struct ice_health {
>+	struct devlink_health_reporter *fw;
> 	struct devlink_health_reporter *mdd;
>+	struct devlink_health_reporter *port;
> 	struct devlink_health_reporter *tx_hang;
> 	struct_group_tagged(ice_health_tx_hang_buf, tx_hang_buf,
> 		struct ice_tx_ring *tx_ring;
>@@ -43,8 +51,13 @@ struct ice_health {
> 		u32 intr;
> 		u16 vsi_num;
> 	);
>+	struct ice_aqc_health_status_elem fw_status;
>+	struct ice_aqc_health_status_elem port_status;
> };
> 
>+void ice_process_health_status_event(struct ice_pf *pf,
>+				     struct ice_rq_event_info *event);
>+
> void ice_health_init(struct ice_pf *pf);
> void ice_health_deinit(struct ice_pf *pf);
> void ice_health_clear(struct ice_pf *pf);
>diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>index 73f5fddf3ee9..dd41a4dcc0b9 100644
>--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>@@ -2517,6 +2517,87 @@ enum ice_aqc_fw_logging_mod {
> 	ICE_AQC_FW_LOG_ID_MAX,
> };
> 
>+enum ice_aqc_health_status_mask {
>+	ICE_AQC_HEALTH_STATUS_SET_PF_SPECIFIC_MASK = BIT(0),
>+	ICE_AQC_HEALTH_STATUS_SET_ALL_PF_MASK      = BIT(1),
>+	ICE_AQC_HEALTH_STATUS_SET_GLOBAL_MASK      = BIT(2),
>+};
>+
>+/* Set Health Status (direct 0xFF20) */
>+struct ice_aqc_set_health_status_cfg {
>+	u8 event_source;
>+	u8 reserved[15];
>+};
>+
>+enum ice_aqc_health_status {
>+	ICE_AQC_HEALTH_STATUS_ERR_UNKNOWN_MOD_STRICT		= 0x101,
>+	ICE_AQC_HEALTH_STATUS_ERR_MOD_TYPE			= 0x102,
>+	ICE_AQC_HEALTH_STATUS_ERR_MOD_QUAL			= 0x103,
>+	ICE_AQC_HEALTH_STATUS_ERR_MOD_COMM			= 0x104,
>+	ICE_AQC_HEALTH_STATUS_ERR_MOD_CONFLICT			= 0x105,
>+	ICE_AQC_HEALTH_STATUS_ERR_MOD_NOT_PRESENT		= 0x106,
>+	ICE_AQC_HEALTH_STATUS_INFO_MOD_UNDERUTILIZED		= 0x107,
>+	ICE_AQC_HEALTH_STATUS_ERR_UNKNOWN_MOD_LENIENT		= 0x108,
>+	ICE_AQC_HEALTH_STATUS_ERR_MOD_DIAGNOSTIC_FEATURE	= 0x109,
>+	ICE_AQC_HEALTH_STATUS_ERR_INVALID_LINK_CFG		= 0x10B,
>+	ICE_AQC_HEALTH_STATUS_ERR_PORT_ACCESS			= 0x10C,
>+	ICE_AQC_HEALTH_STATUS_ERR_PORT_UNREACHABLE		= 0x10D,
>+	ICE_AQC_HEALTH_STATUS_INFO_PORT_SPEED_MOD_LIMITED	= 0x10F,
>+	ICE_AQC_HEALTH_STATUS_ERR_PARALLEL_FAULT		= 0x110,
>+	ICE_AQC_HEALTH_STATUS_INFO_PORT_SPEED_PHY_LIMITED	= 0x111,
>+	ICE_AQC_HEALTH_STATUS_ERR_NETLIST_TOPO			= 0x112,
>+	ICE_AQC_HEALTH_STATUS_ERR_NETLIST			= 0x113,
>+	ICE_AQC_HEALTH_STATUS_ERR_TOPO_CONFLICT			= 0x114,
>+	ICE_AQC_HEALTH_STATUS_ERR_LINK_HW_ACCESS		= 0x115,
>+	ICE_AQC_HEALTH_STATUS_ERR_LINK_RUNTIME			= 0x116,
>+	ICE_AQC_HEALTH_STATUS_ERR_DNL_INIT			= 0x117,
>+	ICE_AQC_HEALTH_STATUS_ERR_PHY_NVM_PROG			= 0x120,
>+	ICE_AQC_HEALTH_STATUS_ERR_PHY_FW_LOAD			= 0x121,
>+	ICE_AQC_HEALTH_STATUS_INFO_RECOVERY			= 0x500,
>+	ICE_AQC_HEALTH_STATUS_ERR_FLASH_ACCESS			= 0x501,
>+	ICE_AQC_HEALTH_STATUS_ERR_NVM_AUTH			= 0x502,
>+	ICE_AQC_HEALTH_STATUS_ERR_OROM_AUTH			= 0x503,
>+	ICE_AQC_HEALTH_STATUS_ERR_DDP_AUTH			= 0x504,
>+	ICE_AQC_HEALTH_STATUS_ERR_NVM_COMPAT			= 0x505,
>+	ICE_AQC_HEALTH_STATUS_ERR_OROM_COMPAT			= 0x506,
>+	ICE_AQC_HEALTH_STATUS_ERR_NVM_SEC_VIOLATION		= 0x507,
>+	ICE_AQC_HEALTH_STATUS_ERR_OROM_SEC_VIOLATION		= 0x508,
>+	ICE_AQC_HEALTH_STATUS_ERR_DCB_MIB			= 0x509,
>+	ICE_AQC_HEALTH_STATUS_ERR_MNG_TIMEOUT			= 0x50A,
>+	ICE_AQC_HEALTH_STATUS_ERR_BMC_RESET			= 0x50B,
>+	ICE_AQC_HEALTH_STATUS_ERR_LAST_MNG_FAIL			= 0x50C,
>+	ICE_AQC_HEALTH_STATUS_ERR_RESOURCE_ALLOC_FAIL		= 0x50D,
>+	ICE_AQC_HEALTH_STATUS_ERR_FW_LOOP			= 0x1000,
>+	ICE_AQC_HEALTH_STATUS_ERR_FW_PFR_FAIL			= 0x1001,
>+	ICE_AQC_HEALTH_STATUS_ERR_LAST_FAIL_AQ			= 0x1002,
>+};
>+
>+/* Get Health Status (indirect 0xFF22) */
>+struct ice_aqc_get_health_status {
>+	__le16 health_status_count;
>+	u8 reserved[6];
>+	__le32 addr_high;
>+	__le32 addr_low;
>+};
>+
>+enum ice_aqc_health_status_scope {
>+	ICE_AQC_HEALTH_STATUS_PF	= 0x1,
>+	ICE_AQC_HEALTH_STATUS_PORT	= 0x2,
>+	ICE_AQC_HEALTH_STATUS_GLOBAL	= 0x3,
>+};
>+
>+#define ICE_AQC_HEALTH_STATUS_UNDEFINED_DATA	0xDEADBEEF
>+
>+/* Get Health Status event buffer entry (0xFF22),
>+ * repeated per reported health status.
>+ */
>+struct ice_aqc_health_status_elem {
>+	__le16 health_status_code;
>+	__le16 event_source;
>+	__le32 internal_data1;
>+	__le32 internal_data2;
>+};
>+
> /* Set FW Logging configuration (indirect 0xFF30)
>  * Register for FW Logging (indirect 0xFF31)
>  * Query FW Logging (indirect 0xFF32)
>@@ -2657,6 +2738,8 @@ struct ice_aq_desc {
> 		struct ice_aqc_get_link_status get_link_status;
> 		struct ice_aqc_event_lan_overflow lan_overflow;
> 		struct ice_aqc_get_link_topo get_link_topo;
>+		struct ice_aqc_set_health_status_cfg set_health_status_cfg;
>+		struct ice_aqc_get_health_status get_health_status;
> 		struct ice_aqc_dnl_call_command dnl_call;
> 		struct ice_aqc_i2c read_write_i2c;
> 		struct ice_aqc_read_i2c_resp read_i2c_resp;
>@@ -2859,6 +2942,10 @@ enum ice_adminq_opc {
> 	/* Standalone Commands/Events */
> 	ice_aqc_opc_event_lan_overflow			= 0x1001,
> 
>+	/* System Diagnostic commands */
>+	ice_aqc_opc_set_health_status_cfg		= 0xFF20,
>+	ice_aqc_opc_get_health_status			= 0xFF22,
>+
> 	/* FW Logging Commands */
> 	ice_aqc_opc_fw_logs_config			= 0xFF30,
> 	ice_aqc_opc_fw_logs_register			= 0xFF31,
>diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
>index 64871ecfe8ef..7af169466655 100644
>--- a/drivers/net/ethernet/intel/ice/ice_common.c
>+++ b/drivers/net/ethernet/intel/ice/ice_common.c
>@@ -5892,6 +5892,44 @@ bool ice_is_phy_caps_an_enabled(struct ice_aqc_get_phy_caps_data *caps)
> 	return false;
> }
> 
>+/**
>+ * ice_is_fw_health_report_supported - checks if firmware supports health events
>+ * @hw: pointer to the hardware structure
>+ *
>+ * Return: true if firmware supports health status reports,
>+ * false otherwise
>+ */
>+bool ice_is_fw_health_report_supported(struct ice_hw *hw)
>+{
>+	return ice_is_fw_api_min_ver(hw, ICE_FW_API_HEALTH_REPORT_MAJ,
>+				     ICE_FW_API_HEALTH_REPORT_MIN,
>+				     ICE_FW_API_HEALTH_REPORT_PATCH);
>+}
>+
>+/**
>+ * ice_aq_set_health_status_cfg - Configure FW health events
>+ * @hw: pointer to the HW struct
>+ * @event_source: type of diagnostic events to enable
>+ *
>+ * Configure the health status event types that the firmware will send to this
>+ * PF. The supported event types are: PF-specific, all PFs, and global.
>+ *
>+ * Return: 0 on success, negative error code otherwise.
>+ */
>+int ice_aq_set_health_status_cfg(struct ice_hw *hw, u8 event_source)
>+{
>+	struct ice_aqc_set_health_status_cfg *cmd;
>+	struct ice_aq_desc desc;
>+
>+	cmd = &desc.params.set_health_status_cfg;
>+
>+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_set_health_status_cfg);
>+
>+	cmd->event_source = event_source;
>+
>+	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
>+}
>+
> /**
>  * ice_aq_set_lldp_mib - Set the LLDP MIB
>  * @hw: pointer to the HW struct
>diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
>index d12424735686..0a35fcdc6eb5 100644
>--- a/drivers/net/ethernet/intel/ice/ice_common.h
>+++ b/drivers/net/ethernet/intel/ice/ice_common.h
>@@ -141,6 +141,8 @@ int
> ice_get_link_default_override(struct ice_link_default_override_tlv *ldo,
> 			      struct ice_port_info *pi);
> bool ice_is_phy_caps_an_enabled(struct ice_aqc_get_phy_caps_data *caps);
>+bool ice_is_fw_health_report_supported(struct ice_hw *hw);
>+int ice_aq_set_health_status_cfg(struct ice_hw *hw, u8 event_source);
> int ice_aq_get_phy_equalization(struct ice_hw *hw, u16 data_in, u16 op_code,
> 				u8 serdes_num, int *output);
> int
>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>index f63e485e65f6..749b5e29e83a 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -1567,6 +1567,9 @@ static int __ice_clean_ctrlq(struct ice_pf *pf, enum ice_ctl_q q_type)
> 		case ice_aqc_opc_lldp_set_mib_change:
> 			ice_dcb_process_lldp_set_mib_change(pf, &event);
> 			break;
>+		case ice_aqc_opc_get_health_status:
>+			ice_process_health_status_event(pf, &event);
>+			break;
> 		default:
> 			dev_dbg(dev, "%s Receive Queue unknown event 0x%04x ignored\n",
> 				qtype, opcode);
>diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
>index adb168860711..ae5a26ea0d03 100644
>--- a/drivers/net/ethernet/intel/ice/ice_type.h
>+++ b/drivers/net/ethernet/intel/ice/ice_type.h
>@@ -1216,4 +1216,9 @@ struct ice_aq_get_set_rss_lut_params {
> #define ICE_FW_API_REPORT_DFLT_CFG_MIN		7
> #define ICE_FW_API_REPORT_DFLT_CFG_PATCH	3
> 
>+/* AQ API version for Health Status support */
>+#define ICE_FW_API_HEALTH_REPORT_MAJ		1
>+#define ICE_FW_API_HEALTH_REPORT_MIN		7
>+#define ICE_FW_API_HEALTH_REPORT_PATCH		6
>+
> #endif /* _ICE_TYPE_H_ */
>-- 
>2.47.1
>
>

