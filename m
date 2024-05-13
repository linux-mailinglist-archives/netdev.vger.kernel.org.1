Return-Path: <netdev+bounces-95825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62138C3998
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 02:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E7A1F21356
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 00:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB89636D;
	Mon, 13 May 2024 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFcAA63x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE017E
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715560048; cv=none; b=Py8wmlHxT0H4CmoX+/3wadPsGrSHvEb2iwAOLiIed8pIAXCaEN1V7FAZ8dLKLMTRHcTM9CwvnSHZvv1xT24bTei1dJuxHiz+1FdsGweWiFMTZffspgO0gwndCxaNqg76kudG1028gd0ODpAnSwD5OgSj3tuaTJMPY/AB/dXo0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715560048; c=relaxed/simple;
	bh=RcChCK/e2P8PPV38DAKw/luj9UjKgRLyOb6xsiyRB/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYVNTsg+RnzIbycOJJn6H+P3mLUYmTlbjl6CztFpMR2udXPbNtdqlxHg5F0LdDR4bpEsYAbKjH03hfWJSTOIVi7jy2uToWEPQoqYVdkU4rst+ZkA1Dqv89dy4U279G3M7tGk/iagnkwuzLr4DtRaAz1QAZsOyKStbDaKFQt4h9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFcAA63x; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34e7a35d5d4so3150053f8f.2
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 17:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715560045; x=1716164845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3JRaPexzqE9WZbiz3ZPDh0MH19zYg04J06+HDVDUWdQ=;
        b=BFcAA63xLtpozmhl1edtAsqczWggScxqrFszAGORd1JqLE7LCqxrAEQCFjHB/CtehT
         iXvcAShBL3vD0oyNhtgy4kLBeOhdNVUgwHkjoyKc57Mk6pe0jJwJg0GIO1h9KxtiKo3o
         chKi8PEqDA+oPrM3dM47Vlg2NXHYXWa17sMeAZIOHF3aTfV7jj4e9D7bzMxGGNUxVuXd
         x20bEIjIVMCxGT9Ai1hPhJ6R/n1KlfoVp7O+cZZXTbPI7ZDYlwvPE6hB+Z7NSwsnaQft
         WIJTGd3J3l+sbHFW3Ou5vyjAi2QjzxYaNnSwRDje95x2HYKKEOH9nJcs4DPyJWxI44ra
         7YkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715560045; x=1716164845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JRaPexzqE9WZbiz3ZPDh0MH19zYg04J06+HDVDUWdQ=;
        b=gm6u4A6iR/cNowejsYs6ksYvJiX15mOoCzGXk22JtV4AjqVxgvLK3OQP+VcbQOAygY
         Z2Ly71HI+XekADcoX0rV/OeO6lHICQtkH2NWIvbTl99L32Hs7xF8+JDlLJb5/ImwkuVn
         S6wYPRepAED/guwLZz6XAPQ48KqxK16siHaZNx4zGHPYroJC0Ksilcbsuw8L82/dcc5x
         wZv4ifQ01xJldHlRubxyPFtN17VLVwkmGcchzsSBBoR9/AY6VjCJQTYkLmCv4pQFQt75
         mx05eWdPmyH59p0VCpR8LzYx+IcDq5lmunmeTcJR8kzio3enm8WhDnM8BS5Kz3JetBiI
         Pf3g==
X-Forwarded-Encrypted: i=1; AJvYcCVAtFZsXnkrLruzFbCxahEqYlNVU/xC1FZeSBlrDhdr2fK9Maq8nxSYE3WlAs64xxtiCRzQ7pX/XLZ1mTojysxH4i7xyDe2
X-Gm-Message-State: AOJu0YyUqm1YZjVttKa4IIu1hXv6O4OntglPnEnbxlIH5v91C8ZTNhA/
	AzRP+zkQP65Eib7Qn9Bv91ykGHPyiqSsydDPWmAAA7hqk1Sjz43L
X-Google-Smtp-Source: AGHT+IHcxOC//KVIkrzhguV3cMvMxSX/17hb5BtojA51FsVqPabuYS8aNLOWVECgH6xa+UD/6IoDcQ==
X-Received: by 2002:adf:ed8d:0:b0:34d:8bc0:3f5a with SMTP id ffacd0b85a97d-3504a206d19mr5768723f8f.0.1715560045070;
        Sun, 12 May 2024 17:27:25 -0700 (PDT)
Received: from [192.168.1.58] (186.28.45.217.dyn.plus.net. [217.45.28.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3518d817ee2sm6129666f8f.2.2024.05.12.17.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 17:27:24 -0700 (PDT)
Message-ID: <d4e9e118-b4c0-4917-b9f0-39ac52229d30@gmail.com>
Date: Mon, 13 May 2024 01:27:24 +0100
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
 <c71a960f-16d3-41f0-9899-0040116b30ee@gmail.com>
 <35fa38fc-9d1e-4a22-86dd-a4c9147d7f70@gmail.com>
Content-Language: en-GB
From: Ken Milmore <ken.milmore@gmail.com>
In-Reply-To: <35fa38fc-9d1e-4a22-86dd-a4c9147d7f70@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/05/2024 23:08, Heiner Kallweit wrote:
> On 12.05.2024 21:49, Ken Milmore wrote:
>>
>> I had started out with the assumption that an interrupt acknowledgement coinciding with some part of the work being done in rtl8169_poll() might be the cause of the problem.
>> So it seemed natural to try guarding the whole block by disabling interrupts at the beginning.
>> But this seems to work just as well:
>>
>> diff --git linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
>> index 6e34177..353ce99 100644
>> --- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
>> +++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -4659,8 +4659,10 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
>>  
>>  	work_done = rtl_rx(dev, tp, budget);
>>  
>> -	if (work_done < budget && napi_complete_done(napi, work_done))
>> +	if (work_done < budget && napi_complete_done(napi, work_done)) {
>> +		rtl_irq_disable(tp);
>>  		rtl_irq_enable(tp);
>> +	}
>>  
>>  	return work_done;
>>  }
>>
>> On this basis, I assume the problem may actually involve some subtlety with the behaviour of the interrupt mask and status registers.
>>
> In the register dump in your original report the interrupt mask is set.
> So it seems rtl_irq_enable() was executed. I don't have an explanation
> why a previous rtl_irq_disable() makes a difference.
> Interesting would be whether it has to be a write to the interrupt mask
> register, or whether a write to any register is sufficient.
> 

In place of calling rtl_irq_disable(), I tried poking at the doorbell and at some of the unused timer registers. These had no effect.

I tried writing various different values to the mask register:

RTL_W32(tp, IntrMask_8125, 0x00); // worked, naturally
RTL_W32(tp, IntrMask_8125, 0x3f); // no effect
RTL_W32(tp, IntrMask_8125, 0x3b); // no effect
RTL_W32(tp, IntrMask_8125, 0x3a); // worked!

So masking both TxOK and RxOK before unmasking seemed to work, but masking either of them individually didn't.

Also, masking just TxOK then just RxOK in sequence, or vice versa didn't seem to work; they both had to be masked together.

YMMV! :-)

