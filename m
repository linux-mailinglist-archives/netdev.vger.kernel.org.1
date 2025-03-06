Return-Path: <netdev+bounces-172550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91482A55671
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C094F18985B5
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF9F269AE0;
	Thu,  6 Mar 2025 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPFHaVol"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728619E99E
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288865; cv=none; b=XZ2O/AVpJXDVOB5IxM3tnU3eNDNfdSr31llouUFvoJi3P87b2Oh/DCxUw2U7SNn2c3SEczaZlVihGWqmRa/eVZZO8V+/cesJ2RHKqvlixDhK9lTrAwP+7q+z1FofkDniHik90YYbzhWNiWrF5RGKgPVW2tcqngxNJg51bE7Yh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288865; c=relaxed/simple;
	bh=GyFXl60w/dOypeMEqp9bKvRVjPJR3Ng/gBhX6neyUGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBg97M+gMbrGJJ0A61Z7T622HeKfgwHFkSL/JHM0otySjjELbOw5wErkULWnEddoZq3JrMCdacW4smKarc2NrDsI40Ykstz6hT6YZR8FHvVuozXZenripmLUdSGaEV+TCoD4unNAwN6HOvXR8uq6RVXqh7y+1M3sRXkyen6erLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPFHaVol; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39127512371so765681f8f.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 11:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741288861; x=1741893661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e38+3vdBhvSHJukETMTmIvHKTa62TqVQDzb6SSBmUZY=;
        b=fPFHaVolYQB2lWaF2eROsGP7QT8tUExto9goHWIF1WHAu6Vkga2ortSI8KCfO62HK7
         2GbVh/3WRE1AWYfGrihuuU8KTfKVGDdAI8mm2jAM+lJpd50XhNlgkZlEW6uTGQIoas1f
         HFgwAWXgXlDMAjqVcqW2mCbG1t7yfatwJ7U2I5c7iUiFTTMDHoysEvy+2UOwOQoqX6xk
         yA44xdo4nhRdDV2lcghi+CbggQkL5J7sga1FaqrWHyV3biKwS/EJaWbCukmSiYbz2GUI
         yBnzmFKwp+0leyqGTYrmB039cAZXnZqAcSy39mWvqJNnV4ydML7EOyxRcB+E0uvlkSm5
         aJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741288861; x=1741893661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e38+3vdBhvSHJukETMTmIvHKTa62TqVQDzb6SSBmUZY=;
        b=ReKdg8l4bM/qrN0s7dIwC7fTDDIyV6D/9fcMWrSk/4z/HAgdZp7I8e7mBv8Kkmw49p
         WCkB/ALVOYPpHQ7NpwABV29ECeyqUJN8vhjmK91m1BmGFXY2tQ3Dm4T6LgVbEzT0W6Sj
         B+ccFDYtRpwTJSdmCkdmQ283MFyMNk1OeM4pNS8CS++iBup8V6HqkMULxS8bIS7nTB4i
         3IlVFqCQKwYSO/pfl7nufMJEZHAoRt1NjFen0qxRI9/X5G1OkV6x0dzlpdt3HawezdsC
         VH4kr/QvrhbyvgcztAq/k+3gz5loZBUkYjpWM6frnFSAKNQ3pwwE+4tYxRmqplv3fngz
         FndQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj6E5J64SagO6g4mwmaDvazhC0qPywnNNjEMarqi9lqG8uYXcl+p6kJxyDsdvSX8wJ0S16mgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSafRLfSwiD1scZm9o+T7nN5cO16/PZ2Vt8ve6iFYrp1Xs1Ew7
	7vT4pqLwKYLyaUqRL4xSOum0mMHZ7v2rpfgl1rKO8petx7ecSHbV
X-Gm-Gg: ASbGnctKeKXKX0javBFtF4AXwCUDJZ/zgIZhXTz1Smm3i6IuX6Hin/iYTw3927XFDSu
	4tWo4O0vdA+LzlIT3P7J+i2sxB7LlW2zVSdGywnOZfORjZGuTpqsG6H0oWEftFADSYH9RGSuimy
	TeEHzNogBiWNFgfTErMqWnI+clha9P1mkJQUbo7dJqXexzZFYra3d4/vY/mv7tE4SeH+bObOrMi
	8VUvX4YEdE402Ou1lSvlwsrDEy+ipFye/R680aMwAgC/Q0oHtU5xjmtinvb5wZz0rw8BJhL4jzZ
	4HsjZscCIht1AVLzX4mvdlPwxLiG18vw1cJfcJ7UfSoBH/Lnl0tJBXQ8+JD9AkEjLw==
X-Google-Smtp-Source: AGHT+IEzNlLBoUFkC9v4/CAACbq7iQJbg0szzGupOkd8v2ml3r+4jOpCO0smutvAeX+oqBgCvlTGxw==
X-Received: by 2002:a5d:584e:0:b0:38d:cf33:31d6 with SMTP id ffacd0b85a97d-39132d68426mr273877f8f.3.1741288860353;
        Thu, 06 Mar 2025 11:21:00 -0800 (PST)
Received: from [172.27.49.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103290sm2829870f8f.87.2025.03.06.11.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 11:21:00 -0800 (PST)
Message-ID: <7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
Date: Thu, 6 Mar 2025 21:20:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, Gal Pressman <gal@nvidia.com>
References: <20250303133200.1505-1-jiri@resnulli.us>
 <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
 <20250305183016.413bda40@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250305183016.413bda40@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/03/2025 4:30, Jakub Kicinski wrote:
> On Wed, 5 Mar 2025 20:55:15 +0200 Tariq Toukan wrote:
>> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> 
> Too late, take it via your tree, please.
> You need to respond within 24h or take the patches.

Never heard of a 24h rule. Not clear to me what rule you're talking 
about, what's the rationale behind it, and where it's coming from.

It's pretty obvious for everyone that responding within 24h cannot be 
committed, and is not always achievable.

Moreover, this contradicts with maintainer-netdev.rst, which explicitly 
aligns the expected review timeline to be 48h for triage, also to give 
the opportunity for more reviewers to share their thoughts.

Tariq.

