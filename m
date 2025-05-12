Return-Path: <netdev+bounces-189656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CB5AB3179
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0747B3BBFB3
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359F2586F6;
	Mon, 12 May 2025 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LZR9VX7o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F22580C0
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038150; cv=none; b=Ogvf9s7xnyQ/zeY6gUidkt4na3zF+YXXr4H1aFben9GQkufzXUuF1qmdyWYV3lVjg24PipIUW4tGIICXlBVllUYdliNYMgpC4om4RNkFkA1vmATVudd3c29fD0wKjNx3WwCUTDOvWMVmj1/amiL8gE32JBoUCgdff/PswWjCvfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038150; c=relaxed/simple;
	bh=RefYP+aC2XZt1QTgxHqSz9bXs31v2R5qAN7LY9zc2rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEGvhsVx3QtXKZ7Q9d6NDBOSRCF1OdGRyUrZ5WMpgpRvbEar95FpdTIhFYOcFSvSeL2V/dKwDFxBrU8kzObcFfpotdBHwqLCKKp4hvPGhKa1VwNE9nvjiBuvNGwSDzWrl7QgOPLi1gGO965M5VUCLZ4eJSnhqDTsemr42yubqsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LZR9VX7o; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad239f23e8fso220955966b.3
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 01:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747038146; x=1747642946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ13AQpJTh1Qdf2+Jipu7Es0MqZ7y/I4WOqHYllJvV0=;
        b=LZR9VX7oHnVa7IMC/j+lU2ickXoBrnCj+2XTNgqzKDDuM0r1C7CjL7O8gqBPR4xTaG
         x2Qocqv0VW4/zbAtBU4jxJf+tilRV4YOmSWNhGQM9hwv0DaQHDHPvb0rHHMnUUH0U7G8
         VXkf8iDIHXLm8zd5e0GGeX+fMh/FrkJiBpNmheyvXaODYLGtDHI94meYog/4WWjX3cr4
         5PrYEmIl66QqrbRv+uwvGHprEyxgDHZUbPJYkHi6i3lxZRRk4k4LUO1Df8QPqW37OXQR
         RHtk7P5jlYleB9wOb+jaLQecDTksqPT3nPz5uWuy8oyEk5jrFpQl9zSY95DhBPLEDG9i
         l4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747038146; x=1747642946;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJ13AQpJTh1Qdf2+Jipu7Es0MqZ7y/I4WOqHYllJvV0=;
        b=UGJyyqphim9r4QkdWBQSqfrgjEQOD3HMHVYICXuHcTfgFEhGLH5rAH6qzZvQPfyo2B
         OetSl9m+PYF1zkbL6avLed4KhuiP0+NfelIobAQjjHkO5kqV7DABuDZ2ISUshQ1yJ3YV
         5PPBETUItF9OG6JdSBwwyTP9aLJOYo10tn1JuAYmGjVSkxzEpJmFIarEfPB9yOohvvoL
         5TttMA1oVP/MlZo+NGrvfmnjZWQEjMnXBSpOub2r03/u84rtNLVRAnA4w6tuH7zIGQC1
         gjV8/6Sy8qWi+tklWqUawSu7mDSUv02khcY3grwz64qyw9294Xul142ys5QfwJ8tGcwe
         z+Qw==
X-Gm-Message-State: AOJu0YzrmC67dYM4GFi26fJNhCWZ3YbePErArwILiyr3z9TFjEOwgJCP
	hOVLaLckMV2x5puHD8a95XVxsDTHLeB3qwBLqRE+Z8Mc834VzIh0LzBichLw8o3hB9M4xdiJD6u
	kkNat/qsU8tqJ6IDTlcnA/qHselhYbomJsocYZvVoTAxBWFY=
X-Gm-Gg: ASbGncvqLnsxjj8Cd7lqJH+ZA3FnhhV/pSh2Dedpk5IhYLs8CMs3KDmnE0H2ksvj22Y
	1cefj1XPs65IWjWPNlxgGAYO+lYYByBfpM8DX8w8pIODiJGjNel8q/6BBBrsnxTaZM/+addmmjk
	nf9mwn+buu4E+MLZ44J6mujS9vr/eZ1oVseBPRE+sKvLd7rUtGeiXYZz2XEM0F2d8BB7XA1JMju
	1mlfTJZbZDrOTXdFZYLUtM84ZPQH/q8N8Qz4eIsJlRS3vS2JHh+wR4ac3R6WbwVbGUQvEDfwgKH
	izbffFGhZX8V9MXLg0bItB39Jw4yU+YVti5Hh2nMt0E0CJZ+Y+9JBuXCjDSfgZ/AcIRemj8cKgC
	B9c/aO6SPoISa+A==
X-Google-Smtp-Source: AGHT+IFLKZWHtWH3tWTrTtOodF1hBljGpygn4jG9K5DNym/TE8hXyPXWFB4Jle3X4NCrUCfdxYCiSw==
X-Received: by 2002:a17:906:2517:b0:ace:50e3:c76c with SMTP id a640c23a62f3a-ad218ed63d4mr857480266b.21.1747038146274;
        Mon, 12 May 2025 01:22:26 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:61f3:d41a:c3ab:f584? ([2001:67c:2fbc:1:61f3:d41a:c3ab:f584])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2193827f1sm579080066b.80.2025.05.12.01.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 01:22:25 -0700 (PDT)
Message-ID: <b72564b3-6374-4a9a-9d3e-35d9d2742b52@openvpn.net>
Date: Mon, 12 May 2025 10:22:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/10] MAINTAINERS: add Sabrina as official
 reviewer for ovpn
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-2-antonio@openvpn.net>
 <7ca63031-79a5-490d-b167-41cc5e53ff26@lunn.ch>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <7ca63031-79a5-490d-b167-41cc5e53ff26@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2025 16:34, Andrew Lunn wrote:
> On Fri, May 09, 2025 at 04:26:11PM +0200, Antonio Quartulli wrote:
>> Sabrina put quite some effort in reviewing the ovpn module
>> during its official submission to netdev.
>> For this reason she obtain extensive knowledge of the module
>> architecture and implementation.
>>
>> Make her an official reviewer, so that I can be supported
>> in reviewing and acking new patches.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> Acked-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> Agreed. She deserves the credit.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Hi Jakub,

should I edit the patch in my tree and append the Reviewed-by Andrew?

While at it, should I add the "Link:" tag referencing patches on the 
openvpn mailing list?

I can keep the same git-tag name so that the pull request does not need 
to be resent.

Cheers,

-- 
Antonio Quartulli
OpenVPN Inc.


