Return-Path: <netdev+bounces-144104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9659C597F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7678E1F21399
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889881FBC90;
	Tue, 12 Nov 2024 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tvp+9rGq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86511FBCAF
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419294; cv=none; b=umSppdlx7aan3hEFwkeP6+p9Xhrinhf/Xx2O9NoZBeE05OKIbA7fQbWcTF1NtT2qhstYNJJoIQe0RNt1wbX4o2ujiB7RnsJO2JG4Z0mkcXklAvrb3Ro2foDu106VNssFfqQ7y37Tjl8DoNvAyaP88W6gtdOUAiu2EAK4PYl3vyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419294; c=relaxed/simple;
	bh=gobI2zzmxZSRmHIZoSZOi3pQaQmNw0thgwqLUgDbafY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FN436T6ItWTodDniIgkWFR51lyebX5utRyeeZ2G6fh/Dyq1IV6k+V6DzWdjQ2JoyLc+Y0HJPi2PaXpEKmdV/peUyD9mfAgGGGqaAcHBAVJwy5RnZDnXG6gAQptucFLzLkio0tVUAai85M/sM5LqOGEr3DBsPzC9RsxakpRiW4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tvp+9rGq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9ed7d8c86cso1014959666b.2
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 05:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731419291; x=1732024091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gobI2zzmxZSRmHIZoSZOi3pQaQmNw0thgwqLUgDbafY=;
        b=Tvp+9rGqIiA/sfVyMEyaE/iswwHYTHrwgJe9J/EovsbB74A/eTaoBmotPO6pK7m7/G
         E9J6mk6D8ruHlyaiZP2YEpjcczjHV704GXpfIhSkegVhNr2t/08CmOyswAnI+VZd9Trb
         T4c0aEnbXr48133IQHveGU4onGA5SIJlsvReRZds6fwT15EixOiiOZMc6f6Q3mPTgY2h
         oEfZ+62jSMVJok79AnBqOEIY8DMfrmuCJSDMWRJBl+rOcoOvISYE7YaY/p+uilJXEbD9
         2LIqT45LS6tACE77GDxjnrK3aClX/xQ51y4fJbmz+thVDg4O32FEuL3f7M5Yx4h/IIvV
         wIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419291; x=1732024091;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gobI2zzmxZSRmHIZoSZOi3pQaQmNw0thgwqLUgDbafY=;
        b=cdf9PnRK40dBKL4E5l/gq6X6SWJP5nepcRGdw9JBACGmDR0G+DvgwOCmgsh7/b2W3X
         Gv0pmJI8vyJu/xMONrqegS5LTRKvDm1RqRl05x8bcsCUrC/3Anw2AIpTb7N3mLMN2TZn
         iFymWltKgv0l/kH/GL0ql7WZc4VeMZpSKpyva6TaaYqj2ryMghjf45YGXjrCHAGumZAa
         /vjUdti7v0EMLhBoe/SrG8wDQXscBoxQinmc828qYKU5n8vhXouYGiL4LN89xbperbYP
         3lQVFcSUY94CCCo5SoxqJYPJkfPmXsfTK1gJ0B2uFC6dhmUOOhfZVk5bJCH/lsVNEjX0
         dcUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhMVVfy0ZINcKL7Es9yHbYH8mEFXlSUbxxTGDcuWQwMFXBkiJ6fBpv1626TXnZg9RwLRNDsVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOl2JpS188QxAmTLdzY8FKD0tqrCvZoDs8ZRGPbPxesxsfKRB1
	UpHBNKbbkdNGApYZV7MfUa2xl59ZFZWHfGiQ5UJjAzG8IkqHXOmv
X-Google-Smtp-Source: AGHT+IEpoBRXk9g0jzDL58+21ujwewz/SOjo7BP2BOb0QuAJyp5cjeF6gVP9BU06vx5r5A3iugr48A==
X-Received: by 2002:a17:906:d542:b0:a9a:67aa:31f5 with SMTP id a640c23a62f3a-a9eefeb1511mr1608189766b.10.1731419290928;
        Tue, 12 Nov 2024 05:48:10 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def47esm714835766b.160.2024.11.12.05.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 05:48:10 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <67ac8505-a08b-40b1-89ec-18d5b4e255bb@orange.com>
Date: Tue, 12 Nov 2024 14:48:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <20241108141159.305966-1-alexandre.ferrieux@orange.com>
 <CAM0EoMn+7tntXK10eT5twh6Bc62Gx2tE+3beVY99h6EMnFs6AQ@mail.gmail.com>
 <20241111102632.74573faa@kernel.org>
 <CAM0EoMk=1dsi1C02si9MV_E-wX5hu01bi5yTfyMmL9i2FLys1g@mail.gmail.com>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <CAM0EoMk=1dsi1C02si9MV_E-wX5hu01bi5yTfyMmL9i2FLys1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/11/2024 13:23, Jamal Hadi Salim wrote:
> On Mon, Nov 11, 2024 at 1:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
>>
>> On Sat, 9 Nov 2024 07:50:53 -0500 Jamal Hadi Salim wrote:
>> > Please split the test into a separate patch targeting net-next.
>>
>> Separate patch - okay, but why are you asking people to send the tests=

>> to net-next? These sort of requests lead people to try to run
>> linux-next tests on stable trees.
>=20
> AFAIK, those are the rules.
> The test case is not a fix therefore cant go to -net.
> You wait until the fix shows up in net-next then you push the test
> case into net-next.
> I should have clarified to Alexandre the "wait until the fix shows up
> in net-next" part.

OK, thank you fro the clarification, will do that :)

The v7 I posted includes all the remarks received so far:
 - static [inline]
 - test split apart
 - u32 type
 - Fixes: with proper commitid
 - Acked-by you ;)

Please tell me about any remaining issue.


