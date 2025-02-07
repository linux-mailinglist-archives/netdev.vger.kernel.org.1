Return-Path: <netdev+bounces-164093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FB2A2C926
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96C13A4A3F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424F218DB23;
	Fri,  7 Feb 2025 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSbp9tWs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CA18DB08;
	Fri,  7 Feb 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738946676; cv=none; b=BmpK0OY4CrKM0Sw7Q2Yyy8UlF/EilIboAXKcQ4CBxbTXjW+qJSYVsjCLvuMQOOqBuLzRf7mFqFNQTaZzrAqHaxPl8oGxe+17OW4ZX27FwK1eKky+7xS6pX+t3GYribiU9IA827WTu46w04RfwLwy50Lwfrk8pEabdPfts9NiuV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738946676; c=relaxed/simple;
	bh=JdlVQooyESRVCEFJ40knIl+97sMuXCaHm/o4iCmD5DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMSV+sOz2lv3Yk6PE3gypLmj6+m2keoYC1LZiHsshLtXdOKGBg/IFQga5YFRry2AjV+56AIcgO0nAOJLi1tADPhyXyzJpnoF4TdhAUgsY6wvHeO0yKQPs0lwpyJnYAUhbdZp8yVK0ZlSPxgL63Y3qgGcTqLUXoXKvatzE1qfRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSbp9tWs; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb939021bfso1163232b6e.3;
        Fri, 07 Feb 2025 08:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738946673; x=1739551473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mBOLwQhvsCYjUO5QU6lf4fihBLDLeyv12uvte6XSdZ8=;
        b=jSbp9tWsSj8zndOhXQLzwat+3AB+3DPkpV44nUwoXTfPGnUeqs8410iZtQ+B3Lk5aj
         Gjyn1jBWa23ou0fHo7gw9bxZBCKjTmhKqsZHkxtil0Po9CNmZWRxTHVqsC1PxEP09gRD
         dTir+Z6Je7Lz1ERDPosw1/5437AeZnM5Wx6eU+pv7OM+zVOa4yFDq9bempsnNZcPY/5Y
         5o4DQMUFdajV6FKcKOXEmFAybpwQNjPISONKfn/mmbFo0amdmuN2wigW7mtOE5D/n70A
         +6mT6qdcCL3bCntuF1ou79FYQMPqB6c9syA3V287EGDjNlrw7JAK9vBU0YoSHK1S5wKW
         LkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738946673; x=1739551473;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBOLwQhvsCYjUO5QU6lf4fihBLDLeyv12uvte6XSdZ8=;
        b=pKq4ipRJjp+6ucCibH6DNKL6McwfzePimMTZNjamkUJ+xjKSaexF68+g/zmn8MusYz
         QnggxfwaWMjD+mFFRWvklBCta60ekVUkHrHTVdKKmyGbfiImZM5GafXOH3Xk8UG7HXir
         qVHPdAg8+hcrXQhU0L+kTBEuEqcvrIQCiJ3s+7ALMx3XFVjjHOxg8+rPC3dOKOFGRuhL
         9Zb1nxvui/sVLuc7CyezW7yxyfQH3FQRnFzW8UZ/U1iX941mvJUqySvycb3ToyvuV+2M
         BrMaLsiqJ/UIk55RmA9oRbo01rfSQMDGmxNu7bSe6jQ9x8GBOSac82fPxzO/qBfFWPqX
         4E8w==
X-Forwarded-Encrypted: i=1; AJvYcCV6yB/7kSpT237PkPafY4unS9FQNj1cmKlCUOZhhAOFmXzLSNopWPxl/j43kiYhrYiFJ2Ez3v+k@vger.kernel.org, AJvYcCVtVygkPSs5EBtEgXw0QZTprH6ENCcRB0ZZR57HrzzP3Lvn9fzT6YVH9wuWR8bmUDfuMipBJwGNjIWwxKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI461CxG6OOC6QVGEhstEFietSEMLovlvnsblxxCRbtS4Lc8la
	H052zXGxOPhVHQij/f4fiUamn1sozJL0b6lJvZxdpFix3acOjbTn
X-Gm-Gg: ASbGncueFP4udESS1tmriSKxQEEmY6p2gSVtaeihnrUxgBt0LGE1yu4c/hPSGxQkMwc
	RiwuaOj8TAHozVijJUWE9V9D1Y2xlCGM3hi94O2hGBt2sgpo+fC7WUlbJLHmLn5jqOFglMCxzfx
	G3u3jlL15blMbSkwWC9/NONKUm50O8RGUFgdznEmfkNc4h+wU1iB4jiC1jI6OmD+YVLuZPBps9P
	xZgTp0T2+xlaW+uVygIIVkFG45srioa9LoWLIazyxHRcC/e40dji2LmKXkCvrveG+dW0MRDmhcW
	JITg45UeJa9F74CkltM/dgWdhr3lTIlqfTf1gQTX4OI=
X-Google-Smtp-Source: AGHT+IEOz7Pml1qWs1pvT3+42Bmr4hlj7VERSJ0J0/N7ecamWse8IkB0YXhPyt8g0x+kvpCBwGwGYA==
X-Received: by 2002:a05:6808:3027:b0:3f1:cfb4:9ca with SMTP id 5614622812f47-3f392363e4bmr2298021b6e.36.1738946673396;
        Fri, 07 Feb 2025 08:44:33 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af9343c2sm860404a34.20.2025.02.07.08.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 08:44:32 -0800 (PST)
Message-ID: <318e8b95-4ef8-43ca-a19d-129372a9dc48@gmail.com>
Date: Fri, 7 Feb 2025 08:44:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net: dsa: b53: Enable internal GPHY on BCM63268
To: Kyle Hendry <kylehendrydev@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250206043055.177004-1-kylehendrydev@gmail.com>
 <1317d50b-8302-4936-b56c-7a9f5b3970b9@broadcom.com>
 <9bd9c1e4-2401-46bd-937f-996e97d750c5@lunn.ch>
 <a804e0a4-2275-41c3-be3b-7dd79c2418cd@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <a804e0a4-2275-41c3-be3b-7dd79c2418cd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/6/25 17:41, Kyle Hendry wrote:
> 
> On 2025-02-06 12:17, Andrew Lunn wrote:
>> On Thu, Feb 06, 2025 at 10:15:50AM -0800, Florian Fainelli wrote:
>>> Hi Kyle,
>>>
>>> On 2/5/25 20:30, Kyle Hendry wrote:
>>>> Some BCM63268 bootloaders do not enable the internal PHYs by default.
>>>> This patch series adds functionality for the switch driver to
>>>> configure the gigabit ethernet PHY.
>>>>
>>>> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
>>> So the register address you are manipulating logically belongs in the 
>>> GPIO
>>> block (GPIO_GPHY_CTRL) which has become quite a bit of a sundry here. I
>>> don't have a strong objection about the approach picked up here but 
>>> we will
>>> need a Device Tree binding update describing the second (and optional)
>>> register range.
>> Despite this being internal, is this actually a GPIO? Should it be
>> modelled as a GPIO line connected to a reset input on the PHY? It
>> would then nicely fit in the existing phylib handling of a PHY with a
>> GPIO reset line?
>>
>>     Andrew
> The main reason I took this approach is because a SF2 register has
> similar bits and I wanted to be consistent with that driver. If it
> makes more sense to treat these bits as GPIOs/clocks/resets then it
> would make the implementation simpler.

I don't think there is a need to go that far, and I don't think any of 
those abstractions work really well in the sense that they are neither 
clocks, nor resets, nor GPIOs, they are just enable bits for the power 
gating logic of the PHY, power domains would be the closest to what this 
is, but this is a very heavy handed approach with little benefit IMHO.

What we do need is document this register in the binding however.
-- 
Florian

