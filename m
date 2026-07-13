Return-Path: <netdev+bounces-307127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b1ZGOa/GVGo/SwAAu9opvQ
	(envelope-from <netdev+bounces-307127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:06:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5913C74A1F4
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:06:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RkI+xStK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307127-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307127-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0570A3022933
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC27E380FEE;
	Mon, 13 Jul 2026 11:06:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536FA374183;
	Mon, 13 Jul 2026 11:06:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940772; cv=none; b=p4w95O64EnWCJ2Lbho+tY6lA3pAqlidlfunj+lXQU1WzTTaae2vyGyJWt1FVdcg7CAqpis8eZ6fII87m67ZYgqiQdEiFy5KikIoV70nMJzujAOu0W0UatAPr+uPC+lZHQCiba+qfgheXyhRYnNG3mUXHvnX2oxXveOnXvuJ+de4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940772; c=relaxed/simple;
	bh=5J5cXQBce5VR8QN/VQA2lP1ZEY9o5RmO3bKYd7gsR4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBtPRbHOld1MlPf67lpZdsM5z0Gtv7QDq50NWpvOZYjqAPUCD6VXdzbXM/jQfgmm/n1rNO+Jo0VGwOUfpzJt70Wr2Qf2+T/7h/G14ApNjHstlS9Icah9OWyLaP8Tapr1BJDaSYgYbRXDD22egAo5x/sVkIdXmAjrMigM60MzpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkI+xStK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674A21F000E9;
	Mon, 13 Jul 2026 11:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783940771;
	bh=ohWt3aTjQf0vTG1RtHrEvL2ptFIhsw5uqjt4ZWrEnKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RkI+xStK+i5l7Pn35q729ItMVQWfTxXMiFNBhgXdb633nBInoqHaH0tj2RRIM3f65
	 nGSwBGneATqRQHA//dJN9FdW4E8mSG+AyPiVgaBrZWI3900wnIGrPiiZMKdYvB6K+J
	 4wysIZzlV07mc6ZMyeIALIq5TckUiRk57o6s2PB0efIybAVGDE13eKRIo2bWJRyaZU
	 LyVrW+MvyMPLy5x+XLTTAzimaEbDQC+ToeYa224bYA+9FeoEe3nzpWTXt1hNdm2TMl
	 DhoSdaQq/+cSOl+xnGhl9kf16qme23ObV+1OYe2s3XNEZSyNmmDIFz1BDhJsixrHyE
	 ttnR2m53/5xnA==
Date: Mon, 13 Jul 2026 12:06:06 +0100
From: Simon Horman <horms@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	David Carlier <devnexen@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/3] octeon_ep: fix skb frags overflow in the RX
 path
Message-ID: <20260713110606.GD1364329@horms.kernel.org>
References: <20260706150208.2944898-1-maoyixie.tju@gmail.com>
 <20260706150208.2944898-2-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706150208.2944898-2-maoyixie.tju@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-307127-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:vburru@marvell.com,m:sedara@marvell.com,m:sburla@marvell.com,m:srasheed@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maciej.fijalkowski@intel.com,m:lgs201920130244@gmail.com,m:devnexen@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,intel.com:email,ntu.edu.sg:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5913C74A1F4

On Mon, Jul 06, 2026 at 11:02:06PM +0800, Maoyi Xie wrote:
> __octep_oq_process_rx() builds an skb for a multi-buffer packet by adding
> one fragment per buffer_size chunk:
> 
> 	data_len = buff_info->len - oq->max_single_buffer_size;
> 	while (data_len) {
> 		...
> 		skb_add_rx_frag(skb, shinfo->nr_frags, buff_info->page, 0,
> 				buff_info->len, buff_info->len);
> 		...
> 	}
> 
> buff_info->len comes from the device response header
> (be64_to_cpu(resp_hw->length)). Nothing bounds the fragment count against
> MAX_SKB_FRAGS. data_len can be close to 65535. buffer_size defaults to
> about 3776 on 4K pages, so a full packet yields about 18 fragments. That
> is one more than the default MAX_SKB_FRAGS of 17, so skb_add_rx_frag()
> writes past shinfo->frags[].
> 
> The fragment count is now checked before build_skb(). A packet that needs
> more fragments than the skb can hold is dropped. octep_oq_drop_rx()
> consumes its descriptors like the build_skb failure path. The same class
> was fixed in other RX paths, including commit 5ffcb7b890f6 ("net: atlantic:
> fix fragment overflow handling in RX path") and commit f0813bcd2d9d ("net:
> wwan: t7xx: fix potential skb->frags overflow in RX path").
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_rx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> index e6ebc7e44a..bdbed58c7b 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> @@ -453,6 +453,15 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>  
>  		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
>  
> +		if (buff_info->len > oq->max_single_buffer_size) {
> +			u16 data_len = buff_info->len - oq->max_single_buffer_size;
> +
> +			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
> +				octep_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
> +				continue;
> +			}
> +		}

The AI-generated review of this patch on sashiko.dev flags that
this cannot occur for 4K pages. I believe this can be
addressed by changing the type of data_len to u32.
I also believe that a similar problem exists in patch 3/3.

   "Does truncating the data_len calculation to u16 introduce a regression
    by bypassing the MAX_SKB_FRAGS check?

    If buff_info->len is unexpectedly large, the u16 truncation of data_len
    could wrap around to a small value. This would bypass the check,
    leaving unconsumed fragments in the ring that might be incorrectly
    parsed as new packet headers."

> +
>  		skb = build_skb((void *)resp_hw, PAGE_SIZE);
>  		if (!skb) {
>  			octep_oq_drop_rx(oq, buff_info,
> -- 
> 2.34.1
> 

