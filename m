Return-Path: <netdev+bounces-140280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDA19B5BF9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 07:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84034284538
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 06:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEC11D0DF4;
	Wed, 30 Oct 2024 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1PybXgQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57013CF82;
	Wed, 30 Oct 2024 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270878; cv=none; b=ocEoq0CclReaAxBCV/dyuvtGQZIy7O+lVxcjMYFCcZcyrDzfYvfonhcF0gqSUfJvuK9wrzySi4C3l+U3xlaZUXbctkDg6NIxpzxnTv7MR2V1J/MxFTO+2UQw0ccAtgbxssy9I7awejFmM2nEQbrEFuDniibAMpy0IlY6c1IQAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270878; c=relaxed/simple;
	bh=sBuryP79hCPagQG+G9zXZR8cppcDQQ2uy+1JYtvGHQc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Lh4fzyYN5na7+rY/+QuBL+YfU9dUj0m1tyOBvRkUgTV2tDzu6rMI1MVfxkm/ZwNyDAqGpb1U3xNiZeXformIzedkwJhSmg1diRaYngkspRITEQe7hzwli6zpxCKHf0BzmIVRBM13rksPOO1jr7pT5HmESFOOikry6744gc74Kvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1PybXgQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9e44654ae3so30404966b.1;
        Tue, 29 Oct 2024 23:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730270874; x=1730875674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hMXpNxhBWpXkuiYmAOYmqAd0VDs3nYutt8Ocou5MWO8=;
        b=J1PybXgQzpIf7UMcERklxOgz0gNpr8VOIcpuJXX+8rBhc5zzEXlFnECrGT7D/AlGwN
         sKreQCvwsSF8rtyNxjuRkXXAWBHV19+LXlfAjN63TYWvSOZRwBF5IY4W7mr15cvw8XNy
         gpOzJIJk9JnJc9zyy6SEzSPhs1aaKiDvmVWwkPTUPNjfNiT4EBsB764rTGJi7N3pdXc0
         VSLF7tuG1KWfXuG4McgmTkHnc9qsbZ9iI5kosGe85fEID7vo2lrxy9Awo9YaYwzGRi6C
         nYIrqilx9f1nQY5UpIApu0bt9CgpZtVB1D4iBnTP6gbopPtuJVSFGjxfGstqNG2nDF08
         lEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730270874; x=1730875674;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMXpNxhBWpXkuiYmAOYmqAd0VDs3nYutt8Ocou5MWO8=;
        b=Zvjk0HNx7Bkpig0dynMBS3SJaaw/9WTn3qZcmsNHkSX5iuacBapJVXOSmc+1M0EOHn
         uH/rpruqtVUWBF9RCHT/mV2KCHemEp6P8V3ZDi1Xoh7FazrIfAJjatfl9MmchLcQLg+Y
         a37ybBpdwqHHuH75E/xpAQJXWJIPvGURov7puCJ8vaXc2CCXjPf3jk5FZE4Jt5Bk8iES
         vb3joEERfnOISoOt7avfaDygO9RvGFusT9mhfujBr9YcZqeOa3JIl1f8kMxHJ4oRSOTP
         MKWuX2rEnhAct8a6xhAHnW5wko/D3Oa3c9Ck8w08O3h4yObcKBUT5UjrlqTCRsGEDrhx
         Il4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyNVVIEH+6AXJ4g8rjRYBDVYuh2uZVVgEXQNpepQuPfMwU3jNY3/Fe4ZDG+Y1nX9qa1/cINEnoAQnqa/A=@vger.kernel.org, AJvYcCXSysHoNR7jJz5UKqQ440vYZNkP9qtbOb/NvO9d4eT0GTzQdKIJB+RHI4ZhdqbS12q09KybiEc4@vger.kernel.org
X-Gm-Message-State: AOJu0YwbN82ZM8oXQHFIwLr1LaeM69antMpMcJ6ptvsQq8/U3fPG0/3J
	XiQoS96p9aOi4KLSQloZwHh4cwhVvkoluQijIwmvKepmpAMNrlmu
X-Google-Smtp-Source: AGHT+IHx0pqrSrMV1MRAV3jbq6+foJpa2k5N4VD2r4i5BCuz3to+OqRh1UbcMSGMr3Z0vtMx/NJCuA==
X-Received: by 2002:a17:907:980e:b0:a9a:7f34:351b with SMTP id a640c23a62f3a-a9de5cfd5d1mr1301008966b.3.1730270874107;
        Tue, 29 Oct 2024 23:47:54 -0700 (PDT)
Received: from [127.0.0.1] ([82.102.65.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f030193sm539645666b.85.2024.10.29.23.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 23:47:53 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:45:48 +0200
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Jinjie Ruan <ruanjinjie@huawei.com>, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net=5D_net=3A_wwan=3A_t7xx=3A_off-by?=
 =?US-ASCII?Q?-one_error_in_t7xx=5Fdpmaif=5Frx=5Fbuf=5Falloc=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <a628c035-641a-1c40-e4c8-c266e867718c@linux.intel.com>
References: <20241028080618.3540907-1-ruanjinjie@huawei.com> <34589bdb-8cbd-455d-9e5b-a237d5c2cd0c@gmail.com> <a628c035-641a-1c40-e4c8-c266e867718c@linux.intel.com>
Message-ID: <6F7BB669-7971-4444-B693-0533E56D623A@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 29, 2024 12:52:39 PM, "Ilpo J=C3=A4rvinen" <ilpo=2Ejarvinen@linu=
x=2Eintel=2Ecom> wrote:
>On Tue, 29 Oct 2024, Sergey Ryazanov wrote:
>
>> Hello Jinjie,
>>=20
>> On 28=2E10=2E2024 10:06, Jinjie Ruan wrote:
>>> The error path in t7xx_dpmaif_rx_buf_alloc(), free and unmap the alrea=
dy
>>> allocated and mapped skb in a loop, but the loop condition terminates =
when
>>> the index reaches zero, which fails to free the first allocated skb at
>>> index zero=2E
>>>=20
>>> Check for >=3D 0 so that skb at index 0 is freed as well=2E
>>=20
>> Nice catch! Still implementation needs some improvements, see below=2E
>>=20
>>>=20
>>> Fixes: d642b012df70 ("net: wwan: t7xx: Add data path interface")
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei=2Ecom>
>>> ---
>>>   drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx=2Ec | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx=2Ec
>>> b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx=2Ec
>>> index 210d84c67ef9=2E=2Ef2298330e05b 100644
>>> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx=2Ec
>>> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx=2Ec
>>> @@ -226,7 +226,7 @@ int t7xx_dpmaif_rx_buf_alloc(struct dpmaif_ctrl
>>> *dpmaif_ctrl,
>>>   	return 0;
>>>     err_unmap_skbs:
>>> -	while (--i > 0)
>>> +	while (--i >=3D 0)
>>>   		t7xx_unmap_bat_skb(dpmaif_ctrl->dev, bat_req->bat_skb, i);
>>=20
>> The index variable declared as unsigned so changing the condition alone=
 will
>> cause the endless loop=2E Can you change the variable type to signed as=
 well?
>
>Isn't the usual pattern:
>
>	while (i--)
>		t7xx_unmap_bat_skb(dpmaif_ctrl->dev, bat_req->bat_skb, i);
>
>?

I can't say it's a usual pattern, but yes, you are right and your solution=
 will work even without signedness change=2E

Jinjie have sent a V2 with int I=2E And since I assume that loop format a =
matter of taste, I am going to Ack it=2E If you think that it is not only m=
atter of taste or Jinjie wants to follow the suggested approach then I will=
 be happy to Ack a new patch with the different loop implementation=2E

--
Sergey

Hello Ilpo,

