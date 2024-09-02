Return-Path: <netdev+bounces-124081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67030967EAD
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 07:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29010282124
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 05:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CCF1547CA;
	Mon,  2 Sep 2024 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOH7BNlC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5415442D
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 05:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725253526; cv=none; b=qlgEvdU7a0oGYHnQNIi6+E1VVQu14PpnJOVxtHGI2jPki/mzPPYczaP0XNMFohN+gv43vF4bh/Zuh758xCEOXqavueBH9xshgGB4C4X0AUgYJnAs/gwtDQLUVMYbFTEo/eRGQP4jXtn2xsP/dgkhpzdia+fmby8RBypMLPYWA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725253526; c=relaxed/simple;
	bh=YjSKkk5AaZK3SGxgSqTIcqwVSkYiq33F+jspB0swlXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l255ow/60I/Zc89nUBT5BwjZ+6ZtU/I30MKrI2a5DXFc4Z5MZPyMrsI0CHmOAPLPQsHW7gl0w2oMjKItysUve2ByXF3uHtBs3Rw5lzqdOhiHt/fjZhbw4tYGrLT7FWVcMugHnQSjnjtG/yF5nR0zApmZ9tSPrXftcZSgOS695EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOH7BNlC; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39e6b1ab200so15022565ab.0
        for <netdev@vger.kernel.org>; Sun, 01 Sep 2024 22:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725253524; x=1725858324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2TWqbJDbwXPjIIRpGPoSbV9nXuYLQsW7xnpIAgHKkY=;
        b=IOH7BNlCXZ/s16//qkQRvvLv6v/pQrrmJYXWeeipHgjFL+C2z7Gw10bsABOrHse3iw
         aMINCdUeDVeL2ovcNnP8OgN8l49A2MEZF7/uT7fOfllvlibEGkUdpX5F1iGaqjRo7CtW
         BOffrtzLzu0KKuVXOUScVU4xl8ctD4UlOJJVHrvMJWxNKAr8dydDPgPniG/L5YxNZzvU
         A4mVfkPNr1t9fvNACiCPLRPMpQ0fhRHo86+uYFWG65DRoOF6FrST+yAz5qL6T187OjBQ
         cgj4sGNT49zD//j7xEKkCSpLDr2UV2fMd1uMi0/37kmwrSn/M+9pKH5ao6AclmoA4oav
         koDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725253524; x=1725858324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2TWqbJDbwXPjIIRpGPoSbV9nXuYLQsW7xnpIAgHKkY=;
        b=Axqxy0G1jdHbKti8sxq5FIVYTir+z/Wo8dE1OvNaZXP2FJvmIa9Lk5f7ym7oN3xwH6
         OdkY5RCMWg8Sa71Rz0yplP5O8A+/WUZHasOiOprAlRKqE0n4TZqbebOk7SpVUKfDCRnK
         +RwWJx3n7vRN1W2iMVkgqpF1lUUS3oj7rHDl4uESjcehDlchlKuJj9nFqTl42QW20NSx
         TAV6u/YYNKSrWDU89HPReo/5k64iDRAwN+MFJqtEelsLXT9jwLKqPHud+9NSwjRYXkhY
         RsgNCFrcuT6or7adxe/0e2pkbfK34EikYfchQ0LXfKq1pW2fntl28pO3zd0RWeh74M6j
         b/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU6d3JXYSnjc6Mfvyry04TJILPqjMtJZwiE0aWiu30U4vBVlwq7zt3KXb1SowIfvR1ztwBFT0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywih7yqetG5/5YzwlGp/vwIvv+74o3VYF7dXcoSWDltxRkzeCe1
	Blc4xzj+974wjxbtqyuHQbWnXOKFoxSyfQGGAxRiXFNLT0rkRXs2KKpPcxbBbNkViHkKPv6A6/W
	l0Kx7MQJe+z+sg44A3uy27mw6B+g=
X-Google-Smtp-Source: AGHT+IG1VyHfZjalYJIqKIyNKw/sF6IhMej6C7l+bmZXB6KNHUd9UNuI58IkccdU6ygosPo8329/ErH6f1PP2xuQ7rQ=
X-Received: by 2002:a05:6e02:219e:b0:39a:1d8d:fc9d with SMTP id
 e9e14a558f8ab-39f4f6c1f49mr74980875ab.22.1725253523751; Sun, 01 Sep 2024
 22:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830153751.86895-3-kerneljasonxing@gmail.com>
 <ZtUZpPISIpChbcRq@rli9-mobl> <CAL+tcoDg5rEQpx7mAvOxFg71iOT9gWBy0+NzjWV4r6JfhnOG0g@mail.gmail.com>
 <ZtU+H5md7d/Svo0u@rli9-mobl>
In-Reply-To: <ZtU+H5md7d/Svo0u@rli9-mobl>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 2 Sep 2024 13:04:47 +0800
Message-ID: <CAL+tcoBL3ggcGOJXwsxXtq-OLH9Hjmou8se4eU8BKUWTOQjJHA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] rxtimestamp.c: add the test for SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER
To: Philip Li <philip.li@intel.com>
Cc: kernel test robot <lkp@intel.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 12:25=E2=80=AFPM Philip Li <philip.li@intel.com> wro=
te:
>
> On Mon, Sep 02, 2024 at 10:41:28AM +0800, Jason Xing wrote:
> > On Mon, Sep 2, 2024 at 9:49=E2=80=AFAM kernel test robot <lkp@intel.com=
> wrote:
> > >
> > > Hi Jason,
> > >
> > > kernel test robot noticed the following build errors:
> > >
> > > [auto build test ERROR on net-next/main]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net=
-timestamp-filter-out-report-when-setting-SOF_TIMESTAMPING_SOFTWARE/2024083=
0-234014
> > > base:   net-next/main
> > > patch link:    https://lore.kernel.org/r/20240830153751.86895-3-kerne=
ljasonxing%40gmail.com
> > > patch subject: [PATCH net-next v3 2/2] rxtimestamp.c: add the test fo=
r SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER
> > > :::::: branch date: 2 days ago
> > > :::::: commit date: 2 days ago
> > > compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project =
617a15a9eac96088ae5e9134248d8236e34b91b1)
> > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/a=
rchive/20240902/202409020124.YybQQDrP-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/r/202409020124.YybQQDrP-lkp@intel.c=
om/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > > >> rxtimestamp.c:102:6: error: use of undeclared identifier 'SOF_TIME=
STAMPING_OPT_RX_SOFTWARE_FILTER'
> > >      102 |                         | SOF_TIMESTAMPING_OPT_RX_SOFTWARE=
_FILTER },
> > >          |                           ^
> > > >> rxtimestamp.c:373:20: error: invalid application of 'sizeof' to an=
 incomplete type 'struct test_case[]'
> > >      373 |                         for (t =3D 0; t < ARRAY_SIZE(test_=
cases); t++) {
> > >          |                                         ^~~~~~~~~~~~~~~~~~=
~~~~
> > >    ./../kselftest.h:61:32: note: expanded from macro 'ARRAY_SIZE'
> > >       61 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> > >          |                                ^~~~~
> > >    rxtimestamp.c:380:13: error: invalid application of 'sizeof' to an=
 incomplete type 'struct test_case[]'
> > >      380 |                         if (t >=3D ARRAY_SIZE(test_cases))
> > >          |                                  ^~~~~~~~~~~~~~~~~~~~~~
> > >    ./../kselftest.h:61:32: note: expanded from macro 'ARRAY_SIZE'
> > >       61 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> > >          |                                ^~~~~
> > >    rxtimestamp.c:419:19: error: invalid application of 'sizeof' to an=
 incomplete type 'struct test_case[]'
> > >      419 |                 for (t =3D 0; t < ARRAY_SIZE(test_cases); =
t++) {
> > >          |                                 ^~~~~~~~~~~~~~~~~~~~~~
> > >    ./../kselftest.h:61:32: note: expanded from macro 'ARRAY_SIZE'
> > >       61 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> > >          |                                ^~~~~
> > >    4 errors generated.
> >
> > I didn't get how it happened? I've already test it locally.
> >
> > Is it because the test environment didn't update the header files by
> > using the command like "make headers_install && cp -r
> > usr/include/linux /usr/include/"?
>
> Sorry about the false report, kindly ignore this. And thanks for the hint=
,
> we will check to understand the root cause of this wrong report and fix t=
he
> bot asap.

That's all right :)

