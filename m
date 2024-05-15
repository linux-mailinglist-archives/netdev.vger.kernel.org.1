Return-Path: <netdev+bounces-96639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C758C6D56
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 22:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BC61F21EE3
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1E85A10B;
	Wed, 15 May 2024 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OrGoxhbT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21B13FD85
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805468; cv=none; b=kDyJEQTJpe80DO8tLBfnzIcN8j9leZb3aB84t99129c1Ul/PAdL42e+wNcDhOnVso/e4BiLvDEdaCIGITnZTQiTjpnTjHF77boWRZQsKKrMoRUph3uyECy4oIrw8P4LChGT+a9vMzn6KcDUcltMbgmu92k1n5AFfG7sebzs42Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805468; c=relaxed/simple;
	bh=uYv0PcycFVNENRlGtG8Mn3IuCpPOK8sY0f5EFRiVcOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJhggDgrKoqNl+LYMS7mtcqXDufb0hWrWk3RK0IxpKoNLoblJQk44Vmcs2fZuwCFQ+N6m89EeeMQ+RDDYCa3i63e8lftS1kQM8xfiDZZf+I16tkbjg7qQ8NHHEnrdIu4Azj+sOioRYnpsk0n+1pUVXBHcIZ4eoM181QbxDcd3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OrGoxhbT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5a88339780so235221666b.0
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715805464; x=1716410264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I36CeDo1iShE40rNg8OYoCl7rt1np8eMWFsHZ7qrPPQ=;
        b=OrGoxhbTArQDUrJNdjjRXmrFG9DtN971xA71bR7hdlJPUCtrh6UpFTB7ftDJtXIojA
         +0EB3YoZyjS1D9cnuTaGNlIWFnf0VCpUbSCGw+mfdrYBtSbtcXlhrx0GiuV5ecKlOVi3
         MWIoqDZTthRokf5Vv3Njeu1D3Vsh14Ql0TsApxR6UeTZwgxTPSQ+CLEGCm7FG7dpTuuK
         XtyWDkkq+4/bSICuDScCRzc1HgffbKXSv/MJKyYQLfTpG9ZiFTCJp11y3OZT6Zh2D9tA
         nkpg2VVHxLcm5ahvOikdTzmDd3a+u2DGNXkMncx145HM/AkIQ5pqhn8eQj3HKLJ5TbmF
         AtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715805464; x=1716410264;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I36CeDo1iShE40rNg8OYoCl7rt1np8eMWFsHZ7qrPPQ=;
        b=aZn2mMOETa11RI7rdNYH7GUg/CIpNF9NF969Ey4TK1B7WrS53EmyqxW7plrfGmsIO8
         ymu21jQvmMSZXUjL9LB1txy63Jv81DvJl8uC6+bNxm6EO3ZRJKSr/+Qx1joJbRIqhJeJ
         eYsemFbZpbyGNzL9FdKDi4jFQID3VljfFEeYwu8uftCv/jmb1OLCiEuh8u/AH6UIsjok
         n1szFLG7b2oFHxg7pqMJRExIZW+45K9waUcv1kXZ1krxuE/Fm5/2JLVIFuooKDbYH34l
         FRHiGoULZBCBYbAuW2SqRLr9K6qlUgULHlYs70e8FlTs0J68QjYPgNZc3FOOw9N1pyhS
         Dsew==
X-Gm-Message-State: AOJu0Yw0dcDme6mU2lvZ/ivxk4kEPkI1CsHyrAp00oVRwNemcCU21xjh
	l1kX1sb6U1TXOZGEr3X3yGD1p3jfJ904kkSokBS/gpbzEX9Yi0d79qVzptxSKRtZZy2ItnCdivw
	D
X-Google-Smtp-Source: AGHT+IG2lgEkgv1QjyD3DiB9g5Z4hD4apD2la+XMFCEKnRDB8yNxfyPdlroHaeWkdei8xFpikbYUfQ==
X-Received: by 2002:a17:907:bc9:b0:a5a:8b21:1be9 with SMTP id a640c23a62f3a-a5a8b211cfamr276671166b.41.1715805464340;
        Wed, 15 May 2024 13:37:44 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:1ebc:be00:b4c3:bcf2? ([2001:67c:2fbc:0:1ebc:be00:b4c3:bcf2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c70asm901929966b.56.2024.05.15.13.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 13:37:43 -0700 (PDT)
Message-ID: <faddc1f2-1637-4e72-a130-a6ccd4cc4449@openvpn.net>
Date: Wed, 15 May 2024 22:39:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 13/24] ovpn: implement TCP transport
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-14-antonio@openvpn.net> <ZkIosadLULByXFKc@hog>
 <73433bdf-763b-4023-8cb9-ffd9487744e0@openvpn.net> <ZkMnpy3_T8YO3eHD@hog>
 <2ddf759d-378f-475c-8fc1-30c6e83c2d14@openvpn.net> <ZkSMPeSSS4VZxHrf@hog>
 <6de315a7-8ef1-4b5d-8adc-fcfae26f6f88@openvpn.net> <ZkTM9b8oU8Rw31Qp@hog>
 <7a3909c1-818d-4701-b3b3-012976db7a34@openvpn.net> <ZkUchRbw3APzvlpe@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZkUchRbw3APzvlpe@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/05/2024 22:35, Sabrina Dubroca wrote:
> 2024-05-15, 21:44:44 +0200, Antonio Quartulli wrote:
>> On 15/05/2024 16:55, Sabrina Dubroca wrote:
>>> 2024-05-15, 14:54:49 +0200, Antonio Quartulli wrote:
>>>> On 15/05/2024 12:19, Sabrina Dubroca wrote:
>>>>> 2024-05-15, 00:11:28 +0200, Antonio Quartulli wrote:
>>>>>> On 14/05/2024 10:58, Sabrina Dubroca wrote:
>>>>>>>>> The UDP code differentiates "socket already owned by this interface"
>>>>>>>>> from "already taken by other user". That doesn't apply to TCP?
>>>>>>>>
>>>>>>>> This makes me wonder: how safe it is to interpret the user data as an object
>>>>>>>> of type ovpn_socket?
>>>>>>>>
>>>>>>>> When we find the user data already assigned, we don't know what was really
>>>>>>>> stored in there, right?
>>>>>>>> Technically this socket could have gone through another module which
>>>>>>>> assigned its own state.
>>>>>>>>
>>>>>>>> Therefore I think that what UDP does [ dereferencing ((struct ovpn_socket
>>>>>>>> *)user_data)->ovpn ] is probably not safe. Would you agree?
>>>>>>>
>>>>>>> Hmmm, yeah, I think you're right. If you checked encap_type ==
>>>>>>> UDP_ENCAP_OVPNINUDP before (sk_prot for TCP), then you'd know it's
>>>>>>> really your data. Basically call ovpn_from_udp_sock during attach if
>>>>>>> you want to check something beyond EBUSY.
>>>>>>
>>>>>> right. Maybe we can leave with simply reporting EBUSY and be done with it,
>>>>>> without adding extra checks and what not.
>>>>>
>>>>> I don't know. What was the reason for the EALREADY handling in udp.c
>>>>> and the corresponding refcount increase in ovpn_socket_new?
>>>>
>>>> it's just me that likes to be verbose when doing error reporting.
>>>
>>> With the "already owned by this interface" message? Sure, I get that.
>>>
>>>> But eventually the exact error is ignored and we release the reference. From
>>>> netlink.c:
>>>>
>>>> 342                 peer->sock = ovpn_socket_new(sock, peer);
>>>> 343                 if (IS_ERR(peer->sock)) {
>>>> 344                         sockfd_put(sock);
>>>> 345                         peer->sock = NULL;
>>>> 346                         ret = -ENOTSOCK;
>>>>
>>>> so no added value in distinguishing the two cases.
>>>
>>> But ovpn_socket_new currently turns EALREADY into a valid result, so
>>> we won't go through the error hanadling here. That's the part I'm
>>> unclear about.
>>
>> you're right. I had forgotten a little but important detail.
>>
>> With UDP OpenVPN creates one socket and uses it for all peers.
>> With TCP we forcefully need one socket per client.
>>
>> Consequently, when a UDP socket is found to be used by our own instance,  we
>> can happily increase the refcounter and use it as if it was free (we are
>> just attaching it to yet another peer).
>>
>> In TCP this is not possible, so the socket must be unused, otherwise we
>> can't attach it.
>>
>> I hope it makes sense.
> 
> Yes, thanks. This behavior should be documented (for example, by
> putting exactly what you just wrote in a comment above
> ovpn_socket_new).

absolutely, will do.

> 
> So for TCP you just need the existing check and EBUSY return. For UDP,
> you need the EALREADY check, but with an extra encap_type test before
> looking at the contents of the sk_user_data.

ACK

-- 
Antonio Quartulli
OpenVPN Inc.

