Return-Path: <netdev+bounces-114230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98948941966
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F77A1F25309
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570251A619A;
	Tue, 30 Jul 2024 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="MbWuQbYB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D941A617E
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357109; cv=none; b=ic4M5K+YdZfy2DX1d20bZ7zCEW2ueteyCjSTBQ9iH9vCJPYPUq+ABrYwRS5qYw/WmafCNGt1TxhD1Vp2jxlXhSUqlEdKvgQQaRjNSwdVujHzX6Bk4RIHOAtR82mUKZh5NW0jJLyUkuNmj+MzJaOhZFkxJ6uHa5SzrEw96sWzZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357109; c=relaxed/simple;
	bh=C4eh0fmTz0+252ic1Rz388oLSSyUr4bpLJf+JQixmUA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=J0dXwvjyRs013e21eDMsBJ+ARIcu9+ftzF/ezsVHk6EWxelvSPLrzXqRxAYh4rASmtd6w+yqIPUS8qmvPhoizzCBQBLtd+qWUJnf/R7fcMInWLMnrHP9OikysG4ckySaulZXEJj/cP2OUg0IhS2/RgktZsQFXUpU3688DIqoy8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=MbWuQbYB; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39641271f2aso18603405ab.3
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1722357106; x=1722961906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNBJvcFevwmgBZA9//H4dblcQszt8ZqZ+jbcb4XqUhA=;
        b=MbWuQbYBuEaEn5At2enlSy9kxprcU/x71Lq+xbNfcNXGjo2qM4i2LJU1WFq63HnlOX
         croWrmESKwADhXypNl5Q6yECRdVc2JdzdR9v4P9UuI1qUgAWCU/8DIaMYlb1BSS32K44
         4ZWumJp9aObz1a0WX+ftVaKh19u2g3ZoJQ4N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357106; x=1722961906;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNBJvcFevwmgBZA9//H4dblcQszt8ZqZ+jbcb4XqUhA=;
        b=kNaNlNtyutD1C53wHep2G0ctYaUTYyUdDs4tJzW9IJSAC/+zmOoUlZeKWFjPM+HWrG
         cQdWoKqrytX+TgNSb+II7bsSdX1S/njCvsY1kZgzQ5vVydwmPa3MMdNZV185ie5cx8aZ
         XEa2+NFm8KBO9xJdB02cJnfwHeHeVxnWUCXJEfAu/nUXjvBwugPEbYvuGO6l6rOifaJ7
         OLRzo5v3UKqeIyy1ipt9ZUpik0YFo9PZC2wbk+edNMRBpa5lz5rmB+XXCeWQH787ayOU
         lOgyW4uleUVsnNdN8h4JVMzxSk/9c5QKCM/UeiczkpdLqUvAQ1HKjTISuSTjPua4G9Bi
         AYBA==
X-Forwarded-Encrypted: i=1; AJvYcCW9pcbzkRsDgVpZd9cZtbGFFxK0EEIia4uy3XNhVYezy6ltUDUnKcZGyiYbig3dT95ZaZvTi1m4KK0akt+8cTpQLI47SET9
X-Gm-Message-State: AOJu0Yw+DO5AZFIJ1D5+ai5B10xi8nwbsN89/bf5qj0/rYTd8q0vs0BT
	dN6dTrlH78Hke0fm5BknUgYgXZUdwaLkro6Icj3PoLKC2BxKNh+wX2ieEzIprQ==
X-Google-Smtp-Source: AGHT+IEHkfnVgoIPIizd+q5uKxNaKPx3+5xQ2nPzwl2AgH3Q91Fem7hTqlgzJdUkSyc28QiVHZJZTw==
X-Received: by 2002:a05:6e02:20ea:b0:380:f340:ad66 with SMTP id e9e14a558f8ab-39aec42d8e9mr143720905ab.26.1722357106157;
        Tue, 30 Jul 2024 09:31:46 -0700 (PDT)
Received: from [10.211.55.3] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-39a22e7e79fsm48336615ab.4.2024.07.30.09.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 09:31:45 -0700 (PDT)
Message-ID: <3f987064-c955-4554-81fa-03b21dfa51e8@ieee.org>
Date: Tue, 30 Jul 2024 11:31:44 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: MAINTAINERS: Demote Qualcomm IPA to
 "maintained"
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alex Elder <elder@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240730104016.22103-1-krzysztof.kozlowski@linaro.org>
 <31f49da0-403c-40af-b61b-8e05f5b343e8@ieee.org>
In-Reply-To: <31f49da0-403c-40af-b61b-8e05f5b343e8@ieee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/30/24 11:29 AM, Alex Elder wrote:
> On 7/30/24 5:40 AM, Krzysztof Kozlowski wrote:
>> To the best of my knowledge, Alex Elder is not being paid to support
>> Qualcomm IPA networking drivers, so drop the status from "supported" to
>> "maintained".
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I hadn't thought much about the distinction, and it might not
> make a lot of difference right now.  But it's true I'm not
> being *paid* to maintain the IPA driver (but will continue).
> 
> Acked-by: Alex Elder <elder@kernel.org>

Oh, and to be clear, please keep it "Maintained" and not
"Odd Fixes".

					-Alex


> 
> 
>> ---
>>
>> ... or maybe this should be Odd Fixes?
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 43e7668aacb0..f1c80c9fc213 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18452,7 +18452,7 @@ F:    drivers/usb/misc/qcom_eud.c
>>   QCOM IPA DRIVER
>>   M:    Alex Elder <elder@kernel.org>
>>   L:    netdev@vger.kernel.org
>> -S:    Supported
>> +S:    Maintained
>>   F:    drivers/net/ipa/
>>   QEMU MACHINE EMULATOR AND VIRTUALIZER SUPPORT
> 


