Return-Path: <netdev+bounces-160157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A13AA18905
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 01:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30621188B16E
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 00:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233B028373;
	Wed, 22 Jan 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="J5hY5fbW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25414A85
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737506397; cv=none; b=iZK5EUHk54H5Gj3UWONUbaFfkWDg0laq/88s6V4PhJIwxlNV+ZRCff/9uSzDDutP55rxUMH29O/CiJhmvd5HEvnvN/VUqKH/v4x8x9ILpQmC+M9PwmJ8/R6nQejIi3OQ20Rize0aF2cEBB/s7mrNzLDpMJqGXurck3VLjEGLWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737506397; c=relaxed/simple;
	bh=SdZKzYOFjcvJbhaQdbT4IeimgpWNHjtjCmLbXbxOSjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/d25mhnEJ6eCKN8ZBMfEV5LFkc6i238KwIyzJfaVZwm2tHoxcH4R7kzOLCHUeTnlma+KrydXMy3Z/8MeZpbuEZRTMLTdLicAx9ucDV+GoRkEcrCMznECfRaGXIG3ZtRthoapnoYKUwthISkuvNOl7UArGGoRP+VsEUreTJB7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=J5hY5fbW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aab925654d9so1111528066b.2
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 16:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737506393; x=1738111193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xe4seuHvx9fyPEV4EIFNjwpAMDzJSfbeTTxyvfVQ/2o=;
        b=J5hY5fbWz6NYbIFOuVUMbjVajmDfl9EqXZJdTLPrfIA5PyJGiTXEO3VFgZWlj7C+Cu
         Yh3ufSgexafnvB2xvArWvdiIO+u2cJUtcisN2/oVFP+ZsN7miG3uTPnzk1aAxR+FLoHp
         HD33q9SozlERDgn2AJI4q4OAGRTprbNnW7AwiLu5Bx37z25R2OwUwHoN/P2J8cBOyBdS
         /JsGAIK3FTF/dEMvxbh1qfoUtYiiT3heHvh4OPGFlWk+dzWOt/KEbJJWqEqLvcdwG8mQ
         tkb0lSUVlGslNmRXdF96BgT9fBzhj88OVKU5i5DTgwp+vaY8HJRk7AevW06sQQpw51U3
         iXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737506393; x=1738111193;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe4seuHvx9fyPEV4EIFNjwpAMDzJSfbeTTxyvfVQ/2o=;
        b=gZqDAdeds9/VzspcdFidlJiQsPYnItvm5srFvaTsSCuT8al3M2NFpmHT8OusRBiG6H
         Yvf/ktpMe+CokiH4QiPjt98eF+kv+8OWjsof4TEzYMgPHP9s1ATyIt7PgO/yovFgnOMk
         EOQhBiQm7aKyUC9G6LsocN9+0iKMDBXlz9GaTYmiQsUqmXGRoXEk9Yuit691AXVLEwsM
         afvy50IQFUOabWd+f+630DnZ4acUoBC8kwB3zX4eAfNqp2ihALgvwVTDszd8XnE42MRk
         GuQlTBJZdcZpz2/1JPVNDU2lw/mI2ft1oZoDY2KLjBqjI/St+O0kSM49Xqgvlg34qQj7
         7hyw==
X-Gm-Message-State: AOJu0YxPpa0x8XOKB7G81aIvoV++FkgA94N9fb5ecOWUZd84R9qewihg
	Zf7oif94qfH30AT3/lv9IyVGVgNld80uJnMM5TDirkOiSBEEk3Q+A1rGNJ6EF5s=
X-Gm-Gg: ASbGncshulPQvGxD2KivmS1IvaaN1AZUynDMdQPDSC1onUUOYqMHrujYGxXrGAKLCj/
	WiJfQ1MdHVtQJGHFBJzOqwQN0m1GQPTsoQIkCFMuQ2QaJnk38EuX30y0f3zGIX5V3XYVDwLDIA0
	bTCaU19uh4yd/rul6F75fqXa3pEFmu14x3FzYPkhUNj6AklVsUwWRztK4xt0aDYNE0gniZKSpAX
	C1bFTRbuiEQeDJfwcis2GdkDwyC/xNQQsjK/fXjmzELcaihrecBLjVCVrfYjs3z5rTtMzRa0GgZ
	EV9MqQaW87joaWl1lMJOomFFlFl1ZAQj
X-Google-Smtp-Source: AGHT+IHwMvg7Jgf3gyg3QM1Kx9E3XAxotqb6sHHRIgnXn8fANxuPm4B1kK/hetMxfb3Gw+V7wK2sUQ==
X-Received: by 2002:a17:907:3f0b:b0:aa6:ab70:4a78 with SMTP id a640c23a62f3a-ab38b44de69mr2046519966b.37.1737506392922;
        Tue, 21 Jan 2025 16:39:52 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:2b1b:6df9:ad3c:c183? ([2001:67c:2fbc:1:2b1b:6df9:ad3c:c183])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dbe6de509esm1159790a12.70.2025.01.21.16.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 16:39:51 -0800 (PST)
Message-ID: <6f907895-4f5f-450f-8aa7-709625e4bb25@openvpn.net>
Date: Wed, 22 Jan 2025 01:40:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net> <Z4pDpqN2hCc-7DGt@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z4pDpqN2hCc-7DGt@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2025 12:48, Sabrina Dubroca wrote:
[...]
> With the delayed socket release (which is similar to what was in v11,
> but now with refcounting on the netdevice which should make
> rtnl_link_unregister in ovpn_cleanup wait [*]), we may return to
> userspace as if the peer was gone, but the socket hasn't been detached
> yet.
> 
> A userspace application that tries to remove the peer and immediately
> re-create it with the same socket could get EBUSY if the workqueue
> hasn't done its job yet. That would be quite confusing to the
> application.
> 
> So I would add a completion to wait here until the socket has been
> fully detached. Something like below.
> 
> [*] I don't think the current refcounting fully protects against that,
> I'll comment on 05/25

Sabrina, after the other changes I acknowledged, do you still have 
comments for 5/25?

Thanks a lot!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


