Return-Path: <netdev+bounces-237959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C6BC5203C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77413A6AA7
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B2A30EF71;
	Wed, 12 Nov 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjVdOQYk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB430C347
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947037; cv=none; b=o2v2Dxp/8eUOalAliq3j2GpUKsrE+u+X1/Y25vGF4BpjZ+TDv4XuIw7bWVAcbT4s5XXpKpD8byANhTAr3CbfQLMKNJD6OmmBCs+F1WGZOvjhXuG9beHKEIhv7EbQl5QbbMPSjRacmyvMJyey6G/02RWuhjUArincIf1slFd3KqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947037; c=relaxed/simple;
	bh=iTAh58xsSTK/DPrCrA9XXO9oOUT/gyUSwdPtMZDZRY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STvXr1VDi7jlEm6VGs2IA7ttLxO6l2P02kUu7I4TCLOEbufUrPwEGAi4ynqwuIM4YKdbQdNu8glS4yrq6YYl4YIbKMdAGXIVF/KE5hzZ9SlgYvGn5D9FGBTJsOBVXMmPhNQ9PQYgL4JPy8km1Q4pQOHE4BkkOMeErWHKR6lY8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjVdOQYk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so5145455e9.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762947034; x=1763551834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l/oUH46h86/olGMZU+XghYpDhfAZ96DwWr356lECM4A=;
        b=BjVdOQYkNn1GugyEtpXSuZbkJ+6NMebvOiOl+vQATSk4DKzy9dP0IzIfF7t7DTxIc0
         h79Cayo4rd1tZHnm3UF6iP16NquA/XmQD1sqR08B0brtBRUm4ITnOXvc+1xwtwV2k7jX
         IqISyf0r5iDNq2JTyIpuefvmlX6xXMDkd9TrEWPtwqTgWsn4oyqRRTyIYNo4RHtFR6mP
         09DYULt2CWaTGcv8PemxgkCUZjwV0kIiNzt5YSy402YM+Flyd34wvMhjIH7WNREJLZoB
         3ZNkEHdsDRfFf3C6aBNo8t5pZGT8AXJXDZZepxyvwuUsqBbgn11CFPp+iptlcxfzy8jr
         FszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762947034; x=1763551834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/oUH46h86/olGMZU+XghYpDhfAZ96DwWr356lECM4A=;
        b=hW3acGOTbvEQadPq7yssqLcXJb+tadagtuemd9EAqIEhbP0KEKG7FsDWeN+ON8nefR
         aY2UX2GqiwEWt/KRRZ45Rv5t1PbIq1b6taZmUQaqqLTFE31WB4TqhPeBmwG7C4oGSYyS
         wnPmY5mOGBJfnIYX9rJ8gk2HunYYKGK0jASTG33haRzMYYuRI6HpXiz3reNzpe6xpkuq
         Asr/7VrDP8Fr+mm8ST3ilTJLYAPZLQH48B6kx+R/UOobX9dpR/+thoqyYZODY+gztpWk
         Oe1Wogo0WyGgvNCvfh7rQENf9Rf0oX8ulLN7QwLcqVeBUUHOl4LIu8ojrQcstKOSV9IG
         874Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEtWBRg+65ggfmKGb3qk8DpP7QsUZanchyXx6n3rz8zOA8ZGpO8KlxbR2+t2eUeftGhHdZjvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbjxIpxMHCm53pIGURJiZxe481xmruVr9dUwwrTV0Rb8dah0D
	VnOLgUsj0I94oZEnumYbR55NGRjORivEF5UO9bjt3zO/I//gONIU+UH/
X-Gm-Gg: ASbGncthj5cLxEYviy8dIoPu+eE5QeY3Wu9vjrRLmZhFxDSR9pjNB+Clxpzm2X+/t8b
	UOIXxCF8/O8OebjqirWBEsMap5e48hpDqf6yDEW2p5Rj0V0Tgdz6P5CsOkIVDYq0MQwjpS0kIaK
	1JEJw+bPtWbTcK84G3FGXQQwxYMGMsIA5xm7g4IPCG6WsFTfdVUDAJ5qRJKVaH7vtucSMSp2lCz
	LMPJhWtYb67+Ytb24XOam3cbuaHnvouaNquEm93ywDa7mBr4umEoiNswhM8sYVPYcs+KMI7IdAD
	4umIg3D9t3EaNIM0gsOH7Sw3oijvBa93jwfbw5JcDTJ61qFIsLbtgSLKn7lnKxeY5r2k4UXKyBx
	zdXwl0VvZXFta/4XRy6BaZeFt34PnU6RcKYZKCthmbpSD39K17WXELoRuV43ZOHB9fLDs5lkuy6
	CIZ+LxV5KFzqUUENEck17FZpU=
X-Google-Smtp-Source: AGHT+IFzZn82+HqmV7Z5oaduLfvBaDy2CYnyKKDWs/rhY5yLhynN3LzPM9CdU2cQ0vUhoC+2FQjWgA==
X-Received: by 2002:a05:600c:4f93:b0:477:bcb:24cd with SMTP id 5b1f17b1804b1-47787095d98mr24817395e9.22.1762947034215;
        Wed, 12 Nov 2025 03:30:34 -0800 (PST)
Received: from [10.125.200.88] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2ad4csm31122115e9.1.2025.11.12.03.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 03:30:33 -0800 (PST)
Message-ID: <89e33ec4-051d-4ca5-8fcd-f500362dee91@gmail.com>
Date: Wed, 12 Nov 2025 13:30:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net/mlx5e: Speedup channel configuration
 operations
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 William Tu <witu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>, Alex Lazar <alazar@nvidia.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
 <874iqzldvq.fsf@toke.dk>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <874iqzldvq.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/11/2025 12:54, Toke Høiland-Jørgensen wrote:
> Tariq Toukan <tariqt@nvidia.com> writes:
> 
>> Hi,
>>
>> This series significantly improves the latency of channel configuration
>> operations, like interface up (create channels), interface down (destroy
>> channels), and channels reconfiguration (create new set, destroy old
>> one).
> 
> On the topic of improving ifup/ifdown times, I noticed at some point
> that mlx5 will call synchronize_net() once for every queue when they are
> deactivated (in mlx5e_deactivate_txqsq()). Have you considered changing
> that to amortise the sync latency over the full interface bringdown? :)
> 
> -Toke
> 
> 

Correct!
This can be improved and I actually have WIP patches for this, as I'm 
revisiting this code area recently.

