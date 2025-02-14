Return-Path: <netdev+bounces-166519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13BBA364F6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25163B21A2
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A597C268C58;
	Fri, 14 Feb 2025 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFj4RW1A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D6D268C42
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555261; cv=none; b=hcv67HkRhYY8JoVXgrfhtx3goa2nzl492vOWOyiVXOS1FhKRdL6jILLj3z15rv351TP34MxYZTqbU47CmO0SKOwxjHMU9/7TGHDjf3zWzW0A+pFvEAuCauHX33Oz1c7SokVVdqo4lO6DemRKpV837IuhlHiCehm0BTSclE13UVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555261; c=relaxed/simple;
	bh=fNZOrpKhvpKOSY1KR/W+6D12K8STByQKHK+koAAXgDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYFW0pWRI+WQN9Ar1TJDODDLE11AntgNhCNGv5KP04t+4cTHQ/G3AF5l3O9USMR5S7lUd+zfogh5ysm4Sb8gcW4CMVhiqG5T5fkLrBayfNA6IO8ESPCIDUs1tA8UXZGO9C4vhFtPENipZ5OA++dJ1EFsnqFxZ5UlKSJJkEMzTKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFj4RW1A; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7e3d0921bso415178166b.3
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 09:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739555258; x=1740160058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3kwJ7uTHssPMwS5yt8vGAy4X5UQb4O8MgmEBY3g5dZU=;
        b=PFj4RW1A9HzPCuWXJsfGdhrPJlaX2X9ofpObrZcrRuZuGWwhyjNLMLSANIOM+dsLsm
         bx18bP8RXFz7dLo9ud5rSqF/SG37SxkTMi+ELvYxFvDVOxYjwV2iq+UDrxqoI5MZc6LO
         kOEFHSRjptQ+IeIlCrhsuTiCx8UFJbj0FA5/szb42ma1yFY/t1CyzHHx+LNRiekE+MNU
         Eq73tdDB5yxrUDnJa1AFTUdOpRlsE1x3Qr/qIW8wtCKqgntBJ1siwZgi+1XcY7Cbc56H
         3MaJPMnt4QutuSY4Hm+R/5V8hMkVAtGsh65MbkxG7Mb9eBEK6r/qPWVEOf9MDkh4ginh
         BYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555258; x=1740160058;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kwJ7uTHssPMwS5yt8vGAy4X5UQb4O8MgmEBY3g5dZU=;
        b=Pls9ZR81bzK4o9f1F/jTS9Os43J5NgR5BEFx0GzEVFeHLvn8/V0uDtI/TtO/Nbxdq0
         1lrbwjpde/IZJXq7Y7B8sL8US5U+zg++lSdbBSjUlzaJoBvZzKCMNzU94vkLHlZbyuSk
         UNZ1TzwXOj8hkDXYEvYlhx2oRyAGA+w7bqvQ61uGhubM+VvX1ZWKp1S8H6DD4VdyYBSU
         DfAJdivTBLrs6W0yXGAaOKteUdIiJ3WTTGdUKQNUgmhK5FmIvDNJ9r3NsNcl7ODxEV98
         cK/WiIXZ0+Rudz0FQRil6/y6WC2h0QiAHdAWkYhQ28tLQGnS5dGcrSSHlMRt27h43okt
         W+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMTk621CPPo4ssFFmNNkRMz/o+bvgRqMXYIMeoKrXKMi3lDhmtkuwtaiRqSDs8z0v/HovRpPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33phfLtlqiOBLkdg1m6oAgFYMscYv8pNLKYoC1U7LtdEI64m2
	PmXR9JwMaCXpEdWDP5KkB4b7HAkxi3LAYgNEVVyX9cQ0SKC9uT9k
X-Gm-Gg: ASbGncsyyJVLsM4IHZp/3ETMppxxCeBZr2FNoukpfrImN9SExfV/MXCv41vL4IDRQZD
	OG/Ic3RyD4d0CQmIPgNpgU4G9BnxnUzTdxcOHoftsScRqySD+gtU+Y1scJ8JQ9vKkhz/Koin/eK
	Ma7XbD19BhA2OazYk8HHH6s8+AQCmQexLJrZqgePAw8nlxIlr4jt5QEplHbb/aYUNAYyualkjFc
	sYlaAAYB47B3HZtA1jRl3bY9L070VD2/SWKugf43+lSlZ/efQY1AOoNtw296TzTnppaHnQjOieE
	NbqDAkQnmy5KZ/Th4W38hPTa2OE86dw7Hx2JpxKimZjvCKjHlTJdR5/X9yCSVwBSUj8fntIvGMd
	gGt1ZUKX1xTGnJD8qjJccE6x0yLgOqP7YzC48pQm7vT7eZ++2lIvQy6jqUqH2wg2fM+Uu4gynVp
	rTjNaby74=
X-Google-Smtp-Source: AGHT+IHJo3hnYxRrjIbxoZHUdLtXXgtE5TGMsAYfQTtXJj6Fp6MAloCxoaEf0Y9jvu7uZ/rwwP9ZcQ==
X-Received: by 2002:a17:907:940c:b0:ab7:e47c:b54a with SMTP id a640c23a62f3a-aba5017e74amr930228666b.37.1739555256264;
        Fri, 14 Feb 2025 09:47:36 -0800 (PST)
Received: from ?IPV6:2a02:3100:afb0:6800:f0cd:edaf:35fa:656a? (dynamic-2a02-3100-afb0-6800-f0cd-edaf-35fa-656a.310.pool.telefonica.de. [2a02:3100:afb0:6800:f0cd:edaf:35fa:656a])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aba533bf4bfsm385535566b.179.2025.02.14.09.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 09:47:35 -0800 (PST)
Message-ID: <30ea33cf-36b8-4c24-a28e-55ab365a6606@gmail.com>
Date: Fri, 14 Feb 2025 18:48:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/3] net: phy: realtek: switch from paged to
 MMD ops in rtl822x functions
To: Andrew Lunn <andrew@lunn.ch>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c6a969ef-fd7f-48d6-8c48-4bc548831a8d@gmail.com>
 <81416f95-0fac-4225-87b4-828e3738b8ed@gmail.com>
 <51d0f59d-2e2c-4384-9a2a-4597ba9b7a03@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <51d0f59d-2e2c-4384-9a2a-4597ba9b7a03@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.02.2025 16:46, Andrew Lunn wrote:
> On Thu, Feb 13, 2025 at 08:19:14PM +0100, Heiner Kallweit wrote:
>> The MDIO bus provided by r8169 for the internal PHY's now supports
>> c45 ops for the MDIO_MMD_VEND2 device. So we can switch to standard
>> MMD ops here.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>  {
>>  	int val;
>>  
>> -	val = phy_read_paged(phydev, 0xa61, 0x13);
>> +	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xa616);
> 
> It is nice to see some magic numbers gone. Maybe as a followup add
> #defines for these registers? Are they standard registers, just in odd
> places? So you could base there name on the standard register name,
> but with a vendor prefix?
> 

Most of the registers are standard registers which are shadowed in
VEND2 device. E.g. 0xa616 is 45.2.1.4 (PMA/PMD speed ability).
So yes, it would make sense to add defines based on the standard
register name.


> Thanks
> 	Andrew
> 
Heiner

