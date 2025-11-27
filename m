Return-Path: <netdev+bounces-242284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64046C8E4ED
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECA4D4E7489
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E599021767D;
	Thu, 27 Nov 2025 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmqeQw0Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+8P6TEk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF4C1DF261
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247583; cv=none; b=NPe7MsjXWKaGe1iJOeCLDGN4xsT+s73/W7wrzVURqg/3DhbFUsBme8y6SthpOKDHySxUeKHF8kwjKe27+HH2pn13YMgY3Vo/9lnpwKxJQNF8ln3q94+gr1I5ubk/lmFI/+OMp3oJX8ewqh+hMnHE/O+JLcA53WjpiECwY892exs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247583; c=relaxed/simple;
	bh=sbR8rj5HdwNUwTJf7rPxcnFUE8stUOVZpJasHjCHCzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZmnBAciHyEZVPBlni6+O13WIvr4orqJote+2ZotVFsZsjkIfoRbfjpnqnp9maFdrODgFSEmSrN8d9nOzBQajN03R1yhKWldxCaUkYbAxp6sNjmscIe17ZzqP+AopUOrt7ik3gKcs6hV3KkjRHpsZ2ANQeD6lrOnEAA580/GIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FmqeQw0Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+8P6TEk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764247580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lU4Q69fwFr8kha5ORL2VucV6zKxUebFEBdC5v2fRfrc=;
	b=FmqeQw0ZNOMWobmmNXbFe9EeVuNj2U60ST/o9IlidZXjQCIlfIvlnZV4fGgVN89k8v1lbo
	iCJOMVy1ESeTjHPeBxKWg5TobdT/SirSYkf9pNLmR6kljmJkSY4paTMNpfzIuOJwUjWyyT
	natwBeKEIJY8CF1QwHvih7L0C2tq4jU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-1D4s1V6QPqem8JrVFgig1Q-1; Thu, 27 Nov 2025 07:46:19 -0500
X-MC-Unique: 1D4s1V6QPqem8JrVFgig1Q-1
X-Mimecast-MFC-AGG-ID: 1D4s1V6QPqem8JrVFgig1Q_1764247578
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b366a76ffso541431f8f.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 04:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764247578; x=1764852378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lU4Q69fwFr8kha5ORL2VucV6zKxUebFEBdC5v2fRfrc=;
        b=S+8P6TEkMeIs+7F2yiYJbnOYj+YuzYd78buBHXa7YJemsmZume7ntc50Ap/D36PaLt
         BvdJms7thPv08rgGqoqpdAJ3JUM5UwOlPR3mJTzsz8aSfv4iHPDyEtpNCZFKekOk+5nC
         oYXatcBy8c/Du8gHRJ8gT6sujRvNO6jfeY2PtLPleL1HVutRwkcW1dHaF/xk4M9RfLFb
         HzlB37M+JrXpzQ/3TT7H53yeXc6cSBHGGznga4YCYMdCsPG0Az1tXpRyeQ8UsGgnvExA
         JLFOmUXgFKjqeaUAM/q9X46r3KR/qRjkze6IACHEThqXWI2jn+f8XjwADjJDr7BIvca5
         5QEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764247578; x=1764852378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lU4Q69fwFr8kha5ORL2VucV6zKxUebFEBdC5v2fRfrc=;
        b=bTwwS6KS6QhFWuVSuXnaA0jaEsZm7MwNcs5RwoFMISEOMAM/pCt0bjTeGb5Cz7imVs
         zkXYCbXihGpGyCLToRaAdjT+qpW9mbAsPFlicGAL3KxTA4k85LMxl6bQ25vV39IZ8oU2
         ebwcoAF26x3xLPz8TpgeiuuTlkjJR+jhU5sELO2Epw6y01w94m8nJojPRESCSBq3S/gN
         TwFkd82zuvYw/u14Xg21iGKPfT8yTJsQT10Bt4UjbksEOmD29jBeqCEVVdc8D5DZwexk
         4GCh8sUWbK+Q3DXWzugT4Z5pWwWSKYzY3An0RApuV93GqNAH6LeC2csHc7DqyuTQC4tj
         3C9g==
X-Forwarded-Encrypted: i=1; AJvYcCXzp9cgdsKvyvFYNA2AvsBxpTW1uFNtF+O8asq1v+F7Ur7mWSRpQEfJFiI7QONyzN8bU8G1iBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVJvPDv+YlQfsbfEn5UtgkBsze6GlvtgPk+eSO/UDiKoUil0m
	nt3Z4vOYRrmdeRadNuJoA2rq/NY+UcHrM2idrUI6lEkKCHVpaOCbv6FhPa0W0zqvofPbCK17vSf
	QfK8487BxdmkIh+dcsP1XgWpPSxiOUr6diMfE75eJ8iHraTiKQoRoieXIMQ==
X-Gm-Gg: ASbGncsuU8ho7hU6D+d+XWsqN/5EIlNn4zTiUGYDg/ZtBM2egyQESUGvDCTc4RG3oaI
	Csy+1ITe1qOzcxoxz3CcFhzu8SC6jtsG35p1OwDyRucQjkpW4MX+KMYp1647NuY9CUZmTZOcio4
	oE92H587kxOvmXEgUPLjI9FjkGYvyJKA6t6padQFNxnuIz4hLvVkDtx7WoNBwCmpP4t/TF5loLt
	x3iVkQnWEG6MxmF9u9b06qeVW+oq+LvX48umG+9yhw8aiNUpXh8TfAMxSgNe8x2l2axohRVXbtX
	CYQVpOpVHqKKQvDv3FEcVp40tczo4k2RLcfKM94t5TOSEPjR5UjGHG0lqOJYd3BxcovuXlHWIT6
	ueSw6mABx3idHfw==
X-Received: by 2002:a5d:588c:0:b0:3ee:3dce:f672 with SMTP id ffacd0b85a97d-42e0f1e3428mr10930160f8f.4.1764247578261;
        Thu, 27 Nov 2025 04:46:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxtcXT2mGT29Cj2YqBl/we77yTx8kGjUHM5RCqeOMm5jzSp7i0tYkAfQYuvbu+j+zndDkpzg==
X-Received: by 2002:a5d:588c:0:b0:3ee:3dce:f672 with SMTP id ffacd0b85a97d-42e0f1e3428mr10930122f8f.4.1764247577824;
        Thu, 27 Nov 2025 04:46:17 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d6049sm3525667f8f.10.2025.11.27.04.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 04:46:16 -0800 (PST)
Message-ID: <9c88eec2-0985-4e05-8f0b-8ce525ddca94@redhat.com>
Date: Thu, 27 Nov 2025 13:46:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 00/15] net: phy: Introduce PHY ports
 representation
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Antoine Tenart <atenart@kernel.org>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20251122124317.92346-1-maxime.chevallier@bootlin.com>
 <20251126190035.2a4e0558@kernel.org>
 <966bb724-59bd-4f45-a2a6-89a1967a851e@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <966bb724-59bd-4f45-a2a6-89a1967a851e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 11:10 AM, Maxime Chevallier wrote:
> On 27/11/2025 04:00, Jakub Kicinski wrote:
>> On Sat, 22 Nov 2025 13:42:59 +0100 Maxime Chevallier wrote:
>>> This is v19 of the phy_port work. Patches 2 and 3 lack PHY maintainers reviews.
>>>
>>> This v19 has no changes compared to v18, but patch 2 was rebased on top
>>> of the recent 1.6T linkmodes.
>>>
>>> Thanks for everyone's patience and reviews on that work ! Now, the
>>> usual blurb for the series description.
>>
>> Hopefully we can still make v6.19, but we hooked up Claude Code review
>> to patchwork this week, and it points out some legit issues here :(
>> Some look transient but others are definitely legit, please look thru
>> this:
>>
>> https://netdev-ai.bots.linux.dev/ai-review.html?id=5388d317-98c9-458e-8655-d60f31112574
> 
> Is there a canonical way to reply to these reviews ? Some are good, some
> aren't.

AFAIK there isn't yet a formalized process for that.

> I'll summarize what I've done in the changelog, but it skips any
> potential discussions that could've been triggered by these reviews. I
> guess this is a matter of letting this process stabilize :)

If you have time it would be great if you could send an email to Chris
Mason (clm@meta.com) detailing the bad parts and why are incorrect.

Thanks,

Paolo


