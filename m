Return-Path: <netdev+bounces-246314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0801ECE93F1
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7276A301C90C
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914EE2D480E;
	Tue, 30 Dec 2025 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vp4I4MmK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xvl3Ppnx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB2C2C3251
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087777; cv=none; b=VajNmNblm7O5l0UbvshqUoFkLUL/zjBEBa5OSL+sR8sfjSm/fxS6U/EjT6HqdK9tGL5KEWwNLXSOCjnOcJx4k0BW3kDGaaX/TdIk8pMMsrBlPgm+p5jjVfm7KGczvMHQ4jEQbD9lZdMVQwk/UICBgz40IHzThfNQKz4mBaybpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087777; c=relaxed/simple;
	bh=SU/gkVSJSKmS1toUh8a9AX9Zwej8Gg1TuhVWXdqgfeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+9BbHfL/qmq6yUVXWN+T13kXlDSmfXOTBvyJbgZqDrY77kcwxxdLWutZbf8OEHr1Fx3ngA5fFSgnJYOGEGJS34EPGvuMoQfmO2Qpb9blL7XDgd67rLElUz2mL7jpJRKQtMGPlHVBzfapgSTIUVYgGy3xD1tZLIOkF1W878ANPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vp4I4MmK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xvl3Ppnx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767087774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9/bKFXPzIaEZ/uggKugW5GizuegwuaRhWjx7DK7tW0=;
	b=Vp4I4MmKubqCsQ+bGeKHvxIxKkxKySm5OkuRtb9IvksBZToddEVR1TlzSsBxy9zRjE1grE
	+qqp1GXGorwVAWYi+H+LIZM5xtP9gV4rxtvx9UERQFfGBOC2B0JyyQzOgUjplIyG0bHgIL
	EdBmTK9T+159c53R+WrUWgoniKOGcro=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-L-i0QONNPAqcIlhoEfxOOQ-1; Tue, 30 Dec 2025 04:42:51 -0500
X-MC-Unique: L-i0QONNPAqcIlhoEfxOOQ-1
X-Mimecast-MFC-AGG-ID: L-i0QONNPAqcIlhoEfxOOQ_1767087770
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fc83f58dso5479025f8f.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 01:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767087770; x=1767692570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9/bKFXPzIaEZ/uggKugW5GizuegwuaRhWjx7DK7tW0=;
        b=Xvl3PpnxqJ8ShPtrHMNnbUU40XyeJSVfCzxWQfJWZM7In46jKQnpEt3DDDNWlulBRT
         8VQq6DyPJyqzTz830FwvbWoQSFE3jCh0RFTi2AU29XhRjsD1x8jIUlJDfd1YM11EJl5X
         mqWVJDPRMHgIvNnJevB8jZD+kTGKNWHig4MsUNZ69nQAP3xDHKJpzCutB8Vsexg6150q
         EavwzHnGnGxwvvOTEOGHmRRFoM7I6Q5z7VEsK9uaix2msUbw3A2VB5ObhvlJnT1bpTua
         ffkQ9zsMczDMrhYimfP/lFqGCM4rHUAeFjT9t1j7oR7TDVxNcrdX953CjsVOb+vyDG7Z
         UHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767087770; x=1767692570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9/bKFXPzIaEZ/uggKugW5GizuegwuaRhWjx7DK7tW0=;
        b=RJqjmHq7/T7F/J/HhNcHtL6S7qODbtY0+s/zAiXXMSCiLlGZRJkvt/zQYAkLW/g74p
         bXI1Ynwn6H19jwbfBGGTaokFDytEY1IpitTKQJQrMKorkU+E/ylyWQ4EljXmo5D54G2y
         rhG08PKvZDPgMy9bxGCXSlbjKRhnGyKrfXLbwfRk5Ujmtg4M9Fc4o8ZyWS/iewKCYMJB
         EzkmwFgtqiytVeRtWacKWQ/1A15LeMj9Ano6WyEc5E85PAtgIyKJLapQdKhxk75D4qlJ
         QYc6XEXZ5haAZGV2DtZjWK7eaHKO0AcR72jdagqeu0EioDm9x1U8PQo6HGOiWOkDZovz
         +VOw==
X-Gm-Message-State: AOJu0Yww+CPUB0rNJJiEMcc8zm0jxfg+FX3a6mo6ti+sP/TB0HY9OHlC
	fB9JYd84LPhF9NRulct6hDn52uiit2O+KQAR5ARHT8mI1MrjrEM2NbulR3/6ciY3vPXCKP0Y3lp
	JXzeoylLMrhGvnpgRZ/NTAHCLv41B4kiiPDJPMIjf5OwMxlM4Hk5m9fbOcA==
X-Gm-Gg: AY/fxX6vu04+WaxT9UTEpHVf7/tjECy/DjoY3/tu9Jga2W6XkhNMEwIn/ip/91HVbS2
	RAt0bvYUfvc0DcSz36svxlN560/oTGHfHSRRjCYbkXVDIdwy/oGS28xd3iPmBXOV67YL952fGKv
	mFB8KNlpWmpJpuB/4Iww1/QVxpYGtLyG6xMvzLBuiQjdgFg/53oZaU2Bv2YglCk50qsGtDuv1F9
	FBi5PeNBl6BCGCXoWWu1XgHXbreKNGXoDC613eds3WH7KrYPbb03B6s2stf9+oPYtsYWuWos20Q
	vyEzVQ2BAf+PrHZfMlIe2WlA8OL0EZHMnj35S09pUHEbUEYul7GUYddYdbA9r4q5ZHTdQ27KrSb
	4k7y4ef3jdpUi
X-Received: by 2002:a05:600c:8b06:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-47d34de6358mr303808845e9.31.1767087770031;
        Tue, 30 Dec 2025 01:42:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3Zx9lRdKfuZUc0CFMcTPCHEvkS3FVBu+fC+b4QW1XnjJD/mHOaw+2kjvzo31uDZK3uXx8xw==
X-Received: by 2002:a05:600c:8b06:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-47d34de6358mr303808595e9.31.1767087769680;
        Tue, 30 Dec 2025 01:42:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a4651bsm250192045e9.7.2025.12.30.01.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 01:42:49 -0800 (PST)
Message-ID: <3d6fbc23-e9b8-443c-badb-b3380b62d21f@redhat.com>
Date: Tue, 30 Dec 2025 10:42:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix PTP driver warnings by removing settime64 check
To: Tinsae Tadesse <tinsaetadesse2015@gmail.com>, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251229173346.8899-1-tinsaetadesse2015@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251229173346.8899-1-tinsaetadesse2015@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/25 6:32 PM, Tinsae Tadesse wrote:
> Signed-off-by: Tinsae Tadesse <tinsaetadesse2015@gmail.com>
> ---
>  drivers/ptp/ptp_clock.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index b0e167c0b3eb..5374b3e9ad15 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -323,8 +323,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	size_t size;
>  
>  	if (WARN_ON_ONCE(info->n_alarm > PTP_MAX_ALARMS ||
> -			 (!info->gettimex64 && !info->gettime64) ||
> -			 !info->settime64))
> +			 (!info->gettimex64 && !info->gettime64)))
>  		return ERR_PTR(-EINVAL);
>  
>  	/* Initialize a clock structure. */

I guess this is an attempt to address the following issue:

https://lore.kernel.org/all/20251108044822.GA3262936@ax162/

If so, it's already fixed by commit 81d90d93d22ca4f61833cba921dce9a0bd82218f

/P


