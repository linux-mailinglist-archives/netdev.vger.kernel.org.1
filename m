Return-Path: <netdev+bounces-89750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6CB8AB69F
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 23:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36A21C21BB0
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 21:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E448313D248;
	Fri, 19 Apr 2024 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OjRjDxx9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A813D249
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563309; cv=none; b=QqR0J6X35+jxI9bsARyHj3IM+hfp4zisKiYU+Cu5GjsbfImU62qFH/mtTo2Mc60rXiq+ki8TSPaxnGW+VayqRqB5gptmj8U7LhgUkLM29Wt0p9yZmBOPMb5PI+kMgUiazI2tkKixSD1B/M4nCNn70pmf6LI3/k8c1HgBfPBsgt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563309; c=relaxed/simple;
	bh=5Vag1zgbosahQOxSLa1mqpC7CFIQB/xqh0zY0fGN6T8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lk/K51rH3Dd+sGConWh+pnRDhhC+/uuv1XECVFUqB/Ps6ezYRzfdNGXROV+T5rtB7iSCB325b+/QHVCA98q8hkyvqgeRvVENecyFuGI/vZZDm4dnWK+S69fx1fKtmDoNE867kely4lK3VMyZ4WyyAjNA+Zr67HZSxQ9++3lUcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OjRjDxx9; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de45dba15feso2670098276.3
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 14:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713563305; x=1714168105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hlZrholMPQopO21vuzYYQrrDJR8lUrEFKktjzCESuvE=;
        b=OjRjDxx9PF3UqxGZ7isSKkuyyPcE6MbQpNxjvlUILxrmUue9MbH/pDy9N3M0D4baxp
         ABGnUZ4amhibPmsMm44HiBgoXPE/HdMvt7WDIKiw9DomNoVrzlA4F7ZFV6UP2VXJHm/J
         WKYaCyo9MWgC/PWorES6T1y+8MCaylHMMteEshUpXP/AyIEya9U2LtmHEyqx5CaUs18P
         s57BzUBBmOJM8sttS/fwHhEyR+z9tPb16zwxFD8DdodKhmr9c/qISWozh3ik0dIX39fG
         /CqvTaz/jAMi/AIhtH4S+fQprIH5+Z1oZJ2y7404j3cc2cEuKATWBuD1klpZHlK5bnSk
         XCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713563305; x=1714168105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlZrholMPQopO21vuzYYQrrDJR8lUrEFKktjzCESuvE=;
        b=KXK/rQc6+zFlqfH3pKu+K6F5cKURaiqGzTwtb2PHIoPPvjVk/bqyEsyLoZZCWboLqv
         saUKZxgdMjcc/jYWFa65sxymHfcTmYDaLBwnyKBu04Z1A5j4x6wDYMfQ3dgjG+pd95Oy
         go1xPv8G1NJokj1finD2qwZgLddR6lBCtg+btQ8xBRQENIwpPlHR1BGS2tGnOTh4l6ue
         8g8eCUywWjVS05WDYyHtyL8YVV+iXmMomcQzq1dlomapWJqwUPiKVMDBNbu7DQNc7kUE
         rz7bKFWo7dKXcJl7UEL9iu8GixEssEWcKiASaRu/S4SUv2rgqYDh+bU4MDVGrEMgAEpD
         8t4A==
X-Gm-Message-State: AOJu0YwLtF3lguAdLxF8uTxInKreoFb2ktk3Ru6XYXpHryUUDdof4y4k
	6FPr20FaFihjbl+0T1yHPY3A3x3q7OCFf8JdyAn13LKeZF5ARMrRftLx/fOqVb8BIxBbq4cjpEh
	T
X-Google-Smtp-Source: AGHT+IFEg7XekIZ/SpVLRz/F+D6FydDz7OfU8/1PyIGRgmDP7mRA9FJNY2ulCveb5aJ46aqT+7utIA==
X-Received: by 2002:a25:bfcf:0:b0:dcd:a28e:e5e0 with SMTP id q15-20020a25bfcf000000b00dcda28ee5e0mr3006592ybm.25.1713563304421;
        Fri, 19 Apr 2024 14:48:24 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.119])
        by smtp.gmail.com with ESMTPSA id n11-20020a0ce48b000000b0069b6c831e86sm1897511qvl.97.2024.04.19.14.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 14:48:24 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v2 0/3] net: A lightweight zero-copy notification
Date: Fri, 19 Apr 2024 21:48:16 +0000
Message-Id: <20240419214819.671536-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Original title is "net: socket sendmsg MSG_ZEROCOPY_UARG"
https://lore.kernel.org/all/
20240409205300.1346681-2-zijianzhang@bytedance.com/

Original notification mechanism needs poll + recvmmsg which is not
easy for applcations to accommodate. And, it also incurs unignorable
overhead including extra system calls and usage of optmem.

While making maximum reuse of the existing MSG_ZEROCOPY related code,
this patch set introduces a new zerocopy socket notification mechanism.
Users of sendmsg pass a control message as a placeholder for the incoming
notifications. Upon returning, kernel embeds notifications directly into
user arguments passed in. By doing so, we can significantly reduce the
complexity and overhead for managing notifications. In an ideal pattern,
the user will keep calling sendmsg with SO_ZC_NOTIFICATION msg_control,
and the notification will be delivered as soon as possible.

Changelog:
  v1 -> v2:
    - Reuse msg_errqueue in the new notification mechanism, suggested
      by Willem de Bruijn, users can actually use these two mechanisms
      in hybrid way if they want to do so.
    - Update case SO_ZC_NOTIFICATION in __sock_cmsg_send
      1. Regardless of 32-bit, 64-bit program, we will always handle
      u64 type user address.
      2. The size of data to copy_to_user is precisely calculated
      in case of kernel stack leak.
    - fix (kbuild-bot)
      1. Add SO_ZC_NOTIFICATION to arch-specific header files.
      2. header file types.h in include/uapi/linux/socket.h

* Performance

We extend the selftests/msg_zerocopy.c to accommodate the new mechanism,
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
 include/uapi/linux/socket.h                 |  16 +++
 net/core/sock.c                             |  70 +++++++++++++
 tools/testing/selftests/net/msg_zerocopy.c  | 105 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 9 files changed, 195 insertions(+), 7 deletions(-)

-- 
2.20.1


