Return-Path: <netdev+bounces-237523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1B8C4CCBE
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4CC54FD01F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360E72F3C39;
	Tue, 11 Nov 2025 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSZ4+vIJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHygYOEP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4724C2F5318
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854645; cv=none; b=q+PClPVp2D4jPoOYESPOeWfSY9V8fJcPBCstXfSnzoMoiLlZZlRy73sYsW6iRAGcBvm8nOOgHA0J2n1hnXgkNF68X1JstGC9pcfh2jVSmCs+Cd8Ny68YmPd63AVGt1pjT1K8VkPKe3c17s/0HdrjC5yB/PQofbFMk6gPYRjEGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854645; c=relaxed/simple;
	bh=TGrH66M5EMnHyGHLVTmDYYLnd908B66BAFvVHStqKN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMbt4VoV/B2sFeB1lx8nFOs/V7oiSZV52GjiexdVbn2rGBJgsagqvpokqF/wu+cuCV2MmBIG7Dj8OZulor08wMiZQpW/7vdGB/yuhNdEkeTSyQ18L7d2D7gm//LGCQuxk+VCdvfVbjK0lRN2AEu9KM8sGRyvkC2NLrPiuzx/B2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSZ4+vIJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHygYOEP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762854641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeZzeU94DGljgdT5wtgZtGEUF0cbb+34JyOazF1oIBo=;
	b=DSZ4+vIJqEKhBhNv1pzFz/06zDTNAqdrykhmQKCQA9b7WLIRCfKH2mpU+L8NgWXKYr98O0
	7uSEVIH0QmcmW9130UXfxiTWNOzn64IsTPdWOlHDwcnQ9+gIF+PKzUoKiJJypLQIzb5Pfe
	HkmTcxfKc6Zu6UhC6vwVBOHjIIwX2BU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-YXAjUAS3N4Od4A_7JRLNQg-1; Tue, 11 Nov 2025 04:50:40 -0500
X-MC-Unique: YXAjUAS3N4Od4A_7JRLNQg-1
X-Mimecast-MFC-AGG-ID: YXAjUAS3N4Od4A_7JRLNQg_1762854639
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b352355a1so271801f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762854639; x=1763459439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeZzeU94DGljgdT5wtgZtGEUF0cbb+34JyOazF1oIBo=;
        b=MHygYOEPIi1DzHXU6Iu80Rj9euj57O2hNXCHBVpRkrmekzW0Lsg7V+/2i2fe7lDmFw
         4XFPKJeKu7FOxjrWy8BSh79X3mCkUFlRAuB9kI5cMzlD0nCs3UKOOUkYW8lX1Yc7LWQi
         9ODCCv1BUkeDkwP5IhuAW/jx2cct+luIrxshraDjJ0GcgSb0UU7ie/hKj9a5dEV3s1UN
         CpZqgBjHtLXtk1z6Vp+WWYJjBfNtYh3XjFX8OjgIRnVcOlLTvBiigcFX8m+M0kze/s0Q
         rx1HJNmCCoMg1D8TEdMgYopqkFAgd2A+Acn+dH89Tb77ltcJ7wKgyYdw7LpQOdtIKAAX
         ETKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854639; x=1763459439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PeZzeU94DGljgdT5wtgZtGEUF0cbb+34JyOazF1oIBo=;
        b=j+RenaSxf0sKEQcbxEt1L3Q/BeQPcoWpKkWYjp35V9MM3tIADlUNeFiSDSl0hnSv1z
         NHT/asZYsyx+oCzrMl1oNMZfa9tBFsTWTm8t+1HkhTricFSa4skhD4vvmjVBtHDhIWKn
         Jdi1p5cUof2NrX3lgXrEP+d5xcVpXNA9h7WqECzEmJ6gwEJUhZHQ/R1zcfMvN9EWucP3
         Mp5NQwUEf5H+7gWP/sqPJrMgEdNuxV826WbriUBeLbp+OmM7n2Jduta4A3QTjN0P2tPa
         Z2lZCI6N8hFoacuwlyEAO+JMTfYzkKxB17QUzEvD1Wnw2l6BMNQF1tTMJE3vndhC/O3K
         NOtw==
X-Forwarded-Encrypted: i=1; AJvYcCVSTKlHCue2Wh4Gx/0IT7ILl13gdHvGiJwTytN8J/G4POafMmtyz6gRsdSWN1+mJjBblKJD3p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRzZ4oqcT7+isXPEDYqPRrgIFQgzF+CghTLxeNM7Vh2QexgmUZ
	eCD/Abmc3KWUDVnctig7Gtr/4lT/HbwpiF5DktfKAw8KOW25be5HLAMJ1dlDOxEIUkF+NuILSLG
	yypuhP/B5ogl9s6ZCRZbUOvD/BomNEDDr/AMSui1DTvwFtwxvhT+j0aCOQw4cDCO5FA==
X-Gm-Gg: ASbGncv4tVeDGmsSxaPOCnCnKt7zgF7wrLXq77Igm9GBHu8Mm8ae8e/kFgTRxfSmiwi
	yEiGtPwV+RyS0cyc8fGPxNwuTTSwwMnsrKYyL6CPJwk75NYEXFpjeXdiW0YiZwHjWBf/MVep8uv
	E6YP1PaZVn3CPTBed5vl3oaYG8enKg0B/sQwWMoAYGI++j2Qj2/oPoO3Jjx7KGXV8saiL23s5Km
	COYVE45O5KbH1xMiWh0sqSL5AM5wLRU2uEZq6jQIh+fNhlqIGc1ugZTK++wK6EdpHeCa+xI+VkJ
	cfEv2TbTcPuSF35Cs++KK7U84w9YmywA8BAatI1VdS7u42yGkHTLWFvpq/nRUIfVH18QxPRbOE4
	/9g==
X-Received: by 2002:a05:6000:1a8f:b0:429:bb77:5deb with SMTP id ffacd0b85a97d-42b432d31d1mr2613865f8f.31.1762854638721;
        Tue, 11 Nov 2025 01:50:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOjiqZW8j+6gGTKHm8NZbSgKmq4M2/ST6ij/CcnDFYYmyWJ6QQto7wEh2ulHAHf/DFX/cVFw==
X-Received: by 2002:a05:6000:1a8f:b0:429:bb77:5deb with SMTP id ffacd0b85a97d-42b432d31d1mr2613837f8f.31.1762854638342;
        Tue, 11 Nov 2025 01:50:38 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b321a80c0sm16502643f8f.1.2025.11.11.01.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 01:50:37 -0800 (PST)
Message-ID: <839e8185-e3d7-427f-874b-5da4bf49c2ee@redhat.com>
Date: Tue, 11 Nov 2025 10:50:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next v2 2/4] net/ipv6: create ipv6_fl_get_saddr
To: David Lamparter <equinox@diac24.net>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Colitti <lorenzo@google.com>, Patrick Rohr <prohr@google.com>
References: <20251104144824.19648-1-equinox@diac24.net>
 <20251104144824.19648-3-equinox@diac24.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251104144824.19648-3-equinox@diac24.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 3:48 PM, David Lamparter wrote:
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 40e9c336f6c5..f20367156062 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1533,7 +1533,9 @@ struct ipv6_saddr_score {
>  };
>  
>  struct ipv6_saddr_dst {
> -	const struct in6_addr *addr;
> +	const struct flowi6 *fl6;
> +	const struct dst_entry *dst;
> +	const struct sock *sk;
>  	int ifindex;
>  	int scope;
>  	int label;

Minor nit: please respect the reverse christmas tree above.

A much more relevant note: the code for the whole functionality would
help greatly to be able to properly review the patches.

Peaking over the shared git repo it looks like overall this work would
fit the 15 patches limit and would be manageable as a single series.

I suggest posting the whole work in the next iteration.

Thanks,

Paolo


