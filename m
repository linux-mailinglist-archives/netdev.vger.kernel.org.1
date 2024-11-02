Return-Path: <netdev+bounces-141236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE03F9BA225
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 20:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3551C20C1C
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 19:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157BF1AAE2B;
	Sat,  2 Nov 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="VF0ObNLZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B91A76DA
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730576431; cv=none; b=rFge9nrErqxCB47sjsPY5BraOQs7bm6s0Cvd9BT1hs7GttKcT/fyJr/eBXbpxi19v9o8VoLUtfqqJI7js85ei+0q79fiod7QVprGvX45UyOhA+Qr0lbBygwcoOC7ErsL1yl9wh0LTqnJ6kkUjDgpZoZ7WciYW+DUddAaUb/USV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730576431; c=relaxed/simple;
	bh=tqKWZX9NC2TsEIz6a8/PdbxqsLuzdYbMTh+Un4Gpiwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flMDt+0XT6Li4mUImvrwERjOG7QXSpTU23bXcpCzwFGSqcfJGbThTmHAqanMx5d5fKyo/ITrkQVlIIaXEgmXXx2YR/OSQpKE14xZEuvbZcFDTU7eo1MmFOUX47dkwnzmtajBPGjfNj9+h6+hP0RSfCCM44UsrbnjJ+u0AE/sTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=VF0ObNLZ; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qd9zKfQuk1UuRFf2kp23YND7Ck7jdbthiny6qGk1pfM=; t=1730576429; x=1731440429; 
	b=VF0ObNLZqRCI4DM1wKDpfa6gdrdKG0JgIL8P0i37sixD7L4ibJzgIsgaltL0gLMEqSPqtOLjqMy
	TqVJ/6+PSoIm5l+R5S5Dmzlv7QLwbziiqn5pexw5BsEcuhXMuCb0dJAoIbw6oCop591p6Qon9Xx3z
	b3ZBdTcAYutvS8+ulj7xmfFffJc3YglBaHLBAtETqKmK7Gp/Vu5W8Kls4iNOOLfImmQFLNirZrynd
	9JstMoTjE+IrJOLdc+7moAxyJoWX6WEhm7YGrITkuQe6VUNvY80U7Tio465RHxAuhBqA3xg1wydyN
	bsh99/mvRVqgks7gTwM8a1EGE7eA8xeoDw7w==;
Received: from mail-oo1-f54.google.com ([209.85.161.54]:52387)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t7Jyw-0006h1-DG
	for netdev@vger.kernel.org; Sat, 02 Nov 2024 12:40:23 -0700
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ec6bdd9923so1515507eaf.0
        for <netdev@vger.kernel.org>; Sat, 02 Nov 2024 12:40:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YwptxKsSXF0y1m9lBGlIbI4/8OCNaf4SgiVOno9EwT63fUfG7bZ
	3fLN0Yo9Vw63PrNO27WAIBRqwgccvBCaVpsw09UqNxGDCy63Mi8FVg2VTknw1SxvBIdWXqRbbZ6
	8QCXIx4UmJ77DQSpNk4f4RRxWE3o=
X-Google-Smtp-Source: AGHT+IGVO/ePnFSjJKK75J27aWGCngUeN3cEtDOFmzCXS85AO19SJjYI4fSimsuCTa0RWcpOYQ9zXj7KGeoxDpDnl7w=
X-Received: by 2002:a05:6820:2018:b0:5ee:17:6a40 with SMTP id
 006d021491bc7-5ee0017700bmr1265001eaf.2.1730576421805; Sat, 02 Nov 2024
 12:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-4-ouster@cs.stanford.edu> <202410291412.HRZPPCyF-lkp@intel.com>
In-Reply-To: <202410291412.HRZPPCyF-lkp@intel.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Sat, 2 Nov 2024 12:39:44 -0700
X-Gmail-Original-Message-ID: <CAGXJAmwmrWU=yVrtEwRFO0S=juq_3PmtKL1uCKaTFv3Xfg8O8A@mail.gmail.com>
Message-ID: <CAGXJAmwmrWU=yVrtEwRFO0S=juq_3PmtKL1uCKaTFv3Xfg8O8A@mail.gmail.com>
Subject: Re: [PATCH net-next 03/12] net: homa: create shared Homa header files
To: kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: f824399eb00b5943f8bdbe5dd24fccda

I have modified homa_impl.h so that it no longer includes linux/version.h


On Mon, Oct 28, 2024 at 11:47=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi John,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/ne=
t-homa-define-user-visible-API-for-Homa/20241029-095137
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20241028213541.1529-4-ouster%40c=
s.stanford.edu
> patch subject: [PATCH net-next 03/12] net: homa: create shared Homa heade=
r files
> reproduce: (https://download.01.org/0day-ci/archive/20241029/202410291412=
.HRZPPCyF-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410291412.HRZPPCyF-lkp=
@intel.com/
>
> versioncheck warnings: (new ones prefixed by >>)
>    INFO PATH=3D/opt/cross/rustc-1.78.0-bindgen-0.65.1/cargo/bin:/opt/cros=
s/clang-19/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
>    /usr/bin/timeout -k 100 3h /usr/bin/make KCFLAGS=3D -Wtautological-com=
pare -Wno-error=3Dreturn-type -Wreturn-type -Wcast-function-type -funsigned=
-char -Wundef -fstrict-flex-arrays=3D3 -Wformat-overflow -Wformat-truncatio=
n -Wenum-conversion W=3D1 --keep-going LLVM=3D1 -j32 ARCH=3Dx86_64 versionc=
heck
>    find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -=
o -name .pc -o -name .hg -o -name .git \) -prune -o \
>         -name '*.[hcS]' -type f -print | sort \
>         | xargs perl -w ./scripts/checkversion.pl
> >> ./net/homa/homa_impl.h: 24 linux/version.h not needed.
>    ./samples/bpf/spintest.bpf.c: 8 linux/version.h not needed.
>    ./tools/lib/bpf/bpf_helpers.h: 423: need linux/version.h
>    ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9 linux/version.h no=
t needed.
>    ./tools/testing/selftests/bpf/progs/netcnt_prog.c: 3 linux/version.h n=
ot needed.
>    ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h=
 not needed.
>    ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/v=
ersion.h not needed.
>    ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.=
h not needed.
>    ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/versio=
n.h not needed.
>    ./tools/testing/selftests/wireguard/qemu/init.c: 27 linux/version.h no=
t needed.
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

