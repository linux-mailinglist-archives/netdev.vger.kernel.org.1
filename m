Return-Path: <netdev+bounces-237425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2E1C4B38D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DBB84F15EE
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0CE348877;
	Tue, 11 Nov 2025 02:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY7TLh0m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9009348463
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828323; cv=none; b=E+ZjntPapTRM4Y3pFNn05AFrSCkRB+xBbyfyO+t9q/efcvYhcFDZP22vCwPY2fUVOI1u3yseAnv1j5Cyv3QN9Gl3ouqKnCAvrIbI2Z0raG/prD0+63W2pZM8x9nTpVt7Lnx72yb/5zK06giTHbXDIehmOTb9IjQZOEZsje/BTxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828323; c=relaxed/simple;
	bh=yV9cPHk8dIKIWoV6mdgwaGrSx9FwHfzI8XWgtoJnrQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPzyWrvZZdTMiQjmpuo/pKSLGrCxzul0If9p1xsGbM2/MEBnBBukYZMFwpPE+j+X5kMMgohLsGrIuElOwXi8NVA02qrWK8NJBZfK9FsJPArnOa6ESs0OwVfjV7/r/olWIMo0momu027lfIRIisjp2ZOflC3LohjG46CCeBe5cEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY7TLh0m; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4eda26a04bfso36062381cf.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 18:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762828319; x=1763433119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/klxSk7UtTirsvyrKiSGuSrx879X0M+sdkmegY3UDfY=;
        b=mY7TLh0mVfrD9ru9QrZiBGmdJOXDxfpMg/1/xH7q1yLWYusA2X4S8YorYJsMl2wwfr
         tqZ8UMImCxMLdlT+lq0RZICM38x/eVk6IwId3mI7vnb0Dx+dbN9uqlUl7/BYAIf3oIcl
         m4jQMzvBMdU0BtP5WqvrwR2DKtnAo/rEkjMzD0kHd2/EMCN/wc0TS1M4nx/e+lr2s/a2
         sKE2dYA9AOF34xSloa7HcjYT9IhCXG2b/FEBsItQSi0/uuKJ66Pi0NiFK1bG+peD09Fo
         nmy3ps+D9+8lTi5BqczHeOxewVhtkDdUZ2BXZTA1fg1mptDoz8IMMNOX2qrBhWbDCcan
         WyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762828319; x=1763433119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/klxSk7UtTirsvyrKiSGuSrx879X0M+sdkmegY3UDfY=;
        b=cg95nrsUcq52GKFhvOf8Kz22f2YouxB5IIXRj9TFNahKqXt66rIAffkwEAHOFPFmAU
         HJpVmN1x+PXKuuj98YmRIEGLUF3rKCL8/RGg2WJhVxZbpGBUXbRdRFSg7ojOzfMqjxy2
         o5mu1bosRODihB/yizReOxPV7F+YmmbgQXEjpo3NSYM0Yn8wVkaGyT2NrakzMtsCtqrT
         ze0yO0yzb6Aq/8oofJ51dIuUT7IqecXDjq+TayvD+N+TIxLxbl9y4rpqXdGbGfzDFx4S
         HP3rgH0c8gFikaoRbG6Nq3YlUV5opcpYzx7GLwhntWTmmKfnPa8GFKfIlrdYEaZ5y1S1
         lzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnqppNrDbLE9EyonhLj/n/6oCFxByXFqcZHK7elzn94qPTowmOSJmlGPHmYqQjzrCz9JYvP+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/FqFqkkiTHJpLGS6HhNNEf35rItHp0s4ZzPItpgObiyW5kTOH
	UKF5f/qQicW94r2IfM9mOfMN5QT/Ykn4oQPaPqfDQoptaw90hGWXEdCV
X-Gm-Gg: ASbGnctQCVF03O1YpMwppCPbDt85G8LTURhjL3U60vXJ4aEFaaQrg+0mjmClMmcLdP8
	IUlmviKv/BIsElc/Pyw1WdkOu9xHR5ZcPBujrYLeNzR4dQjkIK6BXfLkxEn+D28VQ8/HJ89Dy/G
	10eR82aSI250q1KpqUJiebCN4JVPZteaT2UwRBFsKN69LtSsOsqxZBfLlrC4oXtWIfUd8+V94xr
	X8Y8ZJVXWD8VdIrBytNYQYeAbNBn0ohD04PsQwpQIdlRfKJS+PS2CerLQsQ2PTnps/gEcJUvR3D
	0Ljvq/D1NhMBT4snBQA+OyBvNhrpRtYhZE/I4nSND8rO+51E5WK9PI1U6g/OUSQuxnU8t7fKyvi
	gRWYPfMV2NledVgRR2Uw0v8Brs4ByUkWNJhryif+YvDGMIh1I3zro2d0c+Wj5PSqmNA5yhKljEi
	JZGKrnKfc=
X-Google-Smtp-Source: AGHT+IFn+vjJHlq24fT2sBNnkUYmhDssFsbnrCMPiJF+OP/zw7CiLhchDG+Dlttk0AGAXdtB6JpCuw==
X-Received: by 2002:ac8:5d56:0:b0:4e8:9f46:402e with SMTP id d75a77b69052e-4eda4f90156mr128481231cf.40.1762828318658;
        Mon, 10 Nov 2025 18:31:58 -0800 (PST)
Received: from [192.168.1.50] ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4edcab79093sm8694271cf.18.2025.11.10.18.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 18:31:58 -0800 (PST)
Message-ID: <d836336a-7022-44e3-9416-1e6cc6a70155@gmail.com>
Date: Tue, 11 Nov 2025 09:31:49 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/9] xfrm docs update
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
 <aRJ3rVhjky-YmoEj@archie.me> <20251110160807.02b93efc@kernel.org>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20251110160807.02b93efc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/25 07:08, Jakub Kicinski wrote:
> On Tue, 11 Nov 2025 06:39:25 +0700 Bagas Sanjaya wrote:
>> On Mon, Nov 03, 2025 at 08:50:21AM +0700, Bagas Sanjaya wrote:
>>> Hi,
>>>
>>> Here are xfrm documentation patches. Patches [1-7/9] are formatting polishing;
>>> [8/9] groups the docs and [9/9] adds MAINTAINERS entries for them.
>>
>> netdev maintainers: Would you like to merge this series or not?
> 
> Steffen said he will merge it.

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

