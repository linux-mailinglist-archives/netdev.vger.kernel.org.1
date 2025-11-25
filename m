Return-Path: <netdev+bounces-241500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D35C849F1
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 12:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9BBA4E8C8F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD70315D43;
	Tue, 25 Nov 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlfFe7j5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnNmbrh9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A0314B9F
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764068645; cv=none; b=H4m1oyFdxRQES+Ilfkz/GfaV3xXLjeQXML/Dh16c5pyJPfyYkRtya+EPE1JeWCCaQfFmd0crcCUT80GKHHwXGCvs1/jWW9nsYkeGueQci4vq2gEthh6IPcp109WihHfnndbRA1JZFeNU21tj7pX8mdZHwqLUHvXVT6/uckKXpsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764068645; c=relaxed/simple;
	bh=iXKpiuNQlb6X68ZweO+BOUjOZ+bKXmHmii0jmBG3APg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDRJL+u2rcW4jp3lf6ptal6qhjUY/D1P502bxA4Z06QWqec9fTSBt8LlyNV1+IIhDY4ltI1+Khz1Ss/wgPPXgbpgagHQsoFjxnlrZsABU6nN6cjir07LY6VIxc3ad2RHJbeFpSsaFMzvAO6e9Z8GyBZyYXBktL0Ooklf5xYM5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlfFe7j5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnNmbrh9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764068641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jX8nyV/wRTc5eESPtXjGF1WJi21h6fkrbY07+2SJ7E=;
	b=GlfFe7j5djGvVcy5VW0Sui70GxQPjxkbErEyTM+pumYgABPILRXlWSeBeoHN2gJKQGAa+C
	4vwIBqPBMo2s8VRLvCrqeTx4z1Lkc7U8pjvqvXTOSXdgylAuuRRKyEmdp2hsQIDIudkel/
	CtKD5XVscwEXji6USgdHSaeDS1ebf4c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-MllV-oieOUy8i742juF_uA-1; Tue, 25 Nov 2025 06:04:00 -0500
X-MC-Unique: MllV-oieOUy8i742juF_uA-1
X-Mimecast-MFC-AGG-ID: MllV-oieOUy8i742juF_uA_1764068639
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477939321e6so30949875e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 03:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764068639; x=1764673439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jX8nyV/wRTc5eESPtXjGF1WJi21h6fkrbY07+2SJ7E=;
        b=JnNmbrh93ftx8BdFQsVOSeTNa3xDgm4vsIofeBTmYMVNOko/s/WTU8FsMaI9+K9sl5
         jYrmttgbG/dyUBGsAMOL1h43rWiBQ6DXytgaKs/dbf82kNClvGSWO8LHfZKMoWjlT3xv
         peBf+2K670Uw6eJLX6uw8rnHxF8k6v+TAs1VJrqJ+JX6+4Vtysv8Ex/fM59ceg2Q1Mga
         cnENbzexJP1n4DGSOWEJyjLycj4PJg6YT7Qsn0Hr7M1c/OZbfscCeeU2V2XF3ALyfiZn
         KNhqaxMaOxYORsGr1yV6YcMPzW9jf9TVIohkllshsm8Rnuhl18oR/PTVUi/xW66uPtAc
         EebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764068639; x=1764673439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jX8nyV/wRTc5eESPtXjGF1WJi21h6fkrbY07+2SJ7E=;
        b=QrNfbtai4Z7F36nRvBmCU3i2nIm0KoWwVW1oHs8njh6TXQ64El7oNnk4PK+gFuJzKr
         LK4EeCCxGbARAJbXF3+yt8oD8JY4T6nUh4f+cV4z9yCY0aEk7lKo3h7BJGDIud77EJuk
         QWuPlzIezDHNL6oS8+vyzdiWYyLH73K629/nXHrBO4UerN5Q7E9PWxFVj1cbtKgDfuMn
         8s2oEeguvUtNQ66Gu/rurLJzgHwKehyxScpiNv8RA8gnHtffbAdS5+VKjk++7OJiIhs6
         vBYVP7xAnbWmtjNoSDH45/LMfWOtuV/dvTfmYPBaAoleJyBYDyzpStS3rEHG5eTnRfiL
         9S9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWw4tORk5pbHtGzj2H0jPnlaJJ19CVEKcefu859rVIat4VnF3nn5W+kcARUOIMf+67a4hSOTWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydLNmn68qLuHrjY5dM1CYBgo+kjTyNVm8VRvuUo7vrDMt2h8Bz
	w8KhYG7euy9/ucadqBL+XH6TtuxsBcPLGnJFxjO2gTAmrfSv5pl7lNmLrlQNB296lSI2tQ2hMEY
	vn0CvSOvd+mYb3sZLb6dqTjF9AwckGh4AAxcrEKDtPtrzhe5SG+gf5c/GbQ==
X-Gm-Gg: ASbGncs9wScYXmMzOMRWH2cLw0GoqURwj/duL6yYGkwofFMNw1xb02Ahp1/3RtmKv13
	VlseFNeh1FK+sJY78LBwc65UK0FRKsH9r08b4f2uEr8MMKWBV/FbytUKoVOWigNlEZ3l584MOLY
	OPBDjw6n4MoQtPZb3rwUMu+eLhKGMxe7vCBNSfgbfngVipVMzj5UlH34dMJ9zbz2u9ixjj8uhaF
	KPbxt2slzUa7NWicovDlfx3eUihZt2rbnNLZPHXkDZzWQgLgyxqn/I8azx53NWNfheqQG+RKJap
	7QAE8j/EAQXU79vYuOyzIdclIqFJduwxVaNnmO6PcCwXx9jB+ww3qdkz2rbcrwWyTGwXLOly+bV
	JHn6yZagwj15sfQ==
X-Received: by 2002:a05:600c:1547:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-47904adff1cmr19046345e9.13.1764068638808;
        Tue, 25 Nov 2025 03:03:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoT6Pfw7CHSt37IswgwvDmurDiD6Zw/XOCayfoPPARGoD0QI10X//Yl97sd3GIIuQ+9cHtCg==
X-Received: by 2002:a05:600c:1547:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-47904adff1cmr19046025e9.13.1764068638268;
        Tue, 25 Nov 2025 03:03:58 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf22ea00sm246531145e9.14.2025.11.25.03.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 03:03:55 -0800 (PST)
Message-ID: <323a8b07-6df3-4cc4-960a-994649fb03e3@redhat.com>
Date: Tue, 25 Nov 2025 12:03:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_net: enhance wake/stop tx queue statistics
 accounting
To: liming.wu@jaguarmicro.com, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, angus.chen@jaguarmicro.com
References: <20251120015320.1418-1-liming.wu@jaguarmicro.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251120015320.1418-1-liming.wu@jaguarmicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 2:53 AM, liming.wu@jaguarmicro.com wrote:
> @@ -3521,6 +3526,9 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
>  
>  	/* Prevent the upper layer from trying to send packets. */
>  	netif_stop_subqueue(vi->dev, qindex);
> +	u64_stats_update_begin(&sq->stats.syncp);
> +	u64_stats_inc(&sq->stats.stop);
> +	u64_stats_update_end(&sq->stats.syncp);

Minor non blocking nit: possibly use an helper even for this increment.

@Michael, Jason, Xuan, Eugenio: looks good?

Thanks,

Paolo


