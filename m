Return-Path: <netdev+bounces-151182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D58149ED3AE
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 18:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA5E188C264
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380FF1FF1DE;
	Wed, 11 Dec 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="pQlGCPQy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1601FF1DF
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938236; cv=none; b=hqI2ni2NtPgyQnBTvbQX9x5UZ5oKeQpELvcNHpen8bN+4rs+scE1BW9zDxQg9ojM/K/095Vp1Dei0eNcjAopg9MnDS/oPletDIboSPEjU4Ff8afep7oooY8ZXZJKncpah03lnONddxdkjSDS+9bKqMAdW1gbwqwd9LXxReDZ8hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938236; c=relaxed/simple;
	bh=NUi/YIiJU2699Nw6gn48AB1Fxc2a1kNriBkg6y7AheA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzIpV63525Fqo9rZu5DJF8IC3AYIPTQjCjTtCJ9TDMeBSqPuovecsWY20eTtaEf8YXi0/gTKbv9xZC79bkH0d06w/UehhJ6OVe8YWpqXb7/cLtbRFdZRmNCCwLjvwwtqK12Guc/HnVPG4ac8lBGutAu9CW4V/l62DoHZE2GSRAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=pQlGCPQy; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WGqb2BlZ4Dq0QvIzemY0BUwW2/Ji9LXM1Y+iYBbQ59E=; t=1733938234; x=1734802234; 
	b=pQlGCPQywWsuQzUi/JHbTRVuwP2A/0QLPUMgN/Fm03DcHSYKGBwG6QPNc89N1gPscHXCe9Oyx9i
	J+rjedAKVhE4CDbnxoyshjSrF44Vlv64VXp1AhfIwZNzW4gBEfIRIC5QjrhcHuQuV0Y6sZAhzpFlu
	7Oj8jIWOHjd8q0JzcLqTgmuwD4dLi6608F2PG5oHWaEs27jE9G5i5v2pOJjpesDuFSw+VZymmxFuK
	AuzlS0uYyGAbKrFa6B0mQcQW86kIKJTRsqpmC4n3nStB4aHBXRSJdplHG1rb6iFHxTof5yXt05XdI
	PgEvhGrtjLohQ+PkH2G9IDwgABezMcVBJjpg==;
Received: from mail-oa1-f50.google.com ([209.85.160.50]:59644)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tLQXg-0004uC-Ac
	for netdev@vger.kernel.org; Wed, 11 Dec 2024 09:30:33 -0800
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-29e61fcc3d2so5949871fac.2
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 09:30:32 -0800 (PST)
X-Gm-Message-State: AOJu0YwUA9MYFbyRmm6V/fq6XHiOObzKcYaJ9k1WFoXyeGpIhaCZ4YMd
	Vov0o6fg+/MGN9f/opIuiceuuP6GefpU6ChOjbwyulgFTCPDdnH3xrXx7sXHtZWxFkC4OTbdLgC
	XQsZnhb7gsid32Due/iGaR38Fh1I=
X-Google-Smtp-Source: AGHT+IGxkxXs8YZX33MkQ2ii2o46QxXMXXz0HOMnDww6voQQ4hoIceFuxqn6e2DeX92iO1zE4nHvrp/hCDLA/liPKPw=
X-Received: by 2002:a05:6870:7a0a:b0:29d:c764:70e1 with SMTP id
 586e51a60fabf-2a3823e4d8bmr474329fac.17.1733938231618; Wed, 11 Dec 2024
 09:30:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209175131.3839-14-ouster@cs.stanford.edu> <202412110709.Kdjua3Pc-lkp@intel.com>
In-Reply-To: <202412110709.Kdjua3Pc-lkp@intel.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 11 Dec 2024 09:29:55 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxvs3mhqw0xWiy6ppzNE+r9wJbrBjYa+_ZoRXJuh5oRNg@mail.gmail.com>
Message-ID: <CAGXJAmxvs3mhqw0xWiy6ppzNE+r9wJbrBjYa+_ZoRXJuh5oRNg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 12/12] net: homa: create Makefile and Kconfig
To: kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 056db2312ab85a437fb45f547310e25c

I have now fixed the problems found by the test robot.

-John-


On Tue, Dec 10, 2024 at 4:32=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi John,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/in=
et-homa-define-user-visible-API-for-Homa/20241210-055415
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20241209175131.3839-14-ouster%40=
cs.stanford.edu
> patch subject: [PATCH net-next v3 12/12] net: homa: create Makefile and K=
config
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/2024=
1211/202412110709.Kdjua3Pc-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51=
eccf88f5321e7c60591c5546b254b6afab99)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241211/202412110709.Kdjua3Pc-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412110709.Kdjua3Pc-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from net/homa/homa_outgoing.c:7:
>    In file included from net/homa/homa_impl.h:12:
>    In file included from include/linux/audit.h:13:
>    In file included from include/linux/ptrace.h:10:
>    In file included from include/linux/pid_namespace.h:7:
>    In file included from include/linux/mm.h:2223:
>    include/linux/vmstat.h:504:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      505 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:511:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      512 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:518:36: warning: arithmetic between different e=
numeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-c=
onversion]
>      518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip =
"nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>    include/linux/vmstat.h:524:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      525 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
> >> net/homa/homa_outgoing.c:809:6: warning: variable 'checks' set but not=
 used [-Wunused-but-set-variable]
>      809 |         int checks =3D 0;
>          |             ^
>    5 warnings generated.
> --
>    In file included from net/homa/homa_sock.c:5:
>    In file included from net/homa/homa_impl.h:12:
>    In file included from include/linux/audit.h:13:
>    In file included from include/linux/ptrace.h:10:
>    In file included from include/linux/pid_namespace.h:7:
>    In file included from include/linux/mm.h:2223:
>    include/linux/vmstat.h:504:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      505 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:511:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      512 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:518:36: warning: arithmetic between different e=
numeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-c=
onversion]
>      518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip =
"nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>    include/linux/vmstat.h:524:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      525 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
> >> net/homa/homa_sock.c:224:6: warning: variable 'i' set but not used [-W=
unused-but-set-variable]
>      224 |         int i;
>          |             ^
>    5 warnings generated.
> --
>    In file included from net/homa/homa_timer.c:7:
>    In file included from net/homa/homa_impl.h:12:
>    In file included from include/linux/audit.h:13:
>    In file included from include/linux/ptrace.h:10:
>    In file included from include/linux/pid_namespace.h:7:
>    In file included from include/linux/mm.h:2223:
>    include/linux/vmstat.h:504:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      505 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:511:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      512 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:518:36: warning: arithmetic between different e=
numeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-c=
onversion]
>      518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip =
"nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>    include/linux/vmstat.h:524:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      525 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
> >> net/homa/homa_timer.c:106:6: warning: variable 'total_rpcs' set but no=
t used [-Wunused-but-set-variable]
>      106 |         int total_rpcs =3D 0;
>          |             ^
>    5 warnings generated.
>
>
> vim +/checks +809 net/homa/homa_outgoing.c
>
> 537f41147b3131 John Ousterhout 2024-12-09  796
> 537f41147b3131 John Ousterhout 2024-12-09  797  /**
> 537f41147b3131 John Ousterhout 2024-12-09  798   * homa_add_to_throttled(=
) - Make sure that an RPC is on the throttled list
> 537f41147b3131 John Ousterhout 2024-12-09  799   * and wake up the pacer =
thread if necessary.
> 537f41147b3131 John Ousterhout 2024-12-09  800   * @rpc:     RPC with out=
bound packets that have been granted but can't be
> 537f41147b3131 John Ousterhout 2024-12-09  801   *           sent because=
 of NIC queue restrictions. Must be locked by caller.
> 537f41147b3131 John Ousterhout 2024-12-09  802   */
> 537f41147b3131 John Ousterhout 2024-12-09  803  void homa_add_to_throttle=
d(struct homa_rpc *rpc)
> 537f41147b3131 John Ousterhout 2024-12-09  804          __must_hold(&rpc-=
>bucket->lock)
> 537f41147b3131 John Ousterhout 2024-12-09  805  {
> 537f41147b3131 John Ousterhout 2024-12-09  806          struct homa *homa=
 =3D rpc->hsk->homa;
> 537f41147b3131 John Ousterhout 2024-12-09  807          struct homa_rpc *=
candidate;
> 537f41147b3131 John Ousterhout 2024-12-09  808          int bytes_left;
> 537f41147b3131 John Ousterhout 2024-12-09 @809          int checks =3D 0;
> 537f41147b3131 John Ousterhout 2024-12-09  810          __u64 now;
> 537f41147b3131 John Ousterhout 2024-12-09  811
> 537f41147b3131 John Ousterhout 2024-12-09  812          if (!list_empty(&=
rpc->throttled_links))
> 537f41147b3131 John Ousterhout 2024-12-09  813                  return;
> 537f41147b3131 John Ousterhout 2024-12-09  814          now =3D sched_clo=
ck();
> 537f41147b3131 John Ousterhout 2024-12-09  815          homa->throttle_ad=
d =3D now;
> 537f41147b3131 John Ousterhout 2024-12-09  816          bytes_left =3D rp=
c->msgout.length - rpc->msgout.next_xmit_offset;
> 537f41147b3131 John Ousterhout 2024-12-09  817          homa_throttle_loc=
k(homa);
> 537f41147b3131 John Ousterhout 2024-12-09  818          list_for_each_ent=
ry_rcu(candidate, &homa->throttled_rpcs,
> 537f41147b3131 John Ousterhout 2024-12-09  819                           =
       throttled_links) {
> 537f41147b3131 John Ousterhout 2024-12-09  820                  int bytes=
_left_cand;
> 537f41147b3131 John Ousterhout 2024-12-09  821
> 537f41147b3131 John Ousterhout 2024-12-09  822                  checks++;
> 537f41147b3131 John Ousterhout 2024-12-09  823
> 537f41147b3131 John Ousterhout 2024-12-09  824                  /* Watch =
out: the pacer might have just transmitted the last
> 537f41147b3131 John Ousterhout 2024-12-09  825                   * packet=
 from candidate.
> 537f41147b3131 John Ousterhout 2024-12-09  826                   */
> 537f41147b3131 John Ousterhout 2024-12-09  827                  bytes_lef=
t_cand =3D candidate->msgout.length -
> 537f41147b3131 John Ousterhout 2024-12-09  828                           =
       candidate->msgout.next_xmit_offset;
> 537f41147b3131 John Ousterhout 2024-12-09  829                  if (bytes=
_left_cand > bytes_left) {
> 537f41147b3131 John Ousterhout 2024-12-09  830                          l=
ist_add_tail_rcu(&rpc->throttled_links,
> 537f41147b3131 John Ousterhout 2024-12-09  831                           =
                 &candidate->throttled_links);
> 537f41147b3131 John Ousterhout 2024-12-09  832                          g=
oto done;
> 537f41147b3131 John Ousterhout 2024-12-09  833                  }
> 537f41147b3131 John Ousterhout 2024-12-09  834          }
> 537f41147b3131 John Ousterhout 2024-12-09  835          list_add_tail_rcu=
(&rpc->throttled_links, &homa->throttled_rpcs);
> 537f41147b3131 John Ousterhout 2024-12-09  836  done:
> 537f41147b3131 John Ousterhout 2024-12-09  837          homa_throttle_unl=
ock(homa);
> 537f41147b3131 John Ousterhout 2024-12-09  838          wake_up_process(h=
oma->pacer_kthread);
> 537f41147b3131 John Ousterhout 2024-12-09  839  }
> 537f41147b3131 John Ousterhout 2024-12-09  840
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

