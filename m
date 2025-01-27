Return-Path: <netdev+bounces-161090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFACA1D444
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 11:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAE118882C0
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE56B1FCFE5;
	Mon, 27 Jan 2025 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeqIpRGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472111FC7D3;
	Mon, 27 Jan 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973208; cv=none; b=NwQKTz/V/aRS/LUEQEP37l7xaw1GNNw2TsIbPcKy9Ccdv6dq+onFV2zD9Gn3CRsf7vkbWoDxYs54Bt7kYCBLYl3d4kcPdRxtqPHFQhbtU63q8tQJK8AlKjvkM3x5CM9LurhRqV79PjQRZmcwgJqcWRgfgOgt9Ob/kkpPXq3CVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973208; c=relaxed/simple;
	bh=pHI8nT9tX06VZba+Qy/u+b6PysIrs2+wh1W6z+gCEaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJFttYfIxc6sNxL5XAn2+20o4lgezl9XC+EhhwzAwaIjapVlIyidtz1brU3lx2LU/uEA37SbG9cmxOcpUoWVW4C69fWmlQPzIhOkjct2wRbkndwTz1mHt0TIN+1NvIrAwUVeamDOv9gRBIWzLeiPOIuoWJMm9kMtNZy4N1SOK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeqIpRGZ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-844eac51429so347926839f.2;
        Mon, 27 Jan 2025 02:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737973206; x=1738578006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sckdr71MrnKjBSWxkzb932HcRLBhiMEG/B2/474sLNA=;
        b=AeqIpRGZgfeQAldzCVzY7aq/nfMkUmUYn3w3z4fZnQ9i+rgezNo/4QaCTcpJe8TXdj
         Q++Aa/P4Ike5ohgL/GW2cO+izzCvPENHPAPRhfcqagiAxB+m7VZBeKHwo2SgbJ0Sx/sm
         X4Wiem6m74ASJgqQ0KxwMJr+ZVnIhAN3OLqftohCT9f9bukwijoaJPaDvXb60wLK50a+
         FSvKL9166/5k0ySFyFExgMlxpxU/Xx/LFwI0vnyxti4ApnrdTuHCSGPOi+5SYTL9lI9f
         bxKem7Ai9mogfvTeFGqSe68lpZE+9NMkE6AlTjwGlqk4h1HMPy3qHRgtHHLZ041VPF1e
         qzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737973206; x=1738578006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sckdr71MrnKjBSWxkzb932HcRLBhiMEG/B2/474sLNA=;
        b=rz5RiQqFVm6Na3R17mLORNz2HvXdUBURRN4NbKPjRL3rGOZDcsoMjys4eZIMvlKMYX
         YgGhDNVZLlEygl/Wp0Q1nyOMDrMjcvgR6ehKRpySsb8gByPcQzZkjPu+f5n/XWvgcge8
         17lP9j5NeopUaB081ab+Y46MWdNEJ3BIdQDd7pInwyoU7tKlC7hRdUJ1BsQnly5cSn3g
         WXak6efJ25WEd2UwS6KuFizfxmOWzahrhddMXiczgIo5WfLiowija63fgh7vuev0w+wM
         vYSJmUQxG2fP8GYFvuMpQOYfj98tyvD4zdf5w3vSLEner99cDLgj9GBpg5/2zuUCVBjz
         zWxg==
X-Forwarded-Encrypted: i=1; AJvYcCW3FKzFHSJtNf+Yt6glCpq59ZuvV6rc1jddsvQpHlV2xdRgeyYNL7cxNQ8bh+K7bhDsHjMTjQKvdX5hgiY=@vger.kernel.org, AJvYcCXGQ9C5GS5XlKWVe8jl7OnFTkwCfLLYg7vkR5S6Y0kPXIjoj2aT5qQqN1f+nDXjrezvsoh69fmf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4fd+8WCbnf1XSt8a2BfLYSsm3G2IeEnpJERsXXj2YOdsWj98g
	W/eWN4FxY4XNQ9tw1sKrTlUmcF5boPFNoKzRrHT3Roerfg4ZXwq2+pOdIMbI2oFspSWVvWJ1qZM
	miVJZLPT0Kdsbvb8wVQa2kd/PhHcaWA==
X-Gm-Gg: ASbGncvFRZ0k2Y9aprlpyaxL2B/RbjW49zBLVn3+M2X4MyXQb1LfTA1X4HPYtfdciYx
	9j8TxdwTBnUUapg/SHhxfZBaSVuF5EeqJaKy+i8D+fy4zYCkhkFFEX0AmoA6ESdxdxP4czZ0s
X-Google-Smtp-Source: AGHT+IH+oQffYDjVTEsZUgquRRYzcp2aVY/U1Tlc+chFH/eaQzlzqpFS/VT0LzpDx9GoCkmkV/XiWPmeS0X2EUnCIu4=
X-Received: by 2002:a05:6e02:16cb:b0:3cf:cdb8:78fb with SMTP id
 e9e14a558f8ab-3cfcdb87ac6mr90820885ab.16.1737973206316; Mon, 27 Jan 2025
 02:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202501261315.c6c7dbb4-lkp@intel.com> <CAL+tcoBBjLsmWUt9PkzDhVtGLm-s53EyTzcHhpTkVnLpgz0FXw@mail.gmail.com>
In-Reply-To: <CAL+tcoBBjLsmWUt9PkzDhVtGLm-s53EyTzcHhpTkVnLpgz0FXw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 27 Jan 2025 18:19:30 +0800
X-Gm-Features: AWEUYZkHEbWK10UcMluPXye9arxpRxbeEpiKlDFBBrcOJIjVFyWB1-42gpACmvM
Message-ID: <CAL+tcoBmRVKUfhR8DiMryD4h5ZJeQpGuhPyzK3fexiEBvE_KDA@mail.gmail.com>
Subject: Re: [linus:master] [tcp_cubic] 25c1a9ca53: packetdrill.packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv4-mapped-v6.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: Mahdi Arghavani <ma.arghavani@yahoo.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Neal Cardwell <ncardwell@google.com>, Eric Dumazet <edumazet@google.com>, 
	Haibo Zhang <haibo.zhang@otago.ac.nz>, David Eyers <david.eyers@otago.ac.nz>, 
	Abbas Arghavani <abbas.arghavani@mdu.se>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 4:49=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Sun, Jan 26, 2025 at 2:30=E2=80=AFPM kernel test robot <oliver.sang@in=
tel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "packetdrill.packetdrill/gtests/net/tcp/cubic=
/cubic-bulk-166k-idle-restart_ipv4-mapped-v6.fail" on:
> >
> > (
> > in fact, there are other failed cases which can pass on parent:
> >
> > 4395a44acb15850e 25c1a9ca53db5780757e7f53e68
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :6          100%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv4-mapped-v6.fail
> >            :6          100%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv4.fail
> >            :6          100%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv6.fail
> >            :6          100%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/cubic/cubic-bulk-166k_ipv4-mapped-v6.fail
> >            :6          100%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/cubic/cubic-bulk-166k_ipv4.fail
> >            :6          100%           6:6     packetdrill.packetdrill/g=
tests/net/tcp/cubic/cubic-bulk-166k_ipv6.fail
>
> Thanks for the report. I remembered that Mahdi once modified/adjusted
> some of them, please see the link[1].
>
> [1]: https://lore.kernel.org/all/223960459.607292.1737102176209@mail.yaho=
o.com/
>
> I think we're supposed to update them altogether?

Should the updated pkt scripts target net or net-next tree, BTW?

Thanks,
Jason

>
> Thanks,
> Jason
>
> > )
> >
> > commit: 25c1a9ca53db5780757e7f53e688b8f916821baa ("tcp_cubic: fix incor=
rect HyStart round start detection")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > [test failed on linus/master      405057718a1f9074133979a9f2ff0c9fa4a19=
948]
> > [test failed on linux-next/master 5ffa57f6eecefababb8cbe327222ef171943b=
183]
> >
> > in testcase: packetdrill
> > version: packetdrill-x86_64-8d63bbc-1_20250115
> > with following parameters:
> >
> >
> > config: x86_64-rhel-9.4-func
> > compiler: gcc-12
> > test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40G=
Hz (Haswell) with 8G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202501261315.c6c7dbb4-lkp@inte=
l.com
> >
> >
> >
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-=
idle-restart.pkt (ipv4-mapped-v6)]
> > stdout:
> > 20
> > 30
> > 36
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-=
idle-restart.pkt (ipv6)]
> > stdout:
> > 20
> > 30
> > 36
> > stderr:
> >
> > ...
> >
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-=
idle-restart.pkt (ipv4)]
> > stdout:
> > 20
> > 30
> > 36
> > stderr:
> >
> > ...
> >
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k.=
pkt (ipv4)]
> > stdout:
> > 20
> > 30
> > 36
> > stderr:
> >
> > ...
> >
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k.=
pkt (ipv4-mapped-v6)]
> > stdout:
> > 20
> > 30
> > 36
> > stderr:
> >
> > ...
> >
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k.=
pkt (ipv6)]
> > stdout:
> > 20
> > 30
> > 36
> > stderr:
> >
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250126/202501261315.c6c7dbb4-=
lkp@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >

