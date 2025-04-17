Return-Path: <netdev+bounces-183704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 939CBA91950
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EDC167305
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCF222B587;
	Thu, 17 Apr 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYeaWOzC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5283225A37
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885720; cv=none; b=i6TEbQOtsVy5M3uCVL6Wbn9ldE3zU3zeciB+YntkebSshW0RkhMTp++7YnzX8HuXq13TJJ0fGoCPeGP9qO829//gyDexJLJFOnl/4UJB1LPPo4TPYMxE26ulynO+6XWt2z7YHaLEVdnRT+YhQJ2Mn/pI8QHZZt30adLl6S+ndbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885720; c=relaxed/simple;
	bh=wEhVd9cWfcz7UKfL/cKiF1HIKxbw8iqDGQuIlkpMAqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WClZ8UQYfFjgdlhY850Cw812U4kysQ3NbC4zEaeCR9/QIFnynHhwkijkOAp1/twnDJGeJn3sNqMeeXQv0sCogpeHMO4heDNLXo7vSDmu/fDRe2Qb3+QRCMmjx0kfifAiS6ddF+RKUY1VnBMf37oCFosOmjU2f51JA6DBn32gTmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYeaWOzC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744885717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYR6737R9PdlNQuW82+z1wwa0+J91c+dkKgGkvTEGCQ=;
	b=KYeaWOzCs4N254saVB3Gy8kZ47c7z1v937fKo/L5NqcgQLnu+Nyk9yYLC87LqRw07YCjq9
	SPhRE9Ob66FCYD03081BB4wbguwf3pCdQ13HPbynuwo8P7FIyYD/GMInHijd6x5tVGwh/9
	SnW/MkpGac5vmBIUln1vTZ8+2N7aGVU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-3L4pE1FZNNqYsbYZxxDr-w-1; Thu, 17 Apr 2025 06:28:36 -0400
X-MC-Unique: 3L4pE1FZNNqYsbYZxxDr-w-1
X-Mimecast-MFC-AGG-ID: 3L4pE1FZNNqYsbYZxxDr-w_1744885716
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5b9333642so72741285a.3
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 03:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744885716; x=1745490516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYR6737R9PdlNQuW82+z1wwa0+J91c+dkKgGkvTEGCQ=;
        b=woicnKBaAIdKJh6yZyCI42Wn9COFj1KCuBYLM0mfgmF8vslpOFvPcDaoLkzCNRDGUR
         dSBM535ZGmst06NzMlWtcETDx8+9mQuF2MyxgFcowuVb2LFv7YFZZHuGBiStF5hgZTYP
         aSbzXtWXAaLT45GXzdqdc7XUm9hwP77dN5yRvcv3wwjHpx2giivQH6EVx0E/zVoS86wB
         OG7hADAx4EEDfWwQpvlhglc0TboOMtm5WBcf0s25DgyL3DmPbXtmqscNiVmVvceMVtLO
         4N7jKCeGskivQ8M761sFjJfTFxnpqvEuqY2rfM2ocLxgDTEQcG0AsOqBXiA7D2Mhox8j
         NIbg==
X-Forwarded-Encrypted: i=1; AJvYcCUqlnZPKzMhxV+NXdQMHN342NrhXJn6wfS89JzAg+BDbLOI/I5foHqPSktOsoEqBm0MNeMVYbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8x9g46oApaS41htnNZXotUa8CikAP/bFPj6HgkQqHXSG7YqWG
	ayuzXXhBHrlQWAEf0ihbEgGc6HfSjnPZYIqRJlCesfyeGOAwiTqaBZrPQ1D4rvREHYTgUSKU1x+
	Rf/qpTwbO9OMz+eRobfXr6KQW2UvcQCu8DSRYP5KO65yhDC0InN2CnQ==
X-Gm-Gg: ASbGncuYyXIZAVjQXbhLjfvyZg01qLQ2KqNnFSe4m7Qk8rXr/WdSp+3IBRN3a3Dtyr0
	wR/j68RDs/FITJwpXrIbKeCbtgpzH+DIGmg0ew897Ltk9h+jeTYMywttA+l4hZ/pVvl9J9J2eaT
	HvG9HlVJeaCf47txPTgBt/hu73ORqZDrPxGVZb3mc4082YUNKJ4Bu2yABq+ZXuw9WqXV98ecM1H
	vJGs1rbotyB/ec1c/TFDdN6y8v8WdOZceqdIIDddhALEMw9ZtvjxmcOmpuzR+Np0x3OcgzU10MY
	I9MUKmvOQFsFPvk06PV+CnqDEIrfKHFHCzICGsH0zw==
X-Received: by 2002:a05:620a:454f:b0:7c5:602f:51fc with SMTP id af79cd13be357-7c91906563bmr852556285a.44.1744885715929;
        Thu, 17 Apr 2025 03:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqzTf66yKPKOlZDjn6KCEnTCMGlag6Vhw4gC6r0xHrSuqE8PUM4LdRh5W3NOMjL3tUjQDzgg==
X-Received: by 2002:a05:620a:454f:b0:7c5:602f:51fc with SMTP id af79cd13be357-7c91906563bmr852552185a.44.1744885715635;
        Thu, 17 Apr 2025 03:28:35 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a89424c1sm1168102885a.3.2025.04.17.03.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 03:28:35 -0700 (PDT)
Message-ID: <7c9ace30-a973-444c-ba9c-96272474a76d@redhat.com>
Date: Thu, 17 Apr 2025 12:28:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] checkpatch: check for comment explaining
 rgmii(|-rxid|-txid) PHY modes
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Tero Kristo <kristo@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <9d73f6ac-9fee-446b-b011-e664a7311eca@lunn.ch>
 <659d6affd7c58474c4bca5c92fc762925591d0d9.camel@ew.tq-group.com>
 <9e0e6365a2c0151c819e442775ece37353468d91.camel@ew.tq-group.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <9e0e6365a2c0151c819e442775ece37353468d91.camel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 3:37 PM, Matthias Schiffer wrote:
> On Tue, 2025-04-15 at 15:36 +0200, Matthias Schiffer wrote:
>> On Tue, 2025-04-15 at 15:20 +0200, Andrew Lunn wrote:
>>>
>>>> +  **UNCOMMENTED_RGMII_MODE**
>>>> +    Historially, the RGMII PHY modes specified in Device Trees have been
>>>> +    used inconsistently, often referring to the usage of delays on the PHY
>>>> +    side rather than describing the board.
>>>> +
>>>> +    PHY modes "rgmii", "rgmii-rxid" and "rgmii-txid" modes require the clock
>>>> +    signal to be delayed on the PCB; this unusual configuration should be
>>>> +    described in a comment. If they are not (meaning that the delay is realized
>>>> +    internally in the MAC or PHY), "rgmii-id" is the correct PHY mode.
>>>
>>> It is unclear to me how much ctx_has_comment() will return. Maybe
>>> include an example here of how it should look. I'm assuming:
>>>
>>> /* RGMII delays added via PCB traces */
>>> &enet2 {
>>>     phy-mode = "rgmii";
>>>     status = "okay";
>>>
>>> fails, but
>>>
>>> &enet2 {
>>>     /* RGMII delays added via PCB traces */
>>>     phy-mode = "rgmii";
>>>     status = "okay";
>>>
>>> passes?
>>
>> Yes, it works like that. I can't claim to fully understand the checkpatch code
>> handling comments, but I copied it from other similar checks and tested it on a
>> few test patches.
>>
>> One thing to note is that I implemented it as a CHK() and not a WARN() because
>> that's what is used for other comment checks like DATA_RACE - meaning it will
>> only trigger with --strict.
> 
> Oops, DATA_RACE is actually a WARN(). I must have copied it from some other
> comment check that uses CHK(). Let me know which you want me to use.

I think it's better if this will trigger on plain invocation, so that
there are more chances people are going to actually notice/correct the
thing before the actual submission.

Thanks,

Paolo


