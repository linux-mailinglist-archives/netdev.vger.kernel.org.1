Return-Path: <netdev+bounces-288710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NyM9F3uFCWq2dwQAu9opvQ
	(envelope-from <netdev+bounces-288710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 11:08:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B1556010C
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 11:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F96E3009CF1
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10D305692;
	Sun, 17 May 2026 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYvVE8As"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993672617
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779008886; cv=none; b=JELreaPC4uHf0cPx7dfvQ505NCwAsH59mxZOhMzW8zt/oB+nYmUrlIquGDLmixWvOkqZV7bvUE+rViz5OEn8l8Z+aIKhP7xwN40yRBSB3vfnOfrL8NhcpRqO7RH88uehnyCaIW+K0Wq4kOoEz9Q8YSByG9eLmixQ5HJy6GM+08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779008886; c=relaxed/simple;
	bh=2/vC2gtAzqnqEhOGB3CBoJ5IBuX3tz/aPAJPNrNo7JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H39RFg1duDVFRq2Uwog2QEixc58B5lh/CjOtJS74mpy4DhaCOYJDoIg2l7BAG3ns2YCDcuQCbOfOn/1fFy1hWzCx8RL2pdwL0m/4Svw0CBDBJh/Jf32YoxR+xqAAQ/G51Fn7itYY7HVK4YTnYdAXo9r4xD4acdEVwIOtPKLibQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYvVE8As; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so13941545e9.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 02:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779008883; x=1779613683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=npiaD8R6F3ev+VubH9jg2956LfZJhVHUypFqUAHYPy8=;
        b=FYvVE8AsmqRBE4VAbMovCq6CYOx+0H+388vJWd8g+ugX6nIofcpjT95Rir3bp34J1g
         /gZAj8XPxdN6rb9jzVJ335ya+N7RKMq9C9itqr5mZJIgsdjPihvyfz5vDOPM2spbWTG8
         bzWXkUaju4+KTfTvuOR/hxJ1CrCk6fAcTaifJRRIwMLYCLvVmMEEz+3/nJEUH3deHfiD
         lyP2C5DhDm9OcoMXPyZOCZqFRpUxAKPT6T4EJhImHQSvj5KsBEoAb9ljR/vm7/C8KnCh
         Y7flHIztOmQd4WrE/N3DT5UvbDG+LszSv7E9ZXSvccp5DRhWjEOA+HSQlFpehqbcSL4H
         MIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779008883; x=1779613683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npiaD8R6F3ev+VubH9jg2956LfZJhVHUypFqUAHYPy8=;
        b=HNCOBn2geEo7257qSllsR9dsMfW/F1Z8UDGDAj9ujEvjemhzHU4dAyZC6JRNIroMPj
         MOrzZUjBaEUPkdpoPPr3VEsmOSxdY6ODGZ7sv/A6rDkNdQx5rCuqeBRlCq5w8qOHTVgj
         Wjy4vX85MvlASg1P5Dd1Qgv3dvDqmNCjFpQ1igDGwKg3EQ0ckoe3CbhFirQft7eMaAtK
         PW2n78IfVauMVT0Jv3kgbHUYkh9fzPEdEMqctdQb1hBqg5qOxNuSIt6R7LLmnGLX9m2l
         d8ZkE5tdbToXb7lArdMKHDhbjUO8YCXfpzZ+nRx74Yzfi4iBK19+aaUqM4vc+7P0Vw0y
         iFQw==
X-Forwarded-Encrypted: i=1; AFNElJ+3+0d0R8XZEetLIfUIB0spZRNgm3TZIHBsVf1n46m7OxPm4SD0Nn8XU367btyYtzcI5lRHFGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMpLi/RMwbmMn5kLfiXdsll1sMpfwrlJOzmq6I/TtTkravKf2
	4InBu0mmaWMSEy4dIXmSyB8kULqwzaD7GYgWlsGYmCRo6qe5PmEwM8u7
X-Gm-Gg: Acq92OGlS1xh3XofhSUEZ53RYDExqFgi/C+5ukKdYLHnNly6cBekCIKmmD1Utf1Zilw
	r0wRYnw7fmHGtrgmJoscAlGciIVQESyCtJG7rQGRMmm2uQmS3OSNOkchWQqYsD7DPZea7p79ace
	8RY7FGKSohInM7WRRrCuc2XGNedaPcEmTtBNe7bpPszbZu561MVCmHRh0zRsqw9gAQ3k3jNTDO2
	jEMRIY1UVyUFOxpr8GEwDFKTkGdYlZcY2Wqmp/YKbE5yaJbxtZcFZxDfhs3peQXkr4pScYU1fna
	iJjlLwLd2YXYzohYBsn6lh89QVwDWWZ2JfWPv3OgWE3vl8nS+OZA1YiOUiwmTIBbQ5MvC1SEZRB
	uc+hqOgDVkiWDM6FW4nB29epLNdQW3eFMwH9yHGAglySlU4tYa5Dg4Tzhu+ruCJFkeMtKAIMGpr
	RKwsyLWoojIqzWFnJSaNwHNQTVtsBhkdym5JQ9ZtW209ynudMMfKcXFOrddUd90wc5n+bQJJxae
	SC8oUoWQWxykFiSXTgnhA==
X-Received: by 2002:a05:600c:8b47:b0:48f:dfe3:dae3 with SMTP id 5b1f17b1804b1-48fe63223edmr164540535e9.17.1779008882980;
        Sun, 17 May 2026 02:08:02 -0700 (PDT)
Received: from [192.168.50.249] (host-82-48-74-166.retail.telecomitalia.it. [82.48.74.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feae166dasm64053345e9.9.2026.05.17.02.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 02:08:01 -0700 (PDT)
Message-ID: <e9bcfa12-a60b-4224-93ac-df146d4fe0f0@gmail.com>
Date: Sun, 17 May 2026 11:07:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems
To: carl.lee@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: krzk@kernel.org, peter.shen@amd.com, colin.huang2@amd.com,
 kuba@kernel.org, david@ixit.cz, brgl@kernel.org, mpearson@squebb.ca
References: <20260516-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v3-1-37ba4b6e9086@amd.com>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <20260516-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v3-1-37ba4b6e9086@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A1B1556010C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288710-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucastefanige1@gmail.com,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ixit.cz:email,amd.com:email,squebb.ca:email]
X-Rspamd-Action: no action


On 16/05/2026 13:55, Carl Lee via B4 Relay wrote:
> From: Carl Lee <carl.lee@amd.com>
>
> Some ACPI-based platforms report incorrect IRQ trigger types (e.g.
> IRQF_TRIGGER_HIGH), which can lead to interrupt storms.
>
> Use the historically working rising-edge trigger on ACPI systems to
> avoid this regression.
>
> Device Tree-based systems continue to use the firmware-provided
> trigger type.
>
> Signed-off-by: Carl Lee <carl.lee@amd.com>

Tested-by: Luca Stefani <luca.stefani.ge1@gmail.com>

I wonder if all ACPI devices are reporting the wrong trigger type, but 
at least this goes back to the status quo.

I'll gladly help/test if someone wants to delve deeper, but so far this 
seems lenovo specific as Mark mentioned.

> ---
> Some ACPI-based platforms report incorrect IRQ trigger types,
> which can lead to interrupt storms.
>
> Use rising-edge IRQ on ACPI systems to avoid this regression,
> while keeping firmware-provided trigger types on non-ACPI systems.
>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: krzk@kernel.org
> Cc: carl.lee@amd.com
> Cc: peter.shen@amd.com
> Cc: colin.huang2@amd.com
> Cc: kuba@kernel.org
> Cc: david@ixit.cz
> Cc: luca.stefani.ge1@gmail.com
> Cc: brgl@kernel.org
> Cc: mpearson@squebb.ca
> ---
> Changes in v3:
> - Use rising-edge IRQ on ACPI systems to avoid interrupt storms
> - Keep using firmware-provided trigger type on non-ACPI systems
> - Refine commit message to focus on regression on ACPI platforms
> - Link to v2: https://lore.kernel.org/r/20260312-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v2-1-362348f7fa30@amd.com
>
> Changes in v2:
> - Add missing <linux/irq.h> include for irq_get_trigger_type().
> - Link to v1: https://lore.kernel.org/r/20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com
> ---
>   drivers/nfc/nxp-nci/i2c.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> index 6a5ce8ff91f0..266dc231c47d 100644
> --- a/drivers/nfc/nxp-nci/i2c.c
> +++ b/drivers/nfc/nxp-nci/i2c.c
> @@ -16,6 +16,7 @@
>   #include <linux/delay.h>
>   #include <linux/i2c.h>
>   #include <linux/interrupt.h>
> +#include <linux/irq.h>
>   #include <linux/module.h>
>   #include <linux/nfc.h>
>   #include <linux/gpio/consumer.h>
> @@ -267,6 +268,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
>   {
>   	struct device *dev = &client->dev;
>   	struct nxp_nci_i2c_phy *phy;
> +	unsigned long irqflags;
>   	int r;
>   
>   	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> @@ -303,9 +305,26 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
>   	if (r < 0)
>   		return r;
>   
> +	/*
> +	 * ACPI platforms may report incorrect IRQ trigger types
> +	 * (e.g. level-high), which can lead to interrupt storms.
> +	 *
> +	 * Use the historically stable rising-edge trigger for ACPI devices.
> +	 *
> +	 * On non-ACPI systems (e.g. Device Tree), prefer the firmware-
> +	 * provided trigger type, falling back to rising-edge if not set.
> +	 */
> +	if (ACPI_COMPANION(dev)) {
> +		irqflags = IRQF_TRIGGER_RISING;
> +	} else {
> +		irqflags = irq_get_trigger_type(client->irq);
> +		if (!irqflags)
> +			irqflags = IRQF_TRIGGER_RISING;
> +	}
> +
>   	r = request_threaded_irq(client->irq, NULL,
>   				 nxp_nci_i2c_irq_thread_fn,
> -				 IRQF_ONESHOT,
> +				 irqflags | IRQF_ONESHOT,
>   				 NXP_NCI_I2C_DRIVER_NAME, phy);
>   	if (r < 0)
>   		nfc_err(&client->dev, "Unable to register IRQ handler\n");
>
> ---
> base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8
> change-id: 20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-cda942530c60
>
> Best regards,

