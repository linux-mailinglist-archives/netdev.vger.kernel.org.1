Return-Path: <netdev+bounces-175245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C8A64897
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 11:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F0D1884F7F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40431230BCD;
	Mon, 17 Mar 2025 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="g4l1QVmy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA16321A45E
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205657; cv=none; b=omAkBBVlNbeH7AT6ilMY3r69ejLVGCjT6gwizgGyVDec35SDifc+TDB8G55Hhm3TtBrh8Wx08bepzdy6kG8EsurGS8zuC46UeQq9ubqykFDwgr9kn1Xfqa9FjQVf4GXf/htalm86X6WcTW522W8r6g92FmqnnVu+3wbYFbSpjTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205657; c=relaxed/simple;
	bh=TtQ8IkLQe7b+zZk8N3mLfBrLSOius3YlLTFkfIH8qFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilIc5XCgEGp4RG+LeAXD4jhvi68tXzSTLurqZkS3BEAxz9vn/L6P2A5xbAgLFXbie7/Hdi40L5qpltpAo2ODbRmUlLqrAl8TUf6XBVhs+KiFl9W/Sntd0HTRl1rcWQj1M8jGlxWbugBV/8I+AolR49MSu01SceJKu3IfcI3b964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=g4l1QVmy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39127512371so2531993f8f.0
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 03:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742205653; x=1742810453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=svJwQfChR0jzLhTJA4RtfWruh6xe77kq6yeIs3iHID4=;
        b=g4l1QVmyAyZXqPVhjEs1VNVBpbM6PfBAprKpwuH9P1N244SbGBu9RYEH+Gd8/x0yX1
         YiHOjsw6QKU/TyUtW3/a3D6EN80D+waRRw6LR5DLNe6dF7uYtg3HerupYvBO2ExI0cH5
         HNU7OSi6U33rapC0ri0CFFQMve+w6uVd5/V34pUTvrHmTj1wvhZ+kXba+RzH3QjD8IIq
         V/pwsoLk2liSSA62UISai+erMBF1XTzgyc6bWF5sdGGc+475ZDyKtcraf/3qwBj/LAXP
         FLFQX1kldPwZAowd4URw/iGpG9Ltu6U3YoeNSB6X919yGAbYgMQk45+cA8d9ytdtyJ0S
         ehhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742205653; x=1742810453;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svJwQfChR0jzLhTJA4RtfWruh6xe77kq6yeIs3iHID4=;
        b=LYs3eaCFVvkwt7Ui5ksjlwVyIGsltgpn2V6dW/RFaC9qZq/rRgTiHznirjwSRhZzq9
         uz4SVoiOFrvuRO3Lq6RBWKPazW+YLNOi7DmbftOMY4docqP7bF5lR2XDmsA/+WOBqa/s
         sh6nrxvIJ9f+sBgs06SsZ4ZLvotnfiri0cNwXKGlu68ZOMYCHTmlfr5HVezMPXypRtlp
         ncPOXo5DQ6uogpQf1a0pqFjxj6WI+ae+Ow87AWaUjL4GurOkARE+LXW5zlEoK8MLWy9g
         1Z4JlzAgmwFic2AIbDgn2qml+howuWOaYvq8bSQIxFhRK9KQfzNbbRz6of2bW7KF+Xlx
         8MUw==
X-Forwarded-Encrypted: i=1; AJvYcCWbbdLoM2hMDpQYaOZPuhYTV2M3Wfw6ykVBiT2kFRGWWL4VHAte3nszUicb2UxPm5bCP7aKfxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+HGe4p/QAEAyaaeGskC3t1GhHTXoNfiDYYPQ43egvF8mlTzu
	q3EAqjVmRhDUjY9r8/WdGnhyziIVNBPo/N9Lwn6GnGielpj0smKtQAnfrDxLmCOt8Vm/QE183n4
	PcuJaTjCeURK2kMCK4MnEDkWPtVxFQIUokrLslbiNiYJ4vKM=
X-Gm-Gg: ASbGncvq7YMmdeNQb6evcU253OxuLUBEpRTXhqdieFLAJKdKpfBvxpB0DLTHWRmR9dR
	91dakS3JY24f0EKjdBdlPeQrEbch5hVxmjhhfgT0PO148yj8nHVjtNtYTloqFi0mmBtzRoY/ZAz
	83KTA5BPFILGp+jyRPnCsckDky3mSUaxTmHiUsnSEKBCuVArAEgSDSi9q72uK2eeacj9/DTYizO
	PKgQ+LQJklZdFaYjarWkAOgm3eeALtDEpJIgijW8vHz0bf1FGPO51DXUtVI7i4XOMB6Gu+c0KXy
	zg1LDEXN7LOUqEzsOHI0LHxeWpwkurpfUWIKtSHNw37XJyhGlv4ZaDD3F6m94FUq786r30GGyRd
	ubyzbW2o=
X-Google-Smtp-Source: AGHT+IFclieKK4uS5HmG9l6VJYMHBkpPnwG+xgqli7WoI//nWaxZF7goHLBSa7kPMH0H/8Wiqr3yAQ==
X-Received: by 2002:a5d:584a:0:b0:391:2192:ccd6 with SMTP id ffacd0b85a97d-3971ee44b62mr14430814f8f.39.1742205652886;
        Mon, 17 Mar 2025 03:00:52 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:23e9:a6ad:805e:ca75? ([2001:67c:2fbc:1:23e9:a6ad:805e:ca75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb953sm14633383f8f.93.2025.03.17.03.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:00:52 -0700 (PDT)
Message-ID: <0d8a8602-2db4-4c19-ab1c-51efef42cef6@openvpn.net>
Date: Mon, 17 Mar 2025 11:00:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v23 03/23] ovpn: add basic interface
 creation/destruction/management routines
To: Qingfang Deng <dqfext@gmail.com>
Cc: andrew+netdev@lunn.ch, donald.hunter@gmail.com, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, sd@queasysnail.net, shaw.leon@gmail.com,
 shuah@kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20250312-b4-ovpn-v23-3-76066bc0a30c@openvpn.net>
 <20250317060947.2368390-1-dqfext@gmail.com>
 <f4c9a29f-a5c6-464a-a659-c7ffeaf123c1@openvpn.net>
 <CALW65jZe3JQGNcWsZtqU-B4-V-JZ6ocninxvoqMGeusMaU7C=A@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CALW65jZe3JQGNcWsZtqU-B4-V-JZ6ocninxvoqMGeusMaU7C=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/03/2025 10:41, Qingfang Deng wrote:
> Hi Antonio,
> 
> On Mon, Mar 17, 2025 at 5:23 PM Antonio Quartulli <antonio@openvpn.net> wrote:
>>>> +static void ovpn_setup(struct net_device *dev)
>>>> +{
>>>> +    netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
>>>
>>> Do not advertise NETIF_F_HW_CSUM or NETIF_F_RXCSUM, as TX/RX checksum is
>>> not handled in hardware.
>>
>> The idea behind these flags was that the OpenVPN protocol will take care
>> of authenticating packets, thus substituting what the CSUM would do here.
>> For this I wanted to avoid the stack to spend time computing the CSUM in
>> software.
> 
> For the RX part (NETIF_F_RXCSUM), you might be correct, but in patch
> 08 you wrote:
>> /* we can't guarantee the packet wasn't corrupted before entering the
>> * VPN, therefore we give other layers a chance to check that
>> */
>> skb->ip_summed = CHECKSUM_NONE;

Right. This was the result after a lengthy discussion with Sabrina.
Despite authenticating what enters the tunnel, we indeed concluded it is 
better to let the stack verify that what entered was not corrupted.

> 
> So NETIF_F_RXCSUM has no effect.

Does it mean I can drop NETIF_F_RXCSUM and also the line

skb->ip_summed = CHECKSUM_NONE;

at the same time?

> 
> For the TX part (NETIF_F_HW_CSUM) however, I believe wireguard made
> the same mistake.
> Your code both contains the pattern:
> 
> if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) // ...
> 
> NETIF_F_HW_CSUM causes the upper layers to send packets with
> CHECKSUM_PARTIAL, assuming hardware offload will complete the
> checksum, but if skb_checksum_help(skb) is invoked, the checksum is
> still computed in software. This means there's no real benefit unless
> there's an actual hardware offload mechanism.

Got it.
Then as per your suggestion I can drop both NETIF_F_HW_CSUM and the 
if/call to skb_checksum_help().

Regards,

> 
> +Cc: zx2c4
> 
>>
>> I believe wireguard sets those flags for the same reason.
>>
>> Does it make sense to you?
>>
>>>
>>>> +                             NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
>>>> +                             NETIF_F_HIGHDMA;
>>
>>
>> Regards,
>>
>> --
>> Antonio Quartulli
>> OpenVPN Inc.
>>

-- 
Antonio Quartulli
OpenVPN Inc.


