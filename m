Return-Path: <netdev+bounces-119102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCE89540B6
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9075C1C211DD
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C8763EE;
	Fri, 16 Aug 2024 04:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QNTNwwy1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C354D6F30D
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723783900; cv=none; b=iCSKFwmldBlXcjir/aWRyzlTvtjp8lGINSxEn4e3c3SzvrxZ+vnHUrlmPZ3E8erZdhxOEN0GEXMoWcg4LnsqELSdRu00249AOyPtlNa0WbVBuhOuV7klIpsNiG51SFEJw3nCPcDC2mYQqWD3dKMjq2u5QtLcGf1diN22i2kLkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723783900; c=relaxed/simple;
	bh=PP787mnpyQPiRJely5CPAAgYXfHEqHIW48jArRmUmss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbxlv7zN0bh8gsEMM3zfc2HB/lsivaCVT2SHHIAitvR1jDDgPNGdA1MR3hxk+LSya5s64T3x+EB8FdKJKotdw8ny/pFivgSQIkKvHChBJAYKDJ9eaFp4QdYSiUkQ1pyNiQUA/nGFO6K8FRtbtdeFgRQcDf9fbqP/vtIxg8qJeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QNTNwwy1; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6afc27735d4so11752017b3.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1723783898; x=1724388698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0SLUkNdmlUCCCnO+rMdels7NZPrmWYQ4Oiryow/Vx8=;
        b=QNTNwwy1r+sKi+Mx2H1VhBQnDfCGLxY8PrKR5qaTGN7v6jSu/WlHJRYcwjbSfnIRP6
         tvjb6wqjMm4dUzk72HKIQ7de+5H8Ta3gpNDvQromU7iItt10J+0rytv2iEdgcTAtQXoy
         39bcgdOB3+K+VKR1rhqF1LhxECvUBc4pGHiPKCpymOjmLmmc3Xg6+B6weMvAW0Oq1HfY
         uCk6NxQ/c36n+sfBcy07q0GNA1Fz38PHLZCSe8fdq7tf+ATbS+FGkyvSUstN84F6J+ux
         hegZqlZtbZ70r6odLnDMrtikpn4Bg7BQ8QIaMue93rI8Z4fBsH+okOJeuMAV+5S/dysU
         hZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723783898; x=1724388698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0SLUkNdmlUCCCnO+rMdels7NZPrmWYQ4Oiryow/Vx8=;
        b=GXr6eTc9OsTe0ASh7hyzgqiWJwVmqs/ZyJPP3w9dkHEOVgBOLekvG8W2V8X1JdUu5C
         u1l6jJlVX37Ysn2k98ITdUyytU9HTAjKy0R4kY9hL5ANBPH4YVSgQne9lwgJltdC2GCa
         j/cPm75kWKeM5GRe26z2lQdm2/lac3IPzecURoY94TE98HhnECRbovP3JYRaAWVNywgz
         o/jRI7cOOI/7P+FC6TJlsqldzw9Vav2e3DKd5xw4bDgfT4KfCBiIJ3S1QR2RsYPcLIV8
         SELZJ2VXyxE6f34vaDhubIZ7OYCcFl953NODqOffQ9UvpE3+i7oAhwUAbpEum+YUAoO/
         xGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOfRjveqLGMRef7hntwyLisOwrV5cdGYsXFDKSItTEfHUd2E+DmnfnJ2nym1B7jkAVk5FQv4Jg5yZwms/NuEmXt7aipUIs
X-Gm-Message-State: AOJu0YylGVAi6FKOmvJqlNKzqaBWex/VOIdHlpdYwwwTHfqs/+2jS76Y
	0TdAxbAwwpLpbqL18aoBOWppf2mKDJUkH18ZjA7DqjhCGMNUXsk8pNazdEcFO3ySorDWYv6n6F7
	91D+uoxdP7i6PZXbbXp1MmDIn6Sxf05QnJLCL
X-Google-Smtp-Source: AGHT+IFgMDMHKSSts+gPn9jVeCV5w2kbLH2a+iHrWwU6hHZZ0EIJP9f60mGv6z4sKbZOQzEg9LK332QkL9R4LZvz9Vk=
X-Received: by 2002:a05:690c:60c2:b0:6b1:173:514d with SMTP id
 00721157ae682-6b1b7e5ff81mr19493517b3.14.1723783897732; Thu, 15 Aug 2024
 21:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815-tdc-test-ordinal-v1-1-0255c122a427@kernel.org>
In-Reply-To: <20240815-tdc-test-ordinal-v1-1-0255c122a427@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 16 Aug 2024 00:51:26 -0400
Message-ID: <CAM0EoMnJq9GfapaueCkOWVUH81kTFRbuuwpweVo472X5tUHxsQ@mail.gmail.com>
Subject: Re: [PATCH net] tc-testing: don't access non-existent variable on exception
To: Simon Horman <horms@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 11:37=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> Since commit 255c1c7279ab ("tc-testing: Allow test cases to be skipped")
> the variable test_ordinal doesn't exist in call_pre_case().
> So it should not be accessed when an exception occurs.
>

LGTM.
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> This resolves the following splat:
>
>   ...
>   During handling of the above exception, another exception occurred:
>
>   Traceback (most recent call last):
>     File ".../tdc.py", line 1028, in <module>
>       main()
>     File ".../tdc.py", line 1022, in main
>       set_operation_mode(pm, parser, args, remaining)
>     File ".../tdc.py", line 966, in set_operation_mode
>       catresults =3D test_runner_serial(pm, args, alltests)
>     File ".../tdc.py", line 642, in test_runner_serial
>       (index, tsr) =3D test_runner(pm, args, alltests)
>     File ".../tdc.py", line 536, in test_runner
>       res =3D run_one_test(pm, args, index, tidx)
>     File ".../tdc.py", line 419, in run_one_test
>       pm.call_pre_case(tidx)
>     File ".../tdc.py", line 146, in call_pre_case
>       print('test_ordinal is {}'.format(test_ordinal))
>   NameError: name 'test_ordinal' is not defined
>
> Fixes: 255c1c7279ab ("tc-testing: Allow test cases to be skipped")
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  tools/testing/selftests/tc-testing/tdc.py | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/se=
lftests/tc-testing/tdc.py
> index ee349187636f..4f255cec0c22 100755
> --- a/tools/testing/selftests/tc-testing/tdc.py
> +++ b/tools/testing/selftests/tc-testing/tdc.py
> @@ -143,7 +143,6 @@ class PluginMgr:
>              except Exception as ee:
>                  print('exception {} in call to pre_case for {} plugin'.
>                        format(ee, pgn_inst.__class__))
> -                print('test_ordinal is {}'.format(test_ordinal))
>                  print('testid is {}'.format(caseinfo['id']))
>                  raise
>
>

