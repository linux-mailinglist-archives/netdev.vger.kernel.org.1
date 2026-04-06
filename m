Return-Path: <netdev+bounces-275628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKlQMnvQ02n8mQcAu9opvQ
	(envelope-from <netdev+bounces-275628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:25:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 660A63A4B6A
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0ACF300614F
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CAB386565;
	Mon,  6 Apr 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWu+KzaE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E03491C4
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489144; cv=none; b=B9YcSYUOlzG6M7PxRnm0yKVx4YElBJq7wGDbxJR7MFVsxLm1I3qObAx71ds/8rjZGJ2j0remFRaZ9mrogoyOjKY7gOBHEU5EnUjyoLDsfYhLmL3h9EIfdZfgQTPlze3IK9zPESv3OVu7radxqP7tBGeUB0bNGzyk2y3ZRtZT6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489144; c=relaxed/simple;
	bh=+yePk80g3HBJ5qAZcvtjH9PyYcTFDWBiq+ZEyc+7Iig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gujtCXKWM7xeRnS3kQWrrmrzvAI2i01G7D3A+rdeo/GUwe5KbGYPa6lF0HrIh2aoWZvwCFuqP/TEPPxBmWu+mNswsp5T7netGHrUsPd6wg4NLo2b8jIkJyAqJwCcIFwDQrHLT68jU0H8jVusFi1PTE5U+obsfWK5atVebVm0olw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWu+KzaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBFEC4CEF7;
	Mon,  6 Apr 2026 15:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775489143;
	bh=+yePk80g3HBJ5qAZcvtjH9PyYcTFDWBiq+ZEyc+7Iig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWu+KzaER67hdPMQSysMNSWFLen+qitWYpvuVBdwyD3zLJzo3yOFhE4008hwYJtWv
	 b9ujJEQQYjUkF3Rqjm5JMvVtfCocdF12+Od+z2YoSLaRitMIf1YJvFEIP5n72ARNnd
	 txp34XhepFVRt1sNY9/r9QePctldmjt5NvCBFUsN0CW5LM48ZqjwyKWEUrymNG2HLH
	 2o8cHHGNOS2sYhVf6GKo0UMH8WMK20EhLUrc7xOZ8XakksPFrn1X4JrJoHu8Gc9cLt
	 l1z+TO4h1UhDGCWj+5LwOLteTlpaiAFFslWvbOU5LUfcRcse1SaqQPBRHn9pe+Z0fd
	 kRadrig3A9tbQ==
From: Simon Horman <horms@kernel.org>
To: lorenzo@kernel.org
Cc: 'Simon Horman' <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xuegang.lu@airoha.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: airoha: Add dma_rmb() and READ_ONCE() in airoha_qdma_rx_process()
Date: Mon,  6 Apr 2026 16:25:23 +0100
Message-ID: <20260406152523.417779-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403-airoha_qdma_rx_process-fix-reordering-v2-1-181e6e23d27b@kernel.org>
References: <20260403-airoha_qdma_rx_process-fix-reordering-v2-1-181e6e23d27b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275628-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 660A63A4B6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: airoha: Add dma_rmb() and READ_ONCE() in airoha_qdma_rx_process()

This commit adds a missing dma_rmb() to ensure DMA read operations are
completed and uses READ_ONCE() to prevent compiler reordering when accessing
descriptor fields.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 95ba99b89428e..f1843bc5b9914 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
[ ... ]
> @@ -612,15 +611,17 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
>  	while (done < budget) {
>  		struct airoha_queue_entry *e = &q->entry[q->tail];
>  		struct airoha_qdma_desc *desc = &q->desc[q->tail];
> -		u32 hash, reason, msg1 = le32_to_cpu(desc->msg1);
> -		struct page *page = virt_to_head_page(e->buf);
> -		u32 desc_ctrl = le32_to_cpu(desc->ctrl);
> +		u32 hash, reason, msg1, desc_ctrl;
>  		struct airoha_gdm_port *port;
>  		int data_len, len, p;
> +		struct page *page;
>  
> +		desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
>  		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
>  			break;
[ ... ]
> @@ -633,10 +634,12 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
>  		if (!len || data_len < len)
>  			goto free_frag;

Could this jump lead to an uninitialized pointer dereference?

The initialization of page was removed from the declarations above, so it
is uninitialized at this point.

Later in the function, the error path looks like this:

free_frag:
		if (q->skb) {
			dev_kfree_skb(q->skb);
			q->skb = NULL;
		} else {
			page_pool_put_full_page(q->page_pool, page, true);
		}

If q->skb is NULL, passing the uninitialized page to
page_pool_put_full_page() might cause a crash.

Also, this isn't a bug introduced by this patch, but does this error path
leak the page associated with the current descriptor?

If we hit an error on a scattered fragment while q->skb is not NULL, the
SKB is freed, but the current page (which hasn't been attached to the SKB
yet) bypasses the else branch and isn't returned to the page pool.

>  
> -		p = airoha_qdma_get_gdm_port(eth, desc);
> +		msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
> +		p = airoha_qdma_get_gdm_port(eth, msg1);
>  		if (p < 0 || !eth->ports[p])
>  			goto free_frag;

Similarly, taking this jump leaves page uninitialized before reaching the
error handling path.

>  
> +		page = virt_to_head_page(e->buf);
>  		port = eth->ports[p];
>  		if (!q->skb) { /* first buffer */

