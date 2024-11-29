Return-Path: <netdev+bounces-147864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3635A9DE808
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 14:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912D4B209BC
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB31F199230;
	Fri, 29 Nov 2024 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJmALu1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0303419D89E
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732888270; cv=none; b=sBtkPuFpEvkfRtj5TmKUwrndq9XrjCtqpKCyZpmKsCVrsjuNr78Af5y2+ps7LcOLtFB+qxG2pfPbEm41bY1LDRlqNbCTCQ3rajNUEv8pd9kOdVcYUFWZG6LReyMX7lb85aqRZvzUoMiJ41qggLreGEykIj2YwJWHB9YYNt64x6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732888270; c=relaxed/simple;
	bh=2b6xdyCnvxyhFYFOPGQI6R1wTiMUE+yrgdP5lFX0vIc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GZB/b7GXQKLSAzLErD5qGD7OkDz7/+wLcsOoTfcetrqIo9Jm3gdrUzo0FeMQ4jmMqNYtZuVdh1g5aV5GOZhRwmUCHAjUMLPtxgGjCT7Tp3CT5bO/VQ45+ew+8GjA5tnFxV8N/OVI3oNIOtAiCSoICmbg9P2JcRPL1Lx3iOOYu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJmALu1m; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53de92be287so3028756e87.1
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 05:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732888266; x=1733493066; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZxElhSLP2C49FX+vtpR5dfeNlafJWEhAmqY/zmBrrl8=;
        b=XJmALu1mxYgNUTVjxwN6WiMe5sF3b7kDtuLXbCcnzdpsVlXrs4b1K3JNFpz4yzbi6s
         adO8Uy++GPIIiyYKnYYIHw9iRzP++mUeVF6KDRlrdvqarJwKUWjslK1tgjv6Y2kQHoc9
         LqSCtg9+Pmyi3vNAh4szojPDulgMPn1eA4GhdeanANJ+n9CT79qX9r28X6boCFMU6Co6
         b3YJEj1pPONRMF5HTRydpgmzax+nxnyRfvAiue/RLQgqRNTPrbFrgGzyt/CW+HUEaeCU
         +c6Q7QNuzuXAYaFC9J5mhwlhlPG8smV1eZx+BWBsCfTcsJoQW2oT9zNNgHy63BtYwECW
         wMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732888266; x=1733493066;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZxElhSLP2C49FX+vtpR5dfeNlafJWEhAmqY/zmBrrl8=;
        b=wwGk9q59bYt4CtQkM7URSCXdqz+8impsANrhbLR45hgDbtIsa2SS37ihcRqZozCYvt
         SS3vVO+3/+8plOiEqTkHjzQzqNPd5bXx8DHkrlgM4ySM5/Mh6jaKTB8BSm1oUq1WktvF
         4wUzqsz3bHCcJj/EajmUfXWjmHj400nJ8ZudR2rPCiDXaMUEIIMpYlfPACU/aD65aLn6
         tDtz6plqaXFVgj3gs5J5Q924D0hYGd+pIM02JXQEbH1B16JlnwN8pmqHYbCazWjGr9j4
         lhlOhyA5VbM/tYiHNlTOuak8UU1p5Rb7rI7vAWuc6+xAoWrvXkNL9mTRz92dT5HN7BMK
         ogrg==
X-Gm-Message-State: AOJu0YxkZIADqdV6noGDYjpfY7VZzVPmO3fknN6mDKps6PXLjXZr0Ank
	F5XXGoAWNtFdG1zScuKGMoZj1Nj/sqLST80iKWMX40euAFpWkBmJcvYYdgXXBADff9zdnJJ/Zzx
	2Dlc9welx8FUCBslo8laqREZiRij04BV2
X-Gm-Gg: ASbGncsK/1X7DoEegMVlLmBcB1VcqtkPDfov0PUi4JlXPI+JXESuNtOz6UiDpNGo5cC
	2DjbmyN4jwcvXHH2Fcth5wEklI9z5KCpR
X-Google-Smtp-Source: AGHT+IGuQSXUqI9t7e0wL02I0pgCKH4XHwSAQR29CCUZyuUtaPBOoFdFgQ6MYTT13ubxJNs3AshHoICHhjAXiknBjqg=
X-Received: by 2002:a05:6512:3e1a:b0:53d:dbc7:981 with SMTP id
 2adb3069b0e04-53df00d030dmr10428982e87.16.1732888266304; Fri, 29 Nov 2024
 05:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 29 Nov 2024 14:50:54 +0100
Message-ID: <CA+=Fv5Tf=3HLhkDqRoxSgp0p6kpn7F62qiRXOXMSyR2KzQNUDQ@mail.gmail.com>
Subject: kernel Oops: net-next-6.9 breaks stuff on Alpha?
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,



First some background:
I've been trying to boot recent kernels on my alpha machines. Anything
after linux-6.8.12 gives me trouble. After doing a kernel bisect, I
found that commit 9187210eee7d87eea37b45ea93454a88681894a4
(net-next-6.9) is where my troubles begin. The problem consist in that
the boot process gets stuck when trying to set parameters for network
interfaces. The bad commit does make a lot of updates to the network
code.

When booting the system with kernel 6.12.0 I'm able to boot into
single-user mode, but when starting system services one by one I
trigger a kernel Oops when the network interface is renamed (see stack
dump below). Looking at the changes made by the bad commit, it seems
to (among other things) be replacing the locking mechanism (RCU
instead of rtnl_lock). The stack dump from the kernel Oops suggests
that something is happening in the RCU locking code. I'm no expert on
RCU-stuff but I read somewhere that its done by volatile access on all
systems other than DEC Alpha, where a memory barrier instruction is
required. This indicates that the change could affect Alpha
architecture differently? Inspecting the changes to networking code in
the bad commit, particularly the changes made to net/core/dev.c, I put
together the patch below. This patch reverts one on the lines changed
in the "bad commit" for net/core/dev.c. After reverting the change on
just this line, I'm able to boot kernel 6.12.0 on my Alpha ES-40 to
full multi-user again. I've tested this on an Alpha ES40 and an
UP2000+ and the problem is 100% reproducible on both systems. The
patch might not be a real solution to the problem but could be a good
place to start looking when figuring out whats really going on.
Not sure what is the next step here, it would be interesting to hear
if anyone else has seen this or is able to reproduce it?

Regards
Magnus Lindholm

---------------------------
Patch to "fix" the problem:
---------------------------

diff --git a/net/core/dev.c b/net/core/dev.c
index 13d00fc10f55..26fda14367e5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1261,7 +1261,7 @@ int dev_change_name(struct net_device *dev,
const char *newname)

        netdev_name_node_del(dev->name_node);

-       synchronize_net();
+       synchronize_rcu();

        netdev_name_node_add(net, dev->name_node);


-----------------
dmesg/kernel log:
-----------------

[   93.431592] tulip 0000:01:02.0 enp1s2: renamed from eth0

[   93.436475] Unable to handle kernel paging request at virtual
address 0000000000000000
[   93.436475] CPU 1
[   93.436475] rcu_exp_gp_kthr(17): Oops -1
[   93.436475] pc = [<0000000000000000>]  ra = [<0000000000000000>]
ps = 0000    Not tainted
[   93.436475] pc is at 0x0
[   93.436475] ra is at 0x0
[   93.436475] v0 = 0000000000000007  t0 = fffffc0000e62440  t1 =
0000000000000001
[   93.436475] t2 = 0000000000000000  t3 = 0000000000000001  t4 =
0000000000000001
[   93.436475] t5 = 0000000000000001  t6 = 0000000000000001  t7 =
fffffc0003138000
[   93.436475] s0 = fffffc0000e62440  s1 = fffffc0000ec3a10  s2 =
fffffc0000ec3a10
[   93.436475] s3 = fffffc0000ec3a10  s4 = fffffc00003a90f0  s5 =
fffffc0000e62440
[   93.436475] s6 = 0000000000000000
[   93.436475] a0 = 0000000000000000  a1 = 0000000000000000  a2 =
0000000000000000
[   93.436475] a3 = 0000000000000000  a4 = 0000000000000001  a5 =
fffffc0000517744
[   93.436475] t8 = 0000000000000001  t9 = 0000000000000001  t10=
fffffc0000e3d320
[   93.436475] t11= fffffc0000220240  pv = fffffc0000b73210  at =
0000000000000000
[   93.436475] gp = fffffc0000eb3a10  sp = 00000000ea2ea184
[   93.436475] Disabling lock debugging due to kernel taint
[   93.436475] Trace:
[   93.436475] [<fffffc00003aee60>] wait_rcu_exp_gp+0x30/0xa0
[   93.436475] [<fffffc0000b6c200>] __cond_resched+0x30/0x90
[   93.436475] [<fffffc00003569b8>] kthread_worker_fn+0xc8/0x1f0
[   93.436475] [<fffffc000035863c>] kthread+0x17c/0x1c0
[   93.436475] [<fffffc00003568f0>] kthread_worker_fn+0x0/0x1f0
[   93.436475] [<fffffc0000311128>] ret_from_kernel_thread+0x18/0x20

[   93.436475] Code:
[   93.436475]  00000000
[   93.436475]  00000000
[   93.436475]  00063301
[   93.436475]  0000077c
[   93.436475]  00001111
[   93.436475]  000022a2

