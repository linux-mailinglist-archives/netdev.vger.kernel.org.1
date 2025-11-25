Return-Path: <netdev+bounces-241478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25086C845C0
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F215A3A9F38
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E252EA756;
	Tue, 25 Nov 2025 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LG2SYZ8h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o9Gt0bUk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072CA2DAFBB
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065114; cv=none; b=I3BtduHIHHXEFgDEtOnKaDy2twnKXz0vtX2ni7s0KRShDGInyTj0j6xw9GSikN1hgSy1Q+l2sSx5fGrcOI1694GMR1pyWVMTNZCjQEZK1BrUHo+cJzm1PXEf6/QwEqr9wj1ky2FZRKch+oJVNtBvI0/FNQitLxw4DwdkJ5Yq3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065114; c=relaxed/simple;
	bh=Tvut4rKFuaZuRy+MpiRjhCbO3OPGk1QYOL3k9etbC0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riRbOMZ7+MJ2PPOs1OQisYXWwFFls6toWS1j/4/xdnmo4aZN+VJGsRT1ntecbOgEIlQTsLBH5CCOgy5RN/7n7woen7UrhtyVR16NqnqP2FS/sBUUqt5q8SzceBY6mcxYBG5ZFcBJ2OhOor5A2aglQDaqBLpAKzE5v7ac3h8KRGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LG2SYZ8h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o9Gt0bUk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764065112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Du2XvNcpBpgsVAjcJWW200tMdW4BN0igIjQyXWLtpA=;
	b=LG2SYZ8hho7IM6ViJ0qkXlqZaPley2c9RpToklHHxNhkWEX+HrRHJYyDMORMsLataafS4v
	5Hfr+AcnKqWNznqnKN1rt1X3eefojx6orGGdeNFYYByNx2C1AdShb5DMmYGtZrOIN0GYUC
	vCoYMjniO3FYMDvIQe56LnReEa0Gqv8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-6fBQxfI_OySEvvEETSP8xw-1; Tue, 25 Nov 2025 05:05:10 -0500
X-MC-Unique: 6fBQxfI_OySEvvEETSP8xw-1
X-Mimecast-MFC-AGG-ID: 6fBQxfI_OySEvvEETSP8xw_1764065109
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so41529915e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 02:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764065109; x=1764669909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Du2XvNcpBpgsVAjcJWW200tMdW4BN0igIjQyXWLtpA=;
        b=o9Gt0bUkE8MiVYFmPzq2Ncg4qqRUvE37dNNhYGCMWPLJ4hAzTmKc4mevLF2JRqax+P
         R3nFMzowcu0ilvQxATUj8ExzuPuVtg4OT/dYhMKlPdjiugpidZRkvdymQuNFnPU6b9xu
         j2+CCmOfibfyONzB9Cti6dsqieikP4vx0Rgi0HgrmNcHoxn9jykd77efyKNDT9d4po07
         VieFnVGzXbhJbEXr0qmAcD3caKCQJLzZ694HXhbtXfiLkqvOlOaNXTyMyr/43it2AVvh
         kAocg3TUiMOllhqbg1dZv9NmpTJahGUQ0h5zHhbDZUq8Cv9zEi2KWRpKB+au8u+9DFMx
         68YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764065109; x=1764669909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Du2XvNcpBpgsVAjcJWW200tMdW4BN0igIjQyXWLtpA=;
        b=d3swGKuz7bh/fpybmLNI7itIPiUzD/NlsGa5xLrKzYCiMBM5nd/f1OWzUKKosCott+
         BI5wdylu+EmwD5FjHsT5QKR7E4RrJVeZabgFfp1RcC+rWuaL8eL5/KVBP7d/P9owHASY
         ZS7443CtqRUytwlRw88hzU/wDEa+4f1iRxipBpSKu7HX7n1fNAEZTRFuEkedUo29s4cr
         1PMtR63fimiAl615EhSq1zgBUpISGOPU0jg+E+E3mdQ+BxUURtfPaX6XTgsPBUsKZG95
         aoDWUyjZxriXCVdH51vPKvtwAoaw31RpjJhjUGSwRwJMRPDokz0fqYLqhEfrIvfRMQCV
         IvPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsrKWKopDbQZa7+RJpuXyRDyay3/VFyAT5mAIcwOB/uSge8f5pyh+RrImh8Lq8VuvGCBPQsPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl35AJ4lB4l03FJp7ZYSFqqG/GuZuUqVvkI4WP1H17OmAZtEM/
	Qk41kE/Z5EEJDMsG8eeOJ6kvxrnRyPb3jJn0uxJAyxwsqSZrRtiWyDaCVX06Xzev3hDcRxjwQ9B
	Z2ufVFys4LXdGkAM+8Z6UThGBB24W9Dw6VDyCKiwZX1TSE/muLjDVjs0OEQ==
X-Gm-Gg: ASbGncsrtNgM4rqbfT5VrUutFK0MmMAZMGYplGGT41hgJVnldH9MwTH+loW9wNIj+m4
	wh/8udGbeGiL3EbcVZU5u2oUnjQK9vy076EphlPF1jCUWDBtditVHUX1c7Yq+AFUA+3Vqgkck9u
	jznSj1aRXoPgcz2cDEF7fKA+g1ONUMSGqz0i500wB+wbIxZD/WWM/IflXSDxgH2zumW2vPbeDWA
	9SZOJSHwheHnUGDkzzPiVKlEyLacrjOgwVdDeOVB88xULPSP/iytSeT0Q7o1L+igwGx3R9QqGl9
	AGjK776SHIF8vz877bLWDtCkRCuJtZLyJfTbXG9GVTTZoNMt0b/5CZN1TelyiPCA7N9gSysfqgA
	AHuuCWFKaFq+4gA==
X-Received: by 2002:a05:600c:3541:b0:477:9650:3184 with SMTP id 5b1f17b1804b1-477c0165bc3mr141142555e9.2.1764065109401;
        Tue, 25 Nov 2025 02:05:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdw5BhuyWaRQOc8C580uVcASiaAfZ16Z89gL80wDsCpr6kPhgTQUxoRiGKflA0cavmZi684g==
X-Received: by 2002:a05:600c:3541:b0:477:9650:3184 with SMTP id 5b1f17b1804b1-477c0165bc3mr141142165e9.2.1764065109027;
        Tue, 25 Nov 2025 02:05:09 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf22dfcesm246385055e9.13.2025.11.25.02.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 02:05:07 -0800 (PST)
Message-ID: <46765613-9a04-454b-8555-21f6fd965008@redhat.com>
Date: Tue, 25 Nov 2025 11:05:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 3/3] net: enetc: update the base address of
 port MDIO registers for ENETC v4
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: aziz.sellami@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251119102557.1041881-1-wei.fang@nxp.com>
 <20251119102557.1041881-4-wei.fang@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251119102557.1041881-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 11:25 AM, Wei Fang wrote:
> Each ENETC has a set of external MDIO registers to access its external
> PHY based on its port EMDIO bus, these registers are used for MDIO bus
> access, such as setting the PHY address, PHY register address and value,
> read or write operations, C22 or C45 format, etc. The base address of
> this set of registers has been modified in ENETC v4 and is different
> from that in ENETC v1. So the base address needs to be updated so that
> ENETC v4 can use port MDIO to manage its own external PHY.
> 
> Additionally, if ENETC has the PCS layer, it also has a set of internal
> MDIO registers for managing its on-die PHY (PCS/Serdes). The base address
> of this set of registers is also different from that of ENETC v1, so the
> base address also needs to be updated so that ENETC v4 can support the
> management of on-die PHY through the internal MDIO bus.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Andrew, it's not clear to me if you are with the current patch version,
could you please chime-in?

Thanks,

Paolo



