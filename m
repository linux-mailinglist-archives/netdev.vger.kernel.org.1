Return-Path: <netdev+bounces-48764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D97EF70C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF901C20AA4
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597CE30F99;
	Fri, 17 Nov 2023 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EUHekREu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EEED75
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:37:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5094727fa67so3201497e87.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700242628; x=1700847428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qPWfawxMvCCwqgwMcoz01kVUlEDZwsGaKlCMKco8RAs=;
        b=EUHekREu0jCPjysi23dKCma4wjjQv4tXXanOI7xgbWblA++fHFQ0InQxfh/3OGuUy+
         mgO/NfO3oC49RDpqkLjSJ0+FaLr74gQ+lbjuCsvkYtyAJL0Uhhg7huTZzyzNAAeAkBzy
         cIv3nvmf+JEHvtCsu4sg3h21Ma3C6YCnf9p4qs2RI/YkibdqPY+Z93eZCF8iYtqQ8qFQ
         5McSAU8KeTfaiUUAqIXr6eyYGdouB2EheCP/XunFKg79wdGFKk077ylOXp2TfY3Ms8w7
         /Ovdd6iRjz5D8TMzbtLGCPLY2rgbaVemqhZ7745y3vzPCW3I/f2XMWvpeyF9JKMrU3hn
         mRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700242628; x=1700847428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPWfawxMvCCwqgwMcoz01kVUlEDZwsGaKlCMKco8RAs=;
        b=Gj+XWtSKyFF1qXnstvP7xTAYa8u9e2a/JkcamubsoKjaIib8Y3TPz3klVEEQSAnuhe
         Ud2PzDAx+8C0y8Ic7FCOtFS/2ViU5qgU40/qtr9r23PvurCo1W2Mhzvvbwifs41yR1v3
         frzoCqwKXMSLULAuiEgkSvO9W8ZUQmRgZLvB46auu939MFyxawUvSVStNNqjk070ItTg
         982Q5JQ1qHtLdZmN5V1oPEm3SufSLrugR8Pr4BLsyErvYcCoWv5YeKauNtr2PCD06Ide
         e8NpWeW8elAW6MK56p6YrWWMbF77P+9583fv0Th64x5MrKLMuzOy7kkRKzzL+gHLpk4z
         2kMg==
X-Gm-Message-State: AOJu0YwSNQMQZkV4on6VVvRzJ5qxz12geX4QYdurwF08DAWENq/Bf4Hf
	aPsaCyOO88zNu/gk3q8KkuMpeA==
X-Google-Smtp-Source: AGHT+IG8vNGCKqG775W9hqhVbWFrKq/2354SflCixUg3G4oiDXO4NcB1WZozj6WQ/9GOg8GMkwEY4A==
X-Received: by 2002:a05:6512:48d6:b0:509:49f1:b7c8 with SMTP id er22-20020a05651248d600b0050949f1b7c8mr211662lfb.21.1700242628451;
        Fri, 17 Nov 2023 09:37:08 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm2918402wrs.26.2023.11.17.09.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 09:37:07 -0800 (PST)
Message-ID: <f41954c0-e303-4d6c-b308-d0dfd00ee251@arista.com>
Date: Fri, 17 Nov 2023 17:37:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 net-next 23/23] Documentation/tcp: Add TCP-AO
 documentation
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski
 <luto@amacapital.net>, Ard Biesheuvel <ardb@kernel.org>,
 Bob Gilligan <gilligan@arista.com>, Dan Carpenter <error27@gmail.com>,
 David Laight <David.Laight@aculab.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Dominik Gaillardetz <dgaillar@ciena.com>,
 Donald Cassidy <dcassidy@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Francesco Ruggeri <fruggeri05@gmail.com>,
 Francois Tetreault <ftetreau@ciena.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>,
 Ivan Delalande <colona@arista.com>, Leonard Crestez <cdleonard@gmail.com>,
 Mohammad Nassiri <mnassiri@ciena.com>,
 Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org
References: <20231023192217.426455-24-dima@arista.com>
 <2745ab4e-acac-40d4-83bf-37f2600d0c3d@web.de>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <2745ab4e-acac-40d4-83bf-37f2600d0c3d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Markus,

On 11/17/23 13:07, Markus Elfring wrote:
> …
>> +++ b/Documentation/networking/tcp_ao.rst
>> @@ -0,0 +1,444 @@
> …
>> +                                          … failure. But sine keeping
> …
> 
> I find this wording improvable.
> How do you think about to use the word “since” here?

Nice, there are people who actually read the docs! :-)

I'll send a patch crediting you.

Thanks,
             Dmitry


