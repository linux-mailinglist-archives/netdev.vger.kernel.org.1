Return-Path: <netdev+bounces-96164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E48C48B6
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99677286C58
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759DD824A3;
	Mon, 13 May 2024 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XCz2Fz8L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038DB1DA24
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635085; cv=none; b=cC3erlEGVJzDWWxQQSsqu/3L4VHzqwU1ZxY++Z+olEYoYyXZkVz9vRDMjOjOFaGwLp4cYRsz5VDknYEhcQQqRwbkU1L9e08icVyRW0uW6C6d8nxNetfLJK8ZvXoUFAuYOLlRFzTe3fAtY7hpxEU7V6AjFCTstj88kcgI3eubfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635085; c=relaxed/simple;
	bh=PdnqOeByj62n1jzT1mOCbl2AnUUAVWXzky16zV45pbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tfSU2bUxjgZTzz8A//aM9m//31/8nKc3rH0xWVdcXf59rhvs0klSoq+493BLFdO6BXSFU/r2VeB6j+z/lB9hr90gpKjAPbJhwFRzsSrudq2AL2SWWgajiEDeSE2iijjr0+lbSZtCUKWLP2nZWrrgUgv4a9G9df2IMFAtB8faQUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XCz2Fz8L; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43dff9da88fso23043431cf.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 14:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715635081; x=1716239881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJTy5ZtIvbOjQ1U7Y0w40QVea2EHxt2KLYcAMTHEJ9U=;
        b=XCz2Fz8LS4SS2WD0YVOX5F2WhdmkqrpHvXpPJ6oxliKR9U6zRCU0iLLPCIAvjSt4XV
         6+vguWC9AG54eIofDVvYZUe78gNZQvXeUim/WmCjaECM2s0I9SOlYHKhBYu6pPdFBZrp
         pfktxxFr+UnIc7g37p3t/ZoITmYu4/9MNpZhq+2GkO5UDh0akQoJL82MT9HMWz9/7e54
         er+26OvNnhGvzoJ/8nNcXM6DetBWtF0Fvcuv4Z6h2rRie0IB3IhQnFKY0sfarSYIZaQx
         Qv1jq9NEx1E4Y97WdR42L0+fzqkyIwhx+6AaMqPNk6U4k4/SZKM8usMGBQseVm6YZlxT
         uLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715635081; x=1716239881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJTy5ZtIvbOjQ1U7Y0w40QVea2EHxt2KLYcAMTHEJ9U=;
        b=lvfxqobHaTw+Tgrxo+t9eGwuiU/klcp+3hCVgJsxA99D95V+z+8wQhjHh0DYJOCr5o
         e27N008jiQCRuchUOnQb8VK+JiERVx6gl/VhWJchyV3oGuWLZKdRIjRggYQkHcEqLLVU
         cd0pNJWacvJv9qG6FwBlMT6QkdQVm7CfkQrdaGSxsXx1owvdX+4c1+v4wIhYT/PS4rAs
         U9hpj1xiKBcOp+kEayYV1AkeKgNtbjsVrz39wYjJrSoCEHOVqs5PgwnUWolgNkh7D00V
         8QayIoaBOtzmbDyc5oeibLdEYAn6eQJogxTPDM9ROOMhKtUoQATRzIPRsKPhOEkBGM2l
         /rPw==
X-Gm-Message-State: AOJu0YyPF6IQ68CMfM9TQA8yviIrY4KznJbRExzVXaUSxj8v1jNTGTdZ
	R+0mjgMhviDo6TXZlHY3mqIWWePCphoJsRVoEASc1ICeRE450fy0xW2bIDARZp/KAw6ZjVTZuec
	q
X-Google-Smtp-Source: AGHT+IFmLMqnR2KFz3Pd0+tA7iXsIrRC305gF0pmIzaxilT0aI+NbedFhdDuBK+BHi2svS2kxgPcGQ==
X-Received: by 2002:ac8:5e13:0:b0:43b:1472:167d with SMTP id d75a77b69052e-43dfdcd73b7mr133355261cf.51.1715635081319;
        Mon, 13 May 2024 14:18:01 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.94])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e184af783sm18340811cf.17.2024.05.13.14.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 14:18:00 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v4 0/3] net: A lightweight zero-copy notification
Date: Mon, 13 May 2024 21:17:52 +0000
Message-Id: <20240513211755.2751955-1-zijianzhang@bytedance.com>
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
 net/core/sock.c                             |  65 +++++++++++
 tools/testing/selftests/net/msg_zerocopy.c  | 116 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 9 files changed, 195 insertions(+), 7 deletions(-)

-- 
2.20.1


