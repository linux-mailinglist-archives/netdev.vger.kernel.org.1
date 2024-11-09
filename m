Return-Path: <netdev+bounces-143533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C029C2E47
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 16:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3471E2823E2
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8135719C576;
	Sat,  9 Nov 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JORMcLjk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644C233D6B
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731166751; cv=none; b=uuazZqwnup+THja9fCbGzsRt3oKJFUh4zKmY4SUatZocX//MYoaj7pH8z9/MA19ktFYCRf15aZ3r1s2e1yUrrRPtCpeKPdk+Iigu6ijOYPC7gXLhg9r3R24G0DCd4OKpzsj5n5e/Lq/Wv0eVNxXVEx7mCOtnitliwXa3zkSbURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731166751; c=relaxed/simple;
	bh=HRiphkFlCXWVsiLbPMteQlV+XGEmBAli8F+ZcUN0UVc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E1DVPkkACBsxkTKBuRNeUjbYMLxOIJwTRTCrel4jxcdjFPXgRHzxW/YPGikl1JHUPiyiUq0q3oi2qIprlCuS9Y9uF6tIPJA6vcb5cu/WGJi8IhFx8dq4VU2s1+tTJROzKD8wg0CooT18EpCdBkwqATn/mJ9EDgIRlPIQZAbIbkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JORMcLjk; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so3702800a12.2
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 07:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731166748; x=1731771548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRiphkFlCXWVsiLbPMteQlV+XGEmBAli8F+ZcUN0UVc=;
        b=JORMcLjkTL2hNz//exXwkDExsTLC1+oF0CTk+1KsR1+nznP+ICjS2+m8r8nsEAxljS
         0LC1T/mb2JvNNVzvcQqsgxfGRUsEP44Mw86zCVNIga9XWjHc6CkGCXeNpQnrSuPV111B
         aEwvjVV/Qkf/A/Ij0zwugm46cg7ujfEJri0ZX3iUsrVw2hNdgvH+ujAUBi1mgBPbNpjx
         H1SAFQh7V3NZPBD5d2GcSxo2DVybnfKfFHXpbvx9jh7Yy9M5nkufg3ZPiaAca4TZM23k
         728fP661lmdzM/5QkoZmCT6KlYrMIFiGkA3CRTVLXxupTjtefeYMwoso1UZgLTxn4SPp
         DWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731166748; x=1731771548;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRiphkFlCXWVsiLbPMteQlV+XGEmBAli8F+ZcUN0UVc=;
        b=Nia6kObKVAg018QhkjD+NdSf78OI4/RpcRyiQ9wffwgOq4TUW11IALAfT4XkPQtf3l
         shRvRHt8GyHHfCO4dS6vuV4cQFHDb/YiJOjn6BxiKdq6fu3VSMwuJVK12Z45Kyb9biM/
         FaPB3OPSIbePWak3ndCliJFMYaLaSmMxtFs/lhs2fS2L0P7nIU4eo/SrmaXM3gQgY4Kr
         fBKO+lUnvafMTjmoLYmP8yk/+VLmXUQPHYyiwXNWklJLMtSc/wzeuz2xHuvKMhUCBD8D
         Qxgwyt7nDpLdGO5Srg2UiGbHZw7IuYfoimw1/O/BWWNX/1VKEFBWxFFYH8hg2Oyv7MUp
         pF8A==
X-Forwarded-Encrypted: i=1; AJvYcCW/Of2X7lo15zcNHulUdfd9+irgRQzYMeb6MLHijLyhmgkiW3t1zWKbU7+dstUGpw14UwNXwX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEr3D5cU+a5/ZkT7TutLClgl/L9iWd+cUQ1mmnGOej3N66/MFg
	WlodNbtEVufb8yCH9FerLnIwy5k2OMCmzpVSDHFw4T/NLWmt8K7e
X-Google-Smtp-Source: AGHT+IEyZVkTysskjB4qTGxgN7+peppFF/g/ruUwb6d7/LwSEI9w590e/t3KRwC480dGn/FsKdNajQ==
X-Received: by 2002:a05:6402:2803:b0:5cb:def2:be0a with SMTP id 4fb4d7f45d1cf-5cf0a4416e0mr4925074a12.21.1731166747772;
        Sat, 09 Nov 2024 07:39:07 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4edd8sm3072393a12.71.2024.11.09.07.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 07:39:06 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <c74d0c92-7e93-4f96-bf24-ab0ca95f1188@orange.com>
Date: Sat, 9 Nov 2024 16:39:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Jamal Hadi Salim <jhs@mojatatu.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <20241108141159.305966-1-alexandre.ferrieux@orange.com>
 <CAM0EoMn+7tntXK10eT5twh6Bc62Gx2tE+3beVY99h6EMnFs6AQ@mail.gmail.com>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <CAM0EoMn+7tntXK10eT5twh6Bc62Gx2tE+3beVY99h6EMnFs6AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/11/2024 13:50, Jamal Hadi Salim wrote:
> On Fri, Nov 8, 2024 at 9:12=E2=80=AFAM Alexandre Ferrieux
> <alexandre.ferrieux@gmail.com> wrote:
>>
>> This patch adds the missing decoding logic for handles that
>> deserve it, along with a corresponding tdc test.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Reviewed-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
>=20
>=20
> Ok, looks good.
> Please split the test into a separate patch targeting net-next.

I'm unfamiliar with the net/net-next dance (beyond the dichotomy between =
fixes
and new features). Can you please explain why the test should not be in t=
he same
commit ?


> Also your "Fixes" should be:> commit e7614370d6f04711c4e4b48f7055e5008f=
a4ed42

Ah OK, I see, that's the IDR conversion. I had mistakenly believed it was=
 an
isofunctional change, and upon seeing the "(|0x800)<<20" without "(>>20)&=
0x7FF"
in the initial commit, I believed it was a 19-year old bug. Then it's onl=
y a
7-year-old, thanks a lot for the correction.

> When you send the next version please include my Acked-by:

Will do. Thanks a lot !


