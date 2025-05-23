Return-Path: <netdev+bounces-192916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC11AC1A23
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 04:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F5A3ACB33
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 02:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBD21C6FF6;
	Fri, 23 May 2025 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhT7GV4I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C72DCBE7
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747967783; cv=none; b=HWJT0+m1CQQEAfxS/gue+TYTqjixR2iFBroIZMRHuqWkGRYS1LJG08TcNXPhrAWa8HX2J2U7WdJIy709YliPY8VeQzOGemBVtg/3IiD9ZSmrxgHIUcIReQKcMiCCkqZce4iqqWOf0JN1zl/5qYdJ7aBhNwofowMM8zEUS1VAxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747967783; c=relaxed/simple;
	bh=Ku0RG7LIv/nNLun2V1WBNcLw+N63ceUVFHAqHm6z5PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWzGBspP/fQSBhe3sT8ON5SkZ84kR9VZ476zvKLjSqYlU1hzStcGP+Q4OzFbuBKQkVWLB5DpQmJXKxLMVySvrrWJblJTg+q4Eo77sHlu5HU0/P7P4uUj4j9bjyEwks1rzNurH6hnt+zE1gtdLGymW51uUOz47+EHnbBGP9LyEAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fhT7GV4I; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-550eaa73a18so9e87.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 19:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747967777; x=1748572577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ku0RG7LIv/nNLun2V1WBNcLw+N63ceUVFHAqHm6z5PU=;
        b=fhT7GV4IYEPcHwueJ1/rh0NqbHDBm4Mz2pJ6+jwkz77QFZqMSAG309eJE6HCjKdE+u
         lpS82EGUNZNegVXyFE0BB73Yy/fcmY54IVBVtZE3PLIUdM5uJrhhxh9cO9Jk3AMSLUXw
         H8pT4AB4kZ/ciyGnBk+IjIx2R72MluyicftG/Q4fCeCKogjtqYusDsx2dvYoIaROkmNt
         pPXcfncYV0HkY5qJxrdlCdWChjx+g3tA8tqSxOeek7sAQfoLhDt1CKEbnSbM4PFPX8Lz
         RVGwsHXSrmNsJcbZfNgtryzA0IeENhXKRGnn64cWXJ3i5avCFD1raPr+KBUF/38TtPhL
         UZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747967777; x=1748572577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ku0RG7LIv/nNLun2V1WBNcLw+N63ceUVFHAqHm6z5PU=;
        b=hYghkh26mDpIRQYi2itzh6FUgzh2c1bFTLUUz6VyHmsXfPUM3x83fR2pZMV00rXMRA
         9nhMRb4hV3ybBYPq2UE+k1cHHS2CgJ6wLCsrE9SVFvKHZngzq3O04A6bKbeQWQM7T073
         LF/czaDHWfiCvvlxPBn0uKKruXODdWxHjhnLfCxwQYs/0SxNYe20RiRj+K46Ut7NCc2T
         buMcTKzeNXkEKDiC6mLwax31ccpErPTcay3N9pBK6ky3HO7FvqCY8LnYSxKRrO7w4Ran
         57/OxsLEuKsBVKm1p2iCLH83D6kKGHpXSyJsBMFH0REj3lvwTfvtnT3/m8Un+6ydeOBz
         6mzA==
X-Forwarded-Encrypted: i=1; AJvYcCXBfyejFGxtmDTDR9gbwTqgdN4K+m2+u6Guj+JEzZiogmayeREDRAKmLXIFuVNWFpOeWvfB3w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyR1dpmw/RfYUrckd8weLpo4vRBMmb3z934LVwY8dR8otNDhN4
	xCX6Ks5bk9oXxwBGajKK6AP5PvE/eUdoT38KwGMH7/C7vFOx5t/a/Q4LgzWNnAsgZfbhZ9pOzkj
	apYODLyjnmii6gEZFCUxEteqrQMgdUCBIGkdY05Y5QxpONbFRQmfxMupp
X-Gm-Gg: ASbGncsN7nNcUnEHFxOVqnhci4LKR/b3nOFoUuv0JnCtL5D0xHn9vpgTw5dKEIUEBgS
	RB75CT8OaWQz4yEdkqf+S2+qAnZD+UEf3KlJyy+0pqOPXTZFGMNlX4eev8Frh2u7k05+EHpTGRL
	6F0CiIY1VlVQ4ddl+JoPgzpakV45VuaTIdQK9ofifkB8TzleWcgZKhr3Q0I7tKp3rx0RKVpWHy
X-Google-Smtp-Source: AGHT+IGgXvGN7dS1Kxxx5d6BUFyZ6uzh7Mm/k2+/iNWKv+fOVoKBDJOaUyLME12z1zEoUQkgDUYkw7R27WctFzZnUy8=
X-Received: by 2002:a19:ca16:0:b0:543:b9ff:12e2 with SMTP id
 2adb3069b0e04-5521855e016mr240e87.2.1747967773961; Thu, 22 May 2025 19:36:13
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174794271559.992.2895280719007840700.reportbug@localhost>
 <CAMw=ZnSsy3t+7uppThVVf2610iCTTSdg+YG5q9FEa=tBn_aLpw@mail.gmail.com>
 <f6475bd4-cf7e-4b96-8486-8c3d084679fc@kernel.org> <CAMw=ZnT7tcjC6z-9xuMbeC5RhDiaPRHaZB_2i_6WYNJ=cm1QVg@mail.gmail.com>
 <CADXeF1Hmuc2NoA=Dg1n_3Yi-2kzGNZQdotb4HJpE-0X9K9Qf5Q@mail.gmail.com>
 <CAMw=ZnTLuVjisLhD2nA094gOE2wkTLyr90Do0QidF5nHG_0k9g@mail.gmail.com>
 <CADXeF1HXAteCQZ6aA2TKEdsSD3-zJx+DA5nKhEzT9v0N64sFiA@mail.gmail.com> <8f511684-3952-4074-8d97-51f4789f3151@kernel.org>
In-Reply-To: <8f511684-3952-4074-8d97-51f4789f3151@kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 23 May 2025 11:35:35 +0900
X-Gm-Features: AX0GCFvtfWFwIamFXukPBrQEa_MbMjTQeOUS4ctL1_t797qJ2q5swgKMA_criD0
Message-ID: <CADXeF1GgJ_1tee3hc7gca2Z21Lyi3mzxq52sSfMg3mFQd2rGWQ@mail.gmail.com>
Subject: Re: Bug#1106321: iproute2: "ip monitor" fails with current trixie's
 linux kernel / iproute2 combination
To: David Ahern <dsahern@kernel.org>
Cc: Luca Boccassi <bluca@debian.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	1106321@bugs.debian.org, Netdev <netdev@vger.kernel.org>, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked, will submit a patch to iproute2 main by EOD.

Thanks,

Yuyang

On Fri, May 23, 2025 at 11:17=E2=80=AFAM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 5/22/25 7:17 PM, Yuyang Huang wrote:
> >> iproute2 is generally backward compatible with previous kernels yes,
> >
> > Acked, will submit a patch ASAP.
> > Could you advise which branch needs the fix?
> > Is submitting to iproute2-next and iproute2 enough?
> >
> >
>
> Thank you for the quick response.
>
> I should have caught the exit on lack of support for the feature, so
> that is on me.
>
> Please send a patch based on iproute2 main (though main and next are
> practically the same right now).
>

