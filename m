Return-Path: <netdev+bounces-176697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D22A6B649
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 09:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18283BC564
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC441F03E2;
	Fri, 21 Mar 2025 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="P+xMfhfz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F23D1DDA39
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546990; cv=none; b=mPochHMMPMmnkyN2MWZp8fyzeyMvtb77q2DviYQFARgSWIgl4sBVCirYXMOlbwD57UHWLwtQApkVUKW31ZN7qiWIiqVPcMJjPXdjdIt70ENLpcKvfm5rAdBP9OCYDXArsdzMfJNuBllXqt/4GouBmguDdBMC1DuqkCCpPgflqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546990; c=relaxed/simple;
	bh=BdYwP7tXPT2j8lmBiDYuVqTDKM/IAWnNLmYs2BkxZbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zx21k5/CT1hklGR4uhcDnw9OdkqjMp9XHIKpKrwvRcVlFJ2cMbeo1yeJCTlIc2pLKqV2dPHAGDbNtVN+4FBLtlDNYTNfuQn18YIk+Ib0jYqzypaFRh5RgjmmsMYxCKjxM2s2u5EPPGLAgZNhZmwK35L+Y0UFvXfsDZpvBJTHIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=P+xMfhfz; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3913d129c1aso1209679f8f.0
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1742546986; x=1743151786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kP/oToQG/ZYW3gTl20lMgrstF8CsuMLc4tD5FNJ7/+I=;
        b=P+xMfhfzr4PwaptqEy4D637SIdm922hj4P8enE+niopsCKhLlXdTHCp9+2xz98X/Li
         2ZIY/wgeg6gLWNQr7O+S4jEizw1XAYux3EOCVvIH255RTIPKysiYri6drx7X2Q9qhzUm
         xSUuZzi4vGIp6DNZjDkMgBtkpd2h4ROmp/6+Cryh9wHAlfPHTFtQmXeUCwdkUQL7SGRK
         s9nZnHGJRwHwm8jXRFni9GlTupBF9HSipQ/rehApZ6/plBF46LbGwopPaCFs+mBNphci
         TzqcmnHBdI4zmsT0ztlgBfrmDaWPRBiqSvygnDO1TYHM8ByDoGMxU5CyBIb1ms7kHytI
         3/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742546986; x=1743151786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kP/oToQG/ZYW3gTl20lMgrstF8CsuMLc4tD5FNJ7/+I=;
        b=fxaMqcndHIIU7C6ii5nexk5muE7nDbHwckRcJRvgLnELXEt3sCWkhSi/rsRWVDkJX9
         h1RzndywnhtsKoACycdYMj6+0S8rYsTHUAFUQcee1t0fwOQAkvjtgkvM1zhm2hi9bvf4
         6/ifKo1c6hafYJi6RLoRXFh1LUDbFvHIMq0hPtX4PioFsOqTFZG7DGyH3vzc/tRkXTeY
         np/EioSt+4IqaeCcrH3/tWW6YOSezW/FtTBltFr7qcb6wSHvg6boFjhAGR7A/ormdLmR
         ulROeJklS6HvyD39k0D/oReJ2HL6J7arIrn5etIEusFkDEY1grtzEH86gVL0EsaMrtC4
         fM9A==
X-Forwarded-Encrypted: i=1; AJvYcCUUMjsVqOhXe9/zxuuPJgLGz9y3FSTVdtIKk4EWTqFrd2wF/UkAth8YLaJT5CJG2rlC2Pa07ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2FGdPd+tvRgg9hc1goHPfbrFp8hBh/tgX7MbVD+FSqKCd40j
	ztOg/pGyoKW03hx+uunzPS5NwBBb5T7qdOnHbj2ZVIPT35Apmv7tryK+WEdsQ8M=
X-Gm-Gg: ASbGncuqy3xQT1H0l/q9rlljRnKIkaAZA64IvsFY6Kgxgny6l4yW1WrVVXakvyOgxnZ
	N0JZaoO8BC+ldyZXMCStGfWy1+uwch4aHBxxEiRY8AyTNN8HU02UOkXTvwuEQ4UbEpjXOT1yOHp
	ulsE//H7dReiUQ4U4vuzMkZ5eOnZcc2dwnSkIAAXqyJO2dp5Ep24n1Vu/7bQ7Q8Tk/N593YtPpB
	iKwoYomTvp3De7ntFuddZAwnf8MVdnwZsmpo5U50GPLAUDL8tmWJyUsPiVYTuuJJxZ+ri8FNR7e
	J3yFIQfvmskjyi4IQWLCHK7uhS2yKCMCn28ZrKmrBqg1VNODklA7DuyvWt5j46sF4ZQxLt7r49Z
	W
X-Google-Smtp-Source: AGHT+IEEPloGyBEU28wIiwPGHJOaEhmT5NLx+HvXiE8cWYV+PLw9KRaTachUL02eG98SY8h03fxa4w==
X-Received: by 2002:a05:6000:1844:b0:391:1199:22b5 with SMTP id ffacd0b85a97d-3997955ca60mr5557045f8f.10.1742546985428;
        Fri, 21 Mar 2025 01:49:45 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b3ebcsm1755679f8f.47.2025.03.21.01.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 01:49:44 -0700 (PDT)
Message-ID: <977fc7da-b7dc-4518-b7c9-0c492e2508f6@blackwall.org>
Date: Fri, 21 Mar 2025 10:49:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bonding: check xdp prog when set bond mode
To: Wang Liang <wangliang74@huawei.com>, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joamaki@gmail.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250321044852.1086551-1-wangliang74@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250321044852.1086551-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/25 06:48, Wang Liang wrote:
> Following operations can trigger a warning[1]:
> 
>     ip netns add ns1
>     ip netns exec ns1 ip link add bond0 type bond mode balance-rr
>     ip netns exec ns1 ip link set dev bond0 xdp obj af_xdp_kern.o sec xdp
>     ip netns exec ns1 ip link set bond0 type bond mode broadcast
>     ip netns del ns1
> 
> When delete the namespace, dev_xdp_uninstall() is called to remove xdp
> program on bond dev, and bond_xdp_set() will check the bond mode. If bond
> mode is changed after attaching xdp program, the warning may occur.
> 
> Some bond modes (broadcast, etc.) do not support native xdp. Set bond mode
> with xdp program attached is not good. Add check for xdp program when set
> bond mode.
> 
>     [1]
>     ------------[ cut here ]------------
>     WARNING: CPU: 0 PID: 11 at net/core/dev.c:9912 unregister_netdevice_many_notify+0x8d9/0x930
>     Modules linked in:
>     CPU: 0 UID: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.14.0-rc4 #107
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>     Workqueue: netns cleanup_net
>     RIP: 0010:unregister_netdevice_many_notify+0x8d9/0x930
>     Code: 00 00 48 c7 c6 6f e3 a2 82 48 c7 c7 d0 b3 96 82 e8 9c 10 3e ...
>     RSP: 0018:ffffc90000063d80 EFLAGS: 00000282
>     RAX: 00000000ffffffa1 RBX: ffff888004959000 RCX: 00000000ffffdfff
>     RDX: 0000000000000000 RSI: 00000000ffffffea RDI: ffffc90000063b48
>     RBP: ffffc90000063e28 R08: ffffffff82d39b28 R09: 0000000000009ffb
>     R10: 0000000000000175 R11: ffffffff82d09b40 R12: ffff8880049598e8
>     R13: 0000000000000001 R14: dead000000000100 R15: ffffc90000045000
>     FS:  0000000000000000(0000) GS:ffff888007a00000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 000000000d406b60 CR3: 000000000483e000 CR4: 00000000000006f0
>     Call Trace:
>      <TASK>
>      ? __warn+0x83/0x130
>      ? unregister_netdevice_many_notify+0x8d9/0x930
>      ? report_bug+0x18e/0x1a0
>      ? handle_bug+0x54/0x90
>      ? exc_invalid_op+0x18/0x70
>      ? asm_exc_invalid_op+0x1a/0x20
>      ? unregister_netdevice_many_notify+0x8d9/0x930
>      ? bond_net_exit_batch_rtnl+0x5c/0x90
>      cleanup_net+0x237/0x3d0
>      process_one_work+0x163/0x390
>      worker_thread+0x293/0x3b0
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0xec/0x1e0
>      ? __pfx_kthread+0x10/0x10
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x2f/0x50
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
>     ---[ end trace 0000000000000000 ]---
> 
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  drivers/net/bonding/bond_main.c    | 8 ++++----
>  drivers/net/bonding/bond_options.c | 3 +++
>  include/net/bonding.h              | 1 +
>  3 files changed, 8 insertions(+), 4 deletions(-)

Just fyi you should include what changed since v1 below the ---.
Anyway, thanks! This is exactly what I meant.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


