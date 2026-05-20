Return-Path: <netdev+bounces-289802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPpyOyZhDWquwgUAu9opvQ
	(envelope-from <netdev+bounces-289802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:22:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F197B588D64
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F21C13006981
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC4C35E943;
	Wed, 20 May 2026 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KyaRiwwY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32A2853E9
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261728; cv=none; b=pqfA6PYMY7S/rG87ZB8e7ReEZWanyh5xWiysY3fODQpPKN1mSIB2qZMwPYPCmHfffV4tBFo3LfMepjrZUqTltMrzkNWqMpSsirvTIasgPKdTNkD/qyYdfOofGO3Vw0A75a/e/qFbkfUc40NIv1hJ1UN3LLIyJ2ngOJ/CmsfvI5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261728; c=relaxed/simple;
	bh=3bvqf0dqNQo3Tdcpr3G+EkeYKrO9suyD30/RelQhkDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvvaSmUmdAXo+yx3wpG3uGuVG+KmCzaKU9eEhmmdrwW0rUKK4nzIEzerLFPrB2u14+qo1rInH1ZJOitLRcYu6Hoaa1hnzX0XQ0/FdJqjRFqiWJ94HM3TNwRctFDlRq8SUc2CU6ZSE7077UxyggaCENB6gAuXzDRRt3cPydnJYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KyaRiwwY; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-912278ed3b5so490036885a.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1779261725; x=1779866525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZThCgnqofA+sjum9vrs5/ytlz4MJgWGh3GxxVtJxpE8=;
        b=KyaRiwwYSvX3k6UY2fK6l8YlsjVEzpLv6biceycpqxz4DVjeUT82/YMafftq18zEw8
         v0hOoXgiKtt7uO0EXkbtznx+UVnh9FbttzVo39s5giCJv3JOCbLElvRRGkaZvkWwx0P5
         078oludD5XaK3atcztI7KBeoC4avEHZuGak8ZXkcqeHnYxR68VEy8V1Jqzwi+1DBx8L3
         vl7ocY68ucR0pUPI/5n94j2mr89SPX0WEPX+FHcsdNTogWdu8FvPoOrRPjXJ4AU8OKUS
         7QyI0bW1kA1cosVnSELtc7zrybzu3aO9T3Sshk4b2OCCl3Jmuik8OqSobRfoicAWNYTA
         hW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779261725; x=1779866525;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZThCgnqofA+sjum9vrs5/ytlz4MJgWGh3GxxVtJxpE8=;
        b=YUv0zPz2MstbX24RSKVQ7YSf5te1J2b8l+Cd+Un37vwDfuko+SJBurXGfFiX0YjfKz
         dNwi4e8ZeAgVHQZbWHqbIdX1Au3xe1ct37zNKyP2KN3+1xhA3r+LlBQmdzrPxvgpfyBv
         4wbDftpF7ZpRTINcnsdt/gcQ2hppf74SZcA9QHdkK7ht7zP9CAUhwgSW9fnp+i1zXRN8
         zLxuZhfnmRUkTKEq+xfhKXIg2QNV1vPxDvvuWVRRxNUWmdXwAaTX//NuIXfRyVwdEMdT
         7XyMEPK5DuUb21Vzw/e/kczYrGLVvlkFTGClsyQifvpxx5zi+RzUNO7Aq+pgDhzBO1f1
         IiZA==
X-Forwarded-Encrypted: i=1; AFNElJ/vJAE+59ExI4cgWHH8MJcTmP2IZy6poAamCrSvf1yvMSq0c6KxxGBE5GAuOgaZEEMhj2GkBTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL40sXhTAV5HzyNb6HxHFnZwIfdT/6y4KA4KUuJmp40hZo99tN
	96/SA5DWxWSofqN3LOJdOyxZ4Sn4Yfg4qNtifCwoz31/RT2gqQpcwBFNj8XNQ6m5YY3O6Nr+ZXa
	Enpq5Sv5mtyW7PTmxj9T0Y62Ls452Q0jpU3PsXDE+hUwGmXy1OJE=
X-Gm-Gg: Acq92OFv3tzINXcwlKJ/LF00NUw6WOnwYmOIFfjo8r191MEeSGIyr2xy6FRYSKFeYg0
	lL+c2/KqTyTUs85W2yJESkdWQImOtBwY8yEEHZbg+7lN5liZcwXykW4ar1/qzANOiXIXMGc5O8u
	eQXLnPGQmObuHcyPB/Lv+acWGhkDEzMXX3TBh1L/trsPp7Qm2N2YUruwxZBoz3CmcF/ssHf9zDz
	0z+ot88taPpHPEL4bOCL3DS5FzBBgvpmksXzrIJi3uqXlkSWei93k0MtK5bHkzXO4b5ISjcDYQY
	QBejHrJabeg+dMmcDlXyhAKqLBnmWgwY7inDgJQ0KUnmfO/1Eghc3lThkjlKWKn6z4RWKfEhOPV
	vKt2YF3evrsWxynRUPTzdpuwkjuSLjGi+eUpRa9uEyGNymQWZEnFJyuqSVAbzyq4fY0mlMY3MHd
	0sDLUwz8kLCZ304Q480J6ULwzS18iM+tmHzRobqp1nGtgyMb5Tr9II1jPq57ZwXg==
X-Received: by 2002:a05:620a:2943:b0:911:c9e6:20c2 with SMTP id af79cd13be357-911cdd4da77mr3495622585a.19.1779261725401;
        Wed, 20 May 2026 00:22:05 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:6834:371a:9574:110b? ([2001:67c:2fbc:1:6834:371a:9574:110b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910b785935bsm2062937685a.0.2026.05.20.00.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 00:22:04 -0700 (PDT)
Message-ID: <2932f619-81a0-4c26-8adf-7a7d0256a137@openvpn.net>
Date: Wed, 20 May 2026 09:22:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ovpn: refuse TCP socket layering with an active
 ULP
To: Sabrina Dubroca <sd@queasysnail.net>,
 Michael Bommarito <michael.bommarito@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260517155645.3882533-1-michael.bommarito@gmail.com>
 <agx0ZRfgc7WhuJtI@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <agx0ZRfgc7WhuJtI@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289802-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[queasysnail.net,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,openvpn.net:mid,openvpn.net:dkim]
X-Rspamd-Queue-Id: F197B588D64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sabrina,

On 19/05/2026 16:32, Sabrina Dubroca wrote:
> mptcp calls tcp_set_ulp() from the setup, maybe ovpn can also do
> that. detach() may be an issue.

What is your exact concern with detach()? if we prevent other protocols 
from stacking, what is there to deal with in detach()?

Cheers,

-- 
Antonio Quartulli
OpenVPN Inc.


