Return-Path: <netdev+bounces-70625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF67B84FD44
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B5D28ACCB
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 19:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57684A53;
	Fri,  9 Feb 2024 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wyriwFU8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFB84E1A2
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508714; cv=none; b=jNC96r8/OPipDya4I1QuMvgrInDlzSH9TF2EWUGFlYQ9f+QeOv3JZT0hLGtWligQJDeQBA6iyYJ9BJ/rRvYqCvt8Sf2dQASXfID/b7gmwofcr65CYsR5yGmMo2POvUYDef982Q83f387D4SXnS3RkhOP2xdLOGiQTZ3JITo+zVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508714; c=relaxed/simple;
	bh=eD9EQcFDBNiBgcU5tvMZBRIekyRKjj9vzifDaj4xy+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfnjqJV7glFHzZN+9tRqC+OtiN3fybcISyUNvVE40yBHhf6FSNr6O/qugu5OuTmvfVh2ecTjktgxmfsMjxxPm9uyRZvVnBxVfP9OCgcpjO9vd29z3EwoLWbhnsv6i1NJUGVPJ15qVjQGnr6OfG/5Q3uhnv9/WWvVzPEYRYC/e1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wyriwFU8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so31941a12.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 11:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707508711; x=1708113511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p20YnXv7NpCJx02QrzV6jlP0H9fDT2JyoFdNhx5bIEA=;
        b=wyriwFU8Ae9V8bemiik4vZ9fboHfx1a/bR+mfxzugCHRPiSug5OALC/geHU0sXLKs8
         RQ6wJa+LI5BOFEhoUxD8X8Tr0vw3cWEu9Hh1S6oEfuYV3QBhrd/k3HvlO/zc1AeP0jzd
         tsf0dcrLL+sYDkvrIqemfp/0nRtJClESGD1D8VvpMLMWpyBlqUw/epL3rU9wymjLqfmZ
         Dql3+OQnQ74RG/ydFY8CoAjqxfCVewAN+XjUc7TkhDhOkzhqiVtvHqBA0aJwj0OWdisj
         mAlpXuLKYdpL/6cHgxZvLpGmVb3DNjQ5NqHPJmOVRzMWl7BMfnUXgXXup73ogYyIuj2r
         8lfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707508711; x=1708113511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p20YnXv7NpCJx02QrzV6jlP0H9fDT2JyoFdNhx5bIEA=;
        b=uz/KJh5Y5xY2NKUkzV1p3dwKTyWfCBW2vMDgdSEOtpz7hJH8n1QbennPTafcGYBSOl
         wjQKQMoBVJkr49qz8bAW52Y9Z4j7n645PGiroY/8rkSkZrvWsfqjiLNqEij8PHiq+vk2
         r0/C/U+Fv0p1XjB/UpJiKe7g923Z1kvVScxlCbXqjvypnE/MprjTSLhmWlH2juscUUjd
         6NXoz6GBFAd3mdfZdgJOKtv6UE1tgBoBhyjll5JoSKjuVMnEn69NGBEcTIADtgN85rue
         k0x9ub4PtDndcXMBWhW1FjlU9BFXQNIeNkTnJ/FuiXHGE80c76EVFKlOdz4LD46Stt8C
         bQIA==
X-Gm-Message-State: AOJu0Ywa6NKcVzOlrWsuVsHm4AnOl2+3J/mkrywqR/BZH3IjRIO9iRqk
	PaGkAPXERmlzrpBtv/Nh7kLbV6rMy2Gp891Kn0OICjRKRLJ6FCa+JgOa+P5d2XZJYurnvhpnDW0
	gmDDfr2MvnWaDG34bUXQvYteuhxPZFMNOWIT+
X-Google-Smtp-Source: AGHT+IGJN2AMdvjrJdhIoLmn1ZUADI/e7sMUkA35RQJWoOSTrSGAMPfObja6Fhu4Ifki9/iguSDWuW03WbCKF92s7v8=
X-Received: by 2002:a50:c30b:0:b0:561:207f:d089 with SMTP id
 a11-20020a50c30b000000b00561207fd089mr194005edb.6.1707508710608; Fri, 09 Feb
 2024 11:58:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208141154.1131622-11-edumazet@google.com> <202402100218.Gmr6NGqc-lkp@intel.com>
In-Reply-To: <202402100218.Gmr6NGqc-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 9 Feb 2024 20:58:16 +0100
Message-ID: <CANn89iKPjqXu9EBHsGcvdpZmC7ZRFFt_aKixiP0=bXN9wRDs0g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 10/13] net: add netdev_set_operstate() helper
To: kernel test robot <lkp@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 8:13=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Eric,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-a=
nnotate-data-races-around-dev-name_assign_type/20240208-222037
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240208141154.1131622-11-edumaz=
et%40google.com
> patch subject: [PATCH v2 net-next 10/13] net: add netdev_set_operstate() =
helper
> config: sh-sh2007_defconfig (https://download.01.org/0day-ci/archive/2024=
0210/202402100218.Gmr6NGqc-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240210/202402100218.Gmr6NGqc-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402100218.Gmr6NGqc-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    sh4-linux-ld: net/core/rtnetlink.o: in function `set_operstate':
> >> net/core/rtnetlink.c:873:(.text+0x1140): undefined reference to `__cmp=
xchg_called_with_bad_pointer'
>    sh4-linux-ld: net/core/rtnetlink.o: in function `netdev_set_operstate'=
:
>    net/core/rtnetlink.c:855:(.text+0x16d0): undefined reference to `__cmp=
xchg_called_with_bad_pointer'
>

Ah right, there was also dev->operstate.

These old arches...

