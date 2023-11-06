Return-Path: <netdev+bounces-46120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C657E184A
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 02:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9AEBB20D33
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 01:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41D3396;
	Mon,  6 Nov 2023 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="FpfHOKwL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D2395
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 01:19:44 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D27DD;
	Sun,  5 Nov 2023 17:19:43 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A61BWrp004583;
	Mon, 6 Nov 2023 01:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=K4pnxYoJ+KUr7qtKNvXwCC+8/biQl4yzw7nV3oJbvW0=; b=
	FpfHOKwLuvDXvWFwHlkHGwOnbtGENolcziAQ0gw8Ke62R4fNXCToWY2dlxzLLPoH
	8BCWaCtkKT+NekSFbzkqInd/XjI/k54LtLHCzK9Vr9K2lK7I0u00aMkTH0vsQEy+
	yAVZ9a3N9yNimq4dEJhhFxBWnlTGbQ9emRNZIkZRjuNFuIl7OnaZIqGJJKah04JU
	3uOkS7eHsbUrsNH+Izg8qVK7/ZWPo6sqWe9+1Xq8UA6cRMasI2lPy35NpYOT+Fj9
	8j5j3T0g63IYugKhQxkxwhjR7mxIVw+S8tFiQRVBK2dZB5sPwGCjnAoOVaXujjnE
	rP6jbkHnBmjS4vKEnKs7gA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u5b5x18xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 06 Nov 2023 01:19:30 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 17:19:31 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.34 via Frontend Transport; Sun, 5 Nov 2023 17:19:29 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <reibax@gmail.com>,
        <richardcochran@gmail.com>, <rrameshbabu@nvidia.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] ptp: fix null ptr deref in ptp_ioctrl
Date: Mon, 6 Nov 2023 09:19:26 +0800
Message-ID: <20231106011926.2928881-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <000000000000e7b62806096c7d67@google.com>
References: <000000000000e7b62806096c7d67@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: LbJdJ5OTJzXKelAKrb_qclTiGzYOGAH5
X-Proofpoint-ORIG-GUID: LbJdJ5OTJzXKelAKrb_qclTiGzYOGAH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-05_21,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=499 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2311060008

In the logs recorded in the strace log,
https://syzkaller.appspot.com/text?tag=CrashLog&x=11aa125f680000
...
openat(AT_FDCWD, "/dev/ptp0", O_RDONLY) = 3
read(3, 0x20000080, 90)                 = -1 EINVAL (Invalid argument)
general protection fault, probably for non-canonical address 0xdffffc000000020b: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000000001058-0x000000000000105f]
CPU: 0 PID: 5053 Comm: syz-executor353 Not tainted 6.6.0-syzkaller-10396-g4652b8e4f3ff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:ptp_ioctl+0xcb7/0x1d10
Code: 81 fe 13 3d 00 00 0f 85 9c 02 00 00 e8 c2 83 23 fa 49 8d bc 24 58 10 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 dc 0e 00 00 49 8b bc 24 58 10 00 00 ba 00 01 00
RSP: 0018:ffffc90003a37ba0 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: ffff88814a78a000 RCX: ffffffff8764f81f
RDX: 000000000000020b RSI: ffffffff8765028e RDI: 0000000000001058
RBP: ffffc90003a37ec0 R08: 0000000000000005 R09: ffffc90003a37c40
R10: 0000000000003d13 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc90003a37c80 R14: 0000000000003d13 R15: ffffffff92ac78e8
FS:  00005555569a9380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000076e09000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ? show_regs+0x8f/0xa0
 ? die_addr+0x4f/0xd0
 ? exc_general_protection+0x154/0x230
 ? asm_exc_general_protection+0x26/0x30
 ? ptp_ioctl+0x22f/0x1d10
 ? ptp_ioctl+0xc9e/0x1d10
 ? ptp_ioctl+0xcb7/0x1d10
 ? ptp_release+0x2b0/0x2b0
 ? lockdep_hardirqs_on_prepare+0x410/0x410
 ? lock_sync+0x190/0x190
 ? find_held_lock+0x2d/0x110
 ? ptp_release+0x2b0/0x2b0
 posix_clock_ioctl+0xf8/0x160
...

It can be confirmed that after the execution of "read (3, 0x20000080, 90)",
ptp_release() will be called to release the queue and set
pccontext->private_clkdata = NULL at the same time, this is unreasonable and
incorrect. The queue is not the memory requested in ptp_read() and should not
be released in ptp_read().

Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 drivers/ptp/ptp_chardev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..27c1ef493617 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -585,7 +585,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }
-- 
2.25.1


