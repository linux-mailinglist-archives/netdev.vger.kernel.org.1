Return-Path: <netdev+bounces-20543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C3760026
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F861281304
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB57107A7;
	Mon, 24 Jul 2023 19:58:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39D101D5
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 19:58:34 +0000 (UTC)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA8C10C9
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690228713; x=1721764713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TYr14xw73bjYSNdYAS1zXDudbXKv/Zuvs4EaPRr+dT0=;
  b=RAMn/Lmo8dRSB8/lS1GSjggDabw8Fr5vkiTgNJLiq+lyUWC9DrJKTpTQ
   3OIuxQNauRMAUaleTXXuPVq9GsMWIGm+0Or+7iYNeL4zllgaBYLqlb+ZB
   u9/6OV4eyQerkAcHz2yw7OtSfUXXnSS6Kp6d0bdvqMhIV3ZMpuZidFk57
   k=;
X-IronPort-AV: E=Sophos;i="6.01,228,1684800000"; 
   d="scan'208";a="662402740"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 19:58:27 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id 97941A0B74;
	Mon, 24 Jul 2023 19:58:26 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 19:58:26 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Mon, 24 Jul 2023 19:58:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <trawets@amazon.com>
CC: <aksecurity@gmail.com>, <benh@amazon.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.co.jp>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <samjonas@amazon.com>
Subject: Re: [PATCH v2 net] tcp: Reduce chance of collisions in inet6_hashfn().
Date: Mon, 24 Jul 2023 12:58:13 -0700
Message-ID: <20230724195813.11319-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <9A3D7F61-23CC-4A2F-9022-EAA17ECFA690@amazon.com>
References: <9A3D7F61-23CC-4A2F-9022-EAA17ECFA690@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.100.36]
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "Smith, Stewart" <trawets@amazon.com>
Date: Sat, 22 Jul 2023 03:17:53 +0000
> On Jul 21, 2023, at 6:39 PM, Iwashima, Kuniyuki <kuniyu@amazon.co.jp> wrote:
> > 
> > From: Amit Klein <aksecurity@gmail.com>
> > Date: Sat, 22 Jul 2023 03:07:49 +0300
> >> Resending because some recipients require plaintext email. Sorry.
> >> Original message:
> >> 
> >> This is certainly better than the original code.
> > 
> > Thanks for reviewing!
> > 
> > 
> >> 
> >> Two remarks:
> >> 
> >> 1. In general, using SipHash is more secure, even if only for its
> >> longer key (128 bits, cf. jhash's 32 bits), which renders simple
> >> enumeration attacks infeasible. I understand that in a different
> >> context, switching from jhash to siphash incurred some overhead, but
> >> maybe here it won't.
> > 
> > I see.  Stewart tested hsiphash and observed more overhead as
> > noted in the changelog, but let me give another shot to SipHash
> > and HSiphash.
> 
> When originally looking at what to do for the collisions, it did seem
> like siphash would be the better hash, but I did have some concern around
> what the real-world performance impact could be, and wanted to have
> something that would alleviate the issue at hand that nobody could even
> *possibly* remotely contemplate complaining was a problem to apply the
> patch to their systems because of “performance”.. which was why keeping
> jhash but with modifications was where we started.
> 
> Two things about siphash/hsiphash that I had open questions about:
> - is the extra overhead of the hash calculation going to be noticeable at
>   all in any regular workload
> - all the jhash stuff gets inlined nicely and the compiler does wonderful
>   things, but it’s possible that siphash will end up always with a jump,
>   which would add more to the extra overhead (and that llvm-mca doesn’t
>   really model well, so it was harder to prove in sim). Again, not quite
>   sure the real world impact to real world workloads.

Here is the llvm-mca result.  Base commit is 1671bcfd76fd.
In Total Cycles, siphash is much slower than others.

  On Skylake: jhash2: +10%, hsiphash +8%, siphash: +23%
  On Nehalem: jahsh2: +5%,  hsiphash +9%, siphash: +26%

  Skylake             	base		jhash2                  hsiphash                siphash                 
  Iterations          	  1.00		  1.00 (100.00)		  1.00 (100.00)		  1.00 (100.00)		
  Instructions        	104.00		137.00 (131.73)		166.00 (159.62)		222.00 (213.46)		
  Total Cycles        	155.00		171.00 (110.32)		168.00 (108.39)		191.00 (123.23)		
  Total uOps          	132.00		166.00 (125.76)		192.00 (145.45)		248.00 (187.88)		
  Dispatch Width      	  6.00		  6.00 (100.00)		  6.00 (100.00)		  6.00 (100.00)		
  uOps Per Cycle      	  0.85		  0.97 (114.12)		  1.14 (134.12)		  1.30 (152.94)		
  IPC                 	  0.67		  0.80 (119.40)		  0.99 (147.76)		  1.16 (173.13)		

  Nehalem             	base		jhash2                  hsiphash                siphash                 
  Iterations          	  1.00		  1.00 (100.00)		  1.00 (100.00)		  1.00 (100.00)		
  Instructions        	104.00		137.00 (131.73)		166.00 (159.62)		222.00 (213.46)		
  Total Cycles        	173.00		182.00 (105.20)		190.00 (109.83)		218.00 (126.01)		
  Total uOps          	130.00		170.00 (130.77)		215.00 (165.38)		295.00 (226.92)		
  Dispatch Width      	  4.00		  4.00 (100.00)		  4.00 (100.00)		  4.00 (100.00)		
  uOps Per Cycle      	  0.75		  0.93 (124.00)		  1.13 (150.67)		  1.35 (180.00)		
  IPC                 	  0.60		  0.75 (125.00)		  0.87 (145.00)		  1.02 (170.00)	


However, inet6_ehashfn() is not dominant in the fast path, and there
seems to be not so big impact during benchmarking with super_netperf.

  for i in $(seq 1 5);
  do
      for i in 64 128 256 512 1024 2048 4096;
      do
  	printf "%4d: " $i;
  	./super_netperf 32 -H ::1 -l 60 -- -m $i -M $i;
      done
  done

Average of 5 run:

  $i    10^6 bps
  size	base		jhash2                  hsiphash                siphash                 
  64	20735.80	20419.96 (98.48)	20335.60 (98.07)	20404.08 (98.40)	
  128	40450.40	40167.66 (99.30)	39957.32 (98.78)	40222.06 (99.44)	
  256	73740.84	74219.26 (100.65)	73625.76 (99.84)	74081.52 (100.46)	
  512	142075.60	142461.80 (100.27)	141237.00 (99.41)	141789.60 (99.80)	
  1024	254391.00	253553.20 (99.67)	252751.00 (99.36)	253718.00 (99.74)	
  2048	421221.20	421175.60 (99.99)	420142.80 (99.74)	418189.20 (99.28)	
  4096	599158.20	597958.20 (99.80)	594472.20 (99.22)	598591.00 (99.91)


Also, in the kernel with hsiphash/siphash, there is call op as
hsiphash_4u32() and siphash_2u64() are exposed to modules, but
both functions did not have jumps.

hsiphash:
  $ gdb -batch -ex 'file vmlinux' -ex 'disassemble inet6_ehashfn' | grep hsiphash
     0xffffffff81de5bcc <+92>:	call   0xffffffff81f637e0 <hsiphash_4u32>
  $ gdb -batch -ex 'file vmlinux' -ex 'disassemble hsiphash_4u32' | grep j
     0xffffffff81f63970 <+400>:	jmp    0xffffffff81f85ec0 <__x86_return_thunk>

siphash:
  $ gdb -batch -ex 'file vmlinux' -ex 'disassemble inet6_ehashfn' | grep siphash
     0xffffffff81de5bc4 <+84>:	call   0xffffffff81f625e0 <siphash_2u64>
  $ gdb -batch -ex 'file vmlinux' -ex 'disassemble siphash_2u64' | grep j
     0xffffffff81f62837 <+599>:	jmp    0xffffffff81f85ec0 <__x86_return_thunk>


All of the data above are uploaded here.
https://github.com/q2ven/inet6_ehashfn

Thanks!

