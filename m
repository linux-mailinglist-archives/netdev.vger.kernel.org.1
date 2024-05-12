Return-Path: <netdev+bounces-95819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 498838C384E
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 21:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9726EB210E3
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 19:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A51524DF;
	Sun, 12 May 2024 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAD9kgiA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EB84EB31
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715543371; cv=none; b=OE0T+fA9DvPbELGvjot09hCjBDUjUtsssxwAQsOHh/iWUYfy5XYbCg1wE79Jak6RgsXPO+W9QzcRC4RFzT+bqYcqnSiq97CKHiseQ8rnLKR/dcmTN3oBdEidmtEeG1S9sg7DiJhitiTK3GMYslnM8l+2iO6H39XdRfCQKKmucpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715543371; c=relaxed/simple;
	bh=62sF46lVjf6MMv+sJ7r9wQHgsDKV3i2sIWCAQmDPgnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qiCzwCsWDGTwafnYdiOlFaYH+7MRL0vD2pnV951HLsLt9JQf/MxANpm3bnRzus9UIXSFXgGXT5QQi3radhhvFmAgIjwNPEJJ4IEP9JY3U1ifiL7l9v5oRsA1qVeR3o6mDg2Q/LLKK6vXrDO3TsK93XUzPXiF4kGjd2ukm/pLmfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAD9kgiA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34e7a35d5d4so3037901f8f.2
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715543368; x=1716148168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GBmfEGebouA9tRdV6gOaqcAJ48WQ3my4yUJM+WLcBW8=;
        b=OAD9kgiA2NxqgpvtqHQys3XhGoAIaV7Evb2e1Egc/P+b/NX90JkRufiMnIfyaQ6/jD
         HnMP+JLjLkizfBMpFKNAqfxX5LvQv19UFU2jUsTV+CFMTi6lyY+R1n36wxBiW38Hi2Jw
         YOkRZR2pEKCYZ1bIb4CRnWtLeDTyMxaKQTZ4xn3Gk5nNY0R3gyMe4JXtGPDBMrqA/Y7D
         xppcr/lHPwGPNDq5LZm+XoOXeXRg0BRU+LKvYmSDKjZiu+G7OAnW2Qks26P1X5kcX08o
         6KxwImWWrv5CFip5jeAr70/ScgZzC3oOwFOyh+ic3slsRSEl4j+TPBamSv2m1JkuZx8z
         Lp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715543368; x=1716148168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBmfEGebouA9tRdV6gOaqcAJ48WQ3my4yUJM+WLcBW8=;
        b=ajJ9MK9aMvSBHhvKM2bzpKx63yAq3mwZYP1j5I0+D7jAx2H+0qqWfNQf82nvspoCk2
         0rfvDXYlHEDH1b7oppnXa1LRt1gyXdtxdhKoxKtsBLZRPxKCtD0bKan9ZWhcUCMLaMmk
         kmxIhXztTHppRIlIdYyPu5PabDDaDqW/EFWbYItqer5lzfr+RtSyuiJCaZo1SbTQUiwD
         waIU3XMCpAAcwZvfeU/bSwqdYHdk0yHemz/21r6oGLPXiD2hVVjiiEwaiaJ5sKU2tkK9
         iTrE6fFxfxGEpFyTonsajCJOhDsKd0p23ukUfdwdIr9CJzm0U0KjfzIAnPKeS1RQ+Dnq
         CqNw==
X-Forwarded-Encrypted: i=1; AJvYcCVxqps2tUO/R2wBQWo20UZRFvdZUeAjlRH4kLjcZV3jTEyROgaAyxyXzjeSLnmQp2I2I1qSObBcsecsC1H5Eud2dboefsyf
X-Gm-Message-State: AOJu0YwJA+iA78FJnfPRW7Te37+yiFFpeGc6Sc2a1nd+LiU44miASvK1
	7gETAvR1gg2lEOU13+xMVWxwbxcWq2s8F9i+zFa2iPDO7O5IfUD5
X-Google-Smtp-Source: AGHT+IFMgy7KO0Kv7VAhWWV2osTGsTqT0hupQYlABS7PYzeD3o4GKFLRpkdGGGdsvUnIYeMt8HDHSQ==
X-Received: by 2002:a05:6000:362:b0:34f:5d07:ebcb with SMTP id ffacd0b85a97d-3504a96d4aamr6536452f8f.64.1715543367559;
        Sun, 12 May 2024 12:49:27 -0700 (PDT)
Received: from [192.168.1.58] (186.28.45.217.dyn.plus.net. [217.45.28.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351b4af0b0asm2900568f8f.100.2024.05.12.12.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 12:49:27 -0700 (PDT)
Message-ID: <c71a960f-16d3-41f0-9899-0040116b30ee@gmail.com>
Date: Sun, 12 May 2024 20:49:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: transmit queue timeouts and IRQ masking
To: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Cc: nic_swsd@realtek.com
References: <ad6a0c52-4dcb-444e-88cd-a6c490a817fe@gmail.com>
 <f4197a6d-d829-4adf-8666-1390f2355540@gmail.com>
 <5181a634-fe25-45e7-803e-eb8737990e01@gmail.com>
 <adfb0005-3283-4138-97d5-b4af3a314d98@gmail.com>
 <f0305064-64d9-4705-9846-cdc0fb103b82@gmail.com>
 <940faa90-81db-40dc-8773-1720520b10ed@gmail.com>
Content-Language: en-GB
From: Ken Milmore <ken.milmore@gmail.com>
In-Reply-To: <940faa90-81db-40dc-8773-1720520b10ed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/05/2024 17:31, Heiner Kallweit wrote:
> On 11.05.2024 00:29, Ken Milmore wrote:
>>
>> Reading this worries me though:
>>
>> https://docs.kernel.org/networking/napi.html
>> "napi_disable() and subsequent calls to the poll method only wait for the ownership of the instance to be released, not for the poll method to exit.
>> This means that drivers should avoid accessing any data structures after calling napi_complete_done()."
>>
> According to kernel doc napi_disable() waits.
> 
> /**
>  *	napi_disable - prevent NAPI from scheduling
>  *	@n: NAPI context
>  *
>  * Stop NAPI from being scheduled on this context.
>  * Waits till any outstanding processing completes.
>  */
> 
>> Which seems to imply that the IRQ enable following napi_complete_done() is unguarded, and might race with the disable on an incoming poll.
>> Is that a possibility?
> 
> Same documents states in section "Scheduling and IRQ masking":
> IRQ should only be unmasked after a successful call to napi_complete_done()
> So I think we should be fine.
> 

Nevertheless, it would be good if we could get away without the flag.

I had started out with the assumption that an interrupt acknowledgement coinciding with some part of the work being done in rtl8169_poll() might be the cause of the problem.
So it seemed natural to try guarding the whole block by disabling interrupts at the beginning.
But this seems to work just as well:

diff --git linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
index 6e34177..353ce99 100644
--- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
+++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
@@ -4659,8 +4659,10 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 
 	work_done = rtl_rx(dev, tp, budget);
 
-	if (work_done < budget && napi_complete_done(napi, work_done))
+	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		rtl_irq_disable(tp);
 		rtl_irq_enable(tp);
+	}
 
 	return work_done;
 }

On this basis, I assume the problem may actually involve some subtlety with the behaviour of the interrupt mask and status registers.

In addition, I'm not sure it is such a good idea to do away with disabling interrupts from within rtl8169_interrupt().
This causes a modest, but noticeable increase in IRQ rate which I measured at around 3 to 7%, depending on whether the load is Tx or Rx heavy and also on the setting of gro_flush_timeout and napi_defer_hard_irqs.

e.g.
Tx only test with iperf3, gro_flush_timeout=20000, napi_defer_hard_irqs=1:
Averaged 32343 vs 30165 interrupts per second, an increase of about 7%.

Bidirectional test with with gro_flush_timeout=0, napi_defer_hard_irqs=0:
Averaged 82118 vs 79689 interrupts per second, an increase of about 3%.

Given that these NICs are already fairly heavy on interrupt rate, it seems a shame to make them even worse!

All in all I preferred the solution where we do all the interrupt disabling in rtl8169_interrupt(), notwithstanding that it may require a change to the interface of napi_schedule_prep().

