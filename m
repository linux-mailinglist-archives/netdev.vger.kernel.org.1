Return-Path: <netdev+bounces-159221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBE5A14D72
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67C83A6908
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD981F941F;
	Fri, 17 Jan 2025 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3ulusjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0273E71750
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109407; cv=none; b=op5zR3sIpeVmz210SsnfiNBFTEMgmLc8xWjIhCfcn+PVALA2bY8snPOGCBfxoCR6qnhPUt5QDAT60xAvBBpK0njce/dN1FN6esWFEWgZzJz/nMtLt/k/DoyzOTt7QB6GpN7DgdcwZrYOaJsGr6NGASsKY504RV+5q1NG329IUuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109407; c=relaxed/simple;
	bh=Shfj2iDGTcqv57itPEupTtFhVPemDARtS6EZEwmb++U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fPcRfRXstDbTNh/q9FciXYY6js8pyh2/5IVBZDk5Wcp3dU9GrLBAkIXECX/8yhp0LXyD8knt9dEy0kwJzY4xjSWEV5j51KYmTmALK0aItC4PfCtucN9YXQoOULEyXWdCYoDJZRof7DwPe33XLcRFevpaTpfLmPxo0CmBGSr3aa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3ulusjh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43622267b2eso18153845e9.0
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 02:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737109404; x=1737714204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQxE00xwDdztL1PB3TvziSm/QBihE9Uxgd4Ub65TbHI=;
        b=W3ulusjhxHqAKKzM80RYgCy5lCmxDYkNjYoYOJnIhxuCfecT82+vCJpzB0IcHswYZe
         WWQfyfzU2/Mhv2AitRJR29zyDVLWMglVbPOJkKJF2k3MdSaIRlT1f2M5AEgsBT8OBM3G
         RJzWaCyCc2p1sdRQYlx7L8FIZHbTAOS+9Hup9JMFlqkYdvvPG/f1InXq5Y5PpM0uK4my
         vFV3tS9/iKQFASxbM5DOr1r2/Sy30ysnVKGLdpghNdX1dNqp3b/gFWSPwNYT1mMbvh0e
         jYl6IlOJQXR7oU8W1kvjyxIBB7+UVzh/7XscEcgeocfVOwB7o/7P/bRlAeRrijmUGsip
         ZuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737109404; x=1737714204;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQxE00xwDdztL1PB3TvziSm/QBihE9Uxgd4Ub65TbHI=;
        b=KKanSjJe620u4NUzi+c+KEHWI/qQsr24wu1OjZHVEFdPbvGCNXusJlawELxhCt+l1b
         GUxH16MGhGco4m6e7ZnLtY0oq8DDUW4CxVjaEqlzMThFPNDmKKQz0GFxwI1R9eYaXm2c
         uDhdSZiSOMKvblR7hfj1ha76nJoTmntwkr0DG+g7pQh8W8m5/i0A1or3HXKOTh/VdA8Z
         28kUyMJb8+BJqSFEDwkeG4piSaBW89qaUWBvRhuPdx79dKyLUWEqThK/8wUH7PiehN8L
         KmR/0LwIQ+DV+/8XpzwHedKqhMUiBCWWrBTsr3POQq0wBQVi/4/jOK81KLNLq/Gt47hs
         Joqw==
X-Gm-Message-State: AOJu0YzbdLmnPKaPxfzR/t8BgZcREVRV7W5+JZIeRQTBwdJqvkox5rYs
	qPhSK3hNyWIf6LY8oIDI/cIUW7FWyuWy/rjadB3fnH1dpN4gJXSQDlgmiw==
X-Gm-Gg: ASbGnct5PnP7bEr4IP20l41pcfGGagcOoJaKI0/UIRQFBr3l7crKdZ/HcrOffLQRWHC
	Ck40tWf6FLcaSde2zkr2SzsI2acLW2mTJTJw8d+2mgsPDPW2JWkehHAdtl0wpOk3e7KlaVfNHxM
	3HzXiYYNnIGjuJpqQRx8o63gTFvSs5BDCZJ265Fp+QaW/BirnnOngUIYaLcl4RqFqSo9i7d0PNt
	4+JefqBINEtKynMGsjBAe8kJ2f0d7U6oD57Zc7S6XPv5BbOxbLYMqRR/FHHpVRaicAH3EJt94DF
	Wh4Usftl13rSxG/Xe0Cp5H9mlVbsxzfd0Gsdx/dYZnC5
X-Google-Smtp-Source: AGHT+IG2ASDVaUyVZ1n8SgyW8AsgfvSnJbxEjPqNkXW2FaG4eBev/zqvxKRdyqNH9RsayZzzjT8sQQ==
X-Received: by 2002:a05:600c:9a3:b0:434:fa73:a907 with SMTP id 5b1f17b1804b1-4389191b819mr17771805e9.13.1737109403950;
        Fri, 17 Jan 2025 02:23:23 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890367b48sm28825495e9.0.2025.01.17.02.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 02:23:23 -0800 (PST)
Subject: Re: [PATCH net v2] net: avoid race between device unregistration and
 ethnl ops
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org
References: <20250116092159.50890-1-atenart@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <9835ebf2-0b27-ff7d-98b8-bd8837d35be2@gmail.com>
Date: Fri, 17 Jan 2025 10:23:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250116092159.50890-1-atenart@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 16/01/2025 09:21, Antoine Tenart wrote:
> The following trace can be seen if a device is being unregistered while
> its number of channels are being modified.
> 
>   DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>   WARNING: CPU: 3 PID: 3754 at kernel/locking/mutex.c:564 __mutex_lock+0xc8a/0x1120
>   CPU: 3 UID: 0 PID: 3754 Comm: ethtool Not tainted 6.13.0-rc6+ #771
>   RIP: 0010:__mutex_lock+0xc8a/0x1120
>   Call Trace:
>    <TASK>
>    ethtool_check_max_channel+0x1ea/0x880
>    ethnl_set_channels+0x3c3/0xb10
>    ethnl_default_set_doit+0x306/0x650
>    genl_family_rcv_msg_doit+0x1e3/0x2c0
>    genl_rcv_msg+0x432/0x6f0
>    netlink_rcv_skb+0x13d/0x3b0
>    genl_rcv+0x28/0x40
>    netlink_unicast+0x42e/0x720
>    netlink_sendmsg+0x765/0xc20
>    __sys_sendto+0x3ac/0x420
>    __x64_sys_sendto+0xe0/0x1c0
>    do_syscall_64+0x95/0x180
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> This is because unregister_netdevice_many_notify might run before the
> rtnl lock section of ethnl operations, eg. set_channels in the above
> example. In this example the rss lock would be destroyed by the device
> unregistration path before being used again, but in general running
> ethnl operations while dismantle has started is not a good idea.
> 
> Fix this by denying any operation on devices being unregistered. A check
> was already there in ethnl_ops_begin, but not wide enough.
> 
> Note that the same issue cannot be seen on the ioctl version
> (__dev_ethtool) because the device reference is retrieved from within
> the rtnl lock section there. Once dismantle started, the net device is
> unlisted and no reference will be found.
> 
> Fixes: dde91ccfa25f ("ethtool: do not perform operations on net devices being unregistered")
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

