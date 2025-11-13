Return-Path: <netdev+bounces-238375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DC1C57E17
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AF1B4EB8E4
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9EA2727E7;
	Thu, 13 Nov 2025 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="L74V+FxB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C062264C8
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043167; cv=none; b=WrVJrx02FI6rcX35x7O7LpualWcZ2S3es0DK22WrLL+kiVLqT7ZfwNm4TTccrdb1+Ryu6ErzPLWXaQhhKxm/ryFZeDc6CA+y5X7CQWq/G8vo0UuJKBv39g8opR2lwqWzY+cdbUy7sKqbQLb1I/X/k+DeOAM6mM2RGBcmZVmEx7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043167; c=relaxed/simple;
	bh=F0jKKYZZRnZDY1fDhrJpONHexTetodOpGN4XWnWGsro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucMHSjM+KB7Y8PcIlspaUDwRrPwm6D6/1qAcZL3NHMPrfIb/BUYfbE+QVG3wLkJF0MXkmfyRHBy1UQHODf/lzNXK1O/H5J05lBpXMG+aVZAPo3u5upjeLhP8ZJdn8mpwzUcVpwFtzoPTnhYt6/12kv/FHGeRYNEX1LlytexEtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=L74V+FxB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so1495068a12.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 06:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763043164; x=1763647964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tLyNs0mSb1zxzychypwD8cbR1V9X7Is6zoP3QCo89TU=;
        b=L74V+FxBAtZSFiHuLLFUZf/H+ij3zaxmV3PpKlncuAMqLqleIwWzD2fp3ft7DwJxuK
         DsyJzqp2NnQ7iFfpF0wT5/DR1Llw9qQAOybtXOJ9fMeGjYIsbJBXlIs1T7rJz1bRS3MM
         BAFZcMcEh1C1q7Vg1JtY1Dav9S/bW64roHpaJWwdUYZUNdVgPL0BwNN0ZNlkIaZubEUM
         t2CbxkXiJfQDr4XZdwLIyITnPNokBU3R1kYRrePiTay/wqQo2kLMYkbcFAweF1WEVo5i
         WE7pPQcaaAvS4ke/lr1ivMEjjyQKkKDDmrPSU1lH3dGCqohacviwQOY/DDAbAH/UccnZ
         DNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763043164; x=1763647964;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLyNs0mSb1zxzychypwD8cbR1V9X7Is6zoP3QCo89TU=;
        b=dT2jqwAgnE0T1UTm57vQzfXWLAVBz1I+THRRZwuDiuDMuuzLTz9hDPKpa+fXvNNG3O
         Ir5W1nYBa6pKekm6NrW/Bo2NVavkipolM+KABq9MaRh1AvxkWwXITcmdhSOS9pJH0IYm
         kOLuYnAVfrwD8JSvpzrabPcJJn1VUQ5rrR7iifeSS0G9FwrQY/d9nKebQDfOb77JTz+r
         JRwo8pk2rkNBj6en5VWfaTAvPRmEgv5dtIkc5fobpmGOWtAH8ut3snqc3h83QuHO36oV
         xve0qFhWAkqB6+rJbmWRoD3nu2ILm4cfwmOwzXCYZTZExSEv5iN0V3MHTG1Q7NMR3jGq
         OG5g==
X-Gm-Message-State: AOJu0YwIc6RMsRxTyFQ8OgBSAxqKZOZ0oHL+HUxgu5SPWQd4lJipp/qr
	ogX7N7O7f737YQ5ol8fmHqbbepbjaGvBs96LtB+Su6m6AZjSh++VpB/pEv9HmmXxiyXa8JQbuQk
	fDjQdZHKyEp/pWRCo3+xGdgXF7JaqsCRco7rW3Sm3UazK32FEmAA=
X-Gm-Gg: ASbGnctRg7DTg1kC4OmLQTk+lSke3IQm+vaLd9NZrYjxpFQ9zPc3uDRxCBUC7hcl4uI
	Ms6gFnfyWVrDDZ+vMs+HoI/NvYXjWDf5xYF5Lwjmg0RfS27EReKPokz9CQ3tywBFEojT9HNPy49
	lSkxNAGwyHWbqQBIgFhF3oV/oiPeRFEhfL3/xMbROtM/1hG0Viru2r7gI0TXx9R3Q8OOAlQu0Wp
	SrrEt2EnxQ6aylgLPNh3k4b24gkiazej2UxUowfKJpr06HPCbM5/PYviXNN64edCnLy+CJGjydH
	t1nnMOGDw6QlybaLbuH03XOavf1ir+RD9LdalXw3PMZ57ChDHhRjUIRueh4WmF7f65D7sX0Rkr4
	m2B4/Sp6PnOF+UA/bJXW6PpCbvgVYzsfNLVX2zdzUJltQFXnCcs3v6NsVqmbPidheOJRu+ffksa
	dM8+9nb4ADVwKQcEQBcu/kjeQKQsl2ejEIG65mXNE=
X-Google-Smtp-Source: AGHT+IEe0OBYmq5pJEzBJIWGkmDzDRPqnbjj2ufbxd42IWf7W+72H6HBX2SaTRLu1rc7pE+KIXBr0Q==
X-Received: by 2002:a17:907:94c5:b0:b71:88eb:e60c with SMTP id a640c23a62f3a-b7331ac02eamr753650166b.44.1763043163533;
        Thu, 13 Nov 2025 06:12:43 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:7016:8c92:f4ad:3b7b? ([2001:67c:2fbc:1:7016:8c92:f4ad:3b7b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad41f1sm173507666b.23.2025.11.13.06.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:12:43 -0800 (PST)
Message-ID: <461eef90-18b1-4ebb-b929-9f0b3e87154b@openvpn.net>
Date: Thu, 13 Nov 2025 15:12:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] ovpn: add support for asymmetric peer IDs
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ralf Lici <ralf@mandelbit.com>
References: <20251111214744.12479-1-antonio@openvpn.net>
 <20251111214744.12479-6-antonio@openvpn.net> <aRXj_--Rbimt-5yL@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <aRXj_--Rbimt-5yL@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sabrina,

On 13/11/2025 14:58, Sabrina Dubroca wrote:
> 2025-11-11, 22:47:38 +0100, Antonio Quartulli wrote:
>> From: Ralf Lici <ralf@mandelbit.com>
>>
>> In order to support the multipeer architecture, upon connection setup
>> each side of a tunnel advertises a unique ID that the other side must
>> include in packets sent to them. Therefore when transmitting a packet, a
>> peer inserts the recipient's advertised ID for that specific tunnel into
>> the peer ID field. When receiving a packet, a peer expects to find its
>> own unique receive ID for that specific tunnel in the peer ID field.
>>
>> Add support for the TX peer ID and embed it into transmitting packets.
>> If no TX peer ID is specified, fallback to using the same peer ID both
>> for RX and TX in order to be compatible with the non-multipeer compliant
>> peers.
>>
>> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>>   Documentation/netlink/specs/ovpn.yaml | 17 ++++++++++++++++-
>>   drivers/net/ovpn/crypto_aead.c        |  2 +-
>>   drivers/net/ovpn/netlink-gen.c        | 13 ++++++++++---
>>   drivers/net/ovpn/netlink-gen.h        |  6 +++---
>>   drivers/net/ovpn/netlink.c            | 14 ++++++++++++--
>>   drivers/net/ovpn/peer.c               |  4 ++++
>>   drivers/net/ovpn/peer.h               |  4 +++-
>>   include/uapi/linux/ovpn.h             |  1 +
>>   8 files changed, 50 insertions(+), 11 deletions(-)
> 
> The patch looks ok, but shouldn't there be a selftest for this
> feature, and a few others in this series (bound device/address, maybe
> the RPF patch as well)?

selftests were indeed extended to check for this feature (and others).
However, since these extensions required some restructuring, I preferred 
to keep all selftests patches for a second PR.

It's obviously always better to have feature+test shipped together, but 
the restructuring on the selftests may require a discussion on its own, 
therefore I decided to go this way.

I hope it makes sense.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


