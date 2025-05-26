Return-Path: <netdev+bounces-193474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA49FAC42B8
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7501B177F02
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420EA211A0C;
	Mon, 26 May 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TguBwEDd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAAB2566
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748275110; cv=none; b=YQpexX+97NsZohaOYwFUWwnaPj4eVzC6o8NUX+VsGv/j03UsBiLDIx/yc2etYMwIiHutsWn6POv6MOpPJrC5VoHbmVsmX2EIT3jq7uWQbHZaTucu4Hxgrc+ZqwRzKE1oJGErz9Wi/8s7akFHkqIWUya2cynmQ2CdWBtJ8oU4jQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748275110; c=relaxed/simple;
	bh=LaFEsq0HvB9vr4NaAcRMwoScIc427WLEmDgdNFDZnT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffxYU0XrrQU3xsBEUQWY+O0QUUYG0O5+XMHD6ZfnB+ACScaoMLPi6t5dEFi6plx8Rp4F65p/b9qZHr7sIEbPCG2WYG82DQTssg0Bh7PnF/wD9UA1yk25l7a977tqrukEISwwtW3vvJB8cEcI0Je2pO8c2bNZYja+HMxCthcCmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TguBwEDd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748275107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSybODuSpim2xb5ecUjEV34I5epjrpdilRUFqZmAtNw=;
	b=TguBwEDdp4S9YGftO0wIto+2l3WPjLzxWKekTxsRYTygFMrSauv+HKhhMgnx0zZu59uRXG
	uTu4my6sr1V3tvjm16Soz6WW86RjqMacam7h+18iJFms2mSj9b8GICKlAFWYa6k6wrFckA
	uupHxLcbQuHT/sAAc21H/xPHB6kgiWo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-oSJ8gfs9Mp-dwqzpEge3vw-1; Mon, 26 May 2025 11:58:26 -0400
X-MC-Unique: oSJ8gfs9Mp-dwqzpEge3vw-1
X-Mimecast-MFC-AGG-ID: oSJ8gfs9Mp-dwqzpEge3vw_1748275105
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442ffaa7dbeso17818155e9.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748275105; x=1748879905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSybODuSpim2xb5ecUjEV34I5epjrpdilRUFqZmAtNw=;
        b=LZ+gFcPRpPMV+1rHxif6EhecWza4pitbReP1L7HJeyz5RudYoQsG9+N2NsRFiAFC7a
         vQjbvyrcqnDSvi/PabMVFq0n/4IGcROzxqOgsfBOpq4xgenlzGewLYWs7cbBXssi7jGB
         j/vg0M3syGyBt8W1D5L4CeEYNC7My71WDzkE09gqewZC264au9pemHR1yIPgirRuGGW/
         itequG6fqnZ4h6sXir24ErgqfoR63SbcLNN9SjhPbUSzzXH+JJs3q6ZlOQrnZhM+8+r+
         CAB0+SHWW/1JlPBd4bIZnuz0I2TUs+KlvRDnP96FNWKlub/sCDQNp7vY2TYhZu/6hZZM
         lnfA==
X-Gm-Message-State: AOJu0Yxp+xd/ZZEpCPI3GDPUm6zQj5PMnG4L2meXmi7rMBiuX0xfj6Ps
	NE0dXRxk36EYAugIkh5vxFTO0ysq0OrERFbjYmUK9fVeBE4Nkkbu6zxMOyezdz52DFqkwon+TL1
	Ml5kib2deWlTg6WXNtHImxuNlcfnk2FsuXTl4dUl856IyxA5MTMWdczEOmA==
X-Gm-Gg: ASbGncuOKZJPJ6gFF8LpkJrWrqTiZpuCBbtRuwh5UKkZohWCCw8jR/mREfQZTOXcWu8
	CxLd4rspiQt9Ohh0LFzkEcTB3ZnLf0wTsuo+APGL4b0cCuFXDAS9eiR1rw3dYfG5XIjivLG5kZ5
	P07nts/TCgiBuIOv36KwvdETogjtBgoGACeSVDWACC2n9bl1iGU4SVu+51TUtcrL9AnorXCGI9A
	1OLxDtn6WR2niEp1btNLoOw7Z/9h3hBFi6zvyw7a2Gs6FIPiXsCeGtFn7qjVIwO2GQppFcyxfzD
	PIQrWiPGeTiOU8tFluc=
X-Received: by 2002:a05:600c:1e8e:b0:43d:7588:6688 with SMTP id 5b1f17b1804b1-44c91cd5140mr79858695e9.12.1748275104831;
        Mon, 26 May 2025 08:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaz2/DahdwY7xm9KuhltKb/hfFgL621ZMWkKswp0RZ7mvRzfJ8eI43LuiT7V7CFnuroB3R7Q==
X-Received: by 2002:a05:600c:1e8e:b0:43d:7588:6688 with SMTP id 5b1f17b1804b1-44c91cd5140mr79858545e9.12.1748275104451;
        Mon, 26 May 2025 08:58:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d37498e8sm5450416f8f.16.2025.05.26.08.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 08:58:24 -0700 (PDT)
Message-ID: <3b7aa4be-bfb6-4c31-8f98-96a2d9988f86@redhat.com>
Date: Mon, 26 May 2025 17:58:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: Add c45_phy_ids sysfs directory
 entry
To: Yajun Deng <yajun.deng@linux.dev>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250526140539.6457-1-yajun.deng@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250526140539.6457-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/25 4:05 PM, Yajun Deng wrote:
> The phy_id field only shows the PHY ID of the C22 device, and the C45
> device did not store its PHY ID in this field.
> 
> Add the new phy_mmd_group, and export the mmd<n>_device_id for the C45
> device. These files are invisible to the C22 device.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.



