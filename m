Return-Path: <netdev+bounces-195197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F162ACECB6
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 11:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A70C1746BF
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A9440855;
	Thu,  5 Jun 2025 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsJLVCHG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3320C005
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749115185; cv=none; b=swPydiIrfMHE717VGpKpnKd9aAB/2toYHsAScB3IIfAmaSt0oYzsMuGe/Ye1U7r7Ot9Iovt62aGaR7OO+GGWlTqgrms+aVRfCozKUsFgYpdzOFydTGTs8uI6TVuXkGb9q0h642ITOPImIIUMHPr61dBtWiUTrbQzDnT212CIlJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749115185; c=relaxed/simple;
	bh=Jna34DJuIz4lYrqaZp7xKG5CCFB0I/HmBOSFfw1c+x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERrgNpk1Fo7Anz9NgWCpod0HvsZkK0jFMnhwPGXTknEBLD1VUIWaXfmiMp0/9mcJuY1hedtyr4ozt7v2yzHQMihAuQV61pJAOOLdWpvJc7fq4Ngf+ou/Az3Rnhq+1wgnunvwh0PCAOxjmJJmG8n2+OpIqfd6xzxx/4aJ/F1V+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsJLVCHG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749115182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbvOWE1CNUocL1BEc3ljc1g1zxTrUZmYCXxonJr+pKM=;
	b=bsJLVCHGpBkXZzEwJKf50nuTmbDluKAfBvfnvcfpA5DImRDYoT3sF5QU5dbx14Fbo4t5O9
	nYQooevfsQT/yBJZnRc8GyNSj/Xfvw5//sopBcCkHqk8GabBkU3oiqj5VIp/Lid1usgCfd
	h3qMjo+/gByqn6aDucssNbqJ+4CbjW4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-cOaG-EtVM7aB1JqQL8-ZFQ-1; Thu, 05 Jun 2025 05:19:39 -0400
X-MC-Unique: cOaG-EtVM7aB1JqQL8-ZFQ-1
X-Mimecast-MFC-AGG-ID: cOaG-EtVM7aB1JqQL8-ZFQ_1749115178
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eb9c80deso324575f8f.0
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 02:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749115178; x=1749719978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbvOWE1CNUocL1BEc3ljc1g1zxTrUZmYCXxonJr+pKM=;
        b=Cy52fYFFx87mzR27JKY2PMr4VMg3HqDNictJMw3yHMWLIERKMCHwjb82bsajJvwO9s
         9pHrhLwEmhwJyIy1o+2sI1ihWdBDK246C76fqJORtY5+a5eoMQeQ0OkF+4+xz59nvuhm
         xr+Ngyl4trlx3JvzatSzd/VcEpaRp++2/4hILqPmAzLkvLqGDoyLYzPHdmU0DzQFU2dE
         O8s/7PZ+gEDEyApOtEg/QnsYg+ysvr7x2FQb9FBcE+fe57yc0i8oak4ofO+PUP/S1QU5
         O5eh/pmoqwuRpoA3leDWmjWidmE1mob1/oWDLAuFNrYhKaLqeUbytkae3vbK5+VA73RR
         2sEQ==
X-Gm-Message-State: AOJu0YwdJVtXHbXt/GXqjD0ahS154rcDkNftlnh81Hn0PschERTmppdg
	aiVM8AkkOAw9sXNj1fgV6jxSAYE/JePB5GpZHT3A2HSkOcw+L2tyPXaGb5e/VrgwdGh9r7F1UtJ
	aR0K8Xtx7p5YmJzfHPA4MMFL3X1KaOTiWWVdqS0W1Qjs2mkGUbhROREid1Q==
X-Gm-Gg: ASbGncuHgD543tT4zeTzUehk7A8d5LiPo5UYXJzIQHfCWSpwN6YGF0rVkZTq5ik/PJH
	6cGLH3yMVGBQgeYeXcSHmYJdpVQPDFZCIvCaEaoQojJkYr1VSi0XcNplHHZxolnokA5/TAKib19
	ZzAdbarDNG8vT9hWEE0gbfLagb0I5ItsvLUxmGN2QLQ1Re636etr04cb8B+Zv4CNAyJSUdm/IH0
	lwKUHmYyFx1nYkcFK/GtY7iUIhaudXwmrt1DBS4LEI0yRNKafO6StcYQlSScDUbGM3R0r5kF2iS
	qnxjzp5MIoMjA60/NkI=
X-Received: by 2002:a05:6000:2901:b0:3a4:d6aa:1277 with SMTP id ffacd0b85a97d-3a51d96cfdcmr4632404f8f.37.1749115178512;
        Thu, 05 Jun 2025 02:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiVIWKhvMhdKbM6hBmvDr6wXdqFF9eZ53YO8jtw/IL68kmldCR4ynqhTKRPPASOlhqnJbzTw==
X-Received: by 2002:a05:6000:2901:b0:3a4:d6aa:1277 with SMTP id ffacd0b85a97d-3a51d96cfdcmr4632374f8f.37.1749115178007;
        Thu, 05 Jun 2025 02:19:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cced:ed10::f39? ([2a0d:3341:cced:ed10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f0097210sm23909436f8f.73.2025.06.05.02.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 02:19:37 -0700 (PDT)
Message-ID: <0d96b03a-e0a6-4277-b8e7-a6d9373539f6@redhat.com>
Date: Thu, 5 Jun 2025 11:19:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/mlx5: Flag state up only after cmdif is ready
To: Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Moshe Shemesh <moshe@nvidia.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250603061433.82155-1-zhaochenguang@kylinos.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250603061433.82155-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/3/25 8:14 AM, Chenguang Zhao wrote:
> When driver is reloading during recovery flow, it can't get new commands
> till command interface is up again. Otherwise we may get to null pointer
> trying to access non initialized command structures.
> 
> The issue can be reproduced using the following script:
> 
> 1)Use following script to trigger PCI error.
> 
> for((i=1;i<1000;i++));
> do
> echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
> echo “pci reset test $i times”
> done
> 
> 2) Use following script to read speed.
> 
> while true; do cat /sys/class/net/eth0/speed &> /dev/null; done
> 
> task: ffff885f42820fd0 ti: ffff88603f758000 task.ti: ffff88603f758000
> RIP: 0010:[] [] dma_pool_alloc+0x1ab/0×290
> RSP: 0018:ffff88603f75baf0 EFLAGS: 00010046
> RAX: 0000000000000246 RBX: ffff882f77d90c80 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 00000000000080d0 RDI: ffff882f77d90d10
> RBP: ffff88603f75bb20 R08: 0000000000019ba0 R09: ffff88017fc07c00
> R10: ffffffffc0a9c384 R11: 0000000000000246 R12: ffff882f77d90d00
> R13: 00000000000080d0 R14: ffff882f77d90d10 R15: ffff88340b6c5ea8
> FS: 00007efce8330740(0000) GS:ffff885f4da00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000003454fc6000 CR4: 00000000003407e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call trace:
>  mlx5_alloc_cmd_msg+0xb4/0×2a0 [mlx5_core]
>  mlx5_alloc_cmd_msg+0xd3/0×2a0 [mlx5_core]
>  cmd_exec+0xcf/0×8a0 [mlx5_core]
>  mlx5_cmd_exec+0x33/0×50 [mlx5_core]
>  mlx5_core_access_reg+0xf1/0×170 [mlx5_core]
>  mlx5_query_port_ptys+0x64/0×70 [mlx5_core]
>  mlx5e_get_link_ksettings+0x5c/0×360 [mlx5_core]
>  __ethtool_get_link_ksettings+0xa6/0×210
>  speed_show+0x78/0xb0
>  dev_attr_show+0x23/0×60
>  sysfs_read_file+0x99/0×190
>  vfs_read+0x9f/0×170
>  SyS_read+0x7f/0xe0
>  tracesys+0xe3/0xe8
> 
> Fixes: a80d1b68c8b7a0 ("net/mlx5: Break load_one into three stages")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

Minor nit: the 'net' tag should be in the subj prefix, alike:

[PATCH net v<n>] mlx5: #...

More importantly, please deal with Moshe feedback.

Thanks,

Paolo


