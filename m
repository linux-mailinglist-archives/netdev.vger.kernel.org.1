Return-Path: <netdev+bounces-280682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHCaA43q6Wm2nAIAu9opvQ
	(envelope-from <netdev+bounces-280682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:46:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781E144FF66
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3B2430CD5D9
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8D3E5EC6;
	Thu, 23 Apr 2026 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAanRu3B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C01830E0FC
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937165; cv=none; b=XUNY27UMWiJ/XfHZzhV/bQVWa09AGiIf0RJKcwHCKhH/KY0yruCmu4XGm+94voilxHhfNjhO0E0eU1UhGrCVtWK6Ac4gfA2PYrSbwm8n1RFGTYNaguTCaKfxu9P6l3hKl8XsCaGhdhNoa+efkrNknWR6Xys5erLOvrRlDvue/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937165; c=relaxed/simple;
	bh=kckCjN1bAJ/aD+ZME7sjfLu222AnPjsahtqch0OotT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vk5c+X21sELspPrtUnvzQpuGY1UT185x/nsRYUigrY2SFQ1er8/03/KnccCLHEGufK7jm7CCLb+wpvrx5kVhmvT8WpafXNo+2n69YEOPbM5yA7KJ4afa/2VZKgMf3WphrJSMhi46Rh9OW/n2CGd+fBb9EKsdWfvuJMbPmssflV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAanRu3B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776937160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWf4pA6wYuLbxdkqZpiZsCBUl5UU+tVZFdkRbdv2rks=;
	b=JAanRu3BHkG+S7xlwPwQxrxLj6ByFBoqS8B7gqOM3K4OdwD/m9mzZ1TW/5dHf4YjTbLOES
	WZjX+UJ+ZNqMW4OCjVvURfsLuwdfH91miv3qDFSrO8/FhYDXF3UWw4TuO3CkpEi6qJlb/b
	DZ4h6r5whBc9hO+h/fZbkl+3eNLWoAs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-GsRj5rZwOJy_-piOMFOLmw-1; Thu,
 23 Apr 2026 05:39:16 -0400
X-MC-Unique: GsRj5rZwOJy_-piOMFOLmw-1
X-Mimecast-MFC-AGG-ID: GsRj5rZwOJy_-piOMFOLmw_1776937155
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2A531956059;
	Thu, 23 Apr 2026 09:39:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.251])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A8823000709;
	Thu, 23 Apr 2026 09:39:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: rkannoth@marvell.com
Cc: davem@davemloft.net,
	sgoutham@marvell.com,
	pabeni@redhat.com,
	sumang@marvell.com,
	dan.carpenter@linaro.org,
	error27@gmail.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org
Subject: Re: [v2,net,06/11] octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width
Date: Thu, 23 Apr 2026 11:39:06 +0200
Message-ID: <20260423093906.138472-1-pabeni@redhat.com>
In-Reply-To: <20260420023442.3295891-7-rkannoth@marvell.com>
References: <20260420023442.3295891-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280682-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,marvell.com,redhat.com,linaro.org,gmail.com,lunn.ch,kernel.org,vger.kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 781E144FF66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width

Replace the old four-argument CN20K MCAM clear with a per-bank static
helper and npc_cn20k_clear_mcam_entry() that takes a logical MCAM index,
resolves the key width via npc_mcam_idx_2_key_type(), and clears either
one bank (X2) or every bank (X4). Call it from npc_clear_mcam_entry() on
cn20k and log when key-type lookup fails. Use the per-bank helper from
npc_cn20k_config_mcam_entry() for pre-program clears. For loopback VFs,
use the promisc MCAM index as ucast_idx when copying RSS action for
promisc, matching cn20k default-rule layout.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 705fe7a877e6..7bfd39fe0f5e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> @@ -877,6 +877,32 @@ npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr, int bank, int index)
>  		    NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(index, bank), 0);
>  }
>
> +int
> +npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr, int mcam_idx)
> +{
> +	struct npc_mcam *mcam = &rvu->hw->mcam;
> +	int bank = npc_get_bank(mcam, mcam_idx);
> +	u8 kw_type, index;
> +
> +	if (npc_mcam_idx_2_key_type(rvu, mcam_idx, &kw_type))
> +		return -EINVAL;
> +
> +	index = mcam_idx & (mcam->banksize - 1);

Can the index calculation overflow a u8 when banksize exceeds 256?

The mcam->banksize field is u16 and can be up to 65535, with typical
values like 512 or 1024 for NPC MCAM hardware. When computing 'mcam_idx &
(mcam->banksize - 1)', the result will be truncated to 8 bits if it
exceeds 255, causing the wrong MCAM entry to be cleared.

Other code in this driver uses u16 or int for the same calculation:

drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c:npc_cn20k_copy_mcam_entry()
    u16 src, dest;
    ...
    src = src_idx & (mcam->banksize - 1);

drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c:npc_clear_mcam_entry()
    index &= (mcam->banksize - 1);

where index is int.

> +
> +	if (kw_type == NPC_MCAM_KEY_X2) {
> +		npc_clear_x2_entry(rvu, blkaddr, bank, index);
> +		return 0;
> +	}
> +
> +	/* For NPC_MCAM_KEY_X4 keys, both the banks
> +	 * need to be programmed with the same value.
> +	 */
> +	for (bank = 0; bank < mcam->banks_per_entry; bank++)
> +		npc_clear_x2_entry(rvu, blkaddr, bank, index);
> +
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 762fafd4ccb7..0a2191fda614 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -259,6 +259,13 @@ static void npc_clear_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
>  	int bank = npc_get_bank(mcam, index);
>  	int actbank = bank;
>
> +	if (is_cn20k(rvu->pdev)) {
> +		if (npc_cn20k_clear_mcam_entry(rvu, blkaddr, index))
> +			dev_err(rvu->dev, "%s Failed to enable mcam %u\n",
> +				__func__, index);

This isn't a bug, but the error message says "Failed to enable mcam"
when the operation is clearing the entry. Should this be "Failed to clear
mcam"?

> +		return;
> +	}
> +
>  	index &= (mcam->banksize - 1);
>  	for (; bank < (actbank + mcam->banks_per_entry); bank++) {
>  		rvu_write64(rvu, blkaddr,

[ ... ]


