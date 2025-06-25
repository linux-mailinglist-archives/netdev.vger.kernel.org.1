Return-Path: <netdev+bounces-201140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210DEAE839F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C0E16BC1B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CB925F99F;
	Wed, 25 Jun 2025 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="UHhwSQDE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A98633A
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856710; cv=none; b=kQtocsghjRsNXluBTmfiJoG6DWCCOG35E2zji4mqBBa12l+iS/2bI7algrjmxyNyByWJ7crFyWMQTr+pZ9a3+zCpv3+e+EEfPwYsElkeM3IEKVnvj1rChcIGiQtdhRn/YBEqb8RURFVhbbuBZjY1fcxzCSDYcrlLIS9B/RQZY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856710; c=relaxed/simple;
	bh=cQChFIpemYCEU2to3qepypyGDWAJy+q5e4OEX2BidPc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qlff6qiV1srrnbxgo+fR8BSjPO7yqs/NOBqzdehVNsKS0MGsRx1L7oCpfBUcRCdunr89vYcZtslHuJcYklfsE/DoaMk5IRFMUHunG7OvhHBQQ1jK/ICbm/fwVyZmU7dMIxsCdVornSL5I/zgq0LJ9DR1MT25erQPE/QEirhpiCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=UHhwSQDE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ade4679fba7so279210166b.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750856707; x=1751461507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NSJW3n5WDshYJ48Euz3P/Df3ZQsxS6XzFo5zNuEInuk=;
        b=UHhwSQDENZ4o5z4XYx7BFX0va9MYcdJi9msZYls4fl0Fq7ACICy1kZjjpsOpq4W5+q
         TJXuCi7EbJzN/cTQy2BbDe3QnI32hbxcpjMkH70nJiUpivynibREbqUex84BnHygiUGg
         X2NCn0kgImsK1PAfpWbIK0fk92UMKobsCVJBW3bQhSXa3wVvZEBvWDMzwn/7Mgf5zb/T
         E6wGugN4gYJgt9Ayziq63Vv3Tv1vSMMLO03vjPbYqEs+NtRD1EZnJfzOJy/TvkVKG7w5
         zgn+4vufCywKEElVxPWcpM9N073jlieXzXanRfIagLHzU9OesnzakB1tvO2b0x+Flcot
         RYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750856707; x=1751461507;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSJW3n5WDshYJ48Euz3P/Df3ZQsxS6XzFo5zNuEInuk=;
        b=psUmPY6v9nX6bnru2Fxr/nlQiPMUEgVR1DpEBHG/WjP707D8jwsfUWQLyEroxMdWsy
         DgdHV3swmDlJHvt3FtcAM/C5euQbGgi99oqAEAFmhyLxKH7CV4zGhcLSkuift8662VGV
         5i0QC2TeUcB3JgO8BrKjuEyhizKKT8LgtQ/+23eG1IjB1r7eqjpwqvgwz4rqLyfV2T4W
         t1YE4gsy3gAPNlaOUWwt2ytnTMErkWz+hWex50eZRoI1uUUXC28fy5pTyC3U+rLttuT4
         H53INzfFy4OqHJwd+92ovimwBLQumycbF5GqB+SY6mEFxTpkDqwqsbRE+y+0Pve+yJ/p
         jsdA==
X-Forwarded-Encrypted: i=1; AJvYcCXKF6bloUZUfGmfD7OlbviBXiRo2jZ3CQHuZSyQkhP8h/ebzPtW5611w0/Ur8nhZKRXmkgDP5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBAT/f31c1TU96eKht9HpZh4WbBgy84IW76+OZubXeaueRgq9b
	Mx5AEP/HR5nUEUSdy5P/UySf+Lpqt/cpcHIKes2e+xZni2wvPpg6PckYfuUMwMWTXg==
X-Gm-Gg: ASbGncvrWpMA30AD28jc8IQow3NqNOq2zlXOJ5HQWAFHS8B6/J1ljHPhcAcpjkvH7nu
	VZJBuBn+yJjHL3stGNsx3HM0jEnxm93TZYd3Qm/j5sZ/ycFHBWS7/6KG4EnOy8zyvwtWO9wKL5M
	fIulUyoL0kC4BM2m9evoN++VL8k/DW/fr3jwXMY0o5yKBF1PVvQ3ZpWN27xufB2HWvxp+jHMcyA
	DA2jpZCay01CJdMQJeQ+0w6oKJ7efqgB/uhSjv189JN9CO4aVznb4vLundMUPKvGPuyK8Q8ksI+
	hqhMpMw/Y/Fa8rBuVjS+4JEuRp8WlNgTSGxuRHa+PRhaXRRnJ3OjEt5LzTu+RuB6
X-Google-Smtp-Source: AGHT+IEC2nKPUdk50WFpUghJX26BtPFp6JEJuxNyGydhjELLPNt5ycVNb0kOu3HHnkCcdxhTWPz2uQ==
X-Received: by 2002:a17:907:fd01:b0:ad8:a04e:dbd9 with SMTP id a640c23a62f3a-ae0bf154a67mr288967966b.31.1750856706457;
        Wed, 25 Jun 2025 06:05:06 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0c0a824a0sm127853766b.36.2025.06.25.06.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 06:05:03 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <613026c7-319c-480f-83da-ffc85faaf42b@jacekk.info>
Date: Wed, 25 Jun 2025 15:05:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] e1000e: ignore factory-default checksum value on
 TGP platform
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vlad URSU <vlad@ursu.me>
References: <91030e0c-f55b-4b50-8265-2341dd515198@jacekk.info>
 <5c75ef9b-12f5-4923-aef8-01d6c998f0af@jacekk.info>
 <20250624194237.GI1562@horms.kernel.org>
 <0407b67d-e63f-4a85-b3b4-1563335607dc@jacekk.info>
 <20250625094411.GM1562@horms.kernel.org>
Content-Language: en-US
In-Reply-To: <20250625094411.GM1562@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>>> +#define NVM_CHECKSUM_FACTORY_DEFAULT 0xFFFF
>>>
>>> Perhaps it is too long, but I liked Vlad's suggestion of naming this
>>> NVM_CHECKSUM_WORD_FACTORY_DEFAULT.

So the proposals are:

1. NVM_CHECKSUM_WORD_FACTORY_DEFAULT
2. NVM_CHECKSUM_FACTORY_DEFAULT
3. NVM_CHECKSUM_INVALID
4. NVM_CHECKSUM_MISSING
5. NVM_CHECKSUM_EMPTY
6. NVM_NO_CHECKSUM

Any other contenders?

-- 
Best regards,
  Jacek Kowalski


