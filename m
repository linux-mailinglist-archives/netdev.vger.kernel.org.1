Return-Path: <netdev+bounces-94879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AC88C0ED4
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA90281C5D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3DD131180;
	Thu,  9 May 2024 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiksbtFq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6D26ACD
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715253925; cv=none; b=jbNk1iJjGrGC9hxq8IZsZXW8N8BzkHK+qRYj1/RFgwkJpHgXUNlgF62KVJYAQGQ5WqIrlIUrD6EKQkLDs9El6OSqV2TUKhabLyYUIvqcoy+WQHxB27omzGOqERSf6NK4okSgqUmhPPzeM0f0K1kl0pFcXR3rE76bRSWZtgeVjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715253925; c=relaxed/simple;
	bh=GwGoV5zTYPUnoFMzSMx+AcgXGXTGLUp1w2bhZce8+QM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lzgk9n0sUutYwMr3vw3WrCxY3fBsoWcK9cdoGMT16/20QLvp8OECDfwpGcFhM2G0UV4lgQUrXapeFa04sWlrjvRFzRBf/7kn+1XoMsQudi3Hg7zr4vjl/FjFT2jgCE+qeL86iV870fkJjp2CnSzVawOW7P3l0xaaDJZ10vTt3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiksbtFq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ab48c14334so240190a91.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 04:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715253923; x=1715858723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jGf4XFSyoCm6lCa28Ni5wKpiwXI8ZnxYGdoSsIE8jQ=;
        b=IiksbtFqf3GtNzONyah59FpUXlahlcNC/dB8SuL+tsczxGKPA1lrUaYrKfuRcevwR8
         KlZ5JYMp6yywF5q35gtnR5I1yNHETOHf5N3i+e84Qh4S7nOVv0VHNfOxafu6OJCRqDyh
         g6NkvLi1R+HQNWKxMQ7mMKVpB7KGM6Bu5weUk6x6tgU/v242bOdYLyuKtkz/dbmHJKEC
         UdmOXQfhV1CVpXfK8KjAkjt0L1LP9/5y3yWxi425ul/8ikDj8MMY7mEb0yrYJm+X85bS
         fzz+24Z8C3gddxJ5srd10CAcUKQxjpHrxCX2fkLzNvCI8r1j2klKTJ9ay06EWTnW07B2
         cj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715253923; x=1715858723;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/jGf4XFSyoCm6lCa28Ni5wKpiwXI8ZnxYGdoSsIE8jQ=;
        b=ISiOUta5WrcJGuud7csFGUDh57Uxx0yh7Hl/XjbE1qizH1n9LpazBUeIpgSc96d3Lh
         TL/r0Iq+kKlP/X5VER7V+RlHUiFqwohjMrZ5lLxyibdxbFwZs+A2SNGF28ERV7Vt8INK
         W2uXnrw00sYaY//iAP2YIInU7rx+OlaLJx9qbURPghvMpQM8DD1yo2QV4Twqa77sWzNG
         SvviMfrECkCVBUh0pO96bdU8A2DpqRRBgU4HonSFu3wutYFzbIv3dr9tS+azuh5GGC3i
         j5KjVy+Dpu+BIIW0q0uMJtGput2iIepreP/9A0QfjI8+C159HLlJTamuqqGadz+xpShD
         Dxog==
X-Forwarded-Encrypted: i=1; AJvYcCXm5lW0/4xagjtfaHTuA4nzFkkE/uUl5x+M0AcjtgD2ykzOwwpjrbOttA8odV3kBp/zkTnwLPYsNZSUI4j28iGtd2YeJ9Sm
X-Gm-Message-State: AOJu0YyBFbA1vkxDzYEo8WcII3+WUGZBYeDvc0sYxbthcwq3iMdLve4w
	mXsuSIBSBcFkOhIx10tBaZEJosi3QLPmvv95m8KIJohfHmHwRQ/K
X-Google-Smtp-Source: AGHT+IFRHEN8EE9alBa/ZqUjNruiEF0ybsuoC/8axyXrETuaS2VkB3AYTdmDjF6MA4UjHj4yegg4FA==
X-Received: by 2002:a17:903:32ca:b0:1e0:c91b:b950 with SMTP id d9443c01a7336-1eeb0991088mr59149435ad.5.1715253922777;
        Thu, 09 May 2024 04:25:22 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c1368cfsm12000045ad.253.2024.05.09.04.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:25:22 -0700 (PDT)
Date: Thu, 09 May 2024 20:25:18 +0900 (JST)
Message-Id: <20240509.202518.402087965685343995.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net
Cc: fujita.tomonori@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com
Subject: Re: [PATCH net-next v5 5/6] net: tn40xx: add mdio bus support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ada8f820-ee60-4fac-92cc-91f287e36041@gmx.net>
References: <6388dcc8-2152-45bd-8e0f-2fb558c6fce9@gmx.net>
	<20240509.195906.2304840489846825725.fujita.tomonori@gmail.com>
	<ada8f820-ee60-4fac-92cc-91f287e36041@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 9 May 2024 13:16:11 +0200
Hans-Frieder Vogt <hfdevel@gmx.net> wrote:

> On 09.05.2024 12.59, FUJITA Tomonori wrote:
>> Hi,
>>
>> On Thu, 9 May 2024 11:52:46 +0200
>> Hans-Frieder Vogt <hfdevel@gmx.net> wrote:
>>
>>> A small addition here:
>>> digging through an old Tehuti linux river for the TN30xx (revision
>>> 7.33.5.1) I found revealing comments:
>>> in bdx_mdio_read:
>>>  =A0=A0=A0=A0=A0=A0=A0 /* Write read command */
>>>  =A0=A0=A0=A0=A0=A0=A0 writel(MDIO_CMD_STAT_VAL(1, device, port), r=
egs +
>>> regMDIO_CMD_STAT);
>>> in bdx_mdio_write:
>>>  =A0=A0=A0=A0=A0=A0=A0 /* Write write command */
>>>  =A0=A0=A0=A0=A0=A0=A0 writel(MDIO_CMD_STAT_VAL(0, device, port), r=
egs +
>>> regMDIO_CMD_STAT);
>>>
>>> The CMD register has a different layout in the TN40xx, but the logi=
c
>>> is
>>> similar.
>>> Therefore, I conclude now that the value (1 << 15)=A0 is in fact a =
read
>>> flag. Maybe it could be defined like:
>>>
>>> #define TN40_MDIO_READ=A0=A0=A0 BIT(15)
>> Thanks a lot!
>>
>> So worth adding MDIO_CMD_STAT_VAL macro and TN40_MDIO_CMD_READ
>> definition?
>>
>>
>> diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c
>> b/drivers/net/ethernet/tehuti/tn40_mdio.c
>> index 64ef7f40f25d..d2e4b4d5ee9a 100644
>> --- a/drivers/net/ethernet/tehuti/tn40_mdio.c
>> +++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
>> @@ -7,6 +7,10 @@
>>
>>   #include "tn40.h"
>>
>> +#define TN40_MDIO_CMD_STAT_VAL(device, port) \
>> + (((device) & MDIO_PHY_ID_DEVAD) | (((port) << 5) &
>> MDIO_PHY_ID_PRTAD))
> =

> As Andrew pointed out, using the definitions from uapi/linux/mdio.h i=
s
> a
> bad idea, because it is just a coincidence that the definitions work
> in
> this case.

Ah, I misunderstood.


> So it is better to use specific defines for TN40xx, for example:
> =

> #define TN40_MDIO_DEVAD_MASK=A0=A0=A0 0x001f
> #define TN40_MDIO_PRTAD_MASK=A0=A0=A0 0x03e0
> #define TN40_MDIO_CMD_VAL(device, port) \
> =A0=A0=A0 =A0=A0=A0 (((device) & TN40_MDIO_DEVAD_MASK( | (((port) << =
5) &
> TN40_MDIO_PRTAD_MASK))
>
> note that I left out the _STAT_ from the TN40_MDIO_CMD_VAL, because i=
n
> TN40xx the CMD and STAT registers are separate (different from the
> TN30xx example).

makes sense.

I'll add the followings:

#define TN40_MDIO_DEVAD_MASK GENMASK(4, 0)
#define TN40_MDIO_PRTAD_MASK GENMASK(9, 5)
#define TN40_MDIO_CMD_VAL(device, port) \
	(((device) & TN40_MDIO_DEVAD_MASK) | (FIELD_PREP(TN40_MDIO_PRTAD_MASK,=
 (port))))
#define TN40_MDIO_CMD_READ BIT(15)

