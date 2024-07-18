Return-Path: <netdev+bounces-112095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2F9934EF3
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 16:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131E71F2103A
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E8384DF5;
	Thu, 18 Jul 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XWX+M6ba"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF280BFC
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311988; cv=none; b=skf905v3cP5r4kVHUjiZJXMtnIKV5zZUGjHeNJkrlg1/2L5Zxl5/0vVQ+9UQkWDhf4nGYY6x8TZuCp+J0erNLb+JIXGUePB857z6MXLliwUgN/4T8Ul60UnuxoggGq44cW8dAl16Lhr/LtQnWtENH8RBZK86EcN+WpomIT4kbtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311988; c=relaxed/simple;
	bh=kda55T5p6sR1XrXr0l9y8AqtLlGfdhZx4P0bc+DHbso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKsSBDUTj9YuiIuP3MqXRG5crj4Dw0Wip/hzjDz1C3NmSSDyPdyGAKA51afzyuBOVvPX2mlQdXCAZ2Pzy7kXEnFbnc5iSnZ3ngK0nnJLh2vNBYFVVv0KsyoAs946XZMfHuTABnosPUSEToH2PsEa1PBrkfECJwCUooK0UKVCdcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XWX+M6ba; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee920b0781so11142781fa.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721311984; x=1721916784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ac9q+rKHkywIBVov0WJ1nP1+L4Xb/lrh3Shrgq2vRC4=;
        b=XWX+M6baJbvivPQhIfhjyHF3KwLeupgTzVoeWLS9MSC8lY+6Z5vL03ifSsCmxPbU1i
         Gco3mKfyXmltA/2HyrAEWjnsuErg9y+kMRXgL/AgvT5EvFKniJKBtotamygfqoY6QvWF
         i1PsKl6SxiNTUKSceCjJIVoyQClVB+PPOTl8wpoRU5iUwJpsOXEjSWV1nOKjPQBSUZV5
         SjZIM01dxA6/8qop789to81QL4g4ATqxZnfZddC/TtS2g2WCDRNnLJ78o7EuXyYUByEU
         hCB0a4S70XUiXyozRsRHecJtWgA1MIBediYMh6ySBJJ9p2hUBi701y84MfVQWJfmRLS9
         TjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721311984; x=1721916784;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac9q+rKHkywIBVov0WJ1nP1+L4Xb/lrh3Shrgq2vRC4=;
        b=cnaACWVtnt/xG6a8LshJEos+062NWglO9gfGsUEX+N3oGPMYnz/6eiB5HW1irDA8OV
         MkRFMch0uRcrLUT5SjStk1NIPsnlzB0Tabizvoo+npzVx3irgIrBnzoegdyUQhGm3O56
         EFjTQR8jemYnSCQAoVGOVogeZ0jZ5RU9EbLmcpJFyAIe+gY5pYVe1YGEBiVuOhOiiOG6
         zohFtXrOLpD1svkYs1llOKW0dVnM2IUlFXxG0fB3k3oDD1sI8DAPsajuzuVEmFo0+Nad
         yM2HfuiC4HnQr+cT/ISnwBK2FUG6I/BL8Q9qa5rtcaas+af5WInWE32hwud4/MFEu0w7
         /Zxg==
X-Gm-Message-State: AOJu0YyfLuPMuRDOEwuYmJ6IzgwvKKSHxig1eAbhIByOTjjSP1rf5mXY
	lND3sGXaMp8mK6aI4nglyq4pYCKtBDwxPQhNMGhmy2qtUiaYnICcGAZ/wVeVQoY=
X-Google-Smtp-Source: AGHT+IHpqr82NTgTIMtXhXgDkksVPLWU5Lyh7uwke82doFK4LtW/PJrayeBLmZUCFAFxeOjxgvIRdg==
X-Received: by 2002:a05:6512:a8d:b0:52c:e192:5f5f with SMTP id 2adb3069b0e04-52ee53df0bfmr3763569e87.19.1721311984455;
        Thu, 18 Jul 2024 07:13:04 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:14d5:6a6d:7aec:1e83? ([2001:67c:2fbc:1:14d5:6a6d:7aec:1e83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820ebesm563844366b.197.2024.07.18.07.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 07:13:04 -0700 (PDT)
Message-ID: <dd606a17-5fe1-4c04-b07c-e67b3c2e8223@openvpn.net>
Date: Thu, 18 Jul 2024 16:15:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 10/24] ovpn: implement basic RX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-11-antonio@openvpn.net> <Zj4k9g1hV1eHQ4Ox@hog>
 <eb9558b3-cd7e-4da6-a496-adca6132a601@openvpn.net> <Zpjyg-nO42rA3W_0@hog>
 <10c01ca1-c79a-41ab-b99b-deab81adb552@openvpn.net> <ZpkUfMtdrsXc-p6k@hog>
 <80351026-0d15-460a-8002-4b24b893fefa@openvpn.net> <ZpkbWoW4FlzDDuyp@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZpkbWoW4FlzDDuyp@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/07/2024 15:40, Sabrina Dubroca wrote:
> 2024-07-18, 15:27:42 +0200, Antonio Quartulli wrote:
>> On 18/07/2024 15:11, Sabrina Dubroca wrote:
>>>> basically the idea is: with our encapsulation we can guarantee that what
>>>> entered the tunnel is also exiting the tunnel, without corruption.
>>>> Therefore we claim that checksums are all correct.
>>>
>>> Can you be sure that they were correct when they went into the tunnel?
>>> If not, I think you have to set CHECKSUM_NONE.
>>
>> I can't be sure, because on the sender side we don't validate checksums
>> before encapsulation.
>>
>> If we assume that outgoing packets are always well formed and they can only
>> be damaged while traveling on the link, then the current code should be ok.
>>
>> If we cannot make this assumption, then we need the receiver to verify all
>> checksums before moving forward (which is what you are suggesting).
>>
>> Is it truly possible for the kernel to hand ovpn a packet with invalid
>> checksums on the TX path?
> 
> The networking stack shouldn't generate packets with broken checksums,
> but it could happen. On a VPN server that's giving access to an
> internal network, I think the packet could get corrupted on the
> internal network and may be pushed without verification into the
> tunnel.

Right.

In these cases the receiver would have a chance to detect and discard 
this packet.

With the current ovpn code, instead, we are saying "everything is good, 
don't check" and the packet would be delivered to the upper layer.

Ok, I think it makes sense to switch to CHECKSUM_NONE.

(I wonder what the wireguard guys think about it :-))

> 
> It's also possible to inject them with packet sockets for
> testing. Using scapy to send packets over your ovpn device should
> allow you to do that.

Thanks for the hint!

> 

-- 
Antonio Quartulli
OpenVPN Inc.

