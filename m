Return-Path: <netdev+bounces-76600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD53C86E5BB
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19B53B25A4D
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD4A2571;
	Fri,  1 Mar 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLfuyKAU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA81FAB
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311037; cv=none; b=nAGJXLrhwH/ywVcI0aNQ0bQtaQEmz8CN5ZVfHOJ2DabgFdj2yutqap92XkLT+4SLpzy2XPE8RESUbNjRbbJTo7kF9MP9gY5iU1NGA7lJ5xAbjJG2RJ5vr04LqhUPgT7XcMj+Eg6qcaSggXBDxm52Nlrfw+uJ1T2TU7oc3NZx0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311037; c=relaxed/simple;
	bh=W8ekqyFDNdERMviLQlmLPvASDFIuRXeZIKAz6X0wpqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpCGDlITlYP7pKWc3PfCbioBjsXB+Dgm6G2Z1WDoTeY8CXMhYqZK4FGZ+kCh30zdkOsj7CiuOmNUjhYDyKMs/jYUVHbMobfXBSwldgWvg3PVndoqtzz4bRaUDk9gsJzpP71ekMXhR8L8B1u8F6c9O+GHRnhI3g8KFJyx6vQQUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eLfuyKAU; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bb9b28acb4so1637965b6e.2
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 08:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709311035; x=1709915835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0S1pjMIEbQhahvKt9V4WgWqNibwCApPjl+YvM8irZw=;
        b=eLfuyKAUbffS/v/1thMq1zcsFshSGOAusKjCOTeSBvM+LNqqRpeC12IF7Z3bpJ5lge
         7I4OMes0RnWOBSRuVMJYfGn+5vFd5SVpnF25hXTEOk2jc+UOLZYBgUnDFTk3GxTGuTvO
         yuipT3DZVvOKftLZe0myhbCwyVPzXAj8hcB16QYTPpNkSgT59xRwBGDvs+tq6zIpBfLR
         LCvlqNnMoSyaIDOIE6HA8/XTkPvLw07NVCjyotq2D8gQKo9x5i9oqijSWg7Uw0GJXvzp
         lbjU2JBjClRe5U1815i+Jk+xEF3DZo4VHrD7J5po1kF3ENLhbMn8JYJ9SE1BMQolhmNp
         6cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311035; x=1709915835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0S1pjMIEbQhahvKt9V4WgWqNibwCApPjl+YvM8irZw=;
        b=xViouxqIizqjWB9pcQRZS7YbbZdYb1naKE00xH2OI17UsLqfW7871AYAKL6S9wqdcB
         0m3D/bOZL6fRzvyTe6Gk8WjW/77Hy9JpJ+5Hqf8GBZEEjB/UQ4EVLvn1e6SA7dTrgO0R
         Zx30xI/bYEIfTtm0VL2BinPsyO2dqo717Wa4L0m2tWlTIeYMPgmNQ6lF9qBVw6yfZRrh
         bG/CG3JPzDpC9q57mapy6uiXV/u1apTr5Lc4713YAS5jM6nTjRctXUWSvYnMmliOQNwJ
         M5g3PXz6gWjQIZ2Um4pb3At1P1FdmDRa/IVSamREomRWm2zEGBvJj29OtbW1PrPTFVPk
         OBQw==
X-Forwarded-Encrypted: i=1; AJvYcCUsT8AfpaLLp6WKBsHKYfsCb269BrbT5CL9TuWojQu55+fMqggI/Qf+4fnTYAo1wbN8QXSMIT3wwtjxb59UWRfeNX7vF/MD
X-Gm-Message-State: AOJu0YyRBabY/TqNW8mTnnRpfXEvHmD3J1/MDi1bbArkRvvD62kVl01W
	JsyND4n3Wg4WdA64sKfXTTQEM7OeWbk9NSeCBUntNbQnyOdap1FkmIaLy8a+vww=
X-Google-Smtp-Source: AGHT+IFj0GoRPprx2GuYPkyopZPppe0fMe+bFr3Nqv8uhWiYNQXQ99+Hhzb/IA0zdNSDj3aIomVZgA==
X-Received: by 2002:a05:6808:13d3:b0:3c1:7c55:373f with SMTP id d19-20020a05680813d300b003c17c55373fmr2061160oiw.6.1709311035461;
        Fri, 01 Mar 2024 08:37:15 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id bq16-20020a05622a1c1000b0042e8f150417sm1857674qtb.45.2024.03.01.08.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 08:37:15 -0800 (PST)
Message-ID: <30604225-dec5-4ba7-9e7d-4c845c8ee9d6@linaro.org>
Date: Fri, 1 Mar 2024 10:37:13 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/7] net: ipa: change ipa_interrupt_config()
 prototype
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mka@chromium.org, andersson@kernel.org,
 quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
 quic_jponduru@quicinc.com, quic_subashab@quicinc.com, elder@kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229205554.86762-1-elder@linaro.org>
 <20240229205554.86762-2-elder@linaro.org>
 <20240301162628.GF403078@kernel.org>
From: Alex Elder <elder@linaro.org>
In-Reply-To: <20240301162628.GF403078@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 10:26 AM, Simon Horman wrote:
> There are two cases where this function still returns a pointer.

Yeah I saw that.  I'm in the middle of testing v2 right now.

I'm very sorry about that.  My process includes testing
every patch but somehow I missed these errors on patches 1
and 2 this time.  (The netdev CI doesn't report all the
problems with patch 2; I'm not sure why.)

Anyway, a new version is coming.  Thanks for the note.

					-Alex

