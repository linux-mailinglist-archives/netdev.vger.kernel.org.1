Return-Path: <netdev+bounces-236247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D04BBC3A378
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4314627BB
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AEF30DED9;
	Thu,  6 Nov 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOa9ZqL8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC4330DECC
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424040; cv=none; b=pX2Llh09ii3hc0+CqQccOM8hHMrbfUcV2rMaXaThBDZt7RJujKJJ8E94ZsFVWgn4tICnu2zUXyOh/OtctA5iCs16BfxOX5OR1YsyXYz+0cTAN1W9uSK7+UXplc9RX0XAxycUTBp05oT/E+49X+fN27llj8uVrbIj/5FVaZ1WG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424040; c=relaxed/simple;
	bh=3g6OwqvUvgOuE0sVQ1tvj2/4v52gpeHEPrmCnel5VNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iiFgQ8d2JrsVKtOvZl2Uql0wovO39k6wqiOyQ+4XlD0KMYILndzyHnme77bJrzwHG75FS9CqrJmQL4ac5GNIOyU16otrjfXBYYh3UCEDbbQrYF0MriYuD+IFvC770A1NIAVr3rTEnO9WesOoftyLHTKy3VPU4+S+ZQ588HYC7ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOa9ZqL8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aca3e4f575so740499b3a.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 02:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762424038; x=1763028838; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XVferEyN4+RzXvE7eehEmFRfQazqGQ49nTw3vZt6WP4=;
        b=fOa9ZqL89qNKkCAz8jQYoADmdLmc1LtqIlsCaUEVxK9YS6x3ZBOhldjv8rDDuf4yvf
         GhQbPWIX2m8kSLQ7HAZseTB5Tsg8lrSzVTXqPO6aKqiboFeCiC/C58qBa79f2wiRhApB
         Vtn93e1Kp3oVPkrv9lMvvJ764fw6z8Qw+jLMlOTPSSnRkVdLgp702zIwJszfsM8okrrQ
         lb/B90zsPEt2Pavga6L2LHM4EV5/3yu2v9PQl7rKjsEyVbRwFpA1CIa9IMvSZ+E6nbRq
         1ZV8WZ8uXOBdPxRAxkfAI+rxq4KzGAElTBNzHGFzZuX/yRQsZAVr9/XNQy+seOD2PJNM
         qqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762424038; x=1763028838;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVferEyN4+RzXvE7eehEmFRfQazqGQ49nTw3vZt6WP4=;
        b=QZv3GT5la6FqIhktPfnDUCJL0rR1BDd0yD7K2LdBHPro1z/tnhX0uaXgeo8G63kmsq
         iqer3eEcOOKxvN+uWOEEc0DLQ0/sjMqEqz3X/QXJnGjif9oGsXEkFnGKchk4HEUeBmXf
         7/M4hqaDy3NlIqK0U4amb95qMiee6MrFjMEp5UVVLYr4/7GzWhpowNuX1lFvzhgGRYYV
         yb9nlPJJLgieqsezODY0bracOa168ym+YiF58Y7SKvGq7QkBXk/YOGGUShRWHAgSLD+N
         Ne7rG4v7TcVwVv64oUcarOP3z1rOb+U2ldG4NKHRGNHc+9kqewG5/KF77WqVo+ha9aDn
         PDqw==
X-Forwarded-Encrypted: i=1; AJvYcCVpRFgt826mWp5RvzChEgXwh2to+L15LmlrTLX4Vyw/uDsiD7Lrf93k8AqptkCiLMNwMBCmWgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR5s6hxBFTIZMv/d0aO0rxZ0jknPsbpFwMsd3T/Gzp0+qZjk5P
	u4EPqx2y3tFEzorwoYd2Po7gravxEPWNuLMg4phhJuO30F9b8gjaVFFY
X-Gm-Gg: ASbGncuQTdxXQiktrtIm2llNGI7OHvPAxYABWNUS6QPuz1//he/J5vB8D/jglw6QG1K
	AM+1lwGZI6dyEEbhVwl/8E2JMMwMzJH6ZWV7uUF/oHs+bZuy1AFeu3XL1FtraWWj37zmJIi4368
	FEYj4uklWzJCcaOJFvCVFyeaWXyx6YRnT9D4v3fZZ5s9MewCWOiIUWFA93EzWSQZ3MDwoRx4XvG
	6BWFYNFZCpq8RH8+FDe/UuPSsiu8nfftWw7LLo/8SrW1OAD1otpYUvLtest4ElDWVVF8pUVUcSy
	SHdeNEcWBxmrh0b6y5R2xOrLcKhd217ltGiVuZUFlmqCElrrVK16PgoFBrcODqh4hV3bA85SfmZ
	YzbIq1uZ8lcq+pooyW1b1mzbFKVhpph2r7/lcscE6uc8TZ+PllFk1Er2x/NtOQQCTZW1nb3Hd7Y
	vT/CZrKaYman71Bm5rbLhAoXenfn9moZqPTnbzK9fQB6SLIdr7
X-Google-Smtp-Source: AGHT+IHFm4f4DIfuJZeWFWHECmS607MVUrzEbqxwY7bBNABCSqwm+nfFI94x/cfAN4hYxfUSU4FFIA==
X-Received: by 2002:a05:6a00:2e0d:b0:792:574d:b12 with SMTP id d2e1a72fcca58-7ae1d7350a5mr8116654b3a.10.1762424038444;
        Thu, 06 Nov 2025 02:13:58 -0800 (PST)
Received: from ?IPv6:2401:4900:88f4:f6c4:5041:b658:601d:5d75? ([2401:4900:88f4:f6c4:5041:b658:601d:5d75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af825fbc63sm2270481b3a.49.2025.11.06.02.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:13:58 -0800 (PST)
Message-ID: <26b0845236aeeedae68b20765376e6acf3bb0e97.camel@gmail.com>
Subject: Re: [PATCH] net: ethernet: fix uninitialized pointers with free attr
From: ally heev <allyheev@gmail.com>
To: kernel test robot <lkp@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller"	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "K. Y.
 Srinivasan"	 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu	 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Dan Carpenter <error27@gmail.com>
Date: Thu, 06 Nov 2025 15:43:49 +0530
In-Reply-To: <202511061627.TYBaNPrX-lkp@intel.com>
References: 
	<20251105-aheev-uninitialized-free-attr-net-ethernet-v1-1-f6ea84bbd750@gmail.com>
	 <202511061627.TYBaNPrX-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-06 at 17:06 +0800, kernel test robot wrote:
> Hi Ally,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on c9cfc122f03711a5124b4aafab3211cf4d35a2ac]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Ally-Heev/net-ethe=
rnet-fix-uninitialized-pointers-with-free-attr/20251105-192022
> base:   c9cfc122f03711a5124b4aafab3211cf4d35a2ac
> patch link:    https://lore.kernel.org/r/20251105-aheev-uninitialized-fre=
e-attr-net-ethernet-v1-1-f6ea84bbd750%40gmail.com
> patch subject: [PATCH] net: ethernet: fix uninitialized pointers with fre=
e attr
> config: x86_64-randconfig-015-20251106 (https://download.01.org/0day-ci/a=
rchive/20251106/202511061627.TYBaNPrX-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251106/202511061627.TYBaNPrX-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202511061627.TYBaNPrX-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from include/uapi/linux/posix_types.h:5,
>                     from include/uapi/linux/types.h:14,
>                     from include/linux/types.h:6,
>                     from include/linux/objtool_types.h:7,
>                     from include/linux/objtool.h:5,
>                     from arch/x86/include/asm/bug.h:7,
>                     from include/linux/bug.h:5,
>                     from include/linux/vfsdebug.h:5,
>                     from include/linux/fs.h:5,
>                     from include/linux/debugfs.h:15,
>                     from drivers/net/ethernet/microsoft/mana/gdma_main.c:=
4:
>    drivers/net/ethernet/microsoft/mana/gdma_main.c: In function 'irq_setu=
p':
> > > include/linux/stddef.h:8:14: error: invalid initializer
>        8 | #define NULL ((void *)0)
>          |              ^
>    drivers/net/ethernet/microsoft/mana/gdma_main.c:1508:55: note: in expa=
nsion of macro 'NULL'
>     1508 |         cpumask_var_t cpus __free(free_cpumask_var) =3D NULL;
>          |                                                       ^~~~
>=20
>=20
> vim +8 include/linux/stddef.h
>=20
> ^1da177e4c3f41 Linus Torvalds   2005-04-16  6 =20
> ^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
> ^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
> 6e218287432472 Richard Knutsson 2006-09-30  9 =20

Sorry. I think I messed up config somehow during build. Hence, couldn't
catch the error in local. Fixed in v2

