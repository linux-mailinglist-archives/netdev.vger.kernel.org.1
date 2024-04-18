Return-Path: <netdev+bounces-89210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E68A9AFB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1BF1F216D1
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C5156F54;
	Thu, 18 Apr 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+DG6OeE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA021E4AD;
	Thu, 18 Apr 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446142; cv=none; b=Dm47GueifnZ4Y+1eO/7s9zedOuN7ZqN86AWF3dTglKaLN91y8M4i84be2u9TNqrwozcggTkREWq094nJYPN/rY2derycignXFkc+AlJnaTdqcVm47ksZfqRGUgC2LwJBJAedxbbVmqIddVoAk2lVIC0+2hzJsbSKRia5nUCvkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446142; c=relaxed/simple;
	bh=S1Mfc7JLzYMrRlV9SGrwBV28wGetaZRsdp62jkhhWVU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Rs0nE6dyV36mbFrb2RIgpI0RNzNLw16ZObcGh1PlwB3QwFf8vMAqXaj4oB0Dsam0QWzGqJ0b0AoJ+TS39XBefX1cwYnIC9hxBq4CTF2AfCFdcKJAIFulOKHjgWUoSnz1WvQTCLfMJZfsnnkPTofWOyCUJiXfX623/0Mcl5KKTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+DG6OeE; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5f77640bd44so161736a12.2;
        Thu, 18 Apr 2024 06:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713446137; x=1714050937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xyDQZvtX6hwPdvYyLnXnAARB0qInxjzOQtaTRIcWQA=;
        b=L+DG6OeETciRBglfSVY0F2E+8pQhotNk/tS5dCvQmTqMAULktnM1dbhkBSbdXN80aW
         S3WzKJsoeq6qiUHgocyKgPknGsHUkiwTgXJVECrksCnjz8EdpBTC8WJmEeeyNaa8tn7N
         L5BlThIuyGJ0qx344gtlmm8W/k8Vjv9EF2DA2BUbIWvR/9Z6KPzpdYg0lbd2VmFH6ycw
         F00b0i7JHLZhGbh1WHUUWKu6q6DtFW8mdQoNMPHxgw0nmXXFRfKUrq3pfsvjHoPAizfK
         J6BxreFbAt4xplYGEBm48mw1Cwxk+wUvxVEgGfgvSoFMXFrRjQVK9Wa+6MR46jr57kv6
         n2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713446137; x=1714050937;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5xyDQZvtX6hwPdvYyLnXnAARB0qInxjzOQtaTRIcWQA=;
        b=Slemjh8B6YPskNbVBcVklSObCxSFu0VsQMowy+gSZcniokURdDdA622luvQ9i2AdZV
         Y65Ech6AYQt5KYwsNPN4gd6tQF2RfmUBD3tlVR353SQ7F4CNWdedjpLHBuk6DdQf0doi
         a7KFxgZNjp546UgP890y00ZMD75yfinwnLgW6gBkaE6hqzh0vloykaK5pKdAFx/IeQH+
         ET/v7N3cLYftZIqM540e9u037iIDC2vFS+uEw324+4fp1LS3zIu+CJI2ZJ3U0GvJ0TMU
         pxZSJ9BZClC4sapgjVk6dBQC39t1Eyk3IddtIyffxOSaGNPTRhNOEtEj8AeLl3GVoAit
         rrNg==
X-Forwarded-Encrypted: i=1; AJvYcCUSi63/5ZGpSOa7kUHLsD97JTEVFtd7BPB2wYoflXwtVAwgbm4ybf5L8ELnkYIS2+I2EB+y7lF9dHX1A7b8/U5ktA107zAo/Ouk2jGSjKzxA/loayJS2CcLqEXOCSHjmkQet6z7hds=
X-Gm-Message-State: AOJu0YycQ9XPoSu0Wmel8AwYsjdnlyzCAA5mRks/Pyj567mRbZtiVila
	+hFUTZW7sQNRIFbCbywBaUJAHOMb9HpuYv8FKeR7PLMlXcb7EO6C
X-Google-Smtp-Source: AGHT+IH4ncT1azi09Hj2Yj0RKU65VF/XIJ9wg5JbHv/ZJiVTjqU7iiBJKAp1L1mYri1i4eUxtT/CEg==
X-Received: by 2002:a62:5845:0:b0:6ec:ef1c:5c55 with SMTP id m66-20020a625845000000b006ecef1c5c55mr3458872pfb.2.1713446136904;
        Thu, 18 Apr 2024 06:15:36 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id jw31-20020a056a00929f00b006f09f17fa9asm836600pfb.113.2024.04.18.06.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:15:36 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:15:32 +0900 (JST)
Message-Id: <20240418.221532.1329700378176129871.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH net-next v1 2/4] rust: net::phy support C45 helpers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <92b60274-6b32-4dfd-9e46-d447184572d2@proton.me>
References: <b03584c7-205e-483f-96f0-dde533cf0536@proton.me>
	<f908e54a-b0e6-49d5-b4ff-768072755a78@lunn.ch>
	<92b60274-6b32-4dfd-9e46-d447184572d2@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 08:20:25 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 17.04.24 00:30, Andrew Lunn wrote:
>>> I think we could also do a more rusty solution. For example we could
>>> have these generic functions for `phy::Device`:
>>>
>>>      fn read_register<R: Register>(&mut self, which: R::Index) -> Result<R::Value>;
>>>      fn write_register<R: Register>(&mut self, which: R::Index, value: R::Value) -> Result;
>>>
>>> That way we can support many different registers without polluting the
>>> namespace. We can then have a `C45` register and a `C22` register and a
>>> `C45OrC22` (maybe we should use `C45_OrC22` instead, since I can read
>>> that better, but let's bikeshed when we have the actual patch).
>>>
>>> Calling those functions would look like this:
>>>
>>>      let value = dev.read_register::<C45>(reg1)?;
>>>      dev.write_register::<C45>(reg2, value)?;
>> 
>> I don't know how well that will work out in practice. The addressing
>> schemes for C22 and C45 are different.
>> 
>> C22 simply has 32 registers, numbered 0-31.
>> 
>> C45 has 32 MDIO manageable devices (MMD) each with 65536 registers.
>> 
>> All of the 32 C22 registers have well defined names, which are listed
>> in mii.h. Ideally we want to keep the same names. The most of the MMD
>> also have defined names, listed in mdio.h. Many of the registers are
>> also named in mdio.h, although vendors do tend to add more vendor
>> proprietary registers.
>> 
>> Your R::Index would need to be a single value for C22 and a tuple of
>> two values for C45.
> 
> Yes that was my idea:
> 
>     enum C22Index {
>         // The unique 32 names of the C22 registers...
>     }
> 
>     impl Register for C22 {
>         type Index = C22Index;
>         type Value = u16;
>     }
> 
>     impl Register for C45 {
>         type Index = (u8, u16); // We could also create a newtype that wraps this and give it a better name.
>         type Value = u16;
>     }

C45 looks a bit odd to me because C45 has a member which isn't a
register. It's a value to specify which MMD you access to.

