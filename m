Return-Path: <netdev+bounces-110013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B388092AAE1
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1712BB2189A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF21C14A08D;
	Mon,  8 Jul 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VMovxTl3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0114E2E2
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472775; cv=none; b=i+zK1I6trbMzKZNw1DiEushunKjFfbhlgLYPvudMjs+8bob02gQ9a3pHINd409vukI18jC2UYPnZ7T/85SerY+LSZ/H20EktqZozUgRwVcCRha37Qo/ltRVR1bklwWUqFRtjxmq2OA07VVqIih0AqCZTmLWr2E9/AZky5gJB+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472775; c=relaxed/simple;
	bh=WKQSkNlos++v6ilN3MZLl7UVAHDwyEwzYdwNd/LJeSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4IRpvUKNRdfHgXKxIh4HRYMWcrbneq9pAi2MKaSHVtkvcussXtcO746nhV5FSLfkO4hZdrg59IkVp80rBpXkwfSrnPmwl4PT27bU/YFXNFOCUsyjaqr+LXPJIRYrNC1QeUXvgnRajqyZCCIDqo5AgZCG2jhh7slfKoyY5jqc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VMovxTl3; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79efbc9328bso333430685a.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 14:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720472771; x=1721077571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZQMwCJgS8y+Lt9eNHTIINWcgFrJoWHswNZCv4eOnsE=;
        b=VMovxTl3Oz1osYSU49zzqI3PNBhYaMjpnaD5+/60XRA0fAIi1aXsQSkEqIuVTvFuyk
         1KHL3/oKyoe0CZikA2cG7OrDBgshvDA3fVgiqnpTj2Xwi+GIMY2LrNnlGNVCFqXM0RPR
         AkZkaWzafQZQfsRBeVkfibOhZFiKgx11GwPnFeh1FlnJj8hYAC5OG2sbJXqIUP3tbGDW
         bLdmCpwTV2QFkXRSejB4RPj14L975NW3kPoNRbQDIUjdz2tjfolJncx9HgYJ667I82Ea
         YBPZwS/aocM4FMNqvDd/WO0p/CENZuXrC/Bs9JSAvQk4/46kBRhjxN0ORZx0+b+sIH5o
         1hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720472771; x=1721077571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZQMwCJgS8y+Lt9eNHTIINWcgFrJoWHswNZCv4eOnsE=;
        b=ne9p3HY55XQKa5+ntlJBxtqPGANq/diXAIy9ElMI/gtBAHVWUc3d7XrVy9pakaWTpt
         RjoD0m5XGhUTALqipQQk+SZ5R6di/OasxdhpnK7m2oLs+sj3RQ/Ia1vH6LFG8N2XhfVd
         +LmngIsoQ4hDY9RwvRNpBVuRS/JS/rbGIpicpmR0xsk6gNMnYMZ0xMLnLA7gpyIGTwfq
         xvz0VzoH6JvJgOf9F/XrmNquP4177CrZDIklCjV7X+K91POqgW9pVkmGzNSA8zia8FjT
         t5QgVRem5W48s7mQJrdxV9olgOJKutUMskPYdtMenNWPrHjpPXuSCgAnxQz4qBGe6om3
         nqTA==
X-Gm-Message-State: AOJu0YzGLJIbNSRNVmmfFwf4ev1CFyI+fjoTR+aUQO0HvT+970i3K2N2
	fe2jfRFjVxnNi+gc1n56EBj7BA6TgT+7NaBUT7VHFLznSi0PBCe4ptLDeHTf+aR/r9NF5WNl2n/
	2
X-Google-Smtp-Source: AGHT+IHUhY4fDPMjejYIung90hitqhOfeHv5nywUZBw3aVKJIKAJlb0jvPRyjomF5PnAc9eolXvFiw==
X-Received: by 2002:a05:620a:4506:b0:79f:10e6:2de with SMTP id af79cd13be357-79f19a686c8mr72946785a.41.1720472771431;
        Mon, 08 Jul 2024 14:06:11 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff82a7sm28212185a.9.2024.07.08.14.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 14:06:11 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v7 0/3] net: A lightweight zero-copy notification
Date: Mon,  8 Jul 2024 21:04:02 +0000
Message-Id: <20240708210405.870930-1-zijianzhang@bytedance.com>
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
overhead including extra system calls.

While making maximum reuse of the existing MSG_ZEROCOPY related code,
this patch set introduces a new zerocopy socket notification mechanism.
Users of sendmsg pass a control message as a placeholder for the incoming
notifications. Upon returning, kernel embeds notifications directly into
user arguments passed in. By doing so, we can significantly reduce the
complexity and overhead for managing notifications.

We also have the logic related to copying cmsg to the userspace in sendmsg
generic for any possible uses cases in the future.

Initially, we expect users to pass the user address of the user array
as a data in cmsg, so that the kernel can copy_to_user to this address
directly.

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

We solve it by supporting put_cmsg to userspace in sendmsg path starting
from v5.

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

  v6 -> v7:
    - 1. Remove flag MSG_CMSG_COPY_TO_USER, use a member in msghdr instead
    - 2. Pass msg to __sock_cmsg_send.
    - 3. sendmsg_copy_cmsg_to_user should be put at the end of
    ____sys_sendmsg to make sure msg_sys->msg_control is a valid pointer.
    - 4. Add struct zc_info to contain the array of zc_info_elem, so that
    the kernel can update the zc_info->size. Another possible solution is
    updating the cmsg_len directly, but it will break for_each_cmsghdr.
    - 5. Update selftest to make cfg_notification_limit have the same
    semantics in both methods for better comparison.

* Performance

We update selftests/net/msg_zerocopy.c to accommodate the new mechanism,
cfg_notification_limit has the same semantics for both methods. Test
results are as follows, we update skb_orphan_frags_rx to the same as
skb_orphan_frags to support zerocopy in the localhost test.

cfg_notification_limit = 1, both method get notifications after 1 calling
of sendmsg. In this case, the new method has around 17% cpu savings in TCP
and 23% cpu savings in UDP.
+----------------------+---------+---------+---------+---------+
| Test Type / Protocol | TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+----------------------+---------+---------+---------+---------+
| ZCopy (MB)           | 7523    | 7706    | 7489    | 7304    |
+----------------------+---------+---------+---------+---------+
| New ZCopy (MB)       | 8834    | 8993    | 9053    | 9228    |
+----------------------+---------+---------+---------+---------+
| New ZCopy / ZCopy    | 117.42% | 116.70% | 120.88% | 126.34% |
+----------------------+---------+---------+---------+---------+

cfg_notification_limit = 32, both get notifications after 32 calling of
sendmsg, which means more chances to coalesce notifications, and less
overhead of poll + recvmsg for the original method. In this case, the new
method has around 7% cpu savings in TCP and slightly better cpu usage in
UDP. In the env of selftest, notifications of TCP are more likely to be
out of order than UDP, it's easier to coalesce more notifications in UDP.
The original method can get one notification with range of 32 in a recvmsg
most of the time. In TCP, most notifications' range is around 2, so the
original method needs around 16 recvmsgs to get notified in one round.
That's the reason for the "New ZCopy / ZCopy" diff in TCP and UDP here.
+----------------------+---------+---------+---------+---------+
| Test Type / Protocol | TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+----------------------+---------+---------+---------+---------+
| ZCopy (MB)           | 8842    | 8735    | 10072   | 9380    |
+----------------------+---------+---------+---------+---------+
| New ZCopy (MB)       | 9366    | 9477    | 10108   | 9385    |
+----------------------+---------+---------+---------+---------+
| New ZCopy / ZCopy    | 106.00% | 108.28% | 100.31% | 100.01% |
+----------------------+---------+---------+---------+---------+

In conclusion, when notification interval is small or notifications are
hard to be coalesced, the new mechanism is highly recommended. Otherwise,
the performance gain from the new mechanism is very limited.

Zijian Zhang (3):
  sock: support copying cmsgs to the user space in sendmsg
  sock: add MSG_ZEROCOPY notification mechanism based on msg_control
  selftests: add MSG_ZEROCOPY msg_control notification test

 arch/alpha/include/uapi/asm/socket.h        |   2 +
 arch/mips/include/uapi/asm/socket.h         |   2 +
 arch/parisc/include/uapi/asm/socket.h       |   2 +
 arch/sparc/include/uapi/asm/socket.h        |   2 +
 include/linux/socket.h                      |   6 ++
 include/net/sock.h                          |   2 +-
 include/uapi/asm-generic/socket.h           |   2 +
 include/uapi/linux/socket.h                 |  13 +++
 net/core/sock.c                             |  52 ++++++++-
 net/ipv4/ip_sockglue.c                      |   2 +-
 net/ipv6/datagram.c                         |   2 +-
 net/socket.c                                |  54 +++++++++-
 tools/testing/selftests/net/msg_zerocopy.c  | 111 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 14 files changed, 236 insertions(+), 17 deletions(-)

-- 
2.20.1


