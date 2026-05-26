Return-Path: <netdev+bounces-291799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAqEGoPNFWoTcAcAu9opvQ
	(envelope-from <netdev+bounces-291799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:42:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EC75D9E5B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09722306F4BF
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7033AEF4F;
	Tue, 26 May 2026 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hNxarPoR"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A13AE704
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811464; cv=none; b=CBOc5tABu7st8XN7f7zJUYYtnKs48va69IiPp+P0WIc5W/z72mCEkWocIkwPrnPzmBARM2sbjTUby3qLt4Aiz9eO+kaKc2N9TxvLIZefacCfo5TDUmjx21vzGeHLEcxVJE+bePo3mDSLhNahC+on8aL7/lloJdq7Vy+LoDK4bGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811464; c=relaxed/simple;
	bh=e47KtkrYO57OJXfoa2/QJlN8g5myP7AFeS9mCx07YsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcwZh4byHHBn9m11kK+yylmkXAzeu4kQsePTPL51htur22jO2QeYSQR7UXWWCMpK1M8HnEJgoqyNYf5LcV7nxhrrZu6ixz85Cds897mcs+k5cm5jsu9N/0wyU7fKs9G26bm/cyEPldJ3VOXcmK3eq46WVuTHHqoZEYJQeYiYF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hNxarPoR; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <06218bf6-5e3b-4f68-b888-451c054a662c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779811460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsCDhvn0IsYvzvFC28oYc41j9171fM0D3hLs9SoKx6Y=;
	b=hNxarPoRzF9S+9LroGK/dPbgoXul/hNEqCItSfrenciPeKndq/XeF5uc5XgxvWvQQqILxF
	MhduSS6MrfWZwWaAvP3ejc/dhmZ7PtWtET8EmjjYP4f0Sb3WUOcXvZ69eJzj5PQz+8Fx+/
	OpQls9ELLrwrbXgaMfJhajJDqe6Ob6A=
Date: Tue, 26 May 2026 17:04:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 02/10] ethtool: tsconfig: fix reply error handling
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 haiyangz@microsoft.com, andrew@lunn.ch
References: <20260526153533.2779187-1-kuba@kernel.org>
 <20260526153533.2779187-3-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260526153533.2779187-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291799-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 11EC75D9E5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/05/2026 16:35, Jakub Kicinski wrote:
> A couple of trivial bugs in error handling in tsconfig_send_reply().
> If we failed to allocate rskb we need to set the error.
> If we did allocate it but failed to send it - we need to remember
> to free it.
> 
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: vadim.fedorenko@linux.dev
> CC: kory.maincent@bootlin.com
> ---
>   net/ethtool/tsconfig.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
> index e4f518e49d4c..e9db4ee2299d 100644
> --- a/net/ethtool/tsconfig.c
> +++ b/net/ethtool/tsconfig.c
> @@ -224,16 +224,21 @@ static int tsconfig_send_reply(struct net_device *dev, struct genl_info *info)
>   	reply_len = ret + ethnl_reply_header_size();
>   	rskb = ethnl_reply_init(reply_len, dev, ETHTOOL_MSG_TSCONFIG_SET_REPLY,
>   				ETHTOOL_A_TSCONFIG_HEADER, info, &reply_payload);
> -	if (!rskb)
> +	if (!rskb) {
> +		ret = -ENOMEM;
>   		goto err_cleanup;
> +	}
>   
>   	ret = tsconfig_fill_reply(rskb, &req_info->base, &reply_data->base);
>   	if (ret < 0)
> -		goto err_cleanup;
> +		goto err_free_msg;
>   
>   	genlmsg_end(rskb, reply_payload);
>   	ret = genlmsg_reply(rskb, info);
> +	rskb = NULL;
>   
> +err_free_msg:
> +	nlmsg_free(rskb);
>   err_cleanup:
>   	kfree(reply_data);
>   	kfree(req_info);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

