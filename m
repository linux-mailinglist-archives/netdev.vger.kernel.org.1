Return-Path: <netdev+bounces-65907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A44FC83C4A4
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 15:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9251F260C8
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9D960269;
	Thu, 25 Jan 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpKpW/tj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C1634E2
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192787; cv=none; b=n0Y97919GTl5DwcJ8LGZlv76DZBCID95npO0uavEa9scbAS7qy7t6U8G4McVLLOokLTC+kwBaxztx1eXue+z6LQlQMMEmXdeUmoSGf+KmT2kPO5XkriKo3m1QBm0KmG1uo1h6Uq9jpGHsOo3CcaWLY+uXYRcPWfmGAniwNzMAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192787; c=relaxed/simple;
	bh=fJsZLPIoXcIT/PKaNR3olhXn7PWwkI3//knXh7FJD7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Di81DgYXRbgFRMeZmTzdaQpkosHWnyFo04CzTn+st6QGMBuOLXHBpWG4TYUYjWwd8SGxTKarJshNlHzXsliDd9eeqz/y9/TyBJoxJaPBAg7Idib5oxEfOqpBoIpQDFl6yHlTpvwIGqtzcsMt8H/ERrDGXqVgWlGd+eoKDLn2YL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpKpW/tj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a26fa294e56so692351866b.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 06:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706192784; x=1706797584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJsZLPIoXcIT/PKaNR3olhXn7PWwkI3//knXh7FJD7A=;
        b=UpKpW/tjKveMu4Ju/TjKxch2h0chwPhbYUkNSJ1FwXxRWzMz4z4Eac3KpBqE0Q7ALp
         qW9QVKJqZz0r/rD2IKAKtb5mG9x1P11FeezdNixVES7+M7u4bP1c/ogqkuwU4DZuMwq2
         xEdX6A8AVe3XAbs0w6R4oZqek9nvoCwOr1aksfXM6cc6GrR3M1JNJpw0nKZj5hwkUUpL
         eIb9jKE2pRbNFSzLy/McQPfcdwhFJcQV4wPiff/QJuRpN/JenTo7QZsDrOZNM1Tw+onm
         DkYKZgTLiTin6l5Hocn0P30iO3kSWhyT+53/h7E1j+pvv/TAvQfk9dpGujky2ECjB8qx
         82Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706192784; x=1706797584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJsZLPIoXcIT/PKaNR3olhXn7PWwkI3//knXh7FJD7A=;
        b=HSyP1z4of6mtnbe7paIvBdExcC3SID5DGb5wBN+VIqnxMpZcW8L7Y+ddqKSfiN0Hf5
         03ZGOIjQ4pJouBnz7vUp0xbQxaa1IWheYMxBB+H9b8btHd2S55s/O1JzVSneXUaSA4FO
         J3FkbB24zOgSgV8HCYHAyB5GVqYpwYMtqCImxJV2X6aGuAM0ieKXDXmoVwNgLOnPKTyX
         nUQSgTOljI/FKH+2/MDQPKJ8IkrHkJcVgdbcUPBk4R8H5cBpwu67QVl1b7+xHjmWxFEJ
         G7TldjexraAbial2x68r66YdDwgTW1zgSQEJSxUmySdRP0sSZtRuaAgfTuNigS2vEjf6
         RUiw==
X-Gm-Message-State: AOJu0YxUIlo9Eg9WA47XMKDihrajib/+waphokaNoDJgVF0xu3fiqb0E
	QShh4z0gTcSeGtvRd2NaTHj+B/u8ifwqS/OGuTHVHS5X5HmDCYXA
X-Google-Smtp-Source: AGHT+IGeZElJ0WPKik4Ye20RIkL04NkImcO5OOM0PDDEZ4c0KmIdOjl99/Zd1/Ajk3sSf7MDpaYj8g==
X-Received: by 2002:a17:906:34ce:b0:a30:b7a5:c34e with SMTP id h14-20020a17090634ce00b00a30b7a5c34emr570190ejb.17.1706192783695;
        Thu, 25 Jan 2024 06:26:23 -0800 (PST)
Received: from ?IPV6:2001:b07:646f:4a4d:e17a:bd08:d035:d8c2? ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id b24-20020a170906195800b00a2d5e914392sm1074152eje.110.2024.01.25.06.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 06:26:23 -0800 (PST)
Message-ID: <5ac49f2f-f67c-4877-9536-3f6516a79b7d@gmail.com>
Date: Thu, 25 Jan 2024 15:27:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] taprio: validate TCA_TAPRIO_ATTR_FLAGS
 through policy instead of open-coding
To: Simon Horman <horms@kernel.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
References: <20240124092118.8078-1-alessandromarcolini99@gmail.com>
 <20240125120900.GM217708@kernel.org>
Content-Language: en-US
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
In-Reply-To: <20240125120900.GM217708@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 13:09, Simon Horman wrote:

> Hi Alessandro,
>
> Perhaps there was an uncommitted local change, but
> I think an attribute is required as the second argument to
> NL_SET_ERR_MSG_ATTR(). Without that I see this code fails to compile.

Hi Simon,

Yes, you're definitely right and I'm an idiot for not double checking the patch I was submitting. I'll send the correct version, thanks!


