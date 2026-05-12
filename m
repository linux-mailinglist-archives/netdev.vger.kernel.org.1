Return-Path: <netdev+bounces-287184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM+FFQEyA2oA1gEAu9opvQ
	(envelope-from <netdev+bounces-287184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:58:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC0F521D38
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B1E7303801A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E057839E9C0;
	Tue, 12 May 2026 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bh4punbO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B239E9BB
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594144; cv=none; b=f5k3de4Pdma+5X5e1E/NTrakvgAvLD9O7yHvdo/uLVzfqxoRnTJfr0ac/sneNNVIDEBxRN8y9sCGxk7+qMAs6KiAdcVp66LLv50rYj6NRrA8d/nD9JNTXV/OGZ7eZW2GPoTQVSVp/by5lLVphIv8/zKs67bKKFw5PvF00y9ZoAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594144; c=relaxed/simple;
	bh=L2obTzioIky7Xe62sdUdJugOF/DLMnYd+se+yIwRjpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1gZPCJFfwHqV3B/qhrl0Ci1HYOqIUqvVWnRcYH7REX1rFyzeHeSqSWJ+CkYjSV8iVZ7TqINgb4Qcht0Mad2IID51jWWtQADEhy0I9Hc5dN98E3HuDY3/S8WkXswKnbd7QWyHeQ2U7T1gCh1RISvjuy6bgBANyJWcNZ5g+IdwGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bh4punbO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso47886825e9.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778594142; x=1779198942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c9Ujg9pQGDL6jd9yyZ5NSQ4d/MQLU1mdX7ZdiG8lxiU=;
        b=bh4punbOIGB0/HAet2LnovnLp/Ov6L46gzk4y2rkaVhOjpa7OzM1Ry3MojAEAUluPc
         oLn5KsD4fwNoo0HGkSjmwCic3QeboX+utYdU/I8QKCIFzWG5C18AEYOJ2XJvuM7gKkDG
         xy/OVRD0TCD/nFKteiWofMfTWGWfoi2EYi2xFWAdpUXFpVQW6XZg2kxLQPmZnF1oQwUq
         78CkQqU6E8G938H9klBXaNeMuefJ/crzcwBFPDbc9FexzPAQLlnkDAlM8oVyKgjJL2W5
         EPWTTCZbDcMMW2YzuqxD7blux5ivKrlwXn0MR8fTrLZJdhRLQO9STutu50QHwP/Pcr83
         lpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594142; x=1779198942;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9Ujg9pQGDL6jd9yyZ5NSQ4d/MQLU1mdX7ZdiG8lxiU=;
        b=ChISDM9elynShCgWKvzuhd/qn+dAQk7f6RL+dJ2B09FUyQot2EsQcuQ/v78/o3RU4L
         WGk+Nj9qx/PVaDxvaxDy91bCr9HMFjtEM1tWaah9m2Gg0h/7qpFYaXJVomuxnbmwltKj
         oNPPThSVAtyoSQSzrmL5N42xF+ekZ/S4Hd9/Hr8wc0AO0YJmLvkDgbbzPIfP6T7gWT14
         PfgxXUTmdwkh6/soG+G6iQ3exzEoEid7S3Lk5Jt/nhnR7ibTzK7ml3139behkxWARFiX
         QGhwqpThRy1TD+eSL/Z5haE8BAm8WsExzQgNleYZanbTy/pyhZyAeYl/bJzyRzzUKywV
         BUVA==
X-Gm-Message-State: AOJu0Yw3GlJnsZ1kVMd/HoPxRoCzZP4Nw7rV0/72+xsIHim/1MxJveyw
	KOULHXsh6wiQ6U5JiXD5GCeZrgl+PrP9F+ZCayF6ZyAovl0QC/3krDW8GUk5e19YqhMoN/GmMmT
	qbmwfuW4Tovb34cm4hV+SiuwScDKaZerilMg8PTcQaUICKzjS/kQ=
X-Gm-Gg: Acq92OEbQX+UDeN2JE8ygGXQwIs9TgkeNpCB/88VjRU+MTO8LNvnTgf74QhFqu3b0nt
	QvZxxMoznPPP5ub9Rk13Ved9lk1rsBaUgQy4fBxJt5jC7CA5fWKm7P6ib7DSm23MOFOMiCY0qwp
	3/51vyE+K+ypiOtjBN7xhI085hJgOkLGfEyYENJFPUTsJMZP1Ae4c3L1HTwvnSdsQgFqXArPe0U
	ckAXLc3EWi3PFxa8XhTsfpRJaucpGj2rNOF364a/Rf0z52f+ky6bYpOEs8MExKt/SlZgAOT5ViX
	tjf/WuUz09TjV9cvFpPoJ8jyVH0I3Qv2sWfpUz5hfH5zTOD2+9Fi3DU13Awhy+fXs7BpaTzB0TZ
	x/rnc0jVRCKfJI7tYpd5bHj+svyGLKXGI2omEQKc2aZfNIs54r2O3hU/im6X51tRNzojqy/XJ6d
	opmmXJTaKB4g9SnJJh9h6CxL0rxT86KAqIiwKRksxd1ebZ+UtonLTrs7tryfT7Ng==
X-Received: by 2002:a05:600c:3510:b0:48a:53ea:1408 with SMTP id 5b1f17b1804b1-48e8fe50a02mr41693535e9.8.1778594141558;
        Tue, 12 May 2026 06:55:41 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:7245:d44f:b95f:a2c6? ([2001:67c:2fbc:1:7245:d44f:b95f:a2c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f410558sm36090165e9.5.2026.05.12.06.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 06:55:41 -0700 (PDT)
Message-ID: <4ff6590a-6695-4c6c-b677-a7891b249165@openvpn.net>
Date: Tue, 12 May 2026 15:55:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ovpn: tcp - use cached peer pointer in
 ovpn_tcp_close()
To: David CARLIER <devnexen@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20260512042036.19870-1-devnexen@gmail.com>
 <20260512042036.19870-2-devnexen@gmail.com>
 <CANn89i+qfzW_S-Z_vT3=UH00Qu2KodJf=V7O3o=yMVgfjK82xg@mail.gmail.com>
 <CA+XhMqy50a8zq1foi564r2niHzJo54E3TCpT-YmYa=r2n75Uyg@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AYGGhrcHM6Ly9rZXlzLm9wZW5wZ3Aub3JnFiEEyr2hKCAXwmchmIXHSPDM
 to9Z0UwFAmj3PEoFCShLq0sACgkQSPDMto9Z0Uw7/BAAtMIP/wzpiYn+Di0TWwNAEqDUcGnv
 JQ0CrFu8WzdtNo1TvEh5oqSLyO0xWaiGeDcC5bQOAAumN+0Aa8NPqhCH5O0eKslzP69cz247
 4Yfx/lpNejqDaeu0Gh3kybbT84M+yFJWwbjeT9zPwfSDyoyDfBHbSb46FGoTqXR+YBp9t/CV
 MuXryL/vn+RmH/R8+s1T/wF2cXpQr3uXuV3e0ccKw33CugxQJsS4pqbaCmYKilLmwNBSHNrD
 77BnGkml15Hd6XFFvbmxIAJVnH9ZceLln1DpjVvg5pg4BRPeWiZwf5/7UwOw+tksSIoNllUH
 4z/VgsIcRw/5QyjVpUQLPY5kdr57ywieSh0agJ160fP8s/okUqqn6UQV5fE8/HBIloIbf7yW
 LDE5mYqmcxDzTUqdstKZzIi91QRVLgXgoi7WOeLF2WjITCWd1YcrmX/SEPnOWkK0oNr5ykb0
 4XuLLzK9l9MzFkwTOwOWiQNFcxXZ9CdW2sC7G+uxhQ+x8AQW+WoLkKJF2vbREMjLqctPU1A4
 557A9xZBI2xg0xWVaaOWr4eyd4vpfKY3VFlxLT7zMy/IKtsm6N01ekXwui1Zb9oWtsP3OaRx
 gZ5bmW8qwhk5XnNgbSfjehOO7EphsyCBgKkQZtjFyQqQZaDdQ+GTo1t6xnfBB6/TwS7pNpf2
 ZvLulFbOOARoRsrsEgorBgEEAZdVAQUBAQdAyD3gsxqcxX256G9lLJ+NFhi7BQpchUat6mSA
 Pb+1yCQDAQgHwsF8BBgBCAAmFiEEyr2hKCAXwmchmIXHSPDMto9Z0UwFAmhGyuwCGwwFCQHh
 M4AACgkQSPDMto9Z0UwymQ//Z1tIZaaJM7CH8npDlnbzrI938cE0Ry5acrw2EWd0aGGUaW+L
 +lu6N1kTOVZiU6rnkjib+9FXwW1LhAUiLYYn2OlVpVT1kBSniR00L3oE62UpFgZbD3hr5S/i
 o4+ZB8fffAfD6llKxbRWNED9UrfiVh02EgYYS2Jmy+V4BT8+KJGyxNFv0LFSJjwb8zQZ5vVZ
 5FPYsSQ5JQdAzYNmA99cbLlNpyHbzbHr2bXr4t8b/ri04Swn+Kzpo+811W/rkq/mI1v+yM/6
 o7+0586l1MQ9m0LMj6vLXrBDN0ioGa1/97GhP8LtLE4Hlh+S8jPSDn+8BkSB4+4IpijQKtrA
 qVTaiP4v3Y6faqJArPch5FHKgu+rn7bMqoipKjVzKGUXroGoUHwjzeaOnnnwYMvkDIwHiAW6
 XgzE5ZREn2ffEsSnVPzA4QkjP+QX/5RZoH1983gb7eOXbP/KQhiH6SO1UBAmgPKSKQGRAYYt
 cJX1bHWYQHTtefBGoKrbkzksL5ZvTdNRcC44/Z5u4yhNmAsq4K6wDQu0JbADv69J56jPaCM+
 gg9NWuSR3XNVOui/0JRVx4qd3SnsnwsuF5xy+fD0ocYBLuksVmHa4FsJq9113Or2fM+10t1m
 yBIZwIDEBLu9zxGUYLenla/gHde+UnSs+mycN0sya9ahOBTG/57k7w/aQLc=
Organization: OpenVPN Inc.
In-Reply-To: <CA+XhMqy50a8zq1foi564r2niHzJo54E3TCpT-YmYa=r2n75Uyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0EC0F521D38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287184-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,openvpn.net:mid,openvpn.net:dkim]
X-Rspamd-Action: no action

Hi,

On 12/05/2026 06:56, David CARLIER wrote:
>    Same multi-read pattern shows up in ovpn_tcp_recvmsg(),
>    ovpn_tcp_sendmsg(), ovpn_tcp_data_ready() and ovpn_tcp_write_space()
>    - happy to roll those into v2 as well, or punt to a follow-up,
>    whichever you'd prefer.

@Eric, if you have no objection, I'd pick this patch up in my tree and 
let David follow with a new patch for net-next.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


