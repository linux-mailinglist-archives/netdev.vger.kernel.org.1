Return-Path: <netdev+bounces-281816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFy4COCf8GkRWQEAu9opvQ
	(envelope-from <netdev+bounces-281816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:54:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D77484504
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B260F32053D8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33C23B3888;
	Tue, 28 Apr 2026 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3+f8bJd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAED2D1931;
	Tue, 28 Apr 2026 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376112; cv=none; b=ep17AZcZ+A2xn33ooW2F/h9/PLBfeES6qzJqLf9Qtgv2nsVlB8VjD5KBjhS1ir+tRGb6f+jXpp1I3YuERZmcSnEa6FQUZ4aucWxLTwlsxRJcnF7bn2lLTyPJGl/valYE0dd/CeaEvwqx731NPtQ0d5dJAs7+r7qkBuCUE5C6uCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376112; c=relaxed/simple;
	bh=Iz9rHSymK8ZiYjYhR8ZRcgGmX59ovYeer7wGZ2377LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUHDHciG8ESBWP0NyioWWkesoDKkAvn2Mo6CQVWPvXiNcI/elzTaiZeQetm+xiekRoKx8VTIZvgLS+QSsDgjiumWSz8CmZrJPWY75aQkL5MEZBLP68OPnI439Zk9aI/7e8+yAqAusQVZAL4SZC3edLwtSwF9zT9b3Xno9lLYqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3+f8bJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F3FC2BCB7;
	Tue, 28 Apr 2026 11:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777376112;
	bh=Iz9rHSymK8ZiYjYhR8ZRcgGmX59ovYeer7wGZ2377LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3+f8bJdU03gbWIoREsR1CdbmEQfJnU84waJmQID4O8fn9WE7H5KyWbUAqRaBP3PD
	 1osYdT5BFzgE8b7gRsYAV3B8kphcrlqPPzxJ3fJG6IBrEzpofU0eWMew1FsgkhWdF1
	 z0QX1TMEa+pZVtilMytIKIUjn85YYR5q3ZdPgrsfOkyf8myIm5YnlCmO8idIM7Xd3N
	 SW49wNtptUZNCY2E8cVkddrZfAxSDTZIO8Ym3BWqlyAnmeTWU1+/+ipggCkIcxv8p2
	 /MCi6vFGKB89LPYD+0zl7+VK/3OeWfMnqF8+VwRLGN+MUUk9bjDf1VzjVT+LrywWlZ
	 ckvalacCBM+Vg==
From: Simon Horman <horms@kernel.org>
To: kerneljasonxing@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	aleksander.lobakin@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	kernelxing@tencent.com
Subject: Re: [PATCH net v4 2/8] xsk: handle NULL dereference of the skb without frags issue
Date: Tue, 28 Apr 2026 12:33:35 +0100
Message-ID: <20260428113333.1296663-3-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424053816.27965-3-kerneljasonxing@gmail.com>
References: <20260424053816.27965-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 74D77484504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281816-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/

Simon says:

Hi Jason,

I'm providing this for informational purposes.
My unedrstanding is that the problem flagged below
is not present with the full 8 patches of the series
applied.

---
xsk: handle NULL dereference of the skb without frags issue

This change guards the existing xsk_inc_num_desc()/xsk_drop_skb() calls
in xsk_build_skb()'s free_err path with an xs->skb check, and adds a new
else branch that cancels the reserved CQ slot and bumps invalid_descs
when xs->skb is NULL.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 887abed25466..54d4895fc11e 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -973,9 +973,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  		kfree_skb(skb);
>  
>  	if (err == -EOVERFLOW) {
> -		/* Drop the packet */
> -		xsk_inc_num_desc(xs->skb);
> -		xsk_drop_skb(xs->skb);
> +		if (xs->skb) {
> +			/* Drop the packet */
> +			xsk_inc_num_desc(xs->skb);
> +			xsk_drop_skb(xs->skb);
> +		} else {
> +			xsk_cq_cancel_locked(xs->pool, 1);
> +			xs->tx->invalid_descs++;
> +		}

The changelog states:

    In this series, the skb is already freed by kfree_skb() inside
    xsk_build_skb_zerocopy for the first-descriptor case, so we only need
    to do the bookkeeping: cancel the one reserved CQ slot and account
    for the single invalid descriptor.

Is that accurate for this commit?

Looking at xsk_build_skb_zerocopy() as it stands here, neither of its
error returns actually frees the skb:

    if (!skb) {
            ...
            skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
            if (unlikely(!skb))
                    return ERR_PTR(err);

            skb_reserve(skb, hr);

            xsk_skb_init_misc(skb, xs, desc->addr);
            if (desc->options & XDP_TX_METADATA) {
                    err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
                    if (unlikely(err))
                            return ERR_PTR(err);
            }
    }
    ...
    for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
            if (unlikely(i >= MAX_SKB_FRAGS))
                    return ERR_PTR(-EOVERFLOW);

            page = pool->umem->pgs[addr >> PAGE_SHIFT];
            get_page(page);
            ...
            skb_fill_page_desc(skb, i, page, offset, copy);
            ...
    }

So on the first-descriptor -EOVERFLOW path (xs->skb == NULL,
IFF_TX_SKB_NO_LINEAR device), doesn't xsk_build_skb_zerocopy() return
with the skb still allocated, up to MAX_SKB_FRAGS pages pinned via
get_page() and attached through skb_fill_page_desc(), and an
sk_wmem_alloc charge held by xsk_destruct_skb (installed by
xsk_skb_init_misc)?

Control then returns to xsk_build_skb():

    skb = xsk_build_skb_zerocopy(xs, desc);
    if (IS_ERR(skb)) {
            err = PTR_ERR(skb);
            skb = NULL;
            goto free_err;
    }
    ...
free_err:
    if (skb && !skb_shinfo(skb)->nr_frags)
            kfree_skb(skb);

Since the local skb has been set to NULL, the kfree_skb() guard is
skipped, and the new else-branch only performs the CQ cancel and
invalid_descs bump.

Doesn't that leak the sk_buff, the attached frag pages, and the
sk_wmem_alloc charge every time a first descriptor hits the i >=
MAX_SKB_FRAGS condition (or the xsk_skb_metadata failure)?

A later patch in the series, "xsk: free the skb when hitting the upper
bound MAX_SKB_FRAGS", adds an "if (!xs->skb) kfree_skb(skb);" inside
xsk_build_skb_zerocopy() before the -EOVERFLOW return, which seems to
confirm the skb is not freed at this commit. Should the changelog's
premise be reworked, or the free added here so each patch in the series
stands on its own?

