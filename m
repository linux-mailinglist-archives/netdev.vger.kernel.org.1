Return-Path: <netdev+bounces-165300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B3A31851
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5C81672B3
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B62E267AE6;
	Tue, 11 Feb 2025 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzllKcHt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84025267715
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739311046; cv=none; b=onDwsiaR4P2XyfZtHYr+hTBTYTRk7Wu73IPH6mJRKyr1XEI/ZgST1dr24Y7GgKLs+YDJL/4ZJ7HqR7lN1wtH/eZuDbVT4G6XXyH+lXIBJ4UMiOMmgkZ7ugjNolKbXJ5mVtTwh7eNxpv2vwq/QeADXcaOQvb/t6WuCzIFu46QIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739311046; c=relaxed/simple;
	bh=EX5X/esorKI1fxw4yuvbOfp9QKtIF++y+Ks2d0qWmSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxMxscJxaLqdqADwX6PDIyaUSouUp7W4b+HTdhud5Wafb32ceZDmLwJrrzjBD/23iKlZCCBM2vS5pG1EcwX1AFG7mEFGn8aAh6nhhY9c1J9r97mlrzW9ATXVF1eYREr6Hku1iqhNji5t9G4Beor4VGB9lSa4Prf7uSjNcnwZBIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzllKcHt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7ca64da5dso40711266b.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 13:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739311043; x=1739915843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IFCZeSJSr6WQxEtYNvLFdeSeQElZvqjJJ1iZDT+RicE=;
        b=IzllKcHtfWJTr1MHSReNg5rTXEiKq281tZHhmIR33nBHtG+rVneo0qBA/C/dqlPEUL
         JizxcImAtfXVekfTdLyYqIikgkfPcDqLOiWJq6ASk9ic8xHHM9ZT3r570q4T4o9jn3dA
         /+Po2u/okAIJ1sdTvzDbJqLIjXb+gy0aow+riU1rPhTwPzZ1aMyKWc442XF2pxPvVfEB
         MgygQDDD7gamcbQVZdCJV5j8LIPnqqMTGtMCMMLjQRCG9fDNX2hqP/Xtvzv/r9FgEREo
         CAVTBJm/Wp5x44jup3ov/wpMdG4zxhiWkBnAaVk1/VUlJtLLnSp+1VJACdmm+cq6A0it
         4luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739311043; x=1739915843;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFCZeSJSr6WQxEtYNvLFdeSeQElZvqjJJ1iZDT+RicE=;
        b=OBOhA32ZLMSWmqcuRkN01IHv+DilPmOgGFYkzW/G1v2b0gvGuyzy/aUQCs0Ds5/2A8
         ByTQSrXepdWcx9ffJz9csRdL2cvLDNshnJreRxiu9f7BMeQarA87ALF6XVQAP9N5zpWl
         ukfrBPh6KmJMxUPtyISWlyPN3JgBPceCgSalzU0Q+lUkeoGFoJzn+OtaPa+GaDxpHIDo
         KR/9bEFweEg18rP53tIq8KMhta35JkT4YXXF/JlFqQjmpaIcZrj31vALdGtXG1C8whC9
         CmX4zbAUtCZ70Mzk3S+luqsS2c8eZ4zT51mYSE0Ix5GrWFysl7vXRt6AMyMtR/6KS3qp
         ehyg==
X-Forwarded-Encrypted: i=1; AJvYcCUyzd0solC9vUDiwypV907AXBEREczG3ooizIA0dSvD2g1CdX14Zi6yiQymkXs1g0P3VWdjbxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlEkFhqxkb3xw12/JMqwbQHAxyg6zRZKeYnKHjiAUb5yBUAnrS
	ETanMFCrqE/r1jhShw9/XmpVA7TC/YajVD85cpY3aHlRFSxEoPe0
X-Gm-Gg: ASbGncvZnLFVNL3y4PuBshhFV+ypb5cOVazuZukNU9F6tI5QvoL/sGLftIpkJMHn3Qe
	spC1ldJwIUXwQxrvBcajnBVK+PPdAa//n1YrUmBT7k5VBPlva1f4rehmyh0VdtjgSqeJuZc3hIL
	S90l1m7IoziSAV0mkdIgv7+uLOCO7B3Uerv0Pdy9+iRkHr/vnYYBVCiGvIAGdPHNKnWIBSpxgrJ
	ln/Gv55tIkZ9ricbz2cSHioOtHS4hNZTjmPWAxYvukvhKjTWH+3iwGX8QnXKhCapc4XpYYnQ5eS
	njmdUupZ7gEpaSAaLaCx3I9dlpZnAgC71A4GI73KJoaMr/R7wuOqDwKufAo+xCIhc/uzZrmHzXT
	rz9QRji80wOgBMU+Xy5tS3k9ZIMuyWA/S9iQxKnMlzoiG+DcuiJMJGwaDh6yNpt3RPAOGCNkYhS
	e4sURohIc=
X-Google-Smtp-Source: AGHT+IFFcMbUS/QkJ9SiVXuqxgQUbPDqsnGHcRevrpkM91lxGhRk6zq1GdSLVJfqWmX7ZqReOXba/Q==
X-Received: by 2002:a17:907:6d29:b0:ab6:d4ce:568c with SMTP id a640c23a62f3a-ab7f2f287afmr72303366b.13.1739311042423;
        Tue, 11 Feb 2025 13:57:22 -0800 (PST)
Received: from ?IPV6:2a02:3100:9c22:7900:2c5c:8c96:f0da:db78? (dynamic-2a02-3100-9c22-7900-2c5c-8c96-f0da-db78.310.pool.telefonica.de. [2a02:3100:9c22:7900:2c5c:8c96:f0da:db78])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab794509fcesm889202066b.34.2025.02.11.13.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 13:57:21 -0800 (PST)
Message-ID: <a8ad7d9b-4276-42e0-9dce-8a8b2115151c@gmail.com>
Date: Tue, 11 Feb 2025 22:57:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ixgene-v2: prepare for phylib stop exporting
 phy_10_100_features_array
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 Keyur Chudgar <keyur@os.amperecomputing.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ad4b5c29-abbc-450c-bada-5f671c287325@gmail.com>
 <92040ddc-bd6c-40f0-807f-b17b7d0e6b39@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <92040ddc-bd6c-40f0-807f-b17b7d0e6b39@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.02.2025 22:24, Andrew Lunn wrote:
>> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
>> +			   phydev->supported);
>> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
>> +			   phydev->supported);
>> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
>> +			   phydev->supported);
>> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
>> +			   phydev->supported);
>> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
>> +			   phydev->supported);
>> +
>> +	phy_advertise_supported(phydev);
> 
> phy_remove_link_mode() would be better. The MAC driver then does not
> need to know about the insides of the phydev structure, and it
> implicitly handles this last part.
> 

Only small drawback is that it unnecessarily calls phy_advertise_supported()
after each statement. Therefore I decided against it.
But you're right, it's cleaner.

>     Andrew
> 

Heiner

> ---
> pw-bot: cr


