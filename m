Return-Path: <netdev+bounces-70237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D761A84E20A
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C4D2B2443C
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F8F76413;
	Thu,  8 Feb 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4mi+XCn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE7776406
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399329; cv=none; b=OcPpGq4fsmCm8dBinvMi3iMrcutvow8mYRBtRF4J7EhHeUxWDw73RREd5GCRPQolAF0YnHD6IVUadTJ6Aqqb0uitWscIRrDh8TIdHza+AkYOXlVtbAetMdkR8OL0bi44kXIIz20ofIuJ01WfE0Vuei+aX2cTaryEsI56qB8/Nfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399329; c=relaxed/simple;
	bh=2h8Chmu0bOFl+lqBM3CEpFhy+LcorAhDE0bSby1h7vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiaIXloPNbIHv9XFWmJY2kGPaj7GarEMZo9/96TkZfdtaFWvakUZqXIX//QuhE/6guizXjoOcZqIdh6SR2Q+ew1FcX1xlVT6NCiXAJPyqqShac9DKCYQ9ddOfapozYGMxifWfevpPlq2XN1johTVkIt7TsUVRWMlLrff10mxWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4mi+XCn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-560530f4e21so11264a12.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 05:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707399324; x=1708004124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQ5SV2QSatUSY6hvPoK0c0jwTyeQgfDQaS3+98ICbFo=;
        b=C4mi+XCnxYhX1QKtZRlZG1YQaWBrP42lOyRG3ZQqT1uWjhSYBFUyz8E1Lj0/6tfpW/
         sG3X+zm1GU9+hR9Cnw8a7R1UUJbQRtsxDBURMDSKpXzUvfBM4M+R+id4/e83ElAGK3Vu
         IT+fXDjSBhtdhnSt75/dItsrw1FODcbQoggo9O2b1Mq8REz0CFo/UbuQf38zDVpKfptq
         Z7RaSrerFdgX5nOoGy0RIWPk4De/ZDVQOlwWwaQmcsZtWxCdWRcEeNgBzJVS7pTxykXN
         NvgTz2QUMk9LBL+n4q7+OLC11mIOIBUdfWLAn89K5VdhucNxcYRqGBhShYRX2JhET628
         CmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707399324; x=1708004124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQ5SV2QSatUSY6hvPoK0c0jwTyeQgfDQaS3+98ICbFo=;
        b=RXSboZcj+wPBsL+pdrHF3EzzEFeNPaLocXgyHv06OrpjZC2HQ6b6RmLybJSJCxjzkW
         b4e4XFChoxrvDpV8s0MzCjPlMV/oal3eGOgBo10IkVAqjiSyOZHwSRjxfAv8zOZ5f1pD
         qjI7fPkuI3M3cIvGkw5LpJu/iCzFzZYYh/uKw0cJNo5LtiphthDS5igqFsx8CRwpJT4N
         tdCZdjs0WxJS33fw/uUbBBWpL0jNI1pjDEHT4txynUss+azTKkags+56KO46FgzAdJ9r
         aS70UtbRuth0x6oPieRUKqhG74Z7p+VcRfnO3rN48tiPgawxBYncBdLmPV259gmlbvOX
         raMA==
X-Forwarded-Encrypted: i=1; AJvYcCU+tMgL+wB2Sct0MH5HNsdfDg96YPHMfLvnyGiLPfHVsyeJQ/inYqT2JNzxUS8j5ZW5md3/NsrfWGhXQiL/Yuke/S8isSCf
X-Gm-Message-State: AOJu0YxWunJRRDtairqxEkmt+HMNbAUhPpSf+rzISIOO8JDe2vOb/VhP
	TKvHGgb6NhkMY3GznHQOtmyQ3mtlB2LLxLibHsjBoLhjilIJIwnhwv1b9C9+4djAcZJk4mpFrCr
	qDDa/QG+FVIPbHkKx/n/LL9eWVuiaOZMEUeG1
X-Google-Smtp-Source: AGHT+IGYls60+/k8r8Q2Dcs9PLnGPZ3KgkcPy8oiu2YQjIAEhESrhu03JsI4ixOnmhIdHlYX3bMynNdlkGyPGTEJj7w=
X-Received: by 2002:a50:f694:0:b0:560:e397:6e79 with SMTP id
 d20-20020a50f694000000b00560e3976e79mr318931edn.2.1707399324033; Thu, 08 Feb
 2024 05:35:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207142629.3456570-11-edumazet@google.com> <202402082151.O18ZoLSK-lkp@intel.com>
In-Reply-To: <202402082151.O18ZoLSK-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Feb 2024 14:35:07 +0100
Message-ID: <CANn89iKQ6-MY2KtPU79P8RTZDc7D_Wp8h6F2+io1ab9E1kn3zQ@mail.gmail.com>
Subject: Re: [PATCH net-next 10/13] net: add netdev_set_operstate() helper
To: kernel test robot <lkp@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 2:20=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Eric,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-a=
nnotate-data-races-around-dev-name_assign_type/20240207-222903
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240207142629.3456570-11-edumaz=
et%40google.com
> patch subject: [PATCH net-next 10/13] net: add netdev_set_operstate() hel=
per
> config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240208=
/202402082151.O18ZoLSK-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7=
dd790db8b77c4a833c06632e903dc4f13877a64)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240208/202402082151.O18ZoLSK-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402082151.O18ZoLSK-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> net/core/rtnetlink.c:852:12: error: call to '__compiletime_assert_784'=
 declared with 'error' attribute: BUILD_BUG failed
>      852 |         } while (!try_cmpxchg(&dev->operstate, &old, newstate)=
);
>          |                   ^
>    include/linux/atomic/atomic-instrumented.h:4838:2: note: expanded from=
 macro 'try_cmpxchg'
>     4838 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>          |         ^
>    include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from=
 macro 'raw_try_cmpxchg'
>      192 |         ___r =3D raw_cmpxchg((_ptr), ___o, (_new)); \
>          |                ^
>    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from=
 macro 'raw_cmpxchg'
>       55 | #define raw_cmpxchg arch_cmpxchg
>          |                     ^
>    note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=
=3D0 to see all)
>    include/linux/compiler_types.h:423:2: note: expanded from macro '_comp=
iletime_assert'
>      423 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^
>    include/linux/compiler_types.h:416:4: note: expanded from macro '__com=
piletime_assert'
>      416 |                         prefix ## suffix();                   =
          \
>          |                         ^
>    <scratch space>:50:1: note: expanded from here
>       50 | __compiletime_assert_784
>          | ^
> >> net/core/rtnetlink.c:852:12: error: call to '__compiletime_assert_784'=
 declared with 'error' attribute: BUILD_BUG failed
>    include/linux/atomic/atomic-instrumented.h:4838:2: note: expanded from=
 macro 'try_cmpxchg'
>     4838 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>          |         ^
>    include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from=
 macro 'raw_try_cmpxchg'
>      192 |         ___r =3D raw_cmpxchg((_ptr), ___o, (_new)); \
>          |                ^
>    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from=
 macro 'raw_cmpxchg'
>       55 | #define raw_cmpxchg arch_cmpxchg
>          |                     ^
>    note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=
=3D0 to see all)
>    include/linux/compiler_types.h:423:2: note: expanded from macro '_comp=
iletime_assert'
>      423 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^
>    include/linux/compiler_types.h:416:4: note: expanded from macro '__com=
piletime_assert'
>      416 |                         prefix ## suffix();                   =
          \
>          |                         ^
>    <scratch space>:50:1: note: expanded from here
>       50 | __compiletime_assert_784
>          | ^
> >> net/core/rtnetlink.c:852:12: error: call to '__compiletime_assert_784'=
 declared with 'error' attribute: BUILD_BUG failed
>    include/linux/atomic/atomic-instrumented.h:4838:2: note: expanded from=
 macro 'try_cmpxchg'
>     4838 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>          |         ^
>    include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from=
 macro 'raw_try_cmpxchg'
>      192 |         ___r =3D raw_cmpxchg((_ptr), ___o, (_new)); \
>          |                ^
>    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from=
 macro 'raw_cmpxchg'
>       55 | #define raw_cmpxchg arch_cmpxchg
>          |                     ^
>    note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=
=3D0 to see all)
>    include/linux/compiler_types.h:423:2: note: expanded from macro '_comp=
iletime_assert'
>      423 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^
>    include/linux/compiler_types.h:416:4: note: expanded from macro '__com=
piletime_assert'
>      416 |                         prefix ## suffix();                   =
          \
>          |                         ^
>    <scratch space>:50:1: note: expanded from here
>       50 | __compiletime_assert_784
>          | ^
>    3 errors generated.
>
>
> vim +852 net/core/rtnetlink.c
>
>    844
>    845  void netdev_set_operstate(struct net_device *dev, int newstate)
>    846  {
>    847          unsigned char old =3D READ_ONCE(dev->operstate);
>    848
>    849          do {
>    850                  if (old =3D=3D newstate)
>    851                          return;
>  > 852          } while (!try_cmpxchg(&dev->operstate, &old, newstate));
>    853
>    854          netdev_state_change(dev);
>    855  }
>    856  EXPORT_SYMBOL(netdev_set_operstate);
>    857
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Ok, some arches are unable to perform cmpxchg() on u8, only plain
32bit integers.

I will send a v2 then.

