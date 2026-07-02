Return-Path: <netdev+bounces-304057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g0GVCpstRmqtLAsAu9opvQ
	(envelope-from <netdev+bounces-304057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:21:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B56F52E4
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:21:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=jHsERTzY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304057-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304057-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 353D931A4040
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6CC478E36;
	Thu,  2 Jul 2026 09:11:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E9478841
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:11:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983494; cv=none; b=qt1ZlKq/aHyEbt71JNIWK0tK6CfaZCZWpNDOCAT138bBcygrXsoS52bdaK5dqUhFprE8DRYh3NtG6kiH3garRaGnFBCIQ2CiSf81u/li7e3Lfc99u7D5u95/ifAp8PMKMXX5cpSzxuizyz7+YwDuj+NnOygHx/ZHSzywg6wBZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983494; c=relaxed/simple;
	bh=o/h+mg2Duy32n+4QGruNE2U7l8UhfznOTh0ByXke1QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SU44Ewx7vJUzkGHjdZbavPGav9jeZWm8OdrgcHNNJTpdRs/hZt4gTGP4u7qCvm/2VUarwW1eRyyO6DyeXegme9fQ6xPCd/Bkev9uIcT5moiiHbDGV+bDCZZavETHRoRK+oK/5K1LMB9fM1khXh944qycmm8brRHP+lupvFGVo3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHsERTzY; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782983491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30lTtWVIJUksKJCsghpj1MpwBokQpFwmBLdFsfjlZR8=;
	b=jHsERTzYhTrTev3UETyyQpIiQ9wICZfFJ5xiZcQcETDMYZBUWfaaoG6TbTKJR39VN4FdAs
	asSMJCwlJc8jjfATdJnizh0dxvh3Xx4KrIhmxkwNvRAaAVPICXuZ9Mrykn2PNPGVFNqjrx
	WnPHz9w/FbMag2WnS0APjpv11BefKKc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-xeRp-O0oMVKsKnln4Pnt9w-1; Thu,
 02 Jul 2026 05:11:26 -0400
X-MC-Unique: xeRp-O0oMVKsKnln4Pnt9w-1
X-Mimecast-MFC-AGG-ID: xeRp-O0oMVKsKnln4Pnt9w_1782983484
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 905CB194511C;
	Thu,  2 Jul 2026 09:11:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.252])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 584B63189;
	Thu,  2 Jul 2026 09:11:21 +0000 (UTC)
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
Subject: Re: [PATCH net-next v6 4/6] pds_core: add PLDM component info display
Date: Thu,  2 Jul 2026 11:11:15 +0200
Message-ID: <20260702091115.93857-1-pabeni@redhat.com>
In-Reply-To: <20260629230200.82092-5-nikhil.rao@amd.com>
References: <20260629230200.82092-5-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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
	TAGGED_FROM(0.00)[bounces-304057-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url,vger.kernel.org:from_smtp,fw.gold:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A57B56F52E4

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
pds_core: add PLDM component info display

This change adds detailed PLDM component info to devlink info on
identity v2 devices, introduces a pdsc_fw_components_invalidate()
helper used during firmware recovery and after firmware update, and
maps PDS_CORE_FW_TYPE_MAIN to the generic "fw" name in the PLDM
flash path.

> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index 38a2446571af..4d9ab8b74ec6 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -580,6 +580,8 @@ void pdsc_fw_up(struct pdsc *pdsc)
>  		return;
>  	}
>  
> +	pdsc_fw_components_invalidate(pdsc);
> +
>  	err = pdsc_setup(pdsc, PDSC_SETUP_RECOVERY);
>  	if (err)
>  		goto err_out;

[Medium]
Can concurrent access to pdsc->fw_components race here?
pdsc_fw_up() runs from pdsc_health_thread (workqueue, holding only
pdsc->config_lock) and from pdsc_reset_done (PCI reset handler, holding
neither), so pdsc_fw_components_invalidate() writes num_components = 0
without the devlink instance lock.

Meanwhile, pdsc_dl_component_info_get() reads pdsc->fw_components from
the devlink info_get callback under only the devlink lock, never
config_lock. The two domains do not exclude each other.

In pdsc_dl_component_info_get():

	if (!pdsc->fw_components.num_components) {
		err = pdsc_get_component_info(pdsc);
		if (err || !pdsc->fw_components.num_components)
			return pdsc_dl_report_fw_ver(req,
						    pdsc->dev_info.fw_version);
	}

	list_info = &pdsc->fw_components;
	num_components = min_t(u16, list_info->num_components,
			       le16_to_cpu(pdsc->dev_ident.max_fw_slots));

The reader can observe num_components > 0 on the first load, then
re-read it inside min_t() and observe 0 after pdsc_fw_up() invalidates
the cache, producing zero iterations and no fallback. Conversely, a
stale non-zero count could be iterated over info[] entries describing
the previous firmware.

No READ_ONCE/WRITE_ONCE or memory barriers are used. Would a lock or
RCU be a better fit here?

> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
> index 3b763ee1715e..bd234c3c50b2 100644
> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
> @@ -93,14 +93,110 @@ int pdsc_dl_flash_update(struct devlink *dl,
>  	return pdsc_firmware_update(pdsc, params, extack);
>  }
>  
> +static int pdsc_dl_report_component(struct devlink_info_req *req,
> +				    struct pds_core_fw_component_info *info)
> +{
> +	enum devlink_info_version_type ver_type;
> +	u16 flags = le16_to_cpu(info->flags);
> +	char *ver = info->version;
> +	const char *name;
> +	char buf[32];
> +
> +	/* Main firmware is reported as generic "fw" */
> +	if (info->component_type == PDS_CORE_FW_TYPE_MAIN) {
> +		if (info->slot_id == PDS_CORE_FW_SLOT_GOLD)
> +			snprintf(buf, sizeof(buf), "fw.gold");
> +		else
> +			snprintf(buf, sizeof(buf), "fw");
> +	} else {
> +		name = pdsc_fw_type_to_name(info->component_type);
> +		if (!name)
> +			return 0;
> +
> +		if (info->slot_id == PDS_CORE_FW_SLOT_GOLD)
> +			snprintf(buf, sizeof(buf), "fw.%s.gold", name);
> +		else
> +			snprintf(buf, sizeof(buf), "fw.%s", name);
> +	}

[Medium]
For PDS_CORE_FW_TYPE_MAIN, only PDS_CORE_FW_SLOT_GOLD is special-cased.
PDS_CORE_FW_SLOT_INVALID, PDS_CORE_FW_SLOT_A, and PDS_CORE_FW_SLOT_B all
end up emitting the bare name "fw".

The legacy v1 path used distinct names fw.mainfwa and fw.mainfwb for
these two slots, and devlink_info_version_*_put() does not deduplicate
names. If firmware reports two MAIN components (which the v1
pds_core_fw_list_info already exposed as A/B), will userspace see two
entries both named "fw" with no way to distinguish them?

[Medium]
Are the new component names documented anywhere? The driver introduces
fw.bootloader, fw.cpld, fw.secure, fw.fpga, fw.suc, fw.suc.bootloader,
fw.uboot, plus a .gold variant of each, and fw.gold.

Documentation/networking/devlink/devlink-info.rst says:

  It is expected that drivers use the following generic names ... As
  last resort, if a component is truly unique, using driver-specific
  names is allowed, but these should be documented in the driver-specific
  file.

Of those names only fw and fw.bootloader correspond to documented
generic suffixes; the rest appear to be driver-invented, and there is
no Documentation/networking/devlink/pds_core.rst introduced by this
patch. The .gold suffix in particular is not part of the generic
vocabulary (different copies of the same component are normally handled
via bundle_id or by reporting the same name under both running and
stored). Composite names like fw.suc.bootloader.gold do not have any
documented dot-separation semantics either.

> +
> +	ver_type = DEVLINK_INFO_VERSION_TYPE_NONE;
> +	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_UPDATE_BY_NAME)
> +		ver_type = DEVLINK_INFO_VERSION_TYPE_COMPONENT;
> +
> +	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_FIXED) {
> +		int err;
> +
> +		err = devlink_info_version_fixed_put(req, buf, ver);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_RUNNING) {
> +		int err;
> +
> +		err = devlink_info_version_running_put_ext(req, buf,
> +							   ver, ver_type);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_STARTUP) {
> +		int err;
> +
> +		err = devlink_info_version_stored_put_ext(req, buf,
> +							  ver, ver_type);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}

[Medium]
Is the generic running "fw" entry still guaranteed on the v2 path?
It is produced only as a side effect of pdsc_dl_report_component()
seeing component_type == PDS_CORE_FW_TYPE_MAIN with
PDS_CORE_FW_COMPONENT_INFO_F_RUNNING set.

The v1 path always called:

	devlink_info_version_running_put(req,
					 DEVLINK_INFO_VERSION_GENERIC_FW,
					 pdsc->dev_info.fw_version);

unconditionally. If firmware reports MAIN only with F_STARTUP/F_FIXED
(no F_RUNNING), or reports no MAIN component at all, does the user
silently lose the generic running fw version that monitoring tools rely
on to identify the active firmware?

> +
> +static int pdsc_dl_report_fw_ver(struct devlink_info_req *req, char *fw_ver)
> +{
> +	return devlink_info_version_running_put(req,
> +						DEVLINK_INFO_VERSION_GENERIC_FW,
> +						fw_ver);
> +}
> +
> +static int pdsc_dl_component_info_get(struct devlink *dl,
> +				      struct devlink_info_req *req,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct pds_core_component_list_info *list_info;
> +	struct pdsc *pdsc = devlink_priv(dl);
> +	u8 num_components;
> +	int err;
> +	int i;
> +
> +	if (!pdsc->fw_components.num_components) {
> +		err = pdsc_get_component_info(pdsc);
> +		if (err || !pdsc->fw_components.num_components)
> +			return pdsc_dl_report_fw_ver(req,
> +						    pdsc->dev_info.fw_version);
> +	}

[High]
Can devlink info polling accumulate deferred DMA buffers when the
firmware is hung?

pdsc_dl_component_info_get() is reachable from any devlink dev info
request. On -EAGAIN or -ETIMEDOUT, pdsc_get_component_info() calls
pdsc_deferred_dma_add() and returns the error without setting
pdsc->fw_components.num_components:

	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout * 2);
	if (err == -ETIMEDOUT || err == -EAGAIN) {
		pdsc_deferred_dma_add(pdsc, deferred, dma_addr, list_info,
				      PDS_PAGE_SIZE, DMA_FROM_DEVICE);
		return err;
	}

The cached count therefore stays 0, so the next devlink info request
re-enters the same path and queues another PDS_PAGE_SIZE allocation
plus DMA mapping. The deferred list is only drained by
pdsc_deferred_dma_free() in __pdsc_devcmd_locked() on a non-EAGAIN
return.

Before this patch, pdsc_get_component_info() was reachable only from
the privileged flash path. Is it intentional that any monitoring agent
polling devlink dev info while firmware is wedged can grow the deferred
DMA list unbounded?

[Medium]
On the v2 branch, the function falls back to a single
pdsc_dl_report_fw_ver() call whenever pdsc_get_component_info() returns
an error or num_components is still 0 (which also happens when the
firmware reports comp.get_component_info.ver == 0 and the function
returns 0).

Before this patch, pdsc_dl_info_get() unconditionally invoked
PDS_CORE_FW_GET_LIST and emitted fw.goldfw, fw.mainfwa, fw.mainfwb.
On v2 devices that branch is unreachable, since pdsc_dl_fw_list_info_get()
is only called from pdsc_dl_info_get_v1().

For transitional firmware that advertises identity v2 but does not yet
support PLDM/GET_COMPONENT_INFO, would calling pdsc_dl_fw_list_info_get()
as a v2 fallback preserve the previous four-version output rather than
silently collapsing it to one?

> +
> +	list_info = &pdsc->fw_components;
> +	num_components = min_t(u16, list_info->num_components,
> +			       le16_to_cpu(pdsc->dev_ident.max_fw_slots));
> +	for (i = 0; i < num_components; i++) {
> +		err = pdsc_dl_report_component(req, &list_info->info[i]);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}

[Medium]
What happens if dev_ident.max_fw_slots is 0? pdsc_get_component_info()
populates pdsc->fw_components.num_components from the firmware list
(bounded by PDS_CORE_FW_COMPONENT_LIST_LEN), but the loop bound clamps
that against the separate max_fw_slots identity field:

	num_components = min_t(u16, list_info->num_components,
			       le16_to_cpu(pdsc->dev_ident.max_fw_slots));

If firmware advertises identity v2 but reports max_fw_slots == 0, the
earlier !pdsc->fw_components.num_components check does not fire (the
count is non-zero), min_t() yields 0, the loop body is skipped, and
pdsc_dl_info_get() proceeds straight to ASIC ID/REV/serial. Would
adding a fallback to pdsc_dl_report_fw_ver() in this case avoid
emitting devlink info with no fw entry at all?

> +
>  static char *fw_slotnames[] = {
>  	"fw.goldfw",
>  	"fw.mainfwa",
>  	"fw.mainfwb",
>  };
>  
> -int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
> -		     struct netlink_ext_ack *extack)
> +static int pdsc_dl_fw_list_info_get(struct devlink *dl,
> +				    struct devlink_info_req *req,
> +				    struct netlink_ext_ack *extack)
>  {

[ ... ]

> @@ -134,12 +230,41 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
>  			return err;
>  	}
>  
> -	err = devlink_info_version_running_put(req,
> -					       DEVLINK_INFO_VERSION_GENERIC_FW,
> -					       pdsc->dev_info.fw_version);
> +	return 0;
> +}
> +
> +static int pdsc_dl_info_get_v1(struct devlink *dl,
> +			       struct devlink_info_req *req,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct pdsc *pdsc = devlink_priv(dl);
> +	int err;
> +
> +	err = pdsc_dl_fw_list_info_get(dl, req, extack);
>  	if (err)
>  		return err;
>  
> +	/* Version 1: report fw from dev_info (running only) */
> +	return pdsc_dl_report_fw_ver(req, pdsc->dev_info.fw_version);
> +}
> +
> +int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
> +		     struct netlink_ext_ack *extack)
> +{
> +	struct pdsc *pdsc = devlink_priv(dl);
> +	char buf[32];
> +	int err;
> +
> +	if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2) {
> +		err = pdsc_dl_component_info_get(dl, req, extack);
> +		if (err)
> +			return err;
> +	} else {
> +		err = pdsc_dl_info_get_v1(dl, req, extack);
> +		if (err)
> +			return err;
> +	}
> +

[Medium]
Is the devlink-info naming change across the identity-version boundary
intentional, and is it captured in the commit message or a Documentation
update?

Before this patch every device emitted stored slot names from
fw_slotnames[] (fw.goldfw, fw.mainfwa, fw.mainfwb) via the unconditional
PDS_CORE_FW_GET_LIST devcmd. After this patch, devices that advertise
identity >= PDS_CORE_IDENTITY_VERSION_2 take the
pdsc_dl_component_info_get() branch and emit a different set of names
(fw, fw.gold, fw.bootloader, fw.uboot, fw.cpld, ...), with no alias for
the old names.

A firmware-only upgrade can therefore silently rename the user-visible
stored entries. Should the commit message call out this UAPI rename,
and should the legacy names remain emitted as aliases for compatibility
with existing fleet tooling that parses devlink dev info output?
-- 
This is an AI-generated review.


