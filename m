Return-Path: <netdev+bounces-256558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MtKITzHgml9awMAu9opvQ
	(envelope-from <netdev+bounces-256558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 05:12:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A950E180E
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 05:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E920D30A2070
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 04:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6481B32E727;
	Wed,  4 Feb 2026 04:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq/QBVBR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA032E12D
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178359; cv=none; b=GGZNRKiaBfhTOhYLTcQJpYtGiBG//QtBY9jBmJG8cvvOAuFSKqtGHe93ftd5q0TQq1qOni71pMzAYkXMBseO1kxI33a/k80lfhY2Pu0D28BpuVHDJCSxoDp4tMlU7kNEs0wlr8wu/lZqyCXxOK/5T8SpT5L6nYZDknD8Qb0SpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178359; c=relaxed/simple;
	bh=GomkjnydL+gNaTLBxCQpqQUlqG8sggmOX7/huJunVZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZL48FKcfPT/6FefwKRRuLzk2iKfAJ3SCql/mzIU9KwyrBn672Tu9caYLLUVCxcR1yoRlEYXXYFcVT1vCThha/zKZh1Z+eL9k4RMhF8APyanFhq6aWTIpIVJWbY0lw9C7TUtAPV+/OTEui+8LyqKJiy5YylP0qkSAaz3bET+le8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq/QBVBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573A8C4CEF7;
	Wed,  4 Feb 2026 04:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770178358;
	bh=GomkjnydL+gNaTLBxCQpqQUlqG8sggmOX7/huJunVZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gq/QBVBRHZvoxlKIWqrKDeJKyhvgV0+PqecU37vOwzdFZ7p2ffJYZLn6Q0pmDqO4C
	 d8NGNgzLc/HrqqKAdymoWFk+KoPsu4GUP+OL84CzPuthVyOeCBnlZ5ASBpOPx5bZUS
	 8LNkNJJC9B03MzzQ1RLFUsCXV1CDKMkU/vn6ceS4vMbbnCtG2DSQO9iS1/uDqHR8H4
	 KTPkjwOLFqDIPjS2zIpvgt7O8Igz1mTJUcNqUbvVApsmaMyrC7r7UdR6fBx4F8wJ8V
	 enIHwdEciYbdemCFSJZcNw7poxCu3sL1JQKr11dI+QDYJLdlS/gv2WOVqXXmfTtufo
	 NNSc21msPeTNw==
Date: Tue, 3 Feb 2026 20:12:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, davem@davemloft.net, guwen@linux.alibaba.com,
 lulie@linux.alibaba.com, hkallweit1@gmail.com, edumazet@google.com,
 lukas.bulwahn@redhat.com, andrew@lunn.ch, dong100@mucse.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org
Subject: Re: [net-next,v25,4/6] eea: create/destroy rx,tx queues for
 netdevice open and stop
Message-ID: <20260203201237.35c5f756@kernel.org>
In-Reply-To: <20260204040054.1698677-2-kuba@kernel.org>
References: <20260202090638.46836-5-xuanzhuo@linux.alibaba.com>
	<20260204040054.1698677-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,redhat.com,linux.dev,davemloft.net,linux.alibaba.com,gmail.com,google.com,mucse.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256558-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A950E180E
X-Rspamd-Action: no action

On Tue,  3 Feb 2026 20:00:55 -0800 Jakub Kicinski wrote:
> > +	err = enet_bind_new_q_and_cfg(enet, ctx);
> > +	if (err) {
> > +		netdev_err(enet->netdev,
> > +			   "eea reset: bind new queues failed. err %d\n",
> > +			   err);
> > +
> > +		return err;
> > +	}  
> 
> When enet_bind_new_q_and_cfg() fails, what happens to the queues allocated
> by eea_alloc_rxtx_q_mem() at line 289? They're now assigned to ctx->rx and
> ctx->tx but haven't been bound to enet yet.
> 
> After eea_netdev_stop() sets enet->started = false, a subsequent call to
> eea_netdev_stop() will return early at line 228 without calling
> eea_free_rxtx_q_mem(). If enet_bind_new_q_and_cfg() fails before binding,
> the queues remain in ctx with no cleanup path.
> 
> The comment suggests deferring cleanup to "normal NIC cleanup" but
> eea_net_remove() doesn't call eea_free_rxtx_q_mem(), and future reset
> attempts would allocate new queues without freeing these.

I think AI is slightly confused here but so am I. I don't get where you
free he previous resources in this flow. The "bind_new_q_and_cfg" just
overrides stuff, who frees the old set of rings?

Also as I already mentioned in previous manual review you are not
pre-allocating enough. You should also request necessary extra IRQs
_before_ you start tearing down the old state.

> > +static struct sk_buff *eea_rx_build_split_hdr_skb(struct eea_net_rx *rx,
> > +						  struct eea_rx_ctx *ctx)
> > +{
> > +	struct eea_rx_meta *meta = ctx->meta;
> > +	struct sk_buff *skb;
> > +	u32 truesize;
> > +
> > +	dma_sync_single_for_cpu(rx->enet->edev->dma_dev, meta->hdr_dma,
> > +				ctx->hdr_len, DMA_FROM_DEVICE);
> > +
> > +	skb = napi_alloc_skb(&rx->napi, ctx->hdr_len);
> > +	if (unlikely(!skb))
> > +		return NULL;
> > +
> > +	truesize = meta->headroom + ctx->len;
> > +
> > +	skb_put_data(skb, ctx->meta->hdr_addr, ctx->hdr_len);
> > +
> > +	if (ctx->len) {
> > +		skb_add_rx_frag(skb, 0, meta->page,
> > +				meta->offset + meta->headroom,
> > +				ctx->len, truesize);
> > +
> > +		eea_consume_rx_buffer(rx, meta, truesize);
> > +	}  
> 
> Is the truesize calculation correct for split header mode? Looking at line
> 255, truesize is calculated as meta->headroom + ctx->len.
> 
> In eea_rx_post() at line 500, buffers are allocated with space for
> [headroom][data][tailroom], where tailroom is typically 128 bytes for
> skb_shared_info. The tailroom is reserved but not included in the truesize
> calculation here.
> 
> When eea_consume_rx_buffer() advances meta->offset by only
> (headroom + data_len), the reserved tailroom space remains unconsumed. After
> alignment in meta_align_offset(), the next fragment may overlap with the
> previous fragment's tailroom space.
> 
> Compare with the non-split header path in eea_rx_build_skb() at line 290,
> which includes shinfo_size in truesize:
> 
>     truesize = meta->headroom + ctx->len + shinfo_size;
> 
> Should the split header path also include meta->tailroom or shinfo_size in
> the truesize calculation?

This one - I think the AI is just confused by how frags work.

