Return-Path: <netdev+bounces-229562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D80BDE3CE
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 13:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC0024E3B2D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001632772D;
	Wed, 15 Oct 2025 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CYGr9gkh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1eqJt9Im";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CYGr9gkh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1eqJt9Im"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44228E5F3
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526944; cv=none; b=nTssdNcUVZefI250kB1aPWwGY7EHpXBBr8wZ87dp9nBnhRKZGPP6s2wm1c1j7U4r0fxMytj46q+vU6Mh8uLUEuvBOgIbA1r/+tWDDZ9RYNacFo/qyeNP7nVrMJfHwu1CxKvvZCob9hRaLTNowJVUWYATXi1gop6tc2iuqkYxf8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526944; c=relaxed/simple;
	bh=ygTBVxJuh31I+49oSzv2Fr0pdWAVI4RisSFBARsTIx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvf2x21+s8VVS0f1jTEo9XXiU15NB+02v3NNKXrVkglZsZ8s2s6zvk4bU+Z/883CHz1P3Ewgiu7m8+l02cVenhrqP3bs5LJ5j5f55IsrekKAXE/IaZtYD/Yn8nje6TIeJX0/IZyOH8ffIDXXHyanzkcOD9H9wwmPcUcOnDrF66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CYGr9gkh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1eqJt9Im; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CYGr9gkh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1eqJt9Im; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35D951FC11;
	Wed, 15 Oct 2025 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760526941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AD8hFa0olUVdxKsfkXt/cmVZTg/GfaJ92oxbfvURsxs=;
	b=CYGr9gkhtGxPUCOYk2xpIIfcoN6d4jLW+XzCekVzTMgfP+4GGSDyyyR/ZJEENO0Kb4jKJt
	5GOd7lqcpVkEVuoOLYsormkY6+KCdx/6WzmZfKCabBOkxDWuDySk1Yxynr5PWhkZ7tu9KI
	LRe5bmQaR8zm6I/wokXjjXAsczOfvn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760526941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AD8hFa0olUVdxKsfkXt/cmVZTg/GfaJ92oxbfvURsxs=;
	b=1eqJt9ImGBTPqx4FEipJBELv2Q6aDrM/Uei2AHx5XPxpMTpiD6bzdP8H0bx9JeTd1yYC+/
	H6WK+NdFizgEe8Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760526941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AD8hFa0olUVdxKsfkXt/cmVZTg/GfaJ92oxbfvURsxs=;
	b=CYGr9gkhtGxPUCOYk2xpIIfcoN6d4jLW+XzCekVzTMgfP+4GGSDyyyR/ZJEENO0Kb4jKJt
	5GOd7lqcpVkEVuoOLYsormkY6+KCdx/6WzmZfKCabBOkxDWuDySk1Yxynr5PWhkZ7tu9KI
	LRe5bmQaR8zm6I/wokXjjXAsczOfvn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760526941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AD8hFa0olUVdxKsfkXt/cmVZTg/GfaJ92oxbfvURsxs=;
	b=1eqJt9ImGBTPqx4FEipJBELv2Q6aDrM/Uei2AHx5XPxpMTpiD6bzdP8H0bx9JeTd1yYC+/
	H6WK+NdFizgEe8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C609D13A29;
	Wed, 15 Oct 2025 11:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hBFwLVyC72jJRAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 15 Oct 2025 11:15:40 +0000
Message-ID: <7534483b-c893-4d25-b69e-247123f35c56@suse.de>
Date: Wed, 15 Oct 2025 13:15:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/hsr: add interlink to fill_info output
To: Jan Vaclav <jvaclav@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20251015101001.25670-2-jvaclav@redhat.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20251015101001.25670-2-jvaclav@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 10/15/25 12:10 PM, Jan Vaclav wrote:
> Currently, it is possible to configure the interlink
> port, but no way to read it back from userspace.
> 
> Add it to the output of hsr_fill_info(), so it can be
> read from userspace, for example:
> 
> $ ip -d link show hsr0
> 12: hsr0: <BROADCAST,MULTICAST> mtu ...
> ...
> hsr slave1 veth0 slave2 veth1 interlink veth2 ...
> 
> Signed-off-by: Jan Vaclav <jvaclav@redhat.com>
> ---
>   net/hsr/hsr_netlink.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
> index 4461adf69623..851187130755 100644
> --- a/net/hsr/hsr_netlink.c
> +++ b/net/hsr/hsr_netlink.c
> @@ -160,6 +160,12 @@ static int hsr_fill_info(struct sk_buff *skb, const struct net_device *dev)
>   			goto nla_put_failure;
>   	}
>   
> +	port = hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
> +	if (port) {
> +		if (nla_put_u32(skb, IFLA_HSR_INTERLINK, port->dev->ifindex))
> +			goto nla_put_failure;
> +	}
> +
>   	if (nla_put(skb, IFLA_HSR_SUPERVISION_ADDR, ETH_ALEN,
>   		    hsr->sup_multicast_addr) ||
>   	    nla_put_u16(skb, IFLA_HSR_SEQ_NR, hsr->sequence_nr))

Thank you Jan, it looks good to me.

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

