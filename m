Return-Path: <netdev+bounces-108037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D799891DA5C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD35B23213
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FD586AEE;
	Mon,  1 Jul 2024 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KUVov2oG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7BC83A14
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823619; cv=none; b=Qo6pifmaibkqOAOFsUqTICXU6j5rB1qrf10AzUR+8ZNGxfRlQz1X0ClMqd6XQU5PqtFfrI2iOhaRCgbmosiSUwaXQVH2+RAA59cCSiiR3fAVwZlC1LJGiXx++Ij3mu+r/11FtEE9//6y90V1cUOteIiCklC/fMFnPHseaAtWjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823619; c=relaxed/simple;
	bh=BmInI5sCeD2pMGcRdjAdMyDdRz9y2p45mNqSolHHZmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TReBqMuN5H93d8RdgA5ml9nKF/FRfUCp8FGenFbWsSLIB+6fV415mG+ABKKr2iej9fsA3h7Sssub2SJTftqTEeiMkbxIj3uY4q73X+wJo1Q6fI95zzGkCnRWNHSsIe0c7h7fQ5MfZ63YaexhSjsomphSeAp5jczmMkfeQiU62A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KUVov2oG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-424acfff613so24739685e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 01:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719823615; x=1720428415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cAIQbhphvcu0FdMyjmmLDL6E1k2VMNmeoru3CRnq76w=;
        b=KUVov2oGgeer7IWf2KPFlos+SEw1JjSoeXTIFV3LnOhoIObA6ZeEMI+zyRIjJxE3mm
         opL+GvmF5Ct2hAEs8GZsVnhxyEOjMiqcNLH/OSZHVIGbYnIMVAYjwjJLqGGqOErxJjF9
         k8hyGoHUBhF6rh4P4Ld+d0I7ZE/g4IyF+iZ18tAinpty50ef+LqlBAF47qxwwocifuNI
         nA/bQVPKx3nEpXX8etgle1ls/t9Sc+HTDIViJWpV40JohdXNK1TXvoccmLZWTr/kWB22
         7QFOecjI4Ch8ZcUvkvXKJVq2+e832XJtHPZ/AS7FgRNegf1P3LQSx1/Esp8Vu2Un3Io7
         NVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823615; x=1720428415;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAIQbhphvcu0FdMyjmmLDL6E1k2VMNmeoru3CRnq76w=;
        b=pg2s9TaM86HtVFqxgA/ccfIylJfEefs72G9GDatQ97yJBIHal+NB82pUw8y/RGXiH9
         QUqa735OYRnJ3zgs7N0mx4HgeHEoQYInuCyxMRXgfpRWjVix7IMvhx6KvZ/n8aZHfxCh
         rfsISkeZITs7qxiBvR03evV7ma9Dn68kOxUjdnKiy5SNG46vq0z5/NsZxSQAmmT4PENx
         Q58mSzulTuTv/wwDZHZuP6IEWzbm8APe6/j4oV9kFnjGIlbnIBrWLpv38WqllwEHGci5
         vL7IjsoyDr02FrL20bk4OsCoQR5hfyNaub1YNyxyzgfE82zJYqBSSimmaHA4ytxXa4XW
         yfQQ==
X-Gm-Message-State: AOJu0Yz/+xdgGSkxs/SS89mrWLtsc36s9sm72PUjXsdmCGwhJjx9VRLT
	YgYkGOspxO72Ww6KVoZ7IEUNoGV1iH8H4qBsSC6aMh65xz1zHTKnNBL4IhmxBdI=
X-Google-Smtp-Source: AGHT+IFscuZc6Ewr5IMCQGyzY2aXBxSqG7nIcYSHUBy7hEdlmoVjy+VC52Yol5ncFeAGxLxZOTbGtg==
X-Received: by 2002:a05:600c:3b09:b0:424:a4a2:9478 with SMTP id 5b1f17b1804b1-4257a020402mr40651375e9.25.1719823614901;
        Mon, 01 Jul 2024 01:46:54 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:78fc:5b06:375f:67a4? ([2001:67c:2fbc:0:78fc:5b06:375f:67a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd60dsm9437193f8f.2.2024.07.01.01.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 01:46:54 -0700 (PDT)
Message-ID: <75d0b4a0-6764-465f-8d48-c81eb37375f5@openvpn.net>
Date: Mon, 1 Jul 2024 10:48:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 05/25] ovpn: add basic interface
 creation/destruction/management routines
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-6-antonio@openvpn.net> <Zn81FBrUNUMC6VvM@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zn81FBrUNUMC6VvM@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 29/06/2024 00:11, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:23 +0200, Antonio Quartulli wrote:
>> +static void ovpn_setup(struct net_device *dev)
>> +{
>> +	/* compute the overhead considering AEAD encryption */
>> +	const int overhead = sizeof(u32) + NONCE_WIRE_SIZE + 16 +
> 
> Is that 16 equal to OVPN_MAX_PADDING? Or some other constant that
> would help figure out the details of that overhead?

That's the size of the auth tag.

Sadly the explanation of the OpenVPN header (with AEAD encryption) is 
only described in a comment inside ovpn_aead_encrypt().

Here the comment is much "slimmer"..

In crypto_aead.c it is defined as AUTH_TAG_SIZE.
Maybe I could export that define and reuse it here.

Same goes for the "4" in ovpn_aead_encap_overhead(), which is actually 
NONCE_WIRE_SIZE.

> 
>> +			     sizeof(struct udphdr) +
>> +			     max(sizeof(struct ipv6hdr), sizeof(struct iphdr));
>> +
>> +	netdev_features_t feat = NETIF_F_SG | NETIF_F_LLTX |
> [...]
>> +	dev->features |= feat;
>> +	dev->hw_features |= feat;
> 
> I'm not sure we want NETIF_F_LLTX to be part of hw_features, I think
> it's more of a property of the device than something we want to let
> users toggle. AFAICT no other virtual driver does that.

I agree. It should *not* be part of hw_features.
I'll remove it from 'feat' and assign it only to '->features'.


Regards,


-- 
Antonio Quartulli
OpenVPN Inc.

