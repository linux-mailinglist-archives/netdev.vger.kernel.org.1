Return-Path: <netdev+bounces-251428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A666D3C510
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0157F585E5E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC1C3D3319;
	Tue, 20 Jan 2026 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVxs1BlG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwEjSH+w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0B3A1A5D
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903477; cv=none; b=JZyaPpZe0gv4eDW4ZDrchSFM7lOdDv3pEJHfuTMZNz1dK41bIXacxlw+K9jrRnyOp4+Q0NmWLRp1ksBdFaWJe9a5Oo6SN7Pr9urXa8Iz1ZW2z61kw0+QUkW4YsgqB+9hU7Vd6xs50mRptSxUZ/AqJCXfu/JoUzQeNtF8vWsRLxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903477; c=relaxed/simple;
	bh=RYkZyLqJ90IZtrT6SNyMGnHInu7O7ZOy96fwuZZjuzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4sX4F+uQk8A3XKlL/ErFij0Isi5v08haCFhAupn2pe9q5rFJ9rxpHwO6hnb15i8J5I2fxie8uD72qV4xfT5W/BkDXu8R7HrXmVXNI3u3Qg7mxpGfz5oNFYvbUYtgAJyjQRlXc0Oncvw1cFOQ5u1AAg3ALA77IoWhtSPvbZ2TlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVxs1BlG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwEjSH+w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768903474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+FKwnioUTqyK6Y6ArRUSCC3M3FO8NWsXoRptKXlqbs=;
	b=NVxs1BlG8HYIO1jOIs5tOjFR3QSp1pYkp6x7hGctlA0iQyegTO6mVlVHHQ458qqHRdEK8U
	FtlJaaVX5JhC0/eX26GDQdzuUl1yQmnz4viq2imKqutyiiIUFX7tlhmZVPT1u/+9/wldav
	bskyJ7tQa9KIEsdpZuuti4usrelwOgM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-3Z_fyhcNN32Iu1cr8_8WuQ-1; Tue, 20 Jan 2026 05:04:33 -0500
X-MC-Unique: 3Z_fyhcNN32Iu1cr8_8WuQ-1
X-Mimecast-MFC-AGG-ID: 3Z_fyhcNN32Iu1cr8_8WuQ_1768903472
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso2915821f8f.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 02:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768903472; x=1769508272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+FKwnioUTqyK6Y6ArRUSCC3M3FO8NWsXoRptKXlqbs=;
        b=GwEjSH+wu/rsj6VirQBI8w4dln+vRXnJnz1V7rUdZyEDywXjC5CwE82yoZxsVkBk7Y
         TpHPGO7hJGRI7rjM6PTMweZSdCsaAZ6B9dMUCV20QPQ04Xw68vuBrUv+di1eH9cyXzMB
         QRtSRo7Aj+H5zHS3LhOad1vAyoPDcIRmIliO9GOZFdYr0whBIv0eqYl0Oezhf5kjNcoN
         5rWyU7LmeOHre1JX5vizH0u0d1FiZ5nLYlFUQD5BMh/3i1O4c6ME2s9NHnLP6X/SnQUU
         6R8jzL8idhtKNV8kAtF/fJmq94p91Me5peG2PcH1uqJN8UMOJgrMl+Vq44pjfbyDTuM3
         isvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903472; x=1769508272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+FKwnioUTqyK6Y6ArRUSCC3M3FO8NWsXoRptKXlqbs=;
        b=AoXbDtEbImLR+hZvw3hijAjv/ThioYQeYtzTDuR4G49TH8PtClqQD44LW8r/zFHkBV
         q7HP5wAIBz6N69DIcZZjN0p9NqstQRmaD0zlOwW+PL6yBROZQCkj2jnsogfCSuZBobCy
         pW1OG3R5Iko4onIXV4D6YWh+L+2CuAG0nEOGMZFPXqroe8pDvvfbRag2eG3QJJ0BJmwP
         +obVnRVtTPrdEVkvtf831vMbOfqUFv7yM69hKV75nq8vZVqAF5pUoDXNNe0XR7bS1q77
         K+bo+cWj1+XPjxl9vYvyVPfYOxIVHGrP5kCukZLiNOQ6VPcmXaUbWZTonIaNLqY6u89i
         8vdA==
X-Forwarded-Encrypted: i=1; AJvYcCVdVTl+BUIu/VS9HkLSEsEbYiOgxj/coVtFN9Hyd3GZR6E3hGAykPh4+NXfgc45hz52xDS8noQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUQFVp/uNAzm/NTxNkq0xQtLxOsGfpHjdCDr+OUswGb0j87Uq4
	G79T2P4kbpzkbZcFY9x27vB4xAeyFNTAQevp8qWisUoHPalnyyu+XPPExnHbCFCzytabK1t5DhO
	7YqTGRywjtv1kPAzziosIaKdfKEkmdyz/w7CswZcx1QtiX5tf6/GrgDgNfQ==
X-Gm-Gg: AZuq6aLcMQqf7gW1xDQ6lmvM0itcOyRbM3k+KmpRVVIx1hSBqzEj5pXNzoif1wilFPd
	pgq8Kuoif3Dg4zpKK3tyAzBWt27D9EVBRT7qdur3eKMfGGKZzGVVenJuVD01bbSGW3pDuJEks57
	aLi20RH5CrdBNaMQZr6O8hgkmPR6wLzU7AQ7s2psdwOu+7nOq97ztCo6RO6cTcHTmt83lTIcUDJ
	3LN0FdTZ0Utzc4BO4szpKMD0l72VxN7JrZAg/eWpzvfF/e6Bp44bw4nwVxhQZRrT/f7BTbHGJEf
	bT/BruqzEWAiwuRzPeVp7NqPdUInAOo7sTUfBQ/pTCff/tbcWUoAQkhw9MwSPiMI/kgGMhy4RrN
	snZ1oG0YXkBgv
X-Received: by 2002:a05:6000:4202:b0:432:a9fb:68f8 with SMTP id ffacd0b85a97d-4356a02643dmr16221640f8f.1.1768903471622;
        Tue, 20 Jan 2026 02:04:31 -0800 (PST)
X-Received: by 2002:a05:6000:4202:b0:432:a9fb:68f8 with SMTP id ffacd0b85a97d-4356a02643dmr16221591f8f.1.1768903471171;
        Tue, 20 Jan 2026 02:04:31 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358f12ee69sm3803557f8f.11.2026.01.20.02.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 02:04:30 -0800 (PST)
Message-ID: <d9096361-8f51-4865-af59-531649a5f42e@redhat.com>
Date: Tue, 20 Jan 2026 11:04:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 5/5] eth: fbnic: Update RX mbox timeout value
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jacob.e.keller@intel.com,
 kernel-team@meta.com, kuba@kernel.org, lee@trager.us,
 sanman.p211993@gmail.com
References: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
 <20260115003353.4150771-6-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260115003353.4150771-6-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/26 1:33 AM, Mohsin Bashir wrote:
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> index b62b1d5b1453..f1c992f5fe94 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> @@ -252,7 +252,7 @@ fbnic_flash_component(struct pldmfw *context,
>  		goto err_no_msg;
>  
>  	while (offset < size) {
> -		if (!wait_for_completion_timeout(&cmpl->done, 15 * HZ)) {

flash completion timeout was 15 secs

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> index 1ecd777aaada..b40f68187ad5 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> @@ -36,6 +37,7 @@ struct fbnic_fw_mbx {
>   *                       + INDEX_SZ))
>   */
>  #define FBNIC_FW_MAX_LOG_HISTORY		14
> +#define FBNIC_MBX_RX_TO_SEC			10
>  
>  struct fbnic_fw_ver {
>  	u32 version;
> @@ -129,6 +131,13 @@ struct fbnic_fw_completion *__fbnic_fw_alloc_cmpl(u32 msg_type,
>  struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type);
>  void fbnic_fw_put_cmpl(struct fbnic_fw_completion *cmpl_data);
>  
> +static inline unsigned long
> +fbnic_mbx_wait_for_cmpl(struct fbnic_fw_completion *cmpl)
> +{
> +	return wait_for_completion_timeout(&cmpl->done,
> +					   FBNIC_MBX_RX_TO_SEC * HZ);

Timeout for all events is now 10 seconds. Is that intentional? Could
that cause unexpected timeout on flash update?

/P


