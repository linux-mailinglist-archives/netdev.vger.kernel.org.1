Return-Path: <netdev+bounces-281536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFkCJaTt72mjKgEAu9opvQ
	(envelope-from <netdev+bounces-281536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:13:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2134C47BBC4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A12C301A1E3
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057E13AE18D;
	Mon, 27 Apr 2026 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjGgC9r3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C8221FBB
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777331616; cv=none; b=WmFhORLsD1NCUGbpupwbDj1thn2+IjlYVwLQunuMWBMR9gdaLGR50Mc6qc6PTmL33mfdVJCD8/3azxTQ16FeM2xGuNyhTfZG7RLnHm6Ugn2ixKasE0fbtB9ArEzLr1nGPOCoclAuTFXZzn0b3go3aGBK+k6JIA4TC0FnDB8qSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777331616; c=relaxed/simple;
	bh=WuZkZ0lxPeq9fY7/KLT8TxVkxDvCvd+qRE8eCtHmGis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSIu6ilLrCicQdPJA4zgQJVjZAqPiIFsn8kbwLnk0BAOYEdkFehFkDCsLvItFDlfguq52AfBXVbCbQP9hG27NUjB4y4xdvc5uFQf2QTxeEprO0mDZjy5enwIomWqmjugqLjqlorN1wcECBdAeSOoRo8lvNzyGzZCdfYYOCnibqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjGgC9r3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB97DC19425;
	Mon, 27 Apr 2026 23:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777331616;
	bh=WuZkZ0lxPeq9fY7/KLT8TxVkxDvCvd+qRE8eCtHmGis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tjGgC9r3rM7HqD0M9uKciF5i1XnlEWOL5Im6HEosJiwFCea0usTlZDE//+SaBTiIY
	 ceUM7XNWPynkYLtO7LaJqYnHJonUit8y5NWej2k9RzfhSShX8BY8yboruL8RA0mrms
	 RI1dAOJrKqEphGz0FqoeX3VCFLzJFe47Mek6b4oBYLw5CCUfKZxxXM5Ck2OYTsrb7Q
	 8urvR/EnUb51JpVOEcKr+hh9N9Z7R95p4WBroD9Mxp+d8SyGc4ibddGnnb/f9gltFe
	 iFJuZdRv0yOzNDSo4CyZ/KHxwy7rVAq2sleDyR65UarRAwcFeBdftSX5xshSBhtVYw
	 92cPrS+QHZZBA==
Date: Mon, 27 Apr 2026 16:13:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/4] net/sched: switch tc_dump_qdisc() to
 for_each_netdev_dump()
Message-ID: <20260427161335.500f80d3@kernel.org>
In-Reply-To: <20260427132555.1791636-4-edumazet@google.com>
References: <20260427132555.1791636-1-edumazet@google.com>
	<20260427132555.1791636-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2134C47BBC4
X-Rspamd-Action: no action
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
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281536-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 13:25:54 +0000 Eric Dumazet wrote:
> +	for_each_netdev_dump(net, dev, ctx->ifindex) {
>  		struct netdev_queue *dev_queue;
> +		struct Qdisc *q;
>  
> -		if (idx < s_idx)
> -			goto cont;
> -		if (idx > s_idx)
> +		if (ctx->ifindex > s_ifindex)
>  			s_q_idx = 0;

I don't think we need this conditional now that we use for_each_netdev_dump()
We can just add

	s_q_idx = 0;

right before closing bracket of the loop?

>  		q_idx = 0;

