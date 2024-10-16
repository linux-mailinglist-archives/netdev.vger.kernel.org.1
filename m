Return-Path: <netdev+bounces-136204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BD69A1013
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432D91F22B59
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFF818786A;
	Wed, 16 Oct 2024 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8tVubQM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B213C807;
	Wed, 16 Oct 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097452; cv=none; b=k6LSYJmHNS0kixRF4mjM1Sxsgb74uFHa9OlSaDoCS6gvabZzkX41/ln1QzLiHvJQ2s4qWmsJMQODrbvwquZyaqVMRRXxh5WeiuNjx7+mV7cI6N4VDWC+cR/rKE18Ek8JJtsju5EiF4YbrZqSF+PRq7Hlx/GPbEv4D/a15Bln0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097452; c=relaxed/simple;
	bh=qtvS70nwQqsJlNMl32FobWgpQUlQU/wpt7DCOpA4Coo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1/h+8jYOQSxQZAU2zwpvMLFV3H8wJhFyPKMj1kDExZ9ucvIK3C2nSa83lwP7LRrRSXVqpYNeInMdnuk4g/WdH8EsmUW/vxMk6LSzUg6WisvoVvc/9PjyMOgn9P2sUSQLZz8HDm3HiA0ZjMOpXdHapmGNSDdAQogu9NlFyKwj0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8tVubQM; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbf0e6414aso258316d6.1;
        Wed, 16 Oct 2024 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729097450; x=1729702250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8yi7ym/n0gGkllmpMlwrL8UC+mwJmI8iD8mtRyUnESA=;
        b=c8tVubQMTETKPcRGeFxXpSCdiBchY3LbcHYZ81rstARp3f9mFHkHVm8T5XaN0hnhBk
         DIIW7vkNPN+JRFIHPsMFYhgLlKjwLBkumkNvolWFKoIsYjuQLfFxrv7K/hu6e0I267ep
         wp1QYEkh6GdaCFAADZV+3dbHKHqhN8SGZPnqTjCx4pnTTbz49OqS9Wn5I2HcNuAwPeum
         8OfhkGmVJIjym1H1vtUN7fcOpg3P1YHJ5/3EKu/vwXFdrNDEIJatiiOKYGV6Pu/LTHa+
         ARuIiYttmInTWQFUyeOJh7nT0xkqgdxrv9/0PvJ+9R5MA2XiBt65Ut1RI5C2V6RCXZgG
         jpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729097450; x=1729702250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yi7ym/n0gGkllmpMlwrL8UC+mwJmI8iD8mtRyUnESA=;
        b=fPsW8pS0kk1pQtK8g4yUa6Zr97JO/rKEKqH1k8j9iD5eWBDQfxqVlZGt3EcTDKvM+j
         vQYnwp6xvaIQzT9L4VUiQAxel9lwBXN8dUoU3cYiDMW5ZZp/Rrqm5OAcltRIiF4xQ/X+
         oXzCn9PSCfoDu6hk7HSUhnLqMpTo92ArPvHqkiaOPLB/wJ8Eqlm8RFy7ltUx+0IlQdif
         evEk3MMI3DlG1MQ4Y0NfqCLsl4eI7VM4ly0qIcwOwPqph8twW0jBQeUF2xwuTYui79ao
         jwu/cbSWuCQUsW0bR/I8yZD6Jh9pviubM5+bafER0eyPECrVtrrXHF9RQVAjTx0S6XZY
         CZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCViTaqf0yXsk47nfhm/37R+m9G4zCPkqpbgKKuv7fsoCrjiGsdOMWHFLSgosUIQgKbja4Czh8AE1f6vEIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqBp/FazJXsGa4nerUqocv1fKHyoCL/5Q2ME3rZUo0YitbGws
	LM8bYGGIzSCoZo0u3Qrdd+FG/SnTfYynbHgPCxNRwx0bqmbEa4AE
X-Google-Smtp-Source: AGHT+IF32tanWFk4vBflSMsQMHGW+H3c0gZtScdPw0uUmRLbmCF5OvF51W7ZxiMQPIOXX7Ip3Ls0wg==
X-Received: by 2002:a05:6214:458a:b0:6cb:c9d0:df32 with SMTP id 6a1803df08f44-6cc2b8bc9aemr60265636d6.11.1729097450128;
        Wed, 16 Oct 2024 09:50:50 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:bc84:d25b:55d0:ee7? ([2620:10d:c091:500::7:6d88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2295acd5sm19638386d6.97.2024.10.16.09.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 09:50:49 -0700 (PDT)
Message-ID: <e78915b0-aaf5-4c89-b2a2-a2622710563c@gmail.com>
Date: Wed, 16 Oct 2024 12:50:49 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] ethtool: rss: prevent rss ctx deletion when
 in use
To: Edward Cree <ecree.xilinx@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241011183549.1581021-1-daniel.zahka@gmail.com>
 <20241011183549.1581021-2-daniel.zahka@gmail.com>
 <966a82d9-c835-e87e-2c54-90a9a2552a21@gmail.com>
 <43a98a99-4c79-4954-82f1-b634e4d1be82@gmail.com>
 <c32a876f-4d20-c975-5a2f-3fa0ab229f05@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <c32a876f-4d20-c975-5a2f-3fa0ab229f05@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/16/24 12:23 PM, Edward Cree wrote:
> On 15/10/2024 17:31, Daniel Zahka wrote:
>> On 10/14/24 6:10 AM, Edward Cree wrote:
>>> Imho it would make more sense to add core tracking of ntuple
>>>    filters, along with a refcount on the rss context.  That way
>>>    context deletion just has to check the count is zero.
>>>
>>> -ed
>> That sounds good to me. Is that something you are planning on sending patches for?
> I'm afraid I don't have the bandwidth to do it any time soon.
> If you aren't able to take this on, I'm okay with your original
>   approach to get the issue fixed; I just wanted to ensure the
>   'better' solution was considered if you do have the time for it.
Understood. I don't have enough bandwidth to commit to implementing it 
soon either.

