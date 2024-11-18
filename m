Return-Path: <netdev+bounces-145970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FBC9D16AE
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 18:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C601281351
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C009D1BD9D2;
	Mon, 18 Nov 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgyLdQFx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C41BD4E2;
	Mon, 18 Nov 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949384; cv=none; b=DX54jD8/8QBd94nrAGgy1Ups56/x5yMhNiamUdGJOtnDi+oBsM292471LW4b3BHrYfluh+CHhEaczkgX3Y15ZHjECU9vtmAIk8WzL4viJe2Om1FGw9vr6DNJucVC0YzmnS7BCGPWReKpjmHDu7EiSWqTn1yWhfqZSKxWFDt6ZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949384; c=relaxed/simple;
	bh=J+IYYtr6Q+/i3JxzY7qiBxvtoL0fX9mJc5NlKUOrRG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvLADfOQ635YnexR7E374gLpH8qJsz8MA1CYS5065pjKPI7t6TPu1EBeX5nT/Mbe6ZwfElu5ealYgOnohohRO5WUJpGb+FVssX6jVwHXH70S8ADk8JV0scy5Hwvumz0bazY5dYKjK4bW2jkOP1XhKPvTjDCzwGBMW9frEDFmJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgyLdQFx; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7eab7622b61so3360819a12.1;
        Mon, 18 Nov 2024 09:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731949382; x=1732554182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cmqCu1jLUwthgcAnC3lpgTArfpfOFGuRVBlkpCbID0Q=;
        b=KgyLdQFxOiZTBid3BdN86GNovheA8WbhUL4p6yH+R33pmLD3cbN+mBVGxrHvunVpsC
         2O+9PHaGO8Er+Df/n9uxJTKyfk2ofaZ3AGcvgGe7/jC8/r2+IDW70/6c312wMnGnYLNK
         dYl125i8PvDi1GjoWY+Aw5t9HpM8qmfRJz6B7OWj4aaBiwmv4mJwveL/+SEPkXzr91wN
         RDugtghQnidrVo1mAl4/R0zMGJD5xquxV2fdfwMUPDDP2R5TzIh9u1U+sYNaQDKr5VtJ
         uXxdq1v37a/C64qqZTdlp6CXg9gD1EACfJ27ZDWyuRI1X2Vj67rTHEVIrrm5h9o12sDT
         ybRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949382; x=1732554182;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmqCu1jLUwthgcAnC3lpgTArfpfOFGuRVBlkpCbID0Q=;
        b=KgLMV/aki5Xi2l17UgpgqIZzNevxKvUofkASv6/Zy4r7vPavyCzq6/gbod2nYwneXC
         UQ6NjJo+MwW2/nelwxs+ZT+E/fmOiZ1ko6P3jg7PvjELzOpkdYhmXUENCI6uzIUenLiG
         0mU9B+gz9d0jpD+Vrc/J7DiUscx4dYn8U8ZJg9U73ByWA0C3llt2qNyB8L4bz33qYFrE
         oTSFJVIvqizCJK8yLVB3e/rtW3/X2mIrDnG6HVX6/rOi4IORnZEHXFs9sLEequsc2byI
         J8ElwgYIprybAEq0GVReP9DpOHncopsYUR24mhYRpBmgf3QZ0fhwQ+puwNamJjsWT7Ja
         7eKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEI6Opsz8sDKACqlAlJKD5thsLGiZI91z9Ob7fdsZ0vrjZpKc8pGMhw3T8Rzwk0AAn1QdPPvZbjHqOT2s=@vger.kernel.org, AJvYcCWmOJSDw5P4mOkIGKvHyV/KIay4RSOZQpKJJlDCwRTuuc5t3/ElPBMnSFtf+mdxJK8znLUmuVeO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02lxqhxbdZbZ96Z0acImVihILs7GQ2avLRaf1i+raOT6SK591
	6qnE8HG0NorqLq2/lxbiVWZmSFtkPXOvffN9Q0EEXMES5nDV4db2
X-Google-Smtp-Source: AGHT+IHmr9SYPsPEn7uolC3o5UqwTs6ZC+ruO/Dl1+SOLM2EbvLFqHFmcvFXE1+RnVSjFX3Eu90iUg==
X-Received: by 2002:a05:6a21:205:b0:1db:eea1:7de7 with SMTP id adf61e73a8af0-1dc90b30d94mr12379482637.18.1731949382345;
        Mon, 18 Nov 2024 09:03:02 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c172d1sm6196281a12.16.2024.11.18.09.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 09:03:01 -0800 (PST)
Message-ID: <8e558c33-bb51-4368-836f-a053b331198e@gmail.com>
Date: Mon, 18 Nov 2024 09:02:59 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] net: usb: lan78xx: Fix refcounting and
 autosuspend on invalid WoL configuration
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 Phil Elwell <phil@raspberrypi.org>
References: <20241118140351.2398166-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241118140351.2398166-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/24 06:03, Oleksij Rempel wrote:
> Validate Wake-on-LAN (WoL) options in `lan78xx_set_wol` before calling
> `usb_autopm_get_interface`. This prevents USB autopm refcounting issues
> and ensures the adapter can properly enter autosuspend when invalid WoL
> options are provided.
> 
> Fixes: eb9ad088f966 ("lan78xx: Check for supported Wake-on-LAN modes")
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thank you!
-- 
Florian

