Return-Path: <netdev+bounces-278014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA3xJ9e33Gn2VgkAu9opvQ
	(envelope-from <netdev+bounces-278014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:31:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB3C3E9DCB
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C231630146B6
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B983B0AE5;
	Mon, 13 Apr 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf4epigA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnANikbc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2370D1E5702
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072660; cv=none; b=qCXW6sOvoasRVcj9kzamIksUb4sNtH7IbFykLn49Jzi9jcKfPGiQeQAXlXs58RXT2GCtbVSaDLHy7aCFMFnWS89V1/DxYk7fu7Hmqjbt+Q5SvyCYWyQC8tv1g2ED6BixO4sAcn81kPqCQVdeJG9m9pbi/3DeJdQLqy+wN1VNy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072660; c=relaxed/simple;
	bh=ktqp7Hnd3tVxz0U7RE+2KrU8E8SGNSwevfeqTyUIzy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkqQgZ/GmBh9+twTZERLljFlu3PHmgFDkPNQpZFa1oK7vAU3JmVeIzF8UFqLQf3T2XoauIRr16RokDdgqta3l7gZKRN/mYPf5uRfdZynwivCnbyGLytuFfG1DqPm7KKBfeKkuvNq2UWWB2aMg30MT55gZ0Ed2z5bhkRSQ1/4fZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jf4epigA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnANikbc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776072658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAjFDnY5a9QJh1Rs/FKUmcP7hv6dn3Hxh+qhotN9bv8=;
	b=Jf4epigAaaozNkEKBbYSeeKHk8ICwoB8Cib5BBTm/KvLSR1s0/+DdWeHTvY20h5G+S8RsP
	KAmSMjwxMAOxtEbVT2rGP/vav2aWkN1KOoQI7g8TY6rolHZRc4xe6pNArWo5BRczn6oDgm
	WggyDWSvn9Fm5MIQTvZHhC1RfkSvFpM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-jjXOw_T4P2SLrNbMrpGZEw-1; Mon, 13 Apr 2026 05:30:56 -0400
X-MC-Unique: jjXOw_T4P2SLrNbMrpGZEw-1
X-Mimecast-MFC-AGG-ID: jjXOw_T4P2SLrNbMrpGZEw_1776072656
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so34360935e9.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776072656; x=1776677456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FAjFDnY5a9QJh1Rs/FKUmcP7hv6dn3Hxh+qhotN9bv8=;
        b=MnANikbc3nLNkRhpX+TBOhFuvUeP84gkF8Bhdpcpp1x9EUJra83RSlZZixf1RYoQAW
         wzQIyKYXBmPJM1Ufs4gq7eibe2nN683sJp/OOE6Y+jElvXjHJ3m8NgTOR3+UBcvtjLPT
         3sAm/xJp9+kJh/3KTpCMyaz+VF5lnYK7xmOeCN6QZ/SZYBFmanGHUYulvsRlwy2i63SH
         FpzEpTd1DgiVr8rid5G7enMiGgZLN+oX41XuJrVoOFE22A6fnDR5zp6dSTPMq0SPQk6U
         zFHHhLLvb4lc2jvdCjtYOBErSOUxz8bRCMcJzgISJ4ma3abXFdbULSUxhP6ssCmZgo1+
         ovxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776072656; x=1776677456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAjFDnY5a9QJh1Rs/FKUmcP7hv6dn3Hxh+qhotN9bv8=;
        b=pgUPuXIrOrVkzXTNGV80+KtQaE7dEwD7hM2Uze1jvU2rLMIHnDRHauzgaDiBCV01i0
         WxbpejiScbtOn/qEKUHST5TA6/IBiR/duEOR6jagV+XrWjopo6C3A1o1sZ2Rpd39yqxL
         fVS++ofhQwXTNT5VcHk5uPveaO2d1JrfgdDn2usqQN0IqlhxIViw50jA69GRUh6+knZC
         E35dJSKWVHBo3uqwWKo7UvBztw4899HQdD7z1J5EQ+OVOIN2H8jYOuUKcaWbEg6a7NXb
         IRQApZeiBlT0LRP2M5/qRkB81hsQZ93EXp7+poVbrOEzlGwv88Ux9B5bQAqM3JBBRqTN
         vM4g==
X-Forwarded-Encrypted: i=1; AFNElJ+KvPVZ4OsO3Lc1kFFX/5Su+MdAjbhmESRh4lezZdB6C8c6tmaRr10TgNMqaIzdhtCImdSKTWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6TOdflwiL1mCqtTJ4SIHrsfLnCMSHXzkivKSJZGT7kRaI1uc6
	9PfeHFlNG/8Upu+JJcwP9roL7Td2aDBHL+r36Gx7r0IF/R/TLJrcUvIAEZuGHSAqPE7OOKzuito
	BFjRUhtl6ym+6IGOT8fwvwjwMl/NenGhJDTOlRfE2DoEXQLSCbmqtdx67QA==
X-Gm-Gg: AeBDieuyobdK076u312S1H0VGA6qAc2YVq0VfoSbuWiKB3xHZrOvoM2GL2hK6H/eZ8R
	qKyyhoik181vsn+2/gQ4pjm5kQSBG7QdPbh4sJ3QItfmCJkydlXiH7mdxqFV9qb8siV87Ms2pJ5
	8xx0yF44WHobpIl9iLwmkEv2PiEJRMcQqrFxFwwhv4+/1eRC9zYohoGOidTCVo2oeSblA7D3rJh
	0aPtAQNSfECale3N6CYUR4a9OpNmIFnm7++UHTysz1FUnt8hKEo/PjSh/SNbscZArM9qyWwEfmU
	h56beFPEzG9akeGUvXw0yvUQA4O/63eKJ8NX/rXRgeLW3wM0dtzIHItDa97OYCgG8i0OK1d/OYg
	m00p2rgU2Gfl546qxN13VDrc0AtGT+6L1LpVevjYSKAI2oUMpuODzKWhG
X-Received: by 2002:a05:600c:c173:b0:485:39d1:b4dd with SMTP id 5b1f17b1804b1-488d684b024mr165236645e9.10.1776072655688;
        Mon, 13 Apr 2026 02:30:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c173:b0:485:39d1:b4dd with SMTP id 5b1f17b1804b1-488d684b024mr165236145e9.10.1776072655200;
        Mon, 13 Apr 2026 02:30:55 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d58a8438sm312055965e9.5.2026.04.13.02.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 02:30:54 -0700 (PDT)
Message-ID: <255224dc-0a55-4a0c-95f3-b84d4c6b3897@redhat.com>
Date: Mon, 13 Apr 2026 11:30:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] net: caif: fix stack out-of-bounds write in
 cfctrl_link_setup()
To: Simon Horman <horms@kernel.org>, Kangzheng Gu <xiaoguai0992@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 kees@kernel.org, thorsten.blum@linux.dev, arnd@arndb.de,
 sjur.brandeland@stericsson.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
 <20260408125333.38489-1-xiaoguai0992@gmail.com>
 <20260412135743.GK469338@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260412135743.GK469338@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278014-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,utility.name:url]
X-Rspamd-Queue-Id: 0FB3C3E9DCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/12/26 3:57 PM, Simon Horman wrote:
> I am wondering if it would be best to follow the pattern for
> writing linkparam.u.utility.name elsewhere in this function.
> That:
> 1. Uses a somewhat more succinct loop control structure
> 2. Silently truncates input without updating cmdrsp if overrun would occur
> 
> Something like this (compile tested only!):
> 
> diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
> index c6cc2bfed65d..ba184c11386e 100644
> --- a/net/caif/cfctrl.c
> +++ b/net/caif/cfctrl.c
> @@ -15,6 +15,7 @@
>  #include <net/caif/cfctrl.h>
>  
>  #define container_obj(layr) container_of(layr, struct cfctrl, serv.layer)
> +#define RFM_VOLUME_LEN 20
>  #define UTILITY_NAME_LENGTH 16
>  #define CFPKT_CTRL_PKT_LEN 20
>  
> @@ -414,10 +415,11 @@ static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp
>  		 */
>  		linkparam.u.rfm.connid = cfpkt_extr_head_u32(pkt);
>  		cp = (u8 *) linkparam.u.rfm.volume;
> -		for (tmp = cfpkt_extr_head_u8(pkt);
> -		     cfpkt_more(pkt) && tmp != '\0';
> -		     tmp = cfpkt_extr_head_u8(pkt))
> +		caif_assert(sizeof(linkparam.u.rfm.volume) >= RFM_VOLUME_LEN);
> +		for(i = 0; i < RFM_VOLUME_LEN - 1 && cfpkt_more(pkt); i++) {
> +			tmp = cfpkt_extr_head_u8(pkt);
>  			*cp++ = tmp;
> +		}
>  		*cp = '\0';
>  
>  		if (CFCTRL_ERR_BIT & cmdrsp)

I agree that the code suggested by Simon is clearer. Note that AFAICS it
lacks an additional `tmp!= '\0'` check to break the loop, but even with
that added it should be preferable.

Thanks,

Paolo


