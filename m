Return-Path: <netdev+bounces-208668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8328B0CA50
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 20:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0773A7A3FD3
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 18:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D9229A9ED;
	Mon, 21 Jul 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WKFj66y7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D4F2E093C
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753121305; cv=none; b=cRWo4FdCsnllcloIZ2876vZAEwwgSkKl/ESbWyUQHVIwhudYsxtAgEsFW68hrO3dGJOhwcSPRZWIlf0PNUfDnhjWcLRrcGkNTfrST6GO/88XiVeot6E6oOexPOtFdHQZfTmDTcPDmovmQYcqIKCPlcyr21jCNJVsXnEa9T01sfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753121305; c=relaxed/simple;
	bh=92+Q39EW0fbLTpEgLkOhiI/YwGHlNATxM4RpKtbF9Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRPPLCtfqzHq0w684auFNkEOo+WhdqXc80qLzuEMpsk5FyVKUseZfeU9qvk4DImwewjBfAy+fe7XXz+HmjDDs6iKO+52b/YXmuMsuyMTILRQdrF0TRfMcWaNAT6VjiG2/8bO1gTOtJiWWrzZsXKFOqSZcNI5z1nYHcD4g3oMgWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WKFj66y7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748e63d4b05so2771252b3a.2
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753121303; x=1753726103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OQau27tiFbgxeFSGF9XUGR95YzgyQaSOU0OlzzUWZMQ=;
        b=WKFj66y7fg08NTjqsExRyN4/HYJvmzOjn1pjVz2G4vIdrbJ3yYAoN+PG7BBbighft7
         C/gcsYy118Qz6nafIvPSWZ7u+W3Lft1TtzM/qQfhlnkHyXC+WqgKW8wZy08EBjxta/dA
         1dm03V9nqZbU6XK0Ei6e40HVKqer0G4YrQMx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753121303; x=1753726103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQau27tiFbgxeFSGF9XUGR95YzgyQaSOU0OlzzUWZMQ=;
        b=PdWKtmZ2vlBnNajqBTBQTYHGwmvZkW7U+Ynl9BY7oPfVnzjyJX+hGXATIq123HlXB5
         Ajc49cEOcMXnD/mpO2phyPIxycjTrp0gVhEzSCwWhNqwnpJlYh3yCwl9t9ujh8rQ4XuJ
         /KafNNLHc/QIH2vSxohZr7Nyawp/kAQzuMHbZ5jGl4z2BbS+AudyiRMPC+BMfSpVDENI
         fSBiXeGP7i6lNvuBtXFQIFKwnUVxaC1YbzRLTfXrim371CqNdFlGs3sVQ/FGXgSKj2gm
         rh1Q9Y4zTSXlWjjerBL+aWHcU08iS/3v29qxIZHC/e5esjynIVsvpGhfdf9uaURlAMgF
         gcig==
X-Forwarded-Encrypted: i=1; AJvYcCUSR+zxoJV5YGop8nMCSrw6mNlb2a40v5u8oSAYhauRKsiEjcJPDX2fgeNk/BvfZ9bSHJUiwz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiybwcW8UBIPY+ZIHa/ITNviAOlkytn18tSZiqbnpaM2Dgl08V
	kxj4GEwxj8qv75OaCzCFOBBr9HzP2ZSovXal+hbF56LRJA6HyHaoK3lCNh1GZ8iSFQ==
X-Gm-Gg: ASbGncvI5+2uB80h0mBPWtkMzebIdqA5uYLv99GZOvqbW9QPy/2bXEznStU/OoljH8e
	E81IPp/xBmErsXsmmr34bqyqycSNwyon2gkvFHh/OjKc1VwPCl1gJsEYcVz+Wi5kk1zZtQQWmwB
	1rparj7EUKHIjEsEeRBkDmWYDqfWSI4KyMHIkhUpKTppR0Dvf0bBY1UOpg4PiI9ok8Rz15LN+4n
	MzXYxD5kTWUwKkshBrDZ50/56D2avdzNmIbfYoyyUrJ6tU1IvwLkT2sS3rZxt9eLArdIJtJKssL
	cLyQv4ue5XkhlVhx58/4w0howcLacA2yfmr2n6/vPhJoR7TD2G5M8s9t879yip206z0j7UXcwKq
	VFIjUOH1b9Kp5YexlCFwRP87f7Fgb40AcY+RAh9dK9z20ybfOQZEHoaMbdYMOsUm2f8Kx0h/+Q/
	+w
X-Google-Smtp-Source: AGHT+IH3Pl8hly1TQfln2anufJFdUC5B1Ir4HZCUoycIdoSWzeF9avLSYC/Imq9DCATPu80vE9gR5A==
X-Received: by 2002:a05:6a00:4b43:b0:749:8c3:873e with SMTP id d2e1a72fcca58-75724876b0bmr33128549b3a.24.1753121302713;
        Mon, 21 Jul 2025 11:08:22 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e24c8sm5845796b3a.15.2025.07.21.11.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 11:08:21 -0700 (PDT)
Message-ID: <7bebb6b5-d527-4621-9438-8a8d0ab9d970@broadcom.com>
Date: Mon, 21 Jul 2025 11:08:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
To: Andrew Lunn <andrew@lunn.ch>,
 Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 Tristram Ha <Tristram.Ha@microchip.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-1-89d262812dba@foss.st.com>
 <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/21/2025 10:07 AM, Andrew Lunn wrote:
>> Regarding this property, somewhat similar to "mediatek,mac-wol",
>> I need to position a flag at the mac driver level. I thought I'd go
>> using the same approach.
> 
> Ideally, you don't need such a flag. WoL should be done as low as
> possible. If the PHY can do the WoL, the PHY should be used. If not,
> fall back to MAC.
> 
> Many MAC drivers don't support this, or they get the implementation
> wrong. So it could be you need to fix the MAC driver.
> 
> MAC get_wol() should ask the PHY what it supports, and then OR in what
> the MAC supports.
> 
> When set_wol() is called, the MAC driver should ask the PHY driver to
> do it. If it return 0, all is good, and the MAC driver can be
> suspended when times comes. If the PHY driver returns EOPNOTSUPP, it
> means it cannot support all the enabled WoL operations, so the MAC
> driver needs to do some of them. The MAC driver then needs to ensure
> it is not suspended.
> 
> If the PHY driver is missing the interrupt used to wake the system,
> the get_wol() call should not return any supported WoL modes. The MAC
> will then do WoL. Your "vendor,mac-wol" property is then pointless.
> 
> Correctly describe the PHY in DT, list the interrupt it uses for
> waking the system.

+1
-- 
Florian


