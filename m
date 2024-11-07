Return-Path: <netdev+bounces-142736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F49C0275
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2F62822E3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE021EF929;
	Thu,  7 Nov 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i719SMyb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3AC1EF0B7;
	Thu,  7 Nov 2024 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975659; cv=none; b=a+crOnWGIR++kfPFXEyiPip1gBFTlEpFgqDlCWttg/7WZm6YAc0/Dr8EzuejEy+OLqbEQZ7G9bS1l2U02tTyVCiEk6CFuAETwN3o4luxkkA0mQhzL+k0fm3XjKr0BO3zJ4+j3d3a7Dw+YtwOuEaYO0wKS13i04AWMRnYlyuHCgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975659; c=relaxed/simple;
	bh=uNbbwI0t3CnnRoq+xAfBqxnkdHvi8cAUfxzw4z32a18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsBf9iTUY1ozLXCmfcVZ55jYsM0InLBnF2vsWZH5sA82+0pUPYOFK0eJV6yzhCYhCv6hOD7elj2ycMAQVSASMGOLSx1a5Wr/qdKxRO3XFs+W4qo9YjazMt0CdsFUDz2gw1+0ExCM8lDUPvfJ6doMveaIvWmMMcb7m6uRngZCl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i719SMyb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ca388d242so8399655ad.2;
        Thu, 07 Nov 2024 02:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730975657; x=1731580457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHCnQjwtQk6Ee4qEjCK4DR0rfCUXjzBPqylzEtsbdRg=;
        b=i719SMybg7xh7+xQFf5Va0HkbC60BnwGYUcUEMHD/fxkuZeJKhE7Zk4aSozuUpOV3J
         agzX3nHyjKZ+Ce7jIcxwAryfTVCOEOHSfRnX0p3OdQys6IZJnr+ACH1fFLh0esYLr8xl
         H29fJREJA0Ae0H30JoQKtq6TWOBpGeFw2GczW+cJdZJ+rg1dHWyQe9zIWgJJkOCVcspv
         B1k/2mrRC7Nb++nlJCEHJcASzmlWFQ3hsRflgbIZppgB0MQownfIyOvpx5USa4G8M3ZT
         tuYehg/eldmaIn1ufrXKrJbtysPWSAwyaK3QH4AAvVLEodvdxWvfFfJPgN8EKpRneEmo
         zd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975657; x=1731580457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHCnQjwtQk6Ee4qEjCK4DR0rfCUXjzBPqylzEtsbdRg=;
        b=B/UECp1nVASw/MBzBfeDu01ppCtZx2i2HvShqZf7upwPXSkKnzpVnvpl/kdlHhCGkb
         65iITGuwhT347UCJV7sTkZ7cquOa6w31GaUCZBjCY0KxobwZ3tV/WYKgYlJk2eRUi08O
         nsaBx0+X2NlWzR7M8arIeLReIG+GyKHf/zNRU58TNr+VcFapjJOm1VaWFjkT2X+AWZXy
         Ydg4n+SEouGBwsOJTCjXx8a++PeAYA0Rdpwt0/btjjXanZ23pmMiett4w02SjYkMf5U2
         vaLEzN0FmUV9mqnpm4/Dz7gOVyzt5nQ8cHXTAatFJqt4a31AiGwmxyNkjpNTIamvgYxw
         G8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUgtcExybXz7x32jH5znF2R9vxG7Inzxn3BW1rA7OCyLWaWHSqqK1RawYJi9U4s6cacbPvJab+dJ0CZ@vger.kernel.org, AJvYcCUpfr107qErkeMstdGa5ZalOPNBKo83oXYuob2PvGM3Kelufgoh3h+HSAU1Qp7Gt1GvWmk6omZRKfp26DQV@vger.kernel.org, AJvYcCXm+Tl4PXno9Q2N+1ZOVzw46Fa4Ojiqd8tWlmQPO5EQWIHdovaI5Pm+wllw2j7NEJgX3J/NJwuz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6pofLVpaBV+0w8Y8tQ9dWv715lJJBZkBjO5wC4xyvz5Nzww7
	3pSG2V6jWdhrL9MvjnJayHQQqlSPdazyxigOi6qh3CzbVyAd1GU+
X-Google-Smtp-Source: AGHT+IHkZfIEbD222fQn11aAU/4JCGtUmB7xX2nq1qct7iJZBs/q3eDUArv4HK7B8GzG/yGYnzOsoQ==
X-Received: by 2002:a17:902:e884:b0:20b:3f70:2e05 with SMTP id d9443c01a7336-2111afd6c99mr328557145ad.41.1730975656993;
        Thu, 07 Nov 2024 02:34:16 -0800 (PST)
Received: from [192.168.0.104] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e42b8csm9056135ad.131.2024.11.07.02.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 02:34:16 -0800 (PST)
Message-ID: <61a76bb1-f247-4e9e-b6ba-163fd8af4f69@gmail.com>
Date: Thu, 7 Nov 2024 18:34:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton
 MA35 family GMAC
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20241106111930.218825-1-a0987203069@gmail.com>
 <20241106111930.218825-2-a0987203069@gmail.com>
 <12f4ea21-d83b-412c-9904-d9fe8f8a0167@lunn.ch>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <12f4ea21-d83b-412c-9904-d9fe8f8a0167@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Andrew Lunn 於 11/7/2024 2:13 AM 寫道:
>> +  mac-id:
>> +    maxItems: 1
>> +    description:
>> +      The interface of MAC.
> Please could you expand on what this is?
This property will be removed. Thanks.
> 	Andrew

