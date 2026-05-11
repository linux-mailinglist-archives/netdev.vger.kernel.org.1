Return-Path: <netdev+bounces-286601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL7hH3GzAWppigEAu9opvQ
	(envelope-from <netdev+bounces-286601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:46:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E550C22F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4616301060C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921743D891D;
	Mon, 11 May 2026 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvn1Nbja"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA25F3CB2CF
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496255; cv=none; b=WYSVp2tdh08hcBhGGu6GP2YBtX7wk7SNyCG7hJ66UFuw7RltPXObAK4Jpf79vrJ+HQVqPB+Smh/NVMADWZ5VWzCdqZuCzYMVKU2h4h0kwKQlrKbzg7WkUqcG1OF7G9QaTxl3lEZZL9h5/ngvM7mmBGmyi6eI/mysGcMW/luvW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496255; c=relaxed/simple;
	bh=kcJ9aMR022H0xLEoMibETFRjOtPHp4AblypC0I7Y8z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbinecqsO5Wr40H63mLgLqFsotYt8etVFSOGgTsgaXeqGe6X4ohTRVoBLCLLzjnbm82ECq5VdNdh7QS3E12DNKuDPGv2C7LTfnmgF09CvG2Oth3mgBUr9lrlwUGdEvVlUnlq+8xbeX5ZIA9XMniCK0ZKYXe1jikPkdl/hBwd1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvn1Nbja; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe62837baso2095014f8f.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 03:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778496251; x=1779101051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcj/ah2Qr0zOfJsIJp0MzzxDrHgIa5JutYsmfmVPFZg=;
        b=fvn1NbjaDEXWAW07NVFfmKO1CY6Y0NYJ8O7745NasrWD2H9V1Mr96E71RG2QP4KjM6
         lrNFCSkauxxgTX8enZ5Y1XiXa5Fqr18LVWzjZ7NphiAwpOHHIHRPW3kF8MPY6DuFBj2S
         G77sfQC+DF/bL3v/v6CL1HzOmFrNK9lTtwSsUDt1QENbmveKlhvupqFkfSXfEhjg3w60
         4Hilmxe2U/IE76ShAgJrI1u9ydeGs7jE7mAbV2Jyr+TkcviR00oO83+0oAB0jWVV+sxw
         viP1lj7ifD3EMoSTfyNbaWpbyzQqtTl+NPhL6yO7/vvCS8C0fW7DTWVo5OWL6W5Q1tV/
         YC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496251; x=1779101051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcj/ah2Qr0zOfJsIJp0MzzxDrHgIa5JutYsmfmVPFZg=;
        b=S9pZRtCKR0kqpfxfx8lsUkhPuWJyY+13SUIxhh2VUJDUtz0xJ6z4lXUxY0F3cITJG0
         +I+vC+x+dv7+07bq6UkzwYjB5HPU7QqS9Qqbq3lG3ESu4+EPEuLlBWYV4/4XVkes8CLJ
         ZTd+Y7r+YsMJ6D6BkPmsbCwJi+KR/o+jiXPvu0XDnU6amVU6nCSVet7zPRLZvBEBRDH5
         5ejXSqgc9RLY0Ida6i82Fslhy5ijqfc0TH8WzLWm0I69vsuxAj5tWo+I0SqbNYLUMbms
         gSzzXj539jpZYoanNDN+9UVioadrBf+fqr+wosl5KXgLsf/rqnaQ/zheQWtpQdLCOXhv
         do5g==
X-Forwarded-Encrypted: i=1; AFNElJ+r2yVHI5DZyusBfzgffEsxBZJwYWB8OY97FWJIAxZRQ4eyHss1ltHp7YUHQn2tjwduflXYgKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFaR/Yx+FyvZp+bXd7sM0MKHM9UAiT9WoaP5wkmyP2ETPv5bZ
	0E3CfMug9Hd41+S3T43f471rZi4lb5bq7lNwT9fU6+lqOfFqkkWzb3PM
X-Gm-Gg: Acq92OGNTHH8LVhXluhw8eGfHJz/oHLMDqzKueNLr/cV6vnhZBpYzQJSs3Bl/ukgf4C
	CgSng4o91VwOxFBOR74+xXTjxceOWqbqiR0zHVvrAcOEyjd0hNkTCZlz/AWlzTXmrpnjq6kdRUk
	tRNPml99dgXFb/f9e7CEfFypOmJCAofwA+HZHynxBianBUi1MmwSt5NZm5PUqrzqNXwIRCvVRjv
	xFuRHeMU/6ZMiHNIskQv6b1Qq0KVRMdWm7q+ZQV8yIiiK2TZQDMGCO8+ftVlYHRG3RsQ4NWACJ5
	to5yu8lY/6cZqvfPDsNzPiO7v+m3VxtiesxN2Lko0KkkfMja1ykdmu9sTT2iZwNqpolWJcNhoia
	rYJwn4vGNhgARFayKeR0VmcqVz9L+C2pvkm6qsm1nkA4wnLF5rO95g1cisxEs5hCKUR3ULLwNHi
	WVnZe1TWMgV/7TorqeLxEFejiVSZe12FQjhoFmzsvBDYCvd1S0y1ZTs6emr+gGiaLG8mCgSL4+g
	YRxI1RddHU=
X-Received: by 2002:a05:600c:8115:b0:48a:53ea:1408 with SMTP id 5b1f17b1804b1-48e51e1804amr361769305e9.8.1778496251052;
        Mon, 11 May 2026 03:44:11 -0700 (PDT)
Received: from [192.168.50.249] (host-82-48-74-166.retail.telecomitalia.it. [82.48.74.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fff9ab8sm186358945e9.2.2026.05.11.03.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 03:44:10 -0700 (PDT)
Message-ID: <f176bf40-a5c8-4f6f-86db-ebdbff639da9@gmail.com>
Date: Mon, 11 May 2026 12:44:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: nxp-nci: i2c: restore IRQ trigger fallback
To: David Heidelberg <david@ixit.cz>, Carl Lee <carl.lee@amd.com>,
 netdev@vger.kernel.org, krzk@kernel.org, peter.shen@amd.com,
 colin.huang2@amd.com
Cc: linux-kernel@vger.kernel.org, oe-linux-nfc@lists.linux.dev
References: <20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com>
 <824cb117-1676-4a82-b77c-8908efdffa0e@gmail.com>
 <862b37a1-a25b-49d0-902d-cbb082e2822d@ixit.cz>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <862b37a1-a25b-49d0-902d-cbb082e2822d@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 236E550C22F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-286601-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucastefanige1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 11/05/2026 12:11, David Heidelberg wrote:
> On 11/03/2026 12:08, Luca Stefani wrote:
>>
>> On 11/03/2026 10:26, Carl Lee wrote:
>>> The driver previously relied on IRQF_TRIGGER_RISING when requesting
>>> the interrupt. This was removed to rely on the trigger type provided
>>> by firmware.
>>>
>>> However, some platforms do not propagate the interrupt trigger type
>>> to the IRQ descriptor, resulting in interrupts not being triggered.
>>>
>>> Use the trigger type provided by firmware when available and fall
>>> back to the historically used rising-edge trigger otherwise.
>>>
>>> Signed-off-by: Carl Lee<carl.lee@amd.com>
>>> ---
>>>   drivers/nfc/nxp-nci/i2c.c | 11 ++++++++++-
>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
>>> index 6a5ce8ff91f0..6339586a6a1b 100644
>>> --- a/drivers/nfc/nxp-nci/i2c.c
>>> +++ b/drivers/nfc/nxp-nci/i2c.c
>>> @@ -268,6 +268,7 @@ static int nxp_nci_i2c_probe(struct i2c_client 
>>> *client)
>>>       struct device *dev = &client->dev;
>>>       struct nxp_nci_i2c_phy *phy;
>>>       int r;
>>> +    unsigned long irqflags;
>>>       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>>>           nfc_err(&client->dev, "Need I2C_FUNC_I2C\n");
>>> @@ -303,9 +304,17 @@ static int nxp_nci_i2c_probe(struct i2c_client 
>>> *client)
>>>       if (r < 0)
>>>           return r;
>>> +    /* Prefer the trigger type configured by firmware.
>>> +     * Some platforms do not provide it, so fall back to the
>>> +     * historically used rising-edge trigger.
>>> +     */
>>> +    irqflags = irq_get_trigger_type(client->irq);
>> Doesn't build, needs #include <linux/irq.h>
>>> +    if (!irqflags)
>>> +        irqflags = IRQF_TRIGGER_RISING;
>>> +
>>>       r = request_threaded_irq(client->irq, NULL,
>>>                    nxp_nci_i2c_irq_thread_fn,
>>> -                 IRQF_ONESHOT,
>>> +                 irqflags | IRQF_ONESHOT,
>>>                    NXP_NCI_I2C_DRIVER_NAME, phy);
>>>       if (r < 0)
>>>           nfc_err(&client->dev, "Unable to register IRQ handler\n");
>>>
>>> ---
>>> base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8
>>> change-id: 
>>> 20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-cda942530c60
>>>
>>> Best regards,
>>
>> My ACPI NXP1001 table specifies ActiveHigh that properly gets 
>> translated into IRQF_TRIGGER_HIGH.
>
> Hello Luca,
>
> I'm looking into the issue, I wonder
> would make sense to provide ACPI quirk then?

The old driver didn't really work for me as far as I remember, so if you 
just want to fix the storm, that's fine by me, but it's more a bandaid 
than anything else.

Ideally we'd make the driver work but I didn't get much further compared 
to the diff I sent above.

>
> David
>>
>> Sadly this seems to just show the same storm as before, I played a 
>> bit with the driver and noticed that it is simply broken on my 
>> device, all I get are timeouts if I read the NCI device.
>>
>> I could get it working (reading tags) by hacking the driver a bit, 
>> first of all I disable the irq as soon as I get it, otherwise I keep 
>> getting interrupts when the device is in MODE_COLD that would end up 
>> setting hard_fault to EREMOTEIO. With that in place I re-implemented 
>> the enable/disable routine in nxp_nci_i2c_set_mode, and that seems to 
>> be enough to make it working.
>

