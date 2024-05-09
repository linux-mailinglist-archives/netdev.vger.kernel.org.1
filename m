Return-Path: <netdev+bounces-94823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676F8C0C81
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE222285D9B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A26014A4C8;
	Thu,  9 May 2024 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e31Tk+lr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2514A0B7
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243147; cv=none; b=lQhav3Yt+i8BPbXFbYglepjjMbQlamvULPBGBAZ8hnDUfI+Wlo7JVEkkCW0Pg82LvY742q/rOjQrgke0d4jlJxT5iiNYhOsvd7+eL8oer9rHRBeGGYpJRzRCKU+4rYl1yWKUFkdoRg5Rpz2zk4eVx29m5agkIEVoW6G7/jOmUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243147; c=relaxed/simple;
	bh=6de1OuVin/1TKmuo5RwjirrKHZ8hQTkZpSXpGp0qFVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+3SvysghWW4LhrVa64P6MfN1g6WDjyaknSCeoSiQ6hbuQ3kOapYpw8bu/lWHW8r4QGI7wahJULvXF9aJx/P107CIYd9Go0MXXZfGPHuzUyDgocN/F4tkER0LjcrnjrKNhedfGFbsnDRsAVqfBk2YgM10FtmNJSK84Y2Grv1DB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e31Tk+lr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso9773a12.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 01:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715243129; x=1715847929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXWL+fp9thGcVKthzYUPa2+h322jRzxE5eeJp5R44m8=;
        b=e31Tk+lrhEDM63KH2gc16k5prPYSbvTDIhJ6wnI5Ukc97s8s86nNMU8Hx6pydcRRhd
         WhvSOok7NS+J8Kj4lkZw5a7gdmLl8IHRhEqp+ia19x7U5MXasHeFWcKibWllQ3W59Y5C
         x5rQpzGocQbrmR/qVZiiocczDxcY/xifedFNZ462Q2iSGlM77T5rkaB067QMmbXveeqB
         xoJqZF/AaTnN8EUByf03OndChy3U2yT0Pk0+gKyRWZ4p7AD3NZ3ceLoBxD2nOsg/yxZ0
         anbH+W+P1lay2AhKKSn0WkhoWBJjAtF/GnliLX0DRSe6UEmB3UAUKKsQSJYFeINyeoDn
         hWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715243129; x=1715847929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXWL+fp9thGcVKthzYUPa2+h322jRzxE5eeJp5R44m8=;
        b=T+VBy9g0KOY+D/aDFHwKRVZiKdA+5a5FTJi24o3fDgWsIgzptToNJM5e4FWCTAcD6+
         Fy1/stXRJVWrYzFul3xrlBHUZy0yviMB/LK8U8sPJGJ8U+G3k+P6BBZI2PZACPvtbqsO
         AySBPQitrHzmvsdI9yKWD7ivi3urwPlA8npIvR+bXdDzrUvpxe6Fx10OzXYy5wGmGzpP
         Y3DoVnhw4bSLKWgfr8F8F15mFAyI/tqnRJgnJo/qFs5amBnCz8s0TWJ5nGPKcHsQXxnY
         rTIu0LjZvbkLfYHlXEduoLdt8YOSo0nQS7TpdUT+dHlr5bwkNICo57UAvAZ8NLwna4i+
         Mrwg==
X-Forwarded-Encrypted: i=1; AJvYcCWK7gd7/F7y1F2kPzvuipq9tg58dimXYCgGG1I+vOAL4x57hmheCNY59M96TbEGOmqcv0aVqBj2g13g0UA4hddO2JpnAQ/r
X-Gm-Message-State: AOJu0Yz6lpt4ahMj63ggBzdonjdQZfJywyZ1q/Bqm+BrhnlEzVS+yqDy
	RoXGC3LHOVEzt+/Coms5EhKxoWB53i4bdBIRvIfsP0rJ7GxM14+9Z3VrIt+233BHVct2eL+wHPG
	sqo8rt1sH0pjDGW0yzKxkD0Xws5Sr/vjDND4N+6D1dXADo+19Iqvv
X-Google-Smtp-Source: AGHT+IEBb3fkt7PS3dSxfVEhOctV9ND4hE7/VpA2DYo+vsphPwKBGxq8jj2thNiHzHYF11+V5GhJ13pBNa4Jmw33gH4=
X-Received: by 2002:a50:85c5:0:b0:573:438c:7789 with SMTP id
 4fb4d7f45d1cf-573438c7b65mr18557a12.1.1715243129012; Thu, 09 May 2024
 01:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508075159.1646031-1-edumazet@google.com> <202405091310.KvncIecx-lkp@intel.com>
In-Reply-To: <202405091310.KvncIecx-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 May 2024 10:25:18 +0200
Message-ID: <CANn89iJvTqGtSzyPFXTzomcG=ThyFC-jVcjcE9jBE0Tpd26C9g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: usb: smsc95xx: stop lying about skb->truesize
To: kernel test robot <lkp@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Steve Glendinning <steve.glendinning@shawell.net>, 
	UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:01=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Eric,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-u=
sb-smsc95xx-stop-lying-about-skb-truesize/20240508-155316
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240508075159.1646031-1-edumaze=
t%40google.com
> patch subject: [PATCH v2 net-next] net: usb: smsc95xx: stop lying about s=
kb->truesize
> config: arc-randconfig-r132-20240509 (https://download.01.org/0day-ci/arc=
hive/20240509/202405091310.KvncIecx-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20240509/202405091310=
.KvncIecx-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405091310.KvncIecx-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> drivers/net/usb/smsc95xx.c:1815:19: sparse: sparse: incorrect type in =
assignment (different base types) @@     expected restricted __wsum [userty=
pe] csum @@     got unsigned short x @@
>    drivers/net/usb/smsc95xx.c:1815:19: sparse:     expected restricted __=
wsum [usertype] csum
>    drivers/net/usb/smsc95xx.c:1815:19: sparse:     got unsigned short x
>    drivers/net/usb/smsc95xx.c: note: in included file (through include/ne=
t/checksum.h, include/linux/skbuff.h, include/net/net_namespace.h, ...):
>    arch/arc/include/asm/checksum.h:27:26: sparse: sparse: restricted __ws=
um degrades to integer
>    arch/arc/include/asm/checksum.h:27:36: sparse: sparse: restricted __ws=
um degrades to integer
>    arch/arc/include/asm/checksum.h:29:11: sparse: sparse: bad assignment =
(-=3D) to restricted __wsum
>    arch/arc/include/asm/checksum.h:30:16: sparse: sparse: restricted __ws=
um degrades to integer
>    arch/arc/include/asm/checksum.h:30:18: sparse: sparse: incorrect type =
in return expression (different base types) @@     expected restricted __su=
m16 @@     got unsigned int @@
>    arch/arc/include/asm/checksum.h:30:18: sparse:     expected restricted=
 __sum16
>    arch/arc/include/asm/checksum.h:30:18: sparse:     got unsigned int
>
> vim +1815 drivers/net/usb/smsc95xx.c
>
>   1810
>   1811  static void smsc95xx_rx_csum_offload(struct sk_buff *skb)
>   1812  {
>   1813          u16 *csum_ptr =3D (u16 *)(skb_tail_pointer(skb) - 2);
>   1814
> > 1815          skb->csum =3D get_unaligned(csum_ptr);
>   1816          skb->ip_summed =3D CHECKSUM_COMPLETE;
>   1817          skb_trim(skb, skb->len - 2); /* remove csum */
>   1818  }
>   1819
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


Please note this is not a new warning. Prior to my change we had :

drivers/net/usb/smsc95xx.c:1813:19: warning: incorrect type in
assignment (different base types)
drivers/net/usb/smsc95xx.c:1813:19:    expected restricted __wsum
[usertype] csum
drivers/net/usb/smsc95xx.c:1813:19:    got unsigned short [usertype]

I will submit a v3, to _also_ fix the sparse warning.

