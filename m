Return-Path: <netdev+bounces-215261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1BCB2DD61
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB04B5631D0
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2931A057;
	Wed, 20 Aug 2025 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ifr0tf1O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C23093CB
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695370; cv=none; b=EqDay8ejxyaIWv+6aQCUC3iuMULPZHXcWbUJ1jFN2xcmpdJK+UTrliwYDDpbheTrHJLLxqOf4T9L+M2zWZ8FDDO7+cFyerCBgnxPRMA5VGUdct0oAzUdyf5jy6MWXvoA4TzKKsC7zzYAnE3fkLZ5I1z2XgggJYw8lEvAfXU8wDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695370; c=relaxed/simple;
	bh=FEXjWKZ7j9gKW41TVi5lhas4ByO+JorZFuH4ehN8pSE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ljOLAJLDd+u2zFKM00bjtGQtKGUmX8R98K7CF1+BknACEV63x2i1lWLUSkjoM8oI54uGCCZQzLvdFMa+tn4btSrMgP1Nt7rdQKQOy0gH7uJkg0ADhgHkuGdG9Yi/60XRqUSTh4XWH+V1d/UzPZwSyPVfzeJCkxfPijsiR0htteE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ifr0tf1O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755695367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPMmZ6zRKIfrFWDZNXgVdvv8UMxp7S0BOvyouv50hn4=;
	b=Ifr0tf1OxDUGe9hbOeSBuoR1mDPML0dN4rvoirAuAX1dAIVa5Puqfot+u9GpwHrMun3wMm
	GIQDig9jcZ7t6b+pSwwpRLTvE6/WMCqkUr1RZdRZ6XVxRWS2hapfdcmbsrhviuSYxsWGoZ
	QfTuk+3VS5N7NYjwLtp+Yf640w4ql3g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-z8V46R3eOl2CVyp7G3wm2g-1; Wed, 20 Aug 2025 09:09:26 -0400
X-MC-Unique: z8V46R3eOl2CVyp7G3wm2g-1
X-Mimecast-MFC-AGG-ID: z8V46R3eOl2CVyp7G3wm2g_1755695366
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70bc9937844so43781556d6.2
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 06:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755695366; x=1756300166;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPMmZ6zRKIfrFWDZNXgVdvv8UMxp7S0BOvyouv50hn4=;
        b=j8qOfvlliig6KoVfUHdEAUGHPYmslPOI0XliI674OI/LnZxJW52WRFIloF5gKHHLGe
         /+ZFbzBhnZu45kFFrBVp9E7JxcOe7vELpdfU2QCWAuvXbbHJh4boO2+nUAePgdw3BoFR
         I2mZN9ETbMyimMgA7P2VjeaYIY2kxrvrwkt1AUW5mGwEVlAPyq4Oav1GnH9kdXqru3V0
         Jq8BVVi651gY2Yy4L+AjFXKZ5Ggi/A5khUpzy4f9chdQlzeelbPfmmFrQvbtzoYGjZGO
         DQsJp+dA3dE2kc4srBAkP0+x4ffdUWsKlJIshXyMoRcIdWeVJktmijkK4vnJZCVzexv8
         oClg==
X-Forwarded-Encrypted: i=1; AJvYcCWW9m9UIzvD0W4XgNHEYk3QWKDWmpEnZ3i2mQxknzmgWdmmjhBti7xFPSXL/BSJbjw5wIbxQe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3OD3saaROOVS0LF2JSoTPDf6lWm0ag9gGcrPTlAIUVIOgE1Hc
	cVlCrSEIfGMUsy4Dv6Gyc0NMEns91NZz1jQfQ5j+D3wc7/G5kxPyH+4WByDLIu84K7N1SuI5lrW
	9axNK8Wmy8iKRyqfNvP53TaIVSUt5QUW42TP6PNCPnr9PeXLrRQdIdPNslg==
X-Gm-Gg: ASbGncu2uL8YKBuyCMIujMnqGIwviVodYI+XJVuPYliNF8JV+XTTqGv0z261+gOaLeq
	9Pa22243UN8Jf+ewQYYFDNjIblT4cckk2lC4TbV83lhbMT3evm6Rv68A6pxg/3zThkk8xeC5dxW
	W6egAxRdv9xJkRFQoS6Z04dN3qzFgfYo7ixBKd6vAJqDgD5+06kzNgMfbwbTBLBI1ptcCz01WZY
	Fk54BdQsd/3hCLVLz2kIzVfkk9HLCn+pFrTwkn5kk1CWe09WBB8rBYfEhcuBTP30LaBvR15ts4a
	HzbMh5Sp2sP409QpRCbIVssWL6m97D5U5F5XveAQ/iI=
X-Received: by 2002:a05:622a:a06:b0:4ae:6b72:2ae2 with SMTP id d75a77b69052e-4b291bad303mr27150881cf.40.1755695364418;
        Wed, 20 Aug 2025 06:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6CDVMR8ZcLipXu4rcH+OG7XRzN7NLSTlOlrwN/6LFzDR4qGHtyPyzVaZz3BytkA8vDU51Cg==
X-Received: by 2002:a05:622a:a06:b0:4ae:6b72:2ae2 with SMTP id d75a77b69052e-4b291bad303mr27150361cf.40.1755695363884;
        Wed, 20 Aug 2025 06:09:23 -0700 (PDT)
Received: from [192.168.68.125] ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11ddd6947sm85787501cf.36.2025.08.20.06.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 06:09:23 -0700 (PDT)
Message-ID: <f5c3b451-0a8d-4146-8e47-be2c7e2d6284@redhat.com>
Date: Wed, 20 Aug 2025 16:09:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PATCH: i40e Add module option to disable max VF limit
From: mohammad heib <mheib@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, David Hill <dhill@redhat.com>,
 netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20250805134042.2604897-1-dhill@redhat.com>
 <20250805134042.2604897-2-dhill@redhat.com>
 <20250805195249.GB61519@horms.kernel.org>
 <6133c0c5-8a1a-48c3-9083-8cd307293120@intel.com>
 <20250808130115.GA1705@horms.kernel.org>
 <CANQtZ2wffk6jUTTMYFgTYxWQBc=hmw7nAkbYB2kxt-1ihUP9Rw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANQtZ2wffk6jUTTMYFgTYxWQBc=hmw7nAkbYB2kxt-1ihUP9Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Simon, Jacob,

I’ve also been examining this issue, as it’s affecting us.
I agree that handling the number of allowed filters per VF as a devlink 
resource is the best long-term approach.
However, currently in i40e, we only create a devlink port per PF and no 
devlink ports per VF.
Implementing the resource-per-VF approach would therefore require some 
extra work.
For now, could we adopt Simon’s devlink parameter suggestion as a 
temporary solution and consider adding the resource-based approach in 
the future?

On 8/20/25 2:33 PM, Mohammad Heib wrote:
> Hi Simon, Jacob,
>
> I’ve also been examining this issue, as it’s affecting us.
> I agree that handling the number of allowed filters per VF as a 
> devlink resource is the best long-term approach.
> However, currently in i40e, we only create a devlink port per PF and 
> no devlink ports per VF.
> Implementing the resource-per-VF approach would therefore require some 
> extra work.
> For now, could we adopt Simon’s devlink parameter suggestion as a 
> temporary solution and consider adding the resource-based approach in 
> the future?


