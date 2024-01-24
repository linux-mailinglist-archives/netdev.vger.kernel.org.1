Return-Path: <netdev+bounces-65459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904D083A9F9
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 13:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B311C2164A
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FB86311E;
	Wed, 24 Jan 2024 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llq9UrGc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A960DEB
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099904; cv=none; b=FR0EEPMUSOXpR5kQq7WLfl9JYQtrUNtv/Kj7LYX09x/utGMvEj2XFpOQkY9NJPKJ8DaIBoEVFWpGQX8zl1YZ7w5tiCVmbpN5fD8XyRdSrWD7mkfNLhAY+//YEMfIjj2q2BDCRCVPIwj9alEw5dFM45JWakUU9oXLZtCzbPezYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099904; c=relaxed/simple;
	bh=G4Eo78yHotMmyyqcl5vUTI1sj/UNZU3YgL4Fb4G5AFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZMyzjA5B1bOFIfWBWgwjTr8GPXatOmtTY/n3/quE6m0wyXsZl0YF78o0RJi+jH34tHMgEJ/Zte2aQtgwwdyOgOpMkMbaMLFOqLirm5mZY5kz9ll3sJ/caZq8Mq+ngyN15T1GYgcBFfY9aHMwCOaVvNxPCdue2gfkIwPo5SzXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=llq9UrGc; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51008c86ecbso2043456e87.2
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 04:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706099901; x=1706704701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eErz+34XA2SH+q6nUCH407rk9Jd9s2beoCta3Tc+wxg=;
        b=llq9UrGcIqOZj338ukHKn+LLHoy40gTsL0x7EFOtPYfgolITqA6aKETatoSj2jYoHj
         S2w8Ul6GV7D4QGqm4O1IfYv6h2QQoq0uBlMKM0seB7qcDPBGxDTiNr51lN/0Wjl/xpf1
         6NbD9KWYwKi/5iw4fW4/pRJIYHtdRJ3gaOcw7jTpzCUm50tvcgWA2pY5hG2ttBoak8UR
         riNrIVh6QOPnzFfKUvWOmi2Idqk9trpZqqP2dkrm20wD1NgbfqQVHKTv0BrY1LRdRSAi
         UtNlWrL1msZAtzn7mMyEnDXv1xNlwvmFsYkWz1V/upkt+7Il6pGhApokHf2lXXl56y8d
         17Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099901; x=1706704701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eErz+34XA2SH+q6nUCH407rk9Jd9s2beoCta3Tc+wxg=;
        b=J4U6ckQ+lxjFqIRAZzEec/qEGu80Y91XPSLZUwSDidWXidtpjBAOmS9TIp3bnd9pHj
         EIqDUv2vVYYm/6SyAVOUtDLM0zJjob0AYw2SKsyI6+IqGPiWhDL/glTKJj+tFFapVjjh
         040uzriih5ld1XobXNMnpfO9+P4UPWdueQSg3k0E593XYCnYF8opOCPY3CAmEPwqZGP8
         4sc7abOtDkDP6+5ndtaVeT3Nlfe/Ei7OEVFfMmBGB/IlC5+IFExFW2RYE9uxl+ZZ4IQ1
         tm6cWZiNmWRKW2OgWyOD1zDGhy3b3oRcsUHmwv5upBivydrsbI0rbj2ohLYD1EQ0ai8k
         jFLw==
X-Gm-Message-State: AOJu0Yx3k641h/dV57yNdB0pgsusb+ylRYPCOdaeHbBlLvGANFv9WsQl
	Uua3rbIDAxwNJdof9YyeizpSbBuM/05fTpYRBriRXYLwM28zeQMz7g6lcocFGD0=
X-Google-Smtp-Source: AGHT+IEcmvjt2FacYK+z8AFeFgN6XsDd8oOiQ+Msgo9dlrmxCTyx4Rasaluw0LWJgsEpNEAXokSJYQ==
X-Received: by 2002:a05:6512:3cc:b0:50e:b65b:4944 with SMTP id w12-20020a05651203cc00b0050eb65b4944mr3052789lfp.21.1706099900779;
        Wed, 24 Jan 2024 04:38:20 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o1-20020ac24c41000000b0050ea7b615c3sm2556075lfk.230.2024.01.24.04.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:38:20 -0800 (PST)
Message-ID: <0679f568-60e7-47d8-b86e-052a9eb4c103@linaro.org>
Date: Wed, 24 Jan 2024 13:38:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: qualcomm: Remove QDF24xx support
Content-Language: en-US
To: patchwork-bot+netdevbpf@kernel.org
Cc: timur@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, marijn.suijten@somainline.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
 <170605983124.14933.9916722082205803213.git-patchwork-notify@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <170605983124.14933.9916722082205803213.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/24/24 02:30, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Mon, 22 Jan 2024 13:02:22 +0100 you wrote:
>> This SoC family was destined for server use, featuring Qualcomm's very
>> interesting Kryo cores (before "Kryo" became a marketing term for Arm
>> cores with small modifications). It did however not leave the labs of
>> Qualcomm and presumably some partners, nor was it ever productized.
>>
>> Remove the related drivers, as they seem to be long obsolete.
>>
>> [...]
> 
> Here is the summary with links:
>    - net: ethernet: qualcomm: Remove QDF24xx support
>      https://git.kernel.org/netdev/net-next/c/a2a7f98aeeec

Jakub, can we please drop this (or should I send a revert)?

It turned out that Qualcomm is actually still using this internally,
for "reasons".. [1]

Konrad

[1] https://lore.kernel.org/lkml/4c37d84f-ee46-4557-b25d-01ad9af4e950@linaro.org/

