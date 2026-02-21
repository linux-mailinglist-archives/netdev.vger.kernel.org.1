Return-Path: <netdev+bounces-259797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD9kNZf7mGkOOwMAu9opvQ
	(envelope-from <netdev+bounces-259797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:25:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF216B8F1
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A9143009882
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 00:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85D6284669;
	Sat, 21 Feb 2026 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dibKM2E1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51ED283C9E;
	Sat, 21 Feb 2026 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771633555; cv=none; b=XCVOMC0ZfeN4muYtAOMX7OmmAkzHbBWAONDuf2xjo4upfW95HpiyIfBq9bMMjqSJSEk0J+BGaHNLxbyNljocGN+DTseXdqjRIN0xsy4fPffewBTAiquBmV/WBrnwXjDgaSNPkbvVzGUqjrPvOwMlQ/kvzQtrGpQqCoHzJj5n7QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771633555; c=relaxed/simple;
	bh=hfy+ECBZYZJeWj9PWuqrWID89pxD3KW2GTLEvLawmfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFvjL4JuThD93FMnJ2CYBzt8bCTqPzqwpbGVFKln7zriA0kxrJdAB1v1tIyTIgPCAR66iV2A/khNwphTUxLxNFWzdN491kZzZ7c0985A6M42Uhb3i/sbyx5DS9nbMxA9+wQRiX7KRlfBoVt6ibJSIpgBZzydoNmsvgOWCkCzOsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dibKM2E1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17F3C116C6;
	Sat, 21 Feb 2026 00:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771633555;
	bh=hfy+ECBZYZJeWj9PWuqrWID89pxD3KW2GTLEvLawmfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dibKM2E195AAzqNm3kADibKnmRTusPeruhuHqDD1IZ5DuiMVrjqmEt0dLMup9bifV
	 KTI1FkJwnGOW6gIBQq2I5l/UVUiw5fJ4q79IWG087Ae1OsJu8ZoXvkREjaHtumO6oT
	 xMXp12NT+OYT7MFkZPrpNde3WcMqfxYgmpxBCAKHMijQ/MaL31M2i/t9Em6ylN9W8N
	 4yiVBcTWdvMnz9bcNGkdCangp73bMyExuYm7EcN0FXbyAJYqbsEn2ruxmGIPTtwluz
	 BR8z/a2k3oqTO2TMyZ391DjHOWKMApfDXnIxsLmY+58UYWCuL7FkkpRzCI3KkShQWv
	 vA0i1omY5QUjA==
Date: Fri, 20 Feb 2026 16:25:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Simon Horman <horms@kernel.org>, Zijun Hu <zijun.hu@oss.qualcomm.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: wan: framer: fix potential UAF in
 framer_provider_simple_of_xlate()
Message-ID: <20260220162553.3beafdcc@kernel.org>
In-Reply-To: <aZefB5f3EAkQQM1m@google.com>
References: <aZefB5f3EAkQQM1m@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259797-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6ECF216B8F1
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 15:40:57 -0800 Dmitry Torokhov wrote:
> The implementation put_device()s located device and then uses
> container_of() on the pointer. The device may disappear by that time,
> resulting in UAF.
> 
> Fix the problem by keeping the reference to the framer device, and
> avoid getting an extra reference to it in framer_get().

I have failed to understand what you are talking about after looking 
at this for 15min :S Please write better commit messages?

> Fixes: dcacb364772e ("net: wan: framer: Simplify API framer_provider_simple_of_xlate() implementation")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/net/wan/framer/framer-core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/wan/framer/framer-core.c b/drivers/net/wan/framer/framer-core.c
> index bf7ac7dd2804..397fabc3da4e 100644
> --- a/drivers/net/wan/framer/framer-core.c
> +++ b/drivers/net/wan/framer/framer-core.c
> @@ -482,8 +482,6 @@ struct framer *framer_get(struct device *dev, const char *con_id)
>  	if (IS_ERR(framer))
>  		return framer;
>  
> -	get_device(&framer->dev);

AFAICT this get_device() does not pair with the put_device() 
you are removing

>  	if (!try_module_get(framer->ops->owner)) {
>  		ret = -EPROBE_DEFER;
>  		goto err_put_device;
> @@ -749,7 +747,6 @@ struct framer *framer_provider_simple_of_xlate(struct device *dev,
>  	if (!target_dev)
>  		return ERR_PTR(-ENODEV);
>  
> -	put_device(target_dev);
>  	return dev_to_framer(target_dev);

The only caller of this function does not dereference the pointer
(no idea why it even calls it, for some setup validation?)
Calling container_of() on a stale pointer is safe.

>  }
>  EXPORT_SYMBOL_GPL(framer_provider_simple_of_xlate);

I'm kinda curious about the backstory for this patch..
What made you look at this code?
-- 
pw-bot: cr

