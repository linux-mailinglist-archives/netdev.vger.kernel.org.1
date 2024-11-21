Return-Path: <netdev+bounces-146606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD989D489A
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E600B238C6
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB561BC9E2;
	Thu, 21 Nov 2024 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbnhOXkb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E641B85CF
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176935; cv=none; b=BzthDJ2jayWW+Xjs53JatBIybxictClWpIfHOcXmUVvtGoAGB7dY5Fl/F/pOksXUuLXwxnf2fFWr//FPUD7Sqv493oAskhAyBWVPYj1a8DDVCVaAZyuVK6iwGmofb+UmklvrK4utQSVd+1cOw9C3cisAdbAB+/aaGDA+qgQX7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176935; c=relaxed/simple;
	bh=vx1+AwLU4UsvAMyNOFMRQ4EEtvnDkA2FBnIl/UudUDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzXxfIYsoW+POojJz4YA9+Pb1S4jITTKc95Ak+E05ZLlcHqbIqafSHWNPlzqWdxmIwIp+8ne2bpw5ChYKCf7C6puzF9n0Wp+78JDLOLeohwyrhKCkY7HqZXekgoOq64nMCyye2sKyBSMwyKQFTXyzx9XktSiTTQbR1owo64W7mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbnhOXkb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732176932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAru0Q7sNpk/HHsEEZWynnmCBFQAz2UJFJPWzmB99Ic=;
	b=DbnhOXkbT3bkxbJ+7lZIsHB2UY52yEd7bHq4HtwMabR9mySvuL1Fv/8X9tWgQnqLfPYy/B
	w0Xacr2tKxQw2VGwNoY2wSLvw8EOMg89bwSStwGkkMLfz/VLsMYlJx3mGgOEbNSbyu0+1y
	PqcIU9ivZA3ud3vVQBcdLKLcSipg7Ak=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-xPtNxMYeM4eWtZjW7h-NpA-1; Thu, 21 Nov 2024 03:15:31 -0500
X-MC-Unique: xPtNxMYeM4eWtZjW7h-NpA-1
X-Mimecast-MFC-AGG-ID: xPtNxMYeM4eWtZjW7h-NpA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315eaa3189so5282115e9.1
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 00:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732176930; x=1732781730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAru0Q7sNpk/HHsEEZWynnmCBFQAz2UJFJPWzmB99Ic=;
        b=mVvtC243erHzt5jogAMxtt3HGzT1w5itvLF/+jYZ1wtPipWGEMJknuYpzS4Ofd3qnm
         o/lS/wxTXIig0MY/pFTRgtTUDa52AOo06+avfWgWAOqeD/iF5Gjv6Di8HfmlzLc2yCr7
         JY9diNUqgY6yBJ3OgxLx0m/bm9lGSGxJvyHNG81Q2kpWbcVoYYDGIw6UC9TrB/BfzLME
         T2SEswddTHW6xxNothp6dmTBOtLHBiJZbFdZlGxgGaePw35INKTCJQD4Smrv/erCDB40
         GwuNiqNzBHD8iJBFqpZvBuDpd0Zo/5YexXCRX1ald2feIyRTG6QLSv4i8uwtLm/40SxX
         Bosg==
X-Gm-Message-State: AOJu0YzlDDzgQHJ7iC9F8eitZ6eHmBGkDXEm4fI8cenICkpPJnsC7fQE
	CCHY9y4G8p+su6VfnNIOhthv06iGuqMd4GJ5PH4YEjEGrZRmsRgJTXUA3OaOvneJV54AXGzEzL7
	19aEEZf2TgLkwNwj6w/KYydCCpCyjNPGJzQvttPdQ9E6TKnxf8aMMeg==
X-Received: by 2002:a05:600c:502a:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-433489a06ebmr58058195e9.11.1732176929993;
        Thu, 21 Nov 2024 00:15:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAAKP652fy4bHoCxWpHv86UZV5kyYHY85sFR0FghbNa9ObZXs7vQd2NPg/YLhM7rRCI5jfFg==
X-Received: by 2002:a05:600c:502a:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-433489a06ebmr58057935e9.11.1732176929686;
        Thu, 21 Nov 2024 00:15:29 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b46343e7sm44946215e9.33.2024.11.21.00.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:15:29 -0800 (PST)
Message-ID: <59c96191-3203-4338-9754-ac7c5ee35e78@redhat.com>
Date: Thu, 21 Nov 2024 09:15:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mlx5/core: remove mlx5_core_cq.tasklet_ctx.priv field
To: Caleb Sander Mateos <csander@purestorage.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
References: <20241119042448.2473694-1-csander@purestorage.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241119042448.2473694-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 05:24, Caleb Sander Mateos wrote:
> The priv field in mlx5_core_cq's tasklet_ctx struct points to the
> mlx5_eq_tasklet tasklet_ctx field of the CQ's mlx5_eq_comp. mlx5_core_cq
> already stores a pointer to the EQ. Use this eq pointer to get a pointer
> to the tasklet_ctx with no additional pointer dereferences and no void *
> casts. Remove the now unused priv field.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

[Under the assumption Tariq is still handling the mlx5 tree, and patches
from 3rd party contributors are supposed to land directly into the
net/net-next tree]

@Caleb: please include the target tree ('net-next') into the subj
prefix. More importantly:

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle





