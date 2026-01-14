Return-Path: <netdev+bounces-249932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E949FD20F57
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 20:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E561E3015E38
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 19:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D51433FE07;
	Wed, 14 Jan 2026 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvnIsTGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3C32AAD4
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417409; cv=none; b=V2o1At5JUlpha6dFL8W4/vO81vLDUh6f4t12DoMV0t+EOTybkJyzGUzjp5Pnaan1V2JlJlthFA63uANbF8d/3m+GHV4KQNedzvdGXBRVPUh9BEjURI1fPvEQCvcdGzBnjxq3C7054cDZvpWZNif52qp2Xcx18RDGSxjRhvPkHfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417409; c=relaxed/simple;
	bh=0rMQ6zOURla4mzk4Z8trD7B7gUluo/Fy3On3fQUwXtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWjSFH/3VpfHBKz8ABDpRWRQXmzj02Hdde6qKDmjUcAh/4cD8NfPm1NZjKg8IrwQE074xFeG/lnqB8Gfb9QWmeei3NIhOJkmVlaANidsJVEzTHNXURy6YtdaHhSv39xKnXm31WxHtHdo68AYRI2gjs4tX2fL8ZwHs5kpm2uoLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvnIsTGZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee4539adfso1597795e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768417407; x=1769022207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59rTEl+o7f1MOuKCLVPM1nM2JKRGkvQaPwVRBCBoMgg=;
        b=lvnIsTGZGKs9BtAOGLsXBYnNo6oczlaT7Lw4VVfpFNurZylXPsUOTYNuDqT21uiKBV
         6DkzVirfzl1oCUMXhEppImlWOGmYkqs5CBlwQrF1f8cVvK1ARf7RGvOw00K1M+MdN882
         vl3JYba1HlH8Rb+U5mOSCj8Kw/6NjY45A3dd/27bedMtELAO38LpD2vX1fYR/rVJxXeF
         iCyOeAjedAJt9XbRcyjTI91NHWjzPLNtgcXl+ZK9ixCGQlwTnNJD6pfp+FSK+p4oUqfW
         L/S4SqkhBngEAatyhhlzXXnShgTJd8vJhnNALM7pnYZQucaTaLzSxXWP9oI5aMQvKM+f
         kTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768417407; x=1769022207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59rTEl+o7f1MOuKCLVPM1nM2JKRGkvQaPwVRBCBoMgg=;
        b=m85I9VMaUTuaWuMAUSF3L9cH/MF9GAfyP+tjHXtmcxzIlgmVE20uOUCdDcRsYRbUYe
         QuDdM6BEzIg5e7e+LsEOv7So72POSatepsO9JZz0kukSPNgzVfTuh7191UlOoK6/Apzx
         3ukRsPySx/teyVxlYjwPxdRHtbrRDHOXgIi1tAr811Z4gJ8O5g8e3h0AyqcOMEdkr2Ez
         DWZ9OMjVVE/PQfU2Dzqv9u/dcP8G4qHHtA0AYrZNZYka4jiJGpNlyZmVxO2bzlVtHPCG
         NvoA2vLlTqndKf/XWCWLCZbogvT6iO9FrdOzWbaEcAcqgk6gEtgG+pZF5qUcZQsaSgj2
         BYiA==
X-Gm-Message-State: AOJu0YyCc+pZJ5pQYjfcMieLqGYHr1WWMhbvbXPV+/+n6ZEPc1mQUEc8
	WhbSKBHhIItbt58Ox4BKOaDyeaCpjz4Hrueb4Lrt3ObYFVCXstF9QoKQ
X-Gm-Gg: AY/fxX5rH49NLcxpiy3I8ZWLtIG2WfBA+RcY6maa03eJUAuIkmjRvxGcm8kI4wVfAdx
	8CoUPKWRLlVQWXjCJVWKBmobZaivrEshPDmFPeBQ5grOB8OoLgN81nOeJoyz+UkVN5HaPKGcCiS
	7uYnwYvQs9jawugDLTwr5eCsRKvAk71gMfxE+O9b9/oRXFljna5avxouwolGoDC43Xy4mCubgBx
	9TZnSopFmvmF8Ywuf3KwNnHHtoOIWJbB6dMkAbIkh50Kh42IXFtZInVGjNh52JkjH0nIqBrGA55
	MEhME4rG6jJNWdhljRDLQfIWo4H2CPItjtztSH6lDoKbpHUkEaFyg4oUc5TtRMjzaEd8fx4RlpZ
	B+GeiUhrChg6Z/UAuYaLJfCRn4FSkA0k6OcII8lcc+Rw38Ea4Twj/yoDqRGpjg1SKjGDJH9jjKp
	BtykkIS+spXxnE3A==
X-Received: by 2002:a05:600c:548c:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-47ee3371876mr49366775e9.17.1768417406589;
        Wed, 14 Jan 2026 11:03:26 -0800 (PST)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4289b83csm5779735e9.3.2026.01.14.11.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 11:03:25 -0800 (PST)
Message-ID: <b2e87b4e-c675-4e38-b28f-cc00cf969260@gmail.com>
Date: Wed, 14 Jan 2026 21:03:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wwan: t7xx: Add CONFIG_WWAN_ADB_PORT for ADB port
 control
To: "wanquan.zhong" <zwq2226404116@163.com>, loic.poulain@oss.qualcomm.com,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, ricardo.martinez@linux.intel.com
Cc: netdev@vger.kernel.org, johannes@sipsolutions.net, davem@davemloft.net,
 andrew+netdev@lunn.ch, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, wanquan.zhong@fibocom.com
References: <599905d9-19ac-4027-85d1-9b185603051c@gmail.com>
 <20260114131423.202777-1-zwq2226404116@163.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20260114131423.202777-1-zwq2226404116@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wanquan,

On 1/14/26 15:14, wanquan.zhong wrote:
> From: "wanquan.zhong" <wanquan.zhong@fibocom.com>
> 
> Changes from v2:
>    1) Add missing 'net:' subsystem prefix to commit subject for compliance
>    2) Remove redundant "to config" suffix and refine commit wording
>    3) Split overlong Kconfig help text lines to meet 72-char limit
>    4) Align EXPERT dependency desc with WWAN subsystem conventions
> 
> Add a new Kconfig option CONFIG_WWAN_ADB_PORT to control the ADB debug port
> functionality for MediaTek T7xx WWAN modem. This option depends on MTK_T7XX
> and EXPERT, defaults to 'y' to avoid breaking existing debugging workflows
> while mitigating potential security concerns on specific target systems.
> 
> This change addresses security risks on systems such as Google Chrome OS,
> where unauthorized root access could lead to malicious ADB configuration
> of the WWAN device. The ADB port is restricted via this config only; the
> MIPC port remains unrestricted as it is MTK's internal protocol port with
> no associated security risks.

As it was shared before, you cannot stop user having root privileges. He 
can simply unload your 'secured' driver and load another custom build 
module. If the patch is attempt to address a Chrome OS privileges 
separation issue, then, please, fix Chrome OS itself.

For this specific patch:

NACKed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

