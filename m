Return-Path: <netdev+bounces-254342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBs7K4E8emlB4wEAu9opvQ
	(envelope-from <netdev+bounces-254342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:42:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0CEA6074
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25C03302C30D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6932F314D0D;
	Wed, 28 Jan 2026 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH8LPlZc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463DF225390
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618310; cv=none; b=HdXjDLqSTPXeWl3M0Ls90nmiFQijj901Ulz0uBP8RMHco0+L4NOIjHlvb55/FFRwc6WcDNVThtK1Fs52BG4dxXxOrxSztxFKUK/hsQTzMqtvtaqFn/o4Nk9hY8eWsG6dGlTj9YGGbfsDK/e279YX0doaHXGZU4hqGEJomi8n+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618310; c=relaxed/simple;
	bh=xiGBXufOFrdkSaxEbKSjiKZybVgf4AR4sTOwz0krnc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvAUYdvxQehksv8Hb/lYJTEi+WJCc7LGs1uEzrZRz4Q5l53N+dkNb6/QqQ9ZyEAaoWVKlh0NIJkUiQWAcNsXR8kaGdG0QFp4McwYmxCyP/K/pYdpxBV8eqpIHN902KzXA7uxwKesBY+3ZTnoARC7lTDwss1ZKXI+ksAux5ige4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH8LPlZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D43DC4CEF1;
	Wed, 28 Jan 2026 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769618309;
	bh=xiGBXufOFrdkSaxEbKSjiKZybVgf4AR4sTOwz0krnc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WH8LPlZckK09re/S67PA52zhWxVbmK2yXkpiWSUYXIS6RSuJ/eqTtq7o6lDYcSpDf
	 /jtVGNUgcqEsP53Ly2JTthfD3RBmYQC9dA/LFEcqY1/MjAhLK7Cu9gDVpL2dqfoKH0
	 oDPwNIAVvyunLF81O4NiQxWb8GfEXAtoX6wh/sjFJswjkK+k4IdK9SaZ6avyWEwJxg
	 aiImXEDa2ELxjYRtZWO/q0SxAC6VhbQZAu839zDLtIsQUdGXAEdsWxLyZqUrEI4jdP
	 0QDS3znSoDTGcIuEABR2k2Bz4L2+Iwwte9M0O4RQKci6RAcRKCF5z2Xp2m+SyOfkf6
	 a51yqKbw57n8g==
Date: Wed, 28 Jan 2026 16:38:24 +0000
From: Simon Horman <horms@kernel.org>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jkarrenpalo@gmail.com,
	tglx@linutronix.de, mingo@kernel.org, allison.henderson@oracle.com,
	petrm@nvidia.com, antonio@openvpn.net, bigeasy@linutronix.de,
	Steffen Lindner <steffen.lindner@de.abb.com>
Subject: Re: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate
 discard for PRP
Message-ID: <20260128163824.GB172540@kernel.org>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,de.abb.com];
	TAGGED_FROM(0.00)[bounces-254342-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D0CEA6074
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 03:56:59PM +0100, Felix Maurer wrote:

...

> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c

...

> +/* Get the currently active sequence number block. If there is no block yet, or
> + * the existing one is expired, a new block is created. The idea is to maintain
> + * a "sparse bitmap" where a bitmap for the whole sequence number space is
> + * split into blocks and not all blocks exist all the time. The blocks can
> + * expire after time (in low traffic situations) or when they are replaced in
> + * the backing fixed size buffer (in high traffic situations).
> + */
> +static struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node,
> +					       u16 block_idx)
> +{
> +	struct hsr_seq_block *block, *res;
> +
> +	block = xa_load(&node->seq_blocks, block_idx);
> +
> +	if (block && hsr_seq_block_is_old(block)) {
> +		hsr_forget_seq_block(node, block);
> +		block = NULL;
> +	}
> +
> +	if (!block) {
> +		block = &node->block_buf[node->next_block];
> +		hsr_forget_seq_block(node, block);
> +
> +		memset(block, 0, sizeof(*block));
> +		block->time = jiffies;
> +		block->block_idx = block_idx;
> +
> +		res = xa_store(&node->seq_blocks, block_idx, block, GFP_ATOMIC);
> +		if (xa_is_err(res))

Hi Felix,

I ran Claude Code over this with review-prompts [1] and it flags
that in the error path above, the following is needed so that the
block can be re-used.

			block->time = 0;

[1] https://github.com/masoncl/review-prompts/

> +			return NULL;
> +
> +		node->next_block =
> +			(node->next_block + 1) & (HSR_MAX_SEQ_BLOCKS - 1);
> +	}
> +
> +	return block;
> +}
> +

...

