Return-Path: <netdev+bounces-190001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DB3AB4D99
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90D317C7B0
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E360D1F4C8B;
	Tue, 13 May 2025 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LwgRc8HN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26271F3FE2
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123457; cv=none; b=rnoldafCMztpWYFAiJO0uhduEfoeRePXLSKJ5aPpTU8j9b+04DDIt6o981BuF+QFdcq3x2LxKNbOTuKr/4HeMKfoqMKXm3ryGU2WdMr75Oa1Y+DKHPtm4l1NFemSeJRznsehGtZ/tFRBTiovmwD1vgoHYmxNMlWkHLVA31xBwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123457; c=relaxed/simple;
	bh=MVl0Z7jmhntygGf0XzS7JdF5UYySrCikiUOwWWj4Ei4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7yZ9CopWZTqjPNL6onI7A9JhnCvADgEPlzg8LcZBadbS26LlbJ+L/mitxWkU5TB1QTkFVCJvzofKzuSvyk19aZbbibWNlyFo/ENL/dR94EuycGqIhuQe3g6a/RxafdKOBgZsmzRnPd6MznhH3aym9Qw1QCZEJ35GG2QBnxKfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LwgRc8HN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad243cdbe98so437971666b.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 01:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747123454; x=1747728254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GnWXXAY8sptTOmpzNo2+REw88fqiuCfYrdluj003TXc=;
        b=LwgRc8HNP8isDBftNMv8mZjrGXCdEDwCnkrsuOXxOPVDAO08C73HtjrYUmTcTUvRmt
         0dKQnVa1Ir/Ox1uHJ81b94pkaATRNZaMErTGb5t7wyB/vsqXi51dbnB8gJZKmKZX2nYW
         f/7YZsnXUCqsuwPs0y2LmtphY9N4gc2yzZIdmuS+9PQHaCwaPxjuk0z48JJG85OFWGeC
         CLq19RbQppCm5lcSt1qmbJU1JqzydVRT5PzbwBhU9uU3NOMh1ExmJqf5VodKeMI57hDM
         YVZWf27QRrHr4igqIRy7XzJgfENC59e88P1lJxc5Fb57KQIT8jVqp18F+g/CL1H6gX3j
         U5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747123454; x=1747728254;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnWXXAY8sptTOmpzNo2+REw88fqiuCfYrdluj003TXc=;
        b=Nau4AE35X7LPowbotJERKrt0qQ6eO9dfnn8ikJB0j4o+7PiN/Orh7t23l2bvTBvzcE
         IAam0oR8Xe90Pl1zE28rfA51340h9xaE5ClbGtto7b0nyTe9ZtS1gYoVg2VJwbIR7cKC
         Q2JFZSYE4X2u3lhDrHSq98s1jkFQUJMxADK1rv8wO42X5TsA6O9HNFDkt8JNLXJQaKaT
         nnh/057Qu9lgcf6b1/VecYFa/QB5/P7Xy1ob9Zwe75Bg+RYlvHE05CUSh7dDVCfxjCcW
         N9MY42IE+pIHFSKLcd/lE2MIlgvN0+PloGiE/RV6TMV7q3DmFYu3FxgjA1wB+/Q/k5vx
         5eQg==
X-Forwarded-Encrypted: i=1; AJvYcCVdGtSuKHfe+R6+OnX2bVBMTkItD64cbEEKQyKS8II6/sOihKXHCuo4g4m0IUnuTO1hHtir7y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCyANv9aHPw8dvawrkf7r368HB6Oid/brd+jS/hrxpydQCyoH
	6ZQsyyy25R54JLt17YJC3xbesVkGq0QKL/LK1tY/qFsgdXzYmKnBS974ChqePyWq0r247nLWUwP
	no4lYGw0T8G3xiGO10cb6BBe/wTX/Pia9qB+KCaQO5SxekH8=
X-Gm-Gg: ASbGnctCP3r4m13Die4KKXXDNHX4F6EjIdhM6QNAKnoITXTzOzSXepwv6rpsRtOnahH
	SgzhtsKcdkyLDYXarcmFFIz5VO052fOcyrlwOn8EsSOHHUy4G4GvJQ3IbyyCDWRPB1uGhv3LUMI
	hsGVrRIjx5cLJyUF1/qM51hUJgokXv8veO9pqB+rrViehu/Gn1BloEKUV1T3RHlmlfOzqcyoFK1
	guAYShl47Kv1mZAMSobhLdnciUiCZCpY/P/OUcAkmacacnjaOpiaveczg8P19JbK/fvoUp0Roqq
	ldnFsQEOl/nh2CVy2KBaaZ4gMbduxPtWfNpP4rmyym5/UzKC+aih/DSvpeIkLY6mgZbSI5+AsP6
	yePwx9tAxyGdqYZ3CBMxF4//e
X-Google-Smtp-Source: AGHT+IE/KW8ESBBjKYHzea+yyiPPryzarrJvitv4hngSbXMnrgfeiU2RPoGxhhURdEqYpGHxyGmOBw==
X-Received: by 2002:a17:907:1c92:b0:acb:5c83:25b with SMTP id a640c23a62f3a-ad218e41019mr1570108766b.7.1747123453765;
        Tue, 13 May 2025 01:04:13 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:29cc:1144:33c3:cb9c? ([2001:67c:2fbc:1:29cc:1144:33c3:cb9c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2192c8608sm737523566b.26.2025.05.13.01.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 01:04:13 -0700 (PDT)
Message-ID: <d322b640-ad53-4bf6-a9b6-8a03eca50908@openvpn.net>
Date: Tue, 13 May 2025 10:04:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] ovpn: improve 'no route to host' debug
 message
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-10-antonio@openvpn.net>
 <a5b65bc4-3684-4314-b88b-4b78c919cb6c@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <a5b65bc4-3684-4314-b88b-4b78c919cb6c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2025 09:53, Paolo Abeni wrote:
> On 5/9/25 4:26 PM, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
>> index 24eb9d81429e..a1fd27b9c038 100644
>> --- a/drivers/net/ovpn/peer.c
>> +++ b/drivers/net/ovpn/peer.c
>> @@ -258,7 +258,7 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
>>   		 */
>>   		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
>>   					      &ipv6_hdr(skb)->daddr))) {
>> -			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
>> +			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c)\n",
>>   					    netdev_name(peer->ovpn->dev),
>>   					    peer->id, &bind->local.ipv6,
>>   					    &ipv6_hdr(skb)->daddr);
> 
> Since you have to repost it's better to move this chunk to a separate
> patch, as it's unrelated to the previous one - or at very least mention
> it explicitly in the commit message.

Yeah, the line:
"While at it, add a missing parenthesis in another debugging
message."

was too vague :)

I'll make it more explicit.

Regards,

> 
> /P
> 

-- 
Antonio Quartulli
OpenVPN Inc.


