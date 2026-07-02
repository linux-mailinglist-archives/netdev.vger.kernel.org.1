Return-Path: <netdev+bounces-304056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0ZBnCY0tRmqjLAsAu9opvQ
	(envelope-from <netdev+bounces-304056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:21:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 848BE6F52CF
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:21:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gkr1a+0P;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304056-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304056-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EFF8300CFF8
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965B73EB7FE;
	Thu,  2 Jul 2026 09:11:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A433A7198
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:11:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983483; cv=none; b=kx74Qkk7J4K71JW4QpE4l8AixtC3Ff038HKMLGq5UkkHHeqMsJA0rhSsuM6N05bHQhoQUGa9ALXzmYRhAuuLoh12y1h+XXK10FpUorxIpF8mT8pbC1FHorHJI4/M8eEi3xWoUEfbAFb/XOwWRD4eiajy20ionr4Lonwbb/Ln5aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983483; c=relaxed/simple;
	bh=X4NRI/+xgba1G9Qv41gWPCixhfRMuTftj3BBEqxdgxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyfURRmCMC7UslJkBQrwgZGlicHdLZL328WdRdPtTAlCXvaHzPZjo293Ai0xVJ7bYIJMa+4FoEVL+kfPgxN1wQRlKhNcAXsRxj9LStaOPpNWQIoZRZ3LGmnynnn3vTXAreS87DFwoSvhfihSIBdqIjzD5netKMqCtIL1S0zk1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gkr1a+0P; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782983480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yJ2Z7U8rvXh6fwwfeyL6XzAys4L4vlGqjwQQMWZvJE=;
	b=gkr1a+0Pkgx5fKriAIerEpxcKdhAN7tQEkBVDkZ39VFTG5RNDo9xIotS8oUo+lZnn/gQI3
	LoQ2QbYBqWSYwLMJbbmfPKUfR1jC3kU8X0Mw9w7A5C4KiGovbz7B0yB+xnCBtRofzOObUJ
	MshZxOXQ/q9HcqnUQ5GFE8ssy8bCeo0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-Nays-Xx5MB-07lTPYXhXSg-1; Thu,
 02 Jul 2026 05:11:17 -0400
X-MC-Unique: Nays-Xx5MB-07lTPYXhXSg-1
X-Mimecast-MFC-AGG-ID: Nays-Xx5MB-07lTPYXhXSg_1782983475
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 418C51944D3B;
	Thu,  2 Jul 2026 09:11:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2373196B089;
	Thu,  2 Jul 2026 09:11:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: nikhil.rao@amd.com
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	brett.creeley@amd.com,
	eric.joyner@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v6 3/6] pds_core: add PLDM firmware update support via devlink flash
Date: Thu,  2 Jul 2026 11:11:00 +0200
Message-ID: <20260702091100.93838-1-pabeni@redhat.com>
In-Reply-To: <20260629230200.82092-4-nikhil.rao@amd.com>
References: <20260629230200.82092-4-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304056-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS(0.00)[m:nikhil.rao@amd.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 848BE6F52CF

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
pds_core: add PLDM firmware update support via devlink flash

Implements PLDM firmware update via devlink flash using the upstream
pldmfw API. Adds whole-package and per-component update paths, and
introduces a deferred-DMA list that releases buffers after timed-out
devcmds. A few questions inline.

> diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
> index b7fe9ad73349..c686f0bbbaeb 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.h
> +++ b/drivers/net/ethernet/amd/pds_core/core.h
> @@ -23,6 +23,14 @@
>  #define PDSC_SETUP_RECOVERY	false
>  #define PDSC_SETUP_INIT		true
>  
> +struct pdsc_deferred_dma {
> +	struct list_head list;
> +	dma_addr_t dma_addr;
> +	void *va;
> +	size_t size;
> +	enum dma_data_direction dir;
> +};
> +

[ ... ]

> diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
> index 5c0ca3d0b000..6082b28915db 100644
> --- a/drivers/net/ethernet/amd/pds_core/dev.c
> +++ b/drivers/net/ethernet/amd/pds_core/dev.c
> @@ -206,15 +206,53 @@ static int __pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
>  	else
>  		memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
>  
> +	if (err != -ETIMEDOUT && err != -EAGAIN)
> +		pdsc_deferred_dma_free(pdsc);
> +
>  	return err;
>  }

[High]
Can the deferred-DMA scheme actually guarantee that the device has
finished accessing the buffer before it is unmapped and freed?

The trigger for releasing a deferred entry is "the next devcmd returned
something other than -ETIMEDOUT/-EAGAIN", plus pdsc_remove() and
pdsc_reset_prepare(). None of these provide a hardware-level fence that
the previous in-flight DMA has drained. In the remove/reset paths the
free runs after pci_disable_device(), which clears bus-master but does
not synchronously drain pending transactions.

The DMA_FROM_DEVICE case in pdsc_get_component_info() is particularly
exposed because the buffer is plain kernel slab memory: a late device
write after kfree would corrupt unrelated allocations.

Also note that pdsc_send_package_data(), pdsc_get_component_info(), and
pdsc_flash_component_chunk() only defer on -EAGAIN/-ETIMEDOUT and
immediately unmap+kfree on any other error (-EIO, -ENXIO, ...). Is the
device guaranteed not to have started any DMA in those cases?

> +void pdsc_deferred_dma_add(struct pdsc *pdsc, struct pdsc_deferred_dma *entry,
> +			   dma_addr_t dma_addr, void *va, size_t size,
> +			   enum dma_data_direction dir)
> +{
> +	entry->dma_addr = dma_addr;
> +	entry->va = va;
> +	entry->size = size;
> +	entry->dir = dir;
> +
> +	spin_lock(&pdsc->deferred_dma_lock);
> +	list_add_tail(&entry->list, &pdsc->deferred_dma_list);
> +	spin_unlock(&pdsc->deferred_dma_lock);
> +}
> +
> +void pdsc_deferred_dma_free(struct pdsc *pdsc)
> +{
> +	struct pdsc_deferred_dma *entry, *tmp;
> +
> +	spin_lock(&pdsc->deferred_dma_lock);
> +	list_for_each_entry_safe(entry, tmp, &pdsc->deferred_dma_list, list) {
> +		dma_unmap_single(pdsc->dev, entry->dma_addr,
> +				 entry->size, entry->dir);
> +		kfree(entry->va);
> +		list_del(&entry->list);
> +		kfree(entry);
> +	}
> +	spin_unlock(&pdsc->deferred_dma_lock);
> +}

[Medium]
Is it intentional to hold deferred_dma_lock across dma_unmap_single()
and two kfree()s per entry? This runs from __pdsc_devcmd_locked() on
every successful devcmd while devcmd_lock is also held, and
dma_unmap_single() can trigger IOMMU IOTLB invalidations. Would
list_splice_init() under the lock followed by iteration on a detached
list scale better when many entries have accumulated?

[ ... ]

> diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
> index fa626719e68d..433b0a8df4c1 100644
> --- a/drivers/net/ethernet/amd/pds_core/fw.c
> +++ b/drivers/net/ethernet/amd/pds_core/fw.c

[ ... ]

> +#define PDSC_FW_COMPONENT_PREFIX		"fw."
> +#define PDSC_FW_COMPONENT_FULL_NAME_BUFLEN \
> +	(sizeof(PDSC_FW_COMPONENT_PREFIX) + PDS_CORE_FW_COMPONENT_NAME_BUFLEN)
> +
> +/* Driver-defined component type to name mapping.
> + * PDS_CORE_FW_TYPE_MAIN is NULL - handled specially as "fw" without prefix.
> + */
> +static const char * const pdsc_fw_type_names[] = {
> +	[PDS_CORE_FW_TYPE_MAIN]      = NULL,
> +	[PDS_CORE_FW_TYPE_BOOT]      = "bootloader",
> +	[PDS_CORE_FW_TYPE_CPLD]      = "cpld",
> +	[PDS_CORE_FW_TYPE_SECURE]    = "secure",
> +	[PDS_CORE_FW_TYPE_FPGA]      = "fpga",
> +	[PDS_CORE_FW_TYPE_SUC_MAIN]  = "suc",
> +	[PDS_CORE_FW_TYPE_SUC_BOOT]  = "suc.bootloader",
> +	[PDS_CORE_FW_TYPE_UBOOT]     = "uboot",
> +};

[Low, Low]
The documentation table added in this same patch lists fw.gold as a
driver-defined component name, and the kerneldoc on
enum pds_core_fw_component_type says gold variants are "reported with
a .gold suffix (e.g., fw.gold)". The table above has no gold entry, so
pdsc_name_to_fw_type("fw.gold") returns 0 and pdsc_pldm_firmware_update()
rejects the request with -ENOENT. Should fw.gold either be wired up or
the docs clarify that gold is read-only?

PDSC_FW_COMPONENT_FULL_NAME_BUFLEN is defined here but never used;
pdsc_flash_component() uses an ad-hoc sizeof(PDSC_FW_COMPONENT_PREFIX) +
16 instead. Should this macro be wired up or dropped?

[ ... ]

> +int pdsc_get_component_info(struct pdsc *pdsc)
> +{
> +	union pds_core_dev_cmd cmd = {
> +		.get_component_info.opcode = PDS_CORE_CMD_GET_COMPONENT_INFO,
> +		.get_component_info.ver = 1,
> +	};

[ ... ]

> +	if (comp.get_component_info.ver == 0) {
> +		/* Don't support backward compatibility as version 0 has
> +		 * alignment issues, so give a hint to users to update
> +		 * their firmware
> +		 */
> +		dev_warn_once(pdsc->dev,
> +			      "Incompatible get_component_info version %u reported by firmware\n",
> +			      comp.get_component_info.ver);
> +		err = 0;
> +		goto out;
> +	}

[Low]
This branch returns 0 without populating pdsc->fw_components. The caller
pdsc_pldm_firmware_update() uses:

	if (!pdsc->fw_components.num_components) {
		err = pdsc_get_component_info(pdsc);
		if (err) { ... return err; }
	}

	if (params->component) {
		u8 type = pdsc_name_to_fw_type(params->component);

		if (!type || !pdsc_component_type_exists(pdsc, type))
			return -ENOENT;
	}

so on a device that reports ver == 0, the cache never populates and
every per-component flash returns -ENOENT. Should this branch return an
explicit error instead, or otherwise prevent the per-component lookup
from running?

[ ... ]

> +static int pdsc_devcmd_send_component(struct pdsc *pdsc,
> +				      struct pds_core_flash_component *info,
> +				      u16 info_sz, dma_addr_t addr, u32 length,
> +				      u32 offset, u16 slot_id,
> +				      union pds_core_dev_comp *comp)
> +{
> +	union pds_core_dev_cmd cmd = {
> +		.send_component.opcode = PDS_CORE_CMD_SEND_COMPONENT,
> +		.send_component.ver = 1,
> +		.send_component.operation = PDS_CORE_SEND_COMPONENT_START,
> +		.send_component.data_pa = cpu_to_le64(addr),
> +		.send_component.data_len = cpu_to_le32(length),
> +		.send_component.offset = cpu_to_le32(offset),
> +		.send_component.slot_id = slot_id,
> +	};
> +	unsigned long timeout = 300 * HZ;
> +	unsigned long start_time;
> +	unsigned long end_time;
> +	int err;
> +
> +	start_time = jiffies;
> +	end_time = start_time + timeout;
> +	do {
> +		/* prevent noisy/benign devcmd failures */
> +		err = pdsc_devcmd_with_data_nomsg(pdsc, &cmd, info, info_sz,
> +						  comp, 60);
> +		if (err != -EAGAIN)
> +			break;
> +
> +		/* if required, subsequent commands check status of
> +		 * PDS_CORE_CMD_SEND_COMPONENT command, which returns
> +		 * EAGAIN while the command is still running,
> +		 * else we get the final command status.
> +		 */
> +		cmd.send_component.operation = PDS_CORE_SEND_COMPONENT_STATUS;
> +		msleep(20);
> +	} while (time_before(jiffies, end_time));

[Low]
In the STATUS retry phase, only cmd.send_component.operation changes
between iterations; data_pa, data_len, offset, and slot_id remain set
to the original START values, and pdsc_devcmd_with_data_nomsg() also
re-issues memcpy_toio(&pdsc->cmd_regs->data, info, info_sz) on every
poll (potentially up to ~15000 iterations over the 300s timeout at 20ms
cadence). Does the firmware ignore data_pa/data_len on the STATUS
opcode, or could it re-initiate DMA from the same buffer? Could the
status poll send just the operation field?

[ ... ]

> +static int pdsc_finalize_update(struct pldmfw *context)
> +{
[ ... ]
> +	start_time = jiffies;
> +	end_time = start_time + (PDSC_FW_INSTALL_TIMEOUT * HZ);
> +	do {
> +		err = pdsc_devcmd_finalize_update(pdsc);
> +		if (!err || err != -EAGAIN)
> +			break;
> +
> +		dev_dbg(dev, "retrying finalize_update: %pe\n", ERR_PTR(err));
> +		msleep(20);
> +	} while (time_before(jiffies, end_time) && err == -EAGAIN);

[Low]
Is the !err in if (!err || err != -EAGAIN) intentional? err == 0 already
satisfies err != -EAGAIN, so the condition reduces to err != -EAGAIN.

[ ... ]

> +static int pdsc_pldm_firmware_update(struct pdsc *pdsc,
> +				     struct devlink_flash_update_params *params,
> +				     struct netlink_ext_ack *extack,
> +				     const struct firmware *fw)
> +{
> +	struct pds_core_fwu_priv priv = {};
> +	int err;
> +
> +	if (!pdsc->fw_components.num_components) {
> +		err = pdsc_get_component_info(pdsc);
> +		if (err) {
> +			dev_err(pdsc->dev,
> +				"Failed to get component info: %pe\n",
> +				ERR_PTR(err));
> +			return err;
> +		}
> +	}
> +
> +	if (params->component) {
> +		u8 type = pdsc_name_to_fw_type(params->component);
> +
> +		if (!type || !pdsc_component_type_exists(pdsc, type))
> +			return -ENOENT;
> +	}
> +
> +	INIT_LIST_HEAD(&priv.components);
> +	priv.context.ops = &pdsc_pldmfw_ops;
> +	priv.context.dev = pdsc->dev;
> +	priv.params = params;
> +	priv.pdsc = pdsc;
> +
> +	err = pldmfw_flash_image(&priv.context, fw);
> +	pdsc_free_fwu_priv(&priv);
> +
> +	return err;
> +}

[Medium]
The extack parameter is accepted here and struct pds_core_fwu_priv
declares a netlink_ext_ack *extack field, but priv.extack is never
assigned, and none of the PLDM callbacks (pdsc_match_record_descs,
pdsc_send_package_data, pdsc_send_component_table, pdsc_flash_component,
pdsc_finalize_update) call NL_SET_ERR_MSG_MOD(). The legacy path uses
extack at multiple call sites ("Firmware wait timed out", "Segment
download failed", ...). Was the intent to propagate extack diagnostics
on the PLDM path too, including for the -ENOENT returned above?

> +int pdsc_firmware_update(struct pdsc *pdsc,
> +			 struct devlink_flash_update_params *params,
> +			 struct netlink_ext_ack *extack)
> +{
> +	int err;
> +
> +	if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2 &&
> +	    pdsc->dev_ident.capabilities &
> +		cpu_to_le64(PDS_CORE_DEV_CAP_PLDM_FW_UPDATE))
> +		err = pdsc_pldm_firmware_update(pdsc, params, extack,
> +						params->fw);
> +	else
> +		err = pdsc_legacy_firmware_update(pdsc, params->fw, extack);
> +
> +	/* Invalidate cached component info so next info_get refreshes */
> +	pdsc->fw_components.num_components = 0;
> +
> +	return err;
> +}

[Medium]
What happens here when a user runs:

    devlink dev flash pci/0000:b5:00.0 file foo component fw.cpld

against a device that does not advertise PDS_CORE_DEV_CAP_PLDM_FW_UPDATE?
The dispatcher falls through to pdsc_legacy_firmware_update(pdsc,
params->fw, extack), which has no notion of components and proceeds to
flash the entire image.

The commit message says:

    Not all components support per-component update - devlink will
    reject the request if the specified component cannot be updated.

Should the dispatcher return -EOPNOTSUPP (or similar) when
params->component != NULL on the legacy path, to match that promise?

> diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
> index 619186f26b5b..5a1fafaccf20 100644
> --- a/include/linux/pds/pds_core_if.h
> +++ b/include/linux/pds/pds_core_if.h
> @@ -279,11 +299,20 @@ enum pds_core_fw_control_oper {
>  	PDS_CORE_FW_GET_LIST               = 7,
>  };
>  
> +/**
> + * enum pds_core_fw_slot - Firmware slot identifiers
> + * @PDS_CORE_FW_SLOT_INVALID: Let firmware select slot based on package metadata
> + * @PDS_CORE_FW_SLOT_A:       Primary firmware slot A
> + * @PDS_CORE_FW_SLOT_B:       Primary firmware slot B
> + * @PDS_CORE_FW_SLOT_GOLD:    Gold/recovery firmware slot
> + * @PDS_CORE_FW_SLOT_MAX:     Sentinel value indicating no slot resolved
> + */
>  enum pds_core_fw_slot {
>  	PDS_CORE_FW_SLOT_INVALID    = 0,
>  	PDS_CORE_FW_SLOT_A	    = 1,
>  	PDS_CORE_FW_SLOT_B          = 2,
>  	PDS_CORE_FW_SLOT_GOLD       = 3,
> +	PDS_CORE_FW_SLOT_MAX        = 0xff,
>  };

[Low]
PDS_CORE_FW_SLOT_MAX is added with value 0xff to this wire-protocol
enum but has no references anywhere. Should it be wired up to something
or dropped before the enum value is locked in by firmware?
-- 
This is an AI-generated review.


