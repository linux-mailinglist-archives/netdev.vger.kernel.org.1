Return-Path: <netdev+bounces-263480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIIZFNF3p2kchwAAu9opvQ
	(envelope-from <netdev+bounces-263480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:07:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B220B1F8B52
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9556B311472F
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF621B6D08;
	Wed,  4 Mar 2026 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpP3Q+PN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1841917F0;
	Wed,  4 Mar 2026 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582616; cv=none; b=pmQsoYoFM7Wgc3m6UIQ5YXp0dBntpZahwIhZnBcuNmbN+rOcj+1cf0ORs7nnKJhXyOURMqTVl/pPbKnEW/ekNrmUpXadljvXLtKJNdkD0xw87RBot68unuemsbS40UwMcQmAFFLpkOffXhPvXyeFXyPtykigi3dLywsmdUslYEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582616; c=relaxed/simple;
	bh=8Wd/E9eQnTNShMZJGc8e+/czqhvUxV+VKhAeCGLrEjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9qAqk4LghdzrdntQ+G2207hyByZEhQELMzdxrYBgOkGs3oUxY6I87xaLZL4ZHkfXh80ML8XhEI7cEJHf8v25yxLlnl3T9MnWFpphcdXpT8ImExxCkZYAGFy5/YVtwHgOx53ua7iIybAtRtGQOeQbDx4C400JdVIQxJKVRhsbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpP3Q+PN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3AAC116C6;
	Wed,  4 Mar 2026 00:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772582616;
	bh=8Wd/E9eQnTNShMZJGc8e+/czqhvUxV+VKhAeCGLrEjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mpP3Q+PNEsl5H84XDjPFZlXt1yWkTIa92f6iN4h7qYw5/BgLcB7MgUO5IILSnVlw9
	 Tk9KAqpQVItQK0bqHgfUgO70ePzgY5PtFvY3kMwZKDkzGLJ0Vf/GVJrD1XbpH6UacE
	 EndCIwInXQ0TTgOt/tQLNI0SQnzpI5IxeS07bo2TWJS+eYR4z2QeL39uMmBKIAzpS3
	 3eImbqFRRdNmdR7SXuGtxZ8QaYB4C57YGRwd9g1ySAXx6MdX723+ciCVKwqwevCtmf
	 +vkYYrpaWWmxFnMUYb9pVGM4g752vwR7XyP8x51L6goscD1OUjxn66e+zi61JlCh9+
	 Bdz/yOho7uKSw==
Date: Tue, 3 Mar 2026 16:03:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 1/5] ethtool: Add RSS indirection table resize
 helpers
Message-ID: <20260303160334.39276d7f@kernel.org>
In-Reply-To: <20260303181535.2671734-2-bjorn@kernel.org>
References: <20260303181535.2671734-1-bjorn@kernel.org>
	<20260303181535.2671734-2-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B220B1F8B52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263480-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue,  3 Mar 2026 19:15:29 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> +/**
> + * ethtool_rxfh_indir_can_resize - Check if an indirection table can be =
resized
> + * @tbl: indirection table
> + * @old_size: current number of entries in the table
> + * @new_size: desired number of entries
> + *
> + * Validate that @tbl can be resized from @old_size to @new_size without
> + * data loss. Read-only; does not modify the table.
> + *
> + * Return: 0 if resize is possible, -%EINVAL otherwise.
> + */
> +int ethtool_rxfh_indir_can_resize(const u32 *tbl, u32 old_size, u32 new_=
size)

maybe pass it extack so that all the callers don't have to set it
themslves?

> +{
> +	if (old_size =3D=3D 0 || new_size =3D=3D 0)
> +		return -EINVAL;

defensive programming?

> +	if (new_size =3D=3D old_size)
> +		return 0;
> +
> +	if (new_size < old_size) {
> +		if (old_size % new_size !=3D 0)

please try not to compare things to zero in C, it reads as double
negation

BTW I guess that this expression to cover both branches would be
unreadable right? :D

	if (new_size + old_size % min(new_size, old_size))
		return -EINVAL;

> +			return -EINVAL;
> +		if (!ethtool_rxfh_indir_is_periodic(tbl, old_size, new_size))
> +			return -EINVAL;
> +		return 0;
> +	}
> +
> +	if (new_size % old_size !=3D 0)
> +		return -EINVAL;
> +	return 0;
> +}
> +EXPORT_SYMBOL(ethtool_rxfh_indir_can_resize);
> +
> +/* Resize without validation; caller must have called can_resize first */
> +static void __ethtool_rxfh_indir_resize(u32 *tbl, u32 old_size, u32 new_=
size)
> +{
> +	u32 i;
> +
> +	/* Unfold (grow): replicate existing pattern; fold is a no-op on the da=
ta */
> +	for (i =3D old_size; i < new_size; i++)
> +		tbl[i] =3D tbl[i % old_size];
> +}

> +/**
> + * ethtool_rxfh_contexts_resize_all - Resize all RSS context indirection=
 tables
> + * @dev: network device
> + * @new_indir_size: new indirection table size
> + *
> + * Resize the indirection table of every non-default RSS context to
> + * @new_indir_size. Intended to be called from drivers when the
> + * device's indirection table size changes (e.g. on channel count
> + * change). An %ETHTOOL_MSG_RSS_NTF is sent for each resized context.
> + *
> + * All contexts are validated before any are modified, so either all
> + * contexts are resized or none are.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int ethtool_rxfh_contexts_resize_all(struct net_device *dev, u32 new_ind=
ir_size)
> +{
> +	struct ethtool_rxfh_context *ctx;
> +	unsigned long context;
> +	int ret;
> +
> +	if (dev->ethtool_ops->rxfh_indir_space =3D=3D 0 ||

!dev..

> +	    new_indir_size > dev->ethtool_ops->rxfh_indir_space)

extack needed?

> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &dev->ethtool->rss_lock) {
> +		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
> +			ret =3D ethtool_rxfh_indir_can_resize(ethtool_rxfh_context_indir(ctx),

80 char limit width limit is still king in netdev
please shrink the length of the helpers you're adding?
And/or take the locks in a normal way..

> +							    ctx->indir_size, new_indir_size);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
> +			__ethtool_rxfh_indir_resize(ethtool_rxfh_context_indir(ctx),
> +						    ctx->indir_size, new_indir_size);
> +			ctx->indir_size =3D new_indir_size;
> +		}
> +	}
> +
> +	xa_for_each(&dev->ethtool->rss_ctx, context, ctx)
> +		ethtool_rss_notify(dev, ETHTOOL_MSG_RSS_NTF, context);

Why a separate loop ?

> +	return 0;
> +}
> +EXPORT_SYMBOL(ethtool_rxfh_contexts_resize_all);

