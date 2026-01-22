Return-Path: <netdev+bounces-252486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KehCG9ocmnckQAAu9opvQ
	(envelope-from <netdev+bounces-252486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:11:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7696C164
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA3B2300333A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656A537473B;
	Thu, 22 Jan 2026 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r+wgyCpi"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731C37472A
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105507; cv=none; b=CAkye/SBXPFMSQhnLu1zRk1jQFm7S3r4kxPDtn1HZKZF8UXrD0SdC2CND6DySzpsq11v2QF1Go/8yK7dAzt/jR9LKBPkmAA9O8ZQUqHMpA0k7fEaJPadU9cthwJsaVpi7bruNaZKgjQYY3UOmYoqoQgHDQGYsmQ/26t/5Lo3cis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105507; c=relaxed/simple;
	bh=tYM5UC9SSsqxFoxnsUD+fb34UZyp35wuUETsu4zZA1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+vXj616VRHpRpSNU6VEux0bcbfE72+q2guZ1/F5OH1rNJT3jKYmTax7GI1xDct2rNw0H9/rpX83uTuUfv1DTzpgE7TNh3p/0D4ZMzAsoHG91svdj9mH/c5anAPgbkN8JN3/KD2ULLJU70fziXsbFoty9xUjyIQZBVFi4pVPchk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r+wgyCpi; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d13f6f33-7489-4e70-8b7b-401d2200a5a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769105483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3qF3Oh1VVPLvk+yk9IepnLjR5SkTZ5MYLgq+jNxdc8=;
	b=r+wgyCpinHDM2tEJdLICy5l6d2m4Bu1VxpdtRkYHnMbY6sKUoyK8bCnzaM4DC9FqPC2QWZ
	kMgnsuwmsZiPno7O3rbkygCcDP3+IYauGsz7xSWA7NdtAb7bTTIPe4b98u9gJlB5kTcTSr
	8AdahcVPsqKa0h749xQpgbFBBpLy6pU=
Date: Thu, 22 Jan 2026 18:11:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] octeon_ep: Fix memory leak in octep_device_setup()
To: Zilin Guan <zilin@seu.edu.cn>, vburru@marvell.com
Cc: sedara@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260121130551.3717090-1-zilin@seu.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260121130551.3717090-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252486-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D7696C164
X-Rspamd-Action: no action

On 21/01/2026 13:05, Zilin Guan wrote:
> In octep_device_setup(), if octep_ctrl_net_init() fails, the function
> returns directly without unmapping the mapped resources and freeing the
> allocated configuration memory.
> 
> Fix this by jumping to the unsupported_dev label, which performs the
> necessary cleanup. This aligns with the error handling logic of other
> paths in this function.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
> 
> Fixes: 577f0d1b1c5f ("octeon_ep: add separate mailbox command and response queues")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>   drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> index bcea3fc26a8c..57db7ea2f5be 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -1338,7 +1338,7 @@ int octep_device_setup(struct octep_device *oct)
>   
>   	ret = octep_ctrl_net_init(oct);
>   	if (ret)
> -		return ret;
> +		goto unsupported_dev;
>   
>   	INIT_WORK(&oct->tx_timeout_task, octep_tx_timeout_task);
>   	INIT_WORK(&oct->ctrl_mbox_task, octep_ctrl_mbox_task);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

