Return-Path: <netdev+bounces-52436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A20A7FEBCB
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45461282072
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D14A38DDB;
	Thu, 30 Nov 2023 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UUks07+c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3886B10CE
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:24:12 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cdcef787ffso738727b3a.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701336251; x=1701941051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODGxd7/u71d/rY/1QUl5tXlqtMzlubsqrETh3ZFBIzc=;
        b=UUks07+cN6WPU+Lhz+jl8Ma+nNwYywdE99+qa7HjaTsNJimsVx0/8GBu1sm0fshzUY
         hPF9tRyE3bvdvhBG3AtCnFf8w99n/hGyDLYNZ+usmZcDZzOx4N1gEdkzOAe+z/bq5cyo
         LHAdlRQWuGva8NqWHaHPGUAU/YjM3ylTY3z/yMioGqGk5zFahPwLwi5T2f27XxsuOMPd
         l9VtUIGlZhX8FgnhHH78RUBFKYvAkbKYGTJ+C+sY09IohPcvOBDUQxCpfjQPFAvsxJyk
         pBD0BpQRibAkzihXWD5Pgh9meVfyhasD6Zq50mToidNbTgm3Fbo/Xnp1rhCzcfkmApUZ
         2h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336251; x=1701941051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ODGxd7/u71d/rY/1QUl5tXlqtMzlubsqrETh3ZFBIzc=;
        b=iOrJaKfcfQ5iUIMBJhQPi/r+qlqbGTNFQQO33FTCUvPGVKcqvpanrASYBpxWuFPVc3
         pzZzCePGbsVMvVydRSpGP8HFXm0G2s4ut4stCL7iSd6L+Vf70Nv2QBdeX7u0ifBeULyy
         IXFO3PerTWaxIYyHZFdwzv5TGo4JlPONWca5yid9InQ0ml/w1NvHzKriAWGhJbUaiMYw
         cMoGELTlbdXdREHUuqOL3D3Pf0699YziRlMQNS0j/K8LlLlg0tecyRIvJmRir/SVvXGY
         pImG/ljP8Rm6A4ATBBXYyDKVodRw3CTY4wTiIrWbwGOh3RXg82hO8oCnpm9JjX72pM1T
         iGaw==
X-Gm-Message-State: AOJu0Yxz+P1728w9KaympHUmSX5Zx1Aazuv1nEUbrEPF+LKhiTNAINcN
	th9fsO27os+AmexKGsPfiQ82IA==
X-Google-Smtp-Source: AGHT+IGvtcp1PgtnVJr+WQ8C2U2NNcXXrpY/qCKSZGSEOFUMfOPyOa8gDqmrc3Yr78UCV+DX5EsG/Q==
X-Received: by 2002:a05:6a21:a58d:b0:18b:d99a:99bd with SMTP id gd13-20020a056a21a58d00b0018bd99a99bdmr25455213pzc.32.1701336251730;
        Thu, 30 Nov 2023 01:24:11 -0800 (PST)
Received: from [10.84.152.108] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090282c800b001cfc1b93179sm18516plz.232.2023.11.30.01.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:24:11 -0800 (PST)
Message-ID: <16b4d42d-2d62-460e-912f-6e3b86f3004d@bytedance.com>
Date: Thu, 30 Nov 2023 17:24:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH bpf-next] netkit: Add some ethtool ops to
 provide information to user
To: Nikolay Aleksandrov <razor@blackwall.org>, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com, tangchen.1@bytedance.com
References: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
 <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2023/11/30 17:06, Nikolay Aleksandrov 写道:
> On 11/30/23 09:58, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> Add get_strings, get_sset_count, get_ethtool_stats to get peer
>> ifindex.
>> ethtool -S nk1
>> NIC statistics:
>>       peer_ifindex: 36
>>
>> Add get_link, get_link_ksettings to get link stat.
>> ethtool nk1
>> Settings for nk1:
>>     ...
>>     Link detected: yes
>>
>> Add get_ts_info.
>> ethtool -T nk1
>> Time stamping parameters for nk1:
>> ...
>>
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>>   drivers/net/netkit.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
> 
> Hi,
> I don't see any point in sending peer_ifindex through ethtool, even
> worse through ethtool stats. That is definitely the wrong place for it.
> You can already retrieve that through netlink. About the speed/duplex
> this one makes more sense, but this is the wrong way to do it.
> See how we did it for virtio_net (you are free to set speed/duplex
> to anything to please bonding for example). Although I doubt anyone will 
> use netkit with bonding, so even that is questionable. :)
> 
> Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> Cheers,
>   Nik
> 

We use netkit to replace veth to improve performance, veth can be used 
ethtool -S veth to get peer_ifindex, so this part is added, as long as 
it is to keep the netkit part and veth unified, to ensure the same usage 
habits, and to replace it without perception.



