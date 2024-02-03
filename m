Return-Path: <netdev+bounces-68807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E32A848560
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 12:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1212882F7
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 11:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DC02A8D7;
	Sat,  3 Feb 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARtRV0ZI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DEB5D73A
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706961577; cv=none; b=nkgeUJKfxZD/rsOIMg0EzK/F780ORRjKiMQDjHgINgDXrRaS8ct+lnYtA9oMQ431iIyfW9r6v8znW6+HGPVLY5jaX44ds1Q3c+UtR9BTTRd/wdG1WqRp0JROiXOc6Ysld4SfPacK/t+b+nm7EzyB5Ke4CLivkz7zqjTKw9wQqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706961577; c=relaxed/simple;
	bh=flNffuDSgwlQSeH3OFlqn90brz9zzvCWxzwyPzXceAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVSVq2W0acZrbPRcaMPEw8r89U+TN3IFj5M5iAP7lLSuq4cVZRrlhCTTVcjEQFPanNfKliTKTdJolGJkWDWPnSpTNeUAx3FOKtRItCTUwiEMIbKXqS/8fYFJET0hpMUih1XffbiZn4k6nJTbdi574ACUydctUnomuLEgtkhYL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARtRV0ZI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fc6343bd2so13442635e9.1
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 03:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706961574; x=1707566374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GCEB4R5by0vstQemKRMCu1+Gv6yjqBk+uklQRLjgwoc=;
        b=ARtRV0ZIdxyLeQgBChpEl9lQVo0UIR6fUHUp8hPAlrinogdsxg9mdb4GThbmb0g8ci
         Jc0L780Npuqh2XYglfJelrMotokhTpw4megR8IUnuKaNyiak7JWkyiy+Zoc4rvVIlbKW
         Dtv4TZuKZ9uP2BKo99SuPQUZbkXedvB3h2k9MV7kvkY639Zdvmn+KRUQ5dFpJJP1DBFY
         +1kFxcZzVXvJ/ZRqy1q0FLWTeHNSVmPwbv5uMPLRLzp2gqLMNS36cSLJRd9GMmNgjMWV
         3b76o7Yl2M1FhE3jwu6CFwKJZ3o5bZDl1Yn6BpaY4fky10kIYB5Yvj5MaTH4fR1ZqPho
         HpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706961574; x=1707566374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCEB4R5by0vstQemKRMCu1+Gv6yjqBk+uklQRLjgwoc=;
        b=t/RSVxOTJ8iVb8luFI6XSg4ngSTOpdFfzErxPT/Z4olIw4m95u3uWWj3m5XboUdI3r
         53ZtXuO/nkCVdbU/+yeXAKIMVx/I6wYigDEdHiULUk6x9HLH/c4SPCWoP6Ka5rNQ/8bG
         W4FZ4bepCHtBIYiqPSm2Wn2icLAR2P6cZyaR+7nlovf8k9bmpeEfI5OBVsxWHzqv9vco
         smBvM2eEm6c/tGjsp6rhgxaO55JP39zTt7Vgi7IMfWrwl80C/2+tiBij6+ZxwTONhXSA
         3BBNNA1+jeWj71j4gFj+ceH8xKy++xJTAn8z1ZN5ns00pZS16TYLzfMBwa9a9NVTzOGu
         ZHpw==
X-Gm-Message-State: AOJu0YyK61l2RQy6vU6zK4/4DypVELfuk03gl25OrmujLzr+n+0vLKVL
	2RrFiBEZBHRy5jGsRlqtzwoBvAhhULHMbBOjRLjC30XpLps+Jr5MbbLMqf60GZwe2g==
X-Google-Smtp-Source: AGHT+IGut4oQpN/6pSKrYHIRBeaW4afCSW1uSmPndaVV76TdwCKexTEalZVh2BA+KWllPqu/AM7pwA==
X-Received: by 2002:a05:600c:534f:b0:40e:4d65:e5a1 with SMTP id hi15-20020a05600c534f00b0040e4d65e5a1mr726468wmb.10.1706961574227;
        Sat, 03 Feb 2024 03:59:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW7QHk0CxhIRMH2RA5gDZekNF9q0RCvkQbODobchShVCoSTmfps9RdYCN/Kg+kc90stQrM0nClrYDj1rFaOGSJWtlVP1U2A9U8TNSI6nATS/hY9hssKrDPjjKJX8hGDX5o+DQL+6l4ycVoavT4W2Hn3DbiH5ITTLjOisLgY3fT8iztvgjSm3PR9CtJ/gY5nqgDlGYzKNsQbCq5Ye0QeDCkNm5AIykVoAMBKUrhhv4rQpWsM9g4DkMsGfVEsdYD2Rf7NvQsOpsZrnmrG9vtwn2YRQQppb0m6r3UjiXf6DsIkejc+MaeV3kFSDCCVMBEZMg==
Received: from ?IPV6:2001:b07:646f:4a4d:e17a:bd08:d035:d8c2? ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id bg8-20020a05600c3c8800b0040fb03f803esm2713846wmb.24.2024.02.03.03.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 03:59:33 -0800 (PST)
Message-ID: <85d3f828-1a1a-4614-bd02-9ff07a8fe621@gmail.com>
Date: Sat, 3 Feb 2024 13:00:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 3/3] tools: ynl: add support for encoding
 multi-attr
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, sdf@google.com, chuck.lever@oracle.com,
 lorenzo@kernel.org, jacob.e.keller@intel.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <cover.1706882196.git.alessandromarcolini99@gmail.com>
 <9399f6f7bda6c845194419952dfbcf0d42142652.1706882196.git.alessandromarcolini99@gmail.com>
 <20240202181755.292c165c@kernel.org>
Content-Language: en-US
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
In-Reply-To: <20240202181755.292c165c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/24 03:17, Jakub Kicinski wrote:
> On Fri,  2 Feb 2024 15:00:05 +0100 Alessandro Marcolini wrote:
>>          nl_type = attr.value
>> +        if attr.is_multi and isinstance(value, list):
>> +            attr_payload = b''
>> +            for subvalue in value:
>> +                attr_payload += self._add_attr(space, name, subvalue, search_attrs)
>> +            return attr_payload
>>          if attr["type"] == 'nest':
> nit: would you mind adding an empty line before and after the new
> block? It's logically separate from the other code, sort of an
> alternative to the "actual" handling, as well as finding the attr set.

This makes sense.

> Also agreed on adding an example to the cover letter (either one or
> both).
>
> With that feel free to add:
>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>
> on all 3 patches in v4.
Perfect, I'll post the v4 soon with both the examples. Thanks!

