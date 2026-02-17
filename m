Return-Path: <netdev+bounces-259132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKY2C2W3lGlMHQIAu9opvQ
	(envelope-from <netdev+bounces-259132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:45:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC814F4F4
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B18C302D964
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910DE37417B;
	Tue, 17 Feb 2026 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzhkq4U4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46553372B2E
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353954; cv=none; b=CulDw0p+7cn37JneLt6zvopctTHV/PR9egLBoVjOUb/i8g4RIKi1xW60li4YcM2C3Jexb/ysZrK2+peV0+rrlxx1sx4zoU+Lzygg/jnLjKWArA8KKF2gA6NGqiWq/HQtx9oooDJOjYq8eM5wsao2rwJY2XCIjdXfmDUGnt1Y3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353954; c=relaxed/simple;
	bh=ORWEn33cr8TezltWTg7HhteV+K8N7yMVo8rWvGI/V38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3I9Bv6Z6yijGUWkeNNPgoZxLrBhKdcLZjS4Onc00m/jKhnzviuYAAyM+oZrF1X1MYdmow7aF5m9x05jxRtFF9PX2sv8si5rP07hknfvIUV2cnABLg81b1UVRiezVNh0IKVKXf2QV01o3bdaCnKXrOFMaaaGz43ZbusEV2vu0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fzhkq4U4; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb39647a70so463243885a.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771353952; x=1771958752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9A3D21adMciyC71cYHrKoVOKLOG80kizDTsQCYR5dlk=;
        b=Fzhkq4U4345JJH3lEtbC8BILX3PobhYlJ2eLutY6PDp1Sz2c1Z2olHmK5tSlSoe1vV
         m9Rw6E5iqvk3vsFUZVohuqDsPZOD04NRjiPuB6KpzuwmQuPXbesBCZjMm8PkJUGo7G4j
         Pfg6UhmareZE6JrNmjqWplIT329CmUurZ8MlerEHQGUSaeBZ5GS3S6yCF0Qy8y77cmuc
         UwdDSTlp22nsV36E3ex3svos7KTXXV4p4j3UVZLHaKRHSF+mnSmvOlQHS+FV5a9E41uA
         bRlnDhzVLCHLYOKqH4owx/foDym8RotCS2/YZ8CUJbhoLcZkpsnulTMHXgMJ5B5Xhdqi
         sJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771353952; x=1771958752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9A3D21adMciyC71cYHrKoVOKLOG80kizDTsQCYR5dlk=;
        b=OVWU6H1QiiHaN9ZCyHSIxAmYKXTppkqPU+y7F1jtsvP7i8toRzuSw2Z2RW3DYtQJpL
         8xslAQ3KlvIw/xMrIu9bMHu6dfJpRy+vg0sQPlAMuF2GQ4GM6+wg5tiX/lOX8cTyItJf
         kaE74WxPwEao+WyH8ISA7X87jm9ib8cgfgQ/e78z5uNDvn7aEtExuGkCywn8yXD6FUWQ
         FzRdr4Z2Didr9NC5wcjmTC60aygqw9gg6HFjHn0trqIMIDHSLpfejFhiZxeyIbomH6th
         nIKeaoND0zU7N9a6vBaA5azk/80aJOnwzp4Oe8SlLBnwlFeh7HhB8VNJHjzOAK11YIz4
         xYjw==
X-Forwarded-Encrypted: i=1; AJvYcCXc99Gj+qDblU3rqzpkKwDqm9Rh2Iy3HGwShWJDOlIfIFsPZyXe9nUJfDZIf5gOs/0mtLgxRQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/3ajWkHiNQQoKsKRyNzBtkl2noLRNveiHiZ2yk1sBDo4vyBC
	hE3OGnC6cfr/Gl7gG+9g4ATqAvqXhMjxwwSnrfJPk8tBT9SueOPdslH/
X-Gm-Gg: AZuq6aKWkhFZcx228V9tzgl5ZGioxDUvZOUOmNSZP/yFYe80LZ+rpOf7LWPxqFL06HZ
	Xj/DvxhzVFafOAz0n2BwwtfXf+kVCOMbQIyWCkBCepQ10pw50QKpUI/pn9rz6tye7pOgW1eJlwB
	uX4V4dlMOqCqFSQch7PPMk19VhonAWWV9cq7e7P7Cvr7u1AFtWGLjQnyt8Lu6C+LrI761QyrqIu
	xRpOVIP0bRVI8L5U1QvcYXTUTvhwJ+lWAGU9FmE9yOpAUok3sjLB3B4v4hXzECILKL72Gm5Ug5J
	fSHqXk2KEpooXiaWxqyfgxX2iVW1etg6kpCVm90TiuVOuD9zaZLFBAo3N+1c0BNFeAMCKTKs6ZR
	af+J+A1vcnGon1jZuPQt3uyC0iT0gPj4UfulrsyX/RvrdZUNb0To1lRyfd67U3TvAFzKgH9qavM
	j641q/N/XKtfpdMHuLcrKFyGWzwJxsY/knt5gO3MhM0d1owtBmb0kzr4KhwTFuCu4=
X-Received: by 2002:a05:620a:4809:b0:8c7:1b3c:8e8 with SMTP id af79cd13be357-8cb4bfb97c0mr1463999185a.40.1771353952153;
        Tue, 17 Feb 2026 10:45:52 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:15c9:280a:146e:89e4? ([2620:10d:c091:500::5aa8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7f540sm167126456d6.5.2026.02.17.10.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 10:45:51 -0800 (PST)
Message-ID: <a0f6ef89-e884-4e87-8b4b-2035bc0cc302@gmail.com>
Date: Tue, 17 Feb 2026 13:45:50 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: psp: select CONFIG_SKB_EXTENSIONS
To: Arnd Bergmann <arnd@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260216105500.2382181-1-arnd@kernel.org>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260216105500.2382181-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259132-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AFC814F4F4
X-Rspamd-Action: no action



On 2/16/26 5:54 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> psp now uses skb extensions, failing to build when that is disabled:
>
> In file included from include/net/psp.h:7,
>                   from net/psp/psp_sock.c:9:
> include/net/psp/functions.h: In function '__psp_skb_coalesce_diff':
> include/net/psp/functions.h:60:13: error: implicit declaration of function 'skb_ext_find'; did you mean 'skb_ext_copy'? [-Wimplicit-function-declaration]
>     60 |         a = skb_ext_find(one, SKB_EXT_PSP);
>        |             ^~~~~~~~~~~~
>        |             skb_ext_copy
> include/net/psp/functions.h:60:31: error: 'SKB_EXT_PSP' undeclared (first use in this function)
>     60 |         a = skb_ext_find(one, SKB_EXT_PSP);
>        |                               ^~~~~~~~~~~
> include/net/psp/functions.h:60:31: note: each undeclared identifier is reported only once for each function it appears in
> include/net/psp/functions.h: In function '__psp_sk_rx_policy_check':
> include/net/psp/functions.h:94:53: error: 'SKB_EXT_PSP' undeclared (first use in this function)
>     94 |         struct psp_skb_ext *pse = skb_ext_find(skb, SKB_EXT_PSP);
>        |                                                     ^~~~~~~~~~~
> net/psp/psp_sock.c: In function 'psp_sock_recv_queue_check':
> net/psp/psp_sock.c:164:41: error: 'SKB_EXT_PSP' undeclared (first use in this function)
>    164 |                 pse = skb_ext_find(skb, SKB_EXT_PSP);
>        |                                         ^~~~~~~~~~~
>
> Select the Kconfig symbol as we do from its other users.
>
> Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   net/psp/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/net/psp/Kconfig b/net/psp/Kconfig
> index 371e8771f3bd..84d6b0f25460 100644
> --- a/net/psp/Kconfig
> +++ b/net/psp/Kconfig
> @@ -6,6 +6,7 @@ config INET_PSP
>   	bool "PSP Security Protocol support"
>   	depends on INET
>   	select SKB_DECRYPTED
> +	select SKB_EXTENSIONS
>   	select SOCK_VALIDATE_XMIT
>   	help
>   	Enable kernel support for the PSP Security Protocol (PSP).

Indeed that is and has always been a mandatory config dependency for psp.

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>

