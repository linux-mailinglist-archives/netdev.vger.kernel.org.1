Return-Path: <netdev+bounces-95530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756858C285B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1696B2512D
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AED172780;
	Fri, 10 May 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jekHuepH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2019171E62
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715356769; cv=none; b=RgvFeo9LAY+9782J+dtWtQMbxnZjQyO8UnD7B8g21kB5mx0WAChO2dYpVvXziT67G4b9dwj4kUl//895xvy9kBwT56B1N7PVDEhrf2LoTGX1LMnWJoI1SKDDXeVQGyYQGlg02RAXgkEEgcFSVYUWzEpE9Uau9CqruyG22X8x+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715356769; c=relaxed/simple;
	bh=+aKzoHtS4pG2VYfJ9tpzB+7W1U79lifhDkkzSZkFTfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NP+qypFQgj3ZQpMguX1IOXm0dKfKdpnqqUQW2a58xuzH0DeSlh4OPU4ZTC5r2PWzkXK9xb34fdTEw3pwhWH7yFFzsj8tnNHElRKgfVMao39I9RRDanxq5Calv4c+2L1dKFMrZDRZEwzbml8t43AxyTasoWMQfPD8OOdHQ2sy/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jekHuepH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43dff9b28f6so5659071cf.1
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 08:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715356765; x=1715961565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+X7VuBH3JZrEEOxWp6sHl0AA7i4Adn9SRsCT8gvZprs=;
        b=jekHuepHpnpZly6LcKGqp0uDt8UoA7dKnv0Ya4jN21ZlsiKmuEqhg7vorRlJ1j2Fgs
         Q2yzq7ywhRMdUFPHnakD+ludFXLBLC/RN9r4bfvHe9SsIUqIo83mKwj/YbpSQi4PBxwS
         e+XyT1dSyEQ/SWX3vz3//glm5r4pVVEefeAoime5mc8DVVxF8m+WVKe0rh3jK/DnHu3x
         xi9NkxHXPqkdq+9ixo6P+qGVhfwe7/qBgqoDTfSbyGknPeoZLpiqPTo5TGVHpJ6XWvy6
         jZ7+tTqLA2QIWQRerS5cIUoDJwbXz3XAp/TldnG8WPt8JJaXnCan11uwdzICNfitCt2J
         /MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715356765; x=1715961565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+X7VuBH3JZrEEOxWp6sHl0AA7i4Adn9SRsCT8gvZprs=;
        b=puPJpkSKyNJF5rFgvwAL/dI8/IyvYhvsygAmFtbyx/OwjBMvKJ7DvIcVzWVCG9dWr3
         V0J3PZ8qKTmswfAQE5nzpSiHwkiPt7x20qyMtldi/fByA8JBOkgNVO2jqoeW55UyEptP
         6rSMtzi3+LjGlNCIwBxwOJv//L+R1IIlve1SDXlaMrcGvgYWLiyzF/mGNe3O6Pg+Tz4A
         lCOZ2H5fweehMDzYqr3gofwOpAFQWrScKPiJeqdG8E78GW0cnnH4xv8YfVx+9TyJdD7D
         3whQOoiQXrn037Oc2uzIU8C0/vXUKUvIaLSi5JpTJ70t3srD3jxRI5t4jxTCRnpHus2D
         jPEw==
X-Gm-Message-State: AOJu0Yw2vpkPpo5Pjs99OsSLI6cMqTgydzTSe67xWIcD+MaWvc85cxxk
	Sx4kIuVRyFj//S1CLfOYJmwMsJ3KlQP82Yiiqb5tctky9rU+UBqPP+uFLCf4c9pJpAxf2rktRT8
	f
X-Google-Smtp-Source: AGHT+IHocxABAy0xL0kCXyg3L+8kGccXW4Bwe+kJyVJlPWrAH1UamHoAXKpuP5HXoQu5btvbNAMLYA==
X-Received: by 2002:a05:6214:4608:b0:6a1:6081:6879 with SMTP id 6a1803df08f44-6a160816a73mr111981446d6.17.1715356765093;
        Fri, 10 May 2024 08:59:25 -0700 (PDT)
Received: from n191-036-066.byted.org ([147.160.184.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf32e705sm191553285a.124.2024.05.10.08.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:59:24 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v3 0/3] net: A lightweight zero-copy notification
Date: Fri, 10 May 2024 15:58:57 +0000
Message-Id: <20240510155900.1825946-1-zijianzhang@bytedance.com>
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
overhead including extra system calls and usage of optmem.

While making maximum reuse of the existing MSG_ZEROCOPY related code,
this patch set introduces a new zerocopy socket notification mechanism.
Users of sendmsg pass a control message as a placeholder for the incoming
notifications. Upon returning, kernel embeds notifications directly into
user arguments passed in. By doing so, we can significantly reduce the
complexity and overhead for managing notifications. In an ideal pattern,
the user will keep calling sendmsg with SCM_ZC_NOTIFICATION msg_control,
and the notification will be delivered as soon as possible.

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


