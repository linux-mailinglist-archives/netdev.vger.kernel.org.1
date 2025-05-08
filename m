Return-Path: <netdev+bounces-188985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4F5AAFBFD
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8743E3A571E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3963822C34A;
	Thu,  8 May 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUrhAVc5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8E621FF55
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746712176; cv=none; b=EwliRcsz1xfQ+5vAZ4mkOJC9xmMzavFcLwr/3+ftZfC5CoWrA+l6jmUnsLkADwWNydkIMcLV5NOaGBRDrGnJuXNRxXBg6PrkaBA/dN1fCpRZZm50EZmlyuMZ40RLeaW1kx6vu71avM+Zkrfh/8YpoON63mKN/0R8GePbQrd7dKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746712176; c=relaxed/simple;
	bh=OD8GxFlJxZjRjI0IBByxRgE9JRBwwfxhYepxx0fCF40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqGcLgIOG/LpAouO4Z0NXSZE/pG9KIlppW458n7TJVrLD5jcWtnajogR2vS90KcbW5jMW5+I75+2KXRnWbRWGKYe97P4EcnzrX7h6i4RHEwd3i8D9xDucSIvxmuY5IeNMwaXX7uvFRv/OHOzxfutXIQ/sSSYzFy1yxOTn0kAjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUrhAVc5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746712173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CywF47gXjpgY/l1leg6XrAUlD5bu0hAVfhP0zMhN6lE=;
	b=eUrhAVc5e9IHiT1mMYkaXvP4qGgPKsMj/TncqMuMbuwoBnFUihvpst+6d4L5XHB623qWov
	ViWem5elQGqYAKdNAOg0UrdDGbtNFS5iUMVF79iNZtdUg1TVn/+A+IMMKAutyFfPv/NrWs
	FiHwuCeT1vQils7tW8m/MsLrkW2qn4w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-gxXGz1SqMnKjK8TGlMsDRw-1; Thu, 08 May 2025 09:49:31 -0400
X-MC-Unique: gxXGz1SqMnKjK8TGlMsDRw-1
X-Mimecast-MFC-AGG-ID: gxXGz1SqMnKjK8TGlMsDRw_1746712171
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a0bcaf5f45so231010f8f.1
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 06:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746712170; x=1747316970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CywF47gXjpgY/l1leg6XrAUlD5bu0hAVfhP0zMhN6lE=;
        b=Hf7wOS56v3AGLzVu9dH8Rbq9f3frUFjw9+G2AUkR/xrb9UTQ4Zz8VmHQD4w+5uYNCT
         mkdtd8N3IdAy3rw/t+8z2wYCuY4jz82VoQYdiL0G+dJob8Ow1ahDtIqn1KlCwwRA8Wt5
         ncPuE74Q6U/mIw0roK6qO5llXJ5hiQAUDNUzZEm/I4xyApiWjwwi+u+m+A+Lsh2CGa2e
         luZhpIHqShlCIP2UJ5pZ1lEYdEJAMAIgs/i1PH0dxRWxCQ2y5QykFyrsa1YyZfd/mxHw
         LgWmojDhIspY9IshXiGIalJCTRu7CuGjsAK+cRHo2aIkQj60WHeHPd90p1Aaey1BDaVe
         fmNg==
X-Forwarded-Encrypted: i=1; AJvYcCX4WLbbX6M2RUQEIPg3MIafzLdeB2sHoog1T24qYERWrK0jQJMeEkz4IDz345ZxiRjPOsmP0Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZYyHgDCmly5ka398lVujTRwAMuhX1nE029mDeEwwEC26Dbm5r
	9kfAOsYoEnA0MFE03IpmX8iAu9D39E85Kjpda+Ze0N4boWffBElUP/vT63hHRypP4WMozsaZSCw
	ptWWXc91+kXY5q54CBr4nJNCv0Do5P1ghsey+W/qJICabBhX94GHMaC+3oRTROkH7
X-Gm-Gg: ASbGnct/DW6yaiaVeHTHJeTcCWkorC/wmKDxtjTRsC4nYFjiKbaZ/MoMM70Bfe7Dl7h
	ZrAxr2q+w3tFndAq+oQF2NG/Am4haSNwaIlPgLKIjgCapfR6gYM3vue5MtadS1BnUhtKF6tqO//
	UKcs15dQ3whrIqsG8j/WNfEN5lQ3U++9bbzsaO8kVtPZUZCbJi90IopIyul2siONaVqmstX/6P+
	pE9EuNpFJmAmp7Ptw/WqsqglpbC4wxv4KPw9sb+913OwNB1riysIw2xlVlC+wmlpfgq3E+sfWfd
	2pE24FMbrDBvhdDb
X-Received: by 2002:a05:6000:290c:b0:391:43cb:43fa with SMTP id ffacd0b85a97d-3a0b4a68652mr6692119f8f.51.1746712170397;
        Thu, 08 May 2025 06:49:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECjAERYWa6S2sVnLY/p8FyXyHfUJVuA1XUuJN5svWBMIQPW9IiG9y/gkXhSokA6jatooc4QA==
X-Received: by 2002:a05:6000:290c:b0:391:43cb:43fa with SMTP id ffacd0b85a97d-3a0b4a68652mr6692103f8f.51.1746712170075;
        Thu, 08 May 2025 06:49:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244b:910::f39? ([2a0d:3344:244b:910::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57de0b2sm42895f8f.19.2025.05.08.06.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 06:49:29 -0700 (PDT)
Message-ID: <23278f6d-f111-46f7-a844-2cd7fbf8b623@redhat.com>
Date: Thu, 8 May 2025 15:49:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/9] net: ethernet: ti: cpsw_ale: add policer
 save restore for PM sleep
To: Roger Quadros <rogerq@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Russell King <linux@armlinux.org.uk>, danishanwar@ti.com
Cc: srk@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250505-am65-cpsw-rx-class-v2-0-5359ea025144@kernel.org>
 <20250505-am65-cpsw-rx-class-v2-7-5359ea025144@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250505-am65-cpsw-rx-class-v2-7-5359ea025144@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/25 6:26 PM, Roger Quadros wrote:
> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
> index ce216606d915..4e29702b86ea 100644
> --- a/drivers/net/ethernet/ti/cpsw_ale.c
> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
> @@ -1823,3 +1823,45 @@ int cpsw_ale_policer_set_entry(struct cpsw_ale *ale, u32 policer_idx,
>  
>  	return 0;
>  }
> +
> +void cpsw_ale_policer_save(struct cpsw_ale *ale, u32 *data)
> +{
> +	int i, idx;
> +
> +	for (idx = 0; idx < ale->params.num_policers; idx++) {
> +		cpsw_ale_policer_read_idx(ale, idx);
> +
> +		for (i = 0; i < CPSW_ALE_POLICER_ENTRY_WORDS; i++)
> +			data[i] = readl_relaxed(ale->params.ale_regs +
> +						ALE_POLICER_PORT_OUI + 4 * i);
> +
> +		regmap_field_write(ale->fields[ALE_THREAD_CLASS_INDEX], idx);
> +		data[i++] = readl_relaxed(ale->params.ale_regs +
> +					ALE_THREAD_VAL);
> +		data += i * 4;

I'm confused by the '* 4' part. I think that you just need:
		data += i

to move to the next policer context. I *think* the current code causes
OoB?!?

/P


