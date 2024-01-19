Return-Path: <netdev+bounces-64427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9DA83315F
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 00:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76CA0B21515
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 23:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B152C58ABF;
	Fri, 19 Jan 2024 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8PFMMf/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC238E
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705706056; cv=none; b=D6E+Gq6KLp97zvJO6OyiSz2izGWoNtQHnqS2Z5VFUnWIROPWnrN3mb2HebJ7QviBQAM3Tu/PbmzuoM5TlEvADHG2sg5QIgVNChqcemnT1udTY/sQ98334qKUBO2Y7LZFUyBKti1lSlYKEIMIDWC8vJsvGF6Fvy518T2iUQQBNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705706056; c=relaxed/simple;
	bh=D/3bXJrl1yZGRbyULLA5sAHT+z0xZS8sY9UpNzJFK58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxRS7opiFl6AMvuxpxr0ZHjIGW3uBcXWBZbZZH4E2oipE2F6eCjZp5TCAmkotkkg0jtoqXrl6VuslokG2MG3pCR7kci/EaGUZVl0CYBswMHV2Aod0U9ZLia0ccIesfO0C/8YbyvY1nlZBYQmm4RgiHJbr825PqkKP5GvkvwhIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8PFMMf/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29065efa06fso191094a91.1
        for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 15:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705706054; x=1706310854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8L/9KFU3b80smw6IwSPIqFR1dN3wl0W7U2F+fc05lPA=;
        b=K8PFMMf/Cri/G1x/TbrCF8LKggafj3E6k95g347+3Sq0jt7pqymMpgSREx2UIptdGP
         L6gcmEnJr7SqYwg6ljUsHPEBJ+i2e5Cn3eNOtbOwwb5jBJQ/H+49yMzSvTS0m2tCBFdd
         lEGgCBnQY6eWz6AVpZAOLMvdOQaLBWTE/6jhH5VLV0udXRxau5PKyPRuOYAiyJM30VCf
         bnb2dhCNmnbE7/Qpzgjo5n+DWNwU/stOfZXQwZ3t7CACtT6g4/40/BJL0g68W8iYRYlm
         brZywxrZp6vzH09fw2xVMkgZBgcrhv9y8X9gisfuZB3OV2kp7jIxIRGaGOpYfU5t25Go
         eDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705706054; x=1706310854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8L/9KFU3b80smw6IwSPIqFR1dN3wl0W7U2F+fc05lPA=;
        b=kXSMF+YxlzgQO5fl5IXLClxCTW/l7B7MFqpw37qkUL3Cj7FHO/aEsYZ+IX3RTOfNSm
         xANON1DFsffqzpYeemHILH1N5tiimAyUj8JOEimMPb0EqvoEbtmLG7RSCs+Nm4IZXpSU
         XwsCYeTdh2iv7G7KVmlJBaFRe5a3TOw4NXihz1+Qtd1zAZ2bcC8QI/Bj5pedHmtZuUOv
         84JA0BEPeJrxqDHGfbtUiyG3REQ+CsDraXrP68CRHUCbrCkYIRhYb3KFngpid+UDwPXJ
         stISmUTxrIgL7UHSN+b+3X3CnTFYDlqsnPnWGXl1fiCW+35xvQ7hPn1Q809+e3HumYNi
         YK8g==
X-Gm-Message-State: AOJu0Yx3sh6neZimTguznJeER4yaic+30Wb+Y3c0XquMXJZbtPowhGSs
	ElA0i/pMekbXvINWFbvR2tF+RR8eUhoMMGz9t0kSXXK3TpOm97WJUCMqQmmo
X-Google-Smtp-Source: AGHT+IHUXfYoAqLmd47GmdbCpT8FXJXAPwlV2KXF1m7BNVcYkYj5XTXH4Z7YZnmgaHo3hIp2orD5Fw==
X-Received: by 2002:a17:90a:3ee4:b0:28e:76f5:f9ca with SMTP id k91-20020a17090a3ee400b0028e76f5f9camr445620pjc.62.1705706054357;
        Fri, 19 Jan 2024 15:14:14 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id sl7-20020a17090b2e0700b0028bbf4c0264sm4650643pjb.10.2024.01.19.15.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 15:14:13 -0800 (PST)
Message-ID: <33bbf54f-06dc-4e80-b5ac-adaf7855ee3f@gmail.com>
Date: Fri, 19 Jan 2024 15:14:11 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Content-Language: en-US
To: Asmaa Mnebhi <asmaa@nvidia.com>, davem@davemloft.net,
 linux@armlinux.org.uk, netdev@vger.kernel.org
Cc: davthompson@nvidia.com
References: <20231226141903.12040-1-asmaa@nvidia.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231226141903.12040-1-asmaa@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/26/23 06:19, Asmaa Mnebhi wrote:
> Very rarely, the KSZ9031 fails to complete autonegotiation although it was
> initiated via phy_start(). As a result, the link stays down. Restarting
> autonegotiation when in this state solves the issue.
> 
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>

We used to have a link_timeout as well as the PHY_HAS_MAGICANEG logic in 
the PHY library a long time ago:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=00db8189d984d6c51226dafbbe4a667ce9b7d5da

maybe you can schedule a work queue in case you are using interrupts to 
re-check the link status periodically?
-- 
Florian


