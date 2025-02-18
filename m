Return-Path: <netdev+bounces-167225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D6DA39370
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 07:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84CA188446E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 06:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AADF1AA1C8;
	Tue, 18 Feb 2025 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9dZgJs3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8A749C
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739860375; cv=none; b=fD/Onx82e6Z/rO/ZQKkWbYtb7OgCzi4p6gaAcLjdj2yvvd1hbPBajixvJrYU0rQoBx0ci6Nn2hw3ko1b4BtxC25T4CkCLonVs6uReYeKYcEdmu/EyBruXMZnDWISofm1x7Mh/m2C0OfQ/JBMLbLsLKtm+Cb/JAP5B56RIQ/RLGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739860375; c=relaxed/simple;
	bh=1FuOAYYMqYseSV9Ph1J6B2Tf8swSTytyB/KdlVEtid8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0Ugr1YUykwFmh3VXSu6uYFV9pBoKQGz18rRjsKZlt1SIIzDd6AxQHce1U6ad9EpfROIOVaYzoUOWAFubrgqE0zTjNIHEtLU/hyU1YzkU6Ij9rCddD8YIHYgIEkOfJ6A8+GYbSsRAaYvC1l765bQr197zdy9g5IDR5NfIBBG8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9dZgJs3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so9570429a12.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 22:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739860372; x=1740465172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g4ea/eGC7fAPrN7hvv1/Du9xFr+Gjkrn11i24IzkgKc=;
        b=L9dZgJs3LucCrp5QzkkPT3KIvFeDbQUNdeuESXpbrSwtAq3/o5nQ5/IMD1xfb5d89A
         /vcPWNtcvafZmneu7NoNQcYOBrAD3f0nDoM9wlqJ2OOro25y1BJ10rX4UJqAGR2nACTD
         VblM95fA+vJB55RzzOKFyWH5y7ui9aCmmDlu2XkJphzgxbUPze7WN5OvxdI0qk/M5XsV
         gTCx4FstakpqkZBP+MR6rx1YJ4q7562rIyjn1OGxX7Hj9NLrxlhBIeRrQ+Cq2OLB5gEv
         N+mbfChk6Xr8Uj9iQpALV/PNdh19pdi9ZUersa1yDGJhKvbY7WI5VUoDgbFURNwxxGcA
         lZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739860372; x=1740465172;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4ea/eGC7fAPrN7hvv1/Du9xFr+Gjkrn11i24IzkgKc=;
        b=t5QhvCIJa/vpDBEtWtlIn5qpiuq4BbIWrcnecM4R1Zj4fVy58IgqhrM0F++n4Cxpg0
         +0njP75w52ovqhjQPbNoUV9LMQDtTKuZRgeK8BBBYRrJiAKL2Fa4+H3jMo+BifQ11fv9
         kLWU/4RraOgytevkPEzLUpw3lPnsWSVpM7Q2j7NujLwMAfi20ggluug9XQIrVRLFu7hK
         AOuaQLrjeAaGUWcye62XCOzBttgHxjLWSHqUifLJWay/y7aEcdtEKwHZBpRi7Y2fht9e
         ucvG8rw/Nfd3Kp81ytkyK+mHMM9fH/Ue3GNCe2m/4CxIkVho0f3KziBgbuP+5ak3/3r7
         xJXw==
X-Forwarded-Encrypted: i=1; AJvYcCV21xoZs9/d/JldkqKqA+n63fCot6e+/UkOphvHg/R48SHjPiWXms3AjgbT7OWAFIZU/O+XvIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCTXuE23ZmiQnG0RLjpcejjGWoeIW0xbtqwTqV2ug1shd0sa9b
	8mvUeDJIz8BtQ2hMHQLJRqiFx/QRZwcYBSEe3C3BXL8T76xZtMM5
X-Gm-Gg: ASbGncv+dqJPN82QusRVyyZTAlPNI7JDedsD0lsSc7lKe3dbo5g8gOFxDJyaibGP9qg
	t3DXjaKjrOfNqPbK9cScjbT30wVKdImv9Vd/V5S3elMRtbYjgkn3OHhieCAQO4yLWLYKmpcWMhT
	8NbQMX2FxaRXqrUpETpNSZyAje+55aAkvyaeRBM3AQmgK/hhn+HpGQzQ1dF8Y5lTPSketKdPz0l
	YTND2V0kPW42p1z7Tyv2kpmUirC1rM1gDXekOKihKqaqaMOAStOLP6JzApFZ4ZgL93zkpD+RL51
	ki4xZOkrFMfrXt2Mf/SICwV/qaPHexVtwu5Wh/6jOg0k7BYUfwEZXgmFeNbr2cOYGppwQm4IXjS
	XeXdfZUUiRVQnstpoq1+7+RKsNpv+joyYMLanjeaxzDpEq2k0xRAljLwU7Ib7rcTA1FcLm1fmiS
	e52hbrHfg=
X-Google-Smtp-Source: AGHT+IHaDUTT7r4U7n1kifHffV458t/pNi8Rl5Uh9GebcguP+cR/fmyuGmdfrzHZ7nhYV5O+FbHYmQ==
X-Received: by 2002:a05:6402:3589:b0:5de:5cb3:e82a with SMTP id 4fb4d7f45d1cf-5deca86c698mr21313073a12.0.1739860371439;
        Mon, 17 Feb 2025 22:32:51 -0800 (PST)
Received: from ?IPV6:2a02:3100:b23b:e900:e554:fd12:7e8a:5895? (dynamic-2a02-3100-b23b-e900-e554-fd12-7e8a-5895.310.pool.telefonica.de. [2a02:3100:b23b:e900:e554:fd12:7e8a:5895])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5ded69e7c33sm7229374a12.61.2025.02.17.22.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 22:32:50 -0800 (PST)
Message-ID: <31a901f6-02ed-4baa-902e-d385d1808f4b@gmail.com>
Date: Tue, 18 Feb 2025 07:33:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: realtek: add helper
 RTL822X_VND2_C22_REG
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <6344277b-c5c7-449b-ac89-d5425306ca76@gmail.com>
 <20250217164447.4d59e75c@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250217164447.4d59e75c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.02.2025 01:44, Jakub Kicinski wrote:
> On Fri, 14 Feb 2025 21:31:14 +0100 Heiner Kallweit wrote:
>> -#define RTL822X_VND2_GANLPAR				0xa414
>> +#define	RTL822X_VND2_C22_REG(reg)		(0xa400 + 2 * (reg))
> 
> Just to double check - is the tab between define and RTL intentional?

Yes. In the terminal a space or a tab after #define are the same,
not sure whether there's any preference from your side.
At least checkpatch doesn't complain.

