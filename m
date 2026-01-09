Return-Path: <netdev+bounces-248461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F071D08CC2
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 12:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7930309402A
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 11:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C9633B973;
	Fri,  9 Jan 2026 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDOZ1wFL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED8033B972
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956447; cv=none; b=mSZvXDnGWyilJV4DR9JFCh1gwxmDvfI3XPQKXsBX6g2IlM0UOzqTxFHwf/WCmGh4bTt0rq8Dn138emxKiTY0gZHW8/xVkFjwh6xAdPNAcANKRJujbriAJfecq/cxzRLpW3dvsspAJv37DnEk1HUEhDOlTuhNSbq7yYRXDk4PMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956447; c=relaxed/simple;
	bh=E7Kw2qWiUnhrhOA9x+kUneMFMH2UGTN9uFe1m7zolm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICCn41J6JoPfUDN94nZqdDCdHl0g8fBK5OXafwHctBKgAqiBnezNAOxG7ardNhdOfKr+gqnc6NZYurbxYh0lGTuQKeFcM9kI4+PaIuB3v0QQBMH+bYAXLeSpz+mp/LLeLwgg4b8jVCAxzl1mdpbsfVk8PvrycXspnl2w0zQdT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDOZ1wFL; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b679cff1fso3088029e87.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 03:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767956444; x=1768561244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqoBuqGPYO3MBBZam2ND97FvS4ahEqNDCPSZA0/NAZU=;
        b=kDOZ1wFL+boHapIMVtaWcjmsfpHDuxcFoTrsP/Rdwv2GWc0s5vVyQ50H7UZ8uXUXCU
         svq+b3MtNfyN85wKZjA8CwU5xGSi2q5iNtyOAPja1oRzbwmyzsg7etNkpKal59/p0OIw
         8jH9Ppd670grHK5ae89/KO4MIEuakiMdSD+N6Kk/8/DKP6486Fmw9QU+vLOmGSFPcdHx
         UXAdIzE8gzQham5ogb9T7b6T2TKoZcHIwc4kN9wAxTFhVCutj7FbLfbxZUrpOCyVIsLz
         QupeUmwN/tgVzDGRbjLFVZKAcSeMfgjlNfur9M+ziOFBzfrnJPrM4s3sd0ffs9ng/1H6
         EzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767956444; x=1768561244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqoBuqGPYO3MBBZam2ND97FvS4ahEqNDCPSZA0/NAZU=;
        b=T1hMTQgIcD0Uz3i/bkZKPUPw3ukL+XAhe8Pu5ECMrJc7diayqpqfstvkVJ61lSiFvQ
         Ib/H1jDlVjMWSNlhYlGI+7eUTTcll3fRS+faZBIuIgP6B4cPSFut2OsLIl6K+mGIsIHz
         +Em5uQpx+lw4we5HERsXEmXyIThRr8bQ+ld+4mza8v4sb896FuR6IFVvFuy2fJqe8yFa
         DRlY0EshVq/WGVq54ajQaqFrFeEMMQTgKl2Xx/ECg4GbO3qxQOBvgDwoQuFSHzlBQ0XO
         6KlZE8UkXf/+IM7KcUOkBQYh2KiuhsodPoeoZknlfLekJvac/E/S23juyKfGDrHFqR6Z
         EUuw==
X-Forwarded-Encrypted: i=1; AJvYcCXWbiFHNNCRzBOgWORG0i5EzsJCdcKHDdlOvvhReWoGru8lW7tdTMmLM5AVEeJfP1IY/qEb6y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzytMI8jK5TwmEqh21PmN6gHHqvpDOzw7V5QBQ6rby7YXHcSv1S
	yuuanORt3F52a+Z+4BXfG48bvQ4Ytdwo03Z+NeUFIMBZFr2pH6WsZN7XJUb+jg==
X-Gm-Gg: AY/fxX7uD3OeXv2dfJbvHSogsUj4xdv4OIr6efvYqi3nIS2eeISVxY1sKB6vK83w42u
	FLHXuGbF9RFi2nqWyCgbfMp4avPiHCU9/wYyOq6UIOJQKQ664Mv34fqvWemc7DDq8nLGACUuNc+
	4FIhQ8ZFHhiNuV43Y6RXl/AfHDXYZT1ZZtFVqHmaxhQ6ynCkA/J9+MzaeLCgszdTPq/OgVst2i7
	jMUG+syM6YKE500OKysk7bf7KZAytCLBZI0a1v0MX5waCxlDWVrwxXyjatrqqabYZZ5DGKWqy8M
	bJP2McgvgBkZLedYrr9TW8bTWLa0Vu5SzMNk7SdhI4iTYy566QsRWWY9xUawzouwoXwvHlcC8fa
	KxtIaAWUxB76t0hOsEWW8hSftKbG+he7g+1ItpqEyVF2vt3mVjFWiJGFHSrlvYIEAVsClrGOibR
	7thLUBG0P4NoLoL6Bp/MGliQcjFrn4tJbdElDOP1JKuo5I2sOqAc+1LfAZvUYfZU/BrssCqZpBh
	DvlnHCHww+hW/FKDOdBtGj2DIMZBvc8rV8JQm0wHR+BV2/OT6zO2w==
X-Google-Smtp-Source: AGHT+IFMWrhn/zD8S7L7QefRHqtE+srOvan7Oqu7FDcQ1yfstaZdkM+oGVRAUleuY9Bwvy1rVkrYVQ==
X-Received: by 2002:a05:6512:3da9:b0:59a:1a4e:c098 with SMTP id 2adb3069b0e04-59b6ed134b7mr2674313e87.8.1767956443812;
        Fri, 09 Jan 2026 03:00:43 -0800 (PST)
Received: from ?IPV6:2003:ea:8f34:b700:c079:f905:5470:9a28? (p200300ea8f34b700c079f90554709a28.dip0.t-ipconnect.de. [2003:ea:8f34:b700:c079:f905:5470:9a28])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b6a2b8330sm2512662e87.10.2026.01.09.03.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 03:00:43 -0800 (PST)
Message-ID: <1263a26d-a622-45d7-8043-262f2b92ed3b@gmail.com>
Date: Fri, 9 Jan 2026 12:00:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: fixed_phy: replace list of fixed PHYs
 with static array
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <e14f6119-9bf9-4e9d-8e14-a8cb884cbd5c@gmail.com>
 <20260108181102.4553d618@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260108181102.4553d618@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/2026 3:11 AM, Jakub Kicinski wrote:
> On Tue, 6 Jan 2026 17:56:26 +0100 Heiner Kallweit wrote:
>> +/* The DSA loop driver may allocate 4 fixed PHY's, and 4 additional
>> + * fixed PHY's for a system should be sufficient.
>> + */
>> +#define NUM_FP	8
>> +
>>  struct fixed_phy {
>> -	int addr;
>>  	struct phy_device *phydev;
>>  	struct fixed_phy_status status;
>>  	int (*link_update)(struct net_device *, struct fixed_phy_status *);
>> -	struct list_head node;
>>  };
>>  
>> +static struct fixed_phy fmb_fixed_phys[NUM_FP];
>>  static struct mii_bus *fmb_mii_bus;
>> -static LIST_HEAD(fmb_phys);
>> +static DEFINE_IDA(phy_fixed_ida);
> 
> Isn't IDA an overkill for a range this tiny?
> IDA is useful if the ID range is large and may be sparse.
> Here a bitmap would suffice.
> 

Thanks for the suggestion! The IDA has been there forever, just the definition
has been moved now. I think switching to a bitmap is a good option.
Can we handle this as a follow-up?

> DECLARE_BITMAP(phy_fixed_ids, NUM_FP); 
> 
> id = find_first_zero_bit(phy_fixed_ids, NUM_FP);
> if (id >= NUM_FP)
> 	return -ENOSPC;
> 
> set_bit(id, phy_fixed_ids);
> ...


