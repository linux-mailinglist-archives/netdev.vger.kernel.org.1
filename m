Return-Path: <netdev+bounces-124073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8B3967DEB
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 04:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02331C21C93
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 02:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0762BB04;
	Mon,  2 Sep 2024 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESyfqK1Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028D2A8D0
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244927; cv=none; b=kd6uZDfK3XGfedA5yD9H053b5WnvvafSlocBhcr3V9EdcCzR2Zc6+aNCLIxpMv1kT8IrvYPeYXF5ybSUE/ZW5uOF2eMlRa8vpAhkc1C+D4cnmu/mo2uDgsCIFbI6G+HxJT2nv6uCj2akkyPJ65oZks5ns3iLiQAJ0cgONdxzgLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244927; c=relaxed/simple;
	bh=fRQBjGtlnvDAfBgkDPlHm5l+iboxelN7tPUpU9ILVL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCW3QBVFjMWuJsPTjEIzQhv1msq3nj+adRrtdtJxLSwJdNTOomZhsEPon8BP+oWG1HJ3Mz3aP7mk0oCWqkDSdXU3BIbbmbtliH3IwMgN9SR3KRCEtinYWFUYTxrNGuwHxMGoG+fWlbR46Cdj+LtaiaOluPtwloShDN6svqsxCTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESyfqK1Z; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-829e86cb467so158118139f.1
        for <netdev@vger.kernel.org>; Sun, 01 Sep 2024 19:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725244925; x=1725849725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYVuWR+KJMOu7VVG8hiplGAK1TU6V31co4dLMl7opaY=;
        b=ESyfqK1ZyOlkr9zWvgiT9E/o963SO2gUDOL6sT20prgVkZhqvRipKEHp7kleK/VhCt
         ea5WcaSIogD9OiWR6M70apsmjtavc2yf9rqO3+BBVCw0pyeWbw63rBFX6qnr1Px/6f3K
         JdUZ4AqMCS+b2be5IsZ7LbCWdTaTUDuTuPQ0+1rTnO8w2YTVrGSZ7ZVqiTKKw8y5Ths1
         a2GQP5Su2+QX5WELeYpPUOj24OQyhLPBMEbOzWrAqRn5gEWpLCAEZnIXChBQv/uqYF4B
         5CIT4pAjCK8zxpziSu3FSAUqSB9+w13U9cGd3503JTIlSzZBmqOWU0icLXXYIeiC1M7q
         l+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725244925; x=1725849725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYVuWR+KJMOu7VVG8hiplGAK1TU6V31co4dLMl7opaY=;
        b=O32WbxjdWnIljg0LXJ6lK+OkKfzMT9FeNhQglMUWcHYq8xQmriZ1rzJaqT5fTCGILj
         E3rQhj4TzOFS2NA1QHyGzlxV42drsm4DOnbmEMiYPLQJU6//o3Fk/aZ+WqXmZreWJFXO
         cv4PA/SbVcJSLJwZxOcKMyxuoEMshxXvxk1IlLt8KDbv2/JvRf384um9Dvx/Ozenzewa
         hZU+JFHhHAvscn8qHnztFVvoTWWfD9iITUmDSHP4Tvl1ujwuUB7n1a7VvBIoyeEKVe8f
         c+KkqVuTmqNBNYBRXe5jFLkk3XiAwY2DpIhRfbMNH8o/y81fDGwn9kRV0mlQ25X9SNCP
         hxyA==
X-Forwarded-Encrypted: i=1; AJvYcCUzkKMxbWC1Yr6T8OB/Qv1xrzN6/szPG6SX44dpxu9PGV1IpKCphC1qzIHqrNaQBM67CB7LoyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh+4kplv78Uiq4RqA3y3HoCneH7An4lB2DLVFkjvmAR0fQTuPf
	vXwgX8tKOgskTNqjsbZ6fcQyFLp5UeViCO94ov+89kK/X3W5w4BkmxO4wlhYG1MvEaj5IxicXXD
	BBs6aHjS7S7LCmIev1ovsmh+6xUw=
X-Google-Smtp-Source: AGHT+IGU/4FmqbkrGxfuuIcBMSAIpnYMeDpJVcK8PuY2InxMEkx3irFDs6E+DBoWldDLN7taMAIn3PmFedOV+mIsj48=
X-Received: by 2002:a92:b709:0:b0:37a:7662:7591 with SMTP id
 e9e14a558f8ab-39f4f516a8bmr61004735ab.6.1725244924702; Sun, 01 Sep 2024
 19:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830153751.86895-3-kerneljasonxing@gmail.com> <ZtUZpPISIpChbcRq@rli9-mobl>
In-Reply-To: <ZtUZpPISIpChbcRq@rli9-mobl>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 2 Sep 2024 10:41:28 +0800
Message-ID: <CAL+tcoDg5rEQpx7mAvOxFg71iOT9gWBy0+NzjWV4r6JfhnOG0g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] rxtimestamp.c: add the test for SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER
To: kernel test robot <lkp@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 9:49=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Jason,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-tim=
estamp-filter-out-report-when-setting-SOF_TIMESTAMPING_SOFTWARE/20240830-23=
4014
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240830153751.86895-3-kerneljas=
onxing%40gmail.com
> patch subject: [PATCH net-next v3 2/2] rxtimestamp.c: add the test for SO=
F_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER
> :::::: branch date: 2 days ago
> :::::: commit date: 2 days ago
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a=
15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240902/202409020124.YybQQDrP-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/r/202409020124.YybQQDrP-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> rxtimestamp.c:102:6: error: use of undeclared identifier 'SOF_TIMESTAM=
PING_OPT_RX_SOFTWARE_FILTER'
>      102 |                         | SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FIL=
TER },
>          |                           ^
> >> rxtimestamp.c:373:20: error: invalid application of 'sizeof' to an inc=
omplete type 'struct test_case[]'
>      373 |                         for (t =3D 0; t < ARRAY_SIZE(test_case=
s); t++) {
>          |                                         ^~~~~~~~~~~~~~~~~~~~~~
>    ./../kselftest.h:61:32: note: expanded from macro 'ARRAY_SIZE'
>       61 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>          |                                ^~~~~
>    rxtimestamp.c:380:13: error: invalid application of 'sizeof' to an inc=
omplete type 'struct test_case[]'
>      380 |                         if (t >=3D ARRAY_SIZE(test_cases))
>          |                                  ^~~~~~~~~~~~~~~~~~~~~~
>    ./../kselftest.h:61:32: note: expanded from macro 'ARRAY_SIZE'
>       61 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>          |                                ^~~~~
>    rxtimestamp.c:419:19: error: invalid application of 'sizeof' to an inc=
omplete type 'struct test_case[]'
>      419 |                 for (t =3D 0; t < ARRAY_SIZE(test_cases); t++)=
 {
>          |                                 ^~~~~~~~~~~~~~~~~~~~~~
>    ./../kselftest.h:61:32: note: expanded from macro 'ARRAY_SIZE'
>       61 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>          |                                ^~~~~
>    4 errors generated.

I didn't get how it happened? I've already test it locally.

Is it because the test environment didn't update the header files by
using the command like "make headers_install && cp -r
usr/include/linux /usr/include/"?

If the applications or some userspace tools try to use the new flag,
it should update the header file to sync the uapi file first.

Thanks,
Jason

