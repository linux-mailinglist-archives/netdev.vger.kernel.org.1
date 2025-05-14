Return-Path: <netdev+bounces-190493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5CCAB708B
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 17:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B317AE806
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AAF220F25;
	Wed, 14 May 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8Qk4JzG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447EF1A5B90
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747238317; cv=none; b=sRVZ0dv/+TPHLxOMG+uRCxVLpj9xsekfTjkkLzxft9D8THT8jiHBSGpX2iSPqjNK9Mc/ancclIQAyoHVUc2Qub6TASq4jmDd2+hoHcl3gtX3LdvhoONF63alAdZliWIDgGznqtcrrMOcTccCEPyuph1mknlBTTuK2S1H2xUNjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747238317; c=relaxed/simple;
	bh=RaqmZl58DnIVb+iisfsC6eKCVWU5TDMFnXMqPtsSq4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hVpljNwDH3YjlwkVHMYO8yv1xCrAi+nNEdZxQBSk7mF10QsDXOLpLOf048d6MD8FyJHu8g9vITcDbChtWjfjQ7kuANxSUR5Q4V52RVauue8+1AyS8Vl6bbfSNLcwnLnFMZ3O6ehrFNjZCxy1XGE1kdcylC3Ns6bwKCqckWD1PH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8Qk4JzG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso47068065e9.0
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747238314; x=1747843114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KUtNem6dUKd/QqP9OUQxP8p92EcBLkyvEXza2/acn6w=;
        b=W8Qk4JzGNX/Q1LUYfN4GGkVPGC9WGHPXq02nHjwZEeUjTZNssujzHg8oWjoaORuko0
         ytyRUUZeh0ar/UpfQjrpBSgXCRIde5SdVRgSWXs9tpJxR585SptlB6Y7KOi/K0s4Kdp+
         6f0iRcteDVZ7EfBGK523cF5bue6g7PLLacfWuIjBlaWKtZAw01h1dMiu4lI7aKw6+kq2
         3KpfMLJHhwDxeZnh0yBTTNMkcv/Erb4bMDD8E9mCZX4S3abGSntvxWeAmBfcEYlprKXw
         kH06RxqXVM7s1SGANmnznkBph+mu6ju2G1ww2uINtu07Dlq265d4XLQ01G+ceP6vvWVw
         +ylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747238314; x=1747843114;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUtNem6dUKd/QqP9OUQxP8p92EcBLkyvEXza2/acn6w=;
        b=UxMvYIzeSsFJW/3agXXABfTp9DFVxAZVFXCNDhRD/HQiD7VuR20Ai0e528aDQKag2s
         IFVeCUJQ0k57wSEvjDTGelr4z8uxTxkxix9HOqSrZ3miTEfl3SGDOMM7fVqPSNB2zlMH
         oaEGYkTc8Qxg6XW7apAJRGlmGEkKcUtVHCdQmBzRrH+I6Wp///Uf+uFb1q/6Jsnpag2B
         mRT/hlrC79nclQ0rwqclGWMmAk8Eq774TKwo/5HNsxnw+sWflEaQu5HkTZhH7BbIa7jV
         mvqDIdrYlqKhVZzd2VXCa3Gwh8yaUtCeBwDEdrQH0EDh7J2OWxxzipN2aCtV2vI7mBuq
         ofWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXltnyKa0zWEwekpooTWsa42krhG1TonS9NfanPIqBF6IAbacrjF0t7hA9uwd4aQQTsB+PWkWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVzsfWzBE1nSV2rAt6UY6Os49WCcsQsY6cEIRCak/6HML8HVg2
	bpxCluVqCWW6zpWXmUKmOMevqe8/Cz3+Qq7OzvBcYl3d2XlnrsMo
X-Gm-Gg: ASbGncv0m8692hzxYzsMrTaJbEQyJdxYy3vZeJitVHHbjEZ6Zalak/neQ49rg5xaTDp
	VFG4f0VUVdWBJYj6G3X5O286Lppj7gq7o8b3Oc5c68D6A6s8atP4LQ1E4XRNrDn/+1WEu8lEodG
	Ziq2JknwF/Ek0k8O8oWPs1nPUfcoY4XxNaCQ51yDvl/uXTAEsyweEqwHikXhAxi2ho4XcFNTnxa
	h1dOons5ijt3sUE7K9EFPhS0Y/IT1b7l0GLz0Xexb3cnl5ufr8DA3tfAlw++EWBywRl4kvcF0hn
	nIvtJ2XJDcrGBYkI2NGrHfL2ca7toUyiAxAUPziXk+yFm2nKtvnzhVJuW4seNMNicosObYr3iLK
	M1onTRcymVhfi44RV6wIDBGkNE7L/NWvLUTQTK+lGEu70gfcrYbwG/yquGuM6loe8bAjzuCN9vZ
	F/F36pOLFW88NlSSw=
X-Google-Smtp-Source: AGHT+IGb1Of+JtusV/47FMipIy+L+FINiDvmrmxN6OT2I0H7JO94M2q06zE3qLgnX1WwKleBNPvRxQ==
X-Received: by 2002:a05:6000:2207:b0:3a1:1227:149f with SMTP id ffacd0b85a97d-3a349695c44mr3446095f8f.2.1747238314364;
        Wed, 14 May 2025 08:58:34 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f20:7d00:ad50:3d0d:83ac:8586? (p200300ea8f207d00ad503d0d83ac8586.dip0.t-ipconnect.de. [2003:ea:8f20:7d00:ad50:3d0d:83ac:8586])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a1f58eca4asm19831522f8f.24.2025.05.14.08.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 08:58:33 -0700 (PDT)
Message-ID: <e9ff0335-9b4a-4b5f-adb0-c9ad9ae78f2c@gmail.com>
Date: Wed, 14 May 2025 17:58:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Realtek RTL8125
To: Andreas Muswieck <amuswieck@gmx.de>, netdev@vger.kernel.org
References: <bb856c9b-7038-4e1c-ac8b-7fc5af4ca62d@gmx.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <bb856c9b-7038-4e1c-ac8b-7fc5af4ca62d@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.05.2025 15:03, Andreas Muswieck wrote:
> Hello,
> My new computer has had problems with the LAN chip right from the start. The motherboard is an ASUS PRIME X870-P WIFI. It contains a Realtek RTL8125 chip.
> The Linux distributions Debian bookworm and Linux Mint 21 are not able to establish a LAN connection. I have also tried Debian Trixie, no connection.
> Debian bookworm recognises an r8169 with unknown chip XID 668 and recommends: contact the maintainer.
Likely this is a typo and you mean XID 688. This chip version is supported by r8169 from kernel version 6.13.

> I downloaded the LINUX driver from the Realtek website and have to reinstall it every time after an upgrade. Is there a solution for this?
> 
> Andreas
> 
> 


