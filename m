Return-Path: <netdev+bounces-200753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC435AE6C20
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604967ACD2B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377482E11D9;
	Tue, 24 Jun 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="GsWpsWZz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846E3074AB
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781333; cv=none; b=qIegA/+9MOxNEPEFP8c0RPOi6+IUIKtFuRvQ32c+oD+K/QHN4vH8xe84aVAgHCodJMLY0kPNVaS5pL8W9ZibTBaQQX6Z++7bJPf7nPBBCnfkW7D5MHDg6KE0x9SZDGZTW68dNl9OhdOtfzP1SiP2ztvgIZ/ExlsFAjyF5QG1KG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781333; c=relaxed/simple;
	bh=FHd2sb7X1KnMiTkFvomFX2j5X/HR7YHKbCz5mptOfPw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tl8OPcRrSf8uhhemD/pBrnGVcqLRd4qz9Cu5tsU06eA/v3oKw5emYsW5e4XPVKS4GOlPBdhBB56mXXWlJvm89BFx/GkWpTQYhk+oMfhK/paW8smPUUUSCbugUWrLHbOJa47gbPtPvSD+9nSrAJ2gFi5Ncy6g2aYP9BTdmBVVuWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=GsWpsWZz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad8a6c202ffso1038493266b.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 09:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750781329; x=1751386129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WY8CeVnLl9pE8ZwyaPrNepgc1WZAVINyiA3X1eItW5M=;
        b=GsWpsWZzs69Pg70rgj9TLuZlOZ3ig2AY9sBVJlb7hOEdieQbd4/v7pR5StqALdhIJ6
         4UZk8ZLth3+dkZ2yTpt1ud5QcyPmPsuILunOvirqf6S/ck3KpnTlfSazcyQ2owpuS66h
         XWiWQcY6nq5iiN+krn1lenxSYKME6UFuAFQNSUPkm4dG7Zj3rp9jKry6qi9GHOnx++Fe
         SJQ0+ZviDTqLkCQ/CiVntToIKc18L1p6mi8ZUHLn7xEZicQL/MB9I8hzT7+OWs2Uge5d
         BAZC2cQAdsCwPRkeMu2/+Lcns5FuIqUAgMuGqXQc4wqpWp4UY6tpqzC+aABk9355TAsk
         cYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781329; x=1751386129;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WY8CeVnLl9pE8ZwyaPrNepgc1WZAVINyiA3X1eItW5M=;
        b=SadIwpJeR+1oSPMdSz7fEypB/bNG5cxPLYOsLFqY+6BmjKdkuB1018+LBydDfikw+t
         KMAh7STK0flBRSS5fchKOej1GqgCCtAJGbmvtKdaOCYSUF2FwbV6HFs+tVFp2XDuM/Z5
         C53Pf2V/6zjnswjzwsfVMKX5n52/lsMvr4Dd+ZALF4T6Epade0Y4k94H2FsspyjWR/qS
         /NK6FFwwGW1YAnyFNnY4c+yZoWMzSBFH2jhhOXaN8Oz41jYpIs0P2pMzBY9neqxpqL9b
         xGyZk2qdPmtMVlamD91IJ9vw0ThxhQUSwcRJYeaGs/tFYTU0si4HfdAw12WfN+Gnp7+l
         PPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWS+nlX3pESKfdrc0yrIvrVq1cxiuzf5tYN0x9kxQdLsDUto6fLALbv2TxVE3KHh2m2aqYu+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmWYCbcIJBqfdbtVBlKn67lznbPtJrkxlkbSDUJuyYOCb+/fKy
	QftW12EJhEa/dMXTFXCF4Vog+SndhVH1thmTfUHhhPs0ayIg8mEn5wx8AtOs5MNNRuVtICoZMe5
	Lud2FNw==
X-Gm-Gg: ASbGncvdhQJtBmOgRP2YNwXuwq4flbtLRJZrvrQv+oYnWtd4dDabjJhCjthJJuElzBD
	Qoi8vqf67h576n3joOGDidagyIIHAOq2XZw+/4vYn0hjML35lIqun2q+aIeTOIcQAoyvZtpZQbj
	iJWNeaF6KVDw6YJIyhyiLL4OGY29RTlfp9H+ogMHLvd0ZlAS3N1NkIGIGXCwNqMC1LJSGWxLzTE
	0O/mrnkdNIpQKU8xT6/oRMIAKlFEeUlQ/PuhL1TpG5kjUqhTAdQeiSzh6sWijejFCppLvIf55/u
	BEk+hVyV3Qh8anMDdGb5QNiwTkgWvsRqcX47DyEBYthuOka8oYUaM/kKZ4fkM2IJ
X-Google-Smtp-Source: AGHT+IH2pH0T6i3mZs7TAt1UWsCRfOAa+jl9+T0R72UNW3AbWhpd89UJ/JuJJF5f5GKRJDyujV2Y+w==
X-Received: by 2002:a17:907:9809:b0:ad8:9c97:c2eb with SMTP id a640c23a62f3a-ae0579c1161mr1750959466b.19.1750781328829;
        Tue, 24 Jun 2025 09:08:48 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7f949sm896228366b.34.2025.06.24.09.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 09:08:48 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <b4a3ddf4-c03f-426d-868a-f6e75cda179a@jacekk.info>
Date: Tue, 24 Jun 2025 18:08:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] e1000e: ignore factory-default checksum value on
 TGP platform
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <fe064a2c-31d6-4671-ba30-198d121782d0@jacekk.info>
 <b7856437-2c74-4e01-affa-3bbc57ce6c51@jacekk.info>
 <20250624095313.GB8266@horms.kernel.org>
 <cca5cdd3-79b3-483d-9967-8a134dd23219@jacekk.info>
 <20250624160304.GB5265@horms.kernel.org>
Content-Language: en-US
In-Reply-To: <20250624160304.GB5265@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>> +	if (hw->mac.type == e1000_pch_tgp && checksum == 
>>>> (u16)NVM_SUM_FACTORY_DEFAULT) {
>>> 
>>> I see that a similar cast is applied to NVM_SUM. But why? If 
>>> it's not necessary then I would advocate dropping it.
>> 
>> It's like that since the beginning of git history, tracing back to
>> e1000(...)
>> 
>> I'd really prefer to keep it as-is here for a moment, since 
>> similar constructs are not only here, and then clean them up 
>> separately.
> 
> Ok. But can we look into cleaning this up as a follow-up?

Sure, I'll prepare the patch and send it once this series is applied.

-- 
Best regards,
   Jacek Kowalski

