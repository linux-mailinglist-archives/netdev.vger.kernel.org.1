Return-Path: <netdev+bounces-211169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E67B16F9B
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9E67AAC41
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 10:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEA222A801;
	Thu, 31 Jul 2025 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="0bcLZnU3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1372264B8
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957871; cv=none; b=oZJqnxFGmlH6IoW4uLLffYa4Z1gf1WQ+yWkubvNFyCRgpPYNnwrcZTmxC2fOefYY/LAy2CqRCPwONkJfnWrOfuQYeMdZwsCfOxnd9S83/4zU9nSzPNCl7gZkP/viW09n2ickDNbp4szjy5J02JvGbMVasm8fr4QANyPaHdgUaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957871; c=relaxed/simple;
	bh=ZUDRaqnU24X+T7uVJpSv5R4hg3CFDsxJ4xG56N/y4Qg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QALa5ot+AaMF4hNVBngge0UQxoET6J36LEcPIUzhK+DhZPAHKy1ssXsdYc0KExZY3bTMXzVFKZ8mnDe8k4MHTHDSK7456HN2gZcyT8cb27XwSdrkwkUSwXE4JADa0vc+n91zubNSKGtBYywwhreBbIyD4xHDUf1b56hz2S/pG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=0bcLZnU3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61539e2065dso3014490a12.1
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753957868; x=1754562668; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4guNMFO2mNbUVAujgFMPCeQwDaxzkTETmATTN/1vzk=;
        b=0bcLZnU3r7oR3VeHpMNKjhZCr4QAam/3A7YxEhGTUYHWnkjIT9JTOfEJBRIpxMjkfW
         D0mkWCxlYVSS4JfIC8MM6WBrzBZNCzrOS+BecYrKfvzPu2UIyh1pPgzyCIDtEUZvVd/e
         UpNqjOZVzSl+xdLOEfr1d+sHMajDBmGPC/HIcDA4J/jCWeyWDZKJrUiQuTOGhkjT++T3
         0mQsudHeb+EY2jZcOdX8MPll9k9iLMz31MI4BP34ObVUgDEaw32dg5foXOEMMqJf/vwP
         7FtmkuVa8AFUrX5/EydyDNVXWz+fwQYDlIjp0we3zN/WKgYUjBAYKP8Z/nkhb5uf73pV
         bWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957868; x=1754562668;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L4guNMFO2mNbUVAujgFMPCeQwDaxzkTETmATTN/1vzk=;
        b=K+GL9NYvq8BUs/ffjAzUjw9huirre5o0vInNOt8Da1dJ8epCDsqvLLIe+aMd+aAPLy
         kLyaP7a7rAeuWk9bumzBmAZR3ijz+DOIIkX0HI8cOXkAfDkKorg8pWfxa6PRBxvNyjvl
         ZoMm9svftJPS9DadBq4cXE2jtm6mfwGxf9t+nJ5VpX7MMH3cS277pc45tZyeAwz1Rr1z
         L4NQ43AhjxaV2L743zGLBdAgeQyP0JdJ3WQX5k0bsZYHWc+iGW1bIFk1t40wk+OH79Hj
         E2f2cvYX2OJH85uCg7jgRimIMuZBV2XZF9EEUZlxv0b6bVT4kXLCWUZj51gLugHQzs7f
         NzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWclexnyHFTIR4/aOge9+wOx7rSP4BFZbbSS3Q9XCMWud6YIO0f6ucSeQ0JRLKaYg7bk+zFO6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9eDQrVSgKdqvv2Zhtq1+zLBLzz+XmbYVNHToDad6DIWYbqQP6
	4d/YN0fzFJm3tFae4ZQtw3iqeiMzi5HBKeOvhoizF/WhVs79/esSiXI1XsOwQn7UryI=
X-Gm-Gg: ASbGncvyNjzJEjuA81QphE/DlZ5kPE2rT9SfhuBTnDTRIAG7VipTECXxyY+9u+byo1r
	+vN2uDquj4e/2jStCfS8FKeX7lEPyBwiqa+vAn9AEAuLAMqfK51uhoI54LvU0I2WyBbRALHEU/w
	axIpJIvSH18Kl56SPzpTuCx7IA7oXjSZZABKnpAWxB+a5hN4NrhYBf4/9dWJOxka9U5blQsUvuu
	TmJudeV7it6VMJwRuCogHA61bi7UO37+TmQnKUDluG0pPPnObUssX7iY7fkWbYehTrRYYAzHCnp
	bs3Ku4FG2JPjbb6dyRoYQk6sJzqNOJBq2elLF+6beep6Xz67TdQNAQ8Z2eRr83QyERgs7MZqja7
	vFQlOKvR0T/h9GMVHQTOqRUluAr2jDTF/k0FWC1XrzSZR6lppjMgerjQczLxK1ADQE/h2IHedC+
	g2Sg==
X-Google-Smtp-Source: AGHT+IFmHbj//ifYv0ps4iK3o2MK/SZVcRme2djqmVaHUnfsmz5EX4ncIp+nUgle+xZrZADbwlYiEw==
X-Received: by 2002:a17:907:2d28:b0:ae9:c8f6:bd3 with SMTP id a640c23a62f3a-af91bc55e14mr166781766b.7.1753957867841;
        Thu, 31 Jul 2025 03:31:07 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f25739sm916887a12.21.2025.07.31.03.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 03:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 12:31:07 +0200
Message-Id: <DBQ668L792QL.2OV5Y4G1PDZLR@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ipa: add IPA v5.1 and v5.5 to ipa_version_string()
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Alex Elder" <elder@ieee.org>, "Alex Elder" <elder@kernel.org>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250728-ipa-5-1-5-5-version_string-v1-1-d7a5623d7ece@fairphone.com> <e07f0407-84e1-4efa-868d-5853b7e9ab4e@ieee.org>
In-Reply-To: <e07f0407-84e1-4efa-868d-5853b7e9ab4e@ieee.org>

On Mon Jul 28, 2025 at 5:53 PM CEST, Alex Elder wrote:
> On 7/28/25 3:35 AM, Luca Weiss wrote:
>> Handle the case for v5.1 and v5.5 instead of returning "0.0".
>
> This makes sense for IPA v5.5.
>
> I have comments below, but I'll do this up front:
>
> Reviewed-by: Alex Elder <elder@riscstar.com>

Thanks!

>
>> Also reword the comment below since I don't see any evidence of such a
>> check happening, and - since 5.5 has been missing - can happen.
>
> You are correct.  Commit dfdd70e24e388 ("net: ipa: kill
> ipa_version_supported()") removed the test that guaranteed
> that the version would be good.  So your comment update
> should have done then.
>
>> Fixes: 3aac8ec1c028 ("net: ipa: add some new IPA versions")
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>   drivers/net/ipa/ipa_sysfs.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/ipa/ipa_sysfs.c b/drivers/net/ipa/ipa_sysfs.c
>> index a59bd215494c9b7cbdd1f000d9f23e100c18ee1e..a53e9e6f6cdf50103e94e496=
fd06b55636ba02f4 100644
>> --- a/drivers/net/ipa/ipa_sysfs.c
>> +++ b/drivers/net/ipa/ipa_sysfs.c
>> @@ -37,8 +37,12 @@ static const char *ipa_version_string(struct ipa *ipa=
)
>>   		return "4.11";
>>   	case IPA_VERSION_5_0:
>>   		return "5.0";
>> +	case IPA_VERSION_5_1:
>> +		return "5.1";
>
> IPA v5.1 is not actually supported yet, and this won't be
> used until it is.  Only those platforms with compatible
> strings defined in the ipa_match array in "ipa_main.c" will
> probe successfully.
>
> That said...  I guess it's OK to define this at the same time
> things are added to enum ipa_version.  There are still too
> many little things like this that need to be updated when a
> new version is supported.

Yeah, my point in adding this as well was based on the comment there:

/**
 * [...]
 * Defines the version of IPA (and GSI) hardware present on the platform.
 * Please update ipa_version_string() whenever a new version is added.
 */
enum ipa_version {
    [...]
}

I previously only noticed 5.5 being missing, but before sending I double
checked if anything else was missing and found 5.1. So perhaps if 5.1 is
not going to be added anytime soon, we could remove the 5.1 definition
and the rest.

>
> Thanks for the patch.
>
> 					-Alex
>
>> +	case IPA_VERSION_5_5:
>> +		return "5.5";
>>   	default:
>> -		return "0.0";	/* Won't happen (checked at probe time) */
>> +		return "0.0";	/* Should not happen */
>>   	}
>>   }
>>  =20
>>=20
>> ---
>> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
>> change-id: 20250728-ipa-5-1-5-5-version_string-a557dc8bd91a
>>=20
>> Best regards,


