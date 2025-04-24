Return-Path: <netdev+bounces-185665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2672CA9B46C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747D47B2663
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB8E1A23BE;
	Thu, 24 Apr 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="CLolI0gI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489AD28B4E5
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513210; cv=none; b=mFI5QaG6pNjY2C6UyQzvkzBvRtxevSNPiuVkZE8fiqbxwob5co/PC6/+XdfmX8ggwIwP4Eq6S7ubqwG/a+YwyZJIWZ4k/Ki5GFXLJldh3BloV7ak2kIFiW8YOpS1MYQaswVzlWuuSo/lk6GtsSQWbqIFdZWXv6szsL/lYacKMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513210; c=relaxed/simple;
	bh=4V0OJvZhwo9CryL3WO0sn+dGrmqATcnugSsQq/wzqHI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KmtQ9QDvKbyKBCFlt9OMXx0lc+79tMJyKpWhIS6IvhmlmHN60/hFi2hC59ss3gO2/VCmbKeelCj++4lXX/dTO9352+i/JY741/KrN615Bs4omMoxEf54DdzNGfmgkfwQ+2nejQ/VoTTYLwHpeYR34ZB3bCySm+CdekbqsLyF09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=CLolI0gI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so2024895a12.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1745513206; x=1746118006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WhDyBzYENMDRP2Qu4icH/WALzGg0heRjnQ9LBasVOtE=;
        b=CLolI0gIEadwLL1pK4YC7/sGG28KZj6rHmLsTTSgXzfaavBGuJf9SoI6pncIkU0okN
         CfSCsQfOxVaE74s8fU+xbgokpLQRzv2c/hkRCURtU55dLp1BQt2tBHBOhIMcPlpm5w4i
         NWScyYCBp4XjumDzFVK71/kvR0p0kX1K4JLwBXkB1FzMnPx2xXNhQsQVru5iv+xklCuV
         v1Tv1aE7g9WUrH5TUA1hBXX3ILWZod9bSGjZW7Q2m/ojXYoDPgUapT63zCeRpIQGoRHG
         0VVc9InRIBrXH05Xzcf3Mjj+3zc6CeFxLlw3+Tp9vcHA8+EMMxfhfmYKHBnWClXaESv+
         352w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745513206; x=1746118006;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhDyBzYENMDRP2Qu4icH/WALzGg0heRjnQ9LBasVOtE=;
        b=lLOcT2GwdwLG7DvvjD26+6Cf4Lwzi66q97I/Q5YIWnVUDuJEJyywqwRSQnIKFBIBGB
         /dGK1/UDhCWfsTz+sqy5w3s27y3A8jCMaNF5vhcZG+Y799MtPPQrc3jYyGcdO0JgPSta
         ZVOlx70aqVkwh5Hlpj0jxK4sIOfen2PYst+c2akINRAyIv97D1CDb+/VPn70BtQOiUPP
         4MsrUnAPID4j3ELtoEH5oiaLKKmKp7yBC3KmT9rUMYmp1LlV5/e+haGR92ogDbgk3Q2f
         2lACYjjKPC5jQZtnH/Q6BAi6FDxDIEBEALHFoh592zd8s40OL+gMUt+DfclGXNc7yBGd
         D4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKNd4kRyQ/c+4ddjh+USdB2pNZDgorX6RPQ4mHREdeR0BPVOf5g4WQA89hxVVVh8ENC6bhzGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEzW55oqXiobf34+Y/G4VEzgOiLpzorqpjF6Xljq1b0UR4YX94
	HUoyhJgmX0s7lCI6Zk91XUW1xcTIorQBsuIc7SjmYQx5g96YDHLmiOhZfQgoug==
X-Gm-Gg: ASbGnctfbQ0XjihbGwFSyheRZp8Uk/cwGKcevPbg4R2JpFNQsPlqWBfrRyS/UagLPxd
	IA9LWMR72P84Xck4pmOrLTQXFhaP4qwL5vUiFaWT2ACnn6K0wMvKxxQGtSR86zi8BJwAXP+sVHY
	jcr6ECHP3KZ6eFhEgGOtHieRA5XJoXTByEzrW6Tw+7L/8bw79u46GoQrDS1/1jXyoZkinLgRIxV
	7Cjr8AeGemXPC0CcYr0CmU/cI7UwdvYBJEEJWJfAjA/o0r+PxiFoTC1Gk+CpzFyy37b71U35Fjt
	Jv7e6eBDmhkMtc1gXWnNp/0eF6r5Re4havBmnQvx/6Kc2WD3qQ==
X-Google-Smtp-Source: AGHT+IHTYRGYL0LPgs+SLCq7Lwnmm7pESM7YoTIQRAUYPS5PaefisCf4m3nGAns1jOX8rlFzOE1U5w==
X-Received: by 2002:a05:6402:40d1:b0:5f6:20c4:3b0e with SMTP id 4fb4d7f45d1cf-5f6fabcda66mr75949a12.8.1745513206448;
        Thu, 24 Apr 2025 09:46:46 -0700 (PDT)
Received: from [10.2.1.132] ([194.53.194.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f6ed416c66sm1370042a12.60.2025.04.24.09.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 09:46:46 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <dc357533-f7e3-49fc-9a27-4554eb46fd43@jacekk.info>
Date: Thu, 24 Apr 2025 18:46:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] e1000e: disregard NVM checksum on tgp when valid checksum
 mask is not set
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
 <20250424162444.GH3042781@horms.kernel.org>
Content-Language: en-US
In-Reply-To: <20250424162444.GH3042781@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM
>> checksum")
> 
> I think that while the commit cited above relates to this problem, 
> this bug actually dates back to the patch I'm citing immediately 
> below. And I think we should cite that commit here. IOW, I'm 
> suggesting:
> 
> Fixes: fb776f5d57ee ("e1000e: Add support for Tiger Lake")

I had my doubts when choosing a commit for the "Fixes" tag, but since
my setup would most likely work up until 4051f68318ca9, I selected it
specifically.

On my laptop NVM write attempt does (temporarily) fix a checksum
and makes driver loading possible. Only after 4051f68318ca9, which
disabled this code path (because it broke someone else's setup), I'd
be unable to use my network adapter anymore.

-- 
Best regards,
   Jacek Kowalski

