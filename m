Return-Path: <netdev+bounces-218871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4710FB3EE5B
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDD81B2125D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 19:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141D6258EED;
	Mon,  1 Sep 2025 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0I2dy5z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1519C560
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756754210; cv=none; b=Kg/TOHwanzbaGl8za5le6E3FTtBhlAUXr2NXRC1o5UrnC3gWQr+W4Nj8HQSiyef+Rf8ziekeR/RZm3oTosOGS6g3bkHndNaTntsp4guKPZcO4KHFZHRUDfMCfqjdq15/tlmys1fv4KtzvNM/MgI0/lNhZ+N+ybpy55obL2R3nyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756754210; c=relaxed/simple;
	bh=BB6JRurBSAgQyOynVg55aaYrSapJsV7/dT0b92oyey8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIvmDuBOzJl/SEvjS89hL1Bn/iVe4iEolJHsLv7t4j/oJNs8eYCKgTvmTx9nXV+SH54j6zF+10ub2hA3eQo5F0I9YhJVrY0LZ8kJtsIL4R6mtnggGOVqYx8meUlCjtyRWjfSWC4Tc4c9EoSA5xReIsPHhFeVyh8heMcRZaKgleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0I2dy5z; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b30f73ca19so21223271cf.0
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756754207; x=1757359007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB6JRurBSAgQyOynVg55aaYrSapJsV7/dT0b92oyey8=;
        b=g0I2dy5zsjNw7fn8aAFyHO6Pn/A4JGoxiMPib/aJtHO5lLA78LdEp14g9nZMI4xTFw
         sefitu9a00QJWT/l3Eg32AuQOyCQ7QFG3o9k36sGw6rkyJdvZUa85gqLStNAqwijTobg
         raykEDx8AGXR5sPNXkAGjGKv9xPV15KoGySXeYZvk5gdnYLAphsSIwMk3SgNTvRU/AQC
         ltudRh8AMwqHg+FHTK7PCyp/q3gE2GS9TmO5NUaLwoWVabv+tAvJrY6g+Uwm/9m6d/hn
         DqAd7zpa45YusByz/XGOIQ+qXXSP4Lrs4j19iKIoeV5SGxYXUz8xrznpLVa2mjSohEGA
         qqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756754207; x=1757359007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB6JRurBSAgQyOynVg55aaYrSapJsV7/dT0b92oyey8=;
        b=kgmCm6l1MzlFIgTSRT4sdYrFyifTgFCxowh3FBDxsv5xH6v+IkBr8ozwydfwtg2lE9
         raaOJVNtqfc0AuzbJgrUAnNjpZbXFg7bNL8SyfvBjgO1RLkcQjBptZT+O4VMQmqL4ONI
         KNzsaT5yxGpVDjl4aBhuKrFWQbPSL+EIzFySsxrrnS2heFSvvxqo64p9jArEgK+CEKFB
         gHsRWsuN6x3fpcX7pBVGkVSnQaS1KqdgUf7Mc30XooWIfh79F1cVOZApDLZVuZlyX6JL
         qfOLGlo0/afERmXboAb80Jt6oiXYspvLhZvbnUbZB4KiNtXBeoEs5cCZcRoszgrrYtmw
         1Iog==
X-Forwarded-Encrypted: i=1; AJvYcCU+62wFTucQWDZ/GMl6bM2g/8bsRb49sAhFpKZTxUGWpY7CdAOqjgGDxxlYpuDVrsx2vk0YibY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwyqlxiBHkt890QSniU5BN6ktPvCVAnHpuI73zekwJqNUHI8h
	2HuWhdOGjeAlM9sKKTfIZMJnyKbj23NADTjDr25FStKsre1bVEdr3gUZNsAjIl0Jx7bGxVKl/Zr
	8rd51h6rFYC1ruDW8h9o4nOvsn/USaFzl8ZVS3U9V
X-Gm-Gg: ASbGncvG4Ad7+9SfPwJTc3f0DxFVPq4snveHPTUhc1+ESkSKKTTpdRnq7TbVsxDUjii
	og8ihBq/VcDtOWq29lwpkkRHZWFxHFj4QAlXCTO8APVrIKn5Y5xNKPWcLlJjotFzKg9ZR4NERxX
	6BslcO2yrDoWJ/j6A822/Qrba1HDY5nhof1qwQpJVi6AUxDPBBktJBjDDsYh+1nvrHOhQcNCFdF
	WxpdxqYn1fJsw==
X-Google-Smtp-Source: AGHT+IEH29bg8fNyBHVbov9xmzlE8b9g6LBWULR23ua093TKVyeNDvkA+wfXwDCXdGTf8a+DotlcxJbyDFJn1+G+YuU=
X-Received: by 2002:a05:622a:164c:b0:4b0:7b0a:8985 with SMTP id
 d75a77b69052e-4b31d821cc9mr116270771cf.22.1756754207037; Mon, 01 Sep 2025
 12:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <11212ddf-bf32-4b11-afee-e234cdee5938@free.fr> <4e4c9952-e445-41af-8942-e2f1c24a0586@free.fr>
 <90efee88-b9dc-4f87-86f2-6ab60701c39f@free.fr> <6c525868-3e72-4baf-8df4-a1e5982ef783@free.fr>
 <d073ac34a39c02287be6d67622229a1e@vanheusden.com> <6a5cf9cf-9984-4e1b-882f-b9b427d3c096@free.fr>
 <aKxZy7XVRhYiHu7c@stanley.mountain> <0c694353-2904-40c2-bf65-181fe4841ea0@free.fr>
 <CANn89iJ6QYYXhzuF1Z3nUP=7+u_-GhKmCbBb4yr15q-it4rrUA@mail.gmail.com>
 <4542b595-2398-4219-b643-4eda70a487f3@free.fr> <aK9AuSkhr37VnRQS@strlen.de>
 <eb979954-b43c-4e3d-8830-10ac0952e606@free.fr> <1713f383-c538-4918-bc64-13b3288cd542@free.fr>
 <CANn89i+Me3hgy05EK8sSCNkH1Wj5f49rv_UvgFNuFwPf4otu7w@mail.gmail.com>
 <CANn89iLi=ObSPAg69uSPRS+pNwGw9jVSQJfT34ZAp3KtSrx2Gg@mail.gmail.com>
 <cd0461e0-8136-4f90-df7b-64f1e43e78d4@trinnet.net> <80dad7a3-3ca1-4f63-9009-ef5ac9186612@free.fr>
 <CANn89iJGdn2J-UwK9ux+m9r8mRhAND_t2kU6mLCs=RszBhCyRA@mail.gmail.com> <c7829cbe-a9b0-3c3b-d7c1-88f62a9fae0b@trinnet.net>
In-Reply-To: <c7829cbe-a9b0-3c3b-d7c1-88f62a9fae0b@trinnet.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Sep 2025 12:16:35 -0700
X-Gm-Features: Ac12FXwmz9SJmc8ms8gIPufm3VTQRyhSJcUHJFziPkzYFflDB3jopA5fvGtto7A
Message-ID: <CANn89iLY-Mb8k2wobFAfvCnzizJiv535DG_gBkxDtPAMJ6_s9Q@mail.gmail.com>
Subject: Re: [ROSE] [AX25] 6.15.10 long term stable kernel oops
To: David Ranch <linux-hams@trinnet.net>
Cc: F6BVP <f6bvp@free.fr>, Paolo Abeni <pabeni@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-hams@vger.kernel.org, 
	netdev <netdev@vger.kernel.org>, Dan Cross <crossd@gmail.com>, 
	Folkert van Heusden <folkert@vanheusden.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 12:10=E2=80=AFPM David Ranch <linux-hams@trinnet.net=
> wrote:
>
>
> > Keep calm, I am just saying that the bisection pointed to a fine commit=
,
> > but it took a _lot_ of time to root-cause the issue.
> >
> > And the bug is in ax25, not in Paolo patch.
> >
> > Please test the fix, and thank me for actually working on a fix, while
> > I have more urgent work on my plate.
>
> Much appreciated for your work on this patch but I'm curious, is the
> core issue here on this other committer's patch or just weaknesses in
> the original AX.25 stack code?

Plain day-0 bug in ax25 code.

It was probably not working well with packet capture (tcpdump), with
possibly silent corruptions.

The kind of bugs that can be exploited by malicious actors.

