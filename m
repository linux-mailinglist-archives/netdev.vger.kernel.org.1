Return-Path: <netdev+bounces-166429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AD9A35FB4
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DC27A250D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193D6263C7F;
	Fri, 14 Feb 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Pf8MBZ+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A120FA9E
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541637; cv=none; b=nzZTtpD4qsxm/dsTMXQNDJvwZ/eDFZDv/K+ZLqiujQlYOiUi+A6tVxBDkHljrglrfnHtYBWdSff1Ubb2f4lNxpLX/GDCXGtLcFly5UkGx9Vg66rtLjxqnZimHuBdwYUJpu9An6pcdkkPj4qiBWaX0UWRFyta1fgJvlrA/nmfbQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541637; c=relaxed/simple;
	bh=aT52DCyCkE/FOAU5A4XxNdM0hSVkOX9rETPz1btkjJ8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mQ6xBGBlFUX0bdD30zcnYbURgkEdDWunS9xX9/Oz9nsg7SzEYN/MhpJOSpiuw1CkgjC6BJbKIqnFpG8e1RRws2LNRkFNpGD8eqQtwd4XbVFewCggfUjUm6wrSKicWtFJ2suSs7ZPhPduUtqUwSyEODscacjjUFBt+CQR/L5I5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Pf8MBZ+Y; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dc9f3cc80so868674f8f.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739541633; x=1740146433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIKJXROgZdnHdVfnlvw9H3L9hbWVM4xWzC/FdoHev/E=;
        b=Pf8MBZ+YG5nO7DTT6JrytEgcQIOq+1Q6yPXgN/2LM2H/E/yBZSZuAiQLWlvYFmOTWT
         YsNgGcus6q56K/LrzogRdBbuUR1/IHGVuH7NBAtNVXyoTs6k6nGsjLlA9+JLQJ/AkSEG
         gVaTQqhcaxIeZGrr9ICJZnMVeSeDo0/JYTV90WUE9bpxo76QeznUovViDPreIUpmOmVW
         NOD77Q2d7lGG5BmAJZSdL3QPO8u4SCPOAurpjcKo5EeLO2v2+ixdt2iuDWWNlePYN84C
         6ghjGxINUH/4MLCRlGCP6FhfpvsI1cFtIXZ5407Qn6L/SXSP0fV0w5u+RkA5a0RjYhO9
         RMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739541633; x=1740146433;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QIKJXROgZdnHdVfnlvw9H3L9hbWVM4xWzC/FdoHev/E=;
        b=rWXvzBzm26QciswNaUoy10uY53m27stxhEkAYR8hOdRlxGgRijmdxThYn/0SiLDsjO
         P1c+fNbrBey95Ky2gjwuR6wemsQoi6C+XySQWaODN61onfwKgC1pRHBgyjKwPfx7Ble/
         g5RY+qmCbC2i6JPx+Q9gr0xnnVjsyeh4dKefGozMXAUYUWdHKP/aziOExnL5txDVAGep
         O3erZzyfLKby30VaK4FZabEP9bIJ0EJG2iK3wN9ssL6JcdFZDc7gECLDXfhoHSlOd63Z
         CtZxYefXVl2DLQbD/DQQiQqObhLW6K6sjBu0JOJ/wXNb16hn4t1Jmkw2hzG3ihmezU81
         n1lg==
X-Gm-Message-State: AOJu0YxYdoWXxFsUv00OYNvAZKD8dffzr7fbNaVOdwa7LbW6qtoXWVGk
	mcjKjBQRP2AsWaUaNwrXc8KwU9NgSBdi6OYPEROfQoMW+TW+ukXF04VtbzhPMOk=
X-Gm-Gg: ASbGnctXV9OJkhxh9PeESt3xYK5Wdial7SSW7S6yBnRMBGdiT869ZaMj1u4w0ZnUzCb
	wncDkPVrmNszm1an19JZJpHZFAD97JWX/1aA/UyJe18FETP17nkDrvLNS84ZPzvrF5ID//JJimh
	eFIFbiyrWe3qKtoMxB5CA+R36j94SBb7NcJ228V9ozHGWBHmldWs8MWgGv0YHXDJyr18DBTSExU
	CIn0NPPhL+iU87SB338gEsDLEPXMrlk+E3/yl8a6vncg8deHfrOJTpRr/ic6lmftN4GHeP5MmK7
	lXFPehzFKeipIIDJHlgB4cYAkBhY9PwQni/ngcOAnfkDxPmiWryPkg==
X-Google-Smtp-Source: AGHT+IEPmiJ1bSo/864Z7aQ6et3I2XrazbxrUsk5ja1G6ShAPdhRXrrX/2IxOM6UBpVAET50cPOD0g==
X-Received: by 2002:adf:e74c:0:b0:38f:31fe:6d08 with SMTP id ffacd0b85a97d-38f31fe7410mr849213f8f.46.1739541632914;
        Fri, 14 Feb 2025 06:00:32 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:cd14:b9de:fda8:dc6d? ([2001:67c:2fbc:1:cd14:b9de:fda8:dc6d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5efdsm4635615f8f.43.2025.02.14.06.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 06:00:32 -0800 (PST)
Message-ID: <ccd4c233-e065-456d-8275-ffcca402583d@openvpn.net>
Date: Fri, 14 Feb 2025 15:00:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 00/26] Introducing OpenVPN Data Channel
 Offload
From: Antonio Quartulli <antonio@openvpn.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
 <Z60wIRjw5Id1VTal@hog> <090524ac-724d-4915-8699-fe2ae736ab8c@openvpn.net>
 <Z64Tw02PO433bob8@hog> <0c0de58a-4dac-4b3b-9fc5-2a58a145d5ab@openvpn.net>
 <507c0388-8ce4-47fa-90b3-b46ae170045a@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <507c0388-8ce4-47fa-90b3-b46ae170045a@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/02/2025 14:54, Antonio Quartulli wrote:
> For example in wireguard/device.c the socket is released in 
> pernet_operations.pre_exit().
> 
> But pre_exit() is invoked in cleanup_net(), which is invoked ONLY if the 
> net refcount has reached 0...but how can it be zero before the sockets 
> have been released?
> 
> I must be missing something, because this seems to be a reference loop.

FTR, the answer is that sockets created in-kernel (like for wireguard) 
have sk->sk_ref_cnt set to 0, which implies that no reference to the 
netns is taken.

So ovpn has this issue because our sockets are coming from userspace.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


