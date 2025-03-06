Return-Path: <netdev+bounces-172411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5964A547E7
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D21F189165E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1E820102E;
	Thu,  6 Mar 2025 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5W3Esqg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45A1F63E1
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257416; cv=none; b=oPrD6WlhOaLK/TN1KSY3BAcVwnrcvblKsXwEX3mAj6dsOy1CP6BK8EEUdLHPy5AAczbHCVNXAl1q9TFtgbAwJKa1pNy2iddrxv0o4nP24KpkGT2U2ICGcslzmaaL2V6JB+WCUqau4nqQEV66y9RoMFuvBJll5zGZg1/zND31Oqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257416; c=relaxed/simple;
	bh=eIviFgFwPx2HwSUMq5kkwtsNyVo5QezffE+/FRZmj/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEFo5z4MovwQh4jxEhTXZvXTGcLG9j4tUFsJTbPoXnCb9Eb7xownG5px3v95FsUaBkTMi4HY9lK2bydndmbqInvw+Y0UiCqvqWmlcCC7FWp/E9QZdVCYcTMadkR8ulfnZKdY3A5tOE5IpHPSqh3lIXg0U8L9ea9FMvtDR9fF7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5W3Esqg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741257414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnglbAYEIKKaWGbc5/Ze6UFS6cRYwDkRCxuVuAD5S7Q=;
	b=S5W3EsqgQZWGbrnnCDd3M/6tToecFtTiDwMvoYptk9ewD7OR92hWtnplpvJ4D0PaLX3y3f
	2S3DDoBg68B0Vxt7E4JIgyHYMeij2qw8usO/MxaWqWbjaS4hir1j+paZNt+X8HPJ4klut5
	Zb07Or2NNFwTXjFcvKuKMqdCSdxyyjU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-keErIhR4Pm-l81GsYyHNCA-1; Thu, 06 Mar 2025 05:36:38 -0500
X-MC-Unique: keErIhR4Pm-l81GsYyHNCA-1
X-Mimecast-MFC-AGG-ID: keErIhR4Pm-l81GsYyHNCA_1741257397
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912fc9861cso48044f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 02:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257397; x=1741862197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnglbAYEIKKaWGbc5/Ze6UFS6cRYwDkRCxuVuAD5S7Q=;
        b=dXBF9uiTRQqavr7rpiVBKXaxN2QGI3YXUP3/TIEibZFEfg+iOQmCyDSvd4k1znRVPo
         qncxzewsAgebyc7CTzNT8ayQ46hEQodC/zZC2tOduhqQCR0w7o3Z2vHUj1FhksUheo6L
         zF0Ho9FvXbYYIkbHb7vO3g2o0rNihgcI81pXAuSFn1XUVvMl58wFeV3OaOfde/Dx2jcq
         sh4FGW/vVuNRMs8z/i2q6E2k+NJWON0NQwinANVR/ARuiCYa6DKjglg7oaDFbyZyfCt7
         lYIe12mefjuVqvFn/tRsdrTDrZod4/Ti72mbuwrFyTVtIw/HQYHZRSefYOY4ToBvhbSV
         ulHg==
X-Gm-Message-State: AOJu0YzRiJbpWZutqJeEMgzSlk2dAt9S5TkHbseLsisldQdH1Sz9Y7tR
	93q5A6N6ljPSjx0M4fXw8bbb9xWdSO/v7XK4h7grFzi837RXYLj8NbfoH0OFURskbeATpdsM26G
	XM8zyiTLYBHxbG/tJ0TeVtsPOPhBlVddTD8n5SaX5hZnsTv1TpVspnw==
X-Gm-Gg: ASbGnctSWUjnAAK4HNMzegGwaFX/17qGYb8oildmfS0VdXao0icQRLtCC7ayoaDuoew
	+j1psw4XzJa4QTaB+Ua82NL32aaL/dDVSSrIqOd/QzConiUNExIcZKZntwXm5ponXpa2YUPs2P3
	oM6AuE/HadkEy20l63Z8icV8uBr078zmOrQBuW2Y5RzYN2Sz9uGFt+xPdadMa2mZqG7WbWTsXe4
	t/pS/DhI1cBcc6WH/1rRa/f42VNsQSg+xmeHp5ykKfIihfxUd7j3+84/bVekz9sYl7CA6V2PHIj
	ErwS4UZ/5RY/OogaQPwDGmMGAH618/pvFBE9kEHlXr+XbA==
X-Received: by 2002:a5d:47cd:0:b0:38f:260f:b319 with SMTP id ffacd0b85a97d-3911f7bd90bmr6778428f8f.44.1741257396884;
        Thu, 06 Mar 2025 02:36:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxqUdlV1rQR47fVsjY5mR2qgd1ZZUfY4cR3vuzXwjWACsfsXX/46BAzCY25BIGbrKimMUnRg==
X-Received: by 2002:a5d:47cd:0:b0:38f:260f:b319 with SMTP id ffacd0b85a97d-3911f7bd90bmr6778406f8f.44.1741257396568;
        Thu, 06 Mar 2025 02:36:36 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba66esm1658819f8f.18.2025.03.06.02.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:36:36 -0800 (PST)
Message-ID: <7e4122c2-0c0b-4d55-a3aa-e4c15e28c5d5@redhat.com>
Date: Thu, 6 Mar 2025 11:36:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qlcnic: fix a memory leak in __qlcnic_pci_sriov_enable()
To: Haoxiang Li <haoxiang_li2024@163.com>, shshaikh@marvell.com,
 manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 jiasheng@iscas.ac.cn
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250305101831.4003106-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250305101831.4003106-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/25 11:18 AM, Haoxiang Li wrote:
> Add qlcnic_sriov_free_vlans() to free the memory allocated by
> qlcnic_sriov_alloc_vlans() if qlcnic_sriov_alloc_vlans() fails.
> 
> Fixes: 60ec7fcfe768 ("qlcnic: potential dereference null pointer of rx_queue->page_ring")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

I think we are better off addressing the problem in
qlcnic_sriov_alloc_vlans(), so that eventual future callers of such
fuction will not need special handling.

Thanks,

Paolo


