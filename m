Return-Path: <netdev+bounces-213005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AEAB22CD2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D6B684E0A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA282F28EB;
	Tue, 12 Aug 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PAP18Fbj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E762F28E8
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014124; cv=none; b=aAP8MWVDNoUngntlHfSup5IZUiwHEtnKUa45NDB2BoH1iQBVTNO8Y/IaxgmUsOglRUaSzr/lk2a0lRcdrmFIqCBeK3H1YVj3+NmGABI/00w8+TBzTC9Qffrcpm3myDmmrTVSXdjE+rg4kN/iX8ELKRaXdhQMR6wGpesOFSSPgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014124; c=relaxed/simple;
	bh=r0/yEUMM7JPqnefmK7vmUlZWOLUisa+zKgHd/TvVIaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgFRGo/AV9gCLqp1GvGf2yhzslJJtfDawNRroBuueYYNwqJkUsVGmrp4eYJKO5za917H9yPTYkJLfhCT9cGvUyREsGd0MBW/4GyN5/mNHgiOGTRnpJCUF0/hTCUU6wD64bUujn6CCM6U/hnPIWJSZKCp0TEvpJX1bx7nZalwZWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PAP18Fbj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23ffa7b3b30so52907755ad.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755014123; x=1755618923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mcv2bxyNpRc50Ynpw4pPqHAkM7Jzrp/2IvvGq7EcEI=;
        b=PAP18Fbjhqn8BJLnWsJxG1VR5DW5l6rmrqytcAJgutiTpnQP7EbYwyHUDa+SqEOAqG
         jkYeriaxBRGFD9dm5stzRwZP+AjLYGaz6vdv3n0nnk7tUuDRy2/AUK+/QdrbAUJjZtnz
         L6HzQ9cN/GsY07MxjwYFXpj9r4L7h1LXm8UYKNAB+15ekc3jO/iqD/8J65RkAvKHQAaH
         vR7POb3gfDNlAZ62ZKy9FcDXh8RzZ3x7wOBoeFexQpSO9uNPdWSV9kWC3h2jME9mfbx3
         6EeDnf+Tebik0ahFFfZnJ/7GrghYPmzBQ1ki4FiAIKe0LBq9Tm/Vl6USFBZbsLSWlLuX
         Jkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755014123; x=1755618923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mcv2bxyNpRc50Ynpw4pPqHAkM7Jzrp/2IvvGq7EcEI=;
        b=Dv8kqUB5ExlgCybrCLWW0+yRqBeMLhkKOqtTep88UFjoLVbiVkw24bOJacnRheJhEM
         36I+FFxyEw5enAB2kVkbGC43Eb+nRoghqQGDYfbO2kp+WLrPh7KbGYTXE+H9mRs3GB22
         /+CqKkZ4zGWjtns/+6FxnBc4smTK5bQzRZSKzEwlv31HMccvWR+yw90WCHW69xt13Qum
         i3BcFybeVLqo0OFB+9qoG/+OeRZ+vZYPS7XYqmPxutYns6m7+gFHsz5GfAJ29f7Bz3ZI
         dwvdgJ631+LAv52NvTRk+dcpa4h1/bXe0lSBWrcKayJ5Z5cunkH/KE+wmGNgqXsSn1dz
         xIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6ErCeHhFQwWs0OxetKO0jQZCeRCVKCbx3N/cBaMtoZCKCdTW5+CLuvgUyiBU6JcaFTgBrQ+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4e02aM+CSkBPB8Zjxvx5vSd52d0d45w71NrohhuPgUTbU+DRO
	IdWu5q/ohFU4hmXVSysWxlwo21OR+jfOqm0SW3QUi5pPFLtrJLw6q4eiHTxjzTLW/Pe9O9kS0Ad
	RymBd7ykCXrD26IJ39lFtrEGgGPxTUq2C2Gxj3bkC
X-Gm-Gg: ASbGncvCWrd61L6Q+5txoHliR7APBW6feNl36K5Wx5Z5yyfJkwvF2l32aNOcWdwgQza
	yZ5WlheE26Ttl+gF7FqKJwnrm5Ib4r85bANVMs7w4pMIt+bhJM3lmhKvbRo4csh0H05uzVoVS4L
	UjgS9qif3F5EKe9l5l1fmvCOQoRBWjPn01M5CCEwzpmiRlwiJVAxV037s1LevZEA2jNvm7SpL2E
	MVwci0=
X-Google-Smtp-Source: AGHT+IFChq5GEq9GGfaAl4dOo1Sl+YOfAmncpR386ybj+7kBczFF1Z2UKtKOTxU5KLS0Amm9EkxnQU0RhLAZT1wXcRA=
X-Received: by 2002:a17:903:1968:b0:240:11cd:8502 with SMTP id
 d9443c01a7336-2430c008265mr2760005ad.13.1755014122559; Tue, 12 Aug 2025
 08:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811173116.2829786-13-kuniyu@google.com> <202508122213.H31XXZsm-lkp@intel.com>
In-Reply-To: <202508122213.H31XXZsm-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 12 Aug 2025 08:55:11 -0700
X-Gm-Features: Ac12FXze_DG1t-NtmVQ64sQY1bC4hkt6geufHULb5hsjS94rK_uLgU0R6YoMjYE
Message-ID: <CAAVpQUDguV+qG9Aer=o2HS74OP2EdsWHbFx3J654hU3sBnHtRQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
To: kernel test robot <lkp@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	Linux Memory Management List <linux-mm@kvack.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:09=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Kuniyuki,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/=
mptcp-Fix-up-subflow-s-memcg-when-CONFIG_SOCK_CGROUP_DATA-n/20250812-013522
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20250811173116.2829786-13-kuniyu=
%40google.com
> patch subject: [PATCH v2 net-next 12/12] net-memcg: Decouple controlled m=
emcg from global protocol memory accounting.
> config: csky-randconfig-002-20250812 (https://download.01.org/0day-ci/arc=
hive/20250812/202508122213.H31XXZsm-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 10.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250812/202508122213.H31XXZsm-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508122213.H31XXZsm-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/cleanup.h:5,
>                     from include/linux/irqflags.h:17,
>                     from include/asm-generic/cmpxchg.h:15,
>                     from arch/csky/include/asm/cmpxchg.h:162,
>                     from include/asm-generic/atomic.h:12,
>                     from arch/csky/include/asm/atomic.h:199,
>                     from include/linux/atomic.h:7,
>                     from include/crypto/aead.h:11,
>                     from net/tls/tls_device.c:32:
>    net/tls/tls_device.c: In function 'tls_do_allocation':
> >> net/tls/tls_device.c:374:8: error: implicit declaration of function 's=
k_should_enter_memory_pressure'; did you mean 'tcp_enter_memory_pressure'? =
[-Werror=3Dimplicit-function-declaration]
>      374 |    if (sk_should_enter_memory_pressure(sk))
>          |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Oops, forgot to enable kTLS and allmodconfig.
Will add #include <net/proto_memory.h> there in v3.

