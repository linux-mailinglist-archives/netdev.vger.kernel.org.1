Return-Path: <netdev+bounces-246499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AEDCED5DC
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 22:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA6FB300760D
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 21:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8564621CFFA;
	Thu,  1 Jan 2026 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GcfEsFdO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD54240611
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767303974; cv=none; b=Fkeq+5ccEG5Z0mkevBhTA4HG0GDMnhELJ3Yo3cSAQUjd+5KbihIYXvv4eVbtjz9VcRAjNXYHhZJddvsXqkExinZm3v4oN96BmoIQ9VG1eqdLf/6ZrWZMpEYotD0ZgCPxuSq207s/9xafMTc1nFuyY/eP/Ckjc2J0NTxzzPZgA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767303974; c=relaxed/simple;
	bh=6gpTSrHw38rl/w7scab3B2s/RjjATex9t1kgDLVPCB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kw/s+q83oxC6Ba4lePZcRlkyUK/ryzkOPkXup5AVp4zzjjq/mMOjrvdkMNY1oNQDnnPi6cfFyCgqMTxlSohnQhLoQe6EjawF6/YIh2yDNvI3mIs7SdoJLskwm/Z/ptswcrAHnqBt7hgzgeWz2Nq/PP/zaItdD0zegp1Hf1BN4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GcfEsFdO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso121046715ad.1
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 13:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1767303972; x=1767908772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5blSH3wnz7PXbFZieXRGEw5D2jrirBsMHkqQ+d/vIm0=;
        b=GcfEsFdOtUoM5xm9cnNGNDydkPzC6SafspP6ZOLm4ovi/hdEXykU1sRqLRtbdssLcC
         loEcOx5YCioTIjJXRdCRpHssZK5UReYXvaIPeXIuP/tb1upTkqu5IPZLJYMGI/MuaA9a
         f8EiWzTxE/JUeSnF01Vswyh5fNR3JcauhtDPiWLbhd4I5UXLJ/qp7bd6NzSklH61xVKB
         FZ0kVHviysGa69y2mZsEm/4FGrcMXnUqwedARbM+ev1v4rztdDJK2OQ45BIU2imnpAWv
         3S9zWTpynGrxGvD8z8VcazrqoWeMlXytYAkmu2fJ3LO2d69TpzcAcOWpDgfJsYtGyR02
         o2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767303972; x=1767908772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5blSH3wnz7PXbFZieXRGEw5D2jrirBsMHkqQ+d/vIm0=;
        b=F3ms/fG23kcNE1RUcFJ66Zn/6AP+haXCLSmuwKtyHaRxASkJQbd+eJ/d41LM4VfrAu
         Z4kE18X7Z1pTR4isKTNpsnVW7GnCkmZKBa+UMdO97IKanOBiRtIt6YK7ssOYELh/2COa
         d2g9H/gPZ3P+D6qztHhFi3z1oI3wphXKneJWlX/D/yrtzn3qlA9boLVyLksI2aFUJDvw
         fRH7IHoGvWjk8bd5UKEL2Z/9SKpFW22aJuH0nu75zI8do5EVV2oULh8Y/Xzl/OUt0ZW4
         JIWucPcd1VhpJS2hU7TuE2OHw7A/H0WEqrAgPyzM6dQdRtZt3b0sDIV2pSrD4EzbcWOr
         +udA==
X-Forwarded-Encrypted: i=1; AJvYcCWlogTQRxiwvHpnp/K0VAmZMm74tiQ5zJ6Po1gVzvA7uxZnlzPO0u4xZzrdSnOzNyOcQiAuCX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvaOTqRSKhyIe9VS9uwXt0xIOSak3MhXdhbqKh/krIpZJFkVRX
	GphuiVK2KIdGSFDspApD+E+kBzM/dRQ/EpHMV7XjUDUaoiIibcATKOwaj7G/J0s7WB2tHmgBjjb
	UgHuWvG+/NrDPeVraV0f0DgISPfEpWE7+ia6ruTSM
X-Gm-Gg: AY/fxX4wtNLPx6lXreT2jyXcXg45H5kGE5SoreTK8jMZ/Vw3Ffwx5dtkS4NPEV2zBE2
	sm9oSbXVBvoTZMLkJ0CMyVxRiYXrGsQ7HIWMbTWY9d2seMYKKqQLAjxLbZxYdQ+2F1N4fjLDOpj
	dAvk+5C2G9O7FLv64dGTEmvavc7QxnUX9VFmaRti9e2JAk6VO9moIXBwea4CqmADdFp8xc07j3J
	0u3ighMQfCoF/0yxFbLYcvZzh/skKP0+uZaQyqTRrnSQ+ZVZLR63E5uhmsjX2BGUN81enez37lg
	+PI=
X-Google-Smtp-Source: AGHT+IHJgF8tQVAzrXfaCjgTQEfhyOF4KU5kW7jA/hvH8rjFtgG4aiPuEmPx2T2VA2d0H5R1QMDgCxJR/dPA+u/xjn4=
X-Received: by 2002:a17:902:ec8d:b0:2a0:daa7:8a57 with SMTP id
 d9443c01a7336-2a2f2836573mr396349285ad.30.1767303971965; Thu, 01 Jan 2026
 13:46:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230191814.213789-1-jhs@mojatatu.com> <202601012235.hi5VYzYy-lkp@intel.com>
In-Reply-To: <202601012235.hi5VYzYy-lkp@intel.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 1 Jan 2026 16:45:55 -0500
X-Gm-Features: AQt7F2r5dXv7wShviUh1pTZETegtU7eYoMGvJR5K3MvdK47cld_6fVtmVPB4sQs
Message-ID: <CAM0EoMkqvGtm8=2b+D7_5O1Rmj82ed-+JJpBkeu2JGX7SJudAA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: act_mirred: Fix leak when redirecting
 to self on egress
To: kernel test robot <lkp@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 4:26=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Jamal,

Hi Kernel test robot!

>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jamal-Hadi-Salim/s=
elftests-tc-testing-Add-test-case-redirecting-to-self-on-egress/20251231-03=
1934
> base:   net/main
> patch link:    https://lore.kernel.org/r/20251230191814.213789-1-jhs%40mo=
jatatu.com
> patch subject: [PATCH net 1/2] net/sched: act_mirred: Fix leak when redir=
ecting to self on egress
> config: i386-allnoconfig-bpf (https://download.01.org/0day-ci/archive/202=
60101/202601012235.hi5VYzYy-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260101/202601012235.hi5VYzYy-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601012235.hi5VYzYy-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> net/sched/act_mirred.c:271:41: warning: variable 'at_ingress' is unini=
tialized when used here [-Wuninitialized]
>      271 |         if (dev =3D=3D skb->dev && want_ingress =3D=3D at_ingr=
ess) {
>          |                                                ^~~~~~~~~~
>    net/sched/act_mirred.c:256:17: note: initialize the variable 'at_ingre=
ss' to silence this warning
>      256 |         bool at_ingress;
>          |                        ^
>          |                         =3D 0
>    1 warning generated.
>

You are about 2 days late. See:
https://patchwork.kernel.org/project/netdevbpf/patch/20260101135608.253079-=
2-jhs@mojatatu.com/

[..]

cheers,

jamal

