Return-Path: <netdev+bounces-194845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF8EACCE8B
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 23:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E516218964B6
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 21:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282B91F12F4;
	Tue,  3 Jun 2025 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="gr1fRDzQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F9A4A23
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748984452; cv=none; b=Nl9orK4t1ynzzW4eXODyCZjdyELPQ5yK/84V1l1oeYuEKhxifEYRyE2k3/ImpyjIvl1LXL5J7LalI6ZsMiPYOXSdSFy6XsueCDkLTDNGnkyKM7oJ9ePvBtP2tWy3xBoK8ds1Xs2FP73hSJyZQK+aDnAWuoWyCyDkoUcqVJzokdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748984452; c=relaxed/simple;
	bh=UkVpdqJHMPRKWwzgkIoCA2s+FvvyPiw9dxao/ZWsUgM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YRn5JVhFfxSKLH2M5pBvtYEkj8XOShoXSsOlGwpMYgno60XVZRgTMf7PNgFZkTvXxZV6hO9asY8Xz40CB9ZfaaVI16i3ryha1mNZ0GZ/54bsa4rJdZfwyjnokSP5a9IUfb92GXtOL9NZlvXkBtHQXTY4/XbEJM5L+eLAS/zofwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=gr1fRDzQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad8a8da2376so1006128366b.3
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 14:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1748984448; x=1749589248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+PKgRqE/agxHfUSUWE1ZX+G/aaQhrQ+OflgKrEMgMlM=;
        b=gr1fRDzQD4csOlBG01ID5UNTv7/+iCWDoPaebrtnO7NYNsL+e68Qtl8PpKd0y1KGrx
         AcfL3DdrjFRhb2LCFVuSBCfb7sZxtDxgEGPt1O5vIOl2ckJU7epXDWOnQ3OvUmkT+D1D
         U7XqGGphwvZxsHIl6DyBdMnfs8ScanOH2p+3Ic8numiVxBRqlRD4gpNAge/cji8FfbQR
         8htza4u2Mhpw1yW7fh+8nwSlNlqT0j8mCL9c1e215m7rl2ZHYjbHaoKljMxqO0vfqi85
         gzBj8pGpSRjtVVnj/br8gbL2GvKwGlT7g090SXSQoiHkRQk/TDPKPeayxtO9YYJhpjIB
         g6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748984448; x=1749589248;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PKgRqE/agxHfUSUWE1ZX+G/aaQhrQ+OflgKrEMgMlM=;
        b=SHX4e1YWzz+M2KDnm1KcdtgKN6OD6CdseHb6nUVtlRwfxlBv5kGLEDqZU3BeLAS01i
         D7mnwzzFBXQ9Z0UDyHeURanjWwf1d5CVo/KvNCheFL2y+hWlslR31ygdPe4++v3+BNe+
         9UwN0t3Jdmesv449BGA0h8JphcPpZPeM/wbUDiw36L5DM8Mpnb13jn168ZJQc1EwECN6
         DpMniDhzFzTrj7VE2CLcrzxqxbivGoizxC8X8JnKox8tDqY2T64xoCOyQSsP0O2ZdI6I
         jOzCxmNxWcKq+3hnU/T6ZgorV18C8X4NY1qEnAxTJN+TUw5SPNSBG24C55GUapPjxbDh
         fQAA==
X-Forwarded-Encrypted: i=1; AJvYcCVPhwwTdX1R7akl+gux7kvsSeOuyYNRvJnsYqkdBFUiM+zOGjivS8ZGVrQieUizNMYpc5ekeWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+jGZvzXP7qPLMVgMJy5r8ndD9h8x52nbKgG/IexEZr/ww0Rub
	mlbkVQbbfeinlEIBCJ2PHrLbYt5ORCjXEuGzSdWl43n1DELZX9Um5i7ih/TZe54EWQ==
X-Gm-Gg: ASbGncv1K9Nk3+c23jTtcshjsNMyVV9b1ILLUwtqhPDRw6Ilw6/n3CZz1K6Wk+RaqdI
	RxifvkCby4VgzbES56Kj5EOTclI9PzPbFOWPJKkTAcEyQgXB2R6kLp9+au/ibirQBePKYoRMryR
	iRRI4Y4vOG8LN8FVrldVoktz9zaNNBmBo57/CO05ECcSqxOFbEdSKw5zMPmS3cALuyzORFPDlX4
	kXx2qgEBs7gYd8fY6l9iCG9FgXYcPQ3hp7oatuioZOTP+pZ+20UoM0KaRBGR7su3NY0Z2POgol/
	SoNsfWKixGotJD6sOXcQ6XS8JUDWGf37quhD14hnQgq6f4TQAQ==
X-Google-Smtp-Source: AGHT+IFE/zq55kKCpFNUP8s47xQ1VlVxdxq1nZI5gpd41ZgPDjMuxiJo036Y0yIPNM78hWufsGJ+cQ==
X-Received: by 2002:a17:907:6d0f:b0:acb:b900:2bca with SMTP id a640c23a62f3a-addf8a92b51mr10123066b.0.1748984448317;
        Tue, 03 Jun 2025 14:00:48 -0700 (PDT)
Received: from [10.2.1.100] ([194.53.194.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad3d7ebsm1002032566b.159.2025.06.03.14.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 14:00:47 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <c0ece81e-6fee-41bb-96c9-eef36b09af37@jacekk.info>
Date: Tue, 3 Jun 2025 23:00:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: disregard NVM checksum on tgp
 when valid checksum mask is not set
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>, Vlad URSU <vlad@ursu.me>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
 <23bb365c-9d96-487f-84cc-2ca1235a97bb@ursu.me>
 <03216908-6675-4487-a7e1-4a42d169c401@intel.com>
 <47b2fe98-da85-4cef-9668-51c36ac66ce5@ursu.me>
 <8adbc5a0-782d-4a07-93d7-c64ae0e3d805@intel.com>
 <20f39efe-ba5b-44b2-bfe6-b4ca17d6b0c1@ursu.me>
 <1e92a26e-1fb9-44bb-86df-8007cf9ee711@intel.com>
Content-Language: en-US
In-Reply-To: <1e92a26e-1fb9-44bb-86df-8007cf9ee711@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> If no update is available, perhaps we can consider ignoring the 
>>> checksum on TGP systems if one of the following conditions is met:
>>> 1. SW compatibility bit is not set (current Jacek's approach)
>>> 2. The checksum word at offset 0x3F retains its factory default value 
>>> of 0xFFFF.
>>
>> I am already on the latest firmware. I have also tried downgrading to 
>> earlier versions and they have the same problem.
> 
> Ok, so in this case I think that we should go with option 2.
> 
> Jacek - can you please add this check to your patch?

Yes, I'll prepare v2 by the end of this week.

-- 
Best regards,
   Jacek Kowalski

