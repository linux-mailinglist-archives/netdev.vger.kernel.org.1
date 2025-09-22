Return-Path: <netdev+bounces-225246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148E6B9110C
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD34424391
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4258A306B04;
	Mon, 22 Sep 2025 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="WRFNRSbW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC83064A7
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758542850; cv=none; b=HPWpbagC8fxNhbx0vfcX/sl+NePgL4k+HFGTLGHlH94Ge0Q0BfeFy2T5AlbQ/IupI/+fvKLNetciCYpMKJMtDJRh5hjfJCzEDDk9Q/97Q3x/qMZ2EDU6HE4bGmeequxal/7ECfsD4SgZCuL93+f12M2DFobh3JheGNkRqN5AQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758542850; c=relaxed/simple;
	bh=DVcPbszETqDHHK8qlzPBuEKPE7LbZrIWqmngLLuVmgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXIITB7Bt8cbf8Z2YSEx/jTnWp2s7UU2VnMxBi8khd4QvJ8cJqB3OkUi5XBmhW++hJM37NcW9HjMwdjVWV1sn1TY92YQxm/wgBDIxN0gCYE8haJ1+Yfp2jGqy5EwVC0/Ot2KR16M0W1ySmRFx5y50Sq38dJ0YuvweQ/NYZPfDvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=WRFNRSbW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso716960e87.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1758542846; x=1759147646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jM2pnJ1B8JxuL/d0YmLtjvLcDHew5XSTZjid5H7F9Q=;
        b=WRFNRSbWuYmbC8bojHAF8Zaqqgt5L5w0yX42qFF/d529b+juL25t/jQun99zglGsZW
         y1kUAueRbrEWcWsj6tuYgYA0aEJSDHyB36bhSINCu7K65Lrt4l3rb1L1hNc4az+HYt2O
         ZvW8MoW1f5toGOxzAqHT9x4ip5Zg6FBNAVWXzFPWkdZ1hhZ8uYDRaLyykoq7jeVTJ5/4
         tjscWS0PBp0fya9RU3W1hwFG8ld3hSR4+HJ0h9zZ4S9ob5xLKHFopxmzl8al+7bzNQSu
         r99rfoWnjO46VFC+5+bZ76c8YDevqWp1rlmFp+I7hdr8MiHJHIRqdAR1+sHv0MzXFZrM
         02CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758542846; x=1759147646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jM2pnJ1B8JxuL/d0YmLtjvLcDHew5XSTZjid5H7F9Q=;
        b=gDBqIO+T9d3pG0IAOCdmWjleJPGscfnQ1OCABJ1Fqi/RY5dld6HHe96TZdZsb0HsNS
         G928jS0rzNKTCsooxQgXyHMe94sEJvWbgEoDv4WSnDckFX8lob4EgrBr+bDk3/8eXQzt
         PYZKewx3gD4eZ5ERUI2JyfzVG15UQnu9kznpnYmTWayx7fwjUtZ6Jm95e2aOD07ld+Pd
         WDenjEfPLrN2HRmZl051TAFl/ofzfPrMFCTRsp2B5Lu/xjMT05612ErdXtTDxrZtrUfn
         ZtGhwUv14lRJ4pJigiaUk9/+HCgxjuaVIAtoG1qpvCjhUsWkq9OWX+8RaxNr9gZ5KE2H
         ndUg==
X-Forwarded-Encrypted: i=1; AJvYcCX86ERT0JcQK12okWpc3CARl0x/W5oLTEGLX17VHTOMUwFqEcSLPEhUd8+RaP5rEg/X+Bfd8eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4GJ1MWKZtPAA2gWrPdLCoK+N5iQ5/otphlubni4WqmqCXHhbT
	D3RUjjMoWd0jnU/4PgAlA3R23K+FpeCvda7U0xLggcfFdiOWww6X2Q1OwipKLWNG/U8=
X-Gm-Gg: ASbGncvsfUeXR5ToHaixefbOmDPmA1C/2K+Zoa7kkvD+yOzemAZtNH/tQ/Jl1sAKcJ9
	3j64oobJYz4ngiuv6eZsqEQAlruyVv40wMLkUhHk9xmOmQYGGMIbD5aKlsQAChSEG4VMIPqt5rl
	yI2HAQQCDv5y05ErXR7ssRBwNFiYRifpHxwjT6dQutjEyAhVzxi4NqmMXZHudk71qR2+YAjdZRE
	5Okddh0/4MkbJV715DlVowaEC7PnsdKX9vQMsybmeT3o72N4gNzXOWa4hFajz5wFHdSn1mM3fTA
	3t44DqgAdzMK5K+vnIrfWZ7zp09AG6AiXuPKYHIKlLIahaH0jKvkB9ly2MF61IGgaa7zyMpT9Ml
	XoQsk9eidTMf/nGJrR//i39uRhrWUrfDyeP7fWDDRvYJ62XbPUFEime9m0LdHtMeGUh4Rz2Gso0
	LMrA==
X-Google-Smtp-Source: AGHT+IGD/jn0d6LdkWrAOucGmU5CI1mFNI4XovrTeMWdsjpZHgr8vX7aDRSEomQXgS6HuxCZugjO1Q==
X-Received: by 2002:a05:6512:350d:b0:57d:a4e9:5b00 with SMTP id 2adb3069b0e04-57da4e95c80mr1678442e87.30.1758542846178;
        Mon, 22 Sep 2025 05:07:26 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a9668043sm3191553e87.110.2025.09.22.05.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 05:07:25 -0700 (PDT)
Message-ID: <51de8bdf-e8e9-418b-8d6e-c559b8e831df@blackwall.org>
Date: Mon, 22 Sep 2025 15:05:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/20] netkit: Support for io_uring zero-copy and
 AF_XDP
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/25 00:31, Daniel Borkmann wrote:
> Containers use virtual netdevs to route traffic from a physical netdev
> in the host namespace. They do not have access to the physical netdev
> in the host and thus can't use memory providers or AF_XDP that require
> reconfiguring/restarting queues in the physical netdev.
> 
> This patchset adds the concept of queue peering to virtual netdevs that
> allow containers to use memory providers and AF_XDP at _native speed_!
> These mapped queues are bound to a real queue in a physical netdev and
> act as a proxy.
> 
> Memory providers and AF_XDP operations takes an ifindex and queue id,
> so containers would pass in an ifindex for a virtual netdev and a queue
> id of a mapped queue, which then gets proxied to the underlying real
> queue. Peered queues are created and bound to a real queue atomically
> through a generic ynl netdev operation.
> 
> We have implemented support for this concept in netkit and tested the
> latter against Nvidia ConnectX-6 (mlx5) as well as Broadcom BCM957504
> (bnxt_en) 100G NICs. For more details see the individual patches.
> 
> Daniel Borkmann (10):
>    net: Add ndo_{peer,unpeer}_queues callback
>    net, ethtool: Disallow mapped real rxqs to be resized
>    xsk: Move NETDEV_XDP_ACT_ZC into generic header
>    xsk: Move pool registration into single function
>    xsk: Add small helper xp_pool_bindable
>    xsk: Change xsk_rcv_check to check netdev/queue_id from pool
>    xsk: Proxy pool management for mapped queues
>    netkit: Add single device mode for netkit
>    netkit: Document fast vs slowpath members via macros
>    netkit: Add xsk support for af_xdp applications
> 
> David Wei (10):
>    net, ynl: Add bind-queue operation
>    net: Add peer to netdev_rx_queue
>    net: Add ndo_queue_create callback
>    net, ynl: Implement netdev_nl_bind_queue_doit
>    net, ynl: Add peer info to queue-get response
>    net: Proxy net_mp_{open,close}_rxq for mapped queues
>    netkit: Implement rtnl_link_ops->alloc
>    netkit: Implement ndo_queue_create
>    netkit: Add io_uring zero-copy support for TCP
>    tools, ynl: Add queue binding ynl sample application
> 
>   Documentation/netlink/specs/netdev.yaml |  54 ++++
>   drivers/net/netkit.c                    | 362 ++++++++++++++++++++----
>   include/linux/netdevice.h               |  15 +-
>   include/net/netdev_queues.h             |   1 +
>   include/net/netdev_rx_queue.h           |  55 ++++
>   include/net/xdp_sock_drv.h              |   8 +-
>   include/uapi/linux/if_link.h            |   6 +
>   include/uapi/linux/netdev.h             |  20 ++
>   net/core/netdev-genl-gen.c              |  14 +
>   net/core/netdev-genl-gen.h              |   1 +
>   net/core/netdev-genl.c                  | 144 +++++++++-
>   net/core/netdev_rx_queue.c              |  15 +-
>   net/ethtool/channels.c                  |  10 +-
>   net/xdp/xsk.c                           |  27 +-
>   net/xdp/xsk.h                           |   5 +-
>   net/xdp/xsk_buff_pool.c                 |  29 +-
>   tools/include/uapi/linux/netdev.h       |  20 ++
>   tools/net/ynl/samples/bind.c            |  56 ++++
>   18 files changed, 750 insertions(+), 92 deletions(-)
>   create mode 100644 tools/net/ynl/samples/bind.c
> 

I have reviewed the set and it looks good to me. To be fair, I have reviewed
it privately before as well. I really like the changes, we have discussed some
of the ideas implemented before. Personally I especially like the io_uring support
and think that some new interesting use cases will come out of it.

Nice work, for the set:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
  Nik


