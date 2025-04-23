Return-Path: <netdev+bounces-185189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2710DA98EE8
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 17:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2DC16FF4C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919FF27D763;
	Wed, 23 Apr 2025 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="tU1Q2RVt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477819DF4C
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420326; cv=none; b=IGX+0Lg0rrRDUFRYWkHoD3hP/g3C8YSCb8REf/psOge3H8mb03pWx9vCd3HnRw/hNVl7WgU7PgCPxaXpY/8GJ4EPBcA2/CRNWRNZONE66EW5JCDpvw5YtiEn+z2iC/HimaZrGYGuAwKinDtCSu4wNksvVxBNbFW4ZEqDAdGqlT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420326; c=relaxed/simple;
	bh=7JJzZcZ/ipAWeO2ub72iSgyV5EpLMPjcm0Z+IBsYWcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDCK1RCXKBHjaVeMlit9KmQ/lWOmFMKMDjhvsu6jie2cwqxWH4l4f1CqrVsCSaN/MvFlkbH4xzZIT6F93OgXWfklEUzscQ/JwmRYHuKa9CN6+12s0njT9zOlNVcXKhkTIrZ5uPCHudf4XzC5jed9ZrwwCnDFZ5tiYl+bDyt0hn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=tU1Q2RVt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso10158701a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1745420322; x=1746025122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAnLhMvG6V9xN/VkmmltzcxJ/pU8SwVkbc24nYJNht8=;
        b=tU1Q2RVtPycdYWaDka+MyOsbJsWCYEbja/G26b/lQrZU87CBXmgme/Gg48o+CAqPlx
         Oa0YQ3J/cmspiMEqJFjyFb50jmI8MfUS4JwoFK9xdYzVMNDx5vfd1CCJgei6FeBirxx4
         pFw3fDQ7qkvJeyApwZIpKdUsXvPVvp1wARYQhir9LVl8AC7lMqH+m5Mi+1/A1qhA6+9y
         tLUWzstjd3J38paMHxBa0CWz4fA6cpO2MqWXoRzn6PvGy4YdurXB8ZtXl4hWVd+A4rf1
         W9XQx96xUpDHdJY7FI+K/8FsLL+JFHFXhAXd01ru9JjrAbtciHeoWlM6tEbD4co9d+93
         hn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420322; x=1746025122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAnLhMvG6V9xN/VkmmltzcxJ/pU8SwVkbc24nYJNht8=;
        b=W/xhB4JTevwrrgV8MC0lHLhHYkAR35JdH3eJy+IV7XYdsrCTcUPlnns1Wcfq20hhK/
         sOM2LrQJiBSw2HgFrlvvk61bxnHQiJuvAzkYZGptyoLpLT1WUjOiqAfiTp2DyJfhlSlW
         Rk7Il0UU2WNUXqypARRSYaxbHEcLgb4KQJCQTMFdY43XYBy7LTVekNT+V3J178uk2XbR
         S2ffbdRRGu7gfVvEC3JoDhuKY8XENFr6jfjDpTlcKK1jn4fa1VvveoEwFhSxS60HQZCg
         xZ5imuz1R+Wre3zakoeRo4mXuWRaGg99/Wi68LKEqAL+gN8qCGocQ/Ybew8JTN1pO2uE
         6iOA==
X-Forwarded-Encrypted: i=1; AJvYcCXtf5/AaqYU7ASz0BdryxrypitzXey95hY3nUdkcFzuoWHAVlY2ywy5JdXuiJr50avYDln3Nvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7qSao1zrWyODERn5xJQlA509Xn/mf99PWjcUXmUCCecDAx/D
	PN5tw5V+HeCtcpNIFQPumVkH63Z6lgXxoQs6ISpPc4k4gAcjQS8W5zAbUneicX0=
X-Gm-Gg: ASbGncsjyu3SIWgS3Z0Aw79dlUeuksBYDsoOoDsCjz+GIZDURziLWcbzSsY3CWfUVKy
	+UxWVOwlmExbt1XkN8H0LTyci9z0qwC3jCZN8aA6WN6uxmK/xhWrd3u54SJSgiAMsNyOazs2p7B
	Dcwj6ioUvwUb9pYX8TCMS7LMlxtpKjQnaMa8xxdSbJFwoRtPHu9l/thd897Pqwr2NLezvHqwQIL
	yM4lU/WtI0BHAegFdQEV80fKaRPYYXrikqEQrukrlRwF6uWH3HBOVIh1Jr/n9EIZDN+GIWIThR+
	OPYQAGzRbyfRbRb/fh/mEZeNF6aJ3pNDnyopKLaVwjUjm1MNgXiOUSGseRgS/OYjfYnuzcIz
X-Google-Smtp-Source: AGHT+IEVSbj4N/MbrsW6K8oMTUe9Ep0ZDRXJANdhxTbhGVMHsx5G+exPV90ghbA9Fnsls2tI6n4zBw==
X-Received: by 2002:a17:907:7206:b0:aca:d560:d010 with SMTP id a640c23a62f3a-acb74e0261cmr1720045266b.49.1745420321590;
        Wed, 23 Apr 2025 07:58:41 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec4a1ecsm806691866b.48.2025.04.23.07.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 07:58:41 -0700 (PDT)
Message-ID: <8d644855-0d78-4d0f-85c4-b71158b819d3@blackwall.org>
Date: Wed, 23 Apr 2025 17:58:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vxlan: vnifilter: Fix unlocked deletion of default
 FDB entry
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, petrm@nvidia.com,
 roopa@nvidia.com
References: <20250423145131.513029-1-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250423145131.513029-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/25 17:51, Ido Schimmel wrote:
> When a VNI is deleted from a VXLAN device in 'vnifilter' mode, the FDB
> entry associated with the default remote (assuming one was configured)
> is deleted without holding the hash lock. This is wrong and will result
> in a warning [1] being generated by the lockdep annotation that was
> added by commit ebe642067455 ("vxlan: Create wrappers for FDB lookup").
> 
> Reproducer:
> 
>  # ip link add vx0 up type vxlan dstport 4789 external vnifilter local 192.0.2.1
>  # bridge vni add vni 10010 remote 198.51.100.1 dev vx0
>  # bridge vni del vni 10010 dev vx0
> 
> Fix by acquiring the hash lock before the deletion and releasing it
> afterwards. Blame the original commit that introduced the issue rather
> than the one that exposed it.
> 
> [1]
> WARNING: CPU: 3 PID: 392 at drivers/net/vxlan/vxlan_core.c:417 vxlan_find_mac+0x17f/0x1a0
> [...]
> RIP: 0010:vxlan_find_mac+0x17f/0x1a0
> [...]
> Call Trace:
>  <TASK>
>  __vxlan_fdb_delete+0xbe/0x560
>  vxlan_vni_delete_group+0x2ba/0x940
>  vxlan_vni_del.isra.0+0x15f/0x580
>  vxlan_process_vni_filter+0x38b/0x7b0
>  vxlan_vnifilter_process+0x3bb/0x510
>  rtnetlink_rcv_msg+0x2f7/0xb70
>  netlink_rcv_skb+0x131/0x360
>  netlink_unicast+0x426/0x710
>  netlink_sendmsg+0x75a/0xc20
>  __sock_sendmsg+0xc1/0x150
>  ____sys_sendmsg+0x5aa/0x7b0
>  ___sys_sendmsg+0xfc/0x180
>  __sys_sendmsg+0x121/0x1b0
>  do_syscall_64+0xbb/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> I'm sorry, but I only noticed this issue after the recent VXLAN patches
> were applied to net-next. There will be a conflict when merging net into
> net-next, but resolution is trivial. Reference:
> https://github.com/idosch/linux/commit/ed95370ec89cccbf784d5ef5ea4b6fb6fa0daf47.patch
> ---
>  drivers/net/vxlan/vxlan_vnifilter.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Oops, yup. Thanks,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


