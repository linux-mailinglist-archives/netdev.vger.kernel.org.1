Return-Path: <netdev+bounces-98772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B358D26FB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A583C1C25382
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B249717B432;
	Tue, 28 May 2024 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VBR/uly4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB3224D1
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716931292; cv=none; b=ScektYdIe2Tzrh+i1dq1eWsRrsZ+9WgbKOc0Q40r2LzMSsrzdpFa8qOktIvyNvTNEreSeQYZFBJ1CZDeI7EPOtG9b6Qdq7l0eASEbO1h0JlPoN/GiPQSbvMwXnFVWZDfpNqBl8hMZn8tWqkYf1OslwAgnTYEbj2suVq2sOxE2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716931292; c=relaxed/simple;
	bh=z3XzXoD5vuBfRH0S1jahDiNt0I2nzQ4ZzJKLWvEt6WI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z8qeQMnCbbT8ML3GXTcaRPCtDDYLv9DwTrS9XTjShRGmuxFJcz1nRxLsn8YZCm6Y+DZuV5srlgw0Je0OcPHNDnP3PgyRPzIv3t2lSEnnGZg8Jle7Gr3qrB8p/tZGWGugePWwnFZcRRkwrNJVoVlY2fSWvY/zBrNOMK7J3we0e2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VBR/uly4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-627ebbe7720so13346387b3.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1716931289; x=1717536089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yfz2MSFyMO1Y+AwSOTJia+NWQ1y2FCPRtkFyOLLlMmU=;
        b=VBR/uly4c+ZfwziBwnlhEiULngju2xo7omACSe6ePaV8VO2bEN5uhbUdMyyqT1KjGW
         ZNz+Ud3s1Oe2p1odm8e5qf1cYK0WEGhrnxZmIOCdA6HqNRca6QU1ExCUGS279S/FUpO7
         mNh8Z+yCLuXOarQovMmWbI1yEo2VKuO9P4+8VCtLmKylIFn6DdNFVn6Hc+qOrPdw2ptI
         tA8zWKAxcKwhg1BABdzphY9NDbnYydn9UjrRHU+EUvrvvOdrGMXyG+Xd0PKDkU+ZoQ2U
         C6RKExQzue4mPoAFa3RDOTm9iKNepiyiO2/1bt7Zpxvg0FWVy1LVqqEzkQcKkMerydWW
         5nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716931289; x=1717536089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yfz2MSFyMO1Y+AwSOTJia+NWQ1y2FCPRtkFyOLLlMmU=;
        b=MYxPVCZx5PSN7I8UB/7QivFdNUQ6lcRJibRjTyYGvMASpXf2Wv141Kcrsugl7FUzXn
         kJLzXyyniKjYPg3GX3/hC6d2CrfLsMfZQZRsxzHWnt/0mGSEvjWerqJV8rwFU0qjWwco
         ujCgfYy7A8/b8GkfWqLAGamXRn7QAY7L6t89y8S2MyC5Uwx1WRttdmKN16NWw1xIn+E+
         J5EPfSmE5sNAmeSnHvRDUIymS7B7oyhqbJccRmAonABwbtzM5513U8pja3fZw7BzQNdX
         eEiRDJM0pVOoGTyGpAr89DSi8uwAaZHSVaNxvrYD6rfaXOeUNS1nB2ku7+XUAs94Fm39
         xUng==
X-Gm-Message-State: AOJu0YzbxAyg2Kjb8d64ogu25ewqfl4D1PlgTzwM5aYRqWHgMxoR7y9h
	EvxW3AzLwQdCgNi43678mCDRhW7+xeooHGjsBpT7dzmvi+kinV7cjpK5xq7wumhCE2hC4vnusQB
	K
X-Google-Smtp-Source: AGHT+IHm7nQ8BLbvVGH7c8eYomTTgj1zgWe/GQ9gfLNGWPJ9UO8FNZSPQog5bKRasj5UuXmITh+J4w==
X-Received: by 2002:a81:431b:0:b0:627:96bd:b1d with SMTP id 00721157ae682-62a08db7105mr130424667b3.26.1716931289447;
        Tue, 28 May 2024 14:21:29 -0700 (PDT)
Received: from n191-036-066.byted.org ([147.160.184.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca80a7sm412619485a.17.2024.05.28.14.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 14:21:29 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v4 0/3] net: A lightweight zero-copy notification
Date: Tue, 28 May 2024 21:21:00 +0000
Message-Id: <20240528212103.350767-1-zijianzhang@bytedance.com>
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

Zijian Zhang (3):
  selftests: fix OOM problem in msg_zerocopy selftest
  sock: add MSG_ZEROCOPY notification mechanism based on msg_control
  selftests: add MSG_ZEROCOPY msg_control notification test

 arch/alpha/include/uapi/asm/socket.h        |   2 +
 arch/mips/include/uapi/asm/socket.h         |   2 +
 arch/parisc/include/uapi/asm/socket.h       |   2 +
 arch/sparc/include/uapi/asm/socket.h        |   2 +
 include/uapi/asm-generic/socket.h           |   2 +
 include/uapi/linux/socket.h                 |  10 ++
 net/core/sock.c                             |  68 ++++++++++++
 tools/testing/selftests/net/msg_zerocopy.c  | 114 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 9 files changed, 196 insertions(+), 7 deletions(-)

-- 
2.20.1


