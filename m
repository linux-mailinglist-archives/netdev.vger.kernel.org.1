Return-Path: <netdev+bounces-304078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rsQpMd8+RmrNMgsAu9opvQ
	(envelope-from <netdev+bounces-304078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:35:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2228D6F5FB6
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:35:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=bKOfV7ZK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304078-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304078-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 965E831881FD
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFCD47DF89;
	Thu,  2 Jul 2026 09:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D64A2E15
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:43:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985388; cv=none; b=pNOFgwFb8Ep3FRztth+9dPbdpeykj96OApJ/kn9RKvJosOgG+r1mh/tsnToIdqkcdhHC41DsGUc+PUO5rDh+jftQuX/649bSpazpuuZDD4oPuO6g4W17sZQRie0Ks40xAYmXa83qu1lbZC9We83U3KgLll75g+ojfnSlUjRerXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985388; c=relaxed/simple;
	bh=DBp0HpY/1P83m0+T7zAKgcs6HB4JhMfEjMqLia5VMtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZ3oxt/azKd5KS0a0K+tiiUyOpyR9BSPQOUvuHU7xUxjS8FMeInwVEfon8QZV2+0ekDHfjqJTkStL/YeBq6sz8Kg6gL1//+is3kYjQ7EXipmfFuBaegTFBz0ciJLDEkxdsPu1kMFht7WFkB79o5YRw07me5afi3+ZvBh0JwgBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKOfV7ZK; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782985386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVzabU/aan9emoroPKw52jNiTEzUBhOm6LtJbWWM6Yg=;
	b=bKOfV7ZKBK2pbWTgWVLwWyytV1kXtvafhwhcjjP9juvsyHuhrjIm/xm71RRVdFP8UfLjfW
	KqZ3JDbRycgE9+zaiF7mjcRRB+8gezyaG3zwmwDZYhGJgKnnWtOkN1XSFOeMfp9rwqtKQE
	NGMCVG8HdYKrpc+tgA95LiFALa4enzM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-p0njNHpfO3C6nNclJpdQtw-1; Thu,
 02 Jul 2026 05:43:03 -0400
X-MC-Unique: p0njNHpfO3C6nNclJpdQtw-1
X-Mimecast-MFC-AGG-ID: p0njNHpfO3C6nNclJpdQtw_1782985381
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D34C1944EB7;
	Thu,  2 Jul 2026 09:43:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.252])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C15A71800592;
	Thu,  2 Jul 2026 09:42:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 net-next 06/10] net/nebula-matrix: add intr resource implementation
Date: Thu,  2 Jul 2026 11:42:53 +0200
Message-ID: <20260702094253.111384-1-pabeni@redhat.com>
In-Reply-To: <20260630010718.4346-7-illusion.wang@nebula-matrix.com>
References: <20260630010718.4346-7-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-304078-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:illusion.wang@nebula-matrix.com,m:dimon.zhao@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2228D6F5FB6

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net/nebula-matrix: add intr resource implementation

This patch adds the nbl_interrupt module for management of driver-private
MSI-X indices. It adds hw_ops callbacks to program the function MSI-X mapping
registers, configure MSI-X info, and enable mailbox interrupts.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> new file mode 100644
> index 0000000000000..53a657aef9ca0
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> @@ -0,0 +1,267 @@
[ ... ]
> +/*
> + * This function tears down the MSI-X mapping for a function by clearing the
> + * interrupt bitmaps, disabling MSI-X via HW callbacks, and resetting the
> + * bookkeeping state. The DMA buffer and interrupts[] array are intentionally
> + * left allocated for potential reuse on reset/hot-add paths. Caller must
> + * ensure this is only invoked when the HW cannot issue in-flight DMA to
> + * the region (IRQs already freed or not yet configured).
> + */
> +int nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
> +				  u16 func_id)
> +{
[ ... ]
> +	/* use ctrl dev bdf */
> +	hw_ops->configure_msix_map(res_mgt->hw_ops_tbl->priv, func_id, false, 0,
> +				   0, 0, 0);
> +
> +	intr_mgt->func_intr_res[func_id].interrupts = NULL;
> +	intr_mgt->func_intr_res[func_id].num_interrupts = 0;
> +	intr_mgt->func_intr_res[func_id].msix_map_table.base_addr = NULL;
> +	intr_mgt->func_intr_res[func_id].msix_map_table.size = 0;
> +	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
> +
> +	return 0;
> +}

[Severity: High]
Does this code leak the devm-managed resources? The comment mentions that
the DMA buffer and interrupts array are left allocated for potential reuse,
but the pointers are set to NULL here. This causes the pointers to be lost
so they cannot be reused or explicitly freed later.

Because nbl_res_intr_configure_msix_map() unconditionally allocates new devres
memory on every call, won't this cause the devres list to accumulate leaked
allocations (dmam_alloc_coherent and devm_kcalloc) each time the device is
reset or a VF is reconfigured?

[ ... ]
> +int nbl_res_intr_configure_msix_map(struct nbl_resource_mgt *res_mgt,
> +				    u16 func_id, u16 num_net_msix,
> +				    u16 num_others_msix,
> +				    bool net_msix_mask_en)
> +{
[ ... ]
> +	nbl_res_intr_destroy_msix_map(res_mgt, func_id);
> +
> +	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
> +	WARN_ON(msix_map_table->base_addr);
> +	msix_map_table->size =
> +		sizeof(struct nbl_msix_map) * NBL_MSIX_MAP_TABLE_MAX_ENTRIES;
> +	/* HW indexes the MSI-X map table with a fixed stride of 1024 entries,
> +	 * so we must allocate the full table even if fewer vectors are used.
> +	 */
> +	msix_map_table->base_addr = dmam_alloc_coherent(dev,
> +							msix_map_table->size,
> +							&msix_map_table->dma,
> +							GFP_KERNEL);
> +	if (!msix_map_table->base_addr) {
> +		dev_err(dev, "Allocate DMA memory for function msix map table failed\n");
> +		msix_map_table->size = 0;
> +		return -ENOMEM;
> +	}
> +
> +	interrupts = devm_kcalloc(dev, requested, sizeof(interrupts[0]),
> +				  GFP_KERNEL);
> +	if (!interrupts) {
> +		ret = -ENOMEM;
> +		goto alloc_interrupts_err;
> +	}

[Severity: High]
If devm_kcalloc() fails, the goto alloc_interrupts_err path bypasses
clearing msix_map_table->base_addr and size. 

While nbl_res_intr_destroy_msix_map() clears it unconditionally on the next
call, doesn't this leave the internal state inconsistent by keeping base_addr
populated when interrupts is NULL?

[ ... ]
> +get_interrupt_err:
> +	while (i--) {
> +		intr_index = interrupts[i];
> +		if (intr_index >= NBL_NET_INTR_BASE)
> +			clear_bit(intr_index - NBL_NET_INTR_BASE,
> +				  intr_mgt->interrupt_net_bitmap);
> +		else
> +			clear_bit(intr_index,
> +				  intr_mgt->interrupt_others_bitmap);
> +	}
> +
> +	intr_mgt->func_intr_res[func_id].num_interrupts = 0;
> +	intr_mgt->func_intr_res[func_id].interrupts = NULL;
> +	intr_mgt->func_intr_res[func_id].num_net_interrupts = 0;
> +	intr_mgt->func_intr_res[func_id].msix_map_table.base_addr = NULL;
> +	intr_mgt->func_intr_res[func_id].msix_map_table.size = 0;
> +alloc_interrupts_err:
> +	return ret;
> +}
-- 
This is an AI-generated review.


