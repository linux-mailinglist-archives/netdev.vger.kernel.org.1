Return-Path: <netdev+bounces-122375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926BD960DCF
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC49284BAD
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03441C5782;
	Tue, 27 Aug 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCTFrcNo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE8A1C4EFB
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769715; cv=none; b=CUtw75IZGdYz7lMcQBwD0OIyHYXJW6lbebqvDNGxtsJ2t77yWLrOMyMUHQY8hVf7CSTdzr68zESvROw2CZsWsJ06khpnx6FkepFV4rtiUlD5dCrEbaX2XSVRLgenB2yn0BxM2QjtcD6vWw7ox2dRjYV8y3SkPIR6ZqvlBpuDfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769715; c=relaxed/simple;
	bh=H+6cCp+741S1jmZeN1/j+eaIKgM43f89iZXxvad582Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdrXPIC6zch+ML8jZLKB/kDx/n7zuX29MZr3YMSkTp62F0O/MFhY7kw8iq5kVV6zd0+eLDRPEHWPVgQnkl9XiZN3qGZU7EDq2/H4c6fX8/O9b/2ZiTavYgR8+YqXJlMgB1OyrkDd/OZqihmAxoAkQUgH4S+6RFhMTF2UhU4iRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kCTFrcNo; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3718cea0693so206329f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724769712; x=1725374512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eeFJp64j8+utoarUzbDHezpPIBUD0Z7OIl2+BjKQ8mE=;
        b=kCTFrcNoOsBtbodILfkOr/XO5kqwnQoM6a9Aa3SnETDNcOpGO6qllNn5mbkbFtQOHx
         B8GZtE75I+Jv1vWZhXdnaGd9YtR0TBCRCOWwCTWdQcTuqOI0Nu978mrUv8BWykS5FBJC
         5Rx7nIohK4HZBiRiUY22ir8i1eqLGeGl5E3T2C7/FVc2RiHkWSzMOlKIODrq6WWXH5ii
         MDmIW4KJz3/CbZdj6+9eGfGstNzp9iNe6ObRHbRaucb0sijZw/9xPL7Exey6b1DoHuSK
         qK5XkyXjRN3Evu2GrSdNDarf72pbvvSNWZpUuij10q24ctyQh5QL/oERhEDhIK2npWBO
         vGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769712; x=1725374512;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeFJp64j8+utoarUzbDHezpPIBUD0Z7OIl2+BjKQ8mE=;
        b=XF+k/o+JgdPPRBGqixgls/WOHGXsAvkG9DZ8W/a8aBO5MZ4sBPwLA+rlr/lqA02V9H
         q7ybe99BgZUwBQtRWGomuB9RBBQzYuQc6jj8D2pQcwbhRJLIt/E10Q3lyFxWS+mec4S7
         +yaZtsGOltxdIfEY84/PUPqcRn0gJSKBScdpZQliEL7SAVl64stMjsiSzZcP7rKRVfiP
         31joRN0jokKzZYlg1JZ7UM2flqorRVphRHqx8sFA+LrlTBr8GUI4asBZycZWyteTtU2l
         cF+TjVZquDFvYuwaQJH3T98bwt5t0pXTsc0A0rF6JLgyAzfm8DCSx0v6G2/ZZdCypawL
         cQjA==
X-Gm-Message-State: AOJu0YwcQLlLfoIgTEsQOuQo2FHHIj+UOOGVnuUY3UOhNSUVf92/POJj
	IRPbdKQrZT78dVkoDhuXGpnEvl90hVsyDRc6iiDWW8CDlJjSVxc7G4U2qKRysIJoW0O5z7vDYxo
	t
X-Google-Smtp-Source: AGHT+IEER2p+CG0AK10idopzDFngjXs66PqSkE0h5u8xVVMh/bzYLQ3F6Xn8jaT6l+lLmA5+Mb9rEg==
X-Received: by 2002:a5d:6d05:0:b0:367:9495:9016 with SMTP id ffacd0b85a97d-373118e9996mr5511256f8f.6.1724769712319;
        Tue, 27 Aug 2024 07:41:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730811001fsm13298892f8f.20.2024.08.27.07.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 07:41:51 -0700 (PDT)
Message-ID: <6b483487-1806-424c-8237-07c0de481790@linaro.org>
Date: Tue, 27 Aug 2024 16:41:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: hisilicon: hip04: fix OF node leak in probe()
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, LKML <linux-kernel@vger.kernel.org>
References: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
 <dc803f66-5f85-49d3-81e3-f56a452a71bf@web.de>
 <20240827144010.GD1368797@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240827144010.GD1368797@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/08/2024 16:40, Simon Horman wrote:
> On Sun, Aug 25, 2024 at 09:21:31PM +0200, Markus Elfring wrote:
>>> Driver is leaking OF node reference from
>>> of_parse_phandle_with_fixed_args() in probe().
>>
>> * Is there a need to improve such a change description another bit?
>>
>>   + Imperative mood
>>
>>   * Tags like “Fixes” and “Cc”
> 
> I think it would be helpful if these were either explicitly targeted for
> net-next without Fixes tags (the assumed state of affairs as-is).
> 
> 	Subject: [Patch x/n net-next] ...
> 
> Or targeted at net, with Fixes tags
> 
> 	Subject: [Patch x/n net] ...
> 
> I guess that in theory these are fixes, as resource leaks could occur.
> But perhaps that is more theory that practice. I am unsure.

I'll resend with net-next.


Best regards,
Krzysztof


