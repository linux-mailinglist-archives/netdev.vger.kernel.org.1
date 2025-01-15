Return-Path: <netdev+bounces-158430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9686A11CF5
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EC416336B
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA02C246A35;
	Wed, 15 Jan 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrEai8Dz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A295246A0E;
	Wed, 15 Jan 2025 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932155; cv=none; b=JzZzLPaaQNFzdNgn5M4dMWVJVrZeI8924DY5Z0NChct+o4KxSW+V5kUUPs84hQacMXxRJmjaCrDQy7XA/OMf4fNC7Sc1Lr1XKHu1O8aiL6Y5GEvwSFW4dVqKZIVlZTRkiUuqGglN0azkyT9JlpUTt1qI5VaqinTcl9t3iVbdQLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932155; c=relaxed/simple;
	bh=Yfxhe29O/qlnSI3nwcCqFA57vArut96fC+BHmYETDhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRekLa4xZkDRT+Ow5jryxz3qpTzN90SDKl7mDgfrgVfbsNtUuOqxTh26O3uhSyIrU2slWYy6L9dZGPbEwFmjf+sN6o5x4Tn2JNvUen+ZnzUUm2GPgS7xpB8mNgvDqLgHP4MLV5Z47+GFkSmvKEdx6HFC0GN9JOw4kp1FjExml9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrEai8Dz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21654fdd5daso109944595ad.1;
        Wed, 15 Jan 2025 01:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736932154; x=1737536954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZu3RRCSZ6fAo+lWLsGDi7lH9XSyk6eapVHs6gKrrgo=;
        b=UrEai8Dz+MTsHE5oMs4e06nwZRENWwCAu9Yziwy8ThQ3aW/m5DaZDn9W3cDiKeBQEO
         9em8TkuWx034vULeaOMf8IiBpzvgVCURpxmSLPohMS9G3NRmk++tJDb7meGQX28u4wOX
         Zkwi7pSj4Hy0Vg5h4mLZaWuTOEJPE2ANR8JZrhHnAS6QhHRbKv75LWh/toNQWxfSQVjV
         k34O1CvFlxU0avWRnNCeIpmsmRdr57ogX0VTLUjs6Sc9qnNSON44OkUEqZh+/Fuihj8L
         capl2mRW31JxSYOrhshGwHZ0odbSi19vujcdBHgu5ZxBy5CV9JmnATvwL3PZhRybbgIM
         uYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736932154; x=1737536954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZu3RRCSZ6fAo+lWLsGDi7lH9XSyk6eapVHs6gKrrgo=;
        b=ezeGVMiOMqbvMdf6yUTIqxuxKv0ii7uSvMs0eKq3Z3l4L6cCb83aRKkB1l2/+72Tj+
         hgZpq09D0y5ZIaQ+g0dVT2MuGuSkpoxMaI738DpESKPPGY/EIussf7PVOqKSMOenS6Z3
         3BfLpavp+Ew7E/yK1dqMghvF2sZEg8EZisW6nIewmqrsOiv52TbrjzVccB8R0ofR+Zrk
         2KDrtkZOhF9qvaU4RBTyESNl+7WyPWR/i1JEXcQhf8hRqVNLL9UMQsiy7p4vNcEg95kZ
         AoPrdhQQu57c5uY9b0LsEHcxB3cu0t4LoMjJPgmzxfcY4DYEMD5VGit7z2n5Uc76SFCm
         VSyw==
X-Forwarded-Encrypted: i=1; AJvYcCUx0rJ3anDXeINVbu2JcNLHwwYmMpBVW4WjR8UGdyfwnR5qFr7PcEHM/CEKtAsDQJftQV5Aff8rB9r4C7T9@vger.kernel.org, AJvYcCVtQUIuFxkjHsz3JH7gGP82wbRcQUeWz594eNFjjBx79tq0FeFqK8hTmqTQgz4uTfN9+LsglB8S@vger.kernel.org, AJvYcCXSqhJBUpu1sPmJyzktQTLnL0clpfc4QQnM2mpORsUr1AdsO46UkFgYj7NPFG5d7aeRSSf3TJrmVCwp@vger.kernel.org
X-Gm-Message-State: AOJu0YywdnbzrvqZsc+juHpxiEZdlNrKJLqisx92FiR/l4OXRcgvj0We
	VL07162XVGa60hQTvX4VE/R/SAs6OokzJqN3jli6OuxkQgF9c8Mj
X-Gm-Gg: ASbGnctE6DI0kxjm+lvdEvWWAIcEFKGUBPjil7XOjs/qdzryH2KTX9Kblx9EKXCNPBh
	+48SHLdQiZA5+WxgXqIomb/qKsR5mqV6gFyWibRqWil1UPrraszM1ckvQNh8kuz6B7M7vM8sTeh
	5yspkvaXk5xFCmuTcthcRBsr/hwgeNg9FcrONMNzTr+oKKbX+i+g2MuHEIddARgVTwEQzSInNaL
	tqAycYTSMqN5IeCYHBU//t1SyGX0JtLjSQbalOIfRbIctk1ee+QqTHrD3bBx3R2QvH9Tzdmb8LY
	5OJAv6Y3K2kTF2Yfgkpd9nBmcINECcgWgGk=
X-Google-Smtp-Source: AGHT+IFzyRepggFFHtQT8D4fkFN2tkBOOiPSmaRhjKsx+myOrF3U4xxdVBjzw1AHpDW/+2qMjfDQIg==
X-Received: by 2002:a17:902:e747:b0:216:3c2b:a5d0 with SMTP id d9443c01a7336-21a84002a70mr352529525ad.51.1736932153585;
        Wed, 15 Jan 2025 01:09:13 -0800 (PST)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21a21csm78826285ad.109.2025.01.15.01.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 01:09:13 -0800 (PST)
Message-ID: <72e993f1-bb8d-43fb-a9cd-210f1f8f02c5@gmail.com>
Date: Wed, 15 Jan 2025 17:09:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com,
 Andrew Lunn <andrew@lunn.ch>
References: <20250113055434.3377508-1-a0987203069@gmail.com>
 <20250113055434.3377508-4-a0987203069@gmail.com>
 <20250114153323.527d4f63@kernel.org>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20250114153323.527d4f63@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jakub,

Thank you for the reply.

Jakub Kicinski 於 1/15/2025 7:33 AM 寫道:
> On Mon, 13 Jan 2025 13:54:34 +0800 Joey Lu wrote:
>> +	regmap_write(bsp_priv->regmap,
>> +		     macid == 0 ? NVT_REG_SYS_GMAC0MISCR : NVT_REG_SYS_GMAC1MISCR, reg);
> This is a pretty long line and you do it twice, so save the address
> to a temp variable, pls
Got it!
>> +MODULE_LICENSE("GPL v2");
> checkpatch insists:
>
> WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")

Understood. I will fix the warning.

BR,

Joey


