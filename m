Return-Path: <netdev+bounces-78251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180A987483A
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 07:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B68D1C22C8F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 06:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6576F1C295;
	Thu,  7 Mar 2024 06:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2XuMTd0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E35E1BF2B
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 06:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709793317; cv=none; b=GWt8f/6BrZOnJA+yLRioWFzxRadjADFRnHPaTNDDmf8Ny/5BKP7P6sHUFH4CSAMq/gUcgy4O1aqKY88yKTG5zJAuwsVs0kCwQq9J6VRa1ZZAKbo+lSu5WZ5uj+i1wD558q9a90YJoTeDOCHzMk5RWAnoPfnwSBex2+v2KhakW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709793317; c=relaxed/simple;
	bh=PIffxkyd1VyYEndk3IcSxFHChsYZoSqzYCmiQnyRlOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mu14A8ZbWxYt4bJqTmfoSwjG+zFmjzUbZHVbboGfVXRRNpzYBKGRG/JYAdyzYMg9ubJUQYl/XexTphURUFaiZMCKAvyg42YdrEmbEkLFD2YgY4+XpFNdqqCfcrvoi+9bgyoPJFH2R3ChCnomrAR0A/M2lipU37xMCg8pwE7wKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2XuMTd0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so5411a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 22:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709793314; x=1710398114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPsVPoErqXxMTMnANKvKCPq1bURWpx3Hk4gYw3j9lEk=;
        b=G2XuMTd0/yqjQfYNcHTzjgoe7MKYe+EfK8kEpH8gTCuwhMCo5jSGn7PxW+OziI92kz
         Q5KDk+36OAcdFf/5r2Dy0VnCDDTTOvXhepLlRBkC8J1G/Wo8j4d01SUh4Hg4K26/mV9C
         1xAKC/8zp6SnuR9UK0f/HC3WPRKpuICjSj62Ycbkoc2l3Cy6WjgrsPgDndoUPVPPuRP4
         zneWOoy+UOsvGOCylmCEWG7kYoMm9M1CXwBa0hxGP/s6lbP/CzfiXkpZwrZ0wsWicy26
         RmYD3gECXAL2e/UottXScsEbJHc1ZwS49hFbMh0/7FkrJl3b6eAKrQUBqJW9XDTL2W9b
         /Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709793314; x=1710398114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPsVPoErqXxMTMnANKvKCPq1bURWpx3Hk4gYw3j9lEk=;
        b=niNufvMiSa01IizuwjLDhYbJ9fapBRUsc1uujc4hRvZK4jKnotMKuroseDlD43WAVi
         DCJ1GXdb7c/tDEVLVW8q59Crbm1Zb7Qmehpqns8kohVumyqKAL+oo22Ll41w99uLaz7m
         6qwms1//hiWLRdoJs762r4i8XiblvrJs43v3kI8FKiP/OdC91qUOwxDcT9XkBaatmm9P
         buvegeVlrgMfanmARyY045HK4cu/Pg4m8qx1tgeyfgtTP8yyDk36M9k/Dz/uKjdMlwIm
         ZECMYWKbSUPrQBvp9Uip3W1TovRzpOMAM1zmBOMRnJ/Xt0uOZibMt1q02Ww/WL/sazWW
         xk4A==
X-Forwarded-Encrypted: i=1; AJvYcCXWDF3s1/Rh1hWeXmE30L13EmaEWteJpHPLq1xVOUxFCcsnxWGx0FMw8FzyPnN1OGFAk1jQhnqpEzLd9NSXsHtt7TG3Rrer
X-Gm-Message-State: AOJu0YxWKZW5Pv9aVul9HMgmiMHKzXSbNAAPoVARxlhs1Cjlp9/OvAOS
	0l2u8KqzgO8/BUWqCZ0+xd0nzUoMUYqvmsCTwww6zYNXCeFK3ei6XYIoEo4nTPRTTWw6RhsBMSY
	vfGp3qjxo+AuTl+ATts/LoRe6+OdR2bJKCKX5J5mld8cRqta+Or9O
X-Google-Smtp-Source: AGHT+IGE27wumKChudfquqfT8KAxWBZRqyoYdfEO328uhTv83pF81zZO8tCzQ/jm2iInWNiWxBhJgF5ddE4rF7K2/Yg=
X-Received: by 2002:a05:6402:5202:b0:567:eb05:6d08 with SMTP id
 s2-20020a056402520200b00567eb056d08mr143349edd.6.1709793313634; Wed, 06 Mar
 2024 22:35:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70C97E7F-767B-4E75-A454-E4468505F248@suse.de>
In-Reply-To: <70C97E7F-767B-4E75-A454-E4468505F248@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Mar 2024 07:35:00 +0100
Message-ID: <CANn89iKseL-ihYhrGmbp3D7Fztg97re61wZuaqB61OMBeJbVxQ@mail.gmail.com>
Subject: Re: Doesn't compile commit 0d60d8df6f49 ("dpll: rely on rcu for netdev_dpll_pin()")
To: Coly Li <colyli@suse.de>
Cc: arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 7:14=E2=80=AFAM Coly Li <colyli@suse.de> wrote:
>
> Hi folks,
>
> The commit 0d60d8df6f49 ("dpll: rely on rcu for netdev_dpll_pin()=E2=80=
=9D) doesn=E2=80=99t compile and see the following error message,
>
> colyli@x:~/source/linux/linux> make
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   DESCEND bpf/resolve_btfids
>   INSTALL libsubcmd_headers
>   CC      net/core/dev.o
> In file included from ./arch/x86/include/generated/asm/rwonce.h:1:0,
>                  from ./include/linux/compiler.h:251,
>                  from ./include/linux/instrumented.h:10,
>                  from ./include/linux/uaccess.h:6,
>                  from net/core/dev.c:71:
> net/core/dev.c: In function =E2=80=98netdev_dpll_pin_assign=E2=80=99:
> ./include/linux/rcupdate.h:462:36: error: dereferencing pointer to incomp=
lete type =E2=80=98struct dpll_pin=E2=80=99
>  #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
>                                     ^~~~
> ./include/asm-generic/rwonce.h:55:33: note: in definition of macro =E2=80=
=98__WRITE_ONCE=E2=80=99
>   *(volatile typeof(x) *)&(x) =3D (val);    \
>                                  ^~~
> ./arch/x86/include/asm/barrier.h:67:2: note: in expansion of macro =E2=80=
=98WRITE_ONCE=E2=80=99
>   WRITE_ONCE(*p, v);      \
>   ^~~~~~~~~~
> ./include/asm-generic/barrier.h:172:55: note: in expansion of macro =E2=
=80=98__smp_store_release=E2=80=99
>  #define smp_store_release(p, v) do { kcsan_release(); __smp_store_releas=
e(p, v); } while (0)
>                                                        ^~~~~~~~~~~~~~~~~~=
~
> ./include/linux/rcupdate.h:503:3: note: in expansion of macro =E2=80=98sm=
p_store_release=E2=80=99
>    smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/rcupdate.h:503:25: note: in expansion of macro =E2=80=98R=
CU_INITIALIZER=E2=80=99
>    smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>                          ^~~~~~~~~~~~~~~
> net/core/dev.c:9081:2: note: in expansion of macro =E2=80=98rcu_assign_po=
inter=E2=80=99
>   rcu_assign_pointer(dev->dpll_pin, dpll_pin);
>   ^~~~~~~~~~~~~~~~~~
> make[4]: *** [scripts/Makefile.build:243: net/core/dev.o] Error 1
> make[3]: *** [scripts/Makefile.build:481: net/core] Error 2
> make[2]: *** [scripts/Makefile.build:481: net] Error 2
> make[1]: *** [/home/colyli/source/linux/linux/Makefile:1921: .] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
>
> Can anyone help to take a look? Thanks.

Look at past messages in netdev@ mailing list, refresh your tree to the lat=
est,
you will see this is already discussed and fixed.

289e922582af5b4721ba02e86bde4d9ba918158a dpll: move all dpll<>netdev
helpers to dpll code
9224fc86f1776193650a33a275cac628952f80a9 ice: fix uninitialized dplls
mutex usage
640f41ed33b5a420e05daf395afae85e6b20c003 dpll: fix build failure due
to rcu_dereference_check() on unknown type


Thank you.

