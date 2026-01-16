Return-Path: <netdev+bounces-250612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FF7D384F7
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8935300D907
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB113A0E98;
	Fri, 16 Jan 2026 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OKmYLEjv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218C3A0E8A
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589750; cv=none; b=pskG/QWD1t2dX53WDCjj1pBiCe4R/RHY0274oT34ytem/yHLZmQlOQAh7uEzj5UitGCwbJrNCmgUNMFu5ELZZT7+7zggx0duQAjxrweKzo7eZF4xj8avjOzHDn0e3zODvbRhcbo2TpiSg2dJU/2k94Hfe8Xwey4ApTf9AFnKOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589750; c=relaxed/simple;
	bh=P5xS1qScu1GQYgtTJ/T7epol7LRBBinPomVjAlVoW/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtpoXWIC9n+Ik9gfAkTitOCzepx4FpD6miaHZh28sO9kJbF6C0vJWhC4SyXcnQAgoNurJWt/VIrry5Lsy3ea3PzjeEl+yp/Pe4v4Esw5FELH/8jlNp5KNI/iquu0C57AFKgXOrtnaveuzk7V0FNPOI+iQNQIToHJGW5RN52bhf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OKmYLEjv; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-55b219b2242so1489756e0c.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 10:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768589748; x=1769194548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNih4jFo4VOHTJt74UmFeRa0U4+3o6bpTkjmFpVP9zE=;
        b=EdsqYpsyuCU2p2CVjCqdTIcD7VgnuDhP1udzXLaN6cOwgGwV46dgdzzY53oh/O2Gbn
         KMyjfFa+B8M3c8ak91oCp0QNKtm8HmZoVD8Qm7y/MspQxlezpWA+dQ6zTxpl19YWGDmg
         SskPcXGSCPp4GfUgVfiTk2zVYz/5y3jbJjHv8o0uFrvUYq4JpqSUmOzHN+Az+qKmYg2Z
         Ak41IWYQqs9O9hKpVo2AO8Ptk8e14V7Ps9FTDIRZ5401jVHK43xmq0/Jo4NarpWEsPoV
         pmJ2UX26/0/2ha8NHzODMmNYV+t2Fc1uGm9e5tf9nYclHJkjni9DSIwzevLTFoMsjlWO
         Xu+g==
X-Forwarded-Encrypted: i=1; AJvYcCVHGf0L3+sdOkmtCXxxl0Yp0hatcKGz+3Jg8Y7ejoOiyetMj3aBDUfRmXUVl6u5dp/NXmYiXz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuQM7oOzVYUxd3/d4M2kwVFwtVqCwsfEzyirkFZpGugODmjH0+
	XgRdJj/VTnaDIiKI/erRvT/hsck3C4MSWK5yRqVaiZvat67BNHoYTZO4cocFIiEHIhN8cp29nOI
	+fxsgQp1eal2A7G1Im69of5RM3H+dY39ttluXFhWDtBEDV020dDh9bVCtElD71xGvVfiEi3f4in
	fM7+hw0VxxS/EqAPpbKNuN1nPSkGBJclr7jGRZIqpEMwuu8M4jB1fSXXqBg3Mrd/IAUjQXKyDjT
	Nk/CM/0HQ==
X-Gm-Gg: AY/fxX7CrYF+tgl0xn5Pq0V8PW+cctMk4ICDXfNss/3OaSTm7ezn7lUYyo7vH328fd2
	bUVVFSj9KSOSMSkoeZa4fnjLVbLDgy+jWBMpobwi6v5TwdR9oKuspMGASBZ5xvqUmZnM2+ED4aX
	AS4hDAJ7ge8eYeH/DS12SZ0eLr02AIA4IikDNZJv5HZRsoRvZAxVghTlzk2zBsd/OGkVuiI9q0H
	jk9L/nGhCTjxf6mnaurArtQJbOQNUMZN8L2p8tONzevy2YxyTaVsx7bOpiHdLYqJd92CtEZPnh+
	lSVuIvaZsSHg5o9AvXBz3IjNEmOrJBteSZkxP/k1+ge4JLTABaiO9LkmAAGdPqzafpZ0hmRaqHE
	AQBlN7p7Pt1nH7E0FokHp98I5P9tGskRAvIrqvRR7i1X7o1+RXJ+Ikgnz+hqhu/DdBEWt7SmKeL
	VKw9yeV+vVBEQ5/7XOz+Vzc/E10kCCK+SN5qWqY8UI9NE=
X-Received: by 2002:a05:6122:4d0f:b0:563:743f:337c with SMTP id 71dfb90a1353d-563b63f81d9mr1423204e0c.7.1768589748144;
        Fri, 16 Jan 2026 10:55:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-563b70f24f5sm389961e0c.5.2026.01.16.10.55.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 10:55:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b0588c6719so2388920eec.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 10:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768589746; x=1769194546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNih4jFo4VOHTJt74UmFeRa0U4+3o6bpTkjmFpVP9zE=;
        b=OKmYLEjvirSWmd92/S7LQqHKHeYM1IMfDVQDegsEIo+ePofFz8CwRpmf1t121SqI6u
         4eoopajAz4K3rqtTRQNCDuyw6dH8aB8m3UDA+DWETMNyaqVPuaAleN06wZR4nPH1y9OK
         pFsNorQ3sNChRJY5Kmz9hV2kB+cRo5hEVn6zA=
X-Forwarded-Encrypted: i=1; AJvYcCUhfE/uHt+UbqD9i3NAP/JymU9+DTMSyzg40eCnaaOAHv32ohidd/Tk47m98+sqBW7l2qCufrw=@vger.kernel.org
X-Received: by 2002:a05:7022:a89:b0:123:2f12:60b4 with SMTP id a92af1059eb24-1233d0ef32cmr8481946c88.20.1768589746659;
        Fri, 16 Jan 2026 10:55:46 -0800 (PST)
X-Received: by 2002:a05:7022:a89:b0:123:2f12:60b4 with SMTP id a92af1059eb24-1233d0ef32cmr8481920c88.20.1768589746167;
        Fri, 16 Jan 2026 10:55:46 -0800 (PST)
Received: from [10.14.4.148] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac6c2besm3925601c88.5.2026.01.16.10.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 10:55:45 -0800 (PST)
Message-ID: <3949edb7-70cf-4036-b6da-df4d3d927480@broadcom.com>
Date: Fri, 16 Jan 2026 10:55:44 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: bcmasp: Fix network filter wake for
 asp-3.0
To: Andrew Lunn <andrew@lunn.ch>
Cc: florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260116005037.540490-1-justin.chen@broadcom.com>
 <20260116005037.540490-2-justin.chen@broadcom.com>
 <f104b361-bc3c-4666-86e7-68fd5218eafe@lunn.ch>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <f104b361-bc3c-4666-86e7-68fd5218eafe@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 1/16/26 9:23 AM, Andrew Lunn wrote:
> On Thu, Jan 15, 2026 at 04:50:35PM -0800, justin.chen@broadcom.com wrote:
>> From: Justin Chen <justin.chen@broadcom.com>
>>
>> We need to apply the tx_chan_offset to the netfilter cfg channel or the
>> output channel will be incorrect for asp-3.0 and newer.
> 
> If this is a fix, should it be queued for stable?
> 

Yes, will add a fixes tag in v2. Thanks!

>     Andrew


