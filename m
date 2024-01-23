Return-Path: <netdev+bounces-65177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB816839719
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DBB284F95
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C58811E5;
	Tue, 23 Jan 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQ1r0Lua"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FD480058
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032774; cv=none; b=OY6N0qM6zN9ZbgZSla0EKDkdAkXlPNUwUUfLN3kFTIbfrK/GWmy+XQpE721C/DzUtt9HzKjQ/dTaHH1WVHqv1g633wiWuFQbYFOwcpyLJKkpxCXZoDtF/PP3vHn62JRY0+iF86veuoK1svZ0UK/34nCenDmH8cvSkntNTgxrLZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032774; c=relaxed/simple;
	bh=zy+VtAthqnrtNOUurs3SoKsfCadphFbukqOkKL+5+c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFUBmakpKxPpDNfNqy1Ktefo9ymbcgoYF5ZsAc8d1Py5skDPWWL41nlg6D7UCVk4uKjqCW8Ru37ei6sE1kpmi7I/11YBBTZp+96hUk4BA7urz6Ess79M+8jsjtfSbzuUelq7wyayElXPBHDMBHB4wyPt0CCR1/O5qBZptC/jOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lQ1r0Lua; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cd33336b32so61249121fa.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 09:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706032771; x=1706637571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MevgjBoC1naTbBSpDdFhU7jz6wq+Ub0rYmPiyyfGzGg=;
        b=lQ1r0LuaqIBsLzUw9F3CllEmNPwkUTvNHClVpuRm3iq3/0BM5kK8lH8HPiHSBKA4nR
         IkNVD6C7HeeFp6YIAW2HKv2oqGiY41U7cHFHSeE/CPQOIG7oCQekk26IUqmmz/XXCPjH
         wgwQCY9gEvgW8b6arKwH2Durs/sHl/3VMCdPU/x9ZbFqO4jlUvh2zF6txvdDhJO1bAtp
         dTFAdG/idcVGtFpG5tnaSTaM8VxmwfnZIBOIWuCixylG7rAl2lsS74LW/7WidwJo5ZAe
         ggiBUpkvs76V3dxEk9e1+DOftSzbo1QDRm0vXeC5lKUtNeKD82RiefH4vNB1U0bIAx0g
         s+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032771; x=1706637571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MevgjBoC1naTbBSpDdFhU7jz6wq+Ub0rYmPiyyfGzGg=;
        b=jVpQi5PwPYZ/CPMMNe/xiGPaCNoET/zCSTjH0F6+8aJDeOntwiw0YkME1TnxszWuAW
         i5V1BoH5WRLaIkH6ZHRXqAJ0ZeuyTCsM2UcSYBHWE9j++6szTPTg8YJMGRv8rl352XGK
         qjG+v4DptRCkDNavBzscIo/BftyLphrOh3aOI97QZwzPlGM393tOMK/f3+mVkVq8ocVT
         ZfE3HsWO1oK3zNXY8uyBSTZHHNJ/LdHxeHKZVN4RRNEDLAtnemVVb6BgAGponKuwZ31h
         CHKIyT4221LFPSjJ8gd82PHa6f55Y2h3kh7Xr0yGR10w5eE3F/dTjNIsn4ujj2RzvACp
         5Blw==
X-Gm-Message-State: AOJu0YyIiJhow0/DVuf3BBpeYW++gzSjpEaoGA/BpieNdeS00IVveNWc
	KUlmb6bWsgEggjLI/yNFowliBPKQv0KQcL2dy4gcXoKaqhLlBD0HT3GndhX5ahYiqJSa204lQ+N
	V
X-Google-Smtp-Source: AGHT+IFsQdXZATi7GwTB0ulTN78M/aUoE2hnQJP5hgZwsQ02mD2/+t03X9iw/GN1e8SEqoW0WSkhyw==
X-Received: by 2002:a05:651c:2208:b0:2cc:609d:eeaf with SMTP id y8-20020a05651c220800b002cc609deeafmr102633ljq.36.1706032771190;
        Tue, 23 Jan 2024 09:59:31 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651c03d100b002cdfc29b46dsm1514699ljp.88.2024.01.23.09.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 09:59:30 -0800 (PST)
Message-ID: <4c37d84f-ee46-4557-b25d-01ad9af4e950@linaro.org>
Date: Tue, 23 Jan 2024 18:59:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: qualcomm: Remove QDF24xx support
Content-Language: en-US
To: Timur Tabi <timur@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
 <CAOZdJXXCmZi8Qx-y2D_NhJiafnGhvma2OY6F+KauqYcNAAQNCQ@mail.gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAOZdJXXCmZi8Qx-y2D_NhJiafnGhvma2OY6F+KauqYcNAAQNCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/22/24 21:34, Timur Tabi wrote:
> On Mon, Jan 22, 2024 at 6:02 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> This SoC family was destined for server use, featuring Qualcomm's very
>> interesting Kryo cores (before "Kryo" became a marketing term for Arm
>> cores with small modifications). It did however not leave the labs of
>> Qualcomm and presumably some partners, nor was it ever productized.
>>
>> Remove the related drivers, as they seem to be long obsolete.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Sad day indeed, but understandable.
> 
> Acked-by: Timur Tabi <timur@kernel.org>
> 
> If you're looking for other QDF stuff to remove, the QDF2400 hacks in
> the SBSA UART driver really should go.

I have a branch completely axing it, but it looks like Qualcomm
apparently still uses some internally [1].. I'm not super happy,
but let's wait on this one.

Konrad

[1] https://lore.kernel.org/linux-arm-msm/52479377-ff61-7537-e4aa-064ab4a77c03@quicinc.com/

