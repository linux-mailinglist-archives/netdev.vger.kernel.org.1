Return-Path: <netdev+bounces-200638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C579AE66AA
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54CD67B4A8A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972C529B206;
	Tue, 24 Jun 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZwLVjHV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE80548EE
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772241; cv=none; b=KiM5aul534r4OlU84L4175+BomIMhHssA05WHF88pCM50z8RSb+4pzBBHdnKqIEr2JZoPlBIDX5IQiOzcmR9crTQ9Rdhs/vbzYGyAfRmArvvrgIQhr4YW95wVwjD4rxmZTsWJe2yLtFATNUdtGz6o0fWei4i5sPEoTZ8DvbnNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772241; c=relaxed/simple;
	bh=w/IDMkNJyCUUzyRjdmPql/8lwhxsnPEA40uW7VzKY3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbMxRGriI75IZayS8slayQi2SrtDdq2JfANFdDK82OlDtufMCI0CCZoOalo6LtWqh/r7cpRV5KRfriUxo9Ndj9mRqQ2Rcbc+dcMU/2kDzY0XJ+QdlPZ6xAdSfcE++stLZWl8t88PTspHRAGwR2odoHqw/jkvBWDXFjZu8RN7nbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZwLVjHV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750772239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdLNi82PU1S92ENBnDfDaMCmZjF6GA2bHRYIMCa5Xtg=;
	b=CZwLVjHVxraU7h8CzE7F4dY+qYxZjBlszzfB2qNF8T7B5NH3cDWAwgmtvgng43I4APshJR
	93obTMNXzv64NccZ/+d1OyhW+NrfDcuyrZtTmzUt1DUluG0H0W1Pm+cg6Fby5rv17qZu5m
	6sOhi5UPy+JTI3voewjoeg1gAGclF+Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-Y7NZIyANPECvOIsE5vDZ8g-1; Tue, 24 Jun 2025 09:37:17 -0400
X-MC-Unique: Y7NZIyANPECvOIsE5vDZ8g-1
X-Mimecast-MFC-AGG-ID: Y7NZIyANPECvOIsE5vDZ8g_1750772236
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4537f56ab74so3239115e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 06:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750772236; x=1751377036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdLNi82PU1S92ENBnDfDaMCmZjF6GA2bHRYIMCa5Xtg=;
        b=XVFNuuu4nZe9zgQDklIhiE8++T/pl92sOyK3E8gjsfhpWvTROUHOc0s3waSFt5qVsA
         gwz+4RkeyzaJsyYVB2Xa8CFZbfO1cqQ42VygFfu3tqlJ2aBpcWTT82OC+66E/YTMoG/O
         LlAjBQzQDe8mEy/ndbNce74KFU7dYGRG375Nx+gSn7gwjFBGfnT1HPrvOnbP5lvAlubU
         ad9V27YSAklhk4pMXZkiqcuPq03XG0UkMlGCZkC1W2Qs++0IwJFKYttwCswimKTjCnoT
         mnFr2sZEkLBOBROb9tp+t6hsoiusRWrJPiK/Had48cZFmn9sN+m5FgNXMlJKokubd1OS
         L8oA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ6CCvKbdO/z6ctLk+Az1S3p1BQhuxQt3AuEy7ExNyHjlIYWx7NtmGf2nNZ/sQCN3OUo2ZoNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKsP/UsgRy7w2TDMjI7gjI/YQw4gGn7HdSnQHlwOR9g6S+H8hE
	WuXODI2EF1yAlYApLcGLBz+OhXZqqo56kfn3OxxuOrA116A43UDWNOYE7rFwvmtKQEnXfuzCQOL
	CQb55X7N8GgAeDNzb/bQkdRYpxd4KeR+9SE3BAcH9l5AkFXhOO6GmABfnNQ==
X-Gm-Gg: ASbGncswIfOpLmi/JnZZMeI38HkGN6PJi+3sQb98n8p8eteydDoI3N1o/6zOJX6swDx
	A+txpE2i/ZxTqWIkcIu7JNCtuQTwTcl8gw26eI5gUIHkmSr6QF6bQq0vm5iYY1SE4YC1keB6Y5N
	i5fhrfbymgiFfb29jsAXw6ugXZ47Z/MLsIHVmOR4VwSOO8Ts0lEL8SZ3FncolsriRqiL5Dhag55
	5zvcIUkF1NXRLxMBT7b6Etp6TeAyV8Aw3UsuSNsY5hzpsT1p1eMTP4GiquDR3QwqJOXdyOwc/b7
	TfevsN/TFcmbYMa5o094al3xp8ZiFA==
X-Received: by 2002:a05:600c:8b67:b0:453:6ca:16a6 with SMTP id 5b1f17b1804b1-453659c9b5cmr178056575e9.10.1750772236032;
        Tue, 24 Jun 2025 06:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCDctwjBQaSlAXYgDwmWAr33weRLLnC8b8hgrnzKmiQvzZklRmZK8SJHQ3VS2Chx7RMg6ong==
X-Received: by 2002:a05:600c:8b67:b0:453:6ca:16a6 with SMTP id 5b1f17b1804b1-453659c9b5cmr178056295e9.10.1750772235622;
        Tue, 24 Jun 2025 06:37:15 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646fd589sm142741035e9.26.2025.06.24.06.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 06:37:15 -0700 (PDT)
Message-ID: <17f789c6-cf64-4940-ac7b-0107b7b96031@redhat.com>
Date: Tue, 24 Jun 2025 15:37:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v13 04/11] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20250622093756.2895000-1-lukma@denx.de>
 <20250622093756.2895000-5-lukma@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250622093756.2895000-5-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/25 11:37 AM, Lukasz Majewski wrote:
> +static void mtip_adjust_link(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct phy_device *phy_dev;
> +	int status_change = 0, idx;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fep->hw_lock, flags);

The above kind of lock look incorrect. In later patch you use
spin_lock_bh(), and the context here is never irq.

Should be spin_lock_bh()

/P


