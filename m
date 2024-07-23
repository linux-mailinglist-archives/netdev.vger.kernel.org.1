Return-Path: <netdev+bounces-112546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2874939E04
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667EA1F2145B
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 09:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323FB14C58A;
	Tue, 23 Jul 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgtXNqLp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54531288D1
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727504; cv=none; b=CkaRA3JlKoNSRC60u+r0kvzI6R9xvT0H2yS4vn4omHZ4k4ck5hTCq2dURwDDShPz7HF6b6+al+0ejAHK/jcQAWCmLK3E6GLKJSNa3WyacowtA/fA9YfhohFE/L/7g5hj1+HeJIK0mZ96krI0gOwPdimC30mnM08BibqZDzvZgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727504; c=relaxed/simple;
	bh=qi1U91OHpmnZJssEm2/ypmTtBAiRYwVO8jtb7pd6rvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TK7TFRr5sAq2rM5lkV4R9m/mcXuEGEwjIB+Lu2dm1cgeI6I2W5RZvRWEvFNy9O+/d5vHGpvkP552M0F+6JNfGpYAxmCbo/YU4GqYoo8A+h1GwU/r4+Fhzem+N8gtRyI9JKclL1mV8q2fBNY9OC0D6Cf84+p17BImaKmH08TPUtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IgtXNqLp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721727501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpS43/XZvd0F+qWhTK9rMYXMOwLc+s9XDg94VmWtwJU=;
	b=IgtXNqLpn3FzaOmqvDwfCShzf4205wUgnFOyxGQwQI/YAxboJqGy4fP+BaUwZNxl42iyYE
	Z7X7VdlQPS/TXPY6W0Nuo9N26MLfeWRjHQGPZITI8l4MzqnYuktWxqNDmE2FgrVEwPhd4o
	wDiRdC3H3/lTLufcRlxqlS7AgUvDxpY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-gD03ZXL-MR6h5Ib3DajVCQ-1; Tue, 23 Jul 2024 05:38:19 -0400
X-MC-Unique: gD03ZXL-MR6h5Ib3DajVCQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3683794e6a9so892317f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 02:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721727498; x=1722332298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpS43/XZvd0F+qWhTK9rMYXMOwLc+s9XDg94VmWtwJU=;
        b=h1dhrP2q2CtOpRnyPRMqbS1bP89UDrRuoy3PJHoVHEf9ds4j9vh5XkaudKdSyGVJW9
         N+MR/T77I4JC1yuvwHrHtR/X1U1DW6BBrKNmJYRP4Z7pDhQF/zYrwaf5BPrtMwlH/5AF
         VjSAv7ZEEQRoccCqxRbqPpUlua2vjxzaDgl8TYPyobEhEEWyyS9PRP2lwcyaYsRzmPh4
         /NoKNtYZkr4g8KY3X/OjvaCR0kSo4q4hEtOky3s04ThqKPiTk1LIJCkpKq8rF10Qf+k2
         mVJoXJDOGrKAvl3GyxaToIXrvcnRdtimoIfYEi2YABRbg0921KoFTCGNMPF8pwaO45vX
         YJTA==
X-Gm-Message-State: AOJu0YwXXsMwej3/ir2JoJ7WAK33qafdLg28C+htG750/dGe1K29oTJw
	uzHJXqNEmZHu1tmbDckxfGYppk5l5fTaVRVucYVd3jMSlOaXniUfTNVhgT5rtrrQUkmHAfYJBrG
	XjYAwFA+/WU5FqHbNdHs9TPBlERyYOfV4Vl97w+z4q8l1EDrpznNgYA==
X-Received: by 2002:a05:600c:35cf:b0:427:9f6f:9c00 with SMTP id 5b1f17b1804b1-427daa928admr45700985e9.6.1721727497969;
        Tue, 23 Jul 2024 02:38:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhM4uOFxMDco1bb25xqWFLK8WcRMoSn2Z6vzwdkNy8MM3JEf6KEfSsox257uyK8/FDBGMvkw==
X-Received: by 2002:a05:600c:35cf:b0:427:9f6f:9c00 with SMTP id 5b1f17b1804b1-427daa928admr45700895e9.6.1721727497551;
        Tue, 23 Jul 2024 02:38:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a724fasm188539965e9.26.2024.07.23.02.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 02:38:16 -0700 (PDT)
Message-ID: <1fa043fa-2406-452d-8078-636679428a1a@redhat.com>
Date: Tue, 23 Jul 2024 11:38:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH net] net: phy: aquantia: only poll GLOBAL_CFG
 registers on aqr113c and aqr115c
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
References: <20240718145747.131318-1-brgl@bgdev.pl>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240718145747.131318-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/24 16:57, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Commit 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to
> start returning real values") introduced a workaround for an issue
> observed on aqr115c. However there were never any reports of it
> happening on other models and the workaround has been reported to cause
> and issue on aqr113c (and it may cause the same on any other model not
> supporting 10M mode).
> 
> Let's limit the impact of the workaround to aqr113c and aqr115c and poll

AFAICS this patch also affect aqr113, I guess the commit message should 
be updated accordingly.

[...]
> @@ -708,6 +702,25 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
>   	return 0;
>   }
>   
> +static int aqr113c_fill_interface_modes(struct phy_device *phydev)
> +{
> +	int val, ret;
> +
> +	/* It's been observed on some models that - when coming out of suspend
> +	 * - the FW signals that the PHY is ready but the GLOBAL_CFG registers
> +	 * continue on returning zeroes for some time. Let's poll the 10M

Please address the typo above as noted by Antoine.

Thanks!

Paolo


