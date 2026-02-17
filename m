Return-Path: <netdev+bounces-259074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPy7GC+LlGnTFQIAu9opvQ
	(envelope-from <netdev+bounces-259074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:37:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2C714DA04
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7247C301992F
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBC236B05F;
	Tue, 17 Feb 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYucySqW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9735D5E2
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342625; cv=none; b=Cs8l0Hku8o97i5ZqefRc363qG2vL7J9uk0Bu32ZSWliJ+PQWDN42s51XxXPPK80gG3xX4dvSTqMp/Ednoz/ITvbTp18lwkM1P08RaybGZNL/h/9YrjFFs4eS0M1H4i/CFVHuLpdwU/ed7nxnm+nYTyUUHHsaNbX3toFkGZeQLB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342625; c=relaxed/simple;
	bh=+hQqWLubS7KMSAh2xl7ApuJordRXcLSUhTiJ+0dEOyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKkKRr22SAoC/oFmH9XPxwyT099FXXN/0Odggka0OFXDK5DguQZezXs3IouibVdlcLUic0pku/0xezvkQ5y3h3W/pfkJjgruXjFcry2KX0cETLyHe9/NxjQUrQnz7ALp0YTRAce0Wmj8A7sI4hTm4P4/b/4KVsNUT0FVtJ3ty9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYucySqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCDBC4CEF7;
	Tue, 17 Feb 2026 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771342625;
	bh=+hQqWLubS7KMSAh2xl7ApuJordRXcLSUhTiJ+0dEOyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYucySqW6hhApWavBUynAzTlgIjd/KZXB9tNd0H9Hugk0GOxuVIeygSC0dnm5y/RO
	 0ursXBDrDNXT8rwbdXcsPIq9g9g9clF1cyknHPs9KbF7MFHEsv20uMq+ot2WmfvGMZ
	 YSOwaH26NeBWttjqIhAjWWKkQUI0dzO28/AmMdCZ7HxqlSr1p7HzaXw/o3BovI6Yk5
	 QQ1kDqetejWokHzA4kcxBnwFMK4AnFNsNPRfBjqWejHZzxsnyO/heYod1t6HihGHSa
	 w/jbPi8EWQFu38p/eC9fZUbdm7n3nhRsq/+fPCSXjCSnFUvfeJix3ahUJt8R9PHO4T
	 yVxHbL45FMPSw==
Date: Tue, 17 Feb 2026 15:37:01 +0000
From: Simon Horman <horms@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: tls: Use disable_delayed_work_sync() instead of
 cancel_delayed_work_sync() in tls_sw_cancel_work_tx()
Message-ID: <aZSLHaFj7k8DPmLG@horms.kernel.org>
References: <aZLotq3aZY0b-dI8@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZLotq3aZY0b-dI8@v4bel>
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
	TAGGED_FROM(0.00)[bounces-259074-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB2C714DA04
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 06:51:50PM +0900, Hyunwoo Kim wrote:
> After cancel_delayed_work_sync() is called from tls_sk_proto_close(), 
> tx_work_handler() can still be scheduled from paths such as the 
> Delayed ACK handler or ksoftirqd.
> As a result, the tx_work_handler() worker may dereference a freed 
> TLS object.
> 
> To prevent this race condition, cancel_delayed_work_sync() is 
> replaced with disable_delayed_work_sync().
> 
> Fixes: f87e62d45e51 ("net/tls: remove close callback sock unlock/lock around TX work flush")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Hi Hyunwoo,

Thanks for your patch(es).

Some feedback on process from my side.
You can read more about that at
https://docs.kernel.org/process/maintainer-netdev.html

* I think it would be good to mention how this problem was found.

* As a bug fix for code present in the net tree, it should be targeted
  at that tree like this.

  Subject: [PATCH net]: ...

* Looking over git history, it seems that an appropriate prefix
  for patches for this code is 'tls: '

  Subject [PATCH net]: tls: ...

* Also, please try to make the subject a bit more succinct

> ---
>  net/tls/tls_sw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 9937d4c810f2..b1fa62de9dab 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2533,7 +2533,7 @@ void tls_sw_cancel_work_tx(struct tls_context *tls_ctx)
>  
>  	set_bit(BIT_TX_CLOSING, &ctx->tx_bitmask);
>  	set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
> -	cancel_delayed_work_sync(&ctx->tx_work.work);
> +	disable_delayed_work_sync(&ctx->tx_work.work);
>  }
>  
>  void tls_sw_release_resources_tx(struct sock *sk)
> -- 
> 2.43.0
> ---
> 
> Dear,
> 
> The following is a simplified scenario illustrating how each race can occur. Since tls_sw_cancel_work_tx() does not hold lock_sock(), it can race with tls_write_space().
> ```
>           cpu0                                             cpu1
> 
> tls_sk_proto_close()
>   tls_sw_cancel_work_tx()
>                                                     tls_write_space()
>                                                       tls_sw_write_space()
>                                                       if (!test_and_set_bit(BIT_TX_SCHEDULED, &tx_ctx->tx_bitmask))
>     set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
>     cancel_delayed_work_sync(&ctx->tx_work.work);
>                                                       schedule_delayed_work(&tx_ctx->tx_work.work, 0);
> ```

I think that the text above would be best included in the patch description.
At least for me it is fundamental to understanding the problem.

> 
> Best regards,
> Hyunwoo Kim
> 

I see three similar patches on the mailing list.
The comments above go for them too.
And It would probably be useful to just handle one at a time,
to allow for proper feedback. Or bundle them in a patchset.

-- 
pw-bot: changes-requested

