Return-Path: <netdev+bounces-86269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A3489E4B1
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7436F1F22CCC
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AEE158844;
	Tue,  9 Apr 2024 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X1jiuxmX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F3370
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712696012; cv=none; b=nsXeY8HIILZKC0MVjEepFsDSWZ04DUJS9jriZXbI664eoJAzApcxdp44/H8qBCOytoAOm3uh4W5yGOpHD/YV/BhOeaI+zlrr5GgKbB1b65cCIRijuR3UI2C5FCTeG+xXjY1+CIPeeshF36Xf4PiYBBndA8gEXWwxL22VNESN+o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712696012; c=relaxed/simple;
	bh=VL1OmKXRS/86ZdIbWGoKSYYbSe/N0+x/bX3Wrz2QxfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aJ/6s4cQE3ZHfCHi8+/VceGFC1SpAmDIHxmy9/Kc5gUXtnhNkV4WrkEj88ckSjn40CJCVlEBo6y5sQqE8uuH+xo5KaUDGy9HPWX5veuUzSpnkdPAlDoic3pxrpy+5QT1cQSYbKUzoGE5yuj3HVHGzjpPCruXKSNbfC8GV15DFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X1jiuxmX; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78d70890182so81585785a.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 13:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712696008; x=1713300808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJNXfRJkpQZ0B1RTrSZqquRN7ck1z6S/P0CBX+NCW9o=;
        b=X1jiuxmXS6h/r4DAmUdMy4ePSli9ODmbgWAHNlov9sHbSS8QF3lYIs+DioyhYFHefp
         7oidMy9z51TPM53OAtraQiVJ0GO11O40M2fG0ysGaCF6GwDrO1gxIOD2DNy7O/mY2T6E
         z9038zJOpiaqV/pP8JZR3vatrBUzBy7MObruupsoo5ScVJRw20XrmRAAeSzkz1iOwRiQ
         HFRjgHiukbKixw+NraW+tBpccwBzfXf4H66ok8YHjIvbI+dgRJDmPUN5AxGAuYNDuYaJ
         1oq3gNz1o6bVBwZkcrJdCoTD4lLYEF/g8at+4SU7jiieFGRrUH+BBRHR4YBUw2o02ZXH
         nklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712696008; x=1713300808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJNXfRJkpQZ0B1RTrSZqquRN7ck1z6S/P0CBX+NCW9o=;
        b=LVIjQEeotqJKop/B2O0whhgBisqhdfl9ohGk5hyswK6wJ/bnMLkwDgYvLWNXP4chqR
         6v5Q2VG2zzVHey4PI/rKPbOzj/zXkR3GyaridvP5h9aCGCFE10luAfGbGvCS8gCvs5Ut
         AtcUnYVWcGR2dNWxl5U/xvZ3Rt8irvgOX/Q/UXHMGV4ykVZqcaB7e2tNM5g9mAxd6FNF
         1fIrvQntGqtpI1gwPiqYf56jWDBQoU103cKVf4njbmIIEY3WFoK3TuRcSy4NCYs315c9
         5OROjbmXWPf0qJ33kbccnvUGlJVpLvzQgQo64KnwWd7QxdLJP28t7qm9wATrdltmAILE
         yfAg==
X-Gm-Message-State: AOJu0Yxt4iJ7iXH+Ld8kiZWI5fHNU35lrznSBO2fukKl/orYKoLDF83Y
	X3wI7LuaMNnj9RU6mEdz5qwIO/CslKz0u3B7cev2XEBh2Jzt21we3yW6ZUFduFBixvsTbRxG+6j
	W
X-Google-Smtp-Source: AGHT+IErcOKldDVJXbLtLuqlIzGgw0Jz4+0+VCKz6tko4gAMknXxH+8L6ZL0JP7Qun733WKiqp8LBA==
X-Received: by 2002:a05:620a:3dd:b0:78d:777d:7d15 with SMTP id r29-20020a05620a03dd00b0078d777d7d15mr972845qkm.5.1712696008111;
        Tue, 09 Apr 2024 13:53:28 -0700 (PDT)
Received: from n191-036-066.byted.org ([147.160.184.150])
        by smtp.gmail.com with ESMTPSA id vy3-20020a05620a490300b0078d6bcfb580sm1151619qkn.10.2024.04.09.13.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 13:53:27 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next 0/3] net: socket sendmsg MSG_ZEROCOPY_UARG
Date: Tue,  9 Apr 2024 20:52:57 +0000
Message-Id: <20240409205300.1346681-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Original notification mechanism needs poll + recvmmsg which is not
easy for applcations to accommodate. And, it also incurs unignorable
overhead including extra system calls and usage of optmem.

While making maximum reuse of the existing MSG_ZEROCOPY related code,
this patch set introduces zerocopy socket send flag MSG_ZEROCOPY_UARG.
It provides a new notification method. Users of sendmsg pass a control
message as a placeholder for the incoming notifications. Upon returning,
kernel embeds notifications directly into user arguments passed in. By
doing so, we can significantly reduce the complexity and overhead for
managing notifications. In an ideal pattern, the user will keep calling
sendmsg with MSG_ZEROCOPY_UARG flag, and the notification will be
delivered as soon as possible.

MSG_ZEROCOPY_UARG does not need to queue skb into errqueue. Thus,
skbuffs allocated from optmem are not a must. In theory, a new struct
carrying the zcopy information should be defined along with its memory
management code. However, existing zcopy generic code assumes the
information is skbuff. Given the very limited performance gain or maybe
no gain of this method, and the need to change a lot of existing code,
we still use skbuffs allocated from optmem to carry zcopy information.

* Performance

I extend the selftests/msg_zerocopy.c to accommodate the new flag, test
result is as follows, the new flag performs 7% better in TCP and 4%
better in UDP.

cfg_notification_limit = 8
+---------------------+---------+---------+---------+---------+
| Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+---------------------+---------+---------+---------+---------+
| Copy                | 5328    | 5159    | 8581    | 8457    |
+---------------------+---------+---------+---------+---------+
| ZCopy               | 5877    | 5568    | 10314   | 10091   |
+---------------------+---------+---------+---------+---------+
| New ZCopy           | 6254    | 5901    | 10674   | 10293   |
+---------------------+---------+---------+---------+---------+
| ZCopy / Copy        | 110.30% | 107.93% | 120.20% | 119.32% |
+---------------------+---------+---------+---------+---------+
| New ZCopy / Copy    | 117.38% | 114.38% | 124.39% | 121.71% |
+---------------------+---------+---------+---------+---------+


Zijian Zhang (3):
  sock: add MSG_ZEROCOPY_UARG
  selftests: fix OOM problem in msg_zerocopy selftest
  selftests: add msg_zerocopy_uarg test

 include/linux/skbuff.h                      |   7 +-
 include/linux/socket.h                      |   1 +
 include/linux/tcp.h                         |   3 +
 include/linux/udp.h                         |   3 +
 include/net/sock.h                          |  17 +++
 include/net/udp.h                           |   1 +
 include/uapi/asm-generic/socket.h           |   2 +
 include/uapi/linux/socket.h                 |  17 +++
 net/core/skbuff.c                           | 137 ++++++++++++++++--
 net/core/sock.c                             |  50 +++++++
 net/ipv4/ip_output.c                        |   6 +-
 net/ipv4/tcp.c                              |   7 +-
 net/ipv4/udp.c                              |   9 ++
 net/ipv6/ip6_output.c                       |   5 +-
 net/ipv6/udp.c                              |   9 ++
 net/vmw_vsock/virtio_transport_common.c     |   2 +-
 tools/testing/selftests/net/msg_zerocopy.c  | 150 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 18 files changed, 397 insertions(+), 30 deletions(-)

-- 
2.20.1


