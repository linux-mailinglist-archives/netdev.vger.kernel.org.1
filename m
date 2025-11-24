Return-Path: <netdev+bounces-241252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE383C8205B
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8EB14E661C
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098943168E3;
	Mon, 24 Nov 2025 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="G7n56+1U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62044314D17
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007581; cv=none; b=pmt3aSybaAF5fgDyp8RotL1tnVyH4rwVjqP32S0i0NKNvy3qKX5VSIUnWhRQ8kHzSWvAE+BndUSYsil5FacFvdvXyd5NTdaZZCPOjA3fUbCHKw++ZhzIqPSBJCKgQPinf5UD6aF6qIuMiITggEdIXfZenSNQwfmj0PXd7wrhgPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007581; c=relaxed/simple;
	bh=E0ulkYNKEJIzVIGF25rNJX/Ke7Zl4peM+vZ7s72I/wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3gSqqmHZaLdZT4FXO4OQe7eLDR0L4J1sJuXP3VRSFSBWJv1oMbNv+I5yz9MWTcTmg5d29oOv9rcfLC3iME6P5wW7+Or4F6IeI2VnLesZpDSw3tfX9EEilR7uRbD+CLk/FEUy30rPAh3JN+r6b/YhnASlxHP/IDaB+XmCxcq8zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=G7n56+1U; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo5384362b3a.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1764007579; x=1764612379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xY3Ejem3wohirw2jRm4uDDMRmk/+FkY1rKJEMtyPFqg=;
        b=G7n56+1US2BPKh95ssvY/qiDV0zlwiVJDrIQ107ZUz4vXxELd2JK6jNHoe74wc3Ny3
         fC8sHdPmvsn5qaI9y/KLMVbMc++4SANr9PSxnRPm1RKWkX2K2sk7+/ixI19B+MDLjTiT
         aUeyQG2LfOQiDeWi85ml9mL6P92366x8q0LApMFN2y0UJIWAucOycV8K38oZD3VPjitZ
         xBwZa74uokJRhmHTRYn6ydq+hvpvUUYc5ta0f7LcAAgfw/WpLlfZvrpCbtWG0iErQ99n
         moHkjYYmH1MQKVb/fiBfvmCscZmrk1dVILETRrmasHgBLGWx5vHdhBbBVt7FUslxxVVZ
         K7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764007579; x=1764612379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xY3Ejem3wohirw2jRm4uDDMRmk/+FkY1rKJEMtyPFqg=;
        b=v/HKSnaE0UbX8Qj8lcuy2fjvwqWkLL565sz7q6QXn9WZpCU1w6QAFVI8PWgID5lSJA
         26MdEcDDRBo/L8IWhK+rWTgDI47XmDbBPk2r+6jhfQu9CJvQLW1DFcVblekt7zPkBjaf
         nKgegoxFaym0keGa7KihOHG9ZHX/NnQgDcos7u4blYBhEiWLGn76uARae68glgiFGLys
         /2tGO+LQI08VovVxEfIPXJfNoxA4dogZtPSgt922mfs/0L5iCpDJ6sn2+VDU7Yfce/BM
         nPuNUGvnE1HAgX+AdN3YoMdqrl/HYE+ZpDQLh4xYShryvQSORDVFVpZv25aXQTu2No4Z
         JLig==
X-Gm-Message-State: AOJu0YwdGKKWYKKCN5V1pDqzyrhr9XvOJ/upaBhyvnciA4F4NR+TvmM6
	ARrxOO0oGUGo96C4Sfw7yvEdc+++s6o3yWQXqyMEaqY9cHoy09ZmAzeCrx7GDxHFeLs=
X-Gm-Gg: ASbGnctox/ELAGh5vYkKLC/3oF0CjaYXOMt529R6GRmSZfgcPZ6SaGGfPxMey59dGI3
	Yyj52Y773A/DnwZc5uGBZviPkT2KV2C55bKeQJwQ+f+3lt5KVAHCmoYyHSSwQOFeI4o8cdxxmYu
	Cse2FSi/3E9AqDxhul8HyeMXSZ+LQITptVQtdACKGROsT1WgCP07UBqy9rU6CjZYmIq2Xy7ztbH
	T9d2WrpVXsxYKhLGfj6oGy+0PP4AsL/BnNTr0yoxHf4u8p3I+pVW8DFD8Cv9C471msLmg9DXl2l
	xcFSgQ1KIOe9WxHrYxREbrrSMhFu46rnXkL1G6zl4yDq7GFigkm/oOcje5ee/lGIvZxwKJ9oW3t
	Dgl5erYKlPeWSYqAW+BT6U4RzJEd58gZHWTBg2FAzrck/CTLTCUlNFkVi4/Bn5ecThp4B6HPkpU
	8+eeqF6SMqP3bWed2bAGGVw+9Z4vcfYgzyagboKmZaPYHXoR22x28qt73RZktDYlpXAlhHBsgk3
	8GhCmZcjTji
X-Google-Smtp-Source: AGHT+IHeWnmCuti+drstEBTeEJiqwp/MpVkt41UBR19fH6EuAP1w4RcA3lhH+nLywKcF5bzLeHs87w==
X-Received: by 2002:a05:6a21:9990:b0:35e:4171:b7e2 with SMTP id adf61e73a8af0-36150f3e91cmr14396158637.55.1764007579325;
        Mon, 24 Nov 2025 10:06:19 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7:4f61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed471060sm15396120b3a.15.2025.11.24.10.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 10:06:18 -0800 (PST)
Message-ID: <6e3f1489-1f70-48e3-b653-384c13502968@davidwei.uk>
Date: Mon, 24 Nov 2025 10:06:17 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] selftests/net: add LOCAL_PREFIX_V{4,6}
 env to HW selftests
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
References: <20251123005108.3694230-1-dw@davidwei.uk>
 <20251123005108.3694230-4-dw@davidwei.uk>
 <20251124093241.555d7d21@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251124093241.555d7d21@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-24 09:32, Jakub Kicinski wrote:
> On Sat, 22 Nov 2025 16:51:06 -0800 David Wei wrote:
>> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
>> index 8b644fd84ff2..4004d1a3c82e 100644
>> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
>> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
>> @@ -196,6 +196,7 @@ class NetDrvEpEnv(NetDrvEnvBase):
>>       def _check_env(self):
>>           vars_needed = [
>>               ["LOCAL_V4", "LOCAL_V6"],
>> +            ["LOCAL_PREFIX_V4", "LOCAL_PREFIX_V6"],
>>               ["REMOTE_V4", "REMOTE_V6"],
>>               ["REMOTE_TYPE"],
>>               ["REMOTE_ARGS"]
> 
> The DrvEpEnv does not need the local_prefix vars.
> Only NetDrvContEnv should require those.

Sorry I missed this :( Will fix in next.

