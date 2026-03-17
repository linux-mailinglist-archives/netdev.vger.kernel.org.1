Return-Path: <netdev+bounces-268452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFQbF9b5uGkumgEAu9opvQ
	(envelope-from <netdev+bounces-268452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:51:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0768A2A475C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 186DD300950D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AC83451AA;
	Tue, 17 Mar 2026 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl6lM7Ok"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD113446B2
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730113; cv=none; b=OJ9nqeUYN6yTvLuCUOTZYxXdslbye5xErvyZ8qt5as8MtrThb6glM9O3XQ2iccnAo9CZNd9k5nP7tYnS2KHFp//56/D8FSXhhtfRfPtS5GPCvdG4ZMzwIGpqXv0tKwi9pUioKLbiTh9737GmDumCQYQ4/t2ZYoCEOYAhI1O+Bbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730113; c=relaxed/simple;
	bh=7mDT2KegbjhvcGVQ7Ky//j6ZPW6Zd2p+RwPpKzFXQmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AW8snUs/WLRD6YZ8HOLiY4OzthNUsDNpQ4BXxJSc9qE4mJBURLoik3FZGNl6RAexQIfs7prnPexZ9r7YNOXSJ+kuu4eJrXcnj0PAWezNOOKj1lAxNf4NrTVjx9yQm+IgJQszxr0JMdzXjh8pSpuOnpvyDlXrnhPdc3biS86cMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl6lM7Ok; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c0bcd8f194so3197636eec.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773730111; x=1774334911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/uOq+b65vcKRbPJG2b/xfb9wjJT/epco+iRGrxkHWQ=;
        b=Jl6lM7OkYWMjal9cJ2c4wfuIsWki21sMKWMw91Es/DWIEtNnSpm3sgg9i8bcrXbGD3
         2QzOotwbrY0CTKbPoa5t4wiVXbXMXhcTVEOUx6AfPqQNhY0dHG1Y97+Vvv1oT86QwYDa
         HYitxSqwXpsPE9nU/uROOxPtyxTdDbFv+5nTztDsVbx7nT3Cj7ydZLO91xrxsjnz6TGS
         fUILnpgEQPvglN1rA22Lp2aK4M26f6nNuoleWF/7C1Gz/+Xc84SUeWmLMP2Bl7Vtwf87
         3bQh1/juoy/+SebiPlYN4whYButH+zk+0ejhAxQZjFjqzBdbm6ynf2bdLnHf3y1TUukI
         6x7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773730111; x=1774334911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/uOq+b65vcKRbPJG2b/xfb9wjJT/epco+iRGrxkHWQ=;
        b=OMf222O08tHwgW/w8+xjAeNwrjoYKQM4RuW+T77Ebq0bU28ywydP+noq69LUvub0mb
         mTnbfCJBh2wdu+Qfeu3eMZ0mopg7451CfTDjEzkaq1/vMREINTvO4Shxtr5sQmNIkvPh
         bsvlgTgYNJZKzqR+Zojd5cnAZqGUVXzTi/sKA/34koM9RC+gDfaS7zln1gyGsu0Y1ZSe
         OtNaPULt5D7eqWMFZ3fc11lkzADZMjo8Ei43PLefVXowhvaVas7Je7nEVP6nzyxqe5U7
         6lUVcQ4A9S0kWvJIzeHeBS2OdHxd9xdy2aQ+UuTwSDeb0I3ArXM0T5vDjqO40JF4H9wu
         6b0g==
X-Forwarded-Encrypted: i=1; AJvYcCVx+Pc5vvfafcwUWp/iCHG/0W/6wIgsVgXbRv/G3/x4RuhthTu/9dkK46/xaSsG8raAzfqOFj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYn4qyvNqoNVEuRXWfF7inIG1IJ+IuYcVao/V/CtXyzUfcNdY4
	GTLJ+lchqH7aAhmdvMwWDJuJS4pJ+X9Lv1NcpgbiY9v+P0QT2eIXDBuz
X-Gm-Gg: ATEYQzxP9JKnyeCLxwdcQMikZO1u2kt3E0y0ezQbr7/j3TmY4ctytdnfrrZnyH8prpd
	eHH1m3+e1cn1HRlmAvJ7rwnj95o4IUwRe33ZEgmt4cHrSz5fhc+HSCVEjKnZeHzW4MSwt4RDI96
	D7zMtesjVCygh/Or37zPs9fp/8qYvJsNuJYmQNbo12gIdxNPDQ7YAbT+iaM8S/UqqeuYqqJ+2jP
	nBcL5h9s4K3PqHuO7dutHw72IkHhYKxKRjeHCdHrT2Odqy8reKmDUxHkHAK+VUMi90LY7yn2L5Q
	Jky3W7NhIqOv6myByaiN8A/Z3XImIcwCvG6WY+Wu6xr6ZM3K7w9rEkpugMzZkW/VFumK9g/ISOz
	mtTAvKCfWu11OgYp7KQZeSniGsxHzzTXMdcMRrHt9HN7sD0cNOHCqxsUZD511qNQF0WS/zlAhtc
	TOPaK9pSoJ7aLYhslFNRcVftsbSaY+eoXCyzMnwfWPDhRmak0abhTsnFnpyr54l8owvFO5ME+Vn
	krgyjprFtZJzlwWX9r1Gw==
X-Received: by 2002:a05:701a:c96e:b0:123:3500:b688 with SMTP id a92af1059eb24-128f3d45b05mr6349426c88.19.1773730111003;
        Mon, 16 Mar 2026 23:48:31 -0700 (PDT)
Received: from ?IPV6:2601:646:8f01:ac80:1833:81b1:8dd:ec21? ([2601:646:8f01:ac80:1833:81b1:8dd:ec21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab526f9asm23132416eec.19.2026.03.16.23.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 23:48:30 -0700 (PDT)
Message-ID: <f790d4e9-7f17-4878-860f-8d21c4c9c307@gmail.com>
Date: Mon, 16 Mar 2026 23:48:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/6] selftests: net: move common xdp.py
 functions into lib
To: Chris J Arges <carges@cloudflare.com>, Joe Damato <joe@dama.to>,
 Jakub Kicinski <kuba@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 David Wei <dw@davidwei.uk>, Daniel Zahka <daniel.zahka@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Nimrod Oren <noren@nvidia.com>, Gal Pressman <gal@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260313223029.454755-1-carges@cloudflare.com>
 <20260313223029.454755-6-carges@cloudflare.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260313223029.454755-6-carges@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268452-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cloudflare.com,dama.to,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,davidwei.uk,nvidia.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0768A2A475C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> -            _set_xdp_map("map_xdp_setup",
> +            bpf_map_set("map_xdp_setup",
>                        TestConfig.ADJST_OFFSET.value,
>                        offset)
> -            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
> -            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)
> +            bpf_map_set("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
> +            bpf_map_set("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)

Looks like a duplicate call to adjust the offset?

> +def format_hex_bytes(value):
> +    """
> +    Helper function that converts an integer into a formatted hexadecimal byte string.
> +
> +    Args:
> +        value: An integer representing the number to be converted.
> +
> +    Returns:
> +        A string representing hexadecimal equivalent of value, with bytes separated by spaces.
> +    """
> +    hex_str = value.to_bytes(4, byteorder='little', signed=True)
> +    return ' '.join(f'{byte:02x}' for byte in hex_str)
> +
> +

Since format_hex_bytes is not exported in __init__.py, Should it be 
prefixed with _ to indicate it is private?

