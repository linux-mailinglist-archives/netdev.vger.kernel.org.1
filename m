Return-Path: <netdev+bounces-89862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D018ABF1A
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 13:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0131C203B5
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 11:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB32F1119A;
	Sun, 21 Apr 2024 11:47:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64402205E21
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713700057; cv=none; b=SQsMG2Rvg7ymHaHTK2zxyfulcEC3LcuQc2KIp0QUSA2baZmHntuDxtJmQzTHwT3VInQA4qO8MpRHr+1DhMGdTbTgLINhDKvwXHNRKNN4nBhnS9XvDhUPSMszoe/qQ5kbk/UCQFZZzcNrylt07ghouEDc4dzCgyG/ZWdXfldZtq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713700057; c=relaxed/simple;
	bh=aP1TO29NBuXe5pCqpYD2RdCc9hERIEFGZ3g4zELoWNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0PVM4USt6GmXlHoDfqYQr0PbLjBG5dV6vBE+u9R9ahFFBC4/bMbFDZVJmkEPAbe863a9kav3ahGEQzSnuoW/J/4L65fYLyKNYvATPJcl3RZ8A4C/UotZltCynJm3V09HqxxsputuceJ5Ej+EAhn+Evv6CxPvGeuEdv+JKGbz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-346407b8c9aso954968f8f.0
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 04:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713700055; x=1714304855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAO6uAdXhRWhSWqz75cahmrQkh7UglWpv3HCw64aE+A=;
        b=oZPNTpf5eNtlSjmArRJcrZS4wy/84BjeeSl2mdzdwpH+luq4Ra9SLUW7U3TScSlXBT
         Er+CU49KMO+IdzAbDPbmLfkotcIFymndWhwKIG0yaK3nR6+UxA1wejFvvrmra+LVvkaW
         9/13CkCag72ZHVRAkh6Qx3szuKohhRYe83Jk6w2896v912vjbUgJls+6GJa+r/MkBNCm
         ljYVlNPZWVbstdJf6Fh4DjwZxkjxtE9sp7p+Vnt9r00muOlZ5IjGqADBbfQDF9FtlBRr
         72PuGoUKJQOZaRvCu9f85pCNvHgetp8YmvmLavH/fcYl4HXrgiBNriTvy5srTOOvDo1I
         52Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU5H+5b51ssPa6h9fKRD5pywyivBTTizA3R+ORnX/X7SxKHWR0taUgO7t9KO/KnC6xbwJHRQtO7h7nlEMhncMinW5fmlIYT
X-Gm-Message-State: AOJu0YxsurJdgcZch7sO0TYo841TKIs82ibKYY4LrxTU3tvcIgwZ3NXW
	ReZle9Q20q7cV5wqTiDaoM/CxZmSmbdfe2loYFjk0kA+I6ieraXH
X-Google-Smtp-Source: AGHT+IEYsKwwjclRwSZQ+wz8CcVL0uOlw9TVDRYNex6MSArZhtkZpO26JNCiL2dcx2Jn/fOIw62hTw==
X-Received: by 2002:a05:6000:369:b0:349:fc93:1d9 with SMTP id f9-20020a056000036900b00349fc9301d9mr4706458wrf.2.1713700054707;
        Sun, 21 Apr 2024 04:47:34 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b00346ceb9e060sm9078419wri.103.2024.04.21.04.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 04:47:34 -0700 (PDT)
Message-ID: <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
Date: Sun, 21 Apr 2024 14:47:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 01/20] net: Introduce direct data placement tcp
 offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-2-aaptel@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240404123717.11857-2-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> +int ulp_ddp_sk_add(struct net_device *netdev,
> +		   struct sock *sk,
> +		   struct ulp_ddp_config *config,
> +		   const struct ulp_ddp_ulp_ops *ops)
> +{
> +	int ret;
> +
> +	/* put in ulp_ddp_sk_del() */
> +	dev_hold(netdev);
> +
> +	config->io_cpu = sk->sk_incoming_cpu;
> +	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);

Still don't understand why you need the io_cpu config if you are passing
the sk to the driver...

