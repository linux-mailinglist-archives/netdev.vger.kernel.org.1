Return-Path: <netdev+bounces-145043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 046429C9318
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE07C283914
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBF41A4F2F;
	Thu, 14 Nov 2024 20:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJJSMuE+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DF1A9B4F
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615430; cv=none; b=TFKKVOi59nErKsa6mU2W31Tga03PDCZLCfcU5EJJNdPDHDQNup7lFehnVnZS4mpKFm/zdf/1XSs9IZ3Ow7EDWxNcrGwi5T3/bTzYfDw479TMkQEj6PFO+u80bDEvGyvw8Zav9Mq1AVR79LPJnfO8bBQp6onRs37vp9V8acBDeOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615430; c=relaxed/simple;
	bh=1k9x2ZOmg7XmLyOgnAFOAzOSB21HvpxSBn98cKaWIFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0vGS4yFLR3v8Z7ujW2HcLYqt5RYIoSfGeeYvJleW3ExgjD+cPtaugFCa4fcJFI/st9HKw0gwbA+v7f0XUri8YNptrY8H8C9Syz+6WLcCQciXQJYp05nx4KFLMiYyJPOijm8qzhfproxSaLmv6xirekqe1ASJYixIGZ9BVQzMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJJSMuE+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa1e87afd31so134894566b.3
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731615427; x=1732220227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dW4pViTdrerdGDMiufKBmTY3XNGjwDVqMSdoGCB6W/Q=;
        b=LJJSMuE+cEtu4Hm59rHXtN0fc2OSiDZkmDqdfkkxr28hjMDeOlRKdz6ndx6UdPAI+5
         oTdomFjYEioqD8rhXuiwo8Ru1QC8RXxezYTDveh47OctlNSJB7BsnmL/PmtD3aepKYfY
         OxwdV8K/rTF7aMfQCtOBSjp9W6Urkt1f5dlu5k/JsYmFdFJ1r/3HkJXidAEl9uP5wru3
         sUCwxCwmcwnRh6eocPtvA2OVNl6YZm8srKwXdHX3ds2Uo3UnTOtodxLh1RhylUcY6uf2
         /9dGpL46j3mObEgs/Xd6obgk8Cwn5CB1BARJxmODd+ip7QIKd89Rn+nPpAGo3djffB6q
         P3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731615427; x=1732220227;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dW4pViTdrerdGDMiufKBmTY3XNGjwDVqMSdoGCB6W/Q=;
        b=j95z03qiNKev3lR/zzk+xWGDUHVyHImDcDkMdThk6Jo4IURlyobdpt7izc0DMACQIa
         ooNk7XRvEvYC4fP4yTPxPWBM316CF2C+WZ3Z0TLDatHW+cPyx6oqezI7QCuOrCuDA5sw
         AKlKKIDxDYQ8rxv+xSEubkpiKQKo7ejrjLEzxEN7UUwB1ncw/vLCad2NMzah9hQK8/l2
         QZivIEhCKuDoFw7kkPv9aGHgD9wmGYbKoiPlUZVVnNfgAeajZ09pw5Lplv1JFItc9VBn
         IvpMrE1L1+fSYybf1EYCpPOydSu8XxsuTgASCLxcgHz1KvmW07QGqvKnOK4ww72AktIL
         c9ng==
X-Forwarded-Encrypted: i=1; AJvYcCXF2Q9Mz8eZLckgmdY9OLiP/9FeIYfxy4ncrsTKjR85fmER6mzyEULSYBR12Fqd1rE9fPMilFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaE+DJyfRkFfnkUNwqgjtKmGrY8I74qQBKA0Q42mqGSM+ziKnn
	PzaLGepFC427S5jviurrbTrXkV/vXO+pffWRZ852VM+YKlY2sOJ7
X-Google-Smtp-Source: AGHT+IFUVQrzuuO6gKgu3R5bGTEkAKs7z71RYHBVKgCJb2jVtUPJnK+NSnmeR88NAp4wpi7eQpvzEw==
X-Received: by 2002:a17:906:9c83:b0:a9a:55de:11f4 with SMTP id a640c23a62f3a-aa483553e07mr477966b.54.1731615426607;
        Thu, 14 Nov 2024 12:17:06 -0800 (PST)
Received: from ?IPV6:2a02:3100:9cd4:3900:c5ab:9562:2027:4661? (dynamic-2a02-3100-9cd4-3900-c5ab-9562-2027-4661.310.pool.telefonica.de. [2a02:3100:9cd4:3900:c5ab:9562:2027:4661])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa20df7f49dsm98767566b.91.2024.11.14.12.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 12:17:06 -0800 (PST)
Message-ID: <732b0bb6-e2ab-40af-acd7-df3091802e22@gmail.com>
Date: Thu, 14 Nov 2024 21:17:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: fix phylib's dual eee_enabled
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 netdev@vger.kernel.org
References: <E1tBXAF-00341F-EQ@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <E1tBXAF-00341F-EQ@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.11.2024 11:33, Russell King (Oracle) wrote:
> phylib has two eee_enabled members. Some parts of the code are using
> phydev->eee_enabled, other parts are using phydev->eee_cfg.eee_enabled.
> This leads to incorrect behaviour as their state goes out of sync.
> ethtool --show-eee shows incorrect information, and --set-eee sometimes
> doesn't take effect.
> 
> Fix this by only having one eee_enabled member - that in eee_cfg.
> 
> Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>


