Return-Path: <netdev+bounces-112023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DB19349DC
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D17B2149E
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 08:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1203F79B9D;
	Thu, 18 Jul 2024 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YSYh0Sz6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892628DA0
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291249; cv=none; b=ctIBWZaJUQM3BxsYX6rqQdThYMLZc2PVVYDJ14QPN2XUS2Iu5tkAofgQxNGR++PMkElEqBeU91RxZ8L+OBLR07t5O25IzmcS84wYhnXMa42hZ4ovg2kqdEW90VURbBlrx+i3LWESRUckRF4gzdQyQok0/6PReMr59Q9pz1kcP3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291249; c=relaxed/simple;
	bh=ocdXjMwTjso3wtuqdzqiNqr/6Ds1MsWUwb8ULRu5mrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2UwdgvDlTqsztQd/aWz6ZblFNNuRuiSgb/kLlEz7wiVzYKLlfxq3upbLqIkp62QQ+OWY5ifEwxOryYeqI93jxOQzkwSLQLd9336hdJJO5mglPK3MscqiU50ggMCl5fCTtxhALRYpyh8y7IJqs1mwbzBkbTewq5kAPeNjhe/Fhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YSYh0Sz6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so550949a12.2
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721291244; x=1721896044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q/sxmchhzE6gPVMDLqdsEnZfg1BFhTahJjn25hezG/8=;
        b=YSYh0Sz6FgdL9kP5VjhcmJIwz2m/gufl+IeZYF/tTdlm0H7MQ7+AMNdB8cnm6qmwFs
         fSGzNCw7T0sC2T5uhN/NO6D0Q5zNKPrXS9pQ1G/HTUklvA2zF6L7NsJpU1qcFK3akiTA
         GL7KGZXexH5prTPfuNm7L9EuvVZealdbsSa3k1hDsNhZ05r9Tqh5qgYiXkWLhEBetBUA
         nAGcI+7rm4jWOnx709v66SPFGLY4dwfbAL82WVzEGFoEnhfGQ/ZB82QdouHyH1iHc4I4
         9Pnk78hvSG1EhGfyZl6rXDJWw5fKUqK6oW4M25JFpgJywwYDbFg9c+LppEcpQBSq6hj/
         YqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721291244; x=1721896044;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/sxmchhzE6gPVMDLqdsEnZfg1BFhTahJjn25hezG/8=;
        b=GDo7E0NZvSeL2PPfUiELkRcU/hpAypATyZ+23u39nF9CTM7u90mqeXS4ZFe1RfAbJ1
         mWCtRHrtvOGhp4tTx6/uv3vRBujeRRh1DglewrQlik8rCzrC9MrmYDIRWIyR4ZrtjqMS
         INwJNpP9LBn9EOAnC5XJYBC2qDWMX82RJiSsZlj8Ad8QhbbPSBaMo/hRyP9S4d7aVti2
         TeuDSk24ggD16tZYnbCfn0/sE4DcREszrW2UYkGg4DivWVFB7w1kxzB5CsRJ7Wivtu5N
         2g1C9Vuu0AFGzNEx1Bs33HoL+Xyz8VxA4G3Ry8y10SLUpnzFfyS78erhC94qY3t9EKLp
         rpHg==
X-Gm-Message-State: AOJu0Yw9OimyRjMRZMvsB/DKtISGMNZnnRYjbmzTIFZkmy/hNKnKjoTN
	al/ETBFPeNciMPaSNkVarJaDWmlAbhomSyu88dAB8h3w9XQAN4Lc/ZS3ZMa/xu4=
X-Google-Smtp-Source: AGHT+IEhcxdmZRTpUGIDAQc30wUB3hqqeCR/Pv4v3DErWs29v6MeBAxPxBCz7r7ty5mYFPU0PV3lPg==
X-Received: by 2002:a05:6402:518f:b0:59e:f6e7:5521 with SMTP id 4fb4d7f45d1cf-5a05bfaa3a6mr3265598a12.19.1721291244198;
        Thu, 18 Jul 2024 01:27:24 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:14d5:6a6d:7aec:1e83? ([2001:67c:2fbc:1:14d5:6a6d:7aec:1e83])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a2926sm8034499a12.59.2024.07.18.01.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 01:27:23 -0700 (PDT)
Message-ID: <21dd5e48-3880-497b-b14b-8f92c8114650@openvpn.net>
Date: Thu, 18 Jul 2024 10:29:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 21/25] ovpn: implement key add/del/swap via
 netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-22-antonio@openvpn.net> <Zpf8q731wtyXMpkd@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zpf8q731wtyXMpkd@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17/07/2024 19:17, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:39 +0200, Antonio Quartulli wrote:
>> This change introduces the netlink commands needed to add, delete and
>> swap keys for a specific peer.
>>
>> Userspace is expected to use these commands to create, destroy and
>> rotate session keys for a specific peer.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>>   Documentation/netlink/specs/ovpn.yaml |   2 +-
>>   drivers/net/ovpn/netlink-gen.c        |   2 +-
>>   drivers/net/ovpn/netlink.c            | 199 +++++++++++++++++++++++++-
>>   3 files changed, 198 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
>> index 68ed88d03732..21c89f0bdcbb 100644
>> --- a/Documentation/netlink/specs/ovpn.yaml
>> +++ b/Documentation/netlink/specs/ovpn.yaml
>> @@ -153,7 +153,7 @@ attribute-sets:
>>             decryption
>>           type: u32
>>           checks:
>> -          max: 2
>> +          max: 7
> 
> Looks like this got squashed into the wrong patch.

Indeed. Thanks for spotting it.

Cheers,

-- 
Antonio Quartulli
OpenVPN Inc.

