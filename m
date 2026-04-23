Return-Path: <netdev+bounces-280681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIxGFfro6Wm2nAIAu9opvQ
	(envelope-from <netdev+bounces-280681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:40:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C0744FDDF
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F8CC3011BCF
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96393DC4C9;
	Thu, 23 Apr 2026 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPyV12jO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB10B3E51D9
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937156; cv=none; b=QDNzFTWgMaon2mlcRwM33RAMtaH0rlhobc1eqxWl5JZboLP3DJZSdVR1Hy+6AElQ9WxJ3aETIRCsuJFR/iO7vm+YErDcReDEl3boTjxaRyBsoiyApaCstm1+T8hsSP37eYiD+FCXQy0DCC8IIJYaqYKKPFzj/AGIzTCDXFP0SE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937156; c=relaxed/simple;
	bh=n8PIjgIUEEPbYl8wiqKvWUmCj65cJf49TySsuytpK7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7xoQB1rnOzlumXvzSyWCvI8yevjNqMr1IhaQjZPAAKDsz7PLI0WVAsqcyrjFzss5JMNFbDHv8Rz7ibUBV78GQ0zMn0IsA8wBQbVcJhy/jqgUkP3dJ9A8Q6UVmHzTytWAXM0PgwUh2EdVwWvC4ubjQpuwVtQFZjD1hoNnzUnoHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPyV12jO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776937152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Xo6oUDKNyK+qqRNSbY/aof+abDZD7/ZcXyiZroh3s8=;
	b=iPyV12jOzeo1A0vaOAMTT0aZpcFdSHGBSVeEn6m9oTa/qDe4fPF8OWC8PC10r6eT3pEwrk
	EeeP/RCr41Yjk6C8EQ3pXEQYtN3ACPOXkwK0uJmnaW7lpT+EMVG7Oc9Dt2qJO9npoz/q7g
	TeVtrTNwSOjx7Hl/fZqkORBhaAdfqoM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-7rjCWyeWPdqouL5UKDV3UQ-1; Thu,
 23 Apr 2026 05:39:08 -0400
X-MC-Unique: 7rjCWyeWPdqouL5UKDV3UQ-1
X-Mimecast-MFC-AGG-ID: 7rjCWyeWPdqouL5UKDV3UQ_1776937146
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 302DF1800345;
	Thu, 23 Apr 2026 09:39:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.251])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51A6A300756E;
	Thu, 23 Apr 2026 09:39:02 +0000 (UTC)
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
Subject: Re: [v2,net,01/11] octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k
Date: Thu, 23 Apr 2026 11:38:53 +0200
Message-ID: <20260423093853.138458-1-pabeni@redhat.com>
In-Reply-To: <20260420023442.3295891-2-rkannoth@marvell.com>
References: <20260420023442.3295891-2-rkannoth@marvell.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280681-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,marvell.com,redhat.com,linaro.org,gmail.com,lunn.ch,kernel.org,vger.kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94C0744FDDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k

This patch converts several cn20k NPC functions from void to int return
types to propagate MCAM key-type lookup errors. It adds error checking
for npc_mcam_idx_2_key_type() and threads these errors through the
cn20k MCAM handlers.

Link: https://lore.kernel.org/netdev/adiQJvuKlEhq2ILx@stanley.mountain/

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 7291fdb89b03..18d70f4527d1 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> @@ -1415,9 +1435,9 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
>  	else
>  		nix_intf = pfvf->nix_rx_intf;
>
> -	npc_cn20k_config_mcam_entry(rvu, blkaddr, entry, nix_intf,
> -				    &req->entry_data, req->enable_entry,
> -				    req->hw_prio, req->req_kw_type);
> +	rc = npc_cn20k_config_mcam_entry(rvu, blkaddr, entry, nix_intf,
> +					 &req->entry_data, req->enable_entry,
> +					 req->hw_prio, req->req_kw_type);
>
>  	mutex_unlock(&mcam->lock);
>
>  	rsp->entry = entry_rsp.entry;
>  	return 0;

Does this function need to return rc instead of 0? If
npc_cn20k_config_mcam_entry() fails (for example, due to an invalid key
type), the function still returns success to the caller. The mailbox
response indicates the entry was successfully allocated and configured,
but the hardware entry may be in an undefined state.

[ ... ]


