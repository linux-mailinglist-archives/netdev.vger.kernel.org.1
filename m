Return-Path: <netdev+bounces-109254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A1992794D
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972151F22B55
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91B21B1205;
	Thu,  4 Jul 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUQSCdZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C31B11FC;
	Thu,  4 Jul 2024 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104679; cv=none; b=Jimo432LSPKXu6TfslnVDAcNj+oeraYGdURgClvt16zFNFBRagayi/yK0xYmlALWZ17PQCCv/WeLIom0iddUk3IINojc67aPPt7oV/J3P7ZVKpKFwnidHr/QRFi+36eGbq61HNeLABU/YxQpujFp5NbrkOJYlThmfvxisbZ8IUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104679; c=relaxed/simple;
	bh=g/7vOroP9f5W0cumiyj1gx2Z6T1BVT0ETgOOO0aRtu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNyMLZ1N0/1IeBRYtKXmi95n/nj5IDA7A0ZDsyZPSVJgPIV3EFc2qwMy3Xhi3uNR16a/gNfKGiFbucpHmnAnIm8bt4as/TXBEtIX0+3Lux9aUtAOa6GsHkiB+4rOKsc8kBhaRARGTS6GsC8jri/ltcZ2efelGDe7clOasOClBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUQSCdZ9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b5def3916bso3343646d6.3;
        Thu, 04 Jul 2024 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720104677; x=1720709477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hyo7nbfknLAdRckRj/UmxcR044dyUDIu6cMVN0RV4AA=;
        b=mUQSCdZ9KEJrd5fHuSYn8FUdQ4RmvVHENWda1FXMtvbov1sCKxzbxFvRlu3o9zfh4B
         vQ8ZemFQMN6JAGYw866oFXUn+qMzRbU02N/u/G/I4SxJkE1sxFDoEB7m9gfDDPDGextg
         QKlDW6tOIqTPhIMEeROOtQN2RsrZ/HHV8Y1w0gSor/BPHahGdCa4qxUiRvl2QCOb/Ouk
         +uCgYEwpgyF0ivgDPQUw3pbx13FOQzBimbFjzLQhTEJxPgpztP8TFETsP+Sw6MHsIohS
         9U/5yw5knZTz0ycA+ITil9Gi0+ZN2dkA6FU698j3jqVABNqb625ia/x9xsidOpoTUnLp
         Dd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720104677; x=1720709477;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyo7nbfknLAdRckRj/UmxcR044dyUDIu6cMVN0RV4AA=;
        b=bLBpeZTC6cv0+Zbyz139j2SZW05105LRF9TY8c7AIS5FggnvqcjmBOYw5ZByUuSC9k
         H2zciJMm0U2ypfDh9Ta1JJb40+WEjezC6L0HdyOA2zr9LVfw4K47zpGrQ4TtwTEcJE2/
         L7kXkZ8RT9BwDnxo9XrwgJdB2r7Aj/TfrrrhDbV6fmdkapLzgRsmtx6bmQLCJQjuKnB1
         +sGBchx8rweRRqObR6RGCDJj8nmXRFoOGc4P3ASXO0YVKepxQ0vf0QcDCu5fxEVkl44b
         LfZpAZ1uMxHGzf5I7cwgdD4M2BXKPgwbyj04EUI2QeQ8nA8CiqtrPOPymHCHoynU/wfN
         V87A==
X-Forwarded-Encrypted: i=1; AJvYcCWZCvfgei4kDPNHgOdeo8oNUXvIaZ6o9pA4fewlMp+QpmtdtmG5FtFVAhjIRdLAHsXManh+SK4xcKRmBCHsLwiXqInLW0A5C1OCJTBq
X-Gm-Message-State: AOJu0YwUvbf4rbhuzl21oFNoAuX/EiyLSPBsVwkbL8mR9WbEbkVGBh/A
	pmS/GEvUnBTdKMuKG7jsBnGWqE3XftRiSZn2H7gb73Ffgj28da8c
X-Google-Smtp-Source: AGHT+IF0kEoqJQ/7/4YpfiTsb/1z/kelC/OmR6Pv7HWh9rRQ5Co0EyIKXuhP+5iWZfN7XMKxcqO2nw==
X-Received: by 2002:ad4:594d:0:b0:6b5:6331:4d4 with SMTP id 6a1803df08f44-6b5ed19c1c0mr20729416d6.51.1720104677125;
        Thu, 04 Jul 2024 07:51:17 -0700 (PDT)
Received: from [10.40.5.113] ([89.207.175.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e368bcasm64363416d6.5.2024.07.04.07.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 07:51:15 -0700 (PDT)
Message-ID: <2b0f7253-685f-4af9-853d-66060be69489@gmail.com>
Date: Thu, 4 Jul 2024 16:51:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] dsa: lan9303: consistent naming for PHY address
 parameter
To: Christian Eggers <ceggers@arri.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Juergen Beisert <jbe@pengutronix.de>, Stefan Roese <sr@denx.de>,
 Juergen Borleis <kernel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240703145718.19951-1-ceggers@arri.de>
 <20240703145718.19951-2-ceggers@arri.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240703145718.19951-2-ceggers@arri.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/3/2024 3:57 PM, Christian Eggers wrote:
> Name it 'addr' instead of 'port' or 'phy'.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

