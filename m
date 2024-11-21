Return-Path: <netdev+bounces-146601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3D99D4866
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BDA1F22440
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 07:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED221C9EAC;
	Thu, 21 Nov 2024 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5Z6/4h5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942181AAE37
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732175809; cv=none; b=s15k/TK0lSsJpnNo9wvPjywwEDipdyAV40iApN6LIjX4mPPzhy043DegsZIrS2LU8lXpyo5NcCx8SE1TZD8PugBSDcrg4M9p7fkDcDTwEz67CeHn8qC2fi2m3AJbmaQM9NMxXGDmMtXdtnhhKT5aMWwwgDnd4nspd9mgDagq/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732175809; c=relaxed/simple;
	bh=0UUY1iK+qbSYtbagsSs4Ufir7soHFJ3WlfPQ18B46Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSqpk6ZFHdf9damuBg3It+p+DUBxGxzJn8yAdiAk4Kwp87/WVcmI4Lp/jPGuvZw6ghuISsE4LmhRRhRIVNLXksHrTzPzPwRM/0GXJkHUrfUlPoJI/tylAgcEKjQmgdkjCs7NJLcTwu2dtYj57roLw4HHb0oNiDyjd4ErY58txV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5Z6/4h5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732175806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92gCfLlbkoSQ+MHQdw6XXaTfuBEXHZVZp1ICXYhuYKw=;
	b=L5Z6/4h5BRYPI3IxTI1Ag3vkjcl0fZCtUkZC04g/5OYNBz0LSq3esjw3HYarhNDV29VlZy
	+sejZYVV+dFkPzncvMe0Ao5lN9L47u0BUUrO8W0qMGcToUpUVruDQQwNxzuIjSWxs/VerA
	bxtI5OrkoSF+Va9h+ZHVJ96JNH0jVW8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-3xFdp0fHM1-82bgQv2Y3mA-1; Thu, 21 Nov 2024 02:56:44 -0500
X-MC-Unique: 3xFdp0fHM1-82bgQv2Y3mA-1
X-Mimecast-MFC-AGG-ID: 3xFdp0fHM1-82bgQv2Y3mA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4316655b2f1so4007905e9.0
        for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 23:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732175802; x=1732780602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92gCfLlbkoSQ+MHQdw6XXaTfuBEXHZVZp1ICXYhuYKw=;
        b=ML5+7hY8jSrOVS4vZmiMDM4QT8r2STsv4C8sYhglsunHNZFAyxQDLnFMR9HYngRWhA
         jU9i5TdizwNEEArz3IZa04RoDtV7va9UL/SyJaRTZGK8hAwJnOAKc4Bd7+wQhoL72ffO
         5M8NHUdTieODsUCF8oJ5atRUtcJkNrd5WCcuMQWa0FB6ryGG7qV8ZLQJH3dH845U0x3R
         ypmrhtiK3YHTQsTIW467eIcy9tHCNyeqNCViyTKocw5+YJcEj9jbt6gH4epVTNp1edTe
         lZNTIcuRHSRTtnKwPpSbxYOSLtA0xTYS6k4nxNpVpwEl84xrCcIc6nwkhAfn9x+S33+m
         DllQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDnhLXnteU0hFxzdMKf7b9nobMvgnM9WTWyXoRLmpzCGy2XwuEMkUc+8F58OxtggccydW54IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDr0FZnoIClO/zfa4CFAfoodxPIRlJchbMWMYj3VPKfaQnQpTm
	dME6MUfQIEIb5WlfV8zmS2ZRRGwiufULzJJwC27c1Efal2kNLb4A2Nf7Yj8+eHJVNQBDqcgnk1E
	5aJT5B7Lh8vhVgtzoDfXNyUBFeRS+eSdBCcE2HOJdd8LBmNzm/dGnCxL1xJS4tA==
X-Received: by 2002:a05:600c:1f89:b0:431:60ac:9b0c with SMTP id 5b1f17b1804b1-4334f022976mr44764405e9.20.1732175802514;
        Wed, 20 Nov 2024 23:56:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9Dv/HXrS6bFeraR7f6sCHP1IXYQOcRMLqrn6BC9ptxW9TsIBcM2hZN2n9VyoonPSe3ABPUw==
X-Received: by 2002:a05:600c:1f89:b0:431:60ac:9b0c with SMTP id 5b1f17b1804b1-4334f022976mr44764195e9.20.1732175802157;
        Wed, 20 Nov 2024 23:56:42 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382549107f9sm4076856f8f.51.2024.11.20.23.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 23:56:41 -0800 (PST)
Message-ID: <75abc41f-a406-4562-9282-bcac0010545c@redhat.com>
Date: Thu, 21 Nov 2024 08:56:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] net: microchip: vcap: Add typegroup table
 terminators in kunit tests
To: Guenter Roeck <linux@roeck-us.net>,
 Daniel Machon <daniel.machon@microchip.com>
Cc: Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241119213202.2884639-1-linux@roeck-us.net>
 <20241120105202.cvmhyfzvaz6bdkfd@DEN-DL-M70577>
 <24a5975e-a022-4bf4-a2ec-76012f977806@roeck-us.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <24a5975e-a022-4bf4-a2ec-76012f977806@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 15:58, Guenter Roeck wrote:
> On Wed, Nov 20, 2024 at 10:52:02AM +0000, Daniel Machon wrote:
>> Hi Guenter,
>>
>>> Comments in the code state that "A typegroup table ends with an all-zero
>>> terminator". Add the missing terminators.
>>>
>>> Some of the typegroups did have a terminator of ".offset = 0, .width = 0,
>>> .value = 0,". Replace those terminators with "{ }" (no trailing ',') for
>>> consistency and to excplicitly state "this is a terminator".
>>>
>>> Fixes: 67d637516fa9 ("net: microchip: sparx5: Adding KUNIT test for the VCAP API")
>>> Cc: Steen Hegelund <steen.hegelund@microchip.com>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> resend: forgot to copy netdev@.
>>
>> You are missing the target tree in the subject - in this case it should be
>> 'net'
> 
> Sorry, I seem to be missing something. The subject starts with
> "net: microchip: vcap: Add ...". How should it look like instead ?

The correct subject should have been:

[PATCH net RESEND] net: microchip: vcap: Add typegroup table terminators
in kunit tests

the target tree is identified by the subj prefix - whatever is enclosed
by []:

https://elixir.bootlin.com/linux/v6.11.8/source/Documentation/process/maintainer-netdev.rst#L12

Please don't resent this patch just to address the above, but please
keep in mind for future submissions.

Thanks,

Paolo


