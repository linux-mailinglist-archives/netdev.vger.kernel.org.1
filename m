Return-Path: <netdev+bounces-82828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9EE88FDFF
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86569B255DC
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE0F7CF1F;
	Thu, 28 Mar 2024 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ygSGHGxm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gc4+k1U1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Msnescrw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IYUitxFZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580457334
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625071; cv=none; b=Jk3aoJo/YitFdR4/GSETUEXmBoBN9uVRAFRHv9xrxEPEZV0OdJbWGaB80+KYN714AGX8QVBhQw8MTfqmNUtymv1kZjAI9Kvq9DxYYrBj3aZlNpfUk8NQIEhiOVb5zJUBaHyoa1k3cLPK+zrVhD4RSfuCkDxhTO197CLPoEFAzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625071; c=relaxed/simple;
	bh=oNWR8HN6nf6kLHUZGZuMj31iTYoYbTy69hoXycOFSec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivPxC2q4t+/55pbpYjNHTTVuMe6V/RfJmFcgkRK9B6pd9IiUvb3s5x93EOM0ft8U4rSNvdVQh9QUof1IKqD5wzLGTrq3eR2nzzxENzxTw/ONxoXKlMITAbgS9feEiLEWPfITrU6JqwfB3vpjknoUd9+BolNfbRe84sqGuZVftgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ygSGHGxm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gc4+k1U1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Msnescrw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IYUitxFZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E563A33DEF;
	Thu, 28 Mar 2024 11:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711625068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MarQiH5EOLHagKn+FWg+ZRSJSxTEu4/ZHAwHkzigCzc=;
	b=ygSGHGxml3mSQKsRu8wSlSOqrTcerk/A7D7xecVMFVtQ5GofMH1PLK1qkVcScTBHgRCCAe
	BTEjpxpVIb6+oKKnKp7hjYfqoMEmrOoVIDS1GUBITeRi4bU7yTWX48342SF/h4KvU+i7KJ
	0BprqVFzgl1Z7S3MqcbwVrGDxI5VzOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711625068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MarQiH5EOLHagKn+FWg+ZRSJSxTEu4/ZHAwHkzigCzc=;
	b=gc4+k1U1cTOhN2+wKXu3ZGfQdwKTWx+8OQ0Hq96XR0M8MeEOBnPg9xbRGvepqYvcZyJj+B
	+z0ijrL2QJkEiVAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711625067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MarQiH5EOLHagKn+FWg+ZRSJSxTEu4/ZHAwHkzigCzc=;
	b=Msnescrw/9XJC+QFLlJxOlHqfbW/FIHKtZjjmkGop5cA8+QhdWs8MCQDtGvOwgo6I6S0JV
	0FFftjloGH0owu/yA4avdoCv+/w8+OKmfiqmLKt4tMQxYbly0tBMUfFjAgYJqONZmHGboB
	zD8z19DDJ+w/akfvvsev9mj1RXgUAQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711625067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MarQiH5EOLHagKn+FWg+ZRSJSxTEu4/ZHAwHkzigCzc=;
	b=IYUitxFZjDTIHOx9WeCa523XaBGqrFXc62tbzXKfwsCx/rryQP05rMedYO/vqG3K128luz
	Ppz1P7cMDHyo2rCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E09313AB3;
	Thu, 28 Mar 2024 11:24:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id rfhtF2tTBWZkFwAAn2gu4w
	(envelope-from <dkirjanov@suse.de>); Thu, 28 Mar 2024 11:24:27 +0000
Message-ID: <511600f7-bfbd-4353-bbc2-8decd81bdd3d@suse.de>
Date: Thu, 28 Mar 2024 14:24:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] RDMA/core: fix UAF in ib_get_eth_speed
To: Denis Kirjanov <kirjanov@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, jgg@ziepe.ca, leon@kernel.org,
 syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
References: <20240328112218.16482-1-dkirjanov@suse.de>
Content-Language: en-US
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240328112218.16482-1-dkirjanov@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Msnescrw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IYUitxFZ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.96 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-1.96)[94.83%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[5fe14f2ff4ccbace9a26];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.96
X-Rspamd-Queue-Id: E563A33DEF
X-Spam-Flag: NO



On 3/28/24 14:22, Denis Kirjanov wrote:
> call to ib_device_get_netdev from ib_get_eth_speed
> may lead to a race condition while accessing a netdevice
> instance since we don't hold the rtnl lock while checking
> the registration state:
> 	if (res && res->reg_state != NETREG_REGISTERED) {
> 
> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed from netdev")

Please ignore, there is an issue on error path

> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  drivers/infiniband/core/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 94a7f3b0c71c..aa4f642e7de9 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1976,11 +1976,11 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>  	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
>  		return -EINVAL;
>  
> +	rtnl_lock();
>  	netdev = ib_device_get_netdev(dev, port_num);
>  	if (!netdev)
>  		return -ENODEV;
>  
> -	rtnl_lock();
>  	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
>  	rtnl_unlock();
>  

