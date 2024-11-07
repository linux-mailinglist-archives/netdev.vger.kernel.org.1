Return-Path: <netdev+bounces-143100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C08B9C1242
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100EB285634
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 23:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3842170B2;
	Thu,  7 Nov 2024 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdCnVBCc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4CD21501C
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731021274; cv=none; b=MWPB3jHf3Q+gqenDkT8HeekAb1EwdnCc+4z5+uDqNFuKT1bJtghjLMrG48HDBftTvIBoQAG9kDfoEDF3L3AXVTL8dfPSeigk0SAr5aoScat8mYVTQ1O6rtioQDM6h2g3QltJDrn3d9r1j155giu4qhhTF4fZXmOeYfMhyRLREnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731021274; c=relaxed/simple;
	bh=Uo75vVYPFOaszbDimp+zeuHCXmy4vvademuRBSQj3yk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CMfzylt+rIDXAGxiQHHMIuPw2YTbNxAuFow8u6hlLC9xmZeImqu/y0cT+JiZuYvQSffWL49PZRM7cjjjw4mWoihjimdHAi1jXdIXoHil843BIwJomeCv6OJ0ixokLcVOx2FeennFEMjgnm8s1WLX29OtmG0bIyUmfojtggYYoqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdCnVBCc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e8522c10bso226017966b.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 15:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731021271; x=1731626071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uo75vVYPFOaszbDimp+zeuHCXmy4vvademuRBSQj3yk=;
        b=QdCnVBCc/x7nRxF1p53FvvriepxFapiQhvkndetj33NPDQFpKsw6eHrFHOBzSWFD8a
         uKHjLaIK8ZlBj2E6LBiEJ9XprTGSHDPIDCe1mcFEjUXCg2Bj0QKqGEnxzyqPDSw5vRgU
         +nTy93ui/BIIDLUzPGLgzRpHRIjGtRpHaAN/M2p7aBfMJtFDhYjCmtCD1PhZVqtPI+l0
         djl7o14MnkRrGs3fPrKTOGmCuPz12TzOBhqz4GToLQ7+Z6+3b1x1B0U0tRlWYucQMGs9
         1+ClVfuVCUMVDZvthQTt0MsKnSPUOj7OB/lXmc1Hhtj3xyBNVJDqtMuSlmSCafKO2Q31
         I+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731021271; x=1731626071;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uo75vVYPFOaszbDimp+zeuHCXmy4vvademuRBSQj3yk=;
        b=JnfR/eksDUVtnl+xCSwhTKiuoAzAinHtlWEMc97RZTad3w3oEBtSoSBuY9zxeT4Xhh
         vGH1U6jrjog6sbfZt/g5ai2PQs+z7vKsbD7OuRiCQQQtWG54IUfwX/0PBIfJotQbZbtA
         205eYwgc6KVm/C0V+E3XIC3gi2Xm9KSOYNhBUT97rbOyE0NcTzcgp+GWYgmIqAZZ7lc/
         vff2v5xVCBLAu01tIvW8UUSI8tdQm23NmScJtVob0Mr6VBSTM/XYWftlOg3Cj17YOEcs
         w8XJ5tNsq4+CyU4cBf6Im8g1+hoHWQcpJe3yigYi06f//A/aP+SxekBgfPsgj1lNhpP9
         90mg==
X-Forwarded-Encrypted: i=1; AJvYcCUrQ5A7+gJxnLVgyWLTN2jHFk8sokbu3B1gSS4sTZ1dOPFS2k2vzYwYyDU1eYaMO7PEHJG/PXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtq41scsJ4JcDrLQQbm1ocd1kdHmvxehU9eB+7czUMapY3zLh8
	CcIULsOHddAHBuFPFfBNn3+ZTdnY1s/7zls7OfC0KjmMPFLhelCQ0YzS0kBv
X-Google-Smtp-Source: AGHT+IGtILkXGQJx5ISStzI7MDFEVtofz9Fqcn8fnTOtyNY/LeBzuSj/Qo32K737Uh8PFQRK9lId3Q==
X-Received: by 2002:a17:907:2da5:b0:a99:fbb6:4972 with SMTP id a640c23a62f3a-a9eeff97fe5mr55665166b.25.1731021271217;
        Thu, 07 Nov 2024 15:14:31 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a188besm154031466b.8.2024.11.07.15.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 15:14:30 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <27c31e30-b2d6-43a4-8ad6-adbeb38db9ee@orange.com>
Date: Fri, 8 Nov 2024 00:14:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Cc: edumazet@google.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <20241106143200.282082-1-alexandre.ferrieux@orange.com>
 <CAM0EoMmw3otVXGpFGXqYMb1A2KCGTdVTLS8LWfT=dPVTCYSghA@mail.gmail.com>
 <CAM0EoMknpWa-GapPyWZzXhzaDe6xBb7rtOovTk6Dpd2X=acknA@mail.gmail.com>
 <7c4dc799-ebf6-47fe-a25f-bb84d6faa0cf@orange.com>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <7c4dc799-ebf6-47fe-a25f-bb84d6faa0cf@orange.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2024 23:58, Alexandre Ferrieux wrote:
> On 07/11/2024 15:47, Jamal Hadi Salim wrote:
>> On Thu, Nov 7, 2024 at 9:45=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
>>>
>>> Hi,
>>>
>>> On Wed, Nov 6, 2024 at 9:32=E2=80=AFAM Alexandre Ferrieux
>>> <alexandre.ferrieux@gmail.com> wrote:
>>> >
>>> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> > Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
>>>
>>> I'd like to take a closer look at this - just tied up with something
>>> at the moment. Give me a day or so.
>>> Did you run tdc tests after your patch?
>>=20
>> Also, for hero status points, consider submitting a tdc test case.
>=20
> Hi Jamal, thanks for looking into this.
> Just posted a v4 with a tdc test case.
> Of course, I also verified that "tdc -c u32" has no regression :)

And a v5 with a proper title as requested by Eric, along with his Reviewe=
d-by.
(Sorry for violating the rule "one version per 24h" but there's no code c=
hange)


