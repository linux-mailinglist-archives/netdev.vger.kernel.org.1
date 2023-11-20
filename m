Return-Path: <netdev+bounces-49407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 362197F1E9B
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 22:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C955DB20B4D
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D0D3032E;
	Mon, 20 Nov 2023 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="picslVya"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42E6CD
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 13:16:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083f613272so23288635e9.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 13:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1700515013; x=1701119813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TkAOJiTN5E/7scyYRzI9Zz4KdYJJ5bEDC78DcwnKc/U=;
        b=picslVyaiJD6rH4AHoltGejJtNwRh8HK9NPsB2ad3kf1QZcrH2bCbhbC9ZL1tJIZyd
         Q5GfMAXxUxCqU5CD09d2N8xlEnYyZiwn4A+87tzgbwcxxdXBHKwzT3o+eq4PgwmmIRV/
         xQliyVIkM3Ix2BmiY+XYvXk6T7Y7jdpD4ElwSi5BoKw4HzXaF9wm4g/N1sKm6K7jpl69
         uk8fm+aS1CDpFKWSsJCKOC/HZwLEn5Neaulbsi6f1jVEAMD9UfZN9zitooOWEavmSda8
         Wz2M8Nw/hcXnJmXjzFUfRplQMpEnW7nE9Z7pSSOWgSPxsPmKVoarJkxTLRIrQg5sTFY8
         IfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700515013; x=1701119813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkAOJiTN5E/7scyYRzI9Zz4KdYJJ5bEDC78DcwnKc/U=;
        b=i6GQPAACVp3YVoH8Kdo605PVUEHSJf+vELeQw+/+Y5y2nW4uwZ8R6Y54kBWwdOho8D
         osdqJHWsOWrDrjkiZ1ZC4Guy+AyshGUa6+uWoI3Q72NRA6bG4TTh/Kosm43uL/6c6aYf
         NXHYQL9uGVNw4LNmM6vnwf5lMD0wQ/n93CtUkYk/Zcl0ZjqINwlaGpR4fGIR6PeLRyhE
         eHRnt4RIpuxyT5+P/6XXsNBs3qBn375zgC/4nzvY1FZgjvnuuw5XHaIRRVkWu7AIvK2i
         YABnNC3MdP2DF+nokadYQ7OLqQ2yY6JNlc6BVw/GxJ3jzWu2eOFBYAW3sbNPjfAfnGvW
         f4IQ==
X-Gm-Message-State: AOJu0Yym2hJZqRiRQRb4UlALh6qtdcJYAiFV5ZvKof/XKhK8v1dypmVi
	vYCDJ4ZLzsX19oANqCvAZFZ1pGo/XLuOhUKaf24=
X-Google-Smtp-Source: AGHT+IGw/sF8uD2DUckr4QkG7Azlt8wA7SPOn1pIeqvzVaIvI2/u0AdnwYNdSQbF+y2BJ/yzhPsLtg==
X-Received: by 2002:a05:600c:4f05:b0:408:543d:5536 with SMTP id l5-20020a05600c4f0500b00408543d5536mr7134629wmq.4.1700515012833;
        Mon, 20 Nov 2023 13:16:52 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003fbe4cecc3bsm18646958wmk.16.2023.11.20.13.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 13:16:52 -0800 (PST)
Message-ID: <eb3334b7-38f8-1c6c-26d6-733be918f98d@blackwall.org>
Date: Mon, 20 Nov 2023 23:16:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2 v2] ip, link: Add support for netkit
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, stephen@networkplumber.org
Cc: martin.lau@kernel.org, dsahern@kernel.org, netdev@vger.kernel.org
References: <20231120211054.8750-1-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231120211054.8750-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/23 23:10, Daniel Borkmann wrote:
> Add base support for creating/dumping netkit devices.
> 
> Minimal example usage:
> 
>    # ip link add type netkit
>    # ip -d a
>    [...]
>    7: nk0@nk1: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>      netkit mode l3 type peer policy forward numtxqueues 1 numrxqueues 1 [...]
>    8: nk1@nk0: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>      netkit mode l3 type primary policy forward numtxqueues 1 numrxqueues 1 [...]
> 
> Example usage with netns (for BPF examples, see BPF selftests linked below):
> 
>    # ip netns add blue
>    # ip link add nk0 type netkit peer nk1 netns blue
>    # ip link set up nk0
>    # ip addr add 10.0.0.1/24 dev nk0
>    # ip -n blue link set up nk1
>    # ip -n blue addr add 10.0.0.2/24 dev nk1
>    # ping -c1 10.0.0.2
>    PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
>    64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=0.021 ms
> 
> Example usage with L2 mode and peer blackholing when no BPF is attached:
> 
>    # ip link add foo type netkit mode l2 forward peer blackhole bar
>    # ip -d a
>    [...]
>    13: bar@foo: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>       link/ether 5e:5b:81:17:02:27 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>       netkit mode l2 type peer policy blackhole numtxqueues 1 numrxqueues 1 [...]
>    14: foo@bar: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>       link/ether de:01:a5:88:9e:99 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>       netkit mode l2 type primary policy forward numtxqueues 1 numrxqueues 1 [...]
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://git.kernel.org/torvalds/c/35dfaad7188c
> Link: https://git.kernel.org/torvalds/c/05c31b4ab205
> Link: https://git.kernel.org/torvalds/c/ace15f91e569
> ---
>   [ Targetted for iproute2 6.7 release. ]
> 
>   v1 -> v2:
>   - Add table-driven approach for netlink settings dump
>   - Remove matches, use strcmp
>   - Fix nit with braces
>   - Add maintainers entry
> 
>   MAINTAINERS              |   6 ++
>   ip/Makefile              |   2 +-
>   ip/iplink.c              |   4 +-
>   ip/iplink_netkit.c       | 165 +++++++++++++++++++++++++++++++++++++++
>   man/man8/ip-address.8.in |   3 +-
>   man/man8/ip-link.8.in    |  44 +++++++++++
>   6 files changed, 220 insertions(+), 4 deletions(-)
>   create mode 100644 ip/iplink_netkit.c
> 

Looks good to me,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



