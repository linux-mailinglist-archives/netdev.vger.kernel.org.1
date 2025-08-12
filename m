Return-Path: <netdev+bounces-212910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED80B2278F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6532627D2A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E8627934A;
	Tue, 12 Aug 2025 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyI0Kw2l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C01277804
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003269; cv=none; b=r3cgQGTMsfMfEyDPjCyC1xmE8LlshIF8PMVivFs4gUwJ34phnpEa4IW/xCcdUt6sc23mZCb1yxPhhUnOZ35Phm4qS2anxLPdffNgQ3vFAAoPiTF8uEadBbfWCUMdx5xDTQxALZeSYgKaka9LEfdTiIaSKMnwN8IXd6Lp9Ms5SN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003269; c=relaxed/simple;
	bh=ODpyotMqbR19gg+oEM80+cCkM0ODDUkNV/2kT+hopxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQ+fgcUUqVF7+O36rhV2II8Rb6QWFZB+q9L6onL+Akbnll6mUcV8w/U3qL3nBWys/2yqMEaMDyZ3ZNUjBhFWe0UiaOohiGMK7CxLlxK36EvRQajOM8B/8HwAFgLa4X0eh0wGuus8Nnr85p97pVVyv2K9eyfQA+iKhyHgi1qYsno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyI0Kw2l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755003266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRwZCYRsxjvJxx5GllLV801jS3kCOXiKfQ2tbx5q35Q=;
	b=DyI0Kw2lj+PTRNAJ3wUdHaxfM8rJgxIEbGH0bvbrkNQ2qejA0e0wBs14QE1gHAPC8Wt1u6
	cwqwp5OG0+ZpGEpgW3b6VAW5hQHPfg2FzzJfiwh2iUoQBU80Y6Bn6NuZGF1D3ajjGQsqCa
	TxVOZMdivsq/VPsZraGfHd7KuJYpST8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-FsrajXvNPQKb3lpEmHnp8Q-1; Tue, 12 Aug 2025 08:54:25 -0400
X-MC-Unique: FsrajXvNPQKb3lpEmHnp8Q-1
X-Mimecast-MFC-AGG-ID: FsrajXvNPQKb3lpEmHnp8Q_1755003264
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7892c42b7so3718641f8f.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 05:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003264; x=1755608064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRwZCYRsxjvJxx5GllLV801jS3kCOXiKfQ2tbx5q35Q=;
        b=qAAArFMKmtb0tXAGqit4Ws67C7NZbavhGaxF8zzfYv1JjrBIGfdQLJQDQiyHONRoHG
         lRI851R03+SewnahmdNXzRaoo0uKrscmmTWj+J6lb10lJV+6abz+1HJRVgOV7pGBcU5i
         eVnclEKyRjtbMXYyQ9n3IpRRfnWykwoDzp41IoeYEHz54lCYdO0LJ6TXLECqrBdTpCSL
         OQzNKP9oPHiZKefSv/Yb426Z3PWkpT6IVl1IaBC7MWYRc5x86kfLBR6HUF2H/cTgNDbX
         8RPE+vqVdRRw8VdQR739QVDFEVUEeRFB39HWWASyMScUw65fY1rH9jQe49jqcGDPP9Si
         5XCw==
X-Gm-Message-State: AOJu0Yxpw4WgZ374HL4cePIriy5iCl+gHuK0qP2jKhB60As0syatG0I/
	/rXsuEjJW6rk4yIFeUxefxXWd58F5madyI/YZRMO0bJdpq2oZoXdUavT9asdbh0q32TnTNUIiNY
	+zHzrIFxRyhqXuVvsxcWBWT2To+HI4aM0SIwpUIRkY9z4gMZJ3uy5NmZ2sQ==
X-Gm-Gg: ASbGncvoxNwDmkFJkXVm3bjkZW+Zwz3LNA8/a9ZQpOftafN5W3keYHknXk2mA5+dTWg
	AP/CiG2hP4W3f2n1b4sN8jFwe+oPvywnjTsT641qRZmL5HB/FziuNWb7glB58YlM12dl0AmEgns
	GKfSq/X10kEod58B0LTq1qdlUIlrRsBFWZ88Z+DJQIwq3LFl7ROtxbeeJIv2EU7DO3+bQuFLW34
	Xhgr9LL7cUY7ZwXZcrizFTsXIcq5gwD1GDaY88/hnSKEeYY3ql0apBjeWiuoQyNYXHGa7KjdZTW
	M/Yz07O23lFWZ3tVpwgt5I+/GoKvod3hMexGJp5wLMI=
X-Received: by 2002:a05:6000:2502:b0:3a6:f2d7:e22b with SMTP id ffacd0b85a97d-3b900b4f08fmr11620936f8f.18.1755003263970;
        Tue, 12 Aug 2025 05:54:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFERWBxAhdG/9H6I4uUmTqO1UoV/PLVlBD6GvON7ihQC9dnpd6IAbGFKbO3xw56aaR9q/kStQ==
X-Received: by 2002:a05:6000:2502:b0:3a6:f2d7:e22b with SMTP id ffacd0b85a97d-3b900b4f08fmr11620919f8f.18.1755003263540;
        Tue, 12 Aug 2025 05:54:23 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm46464914f8f.9.2025.08.12.05.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 05:54:23 -0700 (PDT)
Message-ID: <194e4774-a931-4ce4-af63-4610da7c4350@redhat.com>
Date: Tue, 12 Aug 2025 14:54:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: kcm: Fix race condition in kcm_unattach()
To: Sven Stegemann <sven@stegemann.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+e62c9db591c30e174662@syzkaller.appspotmail.com,
 syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com
References: <20250809063622.117420-1-sven@stegemann.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250809063622.117420-1-sven@stegemann.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/25 8:36 AM, Sven Stegemann wrote:
> @@ -1714,6 +1708,7 @@ static int kcm_release(struct socket *sock)
>  	/* Cancel work. After this point there should be no outside references
>  	 * to the kcm socket.
>  	 */
> +	disable_work(&kcm->tx_work);
>  	cancel_work_sync(&kcm->tx_work);

The patch looks functionally correct, but I guess it would be cleaner
simply replacing:

	cancel_work_sync(&kcm->tx_work);

with:

	disable_work_sync(&kcm->tx_work);

Thanks,

Paolo


