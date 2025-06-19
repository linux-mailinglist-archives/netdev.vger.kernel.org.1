Return-Path: <netdev+bounces-199394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C06FAE0253
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBBF616FAFE
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993BA220F3A;
	Thu, 19 Jun 2025 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgxX1GdT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54221CA0A
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327509; cv=none; b=g5KeM9oCuu01Cb22jy8SbEVPzXpqyebP06im0Vi6EvzdRiM6zwVjTBm6VHbCq7PDK3wcl68pBeloHFidiBJyeSSIOW6wF92XCBRnTfTU7K7kxA/F2rNaHI4OLFYf7WxomfhlkQBadWSHpMWxf5aAWTBANKJhQvb4BCGtJ7iAwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327509; c=relaxed/simple;
	bh=acTQw2qYkSBY4/5FgWX9Ev2YjA+VK61BvCeWc3vMEKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTIQHDWmlHTH2qgX7hoGUFr+BSyU6yh4QKb+epNGqJMQYCAW6tJzNuKqA/ow9xn/r6rXh6gnSjPW+EHce1SLKXxbv2p+PO5tFl3ZIpyUOioMoNsrdWggKpzmd5X8C4CGbdYWXf9XnC888sixoS+PxBrop8u7rVbAwyKmWqdyBYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgxX1GdT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750327506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P43pHjwvIRJysLI2IUyxj7Ft7fzugDO7BmfsY0P/7l0=;
	b=AgxX1GdTVtMf2KsbUVOjOiCWwiD74jfU/RQ9nPAqS+ppZjFSw29SOQf1HdzTiG/BF5UH8H
	lt9kxlLy11gNstGLsVeyUAylXUhrI9JWPStkrhpStW6Ohq26Gg2fuGjCxtQC21G00K4/Cx
	nZ3/enVHCFoDFDRoqtdUvFxtbx9ohhE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-vGrI_8sgN1OdktxuZ_iRUQ-1; Thu, 19 Jun 2025 06:05:05 -0400
X-MC-Unique: vGrI_8sgN1OdktxuZ_iRUQ-1
X-Mimecast-MFC-AGG-ID: vGrI_8sgN1OdktxuZ_iRUQ_1750327504
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43eed325461so3796645e9.3
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 03:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750327504; x=1750932304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P43pHjwvIRJysLI2IUyxj7Ft7fzugDO7BmfsY0P/7l0=;
        b=EHtKlNnQmT+vZ0NJxOmKk74uUplhKPNB0EzVX1gnxb1eykBTu5H2gpXK9I7ke4OoJy
         6Bvs4yUKj14ZrF7hvTKNDauV6D53JUcOtHGsp6loxgMfgPF2exZSGNQXdAcQwwFtOtg8
         Zh2pP2eUkshxRH0hf6xlbzUgRZQQ96+TMMreuEr9e2nRNmDbhwYfUTMiNLYD7pM7FMT9
         Zdxe2CUjhzefL6dzYh1d0H/Ev6Cdk+1xz1keh8YXFTnSUToghYrUAPmbUnOuDUAmCdkN
         SKZfn2foOZ/afFIXVWzqc9EVcLxdS9rOZpRC+WP+UmIUMwu2D7TPpiJr7+aRhglAIhCY
         K69Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd5WFm7NOBrgBv0s2idIf/diVZvNq01aanuL3haKNuFdKtdXQqt2qqnPvy0V36BllZarofSvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb5eV/AEPt5a8I4BclFtF+kgCozzr1tnNosl2cFS/OsPDqm+It
	Olkdr8av0fNN5X+z1U4SOo6bJwTyHWtHpBKrMwOGDgyuCdShc/hbKPIZPrjUskOF315IqmapDqX
	1MujuDM9x7plsyRNLqUge6Vx3h+oWB/FFUn80s5cWGGGspBAflBU2Bfa5Bg==
X-Gm-Gg: ASbGnctkIit4S2BE/y1GEgsFF/lBQoqAPZA0/hJQLab4DAuNaceJxfOWOohpsNBWgnK
	LRqsXT0Okh+1PRuUBeNfmsj4wlLUDTvYfRm+5tCjIM69zTXW6FAp7Vr6LLAZovrXei7p5wTNVSs
	bSIt/jHs0NnBrQOab6ZinURXGhGVitk8qsyh/20VTnuRXPKDXOAIC84d4qbL0gbhreU1rd9W+sb
	TgKmNVHUumW6btCyOs1hoBY63P1FyXD1RhwvYg/slcpXOJ+fB/8d43tr9wgjQjeAOLTOuT3uWzf
	Ug8IKe41lkvQMWHN0Hr6c1a5RxlYPQ8nl8GaWUDlKRfeL6y681uaju3IePvRYiKylKgCSg==
X-Received: by 2002:a05:600c:a301:b0:450:d01e:78ee with SMTP id 5b1f17b1804b1-4533cc0887bmr140835265e9.24.1750327504159;
        Thu, 19 Jun 2025 03:05:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnDhnEFaK2XXfOzKEbUVQS6dTF/8AC1bhnKnwFj+sm+3hBc8WC/oKcecAeqwYQNDljDGBeYw==
X-Received: by 2002:a05:600c:a301:b0:450:d01e:78ee with SMTP id 5b1f17b1804b1-4533cc0887bmr140835045e9.24.1750327503696;
        Thu, 19 Jun 2025 03:05:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310:d5d8:c311:8743:3e10? ([2a0d:3344:271a:7310:d5d8:c311:8743:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead2449sm23320255e9.30.2025.06.19.03.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 03:05:00 -0700 (PDT)
Message-ID: <6a6eb40f-9790-460b-aeab-d6977c0371dc@redhat.com>
Date: Thu, 19 Jun 2025 12:04:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: lan743x: fix potential out-of-bounds
 write in lan743x_ptp_io_event_clock_get()
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>, Rengarajan.S@microchip.com,
 netdev@vger.kernel.org
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>,
 UNGLinuxDriver@microchip.com, Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Richard Cochran <richardcochran@gmail.com>
References: <20250616113743.36284-1-aleksei.kodanev@bell-sw.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250616113743.36284-1-aleksei.kodanev@bell-sw.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 1:37 PM, Alexey Kodanev wrote:
> Before calling lan743x_ptp_io_event_clock_get(), the 'channel' value
> is checked against the maximum value of PCI11X1X_PTP_IO_MAX_CHANNELS(8).
> This seems correct and aligns with the PTP interrupt status register
> (PTP_INT_STS) specifications.
> 
> However, lan743x_ptp_io_event_clock_get() writes to ptp->extts[] with
> only LAN743X_PTP_N_EXTTS(4) elements, using channel as an index:
> 
>     lan743x_ptp_io_event_clock_get(..., u8 channel,...)
>     {
>         ...
>         /* Update Local timestamp */
>         extts = &ptp->extts[channel];
>         extts->ts.tv_sec = sec;
>         ...
>     }
> 
> To avoid an out-of-bounds write and utilize all the supported GPIO
> inputs, set LAN743X_PTP_N_EXTTS to 8.
> 
> Detected using the static analysis tool - Svace.
> Fixes: 60942c397af6 ("net: lan743x: Add support for PTP-IO Event Input External Timestamp (extts)")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>

@Rengarajan: I see you suggested this approach on V1, but it would be
nice to have explicit ack here (or even better in this case tested-by)

Thanks,

Paolo


