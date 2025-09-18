Return-Path: <netdev+bounces-224408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94561B845E1
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3F41733D5
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCB0283FEF;
	Thu, 18 Sep 2025 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKJzIC+3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB3BA42
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195214; cv=none; b=SQAxxa1zfMHV/Qr8lL+j7ca+MdfIiXl7JekWwp3iQ0qCoDwhGH1U5308kpFFIjuSuE3OZz9DziTn71npPu29CWIHF+/8ja5+sh07/4BJ7DgaI3u7e6BjtpCEJeE9mXl9/v27K71lEaFH5WXE0+Dd9SVqke1TVlsXu0gkjcB6av8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195214; c=relaxed/simple;
	bh=gLGGqTQeDcuJ69J2TBtccVCWJDWKQTcujXITNeonqoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEOJxbuy8ZZxBRSHEdidKfZ1+8y58bTAGu0zr3KHFW4IIq9jKDZCFj5XT5P8vUULK7rhXYAxv/B33j1GHoyNk0TEdfg4QktaQDLQ7NQCObfxWk31tChAkq7xdc50yH/EdPEizaGP66/6HPu7tzUsdKevHJR+xwMHZCPc7WpAvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKJzIC+3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758195211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hjZMJrXcmWGskBq2AfadxlFZaPb+oR06sD0dqG5szE=;
	b=ZKJzIC+3zYi2D1BeFFgRhZhGX6F/WVc8QCOpyYzG3IbRlFmMllOr24sYMdVnhSDQzXdqHO
	6t3cjlAxx9rsz4N7dmcZnSUotpf6EJIQHWfkjMrVBA/feMrt5D1yKmGlmsAZh5iBSpqrEW
	twTTHLvZqt6JRuTUZnEIGaY9EZKRAGs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-shpUcl6oPeOcVor7bRx3Ug-1; Thu, 18 Sep 2025 07:33:30 -0400
X-MC-Unique: shpUcl6oPeOcVor7bRx3Ug-1
X-Mimecast-MFC-AGG-ID: shpUcl6oPeOcVor7bRx3Ug_1758195209
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b9a856d58so5979725e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195209; x=1758800009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hjZMJrXcmWGskBq2AfadxlFZaPb+oR06sD0dqG5szE=;
        b=ObBJGPAXW2suXu6hoT5V2stH7IVTmlKmYzfEoqeSUD1I6mm06xJiEI+psphwKVkZgu
         OYxK3wzRJdTEsMmskyXJW2ykNJoZpR0ir5msP0O3zpTfX0uTTKeEPeaSGa5xa7GMwoy+
         lxA0B/P1/Fa0kkOxmBVCtJRllch2/vdTQlW6//ErrmSPgsCvTx8qMI/C6fDO1cg6HCFJ
         K3B+EVDE3OZlGTZKTEGvcKfYprmYczrNIY7AxRvMY6zGX90sWH15YoA+EdpwcOCPS2Qq
         JgZxZDcFB6/WqX0qWBzFgftoTuf+XVjg6IMRen1+RU3xOp1jrWujD5naKDi0IhFrz5Vh
         rhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4eEurjbxZ9Vj9IwYZeEv3WD3+Ypt4DRWB+wD0Hd+zE5BB0AR+Z374ZlsfzeITQrjWNsa1Uyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymcWLvk/+tKDVMfA/XoD6QJSIG9+QG7xT5fglRyyJrcRr/cpsu
	PZH7UjuaNuiDCEE7bbowZ67l3yzKzq55x27oQjI/4CQ8UTD317H3wEw8tNdpj13iWo61oxfT4eW
	4XBTb/VdTQMDYZ/Z4EHj8McJHIUP6ElgjPIMk6HrLMf94nv31T3NkSCyCcA==
X-Gm-Gg: ASbGncs4GvPSAK9YfkXSUZWR3Q9PnzxTGoQRrTpRJ+Bu7e8ucQYSaHIKKBHGWrohK2Q
	YHzW1vE1LvMtxvGstemL2ZsxD/xfgxvhQQToBIMGelwfgLD2lFx5HWyKqWW6MI/wFUJ2kGOZb6O
	+2i+KWJFPZE2fMOomaitSqYQqYrpksSYrsbiR/KnPeF/oLPJiBAgQ2/LRWcYsVn9YrjbqjL9eW7
	p6YhRGzkOHB8rlTT23Q8GrwNNY6vh/qi0uuqsEhY7RfqB9RLl+r0aj3oMxAYaJqCRJsZmDnO8FC
	/fCUHapG2bg34t6w+ARCUlMZfo03bWO+7Q8pV4SVhNMRthNbmBxvLxcUtNoyUB8GnJtLs/+o9LJ
	d0Q4YJ8Jtn+bh
X-Received: by 2002:a05:600c:3151:b0:45f:28cd:e033 with SMTP id 5b1f17b1804b1-46202bf7eebmr61329025e9.10.1758195209004;
        Thu, 18 Sep 2025 04:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG3EUVxK7MvIQjhIO836a63do3moI3MLTYIAwFE+Qud0gpQ9SL7Jmv2xJih97ckBggifHLVw==
X-Received: by 2002:a05:600c:3151:b0:45f:28cd:e033 with SMTP id 5b1f17b1804b1-46202bf7eebmr61328695e9.10.1758195208570;
        Thu, 18 Sep 2025 04:33:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a281f1sm37542095e9.17.2025.09.18.04.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 04:33:27 -0700 (PDT)
Message-ID: <71c34d95-3044-4301-a9f1-c5702a59b730@redhat.com>
Date: Thu, 18 Sep 2025 13:33:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 00/19] add basic PSP encryption for TCP
 connections
To: Eric Dumazet <edumazet@google.com>, patchwork-bot+netdevbpf@kernel.org
Cc: Daniel Zahka <daniel.zahka@gmail.com>, donald.hunter@gmail.com,
 kuba@kernel.org, davem@davemloft.net, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, borisp@nvidia.com, kuniyu@google.com, willemb@google.com,
 dsahern@kernel.org, ncardwell@google.com, phaddad@nvidia.com,
 raeds@nvidia.com, jianbol@nvidia.com, dtatulea@nvidia.com,
 rrameshbabu@nvidia.com, sdf@fomichev.me, toke@redhat.com,
 aleksander.lobakin@intel.com, kiran.kella@broadcom.com,
 jacob.e.keller@intel.com, netdev@vger.kernel.org
References: <20250917000954.859376-1-daniel.zahka@gmail.com>
 <175819262850.2365733.8295832390159298825.git-patchwork-notify@kernel.org>
 <CANn89i+ZdBDEV6TE=Nw5gn9ycTzWw4mZOpPuCswgwEsrgOyNnw@mail.gmail.com>
 <CANn89iJ5+y2PzyMzvRnEqTBW8NgBVDCHA6C7O7VB-pPwqZQS=g@mail.gmail.com>
 <CANn89i+Kqm_jXM4W=ygC08HstWnjnctJYWF+WK+z6f0ZoFLNMg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+Kqm_jXM4W=ygC08HstWnjnctJYWF+WK+z6f0ZoFLNMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/18/25 1:24 PM, Eric Dumazet wrote:
> On Thu, Sep 18, 2025 at 4:02 AM Eric Dumazet <edumazet@google.com> wrote:
>> On Thu, Sep 18, 2025 at 4:00 AM Eric Dumazet <edumazet@google.com> wrote:
>>> On Thu, Sep 18, 2025 at 3:50 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>>>
>>>> Hello:
>>>>
>>>> This series was applied to netdev/net-next.git (main)
>>>> by Paolo Abeni <pabeni@redhat.com>:
>>>>
>>>> On Tue, 16 Sep 2025 17:09:27 -0700 you wrote:
>>>>> This is v13 of the PSP RFC [1] posted by Jakub Kicinski one year
>>>>> ago. General developments since v1 include a fork of packetdrill [2]
>>>>> with support for PSP added, as well as some test cases, and an
>>>>> implementation of PSP key exchange and connection upgrade [3]
>>>>> integrated into the fbthrift RPC library. Both [2] and [3] have been
>>>>> tested on server platforms with PSP-capable CX7 NICs. Below is the
>>>>> cover letter from the original RFC:
>>>>>
>>>>> [...]
>>>>
>>>> Here is the summary with links:
>>>>   - [net-next,v13,01/19] psp: add documentation
>>>>     https://git.kernel.org/netdev/net-next/c/a9266275fd7b
>>>>   - [net-next,v13,02/19] psp: base PSP device support
>>>>     https://git.kernel.org/netdev/net-next/c/00c94ca2b99e
>>>>   - [net-next,v13,03/19] net: modify core data structures for PSP datapath support
>>>>     https://git.kernel.org/netdev/net-next/c/ed8a507b7483
>>>>   - [net-next,v13,04/19] tcp: add datapath logic for PSP with inline key exchange
>>>>     https://git.kernel.org/netdev/net-next/c/659a2899a57d
>>>>   - [net-next,v13,05/19] psp: add op for rotation of device key
>>>>     https://git.kernel.org/netdev/net-next/c/117f02a49b77
>>>>   - [net-next,v13,06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
>>>>     https://git.kernel.org/netdev/net-next/c/8c511c1df380
>>>>   - [net-next,v13,07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
>>>>     https://git.kernel.org/netdev/net-next/c/0917bb139eed
>>>>   - [net-next,v13,08/19] net: psp: add socket security association code
>>>>     https://git.kernel.org/netdev/net-next/c/6b46ca260e22
>>>>   - [net-next,v13,09/19] net: psp: update the TCP MSS to reflect PSP packet overhead
>>>>     https://git.kernel.org/netdev/net-next/c/e97269257fe4
>>>>   - [net-next,v13,10/19] psp: track generations of device key
>>>>     https://git.kernel.org/netdev/net-next/c/e78851058b35
>>>>   - [net-next,v13,11/19] net/mlx5e: Support PSP offload functionality
>>>>     https://git.kernel.org/netdev/net-next/c/89ee2d92f66c
>>>>   - [net-next,v13,12/19] net/mlx5e: Implement PSP operations .assoc_add and .assoc_del
>>>>     https://git.kernel.org/netdev/net-next/c/af2196f49480
>>>>   - [net-next,v13,13/19] psp: provide encapsulation helper for drivers
>>>>     https://git.kernel.org/netdev/net-next/c/fc724515741a
>>>>   - [net-next,v13,14/19] net/mlx5e: Implement PSP Tx data path
>>>>     https://git.kernel.org/netdev/net-next/c/e5a1861a298e
>>>>   - [net-next,v13,15/19] net/mlx5e: Add PSP steering in local NIC RX
>>>>     https://git.kernel.org/netdev/net-next/c/9536fbe10c9d
>>>>   - [net-next,v13,16/19] net/mlx5e: Configure PSP Rx flow steering rules
>>>>     https://git.kernel.org/netdev/net-next/c/2b6e450bfde7
>>>>   - [net-next,v13,17/19] psp: provide decapsulation and receive helper for drivers
>>>>     https://git.kernel.org/netdev/net-next/c/0eddb8023cee
>>>>   - [net-next,v13,18/19] net/mlx5e: Add Rx data path offload
>>>>     https://git.kernel.org/netdev/net-next/c/29d7f433fcec
>>>>   - [net-next,v13,19/19] net/mlx5e: Implement PSP key_rotate operation
>>>>     https://git.kernel.org/netdev/net-next/c/411d9d33c8a2
>>>>
>>>> You are awesome, thank you!
>>>> --
>>>> Deet-doot-dot, I am a bot.
>>>> https://korg.docs.kernel.org/patchwork/pwbot.html
>>>
>>> I just saw a name conflict on psp_dev_destroy(), not sure why it was
>>> not caught earlier.
>>>
>>> drivers/crypto/ccp/psp-dev.c:294:void psp_dev_destroy(struct sp_device *sp)
>>> drivers/crypto/ccp/sp-dev.c:210:                psp_dev_destroy(sp);
>>> drivers/crypto/ccp/sp-dev.h:175:void psp_dev_destroy(struct sp_device *sp);
>>> drivers/crypto/ccp/sp-dev.h:182:static inline void
>>> psp_dev_destroy(struct sp_device *sp) { }
>>> net/psp/psp.h:16:void psp_dev_destroy(struct psp_dev *psd);
>>> net/psp/psp.h:45:               psp_dev_destroy(psd);
>>> net/psp/psp_main.c:102:void psp_dev_destroy(struct psp_dev *psd)
>>> net/psp/psp_main.c:125: /* Wait until psp_dev_destroy() to call
>>> xa_erase() to prevent a
>>
>> Indeed :
>>
>> ld: net/psp/psp_main.o: in function `psp_dev_destroy':
>> git/net-next/net/psp/psp_main.c:103: multiple definition of
>> `psp_dev_destroy';
>> drivers/crypto/ccp/psp-dev.o:git/net-next/drivers/crypto/ccp/psp-dev.c:295:
>> first defined here
> 
> I will rename our psp_dev_destroy to psp_netdev_destroy.

Are you building with CRYPTO_DEV_SP_CCP=y? The CI build tests will
allmodconfig. I do the same locally before each push. I can not observe
the issue when ccp is build as module.

Thanks,

Paolo


