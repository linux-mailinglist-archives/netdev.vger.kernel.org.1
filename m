Return-Path: <netdev+bounces-277795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RJM1DYCj22k6EgkAu9opvQ
	(envelope-from <netdev+bounces-277795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:52:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A700A3E4108
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9B5830128E2
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 13:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4F72E9757;
	Sun, 12 Apr 2026 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZO5f3PMR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029BD2F28FF
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776001897; cv=none; b=NiqKhhXMol/lk7zXNskYP4jcfaTrHoBOGKwyuFER0ajNXiyOqvlUZDmxAxs295F8ckhCtQcSjtgCYqkfm9N78AxtO/6thmRfa1QrCJHUWootHb69ffYYunehiXGSK9EyOMbSD7BRv/xmx3tJjBxz+sEclDNvK598EI/k79CWMCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776001897; c=relaxed/simple;
	bh=57OjRtIg0ScNeEl/Sst5nryyKp+RU9LMcL+MUi2//DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acf6oiK8G4Yljg67Z9ApZGTEc0R16n3p4CPk4+MyN3UnyE90ng9PpQ3af7WfelVvnXfohtEHFFHJOHEaS5ib/Mwp2wheaKN4Ymz0W9ePEVQfI2bPEQFvgVq51l0I8IinL3ctEeL3ZFeKszZYiVSZ8IlQYT1Jq35TAbzpEE4qGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZO5f3PMR; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so7834611eec.1
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776001895; x=1776606695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2buQYzyKwWmZHgRvkBBAVMovr/55fUcx+aSacaP/Hpk=;
        b=ZO5f3PMR+c1C1KDfJzU4H1xTAn1WuhXoEpeWMfV8uQlsQkdG2AgA+/uhs+NVDVx33Z
         U0PeKmi4Qo3KL6X05yyHFDwxY+2JVFcNdhw/XG7YHmIhjXigOhSXeLSECJPGX/YOmInD
         4B/6l836ld25MOaemsI40elnV9H8UsXFm2NqdgD33iel63bLNEmO7YXbFFzs0RRol2uI
         45gDYOCdvc67fIhnIUJet3L1ZgClTKMpk8k/7gokMUVbcFAqLAmGD3RgAbf2wxwwYBG7
         qiH1lE0MDlcfVPv/iT+mPXGoVZ3DrQJ3wAEPbtMCzSgqB/MaZtV8XhTcNkzadjUrJg2S
         I72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776001895; x=1776606695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2buQYzyKwWmZHgRvkBBAVMovr/55fUcx+aSacaP/Hpk=;
        b=fEfSIwll+hnJm7GwOWbX+n/OW1yIdv9cGyIFt9r3rheGPWlNVywyHunPUsZFOSYchy
         OkpVV5wLZGmRXiOTRV8DLpV7C4xqAYhjxMcJAfWRalHtaBwust6E2X8ax0yJrb4Dv5eA
         kEXjETtgrbR8JQaEK0QfpPVVz4WyuE5icl/VExtvpJ29nhjGHCCyJMr36+FS4ODVvBAZ
         vHpzwi5Ogumye5QFT9EINqh77FGRVkQUVCKmHmYlz5KzV/ebf0spBKQpQjFRzsBxK842
         X076FZgLBrisE4A2atodu7PFcgpfvfCs/gtm3HeGhorlkO0I4kkBNChG/6IpOQE8IXXj
         2OlA==
X-Forwarded-Encrypted: i=1; AFNElJ8QA5A/RKHkp8kQJZCl655Kn11q+fTRcQBDsaryj1KRnkyvo76raIrEDeyOLdztreR4A1+vP/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTm16I7VGvvoPa/afdb4XhWsBMvWkEilfUASfXW1czSC6/oP7X
	c2F0KzGDiCQKa4WEdxPSdGr/uJVOpwWmezLa6biMh6SyGHkvbBZfbWGs
X-Gm-Gg: AeBDiet75quvdLB5DR/DHaSOzCqtBs65rCV++jraKka44xkOGcT2ZC0vTQmFcAZFHsB
	CD73ugZVeEubZVPvc/AfTrwJRz2DuN24S6FrazcnyF7LUNPjagBBkpFX4lSyBmAJBvdMxtUHNwZ
	0/VtgSIn7xZtTz//fNuK3Ets1iSnOwBlGJj7WM/7JEF7a+GpH+l3zIqr/5EchTc2RsLoa9PpPgy
	iF/50DFT6lHoZc7Kl2/FbE0gM02mVfzpY4nDCKEWjHD6LjEPfBRxlyx+Q8TnR04s0ZSj0CzFsD/
	FC7IRMlnRkomcwdncFQSobg8j1b7XmkCh6huoPvJGjqPMU7HMS2uJ5Hbb2+RdbKjTnyEE6c8QkS
	muWM6lPw5z3B555Pn5rmqVJRXwgE7V6Y0dh8NWBJ5Q6SZu7xSdJRNJjKteCNK+aA1ygUzeWv2Aa
	w2mVwNLAw+zwahztpuodEzhzMm
X-Received: by 2002:a05:7300:e614:b0:2be:142f:d499 with SMTP id 5a478bee46e88-2d589463d7bmr5513996eec.16.1776001894550;
        Sun, 12 Apr 2026 06:51:34 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:ba4::23? ([2600:6c5c:6b00:ba4::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2a4esm16032565eec.16.2026.04.12.06.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 06:51:33 -0700 (PDT)
Message-ID: <b6c325ea-8865-4aea-addd-3be2fe178244@gmail.com>
Date: Sun, 12 Apr 2026 09:51:30 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: Use napi_schedule_irqoff()
To: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, nic_swsd@realtek.com
References: <20260412014031.525061-1-tactii@gmail.com>
 <d0e1bab5-3476-4b58-834c-6e742e89539d@gmail.com>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <d0e1bab5-3476-4b58-834c-6e742e89539d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277795-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tactii@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A700A3E4108
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/12/26 07:30, Heiner Kallweit wrote:
> On 12.04.2026 03:40, Matt Vollrath wrote:
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 791277e750ba..4c0ad0de3410 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -4873,7 +4873,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>   		phy_mac_interrupt(tp->phydev);
>>   
>>   	rtl_irq_disable(tp);
>> -	napi_schedule(&tp->napi);
>> +	napi_schedule_irqoff(&tp->napi);
>>   out:
>>   	rtl_ack_events(tp, status);
>>   
> 
> Not using napi_schedule_irqoff() here is intentional,
> see 2734a24e6e5d18522fbf599135c59b82ec9b2c9e.

It looks like forced threading was fixed after your fix
to mitigate the issue of forced threading not masking
interrupts.

see 81e2073c175b887398e5bca6c004efa89983f58d

If I understand correctly, this should make
napi_schedule_irqoff() safe in any interrupt handler.


