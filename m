Return-Path: <netdev+bounces-162637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA654A27740
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8250C1884C88
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D202F2153DC;
	Tue,  4 Feb 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="FcVW4pkC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB5C2C181
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686968; cv=none; b=tbLUMKbrvfwW114qppEl0HHv4s5qDhwrFHCAYADWdl96Y+prrt454hX2yURiqfpsyq8rEKPZ4RNgZHhspBlJs1pxZduDDMlQPQydbMC2jnaE2DFIDAgVDlXgKMMlHxcNKTNTkTh4F4jzxYJoqRggd35vbow+3AU7bYOKuZDK0y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686968; c=relaxed/simple;
	bh=bI5dvEhjIyy61ioP0MayYlcLx8z6UqsSCzaKJXhIJhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utX7/dXl/7eDmxvh7jCvuopB6dhtde9PhYyFoU74Gw0KOyESDvoD9dHUOroUFDq7m5JSgu0b9MMGBjntYkeSdWa9sjkvI027zvhdx/isqLHglHRoZYjsuFxuF7gE9kHUrpm2UMpVsgW1u7Lw8erAjs67v1M8f1dXSqL0EPFl8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=FcVW4pkC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436341f575fso68742235e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738686965; x=1739291765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RDunVLcwW1zuR0NReRHj7nS9HRHJPnTZQ6+6UCKJLEQ=;
        b=FcVW4pkCFiUcciq7RY4xmr9SHbIfXOSy9PLxM69I7uM0KITVrKl6N1ZLK9r34GZVtS
         xxI1MZK06Oz1Tl+qSr7/yK0uREMEFEWo2I408qho8yL5VavpQTmAk6JGeMQ7N3Mluv5w
         inv5yNMA6qJeb+hcFAl7NqIj7Qtva25aSkI0cbkrPXYgpj8VQGe2p/uF5Q0fl68LC2Wh
         H/WrsAENKEIJIvjqVDGyjs6EYLLXQFjd2DaUg716nMQq94HUbihwb+HLtkR0ME7gSqOB
         aeqrFaAxypqmHQYSFxzOfQnRrBMuy05wfUNHeRWWkvEphXa6KpiIvWhhrihyjIYflrPx
         nLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738686965; x=1739291765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDunVLcwW1zuR0NReRHj7nS9HRHJPnTZQ6+6UCKJLEQ=;
        b=LpwzbV76J45TQcEwKjxKH2Y7jHsOjKpKJRoKvv0OIuaVPBvfqI1Gn7W9ahywLqIZ/c
         ZhLCEKX1lvGnRXKc0lRo8MKFuny93iEH97RPGXVcz6cDiBe6I1WmX80tCr0pvFvWe8AC
         UsO6TLqNOPkK8qRsDBWWhNUXcOxx18Hv6sQVsFXmLlwRrpvwbpvkHhFICnSpuF6684b9
         gmYrMdDprwEI69IRiDDItE7adpdKOqtH+NAo89pq3vz81kWOy7Z4ZkaS/XLgvYh0kuID
         DJPiomKNHFz0nWDNK9KD2BXzUUPrz+gsq3XQa4L89uwCJ4H/9cQaxfB7n4C+I8m2YKQK
         jAQg==
X-Forwarded-Encrypted: i=1; AJvYcCU0VWkkcGi4JGOrxApz6dXC77+sDal+ypzLDjiupgci/5aqXBHkgxtIshhIryhSwQhRJfkhkpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvADQuHcG1TzY8rHim6BunOoz/3HuQSnsCqGydaWbusueqBR/q
	BQmzD9FZoAfHhU7Ykv6JoRreQRStir7WDJNA+QXqWnVEmmg2tyAdV6KdJMvb2aM=
X-Gm-Gg: ASbGncsr88Wa4sJp15gp1eYHbZ2yxVneyWthqPTyOuhFNwK5qHgXRO7teU4AtIEf/N8
	PRufKixlRZS/dAvp/NA1Hwg5QbGo5uC+zEb6YX8Xri/6kf5BB9AEMeZn0nDRttmRwVGlT5HSWcM
	QdA8plPClaFbJE5jA0K83CDzwi8SZAsoH9rnKz+Ny1F/JjCzNlsrPYkpf1JFU6Oqk/m/6BeKtDd
	7rXeDealZsu3WxT9qE5xut8Y6dCs7125WSdo9s+N551DIOFuD36dGOHW6TIlc84SJHyU3ZVk5/4
	547qC3hZzVUa9eBkzbjOWjWuKXYLDjoYgmoVPGTt0Tx9Qus=
X-Google-Smtp-Source: AGHT+IG+BJvA7XHtSm+ZFB0urLAnB/Y3aTRtbVHRqGxt9kZO0zXne3OI/ba5+Wee/gUa3KszQwocpA==
X-Received: by 2002:a5d:4f90:0:b0:385:ee3f:5cbf with SMTP id ffacd0b85a97d-38c519526edmr19400554f8f.20.1738686964837;
        Tue, 04 Feb 2025 08:36:04 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab705f83e1dsm707185066b.185.2025.02.04.08.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 08:36:04 -0800 (PST)
Message-ID: <e4e9b6a4-ea61-4b98-b948-04ca3caa5f0b@blackwall.org>
Date: Tue, 4 Feb 2025 18:36:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] vxlan: Annotate FDB data races
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com
References: <20250204145549.1216254-1-idosch@nvidia.com>
 <20250204145549.1216254-2-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204145549.1216254-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 16:55, Ido Schimmel wrote:
> The 'used' and 'updated' fields in the FDB entry structure can be
> accessed concurrently by multiple threads, leading to reports such as
> [1]. Can be reproduced using [2].
> 
> Suppress these reports by annotating these accesses using
> READ_ONCE() / WRITE_ONCE().
> 
> [1]
> BUG: KCSAN: data-race in vxlan_xmit / vxlan_xmit
> 
> write to 0xffff942604d263a8 of 8 bytes by task 286 on cpu 0:
>  vxlan_xmit+0xb29/0x2380
>  dev_hard_start_xmit+0x84/0x2f0
>  __dev_queue_xmit+0x45a/0x1650
>  packet_xmit+0x100/0x150
>  packet_sendmsg+0x2114/0x2ac0
>  __sys_sendto+0x318/0x330
>  __x64_sys_sendto+0x76/0x90
>  x64_sys_call+0x14e8/0x1c00
>  do_syscall_64+0x9e/0x1a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff942604d263a8 of 8 bytes by task 287 on cpu 2:
>  vxlan_xmit+0xadf/0x2380
>  dev_hard_start_xmit+0x84/0x2f0
>  __dev_queue_xmit+0x45a/0x1650
>  packet_xmit+0x100/0x150
>  packet_sendmsg+0x2114/0x2ac0
>  __sys_sendto+0x318/0x330
>  __x64_sys_sendto+0x76/0x90
>  x64_sys_call+0x14e8/0x1c00
>  do_syscall_64+0x9e/0x1a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0x00000000fffbac6e -> 0x00000000fffbac6f
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 2 UID: 0 PID: 287 Comm: mausezahn Not tainted 6.13.0-rc7-01544-gb4b270f11a02 #5
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
> 
> [2]
>  #!/bin/bash
> 
>  set +H
>  echo whitelist > /sys/kernel/debug/kcsan
>  echo !vxlan_xmit > /sys/kernel/debug/kcsan
> 
>  ip link add name vx0 up type vxlan id 10010 dstport 4789 local 192.0.2.1
>  bridge fdb add 00:11:22:33:44:55 dev vx0 self static dst 198.51.100.1
>  taskset -c 0 mausezahn vx0 -a own -b 00:11:22:33:44:55 -c 0 -q &
>  taskset -c 2 mausezahn vx0 -a own -b 00:11:22:33:44:55 -c 0 -q &
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

