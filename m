Return-Path: <netdev+bounces-193473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56860AC429E
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130523B120B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE27212D67;
	Mon, 26 May 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PO17gT8L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA6288DB
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274911; cv=none; b=GkVnMQs8bhHSW9mSzBC21ejfcDFDlIref4QGgihcYJ1fw0DNhWYW8UkE5D5nBYKYgv7rD5TtvttBxPFqHC/KCxF92ZaAdlMFJnaKhEQVe1zDZNSNP2XJNmUDK+lKvejjlourot2jwzAt3a6IlDth2PZZtK7fIZKAbTeF9n5RsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274911; c=relaxed/simple;
	bh=XcDclK2OqszwLnPAqUXdQyfcnL/MB8SOCrZHRlJOtt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TTjBbnuTq/AVK1kxDOuJJ4dBlY+uYqbCpQ3NGATG0ysEJQqLMH1QiQFcqZHDgVp32GavGzICpW92vQSxqXazfihr0KkYrgx0K3yAFPYsN8w3NvuprnCkGPMbQxjAdKlbuJu7UsfpTUVmkBr4s3aXEN3AWm8DNzQfrKP2dfEUrBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PO17gT8L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748274908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fARRLv2EAES/QT6e4xl4U/3Dyubza5vfMD7Ni6b9N0M=;
	b=PO17gT8LfJOAyEZNrPb6zaXxcO9yg5XGvcIZJHsrwYqy9EfefGDyJFdb9/gGVzh8YfmqCZ
	UyWmcoMgIJ6It5Fv+E61+/xgnBiB4aCHPYTXKF+/U8/pt/v7pjVNkPkS7oGykIG+bq31b4
	+zJJAcwITkwSEAMQSye9iJA6d9A3ZmI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-oe6cVmepOZ6HwFerRkGKTw-1; Mon, 26 May 2025 11:55:07 -0400
X-MC-Unique: oe6cVmepOZ6HwFerRkGKTw-1
X-Mimecast-MFC-AGG-ID: oe6cVmepOZ6HwFerRkGKTw_1748274906
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4c8c60c5eso1471740f8f.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748274906; x=1748879706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fARRLv2EAES/QT6e4xl4U/3Dyubza5vfMD7Ni6b9N0M=;
        b=c++ilCw2DI/YOQyADOjh41hPO87ZgWaBrVyfbMmmYBqbqfwvB6vRONv/k/brd0fW+F
         WqYep9XJZi1GUKBIkPUuF02d00ZXjD/c27Me8IaCaTAszdCpyFLnmvLOxZ7W0zoe2Ika
         kJQokgAPFDXaUddbQjKIt5ejE+4UchkWVtJvqzM5tit7U267FG/7Fl7dxVQhBLAPbvnq
         J7xW7otZvqtQjCB5g0gRfP5EpQ8FdDoZHGMJIquOMrCNR0S4HAxyS8MVbxcKJ1H4F8xP
         kWIYIPzWj1HXV281l2As/0V8wCCYKo1aRbJn2bOHfdwbZi54ULyZc0i7dgL0M05Ap1CG
         0o6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVc4XH7wTKckLa2uleMrze3eTm2UgWKRqVzlhb+ooaVZ43PwrWYjScucKRxtdZjZsGnwn2Y7Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7DNFxChxqEwCx9q0Ap5jdr/GbmB+KPQ7aXNDtmggMDYHrjhvB
	XGvVSOvVOfdc3BysA1M8/6FYy6TeGLTJ93kkgD9ZYSrGvoCvVMiUD1nnbZRemANMyYqUtP2SDwJ
	SoNgmgDIqhlORvBQax1XM9v6I1NvPZjZRaEgRR7EpA+nS8lWXDM9kZdr/bQ==
X-Gm-Gg: ASbGnctxDrf3emFKjz2PKeYzhBDUEgUhS/9K1cnYPbipWru1q00GUGQvYas8v7mk2AY
	zOUH2p4LcHOE0MyGLkRtRKyd9p25s5bXpOFfeYC0JEC25UJMlbosc0xRXO2ict8mCc1AovdsRkW
	cZ7gL6apP7yOjX4Ia3AyCVNB6pGCkU/zWDUd7qVfUkkAgSKHnZ7dMfuNKEkPx7TGQsC4sfchUsx
	Qe+4BsOeJRD6xjL0fvI63MLQTr1Jf/w/OP3IFBIIThq8fQYLPhzSRDCGkozPU27ztxG1go8tBsw
	PiEzbjYqgTogdfsx68E=
X-Received: by 2002:a05:6000:1ac6:b0:3a3:6941:6013 with SMTP id ffacd0b85a97d-3a4cb489c46mr7644605f8f.40.1748274906116;
        Mon, 26 May 2025 08:55:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEniW4Fa0wQ5QCsDtszPeRRxDRH9P02gatIOFzZCMuokpVnrSJPxMGRC37ySpxpVr8XiaeDXg==
X-Received: by 2002:a05:6000:1ac6:b0:3a3:6941:6013 with SMTP id ffacd0b85a97d-3a4cb489c46mr7644577f8f.40.1748274905760;
        Mon, 26 May 2025 08:55:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4babec83csm14730739f8f.80.2025.05.26.08.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 08:55:05 -0700 (PDT)
Message-ID: <edb8881d-0cac-4f7e-b358-299bb30b5f27@redhat.com>
Date: Mon, 26 May 2025 17:55:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: mtk-2p5ge: Add LED support for MT7988
To: Sky Huang <SkyLake.Huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250526091019.16096-1-SkyLake.Huang@mediatek.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250526091019.16096-1-SkyLake.Huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/25 11:10 AM, Sky Huang wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> Add LED support for MT7988's built-in 2.5Gphy. LED hardware has almost
> the same design with MT7981's/MT7988's built-in GbE. So hook the same
> helper function here.
> 
> Before mtk_phy_leds_state_init(), set correct default values of LED0
> and LED1.
> 
> Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.


