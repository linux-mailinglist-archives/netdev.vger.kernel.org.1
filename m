Return-Path: <netdev+bounces-140751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5E99B7D20
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A060A28436C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAD81A0BF3;
	Thu, 31 Oct 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXbB1bHa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F01A08B6
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385713; cv=none; b=ZdoKBYBXkOzf36qQ4u6Yvb0uGnGT2A2Vng7j3ooB9kjBalNM819QOv5pWdAQnm0bVvVPeJJJVDJexZrdmO3AhgNUFcWkx908rATBrWbxjzwGJHn4pQwoGRXcxELYOKnqFx8xmdFdQdFEAMft9nuksLubeclIKgSnRH0bw0kILvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385713; c=relaxed/simple;
	bh=9eS5ge2alX9b56f6i6Q7sWV1uG4Sj94/LDvot5kpaqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p221E+HDbdKQKtcRnj7Rq6ml5FRe/fPOpD9m98LT2QsbzgRFAHJWMVdTeNVRfoAHMb0xljvX6U/BBq1K+5mbiqpsJQ/oEbAnv0vL28g1fSo5hmeTa9qbAYtBBHG8U2jMkIFkIHQ62gNL/US4C3TweRzlsfM0edQDEeByiL4WP04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXbB1bHa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730385710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dlgmPQjrWN8bcG64Fgx2fujRr7yOykhTLvlfDSXZU4=;
	b=RXbB1bHaLOPFkF5P4Q1HlDCfpE9N9x/AuP90LlxqSIIInEHytJBE3tvvmE+FkUYIyWVhor
	hzt5EGgYB/MbC7FVdI1G8dqndzjAqvHnYWTyuoqaBYyg7x02Pw0HukKciYjwnyB8fQfuaW
	1V3ZrY+tsumXeLO9mtIvlAl5Wej03N8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-wox_es_FO6io5Mam1_33Bg-1; Thu, 31 Oct 2024 10:41:47 -0400
X-MC-Unique: wox_es_FO6io5Mam1_33Bg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5a3afa84so503620f8f.3
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 07:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730385706; x=1730990506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dlgmPQjrWN8bcG64Fgx2fujRr7yOykhTLvlfDSXZU4=;
        b=wCMbPw0CUydS4Gy7Y827dAcvT4gupyLQ8wg5Gm2ddxSVNv7KKMwHDCNLES63TNuRZo
         YuxXvjS/z85RPK3iMx01AEBB/V6QJ/M5r1FmoQnE9T7UwY3slduaiMSEaSELE8dW2dKz
         CKMa8+ubTkp+TbvZIJdgE2P73kcAPdCKe6+OnosPhCJCrNlq8B/IqbSY+ECnPsrkP9/D
         RbxSXwJhYd/ELl8xnnEF+h8dtAWIvC34zDxSsJIvVjcTJ9eWjHLBv5Ubge6C+5MQ74uF
         98Dp6GhwcuSKN9QVVWpCedrJEFi4kflafwczDZ2fJdyi94t55OxA08/B9pPtMpos86Vl
         vB9w==
X-Forwarded-Encrypted: i=1; AJvYcCVMhWr+vT6N+q1ZNAxvY2WBF2hj87xYDuKJFNTJDy80uqmCRu+UIdQn7RVPvD6+3JIeTOq9PZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6iros3znAOtlJyh0bzbBVvMPK4lKM9tsXH/5W5+HJHO1Fxjv
	bO2orPmO1LfZv13z1QIqlFAP963xjYWw1KMHPfLl1wX0QzS6fGTHO1vlAcbVZpTVv9XlFVnR/OY
	rCiuy6RFOIbPE1tHj51H25Yk7G2JnrjMbYbyhg/6j2NkrNqD1HMNgwA==
X-Received: by 2002:a5d:6d0e:0:b0:37c:cc60:2c63 with SMTP id ffacd0b85a97d-381c7a3a23dmr216433f8f.5.1730385706492;
        Thu, 31 Oct 2024 07:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg8FMucp/9+qkpBZFRMIEgFHrJyFQGjPuPNs4cDJVO5fafRU341aNOfiA7iUPsBELpgYtCyQ==
X-Received: by 2002:a5d:6d0e:0:b0:37c:cc60:2c63 with SMTP id ffacd0b85a97d-381c7a3a23dmr216386f8f.5.1730385706081;
        Thu, 31 Oct 2024 07:41:46 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116b11esm2278221f8f.104.2024.10.31.07.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 07:41:45 -0700 (PDT)
Message-ID: <3e443eb4-d15f-45ff-8b41-a8215fb4032b@redhat.com>
Date: Thu, 31 Oct 2024 15:41:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] selftests: hsr: Add test for VLAN
To: MD Danish Anwar <danishanwar@ti.com>, geliang@kernel.org,
 liuhangbin@gmail.com, dan.carpenter@linaro.org, jiri@resnulli.us,
 n.zhandarovich@fintech.ru, aleksander.lobakin@intel.com, lukma@denx.de,
 horms@kernel.org, jan.kiszka@siemens.com, diogo.ivo@siemens.com,
 shuah@kernel.org, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 m-malladi@ti.com
References: <20241024103056.3201071-1-danishanwar@ti.com>
 <20241024103056.3201071-5-danishanwar@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241024103056.3201071-5-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/24 12:30, MD Danish Anwar wrote:
> @@ -183,9 +232,21 @@ trap cleanup_all_ns EXIT
>  setup_hsr_interfaces 0
>  do_complete_ping_test
>  
> +# Run VLAN Test
> +if $vlan; then
> +	setup_vlan_interfaces
> +	hsr_vlan_ping
> +fi
> +
>  setup_ns ns1 ns2 ns3
>  
>  setup_hsr_interfaces 1
>  do_complete_ping_test
>  
> +# Run VLAN Test
> +if $vlan; then
> +	setup_vlan_interfaces
> +	hsr_vlan_ping
> +fi

The new tests should be enabled by default. Indeed ideally the test
script should be able to run successfully on kernel not supporting such
feature; you could cope with that looking for the hsr exposed feature
and skipping the vlan test when the relevant feature is not present.

Cheers,

Paolo


