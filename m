Return-Path: <netdev+bounces-79842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB0287BB8A
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 11:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E8D1F22D71
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8D5DF0E;
	Thu, 14 Mar 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EdTeOkG7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GQQJeUT9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EdTeOkG7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GQQJeUT9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1EB4691
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413427; cv=none; b=kqw9b6cZk52ntcD5NiGkFbBy7c+NoQioihJqVCdx3adRTHxoERcB9XZJzViTsZCj4KEbbsLiNs59I03X02WSL6JksncX2+7scM+xoAsG1VEKKMuB3E/1pIuwiH9FDvU+UEuo1AVwjIFQxywox0f7UhF++MJO9F7Wzkjy5BegDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413427; c=relaxed/simple;
	bh=EiAQ4vDcV476fq2NyHn9gNBPjtYSxUX08cxxEJTA+Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvzP9pZ9QMd8IYN0FR4QltZnGrzX3ioGQZgwX2/1pftFrh+Bx9+GzjLpX6W50tElRVgqg6dbTF4yjH+8RaZrCF5YScVYI2NU5Usdz0UckH28Bi0ZORVfy2PYXILcTDRrHeAj0dCoIxxbDMftmI6Cy8HQEOQePJkXmlL6ned3lJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EdTeOkG7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GQQJeUT9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EdTeOkG7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GQQJeUT9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBB7621D1C;
	Thu, 14 Mar 2024 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710413422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BAtG+Ek6djO1pMtgbiUUwOQO0bmS+/AmfVAhRytcU4A=;
	b=EdTeOkG7lOhbms5zfskw/daNGjYxWYIArV2mcGLotVr5x3OOfJm7q4jIaNwM9+cjJHZOGX
	lblPMCEEK6tandC1nlKrGb2O4ZOevvtDQCKWa1KSAbnjXGgst83K7pl8tsiSKqvj5sgZ3I
	jnSDygQBR2vVk+tHstYXOK+Q88/N0Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710413422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BAtG+Ek6djO1pMtgbiUUwOQO0bmS+/AmfVAhRytcU4A=;
	b=GQQJeUT9JxUrzZSTzCpx2E7/eaqvVoK2XdBYzOCpqrcavWbiwSVyHEVUbSMs0X5vMXvnKT
	1wvR0M1uE77GAvDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710413422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BAtG+Ek6djO1pMtgbiUUwOQO0bmS+/AmfVAhRytcU4A=;
	b=EdTeOkG7lOhbms5zfskw/daNGjYxWYIArV2mcGLotVr5x3OOfJm7q4jIaNwM9+cjJHZOGX
	lblPMCEEK6tandC1nlKrGb2O4ZOevvtDQCKWa1KSAbnjXGgst83K7pl8tsiSKqvj5sgZ3I
	jnSDygQBR2vVk+tHstYXOK+Q88/N0Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710413422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BAtG+Ek6djO1pMtgbiUUwOQO0bmS+/AmfVAhRytcU4A=;
	b=GQQJeUT9JxUrzZSTzCpx2E7/eaqvVoK2XdBYzOCpqrcavWbiwSVyHEVUbSMs0X5vMXvnKT
	1wvR0M1uE77GAvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C5AC1386E;
	Thu, 14 Mar 2024 10:50:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eFBDB27W8mUVVgAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Thu, 14 Mar 2024 10:50:22 +0000
Message-ID: <9e36b337-725e-4f8a-a37d-17a7f0e7e9d6@suse.de>
Date: Thu, 14 Mar 2024 13:50:21 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] hsr: Handle failures in module init
Content-Language: en-US
To: Felix Maurer <fmaurer@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, leitao@debian.org
References: <0b718dd6cc28d09fd2478d8debdfc0a6755a8895.1710410183.git.fmaurer@redhat.com>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <0b718dd6cc28d09fd2478d8debdfc0a6755a8895.1710410183.git.fmaurer@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.34 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.25)[73.32%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -0.34
X-Spam-Flag: NO



On 3/14/24 13:10, Felix Maurer wrote:
> A failure during registration of the netdev notifier was not handled at
> all. A failure during netlink initialization did not unregister the netdev
> notifier.
> 
> Handle failures of netdev notifier registration and netlink initialization.
> Both functions should only return negative values on failure and thereby
> lead to the hsr module not being loaded.
> 
Fixes: f421436a591d3 ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> ---
>  net/hsr/hsr_main.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
> index cb83c8feb746..1c4a5b678688 100644
> --- a/net/hsr/hsr_main.c
> +++ b/net/hsr/hsr_main.c
> @@ -148,14 +148,24 @@ static struct notifier_block hsr_nb = {
>  
>  static int __init hsr_init(void)
>  {
> -	int res;
> +	int err;
>  
>  	BUILD_BUG_ON(sizeof(struct hsr_tag) != HSR_HLEN);
>  
> -	register_netdevice_notifier(&hsr_nb);
> -	res = hsr_netlink_init();
> +	err = register_netdevice_notifier(&hsr_nb);
> +	if (err)
> +		goto out;
> +
> +	err = hsr_netlink_init();
> +	if (err)
> +		goto cleanup;
>  
> -	return res;
> +	return 0;
> +
> +cleanup:
> +	unregister_netdevice_notifier(&hsr_nb);
> +out:
> +	return err;
>  }
>  
>  static void __exit hsr_exit(void)

