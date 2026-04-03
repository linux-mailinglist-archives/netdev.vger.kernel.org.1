Return-Path: <netdev+bounces-275229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJOWN1Y00Gnm4gYAu9opvQ
	(envelope-from <netdev+bounces-275229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:42:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4852739880B
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7272301E96D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 21:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3435B37AA72;
	Fri,  3 Apr 2026 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLIXmbTJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11185371CFB
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775252564; cv=none; b=uYqjycZ0ez9Oi+33DWbyVDJXjOCtLNJ7pYPXMezSm8XIaRbWmYik9G8Xjkh5AVqSe7nL8H4jwcP2+m4A8v22WtNTpU729rKj1JZbh9Iz4Ni3Bvgy2W0XZeYeDoBo7aDFARwb6b9g2aD0d55J971L35oKX8FFy0NNl0pY1/KUO6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775252564; c=relaxed/simple;
	bh=bdj8RXu3qgyKpumk5HWckExHJL+wZZpu0L3xUEHMOvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhAJJpqMIbvCol/O6qGjXhtunmVXfifdzvX4lehA0ql3NAxLO7+93OWqq0p4S342T8qfxs7AKsa//9h96i5YWZtT4Rw5LmKqb1jA3wCCluHokqhp0Ua8iu44xcDxUrH5/wzEf6lHwcPTNB94z/q+ToGgGs+KgCgj81ZgiuNmRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLIXmbTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E667DC4CEF7;
	Fri,  3 Apr 2026 21:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775252563;
	bh=bdj8RXu3qgyKpumk5HWckExHJL+wZZpu0L3xUEHMOvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLIXmbTJFOvMHgvmx+IsIiO/p5g2tHkt75ezUxbSbPXEq1I0iflD+reTNHwPbyhnI
	 7/LHdfxoz7QUStvGpRbfPj5izApbuatl2sDSlXuW6XWVOpdnWC/ov4sw1sQ1TyC4Ks
	 EV/b3+NA8+14EvEA29s+Q1n5/Yub5iKu2W+vZwqJBuCO3Vq1QSHDf9u9RBmD3z0gUj
	 /6EdwmvLhdCi5Tc59ENYFSBH1+nzq52VBCmCSViLW49kXcGfduqaZVBfL4OrEMLa8/
	 3HIXzozEmPLifBHuKQ62QiOf/dBv0OHx0VbrsgdaV8j6dKlHhYGM5PyhAV7uJEr/LY
	 7XjcuwFxC1tNw==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Fix memory leak in airoha_qdma_rx_process()
Date: Fri,  3 Apr 2026 14:42:24 -0700
Message-ID: <20260403214223.2230561-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402-airoha_qdma_rx_process-mem-leak-fix-v1-1-b5706f402d3c@kernel.org>
References: <20260402-airoha_qdma_rx_process-mem-leak-fix-v1-1-b5706f402d3c@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275229-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4852739880B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email says: "more thing to fix.."
---
net: airoha: Fix memory leak in airoha_qdma_rx_process()

This commit fixes a memory leak in the error path of
airoha_qdma_rx_process() by partially reverting a previous commit and
always calling page_pool_put_full_page().

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 95ba99b89428e..91cb63a32d990 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -697,9 +697,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)

This problem wasn't introduced by this patch, but while reviewing this
function I noticed the descriptor field msg1 is read from memory before
the ownership bit is validated:

airoha_qdma_rx_process() {
        while (done < budget) {
                struct airoha_queue_entry *e = &q->entry[q->tail];
                struct airoha_qdma_desc *desc = &q->desc[q->tail];
                u32 hash, reason, msg1 = le32_to_cpu(desc->msg1);
                struct page *page = virt_to_head_page(e->buf);
                u32 desc_ctrl = le32_to_cpu(desc->ctrl);

                if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
                        break;

Could this lead to processing stale descriptor metadata? On weakly-ordered
architectures, the CPU might reorder these reads before the device commits
the new descriptor data. 

Are we missing a dma_rmb() after the ownership check?

>  		if (q->skb) {
>  			dev_kfree_skb(q->skb);
>  			q->skb = NULL;
> -		} else {
> -			page_pool_put_full_page(q->page_pool, page, true);
>  		}

This is also an existing issue, but does jumping to this error path on a
scattered packet fragment leave the receive loop in an inconsistent state?

If an error occurs while processing a middle fragment of a packet, q->skb
is freed and set to NULL here. However, the loop continues to the next
descriptor.

Since q->skb is now NULL, won't the next fragment of the same corrupted
packet be erroneously parsed as the start of a brand new Ethernet frame:

                if (!q->skb) { /* first buffer */
                        q->skb = napi_build_skb(e->buf, q->buf_size);

Could this desynchronization allow arbitrary payload to be injected into
the network stack as a legitimate packet? The driver may need to discard
all subsequent fragments until a descriptor without QDMA_DESC_MORE_MASK is
encountered.

> +		page_pool_put_full_page(q->page_pool, page, true);
>  	}
>  	airoha_qdma_fill_rx_queue(q);
>

