Return-Path: <netdev+bounces-60808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 452D1821910
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A873F1F2130B
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 09:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF5C6D39;
	Tue,  2 Jan 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdNIH3Iy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CAD79E5
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7cb6386a5ffso996002241.3
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 01:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704188912; x=1704793712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8BwdK6YAGL0fyC0pzJgp2omqYHIyDz0pIenuqiZfUq8=;
        b=QdNIH3IyE7qgHTn8GeeDabLy3tJjJUw5FGLgr7Y8CrDsZTGTiaijd7peVEfEMFwKPU
         UUZHUuSa9UKAUCye331cSuqJn16OTGlk14e5o40o3aYzr3lk9gTehWTX5drG9+6YcRJq
         WW3PI871S55xJhbf8PtW0ErkCqaAeYdIFrP0cMZfPKTbIIayMg2/p9zNylI/JM4bN24v
         qMxpaY84vyR+pd8MTqV+mXnwIClgYkmO3HBtXUXhi0nSbgGVhEAqtOFcr14pMIDw7HOf
         XdXJ9qmGpMjcrjvkZdFl3NycEFEP3w4ZVWB3rJ+cevgisk4rLdAb+ll6vBlMHKjwQ+Oh
         LPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704188912; x=1704793712;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8BwdK6YAGL0fyC0pzJgp2omqYHIyDz0pIenuqiZfUq8=;
        b=ALV1si7Yu6bOY5eZfAtzmKyPWcCSQJ3nsw+LLbJeTnwZzuoP7vIkwGkCuXJzS/vsCh
         Xj15ZjpNTFk38+xL4n/Eg93bYyh499UDXDEd/kCBnOCmMb1VcSvv69tB4MfR0SLCBAOX
         zz6htFIG3RTyciPxJNwhtSeGU0XRAiLHlIF0Zoqhi6T8NZFs3ZMoasnpGlazoHo+8vdo
         w7x7TwEw+2OHOjx+Vp9dyVCpTTyTiutcSyEcr6/G3NoN9bKzbia/SPAOFO/CtV1lgaMc
         cYoQj8BuyoMdc071jL7F3NxpFPRSuUUBSQL3Nn86nLL5U/2ioJnQMCVzzln8S1YIKc1y
         +clA==
X-Gm-Message-State: AOJu0Yww9CGs1c1Ao1NUylNjB+/7M8Wzc3t/lS6skh7vFGqv7Rdo0iLv
	e7G5r7immO8SKIxJiKalLSvThvljRPBVUHJHEsvTeMAicqnPPw==
X-Google-Smtp-Source: AGHT+IFqJ3kfP7gJIvjcMWI/WCjonpd/SdBfDjDRDLdxHJDmUEziWZ3Ly+i9RK1H1NCK7B1+eRzjTLt1Q10pf9eZY6k=
X-Received: by 2002:a05:6102:304a:b0:467:920a:c249 with SMTP id
 w10-20020a056102304a00b00467920ac249mr91022vsa.12.1704188912393; Tue, 02 Jan
 2024 01:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Jan 2024 15:18:21 +0530
Message-ID: <CA+G9fYvu_estw19VvZDXVXGmuXg87FZHk3x7ZNLM-KTGOmXRLQ@mail.gmail.com>
Subject: selftests: net/mptcp: mptcp_connect.sh - Internal error: Oops:
 qdisc_block_add_dev (net/sched/sch_api.c:1191)
To: open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Linux Regressions <regressions@lists.linux.dev>, 
	lkft-triage@lists.linaro.org
Cc: Victor Nogueira <victor@mojatatu.com>, "David S. Miller" <davem@davemloft.net>, 
	Hangyu Hua <hbh25y@gmail.com>, Matthieu Baerts <matthieu.baerts@tessares.net>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Following kernel oops noticed on qemu-arm64 while running
selftests: net/mptcp: mptcp_connect.sh test cases on Linux next-20240102

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
---
# selftests: net/mptcp: mptcp_connect.sh
# INFO: set ns3-6593b550-fBKovo dev ns3eth2: ethtool -K  gso off
# INFO: set ns4-6593b550-fBKovo dev ns4eth3: ethtool -K  gro off
# Created /tmp/tmp.vFrp4xubYR (size 219663 /tmp/tmp.vFrp4xubYR)
containing data sent by client
# Created /tmp/tmp.FrEUtOwsBN (size 5630063 /tmp/tmp.FrEUtOwsBN)
containing data sent by server
# New MPTCP socket can be blocked via sysctl [ OK ]
# INFO: validating network environment with pings
<6>[   32.891365] netem: version 1.3
<1>[   32.901072] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
<1>[   32.901926] Mem abort info:
<1>[   32.903342]   ESR = 0x0000000086000004
<1>[   32.903768]   EC = 0x21: IABT (current EL), IL = 32 bits
<1>[   32.904589]   SET = 0, FnV = 0
<1>[   32.905415]   EA = 0, S1PTW = 0
<1>[   32.905914]   FSC = 0x04: level 0 translation fault
<1>[   32.909254] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000103097000
<1>[   32.909914] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
<0>[   32.913724] Internal error: Oops: 0000000086000004 [#1] PREEMPT SMP
<4>[   32.914739] Modules linked in: sch_netem crct10dif_ce sm3_ce sm3
sha3_ce sha512_ce sha512_arm64 fuse drm backlight dm_mod ip_tables
x_tables
<4>[   32.916764] CPU: 0 PID: 438 Comm: tc Not tainted
6.7.0-rc8-next-20240102 #1
<4>[   32.917555] Hardware name: linux,dummy-virt (DT)
<4>[   32.918608] pstate: 63400809 (nZCv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=-c)
<4>[   32.919392] pc : 0x0
<4>[ 32.920396] lr : qdisc_block_add_dev (net/sched/sch_api.c:1191)

<trim>

<4>[   32.931258] Call trace:
<4>[   32.932088]  0x0
<4>[ 32.932626] qdisc_create (net/sched/sch_api.c:1390)
<4>[ 32.933207] tc_modify_qdisc (net/sched/sch_api.c:1792)
<4>[ 32.933791] rtnetlink_rcv_msg (net/core/rtnetlink.c:6615)
<4>[ 32.934280] netlink_rcv_skb (net/netlink/af_netlink.c:2544)
<4>[ 32.934859] rtnetlink_rcv (net/core/rtnetlink.c:6634)
<4>[ 32.935411] netlink_unicast (net/netlink/af_netlink.c:0
net/netlink/af_netlink.c:1367)
<4>[ 32.935981] netlink_sendmsg (net/netlink/af_netlink.c:1908)
<4>[ 32.936544] ____sys_sendmsg (net/socket.c:733 net/socket.c:745
net/socket.c:2582)
<4>[ 32.937121] __sys_sendmsg (net/socket.c:2638 net/socket.c:2665)
<4>[ 32.937677] __arm64_sys_sendmsg (net/socket.c:2672)
<4>[ 32.938283] invoke_syscall (arch/arm64/kernel/syscall.c:0
arch/arm64/kernel/syscall.c:51)
<4>[ 32.938852] el0_svc_common (include/linux/thread_info.h:127
arch/arm64/kernel/syscall.c:144)
<4>[ 32.939395] do_el0_svc (arch/arm64/kernel/syscall.c:156)
<4>[ 32.939913] el0_svc (arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:679)
<4>[ 32.940388] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:0)
<4>[ 32.940968] el0t_64_sync (arch/arm64/kernel/entry.S:595)

<trim>

<4>[   32.943570] ---[ end trace 0000000000000000 ]---
# ./mptcp_connect.sh: line 856:   438 Segmentation fault      tc -net
"$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay
${tc_delay}ms
# INFO: Using loss of 0.84% delay 16 ms reorder 99% 26% with delay 4ms
on ns3eth4

Steps to reproduce:
---
https://storage.tuxsuite.com/public/linaro/lkft/tests/2aO5JSOqobe3WwSEQP81LncHQ7c/tuxrun_reproducer.sh

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240102/testrun/21857563/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240102/testrun/21857563/suite/log-parser-test/test/check-kernel-oops/log


--
Linaro LKFT
https://lkft.linaro.org

