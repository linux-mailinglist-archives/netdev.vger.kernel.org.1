Return-Path: <netdev+bounces-204903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518E1AFC727
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325E17A2232
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D07A22D4DD;
	Tue,  8 Jul 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="it+bR7l3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD0220F5E
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967293; cv=none; b=K04xuegcPhGLZtxY2yD1hnLX0vOfeOCMQssCCFexc0lpdsz7yVjIwFLB+rYWExLrKX3Dh2HSBFxfLIkVGp7PKrB/NYlla9aM2Ykh569oYXXKyanjbTi1gxHmRbb3Q1QKQbx9XrFQcUBMzvKpWPD6mlH/7XkSmytrh4Jyt0YGNTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967293; c=relaxed/simple;
	bh=ak5K2cyoukCuIau+l0rdV20VMA+IDfzIfc4FbUs0WDs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m7emt4ORWsXD3KZM3IiMju6omGsa2Sg1x8os7HWur3XPkfA0NGfxftxA9dDlFx3yGs1/nzI3Fzuw7uaNEedYAoqC2zH3tCY8YvvO6jbfU8b26sdAn68E3Wzm5fppHYQOONoEnxqidMiU+e1NQbbZ/X9ndLPFaICL8rdtL+I5dAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=it+bR7l3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so709384466b.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 02:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1751967289; x=1752572089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X0wqIKyfiz9E2nC0D4l4R/OYaIRzSGCgL15hXxtZO5Q=;
        b=it+bR7l33FEt0VitTxYEVgavmorz7+lM3Ca4hoJa963hXDnBU0xq3/8LbUhiU5Gszs
         Qh1l8+TpW6sx3Fpd68MLxsf/OESdOCQYmRpK+rzNzKKDnCn3CAmFNCfW8o4R1sBb0pz2
         UCk8ISZZXweb1Nb+GKOSMWpUrZdOCpOAt5g4Fv8q/Nslm5Eg/B2xgH6DJVVqSB7QUXPc
         IlOuBVp8vUVCzx4CSn8GFMLNrkiKehLR/0aUP6myeGbIWn2sZqp2Ri64AAAWVdaGf2eC
         AFGB5vh2Cx4YLT/pyqAYD2fWAvJc0rVQWZcODH8DJLMKFIa5nircQ8WNQWtvvR8MS4Po
         tmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751967289; x=1752572089;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0wqIKyfiz9E2nC0D4l4R/OYaIRzSGCgL15hXxtZO5Q=;
        b=cmEEwPA6ShPIjI/EyLjVEdoNq5UfGdDWlYR4DAX87PHb7D3fxHkDMoi4Zxn4R0xmzX
         UjJAMg/KGmR+u+wWX1RqbYIAAxzRY6/pFO3OQJaqxPns8n/xEvJTMG6dVDg00aLsCd8n
         SSokLPKyQeD1boUb006lXDhj15GbskYLqcUxmjO9QJ0JBjh+qRlCN50bAukhokz6AMxu
         YXUWp/iiaIXEHjlST0uMuNloaov9T9CKH3g+HnCSLmVzYHSH+TnH9FCBrYs9qBmKiDzI
         y0E6j/1w0q23eKw8RZFjmda64qKzRzFO7HmKo5jvFVnBgpNDxSnpZKSWgfSuQg8C6PtQ
         f8rg==
X-Forwarded-Encrypted: i=1; AJvYcCXK4PVQFhK2Y7gzu2K6Omdgu7WT6M2U9lS6fyEpPH8RyK3uHaTVuA6E32GzYvOApEH3LvE4gZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBi68n7zFVGkiXrZLJCgeSbC9G/wXfSGF9qQ14xFnAzitT7iOQ
	G4HX2pXDlmcT6wo8hJpvcf21pwlCMfReglpqDJJ6hMWmhyxwu/0gTSyPNPQFDluh0A==
X-Gm-Gg: ASbGncvFzO9YMyg9fjZaE5qBvOpBmsS0knXZHUKjCiprvIhFA+ZhUeCPMKJpwjfTVUG
	AqOp6d/PImiIdeU+pFrhwgXAxrsLUHJ/BmZNUAzVZGdXuAuI7DKiHVdfuSgVsxTHfN9Xpnl4O8h
	udeCAVSxJSx85e+zRquLds6PZYkIS9pg3Qjv7MtFoLgTlXdS91d0fAy0bnr6zGMYp/02Vv8HE8k
	m4dMvi/Ncb1xJqi7V835L+4Vf8ie6pOnOGA0F6QKEnllIV24bvL8Ma5NwZJxNMqvwnwIMIo69sG
	7deytkW2A7J0glClQWKwXZUjO/aqYYiHYBeYE284KrbPAIBOYurugAnE6Q7J1B1N
X-Google-Smtp-Source: AGHT+IFFxKIDljWecarxI82gyEkU8FVLu9l9gNqGHicZF6D2RYECCVrdKrxL2M7d0nFqgkB0aRJAZg==
X-Received: by 2002:a17:907:3f92:b0:ae6:abe9:8cbc with SMTP id a640c23a62f3a-ae6b055ea10mr245460066b.12.1751967289550;
        Tue, 08 Jul 2025 02:34:49 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae4113013ecsm630494966b.58.2025.07.08.02.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 02:34:49 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <b3273f0c-c708-488e-88c0-853e4e8e5ed5@jacekk.info>
Date: Tue, 8 Jul 2025 11:34:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 5/5] ixgbe: drop unnecessary
 constant casts to u16
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
 <33f2005d-4c06-4ed4-b49e-6863ad72c4c0@jacekk.info>
 <IA3PR11MB8986B9D474298EEEFA3C57E5E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <IA3PR11MB8986B9D474298EEEFA3C57E5E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> -	checksum = (u16)IXGBE_EEPROM_SUM - checksum;
>> +	checksum = IXGBE_EEPROM_SUM - checksum;
>>
> Can't lead to different results, especially when:
> checksum > IXGBE_EEPROM_SUM → the result becomes negative in int, and narrowing to u16 causes unexpected wraparound?
> 
> With this patch you are changing the semantics of the code - from explicit 16bit arithmetic to full int implicit promotion which can be error-prone or compiler-dependent /* for different targets */.


As far as I understand the C language does this by design - in the terms of C specification:

> If an int can represent all values of the original type (...), the value is converted to an int; otherwise, it is converted to an unsigned int. These are called the integer promotions. (see note)
> 
> (note) The integer promotions are applied only: as part of the usual arithmetic conversions, (...)


And subtraction semantics are:

> If both operands have arithmetic type, the usual arithmetic conversions are performed on them.



So there is no *16 bit arithmetic* - it is always done on integers (usually 32 bits).

Or have I missed something?


Additionally I've checked AMD64, ARM and MIPS assembly output from GCC and clang on https://godbolt.org/z/GPsMxrWfe - both of the following snippets compile to exactly the same assembly:

#define NVM_SUM 0xBABA
int test(int num) {
    volatile unsigned short test = 0xFFFF;
    unsigned short checksum = NVM_SUM - test;
    return checksum;
}

vs.:

#define NVM_SUM 0xBABA
int test(int num) {
    volatile unsigned short test = 0xFFFF;
    unsigned short checksum = ((unsigned short)NVM_SUM) - test;
    return checksum;
}

-- 
Best regards,
  Jacek Kowalski


