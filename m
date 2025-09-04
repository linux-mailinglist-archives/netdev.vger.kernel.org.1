Return-Path: <netdev+bounces-219813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCE4B431EB
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02EE547A34
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853B24A044;
	Thu,  4 Sep 2025 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYEXIIsm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0971B248869
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965794; cv=none; b=DiNy17YrSJvfxk1T9nhYRUDHuOZigI/rhJQ3OxEVe+7Mpi8OSCIZp8bE08GvEefngZMg35l4qRleAoEtiY8JD99CWzXRVTv1L0dH3fYkOCO2uxwS46saaHxt3kVnFeMBsAtpnufZu13WKnfjVDOnzFxMZ7NxsnywqC/cXv13pho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965794; c=relaxed/simple;
	bh=ul16gl8P5splpgfMS9AuloAvXzeiJCfXNATBrMDdWck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4cJ7x8r2Fa3HzVJWK6NetRCcV4oA22KUyE5dfoiGR5kWEeGis6DUnenRZyxaJFFMiuIawlumIH8OxD/sVDIeJM5qP8DKCyxx0l3gmZkYYRKYd7GyOrMNxKhAUFN1x4AOyy137fFFt/VcW3l+9ebM5EvN9VmwvjtNufbYmmk5sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYEXIIsm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61e425434bbso1052513a12.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 23:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756965791; x=1757570591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVPg2qeIl1VYNj4SqJT/f6jtyBMBms1WA1Dy0Nue7wQ=;
        b=BYEXIIsmJmujwTeux8TiuuiDLoW6ELJ3DM653Ptl+CsTH4bQKnhx1yuVkQzVSVESHM
         Ja8fDrnTs4uY+TZMPJHMeGi14Xkt4IBh1Cfs3zbUoJz2LznlrqQ1GKmepTxIHSBuXE1Y
         IEN8dqRSn9xkAjNVK7ZZAYDwF72rpNQnYHYKQnsJMudPE1pBVd3e41qmfIgUbr9eXHQ9
         4X4vKiKrDv5jirgKlXMAg0HIC6wh3jD6hl8snNgeObRYG4wKO5W0kS4UMMmKHqQTJ54o
         u2Mp9TZxknAv3uAlrPPtLoEBFvk1/mf0JykzeYgcF4rw7688N6LtABhCIqbWW1rezCYx
         YaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756965791; x=1757570591;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVPg2qeIl1VYNj4SqJT/f6jtyBMBms1WA1Dy0Nue7wQ=;
        b=Cs8pq+dGLK9Cjiu29CBFCkWreyj4l/OT3QHDd6aagR7Ne5H3DaMaUOAA/gEXw1tV5O
         fHs5qEc2w1ig0bXq1ckUqfyxkWOOdq2lTZ9sAjo1RJ2fHIRE6gml0bz9nOXD8kYZ7YAM
         XMLDJDQ/BxQv5cGg5HWgC9vV0nZC6KWsnSji7tGQjZHC1o0uxePbEGFD0pkEAbPigzb1
         oVVpH6SrkNg6toBK/vYQGWVC+HvQmirKPTaYqlWzZ2hLzsjWHCigxySJRk2Pxl/KUNPw
         stIU9iy3oKK3VBgfU8shHI1LRjKnAZedG6S0WR2PN1lD6hfRn33kiGR6rGL5uESJyAZr
         pCBA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ8rgUGt1cSUMxhhBs6Yup6u3UXSDjWG/+j+lXcMcX7U/sglm5ytdNum5eYY4KhIV6AGTOtV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziotYuFjghrSVOb7VgHzxSTzo6yWMtjdgZHewifYTdsyGJEt7X
	sPjEb/5zOr3aSYCohXL9dKW/B3uzXdZdQ7n62kPA9KRJEJItNCDm5mge
X-Gm-Gg: ASbGncuCPSRQX625KV8TRLUzwsbQX7GrrDT5BNuxD1Hgx7JB3vGMdQ9ymhWOLD5A/rP
	M1t+va3w57UOea6x2qgz6zxBXy4fessHe6rwDBmCMSv52DfWJQkmIiBoYnNfCynhdk5jQjjynkl
	EdTW0WkkAfPECjapK1PvOcuNzTrUX/4C8FQhY34smakyuYfb/WpfcakOhHWh8zrgZtu0+95A+RK
	66S2/rWSAbrHbubR+QiPQ/b+33PcS78osHKZUiT4cqx3jc0xWWf99mY/BFPANnDCBxDDLK8yoAV
	rmza/H1s7+Ly6uCzCcy1C/kuE1DGl7XYg5ZHZpk954SvsrGNikFZ2bzf7exJIgwJz31O5cjotqZ
	ir+F1DTULyITsJWiPaNadlruWGzfnbUkoN1FqDQnlvYngN0Q8wPQ8Gb+vy9EqtobTKSZ0mmY8J2
	4Oz/wz5Ueo9idVAk7tp9RCmBKmoYJkUUrCbUj8NJRS99A8gJ5So1oEYlyy4+0=
X-Google-Smtp-Source: AGHT+IF5HOi5wOd8aDJKrCfzafdIrLfJVHtZx9IhHvjxxIoO0DuEabgG9Ni0Ci3UGbFVhw+nEbrk+g==
X-Received: by 2002:a05:6402:50d3:b0:617:c1e5:bfa9 with SMTP id 4fb4d7f45d1cf-61d26da4410mr16377767a12.33.1756965791090;
        Wed, 03 Sep 2025 23:03:11 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1f:b00:1062:8af8:2f20:2501? (p200300ea8f1f0b0010628af82f202501.dip0.t-ipconnect.de. [2003:ea:8f1f:b00:1062:8af8:2f20:2501])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61d3174074bsm10410087a12.35.2025.09.03.23.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 23:03:10 -0700 (PDT)
Message-ID: <d618cdc8-593f-43e3-8ac1-663e2d6617d9@gmail.com>
Date: Thu, 4 Sep 2025 08:03:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net: phy: fixed_phy: remove link gpio support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>
References: <230c1f83-6dac-484a-bc80-e62260e56e74@gmail.com>
 <20250903173204.3ca4969e@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250903173204.3ca4969e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2025 2:32 AM, Jakub Kicinski wrote:
> On Tue, 2 Sep 2025 20:37:02 +0200 Heiner Kallweit wrote:
>> The only user of fixed_phy gpio functionality was here:
>> arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
>> Support for the switch on this board was migrated to phylink
>> (DSA - mv88e6xxx) years ago, so the functionality is unused now.
>> Therefore remove it.
> 
> Sorry if I'm mixing things up and misunderstanding.
> There was a recent conversation regarding backward compat
> with device trees. Was it related to this patch? Is the policy 
> that we only care about in-tree device trees?
> Would it make sense to document in the commit message?
> 
This other conversation was about something different, the deprecated
old fixed-link binding. Wrt link gpio there is a very small risk
that there's out-of-tree users who use link gpio with a switch chip
not handled by DSA. I can mention this in the commit message. And yes,
my current understanding is that we care about in-tree dt's only.


