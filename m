Return-Path: <netdev+bounces-107046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7B491984A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 21:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813CC28648A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD4C191499;
	Wed, 26 Jun 2024 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EVx67zKm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F247191494
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430450; cv=none; b=kE+f4TotjrFlsq0yWjCnLnOUHQZLMJz8K7HKuRvsvVejqP8f9dz2PSxh8h1ri5EvdHQ50D7y7FEdZy68WmsSL/8dfoCDjUGgqfqO1Frq6CXdkS4ALKqVurLqp8sNPlK7eXVtXoc1VZHR/0dneksZdMVZKDoAJjDLSP5z3HvHi58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430450; c=relaxed/simple;
	bh=xPfiMz07qWYnBiF58enTksfP0Erl71BxT+rRX73m+Ow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iG3zwul3wH7qiFWj4HjcxujTxueyJFUAtmA+ypXEYzsFiUREvFskaKS0SsJ4z9PLst8RXqwa1X7S8rHZWnjYfBVosDVHXGt62EbEGRPT1ax1m/CpEiaPsLzynES0MwNWyP1QR6iSsaMEYtm7FbRPaH0nfN7K8Uo2PeUMcX/VcdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EVx67zKm; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b2c6291038so7611256d6.0
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719430447; x=1720035247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqd0diP3KmDjnQ8ONVE7Ezzjj4gz8tYSpplCMRypKAw=;
        b=EVx67zKmSzVs4OTAIMSBRj3NuMcG6iqg24PIaXh5LnsT4wYNljg5J5wJLJ/n89VjQt
         XUsDFDjsFp+Axhv/zmpSPeAcDF1SeoWbj8tupr9XmTcYEgOQMKymzk1KA31l9sB3KgW9
         WiSo2eUZyIECK+IkJ9V1eEQG+4r6wS4yVjBjbBdGrRMv5MXQjvt32b4R/hBKrR69Vmrx
         OX0cA/4kVq2r5WreU9CM60PMCADGtZcH3hGMk6IoPbVxCvyhaiS/X3Ni6b9mzyAVyJf4
         HDthxKh406VYQuZzNv77KrN6kkbL1NLM0HxvVfnrG3pkT/4A4XyK529xGDNQS0y32Tfu
         nyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719430447; x=1720035247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wqd0diP3KmDjnQ8ONVE7Ezzjj4gz8tYSpplCMRypKAw=;
        b=h/yO5GjeWb/aLjZ+j3A/iEal6ZGxnP9ksDPQQBXOEZBjREmEF8e5W0erKPm2wu7r/X
         EFuSnDxzgg+tS36AUUV28c+fsuIW/6jAlaK02x7rWeXo14GEsY5LSEwKfMGcYAI/gLzD
         Z+Aw6plGw3Sc1aNB8CONXMYAa7g5DIOEjjO/tAnL+qRc+DSUtdTCXSkMIiiGNinAzLIo
         dOCubs0uUUa+PgfjYMP57m92CZSHJaTZ+XpeSjP1hBDbuMz/MsdCJk/jJjkouBCnCIP1
         ntE1je8qtFyJyDHBYLBukJgY1pvTi9Pg04uRSJ0aBZ2dfWU+HNmN+lr5IBlWwEQLFP6m
         47Tw==
X-Gm-Message-State: AOJu0YxTu2Qr9gAzWovOtAQ7bXtFTrZRvGSLCal5hQwzZvEoOX0bWhIw
	ucPPkKPVxUoGhK6HYZQ4/oEWpscuLnqUozw8J3raUjV7UhMXTCSlyRQAK/SQv+GS3cpNmMrEDOx
	9
X-Google-Smtp-Source: AGHT+IEhB3diDotFgCQcCDpmg+wArUDVdGO81YMMfGfRv7pRoA9SM9b/3Oet4FF8HM2V8dAM9yRCTA==
X-Received: by 2002:ad4:4ee7:0:b0:6b5:2aa3:3a7f with SMTP id 6a1803df08f44-6b53223157dmr189506986d6.20.1719430446653;
        Wed, 26 Jun 2024 12:34:06 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b53df48dedsm40112286d6.67.2024.06.26.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:34:06 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v6 0/4] net: A lightweight zero-copy notification
Date: Wed, 26 Jun 2024 19:33:59 +0000
Message-Id: <20240626193403.3854451-1-zijianzhang@bytedance.com>
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

  v5 -> v6:
    - 1. Cleanly copy cmsg to user upon returning of ___sys_sendmsg

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
  sock: support copy cmsg to userspace in TX path
  sock: add MSG_ZEROCOPY notification mechanism based on msg_control
  selftests: add MSG_ZEROCOPY msg_control notification test

 arch/alpha/include/uapi/asm/socket.h        |   2 +
 arch/mips/include/uapi/asm/socket.h         |   2 +
 arch/parisc/include/uapi/asm/socket.h       |   2 +
 arch/sparc/include/uapi/asm/socket.h        |   2 +
 include/linux/socket.h                      |   6 +
 include/uapi/asm-generic/socket.h           |   2 +
 include/uapi/linux/socket.h                 |  10 ++
 net/core/sock.c                             |  44 ++++++++
 net/ipv4/ip_sockglue.c                      |   2 +
 net/ipv6/datagram.c                         |   3 +
 net/socket.c                                |  45 ++++++++
 tools/testing/selftests/net/msg_zerocopy.c  | 117 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 13 files changed, 231 insertions(+), 7 deletions(-)

-- 
2.20.1


