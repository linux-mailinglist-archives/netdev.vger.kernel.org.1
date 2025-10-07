Return-Path: <netdev+bounces-228105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDA1BC16F7
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 15:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4753B491C
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E02DC322;
	Tue,  7 Oct 2025 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMjYNXjw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434472DF157
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842443; cv=none; b=n8jrlkwY7QA3i5aawVzH52PAM2cJfQXPElyQre7ObeRO3Qn2wKz3YgXimZyWmnOGa4Fj0PcyHQYNamxtEBP1t9wO38Uuld0wkHLZ2RMTopSI/2jGhOSq73LXtw8MP50neacPt6UyzJewoGy1e+2z407gBFH5vhmG/sdhnwl4HWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842443; c=relaxed/simple;
	bh=csno2nImKLREObByo9igOCqv7TpVBoZM28fRybFAIwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5ypLRG2W7rkbxZsg8/MlvpVf1aGntZEXehtvLLR7REWt4FUkY2VJoHnB4Zjyux5qdDvXZO0VWILB2Efz1EgciofgAByAVGaKBjuGQr0LUaTHp68WrFAToUu8wgjjA2LfZHdJb/gGlxCe8/EIPnoo3+dB6F13LsEgMG+RAcJnC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMjYNXjw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759842441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XBg5ffSo2GrH186PgVqj31fJqaeqJpOT+XmNAkbPa8=;
	b=iMjYNXjwKtvjpqGSpyeZBsUeRR+M5j6lVW5JHUNXHTxBO3oDvLT2ZuWxnUnihtXdaTIZkf
	IoK0ge8ETr8cZFs5aDv4zTnEJXSC2hQsld/SgEew076hQ3o8dbtnYyS1I+RUTeauck5wDI
	zRyBzGQme6+Tdz5JS4plY2rv6Zz1jR8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-fjbRP5NIP3qNqcni_WQHsQ-1; Tue, 07 Oct 2025 09:07:18 -0400
X-MC-Unique: fjbRP5NIP3qNqcni_WQHsQ-1
X-Mimecast-MFC-AGG-ID: fjbRP5NIP3qNqcni_WQHsQ_1759842437
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e3ed6540fso33535635e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 06:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759842437; x=1760447237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XBg5ffSo2GrH186PgVqj31fJqaeqJpOT+XmNAkbPa8=;
        b=Pwjpafs4D2uWKBTSoVRQzIG0Drou+g1u2f5L1WSCof7gm4bk0yVwafkkwv7hkNYTYo
         K8cDsO6BIBXY1gwFLti8aiQcHGQV5DRNt5xiDIJd1Ki6wiaW9EU9M7DfIl2VHp+XFltB
         g4tRP2r1jre2kgHXYzuwGWs3ShIg+MzQd/raZyRLRyPtp0ogowvfEKsZtSpNsXtDiaTW
         1AKZYvU2Ki09ntmVjOKG+EqA5LcAkGL3iaBaVS4qQ3UwIQrJKE8K5Yn0WhAJOKhYctsh
         IyByZTeni8cn2eE+F6hTkp1IGdwCaCf64P66iG/KW20WPL6crCu6Z2b+4ZxDlnT0v/kj
         evfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwUnWxEej8qhI7qZ1+AQ2hWp7NxhZoOiA0i3F9VNpNdsb7HesieMDsM1GibVhLUbr/dLz9eGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Tm5B2VqGqt43Sn9PN+L/XWEqOLWexY7zvRPmCLwmDyHLApBt
	5e8O3MPXPpaZKaSTODdvFy3JOCoKFtarir2M3xn8IejVlSzMeKsDHEDTfxL3JUEYVJ9AFtmuzuc
	moEKNI8veeApvfdFLqUMGyDwHmP/jFSzvaD3+lGGUnUUx04H9IlXitJuuB5bVtk1XAQ==
X-Gm-Gg: ASbGncsUXOxX3g1zjYzlh51HGiD3fUPUQWEnz7+mQiEH8kjFMMYIoTxBOLqDHAe/LRm
	9rsDk4fhhIsXTOfgR+deIGzGcomvvxfC2UtJf5twHxWpqNS73mNeD8Lb10pQlLLpxQFVLb7QSOG
	jHeHMRHVJWhK4ObGkdAXdHnYmunVBYaxwf+rxAbw88VfMWN7sktKImaT3ZMZSFWZBtgLsENVwCe
	wEKfbKRERDNo6j+i9KT/jB033P1SPrBmp54Iy+AB31nVXHMGqV3ODecnNFj9Ck6Dax/Un+gxPvo
	aUpwyermpy8JeQCro5Yid4Ue4xIFyhBHqWh8gEyllF9MdioarwaIHn6bTs7mSn1Uyly9K7J2D6b
	fTa5i/VPbT2VmXS3DhQ==
X-Received: by 2002:a05:600c:6a07:b0:46e:74bb:6bd with SMTP id 5b1f17b1804b1-46fa2952c89mr17285505e9.4.1759842436895;
        Tue, 07 Oct 2025 06:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2L851GpOZr+HLN+RmzEFHJmku4g/YovfWmiVjt/V8y3IuJukmtrAjm+9vQy2k3rcv11whEw==
X-Received: by 2002:a05:600c:6a07:b0:46e:74bb:6bd with SMTP id 5b1f17b1804b1-46fa2952c89mr17285295e9.4.1759842436449;
        Tue, 07 Oct 2025 06:07:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a020a3sm307487145e9.10.2025.10.07.06.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 06:07:15 -0700 (PDT)
Message-ID: <7b460ea8-c340-4ab8-96d9-43568227ee07@redhat.com>
Date: Tue, 7 Oct 2025 15:07:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: airoha: Fix loopback mode configuration for GDM2
 port
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20251005-airoha-loopback-mode-fix-v1-1-d017f78acf76@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251005-airoha-loopback-mode-fix-v1-1-d017f78acf76@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/5/25 4:52 PM, Lorenzo Bianconi wrote:
> Add missing configuration for loopback mode in airhoha_set_gdm2_loopback
> routine.
> 
> Fixes: 9cd451d414f6e ("net: airoha: Add loopback support for GDM2")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 81ea01a652b9c545c348ad6390af8be873a4997f..abe7a23e3ab7a189a3a28007004572719307de90 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1710,7 +1710,9 @@ static void airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
>  	airoha_fe_wr(eth, REG_GDM_RXCHN_EN(2), 0xffff);
>  	airoha_fe_rmw(eth, REG_GDM_LPBK_CFG(2),
>  		      LPBK_CHAN_MASK | LPBK_MODE_MASK | LPBK_EN_MASK,
> -		      FIELD_PREP(LPBK_CHAN_MASK, chan) | LPBK_EN_MASK);
> +		      FIELD_PREP(LPBK_CHAN_MASK, chan) |
> +		      FIELD_PREP(LPBK_MODE_MASK, 7) |

I suggest introducing some human readable macro to replace the above
magic number.

Thanks,

Paolo


