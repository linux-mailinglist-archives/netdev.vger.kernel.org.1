Return-Path: <netdev+bounces-265685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SjAYN5sOr2kYNQIAu9opvQ
	(envelope-from <netdev+bounces-265685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:16:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C25DD23E783
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5156E3056514
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 18:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E1A2E88BB;
	Mon,  9 Mar 2026 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwPb1y0b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A012F99B8
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080003; cv=none; b=tANglsL935ou2Mi8O4HkeqSc2/uZLvRSvJtykO+KDYsnRDR7wiLmCe1zfz/aPJgSKOlj1jgtx2Ej7dLkvLcEebt5oPxilseTMq36Jj8aR4MOrp1nFpCzaQBo2IjxTcDLpgHm4XbbLOdmj56uaTZkHqJ+OVmk+TWAqmQ3sv9v9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080003; c=relaxed/simple;
	bh=axqGcRwX0ViFNb4WK9g3weO0SCpswRADdojCcvjft6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jemg4gg3x9XV234koPjPaXYuFmA8Rxcyt1Da/cNAN1AGNhDQ4yTJtQzXz6JgbOm4zJJOvdyn72+GAfkMJV5TP0Ah8gpgwXG6WD6mJzOlmE4HUT0EIU9MDTk/21ST2OX/kgJUL7PevDmOLmeLR/FNboBI6NwvUxSynTSsnxeSEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwPb1y0b; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48540355459so7367125e9.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773080000; x=1773684800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WVxctQB+E2ufIakKyx4ZMHmU69iMfXN6iBRw68NKW9Q=;
        b=lwPb1y0b3Mz3kmVLx+A5jTx13QjNemdBi/Ls6ckr+EGZRYdfGzWcS032UpdvbaL9qj
         Iz80Do1CJZUh1Ai0EvhP/BYl/TS+LYxDZSfk8qZXw5h/FlFEd/yt6BrN8e//5UYuhgQI
         G3xAn6JBpGl4EmSByusVVTxLWHHPuPaOkqqLccCMQSqtWbLv+IGwV8ZMdFEzwlp5mA+s
         ZrS+f+eebUr5E1GPbgrELpUk4j3AK516yJ/tE7EVv3mPE0aaz/yWV/Gjs37PmJYz2OO6
         rs5IXtnhyVkf5VwJ9QRMgG8PcyGN8lvkK3v8tdhPGaZX04w9w6SjQZQGr3UP6cz3MECJ
         qy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773080000; x=1773684800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVxctQB+E2ufIakKyx4ZMHmU69iMfXN6iBRw68NKW9Q=;
        b=hV9kLzrUjU6vW0Dv9h3QdWNlXyRhqvV1zhOiy5GtH8AHkstZvK2gMWPHRCIR3L0VnI
         k7yFtin67394QvoRpoCb6kej5NhF5XZxOGHg/96iiw8bUYckiEtTzYGOOzwfckB0xlEF
         yFzH/zE3/MKe+S6n0OBenqMiwhuqZ/1F/k5pH9s+HVqIZzN8u5uu1Ux9t6lgbz4yTzWP
         5i9zpyavtUN+r2EJ2oMZaZ+MBbZ/HELk5dRNK4Tk0zwc8XzrORFagwp12ubcWNBrnCQd
         m+jRcIhpqzdj5KJi6OB3AvkKwd0x0LlAKiAzVbng/o6ZiiANEzeiFTC9m9ru8rx8iu83
         +zRA==
X-Gm-Message-State: AOJu0YzTXHrxPROIV1gXnya7aYmnM0ZbF6+U9uS98j/gZXMXXQ8NjIZ2
	CTXrz50P153dvCxBuQcqE9U5hf1vYnZJEY3J/9mKdKzLGtr9H7W8+cEYsnMfyRgwCKM=
X-Gm-Gg: ATEYQzwBJJ3KHeOqz79EeOsbnQRLIPx2XWfFhWPtvFlJVBwpJjehkvst2+x5O00Vunt
	oxFzIEUQrXcGqXlXFk9F6kcrGd18/cJleSbTFZ5wliILxkGANz/+ej2Ar98QfvbUDATxPWwzfwQ
	h8qNPytx4XfVH5G20m9+v+Dzv3lWZv4tI6LXGtJS5XYTOYsBQpK9/e/UEwSVEqVHeck5H1u6qtm
	NBpuijVQ6eMeC+kdunt8BaYmyKh1WSgea+AIfoyNxZ47SN1k8+e60Mgmot3+qz0o71m4JPrXbQj
	wJKcslBlN/gMknkJ6MSL2Cqp+eWkUIfbXl2vWQrYGJMu/VF/K8CrWNYNhlTWQGtnspjlvR5XWCp
	1AK4OrbQmTaM+AiTQsrWE+gx92tUb8pwuRlsiMekAxlJxcZv3wLxzmNXpm/kbagtDGcBMB8zq+t
	K+dEF+eYE+oNT9DjdjwELNXf9WavvgCSPLCdfDnY4sVoBXYfnIupdvtK/pOVv2mIreH4IjC35Jg
	SsClOpW
X-Received: by 2002:a05:600c:64c7:b0:483:c12b:fe4a with SMTP id 5b1f17b1804b1-48526922beemr188871065e9.11.1773079999495;
        Mon, 09 Mar 2026 11:13:19 -0700 (PDT)
Received: from [192.168.50.249] (host-79-30-45-36.retail.telecomitalia.it. [79.30.45.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae4b860sm31280494f8f.36.2026.03.09.11.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 11:13:19 -0700 (PDT)
Message-ID: <ca967f7e-d671-4be5-bcc2-30d75fa919aa@gmail.com>
Date: Mon, 9 Mar 2026 19:13:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfc: nxp-nci: remove interrupt trigger type
To: Carl Lee <carl.lee@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, peter.shen@amd.com,
 colin.huang2@amd.com
References: <20260205-fc-nxp-nci-remove-interrupt-trigger-type-v2-1-79d2ed4a7e42@amd.com>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <20260205-fc-nxp-nci-remove-interrupt-trigger-type-v2-1-79d2ed4a7e42@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C25DD23E783
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265685-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucastefanige1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action


On 05/02/2026 12:11, Carl Lee wrote:
> For NXP NCI devices (e.g. PN7150), the interrupt is level-triggered and
> active high, not edge-triggered.
>
> Using IRQF_TRIGGER_RISING in the driver can cause interrupts to fail
> to trigger correctly.
>
> Remove IRQF_TRIGGER_RISING and rely on the IRQ trigger type configured
> via Device Tree.
>
> Signed-off-by: Carl Lee <carl.lee@amd.com>
> ---
> This v2 of the series includes Krzysztof Kozlowski in the review list
> for NXP-NCI NFC.
>
> This series removes IRQF_TRIGGER_RISING in nxp-nci driver,
> relying on the IRQ trigger type specified via Device Tree.
> ---
> Changes in v2:
> - Include Krzysztof Kozlowski in the review list for NXP-NCI NFC.
> - Link to v1: https://lore.kernel.org/r/20260204-fc-nxp-nci-remove-interrupt-trigger-type-v1-1-3bde91593173@amd.com
> ---
>   drivers/nfc/nxp-nci/i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> index 049662ffdf97..6a5ce8ff91f0 100644
> --- a/drivers/nfc/nxp-nci/i2c.c
> +++ b/drivers/nfc/nxp-nci/i2c.c
> @@ -305,7 +305,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
>   
>   	r = request_threaded_irq(client->irq, NULL,
>   				 nxp_nci_i2c_irq_thread_fn,
> -				 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +				 IRQF_ONESHOT,

This is causing an IRQ storm on my ACPI device that eats away a core of 
my cpu...

I'm not sure how this should be fixed but by looking at other drivers 
they all use irq_get_trigger_type() and then apply extra bits on top.

If there's no clear path that handles both ACPI+DT I'll upload a revert.

>   				 NXP_NCI_I2C_DRIVER_NAME, phy);
>   	if (r < 0)
>   		nfc_err(&client->dev, "Unable to register IRQ handler\n");
>
> ---
> base-commit: 4c87cdd0328495759f6e9f9f4e1e53ef8032a76f
> change-id: 20260204-fc-nxp-nci-remove-interrupt-trigger-type-d778323b3b81
>
> Best regards,

