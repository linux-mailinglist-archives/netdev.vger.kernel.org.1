Return-Path: <netdev+bounces-247641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E74AFCFCB3C
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9F99301595C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B553B2EFDBB;
	Wed,  7 Jan 2026 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="E+abYr6c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA962EFD91
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767776413; cv=none; b=ps98jZ50EnW0a0rTEx3KAFQ9hAIqJcy10n1sN9OgqcF3y2KVKi4DOcgMIXTwGxTW1/oeSgsVAc+xqMwHYDfHCwdE6W25e6UmCF+39G/G/ZDmHuAFThGy8yl+FEt2mzCbIF+I4sGL4q8zYxjvJoWkX1P0kPhBDoWKMQrt4ktZGww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767776413; c=relaxed/simple;
	bh=sCCKbuk7YySNPrAfx7Wit6Unf7q4zglc26Z3x5eiZSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C++nuSs97kBBVdGRfLjhOEOJw22PilHu+V87w7arSEH8WvlnGU7/RZ0fdRXxQnCDMIVqdIgZehekXeX6XSljHipbOF/Xa4EBmah5lGJgRbfRJkpEzKUJFGL/tmTpETDxehioKvnkqc659YyVqLsIIyfUr5obqHFZzsXYfNaDkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=E+abYr6c; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d3ffa5f33so8653525e9.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 01:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1767776409; x=1768381209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1adH5GFfbTcDA1IlM7DzqcktsNMYGE1xewRyGNUxKI0=;
        b=E+abYr6chgK0pz9hJE3wo2vMtJ5/xsK59euDpyCKTJHt1BZcGGI6rfl7y7FQlOeWMk
         DyPcuIVhgDGNYEKuKVOtTPPmeLYbJscpA2BTou2050DwGcpLF873FOZQ30okKQlGoYR/
         9c8pHyCAA1Z36rZwMIQ6ak1PsPLhdcUZkr8q1wDIkLYD2LsbZgAUvHtkvCoBQLODRlmI
         KswPp8xd+dg+HGUTAj5KobCNcBPo+KYo85S/vdMG2p9CjU0xGBBcUEY1lLwQHeIbxG89
         IJGclSSG0prQCUmtYcutdYOA/m9cRavQS42hIJNax6BHTSWRFMzY4ZUQlfvZSFfz8Zbl
         fzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767776409; x=1768381209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1adH5GFfbTcDA1IlM7DzqcktsNMYGE1xewRyGNUxKI0=;
        b=FCcPH9zM2dh3J9UWX+6pU+7QTk7kycculeto1D9lTpXhGYEp9opnuSOGEqa2IDDEU5
         iND5i9pMTOTTKnPQOUGM9Vr+tCxpv1xNxc+EkZ0kGZqThnbfN351Hm6VxmH8PId/adtz
         lTb7R/knWJYC2ZjwrLUP7cvNHUz/n3C21d+Jscdt3LbWGUI+Ok2mtoF7PD8bX3z8E0Au
         9h3COSlHFf3RZ7DgSJZyyb94e+TOFS8sHCUqep2YGWcO2GIWdaOb24zyQBOT6Ce0lg/4
         bXRunH8ETgJ7xk4srz2sJUB2M35QSlpIFyDSznRA655qk23FJmP/5fWeCz6c9rLYkTu1
         99HA==
X-Forwarded-Encrypted: i=1; AJvYcCWzNQmdu1Sv21s/h9dTuiC/dRkeqzimnmzBshmVo6TaMGgMWu8QZbPgDz3UF3h2ce0k35Is9no=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHEu+840N4adLADOc56m9M1640HPkwsTtTI7bIB9EJzPbssMC
	JeD/ayfeEqC2qsfJHrC9Wuu62w/5wsxyEk66mWPSAZtWZ9rxq4s3n+8iLCVrd2hCMP8=
X-Gm-Gg: AY/fxX5xMJLlXIqEgKaCfApEXs/fQ5dtsit9X1do47fkuZay72jRlDdSx+PFeGhscMQ
	JEEn1mGwzoGlQ5kQRZOhRlaoXUc/9ja27V3cPe+h0NXat5jXFeD+DQjD5gvVERlYRQJsKTJ73Qr
	EINqMHAb+1DAoQWQIZ1L1iMbSbJw7g3jzmHLtu108TfR/ZmzNlfcQ5MpGxBqgjHU3oems1yP43l
	uPUActfuqlhorU2c+lQ/GxeR7L4Sy2X1EKslVF42KZVkBuRgkbIo6kB0P1qFmdqZEkTx3MrPqF+
	b2Ud5bxfM2JsGASJhIH75e88oWO5n4CbcpIcVAP8yG3EIJ9NpSpu6er+94Dvzd3T6KAl7tfSWz+
	XK9k8TUapr70erMZ5fbhqZCJd33lyw03U3QijBPSYzU/dW/ZkGGT0yblKL4L8tHl1WFUHjv1IEw
	rHqDxqQzFbtXZRfBmRHUp6bAYrDNTvw9K+46KELrpDBX3DJ3txvYJZnFY5LDMEClsLPD6YbXUSe
	Og063LM
X-Google-Smtp-Source: AGHT+IFWhSNgmVk+6HHKRdOSdipnHsEqXnmQkobGqaQcY2yH5rav/ISt5Lb5pCzRNv8s42WPABAMew==
X-Received: by 2002:a05:600c:6815:b0:471:1716:11c4 with SMTP id 5b1f17b1804b1-47d84b61379mr19011795e9.34.1767776409131;
        Wed, 07 Jan 2026 01:00:09 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f7053f5sm84386825e9.14.2026.01.07.01.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 01:00:08 -0800 (PST)
Message-ID: <40b42159-d7d7-44a4-9312-24cf87fd532b@blackwall.org>
Date: Wed, 7 Jan 2026 11:00:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: bridge: annotate data-races around
 fdb->{updated,used}
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Ido Schimmel <idosch@nvidia.com>
References: <20260107083219.3219130-1-edumazet@google.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260107083219.3219130-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/01/2026 10:32, Eric Dumazet wrote:
> fdb->updated and fdb->used are read and written locklessly.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Fixes: 31cbc39b6344 ("net: bridge: add option to allow activity notifications for any fdb entries")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
> v2: annotate all problematic fdb->updated and fdb->used reads/writes.
> v1: https://lore.kernel.org/netdev/CANn89iL8-e_jphcg49eX=zdWrOeuA-AJDL0qhsTrApA4YnOFEg@mail.gmail.com/T/#mf99b76469697813939abe745f42ace3e201ef6f4
> 
>   net/bridge/br_fdb.c | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 

+CC Ido

Oh you took care of ->used as well, even better. Thanks!
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


