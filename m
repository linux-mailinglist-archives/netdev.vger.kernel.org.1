Return-Path: <netdev+bounces-129188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B86797E281
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 18:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4161C20891
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E051C695;
	Sun, 22 Sep 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhCk+8wL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108DBC2E3
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727023144; cv=none; b=hdAXITZdayUey6ZdfVGXSAkwQfiijshTUnXHtxfoRRKa/OqUY1OrugeRhf2owH4QXbwaREnHpF0XTk8lBYbFQaByTRVthXwUE0/CiPgCWrOy4/3VWOl/3dC7btE/f6ENeqc7rsB0hTLm5Y1KpeLtFbH+aY6ubBnMAN56BrYhF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727023144; c=relaxed/simple;
	bh=H4eBrSS0Vlp7PL70trBIgt1GoIEYZEaRyGrRVXxGJe0=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=jCtzpmh6Fn33RcJPi6pzviBY2sqK7mfzv9zXEzAWWErlA0w9XO+zaTnyxP/odvuEQiLYVcwsDW0KlxpagjA4Jrv4I0SBq63OrxL7yI6UQ8PVlw3PvBcLPLUTDoCuCc3b9L4o6ypDVPRWJ+baqtgRTtp9qaQcJANOb0f2LGMcZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhCk+8wL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718ebb01fd2so718548b3a.2
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727023141; x=1727627941; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GC/h1pGdxE+k5QwHnHLHL858YEkAYaiwnoKSC5BaEiE=;
        b=DhCk+8wLODFsCRQ9P19y/Vy/XwOw7hW5AHrr8SRSmbsuNCEce+Aab3Am6o36W6MoOA
         JaJnW1Kp38TwJNsRhsRB/9jkCFilfwWfUwB6KaQSrUc96aOweY5mi7zfnnrGS4Rvlu/4
         1lPufe9tqaaaJweGXvIKxGZCTiKl6X5DrdOh6UvxP6jIwtXoXN3n8uuPOpHZZ7lC/boS
         qDoGmBfoeMNv1S+GDi4gSf+En7utgd2xCIFT0qg+D+L8TnZifZUxD2OUDi8yatQIH0PZ
         mTaOEE+4Gs/nMm6MuF46bGGfKAwQHzZLSlj2pc6wppZgo0tsDQrARfXw1wxXHj+P/874
         QgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727023141; x=1727627941;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GC/h1pGdxE+k5QwHnHLHL858YEkAYaiwnoKSC5BaEiE=;
        b=EVQTvToenF+QwLwIpLlemDRLOoF6kvLJrdrj0kr7ND7z8RLp/YkCoqLm2X9y/dsRj4
         +jvlJru/MpAciLlrB5j3JPNjDj4r6zj44XHvKjGOlqZXQ74kWNOJMo1pDG0EdVI+CTX0
         5F118Jz97H/3/tIK0/zEWvbGTSWape4xUUv1jaAG3RdR6QPUicSwUB8IFHpXZjiSwzam
         6NQe3GcW3FOaXcBELwyfj6KTQJAWmStabu+2JPgKNx2fM4O4zzjDc7Dy46xg2vM5WSaJ
         N8hIfovN4koQI6tUHq4UVbDPfTqi9v50bA5JDzqdsMnqiIZmqRuaC460XwGx2EPM6D+m
         9MpA==
X-Gm-Message-State: AOJu0Yyc4RAL5CEUe2wgNOhGvAGfezw/l7r0/qLHysu244fFF4q6I55k
	ct7qHHZEbLkj8bHUQTuDCn+8nu7I5VBzhWzJQDlFH4v+EbvnWJ9O
X-Google-Smtp-Source: AGHT+IHOb6JxCE/Y/fQpRaNtN4m5fSoYh4o2tqOqDOo3g1TQcWMdyKxQSv/I9FWqOaesIzZjWTXq6Q==
X-Received: by 2002:a17:903:41c6:b0:207:6dc:b6d7 with SMTP id d9443c01a7336-208d83f388emr59545495ad.7.1727023140774;
        Sun, 22 Sep 2024 09:39:00 -0700 (PDT)
Received: from smtpclient.apple (v133-130-115-230.a046.g.tyo1.static.cnode.io. [133.130.115.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079473c86csm120928865ad.286.2024.09.22.09.38.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2024 09:39:00 -0700 (PDT)
From: Miao Wang <shankerwangmiao@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: [BUG Report] hns3: tx_timeout on high memory pressure
Message-Id: <4068C110-62E5-4EAA-937C-D298805C56AE@gmail.com>
Date: Mon, 23 Sep 2024 00:38:42 +0800
Cc: netdev@vger.kernel.org,
 =?utf-8?B?6ZmI5pmf56W6?= <harry-chen@outlook.com>,
 =?utf-8?B?5byg5a6H57+U?= <zz593141477@gmail.com>,
 =?utf-8?B?6ZmI5ZiJ5p2w?= <jiegec@qq.com>,
 Mirror Admin Tuna <mirroradmin@tuna.tsinghua.edu.cn>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)

Hi,

I'm writing to report a possible bug happens when I'm using hns3, i.e. =
the
integrated NIC in Kunpeng 920 CPUS. My server is equipped with double =
Kunpeng
920-4826 CPUs, with 48 cores each. A TM280 flex IO card is attached in =
the
position of FlexIO card 1, exposing quadruple 25G SPF28 ports. I =
currently use
the first two of them to connect the server to the upstream switch, =
forming an
802.11ad bonding. Current running kernel is from Debian, the package =
version is
5.10.0-27-arm64, based on 5.10.205.

In recent period of time, the server lost network connection for several =
times.
When I logged into the server, I can see both of the ports are in the =
DOWN
state. The upstream switch also reports the link is down. In the kernel =
dmesg,
I could see logs from the hns3 driver, stating that tx timeout has =
happened and
resetting the port failed due to memory allocation failure. When this =
symptom
happened, I could notice that the system was facing high memory =
pressure, when
memory was beyond cgroup limit and cgroup OOM-killer was working. But =
this does
not happen every time there is OOM in a cgroup.

The detailed log is attached below. The first part is mixed in the =
output of
OOM-killer:

2024-09-19T16:27:09.961670+08:00 bravo kernel: [19184251.328099] [ =
469442] 65534 469442     1288      723    49152        0             0 =
git-http-backen
2024-09-19T16:27:09.982094+08:00 bravo kernel: [19184251.338343] [ =
469441] 65534 469441     1313      746    49152        0             0 =
git-http-backen
2024-09-19T16:27:09.982154+08:00 bravo kernel: [19184251.348583] [ =
469444] 65534 469444   264600     1031    65536        0             0 =
git
2024-09-19T16:27:10.000504+08:00 bravo kernel: [19184251.357785] [ =
469445] 65534 469445     1988     1110    57344        0             0 =
git
2024-09-19T16:27:10.000559+08:00 bravo kernel: [19184251.367010] [ =
469447] 65534 469447  4983704     3938   786432        0             0 =
git
2024-09-19T16:27:10.009659+08:00 bravo kernel: [19184251.374925] hns3 =
0000:7d:00.1 enp125s0f1: queue state: 0x6, delta msecs: 5556
2024-09-19T16:27:10.009689+08:00 bravo kernel: [19184251.376152] [ =
469448] 65534 469448     1288      247    49152        0             0 =
git-http-backen
2024-09-19T16:27:10.017479+08:00 bravo kernel: [19184251.383964] hns3 =
0000:7d:00.1 enp125s0f1: tx_timeout count: 35, queue id: 1, SW_NTU: =
0x346, SW_NTC: 0x334, napi state: 17
2024-09-19T16:27:10.017493+08:00 bravo kernel: [19184251.383967] hns3 =
0000:7d:00.1 enp125s0f1: tx_pkts: 139894139, tx_bytes: 2708182189429, =
sw_err_cnt: 0, tx_pending: 0
2024-09-19T16:27:10.017502+08:00 bravo kernel: [19184251.383977] hns3 =
0000:7d:00.1 enp125s0f1: seg_pkt_cnt: 0, tx_more: 41158, restart_queue: =
0, tx_busy: 0
2024-09-19T16:27:10.039320+08:00 bravo kernel: [19184251.394041] [ =
469449] 65534 469449     1288      721    49152        0             0 =
git-http-backen
2024-09-19T16:27:10.039337+08:00 bravo kernel: [19184251.394045] [ =
469451] 65534 469451     1897     1045    53248        0             0 =
git
2024-09-19T16:27:10.050625+08:00 bravo kernel: [19184251.406172] hns3 =
0000:7d:00.1 enp125s0f1: tx_pause_cnt: 0, rx_pause_cnt: 0
2024-09-19T16:27:10.062202+08:00 bravo kernel: [19184251.417435] [ =
469453] 65534 469453     1754     1030    53248        0             0 =
git
2024-09-19T16:27:10.062257+08:00 bravo kernel: [19184251.427271] hns3 =
0000:7d:00.1 enp125s0f1: BD_NUM: 0x7f HW_HEAD: 0x346, HW_TAIL: 0x346, =
BD_ERR: 0x0, INT: 0x0
2024-09-19T16:27:10.062261+08:00 bravo kernel: [19184251.427274] hns3 =
0000:7d:00.1 enp125s0f1: RING_EN: 0x1, TC: 0x0, FBD_NUM: 0x0 FBD_OFT: =
0x0, EBD_NUM: 0x400, EBD_OFT: 0x0
2024-09-19T16:27:10.062264+08:00 bravo kernel: [19184251.427278] hns3 =
0000:7d:00.1: received reset event, reset type is 5
2024-09-19T16:27:10.062265+08:00 bravo kernel: [19184251.427386] hns3 =
0000:7d:00.1: PF reset requested
2024-09-19T16:27:10.086931+08:00 bravo kernel: [19184251.437684] [ =
469454] 65534 469454     1288      248    49152        0             0 =
git-http-backen
2024-09-19T16:27:10.086985+08:00 bravo kernel: [19184251.437691] [ =
469455] 65534 469455     1723      973    53248        0             0 =
git
2024-09-19T16:27:10.161412+08:00 bravo kernel: [19184251.518070] [ =
469481] 65534 469481     1288      722    49152        0             0 =
git-http-backen
2024-09-19T16:27:10.161473+08:00 bravo kernel: [19184251.527904] [ =
469482] 65534 469482   281633     1010    77824        0             0 =
git
2024-09-19T16:27:10.180198+08:00 bravo kernel: [19184251.537277] [ =
469484] 65534 469484   806428    12275   450560        0             0 =
git

The second part is the process of resetting the interface:

2024-09-19T16:27:10.480681+08:00 bravo kernel: [19184251.830097] hns3 =
0000:7d:00.1 enp125s0f1: link down
2024-09-19T16:27:10.480746+08:00 bravo kernel: [19184251.845467] bond0: =
(slave enp125s0f1): link status definitely down, disabling slave
2024-09-19T16:27:10.529056+08:00 bravo kernel: [19184251.856566] bond0: =
active interface up!
2024-09-19T16:27:10.568458+08:00 bravo kernel: [19184251.928392] hns3 =
0000:7d:00.1: get sfp info failed -16
2024-09-19T16:27:10.596440+08:00 bravo kernel: [19184251.957449] hns3 =
0000:7d:00.1: prepare wait ok
2024-09-19T16:27:10.608462+08:00 bravo kernel: [19184251.963086] bond0: =
(slave enp125s0f1): link status definitely down, disabling slave
2024-09-19T16:27:10.648433+08:00 bravo kernel: [19184252.004057] hns3 =
0000:7d:00.1: The firmware version is 1.9.33.10
2024-09-19T16:27:10.716438+08:00 bravo kernel: [19184252.073406] hns3 =
0000:7d:00.1: Reset done, hclge driver initialization finished.
2024-09-19T16:27:10.807437+08:00 bravo kernel: [19184252.168449] =
warn_alloc: 3 callbacks suppressed
2024-09-19T16:27:10.807486+08:00 bravo kernel: [19184252.168454] =
kworker/0:1: page allocation failure: order:4, =
mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), =
nodemask=3D(null),cpuset=3D/,mems_allowed=3D0-3
2024-09-19T16:27:10.949461+08:00 bravo kernel: [19184252.188482] CPU: 0 =
PID: 412440 Comm: kworker/0:1 Kdump: loaded Tainted: P        W  OE     =
5.10.0-27-arm64 #1 Debian 5.10.205-2
2024-09-19T16:27:10.949510+08:00 bravo kernel: [19184252.201124] =
Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDDA, BIOS 1.35 =
04/30/2020
2024-09-19T16:27:10.949513+08:00 bravo kernel: [19184252.210067] =
Workqueue: hclge hclge_service_task [hclge]
2024-09-19T16:27:10.949515+08:00 bravo kernel: [19184252.215967] Call =
trace:
2024-09-19T16:27:10.949517+08:00 bravo kernel: [19184252.219305]  =
dump_backtrace+0x0/0x200
2024-09-19T16:27:10.949519+08:00 bravo kernel: [19184252.223947]  =
show_stack+0x20/0x30
2024-09-19T16:27:10.949521+08:00 bravo kernel: [19184252.228296]  =
dump_stack+0xe8/0x124
2024-09-19T16:27:10.949545+08:00 bravo kernel: [19184252.232723]  =
warn_alloc+0x120/0x194
2024-09-19T16:27:10.949549+08:00 bravo kernel: [19184252.237281]  =
__alloc_pages_nodemask+0xe68/0xeac
2024-09-19T16:27:10.949551+08:00 bravo kernel: [19184252.242809]  =
kmalloc_large_node+0x60/0x140
2024-09-19T16:27:10.949553+08:00 bravo kernel: [19184252.247927]  =
__kmalloc_node_track_caller+0x2d4/0x33c
2024-09-19T16:27:10.949555+08:00 bravo kernel: [19184252.253904]  =
devm_kmalloc+0x5c/0x120
2024-09-19T16:27:10.949558+08:00 bravo kernel: [19184252.258468]  =
hns3_init_all_ring+0x88/0x1ec [hns3]
2024-09-19T16:27:10.949561+08:00 bravo kernel: [19184252.264171]  =
hns3_reset_notify_init_enet+0xfc/0x250 [hns3]
2024-09-19T16:27:10.949563+08:00 bravo kernel: [19184252.270617]  =
hns3_reset_notify+0x70/0x80 [hns3]
2024-09-19T16:27:10.949565+08:00 bravo kernel: [19184252.276020]  =
hclge_notify_client+0x80/0xf0 [hclge]
2024-09-19T16:27:10.949567+08:00 bravo kernel: [19184252.281493]  =
hclge_reset_rebuild+0x414/0x860 [hclge]
2024-09-19T16:27:10.949569+08:00 bravo kernel: [19184252.287129]  =
hclge_reset_service_task+0x3e8/0x644 [hclge]
2024-09-19T16:27:10.949571+08:00 bravo kernel: [19184252.293196]  =
hclge_service_task+0x74/0x77c [hclge]
2024-09-19T16:27:10.949572+08:00 bravo kernel: [19184252.298652]  =
process_one_work+0x1d0/0x4d0
2024-09-19T16:27:10.949574+08:00 bravo kernel: [19184252.303326]  =
worker_thread+0x180/0x540
2024-09-19T16:27:10.949576+08:00 bravo kernel: [19184252.307738]  =
kthread+0x12c/0x130
2024-09-19T16:27:10.949577+08:00 bravo kernel: [19184252.311632]  =
ret_from_fork+0x10/0x34
2024-09-19T16:27:10.949588+08:00 bravo kernel: [19184252.316067] =
Mem-Info:
2024-09-19T16:27:10.992612+08:00 bravo kernel: [19184252.319367] =
active_anon:162992 inactive_anon:26930041 isolated_anon:2
2024-09-19T16:27:10.992659+08:00 bravo kernel: [19184252.319367]  =
active_file:234667 inactive_file:674744 isolated_file:37
2024-09-19T16:27:10.992662+08:00 bravo kernel: [19184252.319367]  =
unevictable:0 dirty:991 writeback:0
2024-09-19T16:27:10.992663+08:00 bravo kernel: [19184252.319367]  =
slab_reclaimable:279001 slab_unreclaimable:3081176
2024-09-19T16:27:10.992665+08:00 bravo kernel: [19184252.319367]  =
mapped:761827 shmem:216400 pagetables:320346 bounce:0
2024-09-19T16:27:10.992666+08:00 bravo kernel: [19184252.319367]  =
free:961166 free_pcp:27962 free_cma:905
2024-09-19T16:27:10.992668+08:00 bravo kernel: [19184252.359068] Node 0 =
active_anon:465896kB inactive_anon:29576436kB active_file:204772kB =
inactive_file:688512kB unevictable:0kB isolated(anon):0kB isolated(file)
:116kB mapped:761096kB dirty:100kB writeback:0kB shmem:482100kB =
shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 1030144kB =
writeback_tmp:0kB kernel_stack:23472kB all_unreclaimable? no
2024-09-19T16:27:11.024443+08:00 bravo kernel: [19184252.390885] Node 1 =
active_anon:59184kB inactive_anon:23798416kB active_file:393432kB =
inactive_file:1060012kB unevictable:0kB isolated(anon):4kB =
isolated(file)
:100kB mapped:1226432kB dirty:3236kB writeback:0kB shmem:74528kB =
shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 16384kB writeback_tmp:0kB =
kernel_stack:24208kB all_unreclaimable? no
2024-09-19T16:27:11.087033+08:00 bravo kernel: [19184252.422253] Node 2 =
active_anon:54484kB inactive_anon:29344816kB active_file:105332kB =
inactive_file:100528kB unevictable:0kB isolated(anon):4kB =
isolated(file):
0kB mapped:146276kB dirty:24kB writeback:0kB shmem:53516kB shmem_thp: =
0kB shmem_pmdmapped: 0kB anon_thp: 14336kB writeback_tmp:0kB =
kernel_stack:21280kB all_unreclaimable? no
2024-09-19T16:27:11.087086+08:00 bravo kernel: [19184252.453493] Node 3 =
active_anon:72396kB inactive_anon:24660108kB active_file:250976kB =
inactive_file:898412kB unevictable:0kB isolated(anon):0kB =
isolated(file):
128kB mapped:960240kB dirty:604kB writeback:0kB shmem:255456kB =
shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 2048kB writeback_tmp:0kB =
kernel_stack:21040kB all_unreclaimable? no
2024-09-19T16:27:11.149008+08:00 bravo kernel: [19184252.485173] Node 0 =
DMA free:236912kB min:740kB low:2444kB high:4148kB =
reserved_highatomic:2048KB active_anon:72kB inactive_anon:1349928kB =
active_file:4kB inac
tive_file:0kB unevictable:0kB writepending:0kB present:2092864kB =
managed:1733916kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:28kB =
local_pcp:0kB free_cma:3620kB
2024-09-19T16:27:11.149046+08:00 bravo kernel: [19184252.515423] =
lowmem_reserve[]: 0 0 58358 58358
2024-09-19T16:27:11.188088+08:00 bravo kernel: [19184252.520932] Node 0 =
Normal free:860192kB min:66936kB low:126692kB high:186448kB =
reserved_highatomic:2048KB active_anon:465804kB inactive_anon:28185748kB =
active
_file:206444kB inactive_file:711584kB unevictable:0kB writepending:100kB =
present:65011712kB managed:59759400kB mlocked:0kB pagetables:306396kB =
bounce:0kB free_pcp:10676kB local_pcp:0kB free_cma:0kB
2024-09-19T16:27:11.188141+08:00 bravo kernel: [19184252.554538] =
lowmem_reserve[]: 0 0 0 0
2024-09-19T16:27:11.226952+08:00 bravo kernel: [19184252.559391] Node 1 =
Normal free:1538276kB min:269956kB low:336012kB high:402068kB =
reserved_highatomic:2048KB active_anon:59172kB inactive_anon:23862524kB =
activ
e_file:388548kB inactive_file:1089724kB unevictable:0kB =
writepending:3236kB present:67108864kB managed:66057084kB mlocked:0kB =
pagetables:329020kB bounce:0kB free_pcp:50360kB local_pcp:0kB =
free_cma:0kB
2024-09-19T16:27:11.227008+08:00 bravo kernel: [19184252.593423] =
lowmem_reserve[]: 0 0 0 0
2024-09-19T16:27:11.264637+08:00 bravo kernel: [19184252.598107] Node 2 =
Normal free:524764kB min:34860kB low:100916kB high:166972kB =
reserved_highatomic:2048KB active_anon:54468kB inactive_anon:29337972kB =
active_
file:111076kB inactive_file:121420kB unevictable:0kB writepending:40kB =
present:67108864kB managed:66057072kB mlocked:0kB pagetables:382324kB =
bounce:0kB free_pcp:42340kB local_pcp:0kB free_cma:0kB
2024-09-19T16:27:11.264702+08:00 bravo kernel: [19184252.631104] =
lowmem_reserve[]: 0 0 0 0
2024-09-19T16:27:11.304251+08:00 bravo kernel: [19184252.636179] Node 3 =
Normal free:805352kB min:267792kB low:333320kB high:398848kB =
reserved_highatomic:2048KB active_anon:72376kB inactive_anon:24657996kB =
active
_file:252960kB inactive_file:909812kB unevictable:0kB writepending:604kB =
present:67108864kB managed:65529588kB mlocked:0kB pagetables:262796kB =
bounce:0kB free_pcp:54384kB local_pcp:0kB free_cma:0kB
2024-09-19T16:27:11.304307+08:00 bravo kernel: [19184252.670723] =
lowmem_reserve[]: 0 0 0 0
2024-09-19T16:27:11.329707+08:00 bravo kernel: [19184252.675574] Node 0 =
DMA: 1008*4kB (UMHC) 714*8kB (UMHC) 543*16kB (UM) 278*32kB (UMEHC) =
131*64kB (UMEHC) 93*128kB (UMEHC) 112*256kB (UMEHC) 82*512kB (UMEHC) 51*
1024kB (UMEH) 11*2048kB (UMEC) 11*4096kB (UM) =3D 238080kB
2024-09-19T16:27:11.329755+08:00 bravo kernel: [19184252.696180] Node 0 =
Normal: 83839*4kB (UMEH) 59821*8kB (UME) 2063*16kB (UMEH) 2*32kB (H) =
2*64kB (H) 1*128kB (H) 1*256kB (H) 0*512kB 0*1024kB 0*2048kB 0*4096kB=20
=3D 847508kB
2024-09-19T16:27:11.363103+08:00 bravo kernel: [19184252.713001] Node 1 =
Normal: 224854*4kB (UME) 68037*8kB (UMEH) 5242*16kB (UMEH) 0*32kB 1*64kB =
(H) 2*128kB (H) 0*256kB 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB =3D 1
528416kB
2024-09-19T16:27:11.363169+08:00 bravo kernel: [19184252.729577] Node 2 =
Normal: 76663*4kB (U) 19963*8kB (UE) 1544*16kB (UE) 2*32kB (H) 7*64kB =
(H) 1*128kB (H) 1*256kB (H) 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB =3D=20=

492468kB
2024-09-19T16:27:11.398155+08:00 bravo kernel: [19184252.747281] Node 3 =
Normal: 114940*4kB (UME) 51349*8kB (UME) 3786*16kB (UME) 0*32kB 0*64kB =
1*128kB (H) 1*256kB (H) 0*512kB 1*1024kB (H) 0*2048kB 0*4096kB =3D 932
536kB
2024-09-19T16:27:11.398224+08:00 bravo kernel: [19184252.764634] Node 0 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D1048576kB
2024-09-19T16:27:11.418246+08:00 bravo kernel: [19184252.774940] Node 0 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D32768kB
2024-09-19T16:27:11.418258+08:00 bravo kernel: [19184252.784707] Node 0 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D2048kB
2024-09-19T16:27:11.427731+08:00 bravo kernel: [19184252.794204] Node 0 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D64kB
2024-09-19T16:27:11.446658+08:00 bravo kernel: [19184252.803465] Node 1 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D1048576kB
2024-09-19T16:27:11.446670+08:00 bravo kernel: [19184252.813126] Node 1 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D32768kB
2024-09-19T16:27:11.466249+08:00 bravo kernel: [19184252.822612] Node 1 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D2048kB
2024-09-19T16:27:11.466276+08:00 bravo kernel: [19184252.832606] Node 1 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D64kB
2024-09-19T16:27:11.486098+08:00 bravo kernel: [19184252.842359] Node 2 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D1048576kB
2024-09-19T16:27:11.486144+08:00 bravo kernel: [19184252.852551] Node 2 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D32768kB
2024-09-19T16:27:11.505975+08:00 bravo kernel: [19184252.862570] Node 2 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D2048kB
2024-09-19T16:27:11.506016+08:00 bravo kernel: [19184252.872431] Node 2 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D64kB
2024-09-19T16:27:11.524873+08:00 bravo kernel: [19184252.881782] Node 3 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D1048576kB
2024-09-19T16:27:11.524899+08:00 bravo kernel: [19184252.891339] Node 3 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D32768kB
2024-09-19T16:27:11.543461+08:00 bravo kernel: [19184252.900690] Node 3 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D2048kB
2024-09-19T16:27:11.543483+08:00 bravo kernel: [19184252.909932] Node 3 =
hugepages_total=3D0 hugepages_free=3D0 hugepages_surp=3D0 =
hugepages_size=3D64kB
2024-09-19T16:27:11.557828+08:00 bravo kernel: [19184252.918993] 1183424 =
total pagecache pages
2024-09-19T16:27:11.557857+08:00 bravo kernel: [19184252.924305] 0 pages =
in swap cache
2024-09-19T16:27:11.562364+08:00 bravo kernel: [19184252.928806] Swap =
cache stats: add 0, delete 0, find 0/0
2024-09-19T16:27:11.568801+08:00 bravo kernel: [19184252.935225] Free =
swap  =3D 0kB
2024-09-19T16:27:11.580448+08:00 bravo kernel: [19184252.939308] Total =
swap =3D 0kB
2024-09-19T16:27:11.580488+08:00 bravo kernel: [19184252.943358] =
67107792 pages RAM
2024-09-19T16:27:11.586142+08:00 bravo kernel: [19184252.947605] 0 pages =
HighMem/MovableOnly
2024-09-19T16:27:11.586159+08:00 bravo kernel: [19184252.952573] 2323527 =
pages reserved
2024-09-19T16:27:11.595434+08:00 bravo kernel: [19184252.957108] 131072 =
pages cma reserved
2024-09-19T16:27:11.595466+08:00 bravo kernel: [19184252.961883] 0 pages =
hwpoisoned
2024-09-19T16:27:11.606457+08:00 bravo kernel: [19184252.966031] hns3 =
0000:7d:00.1: Alloc ring memory fail! ret=3D-12
2024-09-19T16:27:11.650402+08:00 bravo kernel: [19184253.004100] hns3 =
0000:7d:00.1: notify nic client failed 2(-12)
2024-09-19T16:27:11.650429+08:00 bravo kernel: [19184253.010794] hns3 =
0000:7d:00.1: re-schedule reset task(1)
2024-09-19T16:27:11.797021+08:00 bravo kernel: [19184253.150913] hns3 =
0000:7d:00.1: prepare wait ok
2024-09-19T16:27:11.797073+08:00 bravo kernel: [19184253.156524] hns3 =
0000:7d:00.1 enp125s0f1: already uninitialized
2024-09-19T16:27:11.797086+08:00 bravo kernel: [19184253.163522] hns3 =
0000:7d:00.1: The firmware version is 1.9.33.10
2024-09-19T16:27:11.896470+08:00 bravo kernel: [19184253.253485] hns3 =
0000:7d:00.1: Reset done, hclge driver initialization finished.
2024-09-19T16:27:11.932436+08:00 bravo kernel: [19184253.291699] hns3 =
0000:7d:00.1: Alloc ring memory fail! ret=3D-12
2024-09-19T16:27:11.988427+08:00 bravo kernel: [19184253.341698] hns3 =
0000:7d:00.1: notify nic client failed 2(-12)
2024-09-19T16:27:11.988450+08:00 bravo kernel: [19184253.348636] hns3 =
0000:7d:00.1: re-schedule reset task(2)
2024-09-19T16:27:12.112305+08:00 bravo kernel: [19184253.466903] hns3 =
0000:7d:00.1: prepare wait ok
2024-09-19T16:27:12.112348+08:00 bravo kernel: [19184253.472208] hns3 =
0000:7d:00.1 enp125s0f1: already uninitialized
2024-09-19T16:27:12.112360+08:00 bravo kernel: [19184253.478787] hns3 =
0000:7d:00.1: The firmware version is 1.9.33.10
2024-09-19T16:27:12.212439+08:00 bravo kernel: [19184253.569362] hns3 =
0000:7d:00.1: Reset done, hclge driver initialization finished.
2024-09-19T16:27:12.248410+08:00 bravo kernel: [19184253.605878] hns3 =
0000:7d:00.1: Alloc ring memory fail! ret=3D-12
2024-09-19T16:27:12.307904+08:00 bravo kernel: [19184253.661702] hns3 =
0000:7d:00.1: notify nic client failed 2(-12)
2024-09-19T16:27:12.307917+08:00 bravo kernel: [19184253.668411] hns3 =
0000:7d:00.1: re-schedule reset task(3)
2024-09-19T16:27:12.452071+08:00 bravo kernel: [19184253.806899] hns3 =
0000:7d:00.1: prepare wait ok
2024-09-19T16:27:12.452128+08:00 bravo kernel: [19184253.812028] hns3 =
0000:7d:00.1 enp125s0f1: already uninitialized
2024-09-19T16:27:12.452140+08:00 bravo kernel: [19184253.818527] hns3 =
0000:7d:00.1: The firmware version is 1.9.33.10
2024-09-19T16:27:12.572454+08:00 bravo kernel: [19184253.929430] hns3 =
0000:7d:00.1: Reset done, hclge driver initialization finished.
2024-09-19T16:27:12.688464+08:00 bravo kernel: [19184254.044574] hns3 =
0000:7d:00.1: Alloc ring memory fail! ret=3D-12
2024-09-19T16:27:12.722215+08:00 bravo kernel: [19184254.076405] hns3 =
0000:7d:00.1: notify nic client failed 2(-12)
2024-09-19T16:27:12.722259+08:00 bravo kernel: [19184254.082824] hns3 =
0000:7d:00.1: re-schedule reset task(4)
2024-09-19T16:27:12.843980+08:00 bravo kernel: [19184254.198875] hns3 =
0000:7d:00.1: prepare wait ok
2024-09-19T16:27:12.843987+08:00 bravo kernel: [19184254.203974] hns3 =
0000:7d:00.1 enp125s0f1: already uninitialized
2024-09-19T16:27:12.843990+08:00 bravo kernel: [19184254.210434] hns3 =
0000:7d:00.1: The firmware version is 1.9.33.10
2024-09-19T16:27:12.940434+08:00 bravo kernel: [19184254.297390] hns3 =
0000:7d:00.1: Reset done, hclge driver initialization finished.
2024-09-19T16:27:12.976514+08:00 bravo kernel: [19184254.335451] hns3 =
0000:7d:00.1: Alloc ring memory fail! ret=3D-12
2024-09-19T16:27:13.017669+08:00 bravo kernel: [19184254.371755] hns3 =
0000:7d:00.1: notify nic client failed 2(-12)
2024-09-19T16:27:13.017675+08:00 bravo kernel: [19184254.378249] hns3 =
0000:7d:00.1: re-schedule reset task(5)
2024-09-19T16:27:13.156212+08:00 bravo kernel: [19184254.510871] hns3 =
0000:7d:00.1: prepare wait ok
2024-09-19T16:27:13.156226+08:00 bravo kernel: [19184254.516038] hns3 =
0000:7d:00.1 enp125s0f1: already uninitialized
2024-09-19T16:27:13.156237+08:00 bravo kernel: [19184254.522680] hns3 =
0000:7d:00.1: The firmware version is 1.9.33.10
2024-09-19T16:27:13.238351+08:00 bravo kernel: [19184254.593369] hns3 =
0000:7d:00.1: Reset done, hclge driver initialization finished.
2024-09-19T16:27:13.268499+08:00 bravo kernel: [19184254.625811] hns3 =
0000:7d:00.1: Alloc ring memory fail! ret=3D-12
2024-09-19T16:27:13.313518+08:00 bravo kernel: [19184254.668595] hns3 =
0000:7d:00.1: notify nic client failed 2(-12)
2024-09-19T16:27:13.313545+08:00 bravo kernel: [19184254.675243] hns3 =
0000:7d:00.1: Reset fail!
2024-09-19T16:27:13.313549+08:00 bravo kernel: [19184254.679950] hns3 =
0000:7d:00.1: PF reset count: 100
2024-09-19T16:27:13.324228+08:00 bravo kernel: [19184254.685320] hns3 =
0000:7d:00.1: FLR reset count: 10
2024-09-19T16:27:13.324246+08:00 bravo kernel: [19184254.690675] hns3 =
0000:7d:00.1: GLOBAL reset count: 0
2024-09-19T16:27:13.335051+08:00 bravo kernel: [19184254.696221] hns3 =
0000:7d:00.1: IMP reset count: 0
2024-09-19T16:27:13.335076+08:00 bravo kernel: [19184254.701524] hns3 =
0000:7d:00.1: reset done count: 34
2024-09-19T16:27:13.346339+08:00 bravo kernel: [19184254.706992] hns3 =
0000:7d:00.1: HW reset done count: 110
2024-09-19T16:27:13.346356+08:00 bravo kernel: [19184254.712788] hns3 =
0000:7d:00.1: reset count: 110
2024-09-19T16:27:13.351472+08:00 bravo kernel: [19184254.717900] hns3 =
0000:7d:00.1: reset fail count: 5
2024-09-19T16:27:13.357093+08:00 bravo kernel: [19184254.723514] hns3 =
0000:7d:00.1: vector0 interrupt enable status: 0x1
2024-09-19T16:27:13.364167+08:00 bravo kernel: [19184254.730596] hns3 =
0000:7d:00.1: reset interrupt source: 0x0
2024-09-19T16:27:13.370494+08:00 bravo kernel: [19184254.736912] hns3 =
0000:7d:00.1: reset interrupt status: 0x0
2024-09-19T16:27:13.376773+08:00 bravo kernel: [19184254.743198] hns3 =
0000:7d:00.1: hardware reset status: 0x0
2024-09-19T16:27:13.389147+08:00 bravo kernel: [19184254.749450] hns3 =
0000:7d:00.1: handshake status: 0x10080
2024-09-19T16:27:13.389200+08:00 bravo kernel: [19184254.755576] hns3 =
0000:7d:00.1: function reset status: 0x0
2024-09-19T16:27:13.400727+08:00 bravo kernel: [19184254.761757] hns3 =
0000:7d:00.1: hdev state: 0x152

It seems that hns3 driver is trying to allocating 16 continuous pages of =
memory
when initializing, which could fail when the system is under high memory
pressure.=20

I have two questions about this:

1. Is it expected that tx timeout really related to the high memory =
pressure,
   or the driver does not work properly under such condition?

2. Can allocating continuous pages of memory on initialization can be =
avoided?
   I previously met similar problem on the veth driver, which was latter =
fixed
   by commit  1ce7d306ea63 ("veth: try harder when allocating queue =
memory"),
   where the memory allocating was changed to kvcalloc() to reduces the
   possibility of allocation failure. I wonder if similar changes can be =
applied
   to hns3 when allocating memory regions for non-DMA usage.
  =20
This problem is really annoying and I currently have no reliable way to
reproduce this issue, and the problem happens only 2-3 times per month, =
making
debugging even harder. Your help is appreciated.=20

Cheers,

Miao Wang=

