Return-Path: <netdev+bounces-141251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F48F9BA333
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 01:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C47B211A9
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 00:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876D7800;
	Sun,  3 Nov 2024 00:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Upumao9N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEC62F2E
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 00:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730592755; cv=none; b=EjGvOXBmRPYtWQBUnP+YtCcwVFvRJ6G29yyOtdHTYoZZ4VZnfBAo1MCpIRf9DUpb67MMLmqf2CwSizPvIiBFA/F6XOC+bzCAoo4L3tqlcFNIBki2HK13MoXxQSJ+O2XM/eDj4x+bzwLfmqmxNIAf/bLw5ibppb+9tm2IxZIeGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730592755; c=relaxed/simple;
	bh=OZWXXGyoS9bJT9N6PrGwyLR+Px5L9/6D39WIpYyz/NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Est+gsLLnFzxHz9yJVpIaxrOYISx0Jui+mUe4UuKjWH2ZN2ESPUP4b4ISmpXv+fZZdM+ko+mPISpvGJvexil9bAuPDHohSc3DH6kymo/p/gWEl+JPSt4cy7Wg4/9xqh4K8z45bm1ms5wbZ6SipKcIvz2qhO1PVwShZ+ntnhnk5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Upumao9N; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LE7fzoInMcHBvF6grXh46ZoKfKccUWf5KStRmstmXFI=; t=1730592753; x=1731456753; 
	b=Upumao9NKyiOMMg6W4Nwgx6vdvVFALGGTds933FvtizXQVlI6gHYA+VcuqbsZNiGuiUhaAxd6mW
	nbh1/VTUjCC9lMA1jmyLE78AdsI6mMbf2Raf0eBXGRLHOs8nXXQeDMaWpU2dIzgo/rx779NHZM0Of
	+AOzrjwMxov/knYL/RRkX3Uf8t3i3RMaFdh9Y8rfOu3a0gCTvQDAbw9c2t0CCFQ7sE1W3NssnFx/o
	w3IpXHaCwQXyKwt/CIKJnn4JuL5x17v438Rcp8m43CKvsxULQxTqMTuYRprqeml2J9uxecYLnOQin
	E4EY10yoij3glcEZYHlYSNJkQk0JZXqpAl9w==;
Received: from mail-oo1-f54.google.com ([209.85.161.54]:59816)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t7OEJ-00068f-VS
	for netdev@vger.kernel.org; Sat, 02 Nov 2024 17:12:32 -0700
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc0c05e25so1621228eaf.3
        for <netdev@vger.kernel.org>; Sat, 02 Nov 2024 17:12:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YyG/tJ70HwX1GrUJci/gKb4D+xCjrQQzGyGNKhXl3IE1Cso528p
	ldEnJO8fQ7BkWrjo2MGs/EAxcevVw1M+JUfgzfF69/oFR+1ab2CXz4hnGUYWglA2FeVz6VM90xh
	gh4C8R/GS9cJ9my9Cm9ikcS6FQZk=
X-Google-Smtp-Source: AGHT+IH2LnniTE/Gn04OHYIREto1SOHB/u8GoEJdhJEsZ6BiJ9NhRaawRQiE1BKTtKQ+fLETiatUt4cxC0RbGqTGsGI=
X-Received: by 2002:a05:6820:541:b0:5eb:db1c:a860 with SMTP id
 006d021491bc7-5ec23aa5cd5mr19028463eaf.8.1730592751392; Sat, 02 Nov 2024
 17:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-13-ouster@cs.stanford.edu> <202410300823.rFSVqCH5-lkp@intel.com>
In-Reply-To: <202410300823.rFSVqCH5-lkp@intel.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Sat, 2 Nov 2024 17:11:54 -0700
X-Gmail-Original-Message-ID: <CAGXJAmxRoU8tkxC+wX24Zn8vvh16ih7d8d83DwOt1h_gPVy62Q@mail.gmail.com>
Message-ID: <CAGXJAmxRoU8tkxC+wX24Zn8vvh16ih7d8d83DwOt1h_gPVy62Q@mail.gmail.com>
Subject: Re: [PATCH net-next 12/12] net: homa: create Makefile and Kconfig
To: kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: e06f15b59fb559802f962308c7f2f8f7

I have made a stab at fixing all of the problems reported by the test
robot. However, it may take a few passes to figure exactly how to make
sparse happy...

-John-


On Tue, Oct 29, 2024 at 6:09=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
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
> patch link:    https://lore.kernel.org/r/20241028213541.1529-13-ouster%40=
cs.stanford.edu
> patch subject: [PATCH net-next 12/12] net: homa: create Makefile and Kcon=
fig
> config: arc-randconfig-r132-20241029 (https://download.01.org/0day-ci/arc=
hive/20241030/202410300823.rFSVqCH5-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20241030/202410300823=
.rFSVqCH5-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410300823.rFSVqCH5-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>    net/homa/homa_rpc.c: note: in included file:
> >> net/homa/homa_impl.h:605:13: sparse: sparse: restricted __be32 degrade=
s to integer
>    net/homa/homa_rpc.c: note: in included file (through include/linux/smp=
.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always eva=
luates to true
>    net/homa/homa_rpc.c:84:9: sparse: sparse: context imbalance in 'homa_r=
pc_new_client' - different lock contexts for basic block
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always eva=
luates to true
>    net/homa/homa_rpc.c:104:17: sparse: sparse: context imbalance in 'homa=
_rpc_new_server' - wrong count at exit
>    net/homa/homa_rpc.c: note: in included file (through include/linux/rcu=
list.h, include/linux/sched/signal.h, include/linux/ptrace.h, ...):
>    include/linux/rcupdate.h:881:9: sparse: sparse: context imbalance in '=
homa_rpc_acked' - unexpected unlock
>    net/homa/homa_rpc.c: note: in included file (through include/linux/smp=
.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always eva=
luates to true
>    net/homa/homa_rpc.c:235:6: sparse: sparse: context imbalance in 'homa_=
rpc_free' - different lock contexts for basic block
>    net/homa/homa_rpc.c:311:5: sparse: sparse: context imbalance in 'homa_=
rpc_reap' - wrong count at exit
>    net/homa/homa_rpc.c:448:17: sparse: sparse: context imbalance in 'homa=
_find_client_rpc' - wrong count at exit
>    net/homa/homa_rpc.c:474:17: sparse: sparse: context imbalance in 'homa=
_find_server_rpc' - wrong count at exit
> --
> >> net/homa/homa_sock.c:85:39: sparse: sparse: cast removes address space=
 '__rcu' of expression
>    net/homa/homa_sock.c:91:31: sparse: sparse: cast removes address space=
 '__rcu' of expression
>    net/homa/homa_sock.c:165:6: sparse: sparse: context imbalance in 'homa=
_sock_shutdown' - wrong count at exit
>    net/homa/homa_sock.c:243:5: sparse: sparse: context imbalance in 'homa=
_sock_bind' - different lock contexts for basic block
>    net/homa/homa_sock.c:312:6: sparse: sparse: context imbalance in 'homa=
_sock_lock_slow' - wrong count at exit
>    net/homa/homa_sock.c:326:6: sparse: sparse: context imbalance in 'homa=
_bucket_lock_slow' - wrong count at exit
>
> vim +605 net/homa/homa_impl.h
>
> 1416f12d4ea455 John Ousterhout 2024-10-28  595
> 1416f12d4ea455 John Ousterhout 2024-10-28  596  /**
> 1416f12d4ea455 John Ousterhout 2024-10-28  597   * Given an IPv4 address,=
 return an equivalent IPv6 address (an IPv4-mapped
> 1416f12d4ea455 John Ousterhout 2024-10-28  598   * one)
> 1416f12d4ea455 John Ousterhout 2024-10-28  599   * @ip4: IPv4 address, in=
 network byte order.
> 1416f12d4ea455 John Ousterhout 2024-10-28  600   */
> 1416f12d4ea455 John Ousterhout 2024-10-28  601  static inline struct in6_=
addr ipv4_to_ipv6(__be32 ip4)
> 1416f12d4ea455 John Ousterhout 2024-10-28  602  {
> 1416f12d4ea455 John Ousterhout 2024-10-28  603          struct in6_addr r=
et =3D {};
> 1416f12d4ea455 John Ousterhout 2024-10-28  604
> 1416f12d4ea455 John Ousterhout 2024-10-28 @605          if (ip4 =3D=3D IN=
ADDR_ANY)
> 1416f12d4ea455 John Ousterhout 2024-10-28  606                  return in=
6addr_any;
> 1416f12d4ea455 John Ousterhout 2024-10-28  607          ret.in6_u.u6_addr=
32[2] =3D htonl(0xffff);
> 1416f12d4ea455 John Ousterhout 2024-10-28  608          ret.in6_u.u6_addr=
32[3] =3D ip4;
> 1416f12d4ea455 John Ousterhout 2024-10-28  609          return ret;
> 1416f12d4ea455 John Ousterhout 2024-10-28  610  }
> 1416f12d4ea455 John Ousterhout 2024-10-28  611
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

