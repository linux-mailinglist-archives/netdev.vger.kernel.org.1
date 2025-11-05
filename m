Return-Path: <netdev+bounces-235649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C01C337F1
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 01:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FAC4619C8
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 00:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7896E1DF987;
	Wed,  5 Nov 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="IUXEF1G6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8124B28
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303437; cv=none; b=pROZViZzIP/jflUZn8QzP6/+FP4FClhCgDymzBQUN/UhG6KXeknagSnFqKH09iuIc3QDawlvkkRyr6qkTxu894IO0g9XwOz2/dJWyJxgHBzjx1NPTqZDshVuy+NgcSEXI8zZ8awvHL8N4zbKbjUXvG2Os7WQxP/3uvAH9ajV7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303437; c=relaxed/simple;
	bh=E5KzXFmlri9AMFXWFXoDNi4x686IkJXsVsOhEzlf3Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omr+V5rmb4XvWVXvaTX90orJJdeRWd9vM4Dv5Mivk6Gt2mDCjs9JWgHeepnOBnKI2XEFmK8x3+hPzLHamaINaIuH85JXPYBICuQmkFCqhoEzTkftwRVja4XykAkxJnEWacRdr93CHcATTzHwl6gcX028NqF214iVWJExCijBdek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=IUXEF1G6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29570bcf220so43352235ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 16:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762303435; x=1762908235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsSMsMyxxTvbuO/AuQ/xWK4ZxpcOgIr+bMzBvy5ZPCg=;
        b=IUXEF1G6bfnmM5yqlCR04eOhf3O3xmDxQj9F6Bfu4Kq3T/sBK+RbWxvc5Q+Sh1jPBV
         3ANzKWZvJCu6Tw/sPI92s6my/t4io6cgsST6l7OhfuOq7LrDLNwuQB6btG1OQ+rqSl3d
         WPo51PA9Nrmn9/fUcoDyUaW2f9WEVYT9mtpSFZSmaMwMwREX16m+mhIbBFo1Yjnk5KpN
         O0Lh7gOelaqpHaNBRWD9leAgDys+EvYWVoK1qulBZNWJSdlqW3boJ7670I98VTiAsKVl
         Gc3TlLHp1B1S9O3eTbwtqLzVfGNvaO10Z5rbTVZamrZCWIDrVx8BY3HLxuPficn3SQ91
         iM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762303435; x=1762908235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsSMsMyxxTvbuO/AuQ/xWK4ZxpcOgIr+bMzBvy5ZPCg=;
        b=eE5T37m8daipC2jYj5Sbe0bN+sST48wmpRj9xeZsXXylR3LL06L19vgQtDd8h/wJf4
         ruVPfVexcjVrJrd6rwfcM3ZDJDEQCCl53HB0hhoczBjxsF5TuIl7l/czYOHGSjIFeagc
         QVda4sI6N7wOXDuzR0sRDkmWWbIx/1rzU/U3Qhl1JIcfyKwoNO3mifUpMsjVzesUqTlh
         Yj8XOGIDHhFXtfkfQ+1b3fmHwa3CR/+dmNFeJmtkO0ULPhh5MCtZYBUIhMEJonNvjkN3
         I562gPYtPWus44asWKfoDuQYWkmTKklZIHWsU0vOEp7mTtVEdssmGCei3zZOhilLMaC/
         vEUw==
X-Gm-Message-State: AOJu0YySXOoYDASngaAw1z3Ul5LWZD8f961gKrhHoLbJMaMfSEGkLIpy
	1rXVcZe2j5KjnKHCdyEhQzejaZ7RZAwihrkzaxj4WbRaLztLMvcyCZ3JqLq3uEArD0I=
X-Gm-Gg: ASbGncvMtQa2y6q3bsu+czoLyYtIfi+6kDwKQGeJJ8vhIaXz3++R84pbirlofw2qLwf
	0yhpGH0OgKWAecLl1WBzOP7zTpX53TtSdnUw6VZ1IlfCYeOwSlvQJVSUnMmqZcI8mJSMl45xLva
	wp9TNDx6GE6rb1Xy4nnkUKseitGaouPSE/O6HvWl5f39gVix7vYwyKNtAgRWv++YCvAebbDrnD8
	8XT9CnuwKTBQv/VpbA9kVYXtq53z7BJbqsJEjBGYEG1/ybdGCxatfci9uIcmIqA195UBWP9/svD
	Ha84lN+sNHEPUnn9VicCkOUjFrG5M6JbpTZRgAPIb2DmP8f/oWdw9VS4fuSbwpUsV3C8MAPa4nL
	sHhtGivXoEEYNcDiX81e0TTAfrhd/1i4+49kG7pSiVGSHfaW3UrjC0fX5Nm3PsqaSuL/wT3/ULb
	mwcBrXgEKCseaczLdMKZYEquTwS4YLraTkv4PfixzbpkvR
X-Google-Smtp-Source: AGHT+IH/m056Yd4GGUR13i+5WeICFachka/jDksifdvaeRwvNQusf56tL3cKrTjbFmVBgBAwzkqZGw==
X-Received: by 2002:a17:902:c404:b0:294:f30f:ea4b with SMTP id d9443c01a7336-2962ad827a2mr15801125ad.8.1762303435328;
        Tue, 04 Nov 2025 16:43:55 -0800 (PST)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019bc0desm40806615ad.47.2025.11.04.16.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 16:43:54 -0800 (PST)
Message-ID: <458d088f-dace-4869-b4af-b381d6ca5af1@davidwei.uk>
Date: Tue, 4 Nov 2025 16:43:54 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/14] netkit: Support for io_uring zero-copy
 and AF_XDP
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20251031212103.310683-1-daniel@iogearbox.net>
 <aQqKsGDdeYQqA91s@mini-arch>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aQqKsGDdeYQqA91s@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-04 15:22, Stanislav Fomichev wrote:
> On 10/31, Daniel Borkmann wrote:
>> Containers use virtual netdevs to route traffic from a physical netdev
>> in the host namespace. They do not have access to the physical netdev
>> in the host and thus can't use memory providers or AF_XDP that require
>> reconfiguring/restarting queues in the physical netdev.
>>
>> This patchset adds the concept of queue peering to virtual netdevs that
>> allow containers to use memory providers and AF_XDP at native speed.
>> These mapped queues are bound to a real queue in a physical netdev and
>> act as a proxy.
>>
>> Memory providers and AF_XDP operations takes an ifindex and queue id,
>> so containers would pass in an ifindex for a virtual netdev and a queue
>> id of a mapped queue, which then gets proxied to the underlying real
>> queue. Peered queues are created and bound to a real queue atomically
>> through a generic ynl netdev operation.
>>
>> We have implemented support for this concept in netkit and tested the
>> latter against Nvidia ConnectX-6 (mlx5) as well as Broadcom BCM957504
>> (bnxt_en) 100G NICs. For more details see the individual patches.
>>
>> v3->v4:
>>   - ndo_queue_create store dst queue via arg (Nikolay)
>>   - Small nits like a spelling issue + rev xmas (Nikolay)
>>   - admin-perm flag in bind-queue spec (Jakub)
>>   - Fix potential ABBA deadlock situation in bind (Jakub, Paolo, Stan)
>>   - Add a peer dev_tracker to not reuse the sysfs one (Jakub)
>>   - New patch (12/14) to handle the underlying device going away (Jakub)
>>   - Improve commit message on queue-get (Jakub)
>>   - Do not expose phys dev info from container on queue-get (Jakub)
>>   - Add netif_put_rx_queue_peer_locked to simplify code (Stan)
>>   - Rework xsk handling to simplify the code and drop a few patches
>>   - Rebase and retested everything with mlx5 + bnxt_en
> 
> I mostly looked at patches 1-8 and they look good to me. Will it be
> possible to put your sample runs from 13 and 14 into a selftest form? Even
> if you require real hw, that should be doable, similar to
> tools/testing/selftests/drivers/net/hw/devmem.py, right?

Thanks for taking a look. For io_uring at least, it requires both a
routable VIP that can be assigned to the netkit in a netns and a BPF
program for skb forwarding. I could add a selftest, but it'll be hard to
generalise across all envs. I'm hoping to get self contained QEMU VM
selftest support first. WDYT?

