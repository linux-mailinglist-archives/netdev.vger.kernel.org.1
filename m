Return-Path: <netdev+bounces-103419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE457907F60
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 01:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2F21C21C13
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A2914D703;
	Thu, 13 Jun 2024 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PeKjkMi8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3595A4FD
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321501; cv=none; b=si11gmdlgFiGIIy7rYC418WMXhiUjOQT2jb7i46ZUfp5xFzWOmUKIEl0M96rvtVpHAOrlPHw0DvWf82cJerDiMYDS0JFhMKqlSOnaUlFUMErreIbFhmB1W5USpaXIVQFUz3krX2hjF1mp7s/eB/EDlp70aWKe2szZakBxDLNjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321501; c=relaxed/simple;
	bh=AdNGi+LK0rX5IUgc2A6PALIQgu+yELfzJ/JCxqgPh3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C0dmSbUklmLxjHoZcf4ehHlzChKP3Z+/PhQKP5Flnsc0oT69C6ileCQiR+PqF1DpD17S3UHGOu47Hz/H/UoghMeTuTr00wkenbL7jz6sy2K+ae05aQfLIixhWQWFkFuPggQrOg+lS0ZBmSruaEKvwMKrqAw3hxir3L96n29KqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PeKjkMi8; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f97a4c4588so916571a34.2
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 16:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718321497; x=1718926297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=511gCyhpZyIEe0OPu5CoheLj1+D88dWRbWR4h5Ws6DE=;
        b=PeKjkMi8wuQ8pDhuXr+z16KoJONBRNZ9a1tMaPXnTQmxzhtGX72u65Pjzj5qmBEQ+s
         A0rK7OxV6AudiT4ykhHeeTKhPNKGwC3AKlvjhMW44ZYspaVH8tSxr5ulNQ70r550NoDQ
         nEf2dD7Q4A7BsprJsyCrnfycZMK2unK1+D1LYbFUVU8SiA3U6dvrc7G9K77ugPjqqA6f
         wEGd7dFuUD15X7qW/jQk6Qkbosf8sFp8REMPMZ2lz9UqFUVteRt4Y0li5+5lEfTlo5HV
         CMtw9waJJPo/LxpA8UPp8ePvSjiCmjQICyY7CgnOSygXVLlMhr3819n9qRDzFFvlo/BM
         tPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321497; x=1718926297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=511gCyhpZyIEe0OPu5CoheLj1+D88dWRbWR4h5Ws6DE=;
        b=hcCnhd6r6ZI/c1/YF9ER9iDJfIDu0Ej2gK1YZS1/QqV5tB8lgon7c1Vv9sGcxL/jxR
         pU2oaAOHWWUN3mtK4e+6HqNKcaB113a8jU7B2QrAwi1uNOD3rjxd3g56q0P19az11LHG
         kZSfEvwug+ftvujNyFa8c9M98MyDMvjpde3uaEosTMceEKzEzK/grGw6irfYrIyP/i4O
         pHM+z5PhfVJxNZkRzSWUeGMgBvgbFZh/XT6krSuACr8C7Hmnlim4FeSrP5UZRNi3Fj0I
         fk9XvITamL+ziGZDQD+qRi5Y3P8qHjt4WWfY11rL2+Vxx2daT4x3D3pA7cAab/ArCR22
         BSCw==
X-Gm-Message-State: AOJu0YwmPomG7K+nlZ0ktsc4fXZYQbZkPIIVncZRq62YYxFIyCTgZtlt
	MhbPP6J6MDfMgyFS/i705l+KjQiYxBwTV1akH3nUjvz2cX9EolxYU/lPon15IB3ZdHat4Offuit
	f
X-Google-Smtp-Source: AGHT+IEcKVHRItY9QV6yKaYxi8ZCrt1yukIBotYvWjdtM2BB/tKPzfv7+sz6zeEeCXhD2W7+GHFlhQ==
X-Received: by 2002:a9d:5914:0:b0:6f9:c46e:af75 with SMTP id 46e09a7af769-6fb9375efdamr1245271a34.11.1718321497195;
        Thu, 13 Jun 2024 16:31:37 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef3d8b62sm10586731cf.11.2024.06.13.16.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 16:31:36 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v5 0/4] net: A lightweight zero-copy notification
Date: Thu, 13 Jun 2024 23:31:29 +0000
Message-Id: <20240613233133.2463193-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Original title is "net: socket sendmsg MSG_ZEROCOPY_UARG".

Original notification mechanism needs poll + recvmmsg which is not
easy for applcations to accommodate. And, it also incurs unignorable
overhead including extra system calls and usage of socket optmem.

While making maximum reuse of the existing MSG_ZEROCOPY related code,
this patch set introduces a new zerocopy socket notification mechanism.
Users of sendmsg pass a control message as a placeholder for the incoming
notifications. Upon returning, kernel embeds notifications directly into
user arguments passed in. By doing so, we can significantly reduce the
complexity and overhead for managing notifications. In an ideal pattern,
the user will keep calling sendmsg with SCM_ZC_NOTIFICATION msg_control,
and the notification will be delivered as soon as possible.

Users need to pass in a user space address pointing to an array of struct
zc_info_elem, and the cmsg_len should be the memory size of the array
instead of the size of the pointer itself.

As Willem commented,

> The main design issue with this series is this indirection, rather
> than passing the array of notifications as cmsg.

> This trick circumvents having to deal with compat issues and having to
> figure out copy_to_user in ____sys_sendmsg (as msg_control is an
> in-kernel copy).

> This is quite hacky, from an API design PoV.

> As is passing a pointer, but expecting msg_controllen to hold the
> length not of the pointer, but of the pointed to user buffer.

> I had also hoped for more significant savings. Especially with the
> higher syscall overhead due to meltdown and spectre mitigations vs
> when MSG_ZEROCOPY was introduced and I last tried this optimization.

We solve it by supporting put_cmsg to userspace in TX path in v5.

Changelog:
  v1 -> v2:
    - Reuse errormsg queue in the new notification mechanism,
      users can actually use these two mechanisms in hybrid way
      if they want to do so.
    - Update case SCM_ZC_NOTIFICATION in __sock_cmsg_send
      1. Regardless of 32-bit, 64-bit program, we will always handle
      u64 type user address.
      2. The size of data to copy_to_user is precisely calculated
      in case of kernel stack leak.
    - fix (kbuild-bot)
      1. Add SCM_ZC_NOTIFICATION to arch-specific header files.
      2. header file types.h in include/uapi/linux/socket.h

  v2 -> v3:
    - 1. Users can now pass in the address of the zc_info_elem directly
      with appropriate cmsg_len instead of the ugly user interface. Plus,
      the handler is now compatible with MSG_CMSG_COMPAT and 32-bit
      pointer.
    - 2. Suggested by Willem, another strategy of getting zc info is
      briefly taking the lock of sk_error_queue and move to a private
      list, like net_rx_action. I thought sk_error_queue is protected by
      sock_lock, so that it's impossible for the handling of zc info and
      users recvmsg from the sk_error_queue at the same time.
      However, sk_error_queue is protected by its own lock. I am afraid
      that during the time it is handling the private list, users may
      fail to get other error messages in the queue via recvmsg. Thus,
      I don't implement the splice logic in this version. Any comments?

  v3 -> v4:
    - 1. Change SOCK_ZC_INFO_MAX to 64 to avoid large stack frame size.
    - 2. Fix minor typos.
    - 3. Change cfg_zerocopy from int to enum in msg_zerocopy.c

  v4 -> v5:
    - 1. Passing user address directly to kernel raises concerns about
    ABI. In this version, we support put_cmsg to userspace in TX path
    to solve this problem.

* Performance

I extend the selftests/msg_zerocopy.c to accommodate the new mechanism,
test result is as follows,

cfg_notification_limit = 1, in this case the original method approximately
aligns with the semantics of new one. In this case, the new flag has
around 13% cpu savings in TCP and 18% cpu savings in UDP.

+---------------------+---------+---------+---------+---------+
| Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+---------------------+---------+---------+---------+---------+
| ZCopy (MB)          | 5147    | 4885    | 7489    | 7854    |
+---------------------+---------+---------+---------+---------+
| New ZCopy (MB)      | 5859    | 5505    | 9053    | 9236    |
+---------------------+---------+---------+---------+---------+
| New ZCopy / ZCopy   | 113.83% | 112.69% | 120.88% | 117.59% |
+---------------------+---------+---------+---------+---------+


cfg_notification_limit = 32, the new mechanism performs 8% better in TCP.
For UDP, no obvious performance gain is observed and sometimes may lead
to degradation. Thus, if users don't need to retrieve the notification
ASAP in UDP, the original mechanism is preferred.

+---------------------+---------+---------+---------+---------+
| Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+---------------------+---------+---------+---------+---------+
| ZCopy (MB)          | 6272    | 6138    | 12138   | 10055   |
+---------------------+---------+---------+---------+---------+
| New ZCopy (MB)      | 6774    | 6620    | 11504   | 10355   |
+---------------------+---------+---------+---------+---------+
| New ZCopy / ZCopy   | 108.00% | 107.85% | 94.78%  | 102.98% |
+---------------------+---------+---------+---------+---------+

Zijian Zhang (4):
  selftests: fix OOM problem in msg_zerocopy selftest
  sock: support put_cmsg to userspace in TX path
  sock: add MSG_ZEROCOPY notification mechanism based on msg_control
  selftests: add MSG_ZEROCOPY msg_control notification test

 arch/alpha/include/uapi/asm/socket.h        |   2 +
 arch/mips/include/uapi/asm/socket.h         |   2 +
 arch/parisc/include/uapi/asm/socket.h       |   2 +
 arch/sparc/include/uapi/asm/socket.h        |   2 +
 include/linux/socket.h                      |   4 +
 include/net/sock.h                          |   2 +-
 include/uapi/asm-generic/socket.h           |   2 +
 include/uapi/linux/socket.h                 |  10 ++
 net/compat.c                                |  33 ++++--
 net/core/scm.c                              |  42 +++++--
 net/core/sock.c                             |  63 ++++++++++-
 net/ipv4/ip_sockglue.c                      |   2 +-
 net/ipv6/datagram.c                         |   2 +-
 net/socket.c                                |   2 +
 tools/testing/selftests/net/msg_zerocopy.c  | 117 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 16 files changed, 258 insertions(+), 30 deletions(-)

-- 
2.20.1


