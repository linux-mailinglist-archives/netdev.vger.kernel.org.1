Return-Path: <netdev+bounces-275040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB1KJBO/z2kM0QYAu9opvQ
	(envelope-from <netdev+bounces-275040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:22:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4322394639
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6285F3024506
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7FF3A960A;
	Fri,  3 Apr 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8Xgcu83"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7623A383C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222544; cv=none; b=p3g+gtDw3HdqSCsC1MOh6/LX5zPHZfPW5iir4qnDKIG/nSCGBH/u/Da2oOhAlrBMCFeDNr5ZFzO+atLaZDWnmzEafy30slS9rV2idwFU6FatT7lKiTHDM1biTYKcvlRj/XEM5bGxafI6/If9632j4bGhkGUitvUKkFOjTN6eJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222544; c=relaxed/simple;
	bh=XJaKaKKd6LcAtQg1wJb8HMrtsWbfEKIHuq5U5a185ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfBwPOUbI1XvIAiqGYz+BAdOVXASKEMn5rEf/LHIeFRRBfB5w6VAf54FlvalS1flXeRNG7ih/Ar/bLPbv6bjwqQgiKJHJf02VatfmzB8qlnk5c3yGdxlu25tBgDUXuyMaAkrFSTLG43/2c2yqTIDk8fn6qW6sjFLecZXH2QymsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8Xgcu83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3385AC4CEF7;
	Fri,  3 Apr 2026 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775222544;
	bh=XJaKaKKd6LcAtQg1wJb8HMrtsWbfEKIHuq5U5a185ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8Xgcu83rmjiuAHx96HukGqJKnEkqu790+UWaNwBTNHFniryumfHQgRr8S2JwIJbH
	 q84Ho/tCh0N/QnuMEVqxjWXTCxvM+FC0+SU0YqiGEm25/b0h4NoQuytecixgsTWTim
	 0KqU68/JAtnJQfEutYsTtHdCxteJojQh87Ib0WrNhbJ2QtpcvbhXAl4mzEsAg8J7Ui
	 f29i8FnbIz9mJ9lugCx+9HoRzdLylFOMEOQ8hpAE8+XVMuhWYy7gwkdQ8bo5tJIlQJ
	 LMAbzAu+9AN+fRdXXXWzRvMQG8axNx9pjRuyglz6bljZGx84Rx2S3yggW7jDpYk7AT
	 Jnj0vtjlmhLgg==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: replace GFP_ATOMIC with GFP_KERNEL in ixgbe_fcoe_ddp_setup()
Date: Fri,  3 Apr 2026 14:21:52 +0100
Message-ID: <20260403132152.121293-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327073046.134085-7-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-7-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275040-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: D4322394639
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ixgbe: replace GFP_ATOMIC with GFP_KERNEL in ixgbe_fcoe_ddp_setup()

This commit changes the memory allocation flag in ixgbe_fcoe_ddp_setup()
from GFP_ATOMIC to GFP_KERNEL based on the claim that the function is
never called from atomic context.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> index 011fda9c6193..7fa0971073e5 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> @@ -193,7 +193,7 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
>  	}
>
>  	/* alloc the udl from per cpu ddp pool */
> -	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_ATOMIC, &ddp->udp);
> +	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_KERNEL, &ddp->udp);
                                                    ^^^^^^^^^^
Doesn't this allocation happen in atomic context? Looking at the function,
get_cpu() is called earlier:

ixgbe_fcoe_ddp_setup() {
    ...
    ddp_pool = per_cpu_ptr(fcoe->ddp_pool, get_cpu());
    ...
    ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_KERNEL, &ddp->udp);
    ...
    put_cpu();
}

get_cpu() disables preemption, which means GFP_KERNEL allocations (which
can sleep during direct reclaim) would trigger a BUG() when attempted with
preemption disabled.

The commit message claims the function is "never from an atomic context",
but while the callers may be in process context, the function itself creates
atomic context via get_cpu().

>  	if (!ddp->udl) {
>  		e_err(drv, "failed allocated ddp context\n");
>  		goto out_noddp_unmap;

