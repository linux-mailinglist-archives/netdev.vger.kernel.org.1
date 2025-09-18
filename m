Return-Path: <netdev+bounces-224412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E182FB84602
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AA5526993
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063672F7AC4;
	Thu, 18 Sep 2025 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSJDsMk1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A25302CD1
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195362; cv=none; b=tnvAnoBWNSMpcPt9CD415I5f8z63fxE9IIfFYSWRcXjYTX5Jo9JCc8sebXSyUUDkSr9v5WConNwAAF3TeIgOFLkFaAw8OMSHueu06CJxFHcbx79LWXpkdtGcL32bqmgT0Ldt6+EhyjhcxcYWdkQjCH2sNKpSM/DPqc37ORfeL1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195362; c=relaxed/simple;
	bh=QGB4qJNbb3sc9X1JcomS4Nu+c8fYZ9vYlFSfRdExM5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFZ2gH1yMLsW3/gQ0i+jj5xvTCaZxA45IC+30BLTlD1qPWcTTutMu5N+Y9r1mySre98DFUVFfMmiYL3TZv9sjyMDD2/Ou6qaRUFE1YrMPhPwULgmyW+7vT2XZLscW4HodWAIxfkEE70Ks2H2ANPI/Qe6Ns19pJoA/fbLu6Ai8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSJDsMk1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758195360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUVg5Hb55jT7v1V5PQ9TQpNIx4/KVfkGuTo/Oo7W1Dg=;
	b=fSJDsMk11p65vH3Blef6iHxHPfc5spdogjc4Z9NMxgWlGygsbtgjaKE6C/zc1qFiWAtMEv
	qLz2/z2rRRWtEtiiXScf/ooFFLb1hUusjNXL+wAJS1AyN6p0OT5M66oY9lDPfYZe3sIi+H
	3vGtzQTVqY7zg/Sfp5JMDpATsnVSPWc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-t_Qe3GebPoGF5mqOR1GQEg-1; Thu, 18 Sep 2025 07:35:58 -0400
X-MC-Unique: t_Qe3GebPoGF5mqOR1GQEg-1
X-Mimecast-MFC-AGG-ID: t_Qe3GebPoGF5mqOR1GQEg_1758195358
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45df9e11fc6so5956085e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195357; x=1758800157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUVg5Hb55jT7v1V5PQ9TQpNIx4/KVfkGuTo/Oo7W1Dg=;
        b=WgaCeWyjR2nBE0SEbpzfEQqH3gBdBiyXVENmSkxnWey7OWjAcnptlnyCUL8pZGJtwe
         LLtqxy7BUtWg2toSlIU1FbMCn5iCq4DU4dIr7adrWjSUOqV1OW7FT1bhmz2PoweaIlXz
         ew5QTUFJLTaDq1Q9q4O1EF1e9RlbPeOIsM1/r9Mrbbh/f+qS+odq+w4CMA/Yd2rIx5HQ
         +xStoEJGFQ1qnsl9Dmo+sjPyID2LBNq/2L++kAPNBdj+BnQDG2A1K3nuIMAEKk40VVCs
         u+LWcMu/Ovr6mfoZx+eu7+7JOrCQBzg0/vzLZkxnZDcLUwvZmvlmnOvf6uH5Ywo6gKOj
         Jc6w==
X-Forwarded-Encrypted: i=1; AJvYcCXIZ5+l2cvzgTJR4/1LzjnZhQ4blaNMbjmXab4z4htUWmgcfvNhFwjAGY/Vhwt0zEaUgfK/dpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/TWZvGfYliCg50V09CohHp9mYzsRrkQWIyEYTLW5uezeC/T9
	frTGN1nZYt9j28AjSerQbzgJYbe8V4ZTVwvEOdCaEpOzJEBFbD3tlqgsYIVbFPo2KXINPH/21Dt
	4O89GRxmNrC9MUzUjXYc0iPKgAfIMuKOAWurx3GmQ1QEy5qtvs8gCdokqGA==
X-Gm-Gg: ASbGncv+d4oTJu4knTn5oAkTZbpDa6XFMMFhmKhCvA2kHdemUJrxNFvMGx/IJf28V5E
	vHwyr/r5bCNo2vL/vCmXqmHzHyzzYQxLYOiKjnYBpfY7lTDm3/4gjZbAOzDQQuYTVXsVe4TDQ+K
	Ppv/7CnF3KAv8o2UtzVOqULNYba7JJ8UWCbKiIXo5illRYJX9FXWG8r/qd15mHl+1/8g5qcZNZd
	RdR3xwLE+V39g1SARq4IApaabw/a6N1zVoV6URlYkDSDwO5WET22hDOydLIWiahIob2d42gPXe6
	AmNwgZbKgbXtx+uMpdzYJL0AcfqiLA+1bd2WxpRscQD2aeCcEekHzSExJG0CE7FgRg6TBJLp/FT
	aisasH5s8PsLK
X-Received: by 2002:a05:600c:4f89:b0:45f:2922:2aef with SMTP id 5b1f17b1804b1-4620683f81dmr50651375e9.28.1758195357521;
        Thu, 18 Sep 2025 04:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaRt8tjCizsuJsnB096RjCrctNaSFIN63A8wF9LILngoIcW27EeF+t2NYaVJaiB7YLzWVZJw==
X-Received: by 2002:a05:600c:4f89:b0:45f:2922:2aef with SMTP id 5b1f17b1804b1-4620683f81dmr50650995e9.28.1758195357028;
        Thu, 18 Sep 2025 04:35:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7284sm3299088f8f.33.2025.09.18.04.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 04:35:56 -0700 (PDT)
Message-ID: <e05f2321-9246-466f-a577-6d0b83beaa89@redhat.com>
Date: Thu, 18 Sep 2025 13:35:54 +0200
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
 <CANn89iLPXwJgiQBFz_w6_UsA5XoyNZ9h_9zhAdKqO8MPMCxe_g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLPXwJgiQBFz_w6_UsA5XoyNZ9h_9zhAdKqO8MPMCxe_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/18/25 1:27 PM, Eric Dumazet wrote:
> On Thu, Sep 18, 2025 at 4:24 AM Eric Dumazet <edumazet@google.com> wrote:
>> On Thu, Sep 18, 2025 at 4:02 AM Eric Dumazet <edumazet@google.com> wrote:
>>> On Thu, Sep 18, 2025 at 4:00 AM Eric Dumazet <edumazet@google.com> wrote:
>>>> On Thu, Sep 18, 2025 at 3:50 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>>>>
>>>>> Hello:
>>>>>
>>>>> This series was applied to netdev/net-next.git (main)
>>>>> by Paolo Abeni <pabeni@redhat.com>:
>>>>>
>>>>> On Tue, 16 Sep 2025 17:09:27 -0700 you wrote:
>>>>>> This is v13 of the PSP RFC [1] posted by Jakub Kicinski one year
>>>>>> ago. General developments since v1 include a fork of packetdrill [2]
>>>>>> with support for PSP added, as well as some test cases, and an
>>>>>> implementation of PSP key exchange and connection upgrade [3]
>>>>>> integrated into the fbthrift RPC library. Both [2] and [3] have been
>>>>>> tested on server platforms with PSP-capable CX7 NICs. Below is the
>>>>>> cover letter from the original RFC:
>>>>>>
>>>>>> [...]
>>>>>
>>>>> Here is the summary with links:
>>>>>   - [net-next,v13,01/19] psp: add documentation
>>>>>     https://git.kernel.org/netdev/net-next/c/a9266275fd7b
>>>>>   - [net-next,v13,02/19] psp: base PSP device support
>>>>>     https://git.kernel.org/netdev/net-next/c/00c94ca2b99e
>>>>>   - [net-next,v13,03/19] net: modify core data structures for PSP datapath support
>>>>>     https://git.kernel.org/netdev/net-next/c/ed8a507b7483
>>>>>   - [net-next,v13,04/19] tcp: add datapath logic for PSP with inline key exchange
>>>>>     https://git.kernel.org/netdev/net-next/c/659a2899a57d
>>>>>   - [net-next,v13,05/19] psp: add op for rotation of device key
>>>>>     https://git.kernel.org/netdev/net-next/c/117f02a49b77
>>>>>   - [net-next,v13,06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
>>>>>     https://git.kernel.org/netdev/net-next/c/8c511c1df380
>>>>>   - [net-next,v13,07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
>>>>>     https://git.kernel.org/netdev/net-next/c/0917bb139eed
>>>>>   - [net-next,v13,08/19] net: psp: add socket security association code
>>>>>     https://git.kernel.org/netdev/net-next/c/6b46ca260e22
>>>>>   - [net-next,v13,09/19] net: psp: update the TCP MSS to reflect PSP packet overhead
>>>>>     https://git.kernel.org/netdev/net-next/c/e97269257fe4
>>>>>   - [net-next,v13,10/19] psp: track generations of device key
>>>>>     https://git.kernel.org/netdev/net-next/c/e78851058b35
>>>>>   - [net-next,v13,11/19] net/mlx5e: Support PSP offload functionality
>>>>>     https://git.kernel.org/netdev/net-next/c/89ee2d92f66c
>>>>>   - [net-next,v13,12/19] net/mlx5e: Implement PSP operations .assoc_add and .assoc_del
>>>>>     https://git.kernel.org/netdev/net-next/c/af2196f49480
>>>>>   - [net-next,v13,13/19] psp: provide encapsulation helper for drivers
>>>>>     https://git.kernel.org/netdev/net-next/c/fc724515741a
>>>>>   - [net-next,v13,14/19] net/mlx5e: Implement PSP Tx data path
>>>>>     https://git.kernel.org/netdev/net-next/c/e5a1861a298e
>>>>>   - [net-next,v13,15/19] net/mlx5e: Add PSP steering in local NIC RX
>>>>>     https://git.kernel.org/netdev/net-next/c/9536fbe10c9d
>>>>>   - [net-next,v13,16/19] net/mlx5e: Configure PSP Rx flow steering rules
>>>>>     https://git.kernel.org/netdev/net-next/c/2b6e450bfde7
>>>>>   - [net-next,v13,17/19] psp: provide decapsulation and receive helper for drivers
>>>>>     https://git.kernel.org/netdev/net-next/c/0eddb8023cee
>>>>>   - [net-next,v13,18/19] net/mlx5e: Add Rx data path offload
>>>>>     https://git.kernel.org/netdev/net-next/c/29d7f433fcec
>>>>>   - [net-next,v13,19/19] net/mlx5e: Implement PSP key_rotate operation
>>>>>     https://git.kernel.org/netdev/net-next/c/411d9d33c8a2
>>>>>
>>>>> You are awesome, thank you!
>>>>> --
>>>>> Deet-doot-dot, I am a bot.
>>>>> https://korg.docs.kernel.org/patchwork/pwbot.html
>>>>
>>>> I just saw a name conflict on psp_dev_destroy(), not sure why it was
>>>> not caught earlier.
>>>>
>>>> drivers/crypto/ccp/psp-dev.c:294:void psp_dev_destroy(struct sp_device *sp)
>>>> drivers/crypto/ccp/sp-dev.c:210:                psp_dev_destroy(sp);
>>>> drivers/crypto/ccp/sp-dev.h:175:void psp_dev_destroy(struct sp_device *sp);
>>>> drivers/crypto/ccp/sp-dev.h:182:static inline void
>>>> psp_dev_destroy(struct sp_device *sp) { }
>>>> net/psp/psp.h:16:void psp_dev_destroy(struct psp_dev *psd);
>>>> net/psp/psp.h:45:               psp_dev_destroy(psd);
>>>> net/psp/psp_main.c:102:void psp_dev_destroy(struct psp_dev *psd)
>>>> net/psp/psp_main.c:125: /* Wait until psp_dev_destroy() to call
>>>> xa_erase() to prevent a
>>>
>>> Indeed :
>>>
>>> ld: net/psp/psp_main.o: in function `psp_dev_destroy':
>>> git/net-next/net/psp/psp_main.c:103: multiple definition of
>>> `psp_dev_destroy';
>>> drivers/crypto/ccp/psp-dev.o:git/net-next/drivers/crypto/ccp/psp-dev.c:295:
>>> first defined here
>>
>> I will rename our psp_dev_destroy to psp_netdev_destroy.
> 
> Or keep psp_dev prefix.  I will use psp_dev_free()

FWIW, I think the latter option would be better.

/P


