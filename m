Return-Path: <netdev+bounces-299535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4awMGlkoMGrEPAUAu9opvQ
	(envelope-from <netdev+bounces-299535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:29:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A4C6885F7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:29:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Qwh3AP0m;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299535-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299535-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D075310C26B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2E409DE6;
	Mon, 15 Jun 2026 16:21:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40DE409630
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:21:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540496; cv=none; b=XMy7GwaGjkhGaRByAXcFZlHhD57IhS2QHbPqa39zIi1W6n90zsLqHtJnvQ+V2hGIvqfrfBqfDFkQku1WAQ1Bzdv0ITIHINguPm4kM3hvJmHHDXPYgAiAY1PHZxnSd/NFn/ae04tfxCI0B5bBIvmUO6b/a7NqZmgxbxAcI3rbw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540496; c=relaxed/simple;
	bh=48wNToL0GEzRVEPao/iuIc0U+DvrDXfGT1rjMUKbg6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iph0Kclxd4h6oVrDqVtqaq2Yll6rSRwY+aMWgEFjTWlJo+odUjYuXe+IN/UKygMjhu0mJiFK/Nsy7nq+rFZblCniTFTxq0B/dXKYjr6iC7VYcyaoZGHQtgpqFIZnxlTFTAWTsb9zeXq8OEX1Yfp0/tO3psxbCyC/AbBlYD3OTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qwh3AP0m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883281F000E9;
	Mon, 15 Jun 2026 16:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540494;
	bh=IVG2qe9CKABjhRIEw0NJbokD/W1nzVa/JpuEacNcCvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qwh3AP0m8mD52EItoEgBPsloNTHthIxDax9kdDYqspYeX1rKogAao1N5TwMSeaHVA
	 li5T3l9m1UNy0SHnZaB5TuEg7vPV6VMsIA8VNQmIOaY0qHZYRvy1M6wgrxpli/TtNL
	 /wb9LFzdLR7TRfMe95Lho8rQAIhbON0ZITgPYaBKTdsZFo3R1jiYTfj2DDHgYN2ph8
	 BGckZQMCsCleeGzfmE0iWdgWY/Y2HSYLJj6p45o2xri+dY75YoijsTKWj5eDFVO46g
	 vteYefv3bnQyelWzj3pT+uL3siLuWYaePdtIt5s9aCJZx3GlocO4lQ2hyRC9iSTrR4
	 sVP4ZYHuOS1sw==
From: Simon Horman <horms@kernel.org>
To: nikhil.rao@amd.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric.joyner@amd.com
Subject: Re: [PATCH v4 5/6] pds_core: add host backed memory support for firmware
Date: Mon, 15 Jun 2026 17:19:30 +0100
Message-ID: <20260615161929.780699-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614050052.1048328-6-nikhil.rao@amd.com>
References: <20260614050052.1048328-6-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299535-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nikhil.rao@amd.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8A4C6885F7

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
pds_core: add host backed memory support for firmware

This commit adds support for host-backed DMA memory to provide additional 
memory for firmware control plane components on newer AMD/Pensando cards.

> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index 705cab7b07273..d1695ca95440c 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c

[ ... ]

> @@ -658,3 +660,161 @@ void pdsc_health_thread(struct work_struct *work)
>  out_unlock:
>  	mutex_unlock(&pdsc->config_lock);
>  }
> +
> +static void pdsc_host_mem_del_one(struct pdsc *pdsc, u16 tag, u8 reason)
> +{
> +	union pds_core_dev_comp comp = {};
> +	union pds_core_dev_cmd cmd = {
> +		.host_mem.opcode = PDS_CORE_CMD_HOST_MEM,
> +		.host_mem.oper = PDS_CORE_HOST_MEM_DEL,
> +		.host_mem.tag = cpu_to_le16(tag),
> +		.host_mem.reason = reason,
> +	};

[ ... ]

> +	hm->pa = dma_map_page(pdsc->dev, hm->pg, 0, hm->size,
> +			      DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(pdsc->dev, hm->pa)) {
> +		dev_err(pdsc->dev, "dma map failed for tag %d size %d\n",
> +			hm->tag, hm->size);
> +		__free_pages(hm->pg, hm->order);
> +		hm->pg = NULL;
> +		err = -EIO;
> +		goto err_del;
> +	}
> +
> +	/* Track this allocation so pdsc_host_mem_free() can clean it up */
> +	pdsc->num_host_mem_reqs++;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	memset(&comp, 0, sizeof(comp));
> +	cmd.host_mem.opcode = PDS_CORE_CMD_HOST_MEM;
> +	cmd.host_mem.oper = PDS_CORE_HOST_MEM_ADD;
> +	cmd.host_mem.tag = cpu_to_le16(hm->tag);
> +	cmd.host_mem.size = cpu_to_le32(hm->size);
> +	cmd.host_mem.buf_pa = cpu_to_le64(hm->pa);
> +
> +	dev_dbg(pdsc->dev, "Sending devcmd for mem add tag %d size %d pa %pad\n",
> +		hm->tag, hm->size, &hm->pa);
> +	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
> +	if (err || comp.status != PDS_RC_SUCCESS) {
> +		dev_err(pdsc->dev, "mem add failed err %d status %d for tag %d\n",
> +			err, comp.status, hm->tag);
> +		err = err ? err : -EIO;
> +		goto err_del;
> +	}
> +	dev_dbg(pdsc->dev, "mem add completed for tag %d\n", hm->tag);
> +
> +	return 0;
> +
> +err_del:
> +	/* After MEM_QUERY succeeds, firmware expects MEM_ADD or MEM_DEL */
> +	pdsc_host_mem_del_one(pdsc, hm->tag, PDS_RC_ENOMEM);
> +	return err;

[Severity: Medium]
Does this leave the failed memory allocation mapped and wasted for the
lifetime of the driver?

Because pdsc->num_host_mem_reqs is incremented before sending the MEM_ADD
command, jumping to the err_del label here skips the DMA unmap and page free
steps. The failed request is tracked and will eventually be cleaned up by
pdsc_host_mem_free() during device teardown.

However, the caller pdsc_start() ignores the failure, so the driver operates
normally while potentially tying up to 4MB of DMA-mapped memory until unload
or reset.

> +}

[ ... ]

> +void pdsc_host_mem_free(struct pdsc *pdsc)
> +{
> +	int i;
> +
> +	if (!pdsc->host_mem_reqs)
> +		return;
> +
> +	for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
> +		dma_unmap_page(pdsc->dev, pdsc->host_mem_reqs[i].pa,
> +			       pdsc->host_mem_reqs[i].size,
> +			       DMA_BIDIRECTIONAL);
> +		__free_pages(pdsc->host_mem_reqs[i].pg,
> +			     pdsc->host_mem_reqs[i].order);
> +	}

[Severity: Critical]
Is there a missing notification to the firmware that this memory is being
unmapped?

This loop unmaps the DMA regions and frees the pages, but it doesn't send a
PDS_CORE_HOST_MEM_DEL command.

For physical functions, pdsc_devcmd_reset() runs before this during
teardown, which might clear hardware state. However, virtual functions
explicitly bypass the reset in pdsc_teardown():

pdsc_teardown() {
    if (!pdsc->pdev->is_virtfn)
        pdsc_devcmd_reset(pdsc);
    ...

If a virtual function uses host memory, skipping the MEM_DEL command means
the firmware could be completely unaware the buffers were returned to the
OS. Could this lead to the device performing DMA into freed memory and
causing memory corruption or IOMMU faults?

> +
> +	kfree(pdsc->host_mem_reqs);
> +	pdsc->host_mem_reqs = NULL;
> +	pdsc->num_host_mem_reqs = 0;
> +}

