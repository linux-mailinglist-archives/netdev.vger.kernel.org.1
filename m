Return-Path: <netdev+bounces-125476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5EA96D37B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D9F1F212E8
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9F2197A92;
	Thu,  5 Sep 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8toSrnn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA549194AD9
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529254; cv=none; b=bmZmIFnQ7qmxINE/UrpSo6hHo0RFseq9nQO+YqYr/0lgcLJeFzU4n9MYI3GAz4i8yuuvIm1pAmMhLR+yRmQi5qQEFzJKvCcxhrmpMNbehCGsjJFbukzfIQDN3P/H+BbNt4nYq1Yp5aub7hTot43/S6KFtzYwyRxC5mP7COQf9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529254; c=relaxed/simple;
	bh=HkMksoJkam39qtRwxGPncit4t3aPPxXN22Lh0dQW1hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leBNJHXWiyGaRVvhEkyj7hqQioQpZMP0kBX/h1D8ZhWa7LLdb7c6xSyOVIkycFohNSyK5EhR88Fo+dNBRiIwZx8qmBXR5Zb/A/KEwBLGwXKkOK7fDHRETPI6nvQEfm2JGYDRpII+6BlMUl8CpCB9RxhjuZ6Tuy7QpcLUj5QsNlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8toSrnn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725529250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/d5hdFRsgesb2Y7IkvZL3YR9p71W/+q8gl8me4oUcJQ=;
	b=W8toSrnno0cEHBWUM8lMbZNjVUcEc9AHTrDG8Vf/P6P2cEBzv/SraQFIBPm3S6vlbyMvzt
	A8P+UQ299zHGeo6Mz+f1cWEU3SOh/wMcCcRovDtQ12s6N7JDArrYJtccxm1MNNrKEKq9wR
	FaAdApJJycoUMmLmtN2bj4bbtPRTKdg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-8H7dqGWqMt-u6vetTzk8Cw-1; Thu, 05 Sep 2024 05:40:49 -0400
X-MC-Unique: 8H7dqGWqMt-u6vetTzk8Cw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c434b952so333621f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 02:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725529248; x=1726134048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/d5hdFRsgesb2Y7IkvZL3YR9p71W/+q8gl8me4oUcJQ=;
        b=VCo9hVBYYeApTizgdcFfysJ8EX1TpWHP+13vUv8DF23XY5qrJUktvT6alLHhklzYDJ
         Yg3YngmpFkQiJmR8snAvapbNPHu9kZF7Lea8OYWL7+YJ54sPwTSpZ/0VLKU0aHTlqY9H
         BnuERb51d3ad1cJH/rnrXRboluRlvfcuJkMD0EO8b1VTVZZYP/KUOq1UQM87hKgnHI62
         wvFi75Z4xFnPlvkKbY20lD3Fw1YcItDXBlMnjZzgpY+SnfEYURryL+BgjeQm1U8GiuwV
         sF/fTBooVKQLx40MRjoBoMEt3o4YMGWP4aq6SMpFrF3aTURbZzavLlwhh2iHNlmI7Apo
         bu+A==
X-Gm-Message-State: AOJu0YyYOzsSvls8lUlPpPpV0DqLMLRMIHErfvJKHAolSyfexg1XFsa7
	d04vkDrBMPgGjuwWDO3xRH7V6/VEFmx4FS5EC83ichVEPdr5bCR5XXHkFvjnK1hX3DH5aOqlvVu
	8FcERw1bmz36O1+WGBYEXXsyROvYsrWrmGDV69e/bnlcVshxNVCJhFA==
X-Received: by 2002:adf:b35c:0:b0:374:ba70:5527 with SMTP id ffacd0b85a97d-374bef38a14mr10487176f8f.13.1725529248263;
        Thu, 05 Sep 2024 02:40:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc1L2IubIloELAc/ui/TQRrGJJubc4ZHHBYU3N6zCj8tc/ichdm6z4YhezmjVfkXYNgOCQ4A==
X-Received: by 2002:adf:b35c:0:b0:374:ba70:5527 with SMTP id ffacd0b85a97d-374bef38a14mr10487145f8f.13.1725529247727;
        Thu, 05 Sep 2024 02:40:47 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c4059811sm12775152f8f.4.2024.09.05.02.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 02:40:47 -0700 (PDT)
Message-ID: <daae082f-f526-4673-9ab5-43cf1d4d8b59@redhat.com>
Date: Thu, 5 Sep 2024 11:40:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net: phy: Add driver for Motorcomm yt8821
 2.5G ethernet phy
To: Frank Sae <Frank.Sae@motor-comm.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
 xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com, jie.han@motor-comm.com
References: <20240901083526.163784-1-Frank.Sae@motor-comm.com>
 <20240901083526.163784-3-Frank.Sae@motor-comm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240901083526.163784-3-Frank.Sae@motor-comm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/24 10:35, Frank Sae wrote:
> Add a driver for the motorcomm yt8821 2.5G ethernet phy. Verified the
> driver on BPI-R3(with MediaTek MT7986(Filogic 830) SoC) development board,
> which is developed by Guangdong Bipai Technology Co., Ltd..
> 
> yt8821 2.5G ethernet phy works in AUTO_BX2500_SGMII or FORCE_BX2500
> interface, supports 2.5G/1000M/100M/10M speeds, and wol(magic package).
> 
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>

The patch LGTM, but waiting a little longer before merging to let Andrew 
have a proper look.

Thanks,

Paolo


