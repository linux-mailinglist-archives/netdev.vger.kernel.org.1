Return-Path: <netdev+bounces-288149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CERaIod6BmqFkAIAu9opvQ
	(envelope-from <netdev+bounces-288149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:44:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 071865487EF
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6F3A306C4FA
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F09936EAA2;
	Fri, 15 May 2026 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDoIrxHd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9BB34CFC7;
	Fri, 15 May 2026 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809381; cv=none; b=u42jcjmxesYhZSjbiNWFSIlw90S/swbS0C7qFvvCNc/sF50mHaXWExkiN3nWdvqslwjGhFzkwRtSQ0pR07X/1J0tvYpOO/DvrJbZnEaFnGjdjI4wUlhFHrGp06RnvOwBPFQV9k7vyLbofi54HCpumzmODjNas3PtMrcHNwwD5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809381; c=relaxed/simple;
	bh=M7O/RNkIv1ZToATfgpVawi9acQM43wQ1QWz9tPxAxOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egUTtqVH0jVOSkts9ZdrXr/xM21hIxMtE4CTMCdHN2ZnF1FiQU5jND2BCDHfiLGaHnAGbsM2GAHjkyhPH9NUwu0PUr8A/KqMGii8E2RxbPDrquxAyLjRKoWKdJ/rrcUw/w7Jln/TYFt79Z8cHUb1NQyt/WiGFxCk8qzZYihLDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDoIrxHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A864C2BCB3;
	Fri, 15 May 2026 01:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778809380;
	bh=M7O/RNkIv1ZToATfgpVawi9acQM43wQ1QWz9tPxAxOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SDoIrxHdB20tuaH89MWvlBkqcieAJeNNYSe6BjV9JXUvd1W9zJoJnvKz3786P/eL9
	 ljIO9d3RMrTpDSOKX5ImrPaPhKMDP+csA7v05CILX//RlpAiw4Qq/SZZwTKA5/ZNPj
	 yI07fYFChsTgdUXysv51e7W+k6OFcLdBYCgPSoY3tbKTQ6TSGQEku3+BdP//R/bpct
	 PARFYxVg5Uxlu4myi7yzIso+yJ3IyL7dITG3+q/XzWQeJ7lE2cFtaYbKWTO0CtpVj9
	 X/yRl2KwP35n68QaQh/tzbRm2wVccG8J6wpP608UJtkYJZpLDDVzmCGCWNlhb5gwn+
	 VTj4Eh4u7Pnkg==
Date: Thu, 14 May 2026 18:42:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ipv6: route: Unregister netdevice notifier on BPF
 init failure
Message-ID: <20260514184259.3a852f9e@kernel.org>
In-Reply-To: <20260514002218.677943-1-dbgh9129@gmail.com>
References: <20260514002218.677943-1-dbgh9129@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 071865487EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288149-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 13 May 2026 20:22:18 -0400 Yuho Choi wrote:
> ip6_route_init() registers ip6_route_dev_notifier before registering the
> IPv6 route BPF iterator target. If bpf_iter_register() fails, the error
> path jumps to out_register_late_subsys and unwinds the RTNL handlers and
> late pernet subsystem, but leaves the netdevice notifier registered.
> 
> Add a separate unwind label for the BPF iterator failure path so the
> netdevice notifier is unregistered before continuing with the existing
> cleanup.
> 
> Fixes: 138d0be35b14 ("net: bpf: Add netlink and ipv6_route bpf_iter targets")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>

> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index cb521700cee7..4333e11dc9c5 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -6925,7 +6925,7 @@ int __init ip6_route_init(void)
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
>  	ret = bpf_iter_register();
>  	if (ret)
> -		goto out_register_late_subsys;
> +		goto out_register_notifier;
>  #endif
>  #endif
>  
> @@ -6939,6 +6939,12 @@ int __init ip6_route_init(void)
>  out:
>  	return ret;
>  
> +#if IS_BUILTIN(CONFIG_IPV6)

Why this check?

> +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
> +out_register_notifier:
> +	unregister_netdevice_notifier(&ip6_route_dev_notifier);
> +#endif
> +#endif
-- 
pw-bot: cr

