Return-Path: <netdev+bounces-73325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E86E85BEEF
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 15:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8875CB21712
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8A467C61;
	Tue, 20 Feb 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvXKp7iR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310782F2C
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439950; cv=none; b=FQPG5h0knOfwWFuQqu1AWIBVeS+7p9QaevPRRnrT+ccVAkrACCcpTuVHZHgD5gm5b+1blrFxGzJhMq2Vxxgy6SeFK1Tb2gdSJpo+reG6AnPxmbkV+xMKtSY0eaC51E2JBPvbyu6SixuwN5n09c1trjsVjTAFhaBgOLqkEe1wdg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439950; c=relaxed/simple;
	bh=0cBM45E1vG9MbbwRLbOIB/aQWFlMrkNIRi3canC/l5M=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=fT+u1lBfDQ/GAWWHM+UuOciJyxROd6du+0ao5OKnYjKyyFNJ8e0eefBKlKuN50eqQTNV3wqxyS92FrN2qCao/QJEETBtx56s1yZ43K5i+Qdhh6PHazbxfJNq5tHv4gpJR1eggmmvk2YHAbyWAevraGUEpsyzI7G1E5dxgjBSHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvXKp7iR; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2998950e951so1293732a91.2
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 06:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708439947; x=1709044747; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMv+kwXiiyvOB2xt3mXPvLsuPPe5Q/ui1pBKtSNj5DU=;
        b=FvXKp7iRcaDxxAiNZhnA2DZz83vFuVtgWk9vEZzwMshfhbqjijU5+bGVeiahwORdoO
         0TZJLIaPtkbMC1VeU4R4JjP7YuLrTSmUaRnkyEEqqlcyod3ZLyMLkS/DmHh6l6AkUK0Q
         5Mfd0l9WfgDtKoGaZXbwRXngT4dFyX/wsKkXgI/LqFTMwYyg8nGsUvR/wvgeJ2/11RPc
         JqHl2DvgY//y0w0KTaC/oE2RT4VX8hwZ9vXzM5jsBqLWnVrIy/DWuQXCCWpNOquBBQPN
         FcVX7chan4fcs+8dIxrIf+fJ82E/zpdNG3Dt2vxqGNC29zviUvjAATQl9k8Q7GnQ73Rz
         OJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708439947; x=1709044747;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMv+kwXiiyvOB2xt3mXPvLsuPPe5Q/ui1pBKtSNj5DU=;
        b=gYS9G1vg1UL0CeUKzzfLL72tXPXeajMsq9TMPVIdUSCC72uE1iaeL2amqwNvYlg8wI
         Tce6qqJJ2ci/J7F6Cu4dmZudLKuZisHKLbRC077s2bNcrAlNBLMM8MhjC/7M9ZJckgCn
         QBlkc/pWEZB8AtnHfXF1c3qrf9l6D9HesLvHFr5VK8S1U1/0CbwsZYNWu/ojWDWDg8pZ
         olFz3LWfbD59r5nYrCJ4lPFxbzrPr8HJbVsO7in8YLjfLpfARIoq37Ze9XhhlVntatc6
         Eqkq/hbd1aOxp+YSNBdE7y9PjU/CGfTmWB8N5X0wemwQ3A+fnLA5+wygRixIdkJCi2FB
         R74w==
X-Gm-Message-State: AOJu0YzjdFM3hf36llXl726OntGzaiff3XU6E2C4yxve8pkGZ4w+YKiQ
	eKpHnlxonG2m0t3yXMHC89hiYbGhH7iPQsdUqGLXlw/OG4xPxJ8j112G90zNW/M=
X-Google-Smtp-Source: AGHT+IEYN3iubC3Q2S+w/IqiSA5jUgbNjw+1Cq3KEh/Q+fmgLi9my/R/MUxEyp6/cgwOWJgFPsKePQ==
X-Received: by 2002:a17:90a:d48d:b0:299:2435:cdf0 with SMTP id s13-20020a17090ad48d00b002992435cdf0mr10255203pju.29.1708439947401;
        Tue, 20 Feb 2024 06:39:07 -0800 (PST)
Received: from smtpclient.apple (va133-130-115-230-f.a04e.g.tyo1.static.cnode.io. [2400:8500:1301:747:a133:130:115:230f])
        by smtp.gmail.com with ESMTPSA id gn15-20020a17090ac78f00b00299332505d7sm7523215pjb.26.2024.02.20.06.39.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2024 06:39:06 -0800 (PST)
From: Miao Wang <shankerwangmiao@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: [Bug report] veth cannot be created, reporting page allocation
 failure
Message-Id: <5F52CAE2-2FB7-4712-95F1-3312FBBFA8DD@gmail.com>
Date: Tue, 20 Feb 2024 22:38:52 +0800
Cc: pabeni@redhat.com,
 "David S. Miller" <davem@davemloft.net>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3774.400.31)

Hi, all

I'm writing to report an issue with the veth module. The symptom is that
ocaasionally, the veth pair can't be created successfully, and the error =
shown
in the dmesg is something like below:

  dockerd: page allocation failure: order:5, =
mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), =
nodemask=3D(null),cpuset=3Ddocker.service,mems_allowed=3D0

I met this problem when I upgraded the kernel of an open source mirror =
server
from 5.10 to 6.1, provided by Debian. I also tried the latest mainline =
kernel
and the problem still exists.

The server has 512GB memory and 96 cores, in 2 Kunpeng 920 CPUs. The =
serving
files reside in a ZFS filesystem. About 75% ~ 90% of the memory is used =
by the
zfs arc cache. We run sync jobs inside docker containers to sync the =
files from
upstreams. As a result, docker containers are created and destroyed =
frequently.

After the upgradation, docker containers cannot be created successfully
occasionally. The error message from the docker daemon indicates the =
failure of
the creation of the veth pair. The full error message in the dmesg is =
attached
at the end. On our server, after several reboots trying different =
versions of
kernels, first occurance of the error is about 7~8 hours after boot. =
Also, I
ruled out the possibility of zfs issues and docker issues by using the =
exact
same version of zfs and docker during the reboots.

Similar issues are also reported in the following link:

  https://github.com/docker/for-linux/issues/1443

I tried to bisect the kernel to find the commit that introduced the =
problem, but
it would take too long to carry out the tests. However, after 4 rounds =
of
bisecting, by examining the remaining commits, I'm convinced that the =
problem is
caused by the following commit:

  9d3684c24a5232 ("veth: create by default nr_possible_cpus queues")

where changes are made to the veth module to create queues for all =
possbile
cpus when not providing expected number of queues by the userland. The =
previous
behavior was to create only one queue in the same condition. The memory =
in need
will be large when the number of cpus is large, which is 96 * 768 =3D =
72KB or 18
continuous 4K pages in total, no wonder causing the allocation failure. =
I guess
on certain platforms, the number of possbile cpus might be even larger, =
and
larger than actual cpu cores physically installed, for several people in =
the
above discussion mentioned that manually specifing nr_cpus in the boot =
command
line can work around the problem.

I've carried out a cross check by applying the commit on the working =
5.10
kernel, and the problem occurs. Then I reverted the commit on the 6.1 =
kernel,=20
the problem has not occured for 27 hours.

I think that the change on the default behavior of the veth creation =
should be
re-considered to reduce memory waste and avoid the allocation failure, =
since
linux containers heavily rely on veth pairs.

Cheers,

Miao Wang


Attached dmesg:

[11203.923303] dockerd: page allocation failure: order:5, =
mode:0x440dc0(GFP_KERNEL_ACCOUNT|__GFP_COMP|__GFP_ZERO), =
nodemask=3D(null),cpuset=3Ddocker.service,mems_allowed=3D0-3
[11203.939669] CPU: 56 PID: 361309 Comm: dockerd Kdump: loaded Tainted: =
P           OE      6.1.0-17-arm64 #1  Debian 6.1.69-1
[11203.951427] Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDDA, =
BIOS 1.38 07/04/2020
[11203.960245] Call trace:
[11203.963304]  dump_backtrace+0xe4/0x140
[11203.967570]  show_stack+0x20/0x30
[11203.971407]  dump_stack_lvl+0x64/0x80
[11203.975590]  dump_stack+0x18/0x34
[11203.979411]  warn_alloc+0x124/0x1ac
[11203.983395]  __alloc_pages+0xda0/0xe64
[11203.987634]  __kmalloc_large_node+0x94/0x170
[11203.992396]  __kmalloc+0x128/0x1d0
[11203.996295]  veth_dev_init+0x8c/0x104 [veth]
[11204.001058]  register_netdevice+0xf8/0x5a4
[11204.005649]  veth_newlink+0x1e0/0x460 [veth]
[11204.010406]  __rtnl_newlink+0x5f0/0x860
[11204.014725]  rtnl_newlink+0x58/0x84
[11204.018710]  rtnetlink_rcv_msg+0x274/0x36c
[11204.023292]  netlink_rcv_skb+0x64/0x130
[11204.027617]  rtnetlink_rcv+0x20/0x30
[11204.031682]  netlink_unicast+0x2d4/0x33c
[11204.036078]  netlink_sendmsg+0x1d8/0x450
[11204.040475]  __sock_sendmsg+0x5c/0x70
[11204.044613]  __sys_sendto+0x10c/0x16c
[11204.048744]  __arm64_sys_sendto+0x30/0x40
[11204.053221]  invoke_syscall+0x78/0x100
[11204.057439]  el0_svc_common.constprop.0+0x4c/0xf4
[11204.062604]  do_el0_svc+0x34/0xd0
[11204.066388]  el0_svc+0x34/0xd4
[11204.069908]  el0t_64_sync_handler+0xf4/0x120
[11204.074639]  el0t_64_sync+0x18c/0x190
[11204.078954] Mem-Info:
[11204.081746] active_anon:4881 inactive_anon:2091912 isolated_anon:0
[11204.081746]  active_file:74800 inactive_file:76095 isolated_file:0
[11204.081746]  unevictable:4 dirty:158 writeback:2
[11204.081746]  slab_reclaimable:1596340 slab_unreclaimable:34544450
[11204.081746]  mapped:35555 shmem:3865 pagetables:13950
[11204.081746]  sec_pagetables:0 bounce:0
[11204.081746]  kernel_misc_reclaimable:0
[11204.081746]  free:1867614 free_pcp:12171 free_cma:48513
[11204.125833] Node 0 active_anon:17128kB inactive_anon:2173780kB =
active_file:47228kB inactive_file:59048kB unevictable:16kB =
isolated(anon):0kB isolated(file):0kB mapped:47124kB dirty:116kB =
writeback:0kB shmem:7092kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: =
323584kB writeback_tmp:0kB kernel_stack:11092kB pagetables:11944kB =
sec_pagetables:0kB all_unreclaimable? no
[11204.159593] Node 1 active_anon:624kB inactive_anon:1706892kB =
active_file:54120kB inactive_file:57144kB unevictable:0kB =
isolated(anon):0kB isolated(file):0kB mapped:41532kB dirty:28kB =
writeback:0kB shmem:3424kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: =
159744kB writeback_tmp:0kB kernel_stack:8692kB pagetables:10048kB =
sec_pagetables:0kB all_unreclaimable? no
[11204.192762] Node 2 active_anon:936kB inactive_anon:2221868kB =
active_file:59832kB inactive_file:58708kB unevictable:0kB =
isolated(anon):0kB isolated(file):0kB mapped:11072kB dirty:64kB =
writeback:0kB shmem:1860kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: =
241664kB writeback_tmp:0kB kernel_stack:10596kB pagetables:8644kB =
sec_pagetables:0kB all_unreclaimable? yes
[11204.226036] Node 3 active_anon:836kB inactive_anon:2265116kB =
active_file:138020kB inactive_file:129480kB unevictable:0kB =
isolated(anon):0kB isolated(file):0kB mapped:42492kB dirty:984kB =
writeback:24kB shmem:3084kB shmem_thp: 0kB shmem_pmdmapped: 0kB =
anon_thp: 180224kB writeback_tmp:0kB kernel_stack:10916kB =
pagetables:25164kB sec_pagetables:0kB all_unreclaimable? yes
[11204.259903] Node 0 DMA free:681676kB boost:0kB min:332kB low:1888kB =
high:3444kB reserved_highatomic:0KB active_anon:8192kB =
inactive_anon:304000kB active_file:1584kB inactive_file:2500kB =
unevictable:0kB writepending:4kB present:2092864kB managed:1598684kB =
mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:194052kB
[11204.289892] lowmem_reserve[]: 0 0 122877 122877
[11204.295192] Node 0 Normal free:1941500kB boost:0kB min:27112kB =
low:152936kB high:278760kB reserved_highatomic:2048KB active_anon:8936kB =
inactive_anon:1869616kB active_file:45644kB inactive_file:56548kB =
unevictable:16kB writepending:112kB present:132120576kB =
managed:125826136kB mlocked:16kB bounce:0kB free_pcp:40508kB =
local_pcp:0kB free_cma:0kB
[11204.327105] lowmem_reserve[]: 0 0 0 0
[11204.331639] Node 1 Normal free:686100kB boost:0kB min:28468kB =
low:160584kB high:292700kB reserved_highatomic:0KB active_anon:624kB =
inactive_anon:1707364kB active_file:54120kB inactive_file:57156kB =
unevictable:0kB writepending:60kB present:134217728kB =
managed:132117604kB mlocked:0kB bounce:0kB free_pcp:15484kB =
local_pcp:0kB free_cma:0kB
[11204.362967] lowmem_reserve[]: 0 0 0 0
[11204.367568] Node 2 Normal free:1283168kB boost:439048kB min:467516kB =
low:599632kB high:731748kB reserved_highatomic:0KB active_anon:936kB =
inactive_anon:2221864kB active_file:59832kB inactive_file:58708kB =
unevictable:0kB writepending:52kB present:134217728kB =
managed:132117600kB mlocked:0kB bounce:0kB free_pcp:12368kB =
local_pcp:32kB free_cma:0kB
[11204.399711] lowmem_reserve[]: 0 0 0 0
[11204.404341] Node 3 Normal free:2676652kB boost:435556kB min:463800kB =
low:594864kB high:725928kB reserved_highatomic:0KB active_anon:836kB =
inactive_anon:2265084kB active_file:138020kB inactive_file:129480kB =
unevictable:0kB writepending:1008kB present:134217728kB =
managed:131064536kB mlocked:0kB bounce:0kB free_pcp:17504kB =
local_pcp:0kB free_cma:0kB
[11204.436947] lowmem_reserve[]: 0 0 0 0
[11204.441696] Node 0 DMA: 2588*4kB (UMEC) 2322*8kB (UMEC) 2061*16kB =
(UMEC) 1664*32kB (UMEC) 1278*64kB (UMEC) 663*128kB (UMEC) 338*256kB =
(UMEC) 178*512kB (UMEC) 51*1024kB (UMC) 47*2048kB (UC) 18*4096kB (UC) =3D =
681680kB
[11204.462171] Node 0 Normal: 14056*4kB (UEH) 13928*8kB (UMEH) =
38891*16kB (UMEH) 35172*32kB (UMEH) 162*64kB (U) 924*128kB (UH) 2*256kB =
(H) 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB =3D 2045072kB
[11204.480482] Node 1 Normal: 16538*4kB (UME) 10181*8kB (UME) 4804*16kB =
(UME) 13628*32kB (UME) 296*64kB (U) 1300*128kB (UME) 1*256kB (U) 0*512kB =
0*1024kB 0*2048kB 0*4096kB =3D 846160kB
[11204.498139] Node 2 Normal: 26478*4kB (UME) 20542*8kB (UME) 8536*16kB =
(UME) 27135*32kB (UME) 207*64kB (U) 2096*128kB (U) 2*256kB (U) 0*512kB =
0*1024kB 0*2048kB 0*4096kB =3D 1557192kB
[11204.515883] Node 3 Normal: 38676*4kB (UME) 56237*8kB (UME) 43905*16kB =
(UME) 42286*32kB (UE) 385*64kB (UE) 2193*128kB (UE) 1*256kB (U) 0*512kB =
0*1024kB 0*2048kB 0*4096kB =3D 2965832kB
[11204.533806] Node 0 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D1048576kB
[11204.543525] Node 0 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D32768kB
[11204.552945] Node 0 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D2048kB
[11204.562353] Node 0 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D64kB
[11204.571526] Node 1 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D1048576kB
[11204.581137] Node 1 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D32768kB
[11204.590554] Node 1 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D2048kB
[11204.599819] Node 1 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D64kB
[11204.608866] Node 2 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D1048576kB
[11204.618314] Node 2 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D32768kB
[11204.627718] Node 2 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D2048kB
[11204.637004] Node 2 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D64kB
[11204.646201] Node 3 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D1048576kB
[11204.655783] Node 3 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D32768kB
[11204.665174] Node 3 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D2048kB
[11204.674608] Node 3 hugepages_total=3D0 hugepages_free=3D0 =
hugepages_surp=3D0 hugepages_size=3D64kB
[11204.683672] 152133 total pagecache pages
[11204.688311] 0 pages in swap cache
[11204.692251] Free swap  =3D 0kB
[11204.695737] Total swap =3D 0kB
[11204.699194] 134216656 pages RAM
[11204.702911] 0 pages HighMem/MovableOnly
[11204.707288] 3535516 pages reserved
[11204.711243] 131072 pages cma reserved
[11204.715446] 0 pages hwpoisoned=

