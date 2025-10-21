Return-Path: <netdev+bounces-231156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ADDBF5C12
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15933A4A0E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80CC32038D;
	Tue, 21 Oct 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7l+S0x2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEEC2EFD91
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042168; cv=none; b=WCwWol6nbqwzaDbKwzPTztzrQ6KsSOj0KggDbusTIf2pb6gU4PJ5rKuZb7XbntHFkHx61uU2DU8bD2G1byql0pqcwxAxiKiE2JhjobmXZtR/CUkOyPphkqkvyn26UFiJYFSR849kpVllVVBoND5881xosMK5NQKONawCqlFV//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042168; c=relaxed/simple;
	bh=1A0W5xTaR9urVjOjv6uluJypcpD+sjwXrvub4CJRLF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGp9i0AxvjQ9enLrcxWagVzKbj4tlWiXXKCA9H4uQk/iWWkBat7Yn8kzA58CXrvJWx3L4Gn4BU4WxgqORIUgFhmcfsCIRRDISvfFi7y1BkSuhk3y9HUz11fTCOrOC/a5fUFEF+MWDai93ehO+t7TyVQFZbexQKPrCpscNtOkeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7l+S0x2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761042166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nS+dBBoi0CBgHRidSyYtoXbkkZV3ymvifoheAJ29ALs=;
	b=g7l+S0x2+z7tPmySDEkiAVOPOhbBr8bsBol3s58NtkGuwdf8WuyM/lyZNPehME9HULwonJ
	aqX1f2iyfOHEKYplcWTwohDH3h6MWq5CQRGKfc2bkGuO2zfeyObL5h30OHH9yEojiPeScc
	2nirMPJHb32mWYhbzsOGe/qKRGp6Vnc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-akfATHr_O1G3tx-9auoEwg-1; Tue, 21 Oct 2025 06:22:44 -0400
X-MC-Unique: akfATHr_O1G3tx-9auoEwg-1
X-Mimecast-MFC-AGG-ID: akfATHr_O1G3tx-9auoEwg_1761042164
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso33943495e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761042163; x=1761646963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nS+dBBoi0CBgHRidSyYtoXbkkZV3ymvifoheAJ29ALs=;
        b=WP3ypHSfEO9lkcTX+GzFt1qL1O4Ge1RJDqWqGmRTPT0RakOw/IWOGWmhRuvIVEaJ6o
         2CfP4M6Ke7etF/Ird1vVRwCV3XS67tQ5IZn8/UKP/bWek+bv1LTjP5egE8IDEUOpEEdE
         yXvdZEdDfz8QB7Su+DLJ1xS9nd7dPjaKwSAKOn62vhal/DRMw9Eaw9ZCDIE+vDEwgsiP
         nkA0DpaYmQAfMB6d7+ZsO6uRFKYzYl4CGj1yjx7f+GP1aLpYxQYoGkpWgKVl/xJJID6s
         35dcbTR5RBI4l8xnTuFZd/cFLT6SWk92E7P7CCVh2XRQXt+DGz5nokR/0gOwa3DQQZrX
         WGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrKMnaKoIYxVox5YfBtD6bNfhVkgKIRExYYjxmz4Nhw7Z3+bwEblCB4TgWlB/xjuCnSUfBMGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH8VzAGBRbJBHLXjlpdwAi2rVi3Vgs0qrQmEKE4+TDupbVDYLM
	DndJj6THpJPDSBlcLAaLzlPrYtgvt2HHA6LBOnQpnYpYrN8y4FHuN84ssFP/JGAY6/4E5X2AceG
	5FyoydQDs+pLdJUAOZZJRiZ803lv7x2jXTBbcrRQhR338khqCQBYvfQ+piw==
X-Gm-Gg: ASbGncuIVE4HIPIp+M63iDjqB9fdOivG745IFcqdM2I1BkczBBEj5tHu9L3a7Maar1r
	5Ia1k9V07hAp/ZSJcdP6ZAWqWeTlqMgXnSZcvXtngho4dAkfVsYL2DjBftV5dmiMCnuztUela2O
	oClffNKdzEk+79L82sRUejra4Wx247ThSPuIVJ2hnttyg7KpGjUFBc+4W6Yc7duMaiiR71YVTCj
	kVODa7TTJvNQy6X7lVOviCG/Xl800m52QRTk+z802bAOyiMBmkGwkLKgQlfvf+VpdzsZWtkzFYf
	FMb8jADy3XOx05xUir06HIPo2lCnJJQSSzLeToikNyQzkmGpF2KleScxjLMWMVjCYukskEWUYnk
	HNaZ4isdAHQOBLimW+tA1UaEA37lNJwhQZTv3NRfP/WpkfW0=
X-Received: by 2002:a05:600c:5026:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-4711792a680mr122675185e9.36.1761042163604;
        Tue, 21 Oct 2025 03:22:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6qZ5b7OU/i07O/ltqiS9RbHNjqlvAjVcXuc/1BRt53UhZ8fu0lXE5nlb4ZYhwCLUDcfMkpw==
X-Received: by 2002:a05:600c:5026:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-4711792a680mr122674895e9.36.1761042163195;
        Tue, 21 Oct 2025 03:22:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711c487dfesm268791525e9.17.2025.10.21.03.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:22:42 -0700 (PDT)
Message-ID: <e23988d5-4dc9-49d0-ba42-c3d1cbabda26@redhat.com>
Date: Tue, 21 Oct 2025 12:22:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v02 6/6] hinic3: Fix netif_queue_set_napi
 queue_index parameter passing error
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Markus.Elfring@web.de, pavan.chebbi@broadcom.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>
References: <cover.1760685059.git.zhuyikai1@h-partners.com>
 <c4d3c2ef38ab788aeeb7a7a7988578eb2e70ee8a.1760685059.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <c4d3c2ef38ab788aeeb7a7a7988578eb2e70ee8a.1760685059.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 10:30 AM, Fan Gong wrote:
> Incorrectly transmitted interrupt number instead of queue number
> when using netif_queue_set_napi. Besides, move this to appropriate
> code location.
> 
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

This looks like a fix that should land into the 'net' tree separatelly
from this series, with an appropriate Fixes tag.

/P


