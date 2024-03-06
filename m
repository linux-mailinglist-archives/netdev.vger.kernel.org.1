Return-Path: <netdev+bounces-77964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BD8873A52
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B51F1C232F0
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662F71353E2;
	Wed,  6 Mar 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JnibbZ9/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF8131744
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737674; cv=none; b=mR92lKr6AroQOqpOYocHU6X6caos8G1gWdFDMdA3dWNJ9tWw6otacunnbD8aYpsyv38rTmcAOIxDKyVn9CF1n+ewD4+SIEPsn1NH9D4wTOyewoMFDAM0sQcPQ01jN7WUAYNdBjacQlQJAxIKzHmT+/lqidy8AcpzFxS7TZjXt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737674; c=relaxed/simple;
	bh=d5bk0Re35JVK8/vwhugAPRbZQKNLXdX4Z3T29NVadME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBweWR3Z1LbMxXc7pwnUWMt2jMKXyY25i3rWDqOzPb9wB1oryN/d56+MloKkhsfzkbDIW42ClF14w1JiccOTLoL61qWWDYbUP80eTo+3lQhBLqJ6aIj3zHABkhTf3Li5lbq5w7bKs6UbF4+6E6jJ+npNS9NzBN8GxIofSySefjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JnibbZ9/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so9609345a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709737670; x=1710342470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RfgWzwa5Q16piX4r4B08UV9l16CetyguRfHpgkGFhS4=;
        b=JnibbZ9/+EiwvI3M7w9p6jubwojH4RgWFJ6yM2WBqpddXpAaZvJV65h4s7ywrcqBnJ
         X3onNA3k1wyQy/hPzLqVL/A70TSqYJbM/bo0Y7ky0ibr9/Z6gGBMdVFqjhe86UwmVwaE
         tHgby40WBRognGAYUJRKMBlTaASvWhKrpXAWbzwk3JXeOzUDKPhQ+P9jscPORtxararD
         Z3PfeqJPxqBo9c+nyMv2nCPWB4fxW+zAE2sFAuUHkG/MKdx10G5xbdwf9qlmb8ZwCo1u
         Zgte1R7c9GXJS0Py3593rK4rdJ5+hduZzp7/VBeqz2T2dHtEMtCanBZVJmi+kd4Kc+U2
         vqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709737670; x=1710342470;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfgWzwa5Q16piX4r4B08UV9l16CetyguRfHpgkGFhS4=;
        b=LLELK3EI/dp/jTjELhZLJfACuElrjJ56IXdE68l2cMmVVviAWTxP8VVsT9bb9wStlO
         DTZZAEkLS0xhrzETZQ4GXnj8MJRSjirmn54uTUiSRDirTm3Ut+VANg4f2zz1JDQhQEA6
         7Rd5f+ubkrgeXcnZM1w6rI9vtYWAdlJGtj8a7m4Ogv6HCjBPOfDJxtWa+Zt2JQpS7TUG
         zZHqEFw2ZKMHWakcJfJOIOZJd2ei+Z6h0HP5j5yl9XkkHw4Lsg+o23F0us1vlDBbQpSM
         oteZprswsSIkjKxUO9ZLTocpTuFtU5nKqOccWg5xA4glVAkRKHePYCAy0snQl/AvBl2x
         d37Q==
X-Gm-Message-State: AOJu0Yz41EfCvB3qC9KrKG3OuF+dQKbl17Z9+2opTCflEskN8tqlxVle
	MQ5XAgDXlT00Z7SpDJncz4ya6J7BKxX4uRSA4kQv5H4aho0kn9OCzZ20XjsHjxw=
X-Google-Smtp-Source: AGHT+IEgfB3mxJlD9O/pnFIYL2bKhLsbqZ0VqOWOhO+VOzPcuoOw7PqcclOtTFX2JOoJBOWc3C5AUQ==
X-Received: by 2002:a05:6402:313a:b0:567:3436:b85b with SMTP id dd26-20020a056402313a00b005673436b85bmr6921178edb.12.1709737670607;
        Wed, 06 Mar 2024 07:07:50 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:2746:4b81:593e:203b? ([2001:67c:2fbc:0:2746:4b81:593e:203b])
        by smtp.gmail.com with ESMTPSA id ew5-20020a056402538500b005667a11b951sm7001148edb.86.2024.03.06.07.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 07:07:50 -0800 (PST)
Message-ID: <50f35d4c-5306-422f-99c9-ac094d0b5eed@openvpn.net>
Date: Wed, 6 Mar 2024 16:08:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/22] ovpn: introduce the ovpn_socket object
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-8-antonio@openvpn.net>
 <20240305145911.GJ2357@kernel.org>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240305145911.GJ2357@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2024 15:59, Simon Horman wrote:
> nit: ./scripts/kernel-doc -none
>       complains that the fields of this structure are not
>       covered by it's Kernel doc.
> 

Thanks a lot for telling me about this other script.
It's been a while since my last kernel submission..

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

