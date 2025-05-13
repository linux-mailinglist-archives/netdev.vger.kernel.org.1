Return-Path: <netdev+bounces-190016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E342AAB4EBE
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEFE1888858
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A456C2116F6;
	Tue, 13 May 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Z6Dvs+ff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B651F152D
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126906; cv=none; b=Tab0SB6P/9EYCfVhfumNVvrIomOyMnPr0lnAOioJiPlhnV3F3dXNZSwm73vwjLn2TwktCTEumK927C1lglpcgLaXxrKjiYKqSPANRp5fewgmkj/lmadHaku0VQ6ChAzw7cGj2+yKBVwzdoWEpQBpQJJj9El1uGk2NL2ksZsuJjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126906; c=relaxed/simple;
	bh=HufYHVSGKa/5dMjK4EU1oEX7A7yT30YviTKgq3SwIwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a26WBy0WDZSHMH0XiCtQ7yAOQIUr5gDqdSnYKRxbFF/65MAeZ1jcrAJa7TOtZTHwgQiDm2dnyurASZPAhPPvqdns6roc0r2//fpdXPScsDh/Nqo107+H+yykYkpPdOS8qPww4Jv/l4ye6LFDtSpLMr1NkucqAjF+o24LZpPoiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Z6Dvs+ff; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5fc9c49c8adso5458533a12.3
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747126902; x=1747731702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ErThekhv50PXRshA5Rb0R/065Vox7G8bEbaYE4WjNj0=;
        b=Z6Dvs+ffws6fTFrhAxa6WSn/SSXDeDUUd2BqAZuiuTShpWiIDbjMK945O/G2m6bl0O
         VbCF7Oun12G6qCE1T1XCfK/3iDagxZOZP+bVOk/5gaSglHceZkj+N/Vgt68SaUOw0nOM
         h07eLhYBdk3LjgFf5cZGV6dAhoSG3S/56kWOfv7zllTTt27P9xf2izH3jy/UmXGf7m0S
         ereI2MORTj1A6pP/NihfGkieBAKNQ/Ei4AIEPMffiraxTh5oHOLE6nT+e9hovnCP0/Py
         xOnPE1eXm3a5Mud9SNPX0bAyndQc3mc/foxp+9/mF2w1kJqTSUXtzOkVJcp2HCTMvYBw
         igGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747126902; x=1747731702;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErThekhv50PXRshA5Rb0R/065Vox7G8bEbaYE4WjNj0=;
        b=TheSK28YAVGTyIysuWtQycnwlyHHGzH3kbum+RHNqwGZ1npWDN7Fbm05lsA2uwFNTI
         zYdF71BtVF9n87Gn5qCs6Iz1Ov/Zm5U5zzb4B1fPT9NX1LyHQRcBL9WpRvUSDIocpiVW
         VUSFEhaIlMTlgMAulY3/TOT00GeLx7JShYNC8Xg2I09TNpYFH1ZQEAhPjJ3LodbsLt5T
         EW3huzkgi5E3H+SDt/yFopTFoJdZHxYyBfkDUQxEVBbiVrNUMdRtHd+X5mwH3reFmMYY
         N8njmXdEbsK1bNkQm9VEZIzCO2p72gxPqctQ6gSVXz/fgaLacPdl2gPVYvpmT6jEV9uL
         FCxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeYfZyX3+JJTR0YthZdlc3m7CpyqDKRJ5x8jQSpM7rM/a/e9KhDWCjtPfaQs7DLHbnoT33qr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5A46vO2nE+t3Y/7gXMqD7mMoO9z2nHOdRquqjkOYPjgGXaqe9
	LYc09swKMsZNh5lJd/K2fRdFS1r+piKDzeJh9H2nxBIlpnlHyAeT1+1mnMfl7nETKdcnHLKa9k6
	khNSwfE+avNYB8A2kxa7238bJEnZVQzI0hmwx8aNv6Issamw=
X-Gm-Gg: ASbGncsTiqo5++9bq8k6vDlSyt2kUA6MdP+wbRnWywz5bo0JEdlprHF9EBusci+IGFU
	9/ZK1MGuzvaWuQqjk/gvzzJHPq0C26Ofc43CUKEVQ9Qthfj8rHd0kSMu6uOTrNMVhUc4Nj40MBC
	zjbk71HlimjMBVCiWs6oN0XR8gq2V6c6TP7Obw9ivDHVCiL2ZbD+K13n2hFIb/CvxqLlXUjyIg1
	akt9l4ObxUn9kDikFx9K6oZ3YTluV8XLiz22jQXbqkBjt65mlrjXY5zQyTVzzAUVNUMuKYS4pXE
	2fhvOdi9fgDm3ehyiOXqGWSoluPTFyu+tlx2lZzCetGdLD08nVMCKrqrymlYpNLGTn9GX1RniXr
	HEA7SrDWh/S/EyA==
X-Google-Smtp-Source: AGHT+IGcBV5gP37pvJE+5SYfWkkRS5HkkdD05GoPtxddBuOOrMWIawuHHbHz1L07FC+sdFr+RQj9+A==
X-Received: by 2002:a05:6402:280d:b0:5fd:dbf7:b6d3 with SMTP id 4fb4d7f45d1cf-5fddbf7b907mr6868821a12.30.1747126902359;
        Tue, 13 May 2025 02:01:42 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:29cc:1144:33c3:cb9c? ([2001:67c:2fbc:1:29cc:1144:33c3:cb9c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe516asm6944788a12.15.2025.05.13.02.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 02:01:41 -0700 (PDT)
Message-ID: <ab526609-ec26-4641-9245-7e806d68117e@openvpn.net>
Date: Tue, 13 May 2025 11:01:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/10] ovpn: set skb->ignore_df = 1 before
 sending IPv6 packets out
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, Gert Doering <gert@greenie.muc.de>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-4-antonio@openvpn.net>
 <fc07f58e-488e-490e-a33f-50f09163a0fb@redhat.com>
 <effc10de-e7a9-4721-84ee-caafcf9aedb8@openvpn.net>
 <7b5f7e09-7df0-43cb-9acd-c31720002860@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <7b5f7e09-7df0-43cb-9acd-c31720002860@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2025 10:51, Paolo Abeni wrote:
> On 5/13/25 9:51 AM, Antonio Quartulli wrote:
>> On 13/05/2025 09:37, Paolo Abeni wrote:
>>> On 5/9/25 4:26 PM, Antonio Quartulli wrote:
>>>> IPv6 user packets (sent over the tunnel) may be larger than
>>>> the outgoing interface MTU after encapsulation.
>>>> When this happens ovpn should allow the kernel to fragment
>>>> them because they are "locally generated".
>>>>
>>>> To achieve the above, we must set skb->ignore_df = 1
>>>> so that ip6_fragment() can be made aware of this decision.
>>>
>>> Why the above applies only to IPv6? AFAICS the same could happen even
>>> for IPv4.
>>
>> For IPv4 we have the 'df=0' param that is passed to
>> udp_tunnel_xmit_skb(), which basically leads to the same result.
> 
> You need to include (an expanded/more describing version of) the above
> in the commit message.

Will do!
Thanks a lot.

Regards,

> 
> /P
> 

-- 
Antonio Quartulli
OpenVPN Inc.


