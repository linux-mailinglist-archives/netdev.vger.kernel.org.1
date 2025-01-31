Return-Path: <netdev+bounces-161766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C682A23C51
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 11:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB7D1662CC
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 10:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33071B2190;
	Fri, 31 Jan 2025 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eF4zJSAa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F1169397
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738319858; cv=none; b=D9dWQhX1uU0EXAz0/srUWkG4GVmYrvfe+NnvyK+PJdYU7AzstWeQF8aC3ytytLEcUJjdo7opKi8d41rKofkfhdA/1AGrSC3ctl7W/stau4mhNzmo+X7vJ1gAIU4MuWr4EkxizuHMCC+jddlCjMHp4uMeVbBKppJne8/KiMEt2Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738319858; c=relaxed/simple;
	bh=msHXue7LsHGxaTn5pYiK/W/ChF7omJg1+nGnQMsxicI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VsUE5ZMf5dHaMO6k/X+NhXwBK2CfwBDfS7tWwME30tEPYr5UmSJuWfbxigsRTlH8rLYwTC91uUBrxaUq4ywNZnJJOHvTAgxEPo6xpKZV06DEW8wP2wl8rr+dldYOsGgezMLk89o8/xIr/Re7BsBCcSgafR0wv2VB+z7dkdd2HMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eF4zJSAa; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8622c3be2f4so538082241.1
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 02:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738319856; x=1738924656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NL8rEb8TLQ4Gyxf38D1JzjLnEVApUa4l/COEM6vDqGg=;
        b=eF4zJSAaGipwpu9DdjTsYbrtQ25PLQfkHSG0WXuq2UmIntKnDz95h6CDZ9sN1sPTj8
         gd12x2xvCQdIo31O+rLWNHmNbhrHbF27NUky8+2uS6qEJLKXdujDQRbQiAC+zlfXAjUs
         4CaUaYWGdNhDGq4jZAGuXFd0yYehkV4wzh7q2HXo+z5NCQ9jOsNGO2kCm0+zAOoyapCP
         wnKd2VdQd7KqQ5DO3Othgj6WdC9B78jkP8c6Ft6c4SLuvBow5GbdR4FYB0Jf7RRVRLLi
         3uNykSktAXPufCkyZpg62oAa5JqWFDLTpMSK3fHp80x3A81S7XnRaEGO++oQA+laohle
         JtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738319856; x=1738924656;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NL8rEb8TLQ4Gyxf38D1JzjLnEVApUa4l/COEM6vDqGg=;
        b=CD7yfTHWq9L6eOW3zysOfiMZGVeqtmXL6Od15XTbAHApqv4m6oVy4fqsDMf15rBi6V
         srGsc93IFLkALc+Nssa4ZAOtHJKy6V7BBxj7B2UtSXWGkdDAwknEyFUHJTfiRCn18mEF
         tPKQYxLMdbwugfqaEImLKZqTv6LlqLDq5ypAiOwT6cdC8dufmppLWlaF0DEfsCKvggPc
         KUEomAXfo+qUsAgVPoBFZXbBocOmq27TXFITqW0JTaC/AaZAoJxoEmpEcOV85Vkm3p4f
         cu+Rjzas+LoCdRjrIDXn+b7eXS5xsniCxZzDSBvVlhv2hcJaSsHC4v7cjwaAhmP929lm
         WB4g==
X-Forwarded-Encrypted: i=1; AJvYcCXecbCFWXgm2yN/lwhm9Cn4Y2SkSyzj+j77asDWxAE1e5cQCVOBGSr7iwek1h4oF0B0laIy5KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHu3h8vqEmDrNWnP3FhSewhcg14OEIGAp5EEwnDQDzD17DLESD
	C/atk5lSATfIsoxtZDHmka+3RugbW1TnzJEjsFD0ZeUKsphkKtIhUdL3lVvijbvSyi2pSZGjmcd
	wLnjCoE5nRxBTprT2Y2uQnga5Tw/t3LFlN95u2w==
X-Gm-Gg: ASbGncsdEr5tneLqFmXIkJt7j1ZSLTagqZyqujB0fjmyrMGYg1bAuxjEYC51vZarMVf
	P4Dcq/cRAIT5KyS+FWfUypM4kUsD+5UXBV3jsCpiAhDRERIcD7bYveM+XSJvaVnYxvyY5KFhCkg
	==
X-Google-Smtp-Source: AGHT+IFUKgwJUUPWZCms/ASmcU/ClUD9GXhapxiyufUZS6lTDvxg1H4P9dPBBgmdz5SOw3Z5b7ARbULwquhr5OcQzXo=
X-Received: by 2002:a05:6102:1495:b0:4b6:3d72:5c28 with SMTP id
 ada2fe7eead31-4b9a5221a27mr9064788137.18.1738319855799; Fri, 31 Jan 2025
 02:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 31 Jan 2025 16:07:24 +0530
X-Gm-Features: AWEUYZmUJ2DXNgZLfJYjNT9yTpkfESWbueiq-lGs1komIRRCaOtrb3XVYH9OZ8c
Message-ID: <CA+G9fYtqv_S+nK2cZB623yUuQS7HL18ELARpq_6W3_5m9ci7zA@mail.gmail.com>
Subject: next-20250129: rk3399-rock-pi-4b NFS mount and boot failed
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Netdev <netdev@vger.kernel.org>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Yanteng Si <si.yanteng@linux.dev>, 
	Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Theodore Grey <theodore.grey@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The arm64 rk3399-rock-pi-4b boot failed on Linux next-20250129
while mounting rootfs via NFS. Whereas other arm64 devices boot fine.

rk3399-rock-pi-4b:
  boot:
    * gcc-13-lkftconfig

First seen on the the Linux next-20250129..next-20250130
Good: next-20250128
Bad: next-20250129

Theodore Grey bisected this to,
first bad commit:
  [8865d22656b442b8d0fb019e6acb2292b99a9c3c]
  net: stmmac: Specify hardware capability value when FIFO size isn't specified

Anyone have noticed this boot problem on rk3399-rock-pi-4b running the
Linux next-20250129 and next-20250130 kernel.

Boot regression: arm64 rk3399-rock-pi-4b nfs mount and boot failed
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
----
[    0.000000] Linux version 6.13.0-next-20250129 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0, GNU ld (GNU Binutils
for Debian) 2.43.50.20241215) #1 SMP PREEMPT @1738124074
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: Radxa ROCK Pi 4B
...
[  111.599122] VFS: Unable to mount root fs via NFS.
[  111.599909] devtmpfs: mounted
[  111.625869] Freeing unused kernel memory: 4800K
[  111.626817] Run /sbin/init as init process
[  111.627364] Run /etc/init as init process
[  111.627858] Run /bin/init as init process
[  111.628350] Run /bin/sh as init process
[  111.628828] Kernel panic - not syncing: No working init found.  Try
passing init= option to kernel. See Linux
Documentation/admin-guide/init.rst for guidance.
[  111.630076] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
6.13.0-next-20250129 #1
[  111.630769] Hardware name: Radxa ROCK Pi 4B (DT)
[  111.631185] Call trace:
[  111.631411]  show_stack+0x20/0x38 (C)
[  111.631761]  dump_stack_lvl+0x34/0xd0
[  111.632110]  dump_stack+0x18/0x28
[  111.632428]  panic+0x3b8/0x420
[  111.632716]  kernel_init+0x1ac/0x1f0
[  111.633052]  ret_from_fork+0x10/0x20
[  111.633395] SMP: stopping secondary CPUs
[  111.633894] Kernel Offset: disabled
[  111.634209] CPU features: 0x100,0000002c,00800000,8200421b
[  111.634701] Memory Limit: none
[  111.634985] ---[ end Kernel panic - not syncing: No working init
found.  Try passing init= option to kernel. See Linux
Documentation/admin-guide/init.rst for guidance. ]---


metadata:
---
kernel: 6.13.0
git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git_sha: da7e6047a6264af16d2cb82bed9b6caa33eaf56a
git_describe: next-20250129
test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250129
boot log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250129/testrun/27058414/suite/boot/test/gcc-13-lkftconfig-no-kselftest-frag/log
details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250129/testrun/27058414/suite/boot/test/gcc-13-lkftconfig-no-kselftest-frag/details/
history: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250129/testrun/27058414/suite/boot/test/gcc-13-lkftconfig-no-kselftest-frag/history/
test job link: https://lkft.validation.linaro.org/scheduler/job/8100579

--
Linaro LKFT
https://lkft.linaro.org

