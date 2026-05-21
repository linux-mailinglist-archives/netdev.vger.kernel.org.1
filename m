Return-Path: <netdev+bounces-290151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAAdMJdMDmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:06:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF3559D26E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C280301484A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765553EA66;
	Thu, 21 May 2026 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgjvGo5D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06C11CBA
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321921; cv=none; b=KjBJ1ofN9Ru9oxpcO3OUddnLy1yjKab1OaFdwxJ8fLn1dDsNyinUPooPYVdQnTAqGLwns1rTCaY3Opn/mdtOy7pU5P25cgaljrz4pO5rytDVkDH+FtIgp4Eazc5bwoF/RpBUeQXocHHUVgs7un0YwQAPwcNRZoBomULgZJzpvQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321921; c=relaxed/simple;
	bh=BbtGjjmeI2nVsSBJfqYLmKm3sQ2wmIxqjbeHSi9rv+A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Hi6azPweE3/TkWg6chxnaO4YO/rLGGyC0ZqrNtHwi7HJKHCZqkje7YzwULnQnwR0fxCt2U7vBDvMalC665MRrGZDZYxg01Xs069w3fqck9fGMUHIQF8aifPYysh0uk/qX9vZrPCspPWfonRYO+Gl2Zk7JJswM4M9HLvfBwymcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qgjvGo5D; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7bd9f61458eso40118017b3.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779321918; x=1779926718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4bH0PWwVzIcDIt4+BnyuzrmluUQcP68Q7Zx7vTal4I=;
        b=qgjvGo5DQZcfdXg2G8z4VJQW8GFXwVJm1jmYgoM0uHpewOTkVKDK4rbTjNEG8NdS2d
         QZ5dFje1OVRpTXJcplj9g81EomQrO3H2AsPnNOEJXmTzCFF5+cDgWKUTTMMlO5H407BT
         mfo/Rq/YZlBTizeafQweDV0ZHa+6jeYdo6MumZ7epnerdXsKGKZ0HVPtJ/vAYZkAK11n
         Z/tFxOhM5bQJsmknUNBBl7KlkuflVMHWsvz8dzeRa8BPUbiMKNE7ykDJH3tJWA/YpzpG
         KAZw2GXQ2irOJuWJi/htqSmTjfTujYWyU/DmawAaYHPQvasfIN+Y8wuTOE+LkjQUsSl5
         BgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779321918; x=1779926718;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4bH0PWwVzIcDIt4+BnyuzrmluUQcP68Q7Zx7vTal4I=;
        b=MYFcS5v/J0EgRFKCufnv/YbfdrSQjw7l5ddUeyMRyB0AmPjHxSW4jijm6mcRbuTRr5
         Uy3ULTRhXxyWRHbEqWjcr969cpMr88JRSTC1LW9Bplh5FRlPmCpWdXj6fX06djpkN+ng
         CtG1fWU1AItn2cMOsZHAmlzXrv7eqWMB7pOmm/PV+KeFKq7BUSZAryx1S/kS3RKyV0lr
         qbVfKgmwXpEXg9NZt7IhGA3QfackLt25uZz52hJOIi59sfXWiN267iMKgTki0zQE6O49
         j16Uid4RsCfC0ZwBQaJkGsUdV2sOoBWYVBBtp84HYwzVU1ULO+NlH20PsI3Ix+H0uqHm
         UZCg==
X-Forwarded-Encrypted: i=1; AFNElJ//2C/Sp6x2OCSCTd41uDuTZWBIVQrbMyRxd0xj1Su0IXaJm4BcDv/6+l93RMQJUBdMKT3zO/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx2o8jw+JL5UWD8ne7frLJtRbIz0aGkiWkF+QDs+/dV/L5XeuO
	zNxWjVbjwMrwYGt9yE7taakoUwAxbG+UdIrgmrRpSyXxc2OwRWVjA+rC
X-Gm-Gg: Acq92OEUfoiBXPlJtr4CJNUAe8hOi7/GBhU3dfKdHiMCgJdwOz3vKuVzKxcihINcfdG
	+tpzH7YjLa5ArXMzJaN9kJKiM88x0xm9TWmyZ4rhM9PANFxrUN/fE9ch3miwtFKaG6hGA5o22nS
	X/pdnRDugWeaQcW6ki6WSiPCHqrtDeiiu31mVm3Rea0oKsnPPuXiWMqEYUSQUdNazyslfFyADyC
	0S52lDwTcYG0yBUaZYeD3lWI6Jv1Bh2Nq0UO8IODUAjXXkzGhbZ/xitYn4eFdYZDH+gTyATAeq6
	iKcDFOxF35BLx3ylc65ih71bsGHY6UhBGNGCcia+/FaryhwHY21SJPq6GwlbyfJYehYG9+IF9B5
	T/gXL8H2c5d1kT4Ip187LcL1PDbVKcT7Dh8PLI/wMwJG6Zn6IC2tZW8S74irwgv9gE1B9Hmc8mo
	RAtRi2rUqse5ZX6cehrLPSzvObvpofXJqEcYEIw6dMbi91qDhpdGWKqgDSjev1QCVkqclflzSNk
	RJA
X-Received: by 2002:a05:690c:9b08:b0:7d0:4824:6411 with SMTP id 00721157ae682-7d20dff3867mr7208317b3.47.1779321917557;
        Wed, 20 May 2026 17:05:17 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc991c9aefsm59495767b3.9.2026.05.20.17.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:05:17 -0700 (PDT)
Date: Wed, 20 May 2026 20:05:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 pabeni@redhat.com, 
 kuba@kernel.org, 
 edumazet@google.com, 
 dongli.zhang@oracle.com, 
 xmei5@asu.edu, 
 linux-kernel@vger.kernel.org, 
 Weiming Shi <bestswngs@gmail.com>
Message-ID: <willemdebruijn.kernel.28580e8a2708a@gmail.com>
In-Reply-To: <20260520160020.375349-2-bestswngs@gmail.com>
References: <20260520160020.375349-2-bestswngs@gmail.com>
Subject: Re: [PATCH net] tun: free page on short-frame rejection in
 tun_xdp_one()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,google.com,oracle.com,asu.edu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290151-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BCF3559D26E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Weiming Shi wrote:
> tun_xdp_one() returns -EINVAL on a frame shorter than ETH_HLEN without
> freeing the page that vhost_net_build_xdp() allocated for it.
> tun_sendmsg() discards that -EINVAL and still returns total_len, so
> vhost_tx_batch() takes the success path and never frees the page; each
> short frame in a batch leaks one page-frag chunk.
> 
> A local process that can open /dev/net/tun and /dev/vhost-net can hit
> this path: it attaches a tun/tap device as the vhost-net backend and
> feeds TX descriptors whose length minus the virtio-net header is below
> ETH_HLEN. Each kick leaks the page-frag chunks for that batch, and a
> tight submission loop exhausts host memory and triggers an OOM panic.
> Free the page before returning -EINVAL, matching the XDP-program error
> path in the same function.
> 
> Fixes: 049584807f1d ("tun: add missing verification for short frame")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  drivers/net/tun.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index b183189f1853..f594360d66d6 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2394,8 +2394,10 @@ static int tun_xdp_one(struct tun_struct *tun,
>  	bool skb_xdp = false;
>  	struct page *page;
>  
> -	if (unlikely(datasize < ETH_HLEN))
> +	if (unlikely(datasize < ETH_HLEN)) {
> +		put_page(virt_to_head_page(xdp->data));
>  		return -EINVAL;
> +	}

Make sense, thanks.

The error path from tun_xdp_act does the same. And the default: label
used to too, before a batching optimization was introduced.

Is the same then also missing if build_skb fails?


