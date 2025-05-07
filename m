Return-Path: <netdev+bounces-188550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15705AAD542
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 07:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF5F7B4715
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 05:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A25D18952C;
	Wed,  7 May 2025 05:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="An7ue0kC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E3F139E
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 05:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746595935; cv=none; b=UCK0BKAEICxLlqabThsCKQvXsaiQka1Du/VIIhl/az92VFkrxXM+nSOBb2HfEbixGVMP+3+ppgptAySWZIeqX1QSL+0cOM+dMfo56upVS0xjaLDCUHYxBG2nUOS4BVfWSvOaP2S3bDfyaDqFfU+I1dIa/9AVHUAXOUovfONI330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746595935; c=relaxed/simple;
	bh=yTF7Jp+TbY9cdTZBGOI3JrvkroGJtrZEvckT2cb/qwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3P5V38H95b+s6ecKZH2TgOa8eqKTeQTL1SKmUahtuhYokjq1+tI5tP/NaRErJPGq3tld2POadnV2pTod56u1VnUrsJl8Bkv3jiUPi9IvhUjDP+Az08VmFIptj0Hi/BaD0HeTwr8fwAx23p7nkigwk1tz/F4C4d/kfsIdezTHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=An7ue0kC; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3fea67e64caso4714511b6e.2
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 22:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1746595932; x=1747200732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXHN6Gnj9+P3ptMzbsSFbhupeu9xKqhyrBaUp2v4ioo=;
        b=An7ue0kCo8B51ct1pXlQDs2myLL719Pr+ee8SDUg7N/sPfY5ey/aYYJN79IZQamAMK
         i1Hz3d4BkyYZpQaKrfLBR5GFXEqjTAjKoiZCnpUB7UgtPZorp3GG5l5j+IwMknOjOalh
         8D/7yavcEGjrfhRAk+QyTuJ38l7jbX0Ea22nzP5/+yn9NpExaQsTcnJ7rmZSNKeBxfMj
         TcgBH49nRoFgJEyw0I+YW6D36y5SysuMC0J7QFW+Fh4GDbAE8H1ynSxUlKHxJ8x96mq4
         GST3hk2Ldya+CmsSaIUhByxcGEx1LJhr7r2VYYQ55bCYfHbrpPHB191ecixOOpzqj7Uw
         PwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746595932; x=1747200732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXHN6Gnj9+P3ptMzbsSFbhupeu9xKqhyrBaUp2v4ioo=;
        b=pbEY5EzOV31iHm+4utRehofmfiSofMe3e1PeS3KJK0fWjLEjwRvZgGrh+BJ1lsk0jn
         X6F1hoG6GmtgpXZoPvpCzTIOLHPhgleO2zQnwYFmiQc/CUzBrB+WHBZcb1n1BPyf6sJP
         usQg7lPGiF3acYUCRgs816d8X+2MwQSBqctgEbFuKOP37jqeLoFGd58eUxl0pY1tM5yQ
         iaWfw5693wSkbhq0KtSx8rENcE1fEfoZ3ZaTKHyUxnl5cA8TXo9A4PcYTks7IPlDHAyc
         I+ngTUpDX1hj4lJzBfsFcwS5fy1fdJaTY1Ne2sFDUFydttN70abD5DtfWU9ELMGxEdvP
         eBMg==
X-Forwarded-Encrypted: i=1; AJvYcCUGtIRfzsGvXhC3zGFpIpHEvy+JsDD06gq4dQ5pJJxuC8bXwR/8EdEK/ws9eTgyb3bfWoC9I8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoaeCbbLx67YlTidlOlfCfmoCRqFPP93By9GoelSIl8QxZ3SP9
	aN506w4aAggadd/BWDYNhjJMELZenZjOGwJnbw649LdKYFl4OWOiKWOIOUCAXN2D34lAJbQ+Ceg
	hcWE=
X-Gm-Gg: ASbGncv9EDXCdUlIQe5N+yk2DTzUrZD6HCrtkTtLACi76pjOBO4or3Cc7cx74nLF+P4
	7XwlE9g+uCpMe5NtucU7FJ+zF3XSohToIqf/RDikLxgM67uPW5oebe11MsosN1fNX+qBtcmZlPD
	i55PChdaS1Sx/Vf+8vT/sAHNQgql/zCvP73vs0SD46AdTWdH/mI+qHWQoeGW1r88tV245drW8g/
	7K6XrVrW2PLRwLAVjPF+LyFSRKLM0JRw4DjTzSiIY3+BUFyjAhfQxMGJpY29RkeAcfIwd/jgIn1
	T//pmEp4kpOXe+iBZ4Vmzxv1oMgKoBr12wDLn5hlBxKG+dkU2A==
X-Google-Smtp-Source: AGHT+IFuuMQml0Hx1oiprC/PjWiEkfzDo1G+dZyDFqtYvUvWVwe8mCI5eFQYikJMh7wXdDPRJuuYvA==
X-Received: by 2002:a05:6a00:420b:b0:732:a24:7354 with SMTP id d2e1a72fcca58-7409cf20f2cmr2862896b3a.4.1746595921472;
        Tue, 06 May 2025 22:32:01 -0700 (PDT)
Received: from [127.0.0.1] ([104.28.205.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a3a6sm10142958b3a.2.2025.05.06.22.31.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 May 2025 22:32:01 -0700 (PDT)
Message-ID: <b36a7cb6-582b-422d-82ce-98dc8985fd0d@cloudflare.com>
Date: Tue, 6 May 2025 22:31:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 0/3] Fix XDP loading on machines with many CPUs
To: Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com, aleksander.lobakin@intel.com,
 przemyslaw.kitszel@intel.com, dawid.osuchowski@linux.intel.com,
 jacob.e.keller@intel.com, netdev@vger.kernel.org, kernel-team@cloudflare.com
References: <20250422153659.284868-1-michal.kubiak@intel.com>
Content-Language: en-US
From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
In-Reply-To: <20250422153659.284868-1-michal.kubiak@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/22/25 8:36 AM, Michal Kubiak wrote:
> Hi,
>
> Some of our customers have reported a crash problem when trying to load
> the XDP program on machines with a large number of CPU cores. After
> extensive debugging, it became clear that the root cause of the problem
> lies in the Tx scheduler implementation, which does not seem to be able
> to handle the creation of a large number of Tx queues (even though this
> number does not exceed the number of available queues reported by the
> FW).
> This series addresses this problem.


Hi Michal,

Unfortunately this version of the series seems to reintroduce the 
original problem error: -22.

I double checked the patches, they looked like they were applied in our 
test version 2025.5.8 build which contained a 6.12.26 kernel with this 
series applied (all 3)

Our setup is saying max 252 combined queues, but running 384 CPUs by 
default, loads an XDP program, then reduces the number of queues using 
ethtool, to 192. After that we get the error -22 and link is down.

Sorry to bring some bad news, and I know it took a while, it is a bit of 
a process to test this in our lab.

The original version you had sent us was working fine when we tested it, 
so the problem seems to be between those two versions. I suppose it 
could be possible (but unlikely because I used git to apply the patches) 
that there was something wrong with the source code, but I sincerely 
doubt it as the patches had applied cleanly.

We are only able to test 6.12.y or 6.6.y stable variants of the kernel 
if you want to make a test version of a fixed series for us to try.

Thanks,

Jesse


some dmesg follows:

sudo dmesg | grep -E "ice 0000:c1:00.0|ice:"

[  20.932638] ice: Intel(R) Ethernet Connection E800 Series Linux Driver

[  20.932642] ice: Copyright (c) 2018, Intel Corporation.

[  21.259332] ice 0000:c1:00.0: DDP package does not support Tx 
scheduling layers switching feature - please update to the latest DDP 
package and try again

[  21.552597] ice 0000:c1:00.0: The DDP package was successfully loaded: 
ICE COMMS Package version 1.3.51.0

[  21.610275] ice 0000:c1:00.0: 252.048 Gb/s available PCIe bandwidth 
(16.0 GT/s PCIe x16 link)

[  21.623960] ice 0000:c1:00.0: RDMA is not supported on this device

[  21.672421] ice 0000:c1:00.0: DCB is enabled in the hardware, max 
number of TCs supported on this port are 8

[  21.705729] ice 0000:c1:00.0: FW LLDP is disabled, DCBx/LLDP in SW mode.

[  21.722873] ice 0000:c1:00.0: Commit DCB Configuration to the hardware

[  22.086346] ice 0000:c1:00.1: DDP package already present on device: 
ICE COMMS Package version 1.3.51.0

[  22.289956] ice 0000:c1:00.0 ext0: renamed from eth0

[  23.137538] ice 0000:c1:00.0 ext0: NIC Link is up 25 Gbps Full Duplex, 
Requested FEC: RS-FEC, Negotiated FEC: NONE, Autoneg Advertised: On, 
Autoneg Negotiated: False, Flow Control: None

*[ 499.643936] ice 0000:c1:00.0: Failed to set LAN Tx queue context, 
error: -22*

*
*


