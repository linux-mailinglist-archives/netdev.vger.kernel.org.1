Return-Path: <netdev+bounces-111877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDFE933DB5
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 15:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA611C228EB
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E621802CD;
	Wed, 17 Jul 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BpckdrJz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B4566A
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223378; cv=none; b=I6p4ZPBp4hJXRi1eFUP9YR/H1g/dpEjm7Khe5jIvtudxcREBrYVdr7fzP0QVl+ifrpsFChB97tG+1jZdetdMzXDgHwnUyo5rAxrz46AO4CT6FxplC4ZfaohVm6NrZ7LknmAInkTBDM3SIQl/zEwQ59D66Qb/azskd8TzELLw1WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223378; c=relaxed/simple;
	bh=6z+L87ECItbdulPZR7hlLL/92xtqW3MUKrRECUb+sNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMxoNH82UtG8/CSQRbMWTGxzix9a+Txs9FtTazL0SeErKgirgc2HIo6iaVjArh2N6NlhLmcaXgam7rVmsBZeKOHZ/5vMRbbuHlxsz3vgXmnVO8uqp3m2SdiRF01Ez060DLcPCXm4cAblqrtdKgTx2FKbwTdDiodsxF49//wKch4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BpckdrJz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a79fe8e6282so74376066b.2
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 06:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721223374; x=1721828174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WDqdjT0EHVkEkUlJGTjVxgCuKhH4vR4gWOW3NuxX2Gg=;
        b=BpckdrJz0RSKm3t4/ttcTJncMpOHTZmCJx4mE6LBLx97hcGoAzO1ihK/ymPOjM/nCN
         CWbwzBxbYUlvVOrK/NFBvEvmzMpynX8VLEHUigEYR8RIR3QnGf1LQQXmU/GmSW5zcYbH
         gINVc7fmcPXNB8xtKq8nis9ugdXL7V/POxsVFL75CeF9tqxNHU1xVf1ZhVhEF47y6lBR
         BP2BH5TXv8QXwB2bm1QwctkYOGgCX0oXCF/WHmqIttmJKKSxDKbeXKh36SWrf2HRgyue
         JVIFjEyYAiK1GqaN8+RHyghVMRe6/lV3e7mVx7buaItV4o0VHQniTohGeS6sqQ01mgYi
         C78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721223374; x=1721828174;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDqdjT0EHVkEkUlJGTjVxgCuKhH4vR4gWOW3NuxX2Gg=;
        b=EMVth26MY33/uxy6googTffOnu7sjVDn84ZBun2DKxsBPhpBNgU5g6SiDnWde2QlFu
         d7k4dFI2sOODXnP/BSZQORJhvAL36oc+zH3eEAV8+KhA2TaPJRhg3QA/SaKPwcZsdv3B
         ZRX/cqdg9Vuj12IX3KwlM4yKii5ehlJnfKUbO3IlROp7DS/91YV4BWJqbLDvfJElhjQJ
         OZ/Ofeoc+PWqQvJO1Gu6QO6DNgpIpIb3j+DZ4Ghz6FUDlf+0tm/t4HRl5ieWmo3LJ5We
         tDsjEX6ES8E0gnATe0O9+k3uUTzvpEok9tqTvdUbNouOIAEmHapYqdCmqUiWV8TJ4XsF
         mznw==
X-Gm-Message-State: AOJu0YzCmpSI/sGfmi496KIU4anNMsrIdWiMdrXPihVmBC3sqY3eWzEZ
	XFzLfmIonFkhsHaIyWCYlioxTKEZU1KC8cnDyQKMWnD5SjP2cSWCIjIftmWDjxo=
X-Google-Smtp-Source: AGHT+IGRHGVPf64zx6kp6zHgQ8qwVm+m6dHYiW3W+tyymU2xXlOh1dBeSyuaep3fepUKPBKQuHlg0g==
X-Received: by 2002:a17:906:b0c9:b0:a77:cdaa:88aa with SMTP id a640c23a62f3a-a7a011c0807mr123929766b.4.1721223374207;
        Wed, 17 Jul 2024 06:36:14 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:4c30:cffb:9097:30fc? ([2001:67c:2fbc:1:4c30:cffb:9097:30fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820fb5sm450355966b.212.2024.07.17.06.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 06:36:13 -0700 (PDT)
Message-ID: <5d8ecc8e-bf89-4c62-acda-0ce280d19849@openvpn.net>
Date: Wed, 17 Jul 2024 15:38:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 22/25] ovpn: kill key and notify userspace in
 case of IV exhaustion
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-23-antonio@openvpn.net> <ZpegDb1F4-uBMwpe@hog>
 <b631abf1-b390-45fb-b463-ac49fec0fdfe@openvpn.net> <ZpfGgHOqgSc9vOnx@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZpfGgHOqgSc9vOnx@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2024 15:26, Sabrina Dubroca wrote:
> 2024-07-17, 13:03:11 +0200, Antonio Quartulli wrote:
>> On 17/07/2024 12:42, Sabrina Dubroca wrote:
>>> I don't see any way for userspace to know the current IV state (no
>>> notification for when the packetid gets past some threshold, and
>>> pid_xmit isn't getting dumped via netlink), so no chance for userspace
>>> to swap keys early and avoid running out of IVs. And then, since we
>>> don't have a usable primary key anymore, we will have to drop packets
>>> until userspace tells the kernel to swap the keys (or possibly install
>>> a secondary).
>>>
>>> Am I missing something in the kernel/userspace interaction?
>>
>> There are two events triggering userspace to generate a new key:
>> 1) time based
>> 2) packet count based
>>
>> 1) is easy: after X seconds/minutes generate a new key and send it to the
>> kernel. It's obviously based on guestimate and normally our default works
>> well.
>>
>> 2) after X packets/bytes generate a new key. Here userspace keeps track of
>> the amount of traffic by periodically polling GET_PEER and fetching the
>> VPN/LINK stats.
> 
> Oh right, that's what I was missing. TX packet count should be
> equivalent to packetid. Thanks.

np!

> 
> 
>> A future improvement could be to have ovpn proactively notifying userspace
>> after reaching a certain threshold, but for now this mechanism does not
>> exist.
> 
> If it's not there from the start, you won't be able to rely on it
> (because the userspace client may run on a kernel that does not
> provide the notification), so you would still have to fetch the stats,
> unless you have a way to poll for the threshold notification feature
> being present.

You're right. Then scratch that because userspace is not ready for this.

> 
> 
>> I hope it helps.
> 
> Yup, thanks. Can you add this explanation to the commit message for
> this patch in the next version? Documenting a bit the expectations of
> the kernel/userspace interactions would be helpful, also for the
> sequencing of key installation/key swap operations. I'm guessing it
> goes something like this:

Sure, will document how this works.

> 
>   1. client sets up a primary key (key#1) and uses it
>   2. at some point, it sets up a secondary key (key#2)
>   3. later, keys are swapped (key#2 is now primary)
>   4. after some more time, the secondary (key#1) is removed and a new
>      secondary (key#3) is installed
>   [steps 3 and 4 keep repeating]
> 
> And from reading patch 21, both the TX and RX key seem to be changed
> together (swap and delete operate on the whole keyslot, and set
> requires both the ENCRYPT_DIR and DECRYPT_DIR attributes).

You are correct. Encryption and decryption keys are derived from the 
same key material that is exchanged/generated upon each "renegotiation".

> 
> A rough description of the overall life of a client (opening sockets
> and setting up the ovpn device/peers) could also be useful alongside
> the code.
> 

ok, will add it too!

Thanks!


-- 
Antonio Quartulli
OpenVPN Inc.

